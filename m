Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5BBD814CD5E
	for <lists+linux-pci@lfdr.de>; Wed, 29 Jan 2020 16:30:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727119AbgA2PaI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 29 Jan 2020 10:30:08 -0500
Received: from mta-02.yadro.com ([89.207.88.252]:55828 "EHLO mta-01.yadro.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727112AbgA2PaI (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 29 Jan 2020 10:30:08 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-01.yadro.com (Postfix) with ESMTP id C0EA947640;
        Wed, 29 Jan 2020 15:30:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
        content-type:content-type:content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:date:subject
        :subject:from:from:received:received:received; s=mta-01; t=
        1580311805; x=1582126206; bh=diYC8NtFprW2FtiGXYlFHAb2ZsYOyKJFZPw
        rMvocfIA=; b=Ohj1xCAgK5XXZ0KMnpH6MMms9SfsaOLxuGdQam9QzNa5T9Gke+Z
        fNKD4750wqHYfjcduZ1YwiaNUxg7nu6BN/Bg0wOerdj/7tRO6uoneyEQkAmPEld0
        Mq1iZddeZBQVs8E48IVix2moFK6dmJGUgs74xmJPDVdW0DrT+V3ZBtGg=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
        by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id jGy6FVIm6Gxh; Wed, 29 Jan 2020 18:30:05 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com [172.17.10.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Postfix) with ESMTPS id 723D047607;
        Wed, 29 Jan 2020 18:29:55 +0300 (MSK)
Received: from NB-148.yadro.com (172.17.15.136) by T-EXCH-02.corp.yadro.com
 (172.17.10.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Wed, 29
 Jan 2020 18:29:54 +0300
From:   Sergei Miroshnichenko <s.miroshnichenko@yadro.com>
To:     <linux-pci@vger.kernel.org>
CC:     Bjorn Helgaas <helgaas@kernel.org>, Stefan Roese <sr@denx.de>,
        <linux@yadro.com>,
        Sergei Miroshnichenko <s.miroshnichenko@yadro.com>
Subject: [PATCH v7 24/26] PCI: hotplug: Don't reserve bus space when enabled movable BARs
Date:   Wed, 29 Jan 2020 18:29:35 +0300
Message-ID: <20200129152937.311162-25-s.miroshnichenko@yadro.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200129152937.311162-1-s.miroshnichenko@yadro.com>
References: <20200129152937.311162-1-s.miroshnichenko@yadro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.17.15.136]
X-ClientProxiedBy: T-EXCH-01.corp.yadro.com (172.17.10.101) To
 T-EXCH-02.corp.yadro.com (172.17.10.102)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

A hotplugged bridge with many hotplug-capable ports may request reserving
more IO space than the machine has. This could be overridden with the
"hpiosize=" kernel argument though.

But when BARs are movable, no need to reserve space anymore: new BARs are
allocated not from reserved gaps, but via rearranging the existing BARs.
Requesting a precise amount of space for bridge windows increases the
chances of adding the new bridge successfully.

Signed-off-by: Sergei Miroshnichenko <s.miroshnichenko@yadro.com>
---
 drivers/pci/setup-bus.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index dd94b4ed7358..3ec01a74b7b6 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -1316,7 +1316,7 @@ void __pci_bus_size_bridges(struct pci_bus *bus, struct list_head *realloc_head)
 
 	case PCI_HEADER_TYPE_BRIDGE:
 		pci_bridge_check_ranges(bus);
-		if (bus->self->is_hotplug_bridge) {
+		if (bus->self->is_hotplug_bridge && !pci_can_move_bars) {
 			additional_io_size  = pci_hotplug_io_size;
 			additional_mmio_size = pci_hotplug_mmio_size;
 			additional_mmio_pref_size = pci_hotplug_mmio_pref_size;
-- 
2.24.1

