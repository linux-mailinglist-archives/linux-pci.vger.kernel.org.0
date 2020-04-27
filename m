Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A0661BAC81
	for <lists+linux-pci@lfdr.de>; Mon, 27 Apr 2020 20:24:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726266AbgD0SY3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 27 Apr 2020 14:24:29 -0400
Received: from mta-02.yadro.com ([89.207.88.252]:53212 "EHLO mta-01.yadro.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726493AbgD0SY2 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 27 Apr 2020 14:24:28 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-01.yadro.com (Postfix) with ESMTP id 0526E4C86D;
        Mon, 27 Apr 2020 18:24:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
        content-type:content-type:content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:date:subject
        :subject:from:from:received:received:received; s=mta-01; t=
        1588011864; x=1589826265; bh=5IHf3xl9gAL92pKdSkCWQbDijv7JzrB8B9X
        +bgoyIjc=; b=ELBQvR/uLxt9mqD+3JVde9JXLitW0JlOuCf7s7ovVU+9LPyieHT
        OuHRg0xSnhNHQ/9LhxIFp7a6sphZUwwdkxmqCxLb5AZKOv6OFCdYwChsexUNmL4h
        9j8Z5ngKKZ65KAkD/2favvUUK7+scm7/913p0i43ZAqo41HdJesJ4nE0=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
        by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 5hJ24E6CGdJu; Mon, 27 Apr 2020 21:24:24 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com [172.17.10.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Postfix) with ESMTPS id 52BC64C84E;
        Mon, 27 Apr 2020 21:24:13 +0300 (MSK)
Received: from NB-148.yadro.com (172.17.15.136) by T-EXCH-02.corp.yadro.com
 (172.17.10.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Mon, 27
 Apr 2020 21:24:14 +0300
From:   Sergei Miroshnichenko <s.miroshnichenko@yadro.com>
To:     <linux-pci@vger.kernel.org>
CC:     Bjorn Helgaas <helgaas@kernel.org>, Lukas Wunner <lukas@wunner.de>,
        Stefan Roese <sr@denx.de>, Andy Lavr <andy.lavr@gmail.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        David Laight <David.Laight@ACULAB.COM>,
        Rajat Jain <rajatja@google.com>, <linux@yadro.com>,
        Sergei Miroshnichenko <s.miroshnichenko@yadro.com>
Subject: [PATCH v8 21/24] PCI: hotplug: Don't reserve bus space when enabled movable BARs
Date:   Mon, 27 Apr 2020 21:23:55 +0300
Message-ID: <20200427182358.2067702-22-s.miroshnichenko@yadro.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200427182358.2067702-1-s.miroshnichenko@yadro.com>
References: <20200427182358.2067702-1-s.miroshnichenko@yadro.com>
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

A hot-added bridge with many hotplug-capable ports may request reserving
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
index 3081f2d2a48a..e37976551a05 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -1302,7 +1302,7 @@ void __pci_bus_size_bridges(struct pci_bus *bus, struct list_head *realloc_head)
 
 	case PCI_HEADER_TYPE_BRIDGE:
 		pci_bridge_check_ranges(bus);
-		if (bus->self->is_hotplug_bridge) {
+		if (bus->self->is_hotplug_bridge && !pci_can_move_bars) {
 			additional_io_size  = pci_hotplug_io_size;
 			additional_mmio_size = pci_hotplug_mmio_size;
 			additional_mmio_pref_size = pci_hotplug_mmio_pref_size;
-- 
2.24.1

