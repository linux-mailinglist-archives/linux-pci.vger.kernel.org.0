Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 362BAE39C0
	for <lists+linux-pci@lfdr.de>; Thu, 24 Oct 2019 19:22:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503447AbfJXRWN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Oct 2019 13:22:13 -0400
Received: from mta-02.yadro.com ([89.207.88.252]:49508 "EHLO mta-01.yadro.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2503539AbfJXRWN (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 24 Oct 2019 13:22:13 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-01.yadro.com (Postfix) with ESMTP id 34FB9437FA;
        Thu, 24 Oct 2019 17:22:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
        content-type:content-type:content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:date:subject
        :subject:from:from:received:received:received; s=mta-01; t=
        1571937730; x=1573752131; bh=wLWcatK3Zquun9QrjH55cMJhLIQuWciJ0cq
        tFux4U8c=; b=t0h6bpSCgAfWXWvMbWWGS7UDVN70Ciq4XQPLPI8UC1PvS9nINSG
        765WSU8R2in9u7r7g78phnPFRIvjrm3VJzKvBTtyChxAZyjDYXk/g255KezR6Iqh
        T3jjDCoBK+DFLLjkTo910ynzMpiouia7MzLeTbC3N5nVpR0MGiTggswo=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
        by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id naVwxlIoW55m; Thu, 24 Oct 2019 20:22:10 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com [172.17.10.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Postfix) with ESMTPS id 8953243130;
        Thu, 24 Oct 2019 20:22:06 +0300 (MSK)
Received: from NB-148.yadro.com (172.17.15.136) by T-EXCH-02.corp.yadro.com
 (172.17.10.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Thu, 24
 Oct 2019 20:22:06 +0300
From:   Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
To:     <linux-pci@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>
CC:     Bjorn Helgaas <helgaas@kernel.org>, <linux@yadro.com>,
        Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
Subject: [PATCH RFC 11/11] PCI: hotplug: movable bus numbers: compact the gaps in numbering
Date:   Thu, 24 Oct 2019 20:21:57 +0300
Message-ID: <20191024172157.878735-12-s.miroshnichenko@yadro.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191024172157.878735-1-s.miroshnichenko@yadro.com>
References: <20191024172157.878735-1-s.miroshnichenko@yadro.com>
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

If bus numbers are distributed sparsely and there are lot of devices in the
tree, hotplugging a bridge into the end of the tree may fail even if it has
less slots then the total number of unused bus numbers.

Thus, the feature of bus renaming relies on the continuity of bus numbers,
so if a bridge was unplugged, the gap in bus numbers must be compacted.

Let's densify the bus numbering at the beginning of a next PCI rescan.

Signed-off-by: Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
---
 drivers/pci/probe.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index fe9bf012ef33..0c91b9d453dd 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1319,6 +1319,30 @@ static bool pci_new_bus_needed(struct pci_bus *bus, const struct pci_dev *self)
 	return true;
 }
 
+static void pci_compact_bus_numbers(const int domain, const struct resource *valid_range)
+{
+	int busnr_p1 = valid_range->start;
+
+	while (busnr_p1 < valid_range->end) {
+		int busnr_p2 = busnr_p1 + 1;
+		struct pci_bus *bus_p2;
+		int delta;
+
+		while (busnr_p2 <= valid_range->end &&
+		       !(bus_p2 = pci_find_bus(domain, busnr_p2)))
+			++busnr_p2;
+
+		if (!bus_p2 || busnr_p2 > valid_range->end)
+			break;
+
+		delta = busnr_p1 - busnr_p2 + 1;
+		if (delta)
+			pci_move_buses(domain, busnr_p2, delta, valid_range);
+
+		++busnr_p1;
+	}
+}
+
 static unsigned int pci_scan_child_bus_extend(struct pci_bus *bus,
 					      unsigned int available_buses);
 /**
@@ -3691,6 +3715,9 @@ unsigned int pci_rescan_bus(struct pci_bus *bus)
 		pci_bus_update_immovable_range(root);
 		pci_bus_release_root_bridge_resources(root);
 
+		pci_compact_bus_numbers(pci_domain_nr(bus),
+					&root->busn_res);
+
 		max = pci_scan_child_bus(root);
 
 		pci_reassign_root_bus_resources(root);
-- 
2.23.0

