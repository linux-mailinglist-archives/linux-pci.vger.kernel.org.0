Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FC1F65FD0B
	for <lists+linux-pci@lfdr.de>; Fri,  6 Jan 2023 09:47:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbjAFIrq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 6 Jan 2023 03:47:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232149AbjAFIrl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 6 Jan 2023 03:47:41 -0500
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6036663D2A;
        Fri,  6 Jan 2023 00:47:40 -0800 (PST)
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxhk.zte.com.cn (FangMail) with ESMTPS id 4NpH614dQtz8R039;
        Fri,  6 Jan 2023 16:47:37 +0800 (CST)
Received: from xaxapp03.zte.com.cn ([10.88.97.17])
        by mse-fl2.zte.com.cn with SMTP id 3068lVvb047944;
        Fri, 6 Jan 2023 16:47:31 +0800 (+08)
        (envelope-from guo.ziliang@zte.com.cn)
Received: from mapi (xaxapp03[null])
        by mapi (Zmail) with MAPI id mid32;
        Fri, 6 Jan 2023 16:47:33 +0800 (CST)
Date:   Fri, 6 Jan 2023 16:47:33 +0800 (CST)
X-Zmail-TransId: 2afb63b7e025ffffffffe75b211b
X-Mailer: Zmail v1.0
Message-ID: <202301061647338189934@zte.com.cn>
Mime-Version: 1.0
From:   <guo.ziliang@zte.com.cn>
To:     <bhelgaas@google.com>
Cc:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <chen.lin5@zte.com.cn>, <guo.ziliang@zte.com.cn>
Subject: =?UTF-8?B?W1BBVENIXSBQQ0k6IG9mOiBXYXJuIGlmIGJyaWRnZSBiYXNlL2xpbWl0IHJlZ2lvbiBvdmVybGFwcyB3aXRoIHN5c3RlbSByYW0gcmVnaW9u?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl2.zte.com.cn 3068lVvb047944
X-Fangmail-Gw-Spam-Type: 0
X-FangMail-Miltered: at cgslv5.04-192.168.250.137.novalocal with ID 63B7E029.000 by FangMail milter!
X-FangMail-Envelope: 1672994857/4NpH614dQtz8R039/63B7E029.000/10.5.228.133/[10.5.228.133]/mse-fl2.zte.com.cn/<guo.ziliang@zte.com.cn>
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 63B7E029.000/4NpH614dQtz8R039
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Chen Lin <chen.lin5@zte.com.cn>
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
warn it also in host bridge pci address detection phase.

Signed-off-by: Chen Lin <chen.lin5@zte.com.cn>
---
 drivers/pci/of.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/pci/of.c b/drivers/pci/of.c
index 196834ed44fe..82e09af6c638 100644
--- a/drivers/pci/of.c
+++ b/drivers/pci/of.c
@@ -314,6 +314,8 @@ static int devm_of_pci_get_host_bridge_resources(struct device *dev,

 	dev_dbg(dev, "Parsing ranges property...\n");
 	for_each_of_pci_range(&parser, &range) {
+		int is_ram;
+
 		/* Read next ranges element */
 		if ((range.flags & IORESOURCE_TYPE_BITS) == IORESOURCE_IO)
 			range_type = "IO";
@@ -332,6 +334,18 @@ static int devm_of_pci_get_host_bridge_resources(struct device *dev,
 		if (range.cpu_addr == OF_BAD_ADDR || range.size == 0)
 			continue;

+		/*
+		 * bridge base/limit(memory behind) region may filter out inbound
+		 * transactions which will result in inbound(eg:dma) fail of ep.
+		 * AER may report it if enabled, we warn it also.
+		 */
+		is_ram = region_intersects(range.pci_addr, range.size,
+					IORESOURCE_SYSTEM_RAM, IORES_DESC_NONE);
+		if (is_ram == REGION_INTERSECTS) {
+			dev_warn(dev, "%#012llx..%#012llx bridge base/limit region overlaps with system ram, may result in inbound fail\n",
+				 range.pci_addr, range.pci_addr + range.size - 1);
+		}
+
 		err = of_pci_range_to_resource(&range, dev_node, &tmp_res);
 		if (err)
 			continue;
-- 
2.15.2
