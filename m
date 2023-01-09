Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3C1D662019
	for <lists+linux-pci@lfdr.de>; Mon,  9 Jan 2023 09:35:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230404AbjAIIfl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 9 Jan 2023 03:35:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233151AbjAIIfk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 9 Jan 2023 03:35:40 -0500
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A53766575;
        Mon,  9 Jan 2023 00:35:38 -0800 (PST)
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxhk.zte.com.cn (FangMail) with ESMTPS id 4Nr6hm3whKz4xVnD;
        Mon,  9 Jan 2023 16:35:36 +0800 (CST)
Received: from xaxapp03.zte.com.cn ([10.88.97.17])
        by mse-fl2.zte.com.cn with SMTP id 3098ZNiW068141;
        Mon, 9 Jan 2023 16:35:23 +0800 (+08)
        (envelope-from guo.ziliang@zte.com.cn)
Received: from mapi (xaxapp03[null])
        by mapi (Zmail) with MAPI id mid32;
        Mon, 9 Jan 2023 16:35:25 +0800 (CST)
Date:   Mon, 9 Jan 2023 16:35:25 +0800 (CST)
X-Zmail-TransId: 2afb63bbd1cd5bc25402
X-Mailer: Zmail v1.0
Message-ID: <202301091635256312056@zte.com.cn>
In-Reply-To: <20230106121845.GA1216249@bhelgaas>
References: 20230106121845.GA1216249@bhelgaas
Mime-Version: 1.0
From:   <guo.ziliang@zte.com.cn>
To:     <helgaas@kernel.org>
Cc:     <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <chen.lin5@zte.com.cn>
Subject: =?UTF-8?B?562U5aSNOiBbUEFUQ0hdIFBDSTogb2Y6IFdhcm4gaWYgYnJpZGdlIGJhc2UvbGltaXQgcmVnaW9uIG92ZXJsYXBzIHdpdGggc3lzdGVtIHJhbSByZWdpb24=?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl2.zte.com.cn 3098ZNiW068141
X-Fangmail-Gw-Spam-Type: 0
X-FangMail-Miltered: at cgslv5.04-192.168.250.138.novalocal with ID 63BBD1D8.000 by FangMail milter!
X-FangMail-Envelope: 1673253336/4Nr6hm3whKz4xVnD/63BBD1D8.000/10.5.228.133/[10.5.228.133]/mse-fl2.zte.com.cn/<guo.ziliang@zte.com.cn>
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 63BBD1D8.000/4Nr6hm3whKz4xVnD
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

bridge base/limit(memory behind in lspci info, outbound pcie address/size)
region is used to route outbound mem read/write transaction to ep. This
base/limit region also may filter out inbound transactions which will
result in inbound(eg: dma) transaction fail.

For example, if bridge base/limit is [0x20000000, 0x203fffff], system ram
is [0x20000000, 0x27ffffff]. The inbound mapping is usually 1:1 equal
mapping. When allocated system ram for inbound tansaction is 0x20004000
(any in bridge base/limit), this inbound transactions will be filter out.

AER may report 'UnsupReq' on inbound mem read/write transactions if address
is in this base/limit region, but not all pcie AER enabled or work well. We
warn it also in bridge pci address setting phase.

Signed-off-by: Chen Lin <chen.lin5@zte.com.cn>
---
 drivers/pci/setup-bus.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index b4096598dbcb..1a9f527d2317 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -608,6 +608,24 @@ static void pci_setup_bridge_io(struct pci_dev *bridge)
 	pci_write_config_dword(bridge, PCI_IO_BASE_UPPER16, io_upper16);
 }

+static void check_bridge_region_overlaps_systemram(struct pci_dev *bridge,
+							struct pci_bus_region *region)
+{
+	int is_ram;
+
+	/*
+	 * bridge base/limit(memory behind) region may filter out inbound
+	 * transactions which will result in inbound(eg: dma) fail of ep.
+	 * AER may report it if enabled, we warn it also.
+	 */
+	is_ram = region_intersects(region->start, region->end - region->start + 1,
+				IORESOURCE_SYSTEM_RAM, IORES_DESC_NONE);
+	if (is_ram == REGION_INTERSECTS) {
+		pci_warn(bridge, "%#012llx..%#012llx bridge base/limit region overlaps with system ram, may result in inbound fail\n",
+			region->start, region->end);
+	}
+}
+
 static void pci_setup_bridge_mmio(struct pci_dev *bridge)
 {
 	struct resource *res;
@@ -621,6 +639,7 @@ static void pci_setup_bridge_mmio(struct pci_dev *bridge)
 		l = (region.start >> 16) & 0xfff0;
 		l |= region.end & 0xfff00000;
 		pci_info(bridge, "  bridge window %pR\n", res);
+		check_bridge_region_overlaps_systemram(bridge, &region);
 	} else {
 		l = 0x0000fff0;
 	}
@@ -652,6 +671,7 @@ static void pci_setup_bridge_mmio_pref(struct pci_dev *bridge)
 			lu = upper_32_bits(region.end);
 		}
 		pci_info(bridge, "  bridge window %pR\n", res);
+		check_bridge_region_overlaps_systemram(bridge, &region);
 	} else {
 		l = 0x0000fff0;
 	}
-- 
2.15.2
