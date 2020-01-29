Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E5A2914CD50
	for <lists+linux-pci@lfdr.de>; Wed, 29 Jan 2020 16:29:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726842AbgA2P3y (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 29 Jan 2020 10:29:54 -0500
Received: from mta-02.yadro.com ([89.207.88.252]:55756 "EHLO mta-01.yadro.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726913AbgA2P3y (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 29 Jan 2020 10:29:54 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-01.yadro.com (Postfix) with ESMTP id 1F45F47610;
        Wed, 29 Jan 2020 15:29:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
        content-type:content-type:content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:date:subject
        :subject:from:from:received:received:received; s=mta-01; t=
        1580311792; x=1582126193; bh=FCclUi7mbseaPmr15QdjS7XIaf3Bj0PVVyq
        fUm8eskI=; b=iSy8qORmXuVcs8qaQx2G7RaTDb3L29si/zpnTwdnmSohGwnasjo
        yoAkzjPi+Xc3B5+SiKau8YrhhAyTsPmQ2YE9I4hwztfm501ebL05IHYUi1C1kJJC
        6OeWTGl9rD4hc/CMQwS18wu5BYvZ7nbA+BZ98RUBTw6HMEU6ovjIGDK4=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
        by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id jMJXsBPtGwUX; Wed, 29 Jan 2020 18:29:52 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com [172.17.10.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Postfix) with ESMTPS id 1D47147604;
        Wed, 29 Jan 2020 18:29:51 +0300 (MSK)
Received: from NB-148.yadro.com (172.17.15.136) by T-EXCH-02.corp.yadro.com
 (172.17.10.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Wed, 29
 Jan 2020 18:29:50 +0300
From:   Sergei Miroshnichenko <s.miroshnichenko@yadro.com>
To:     <linux-pci@vger.kernel.org>
CC:     Bjorn Helgaas <helgaas@kernel.org>, Stefan Roese <sr@denx.de>,
        <linux@yadro.com>,
        Sergei Miroshnichenko <s.miroshnichenko@yadro.com>
Subject: [PATCH v7 02/26] PCI: Enable bridge's I/O and MEM access for hotplugged devices
Date:   Wed, 29 Jan 2020 18:29:13 +0300
Message-ID: <20200129152937.311162-3-s.miroshnichenko@yadro.com>
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

The PCI_COMMAND_IO and PCI_COMMAND_MEMORY bits of the bridge must be
updated not only when enabling the bridge for the first time, but also if a
hotplugged device requests these types of resources.

For example, if a bridge had all its slots empty, the IO and MEM bits will
not be set, and a hot hotplugged device will fail.

Originally these bits were set by the pci_enable_device_flags() only, which
exits early if the bridge is already pci_is_enabled(). So let's check them
again when requested.

Signed-off-by: Sergei Miroshnichenko <s.miroshnichenko@yadro.com>
---
 drivers/pci/pci.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 0366289c75e9..cb0042f28e6a 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1679,6 +1679,14 @@ static void pci_enable_bridge(struct pci_dev *dev)
 		pci_enable_bridge(bridge);
 
 	if (pci_is_enabled(dev)) {
+		int i, bars = 0;
+
+		for (i = PCI_BRIDGE_RESOURCES; i < DEVICE_COUNT_RESOURCE; i++) {
+			if (dev->resource[i].flags & (IORESOURCE_MEM | IORESOURCE_IO))
+				bars |= (1 << i);
+		}
+		do_pci_enable_device(dev, bars);
+
 		if (!dev->is_busmaster)
 			pci_set_master(dev);
 		mutex_unlock(&dev->enable_mutex);
-- 
2.24.1

