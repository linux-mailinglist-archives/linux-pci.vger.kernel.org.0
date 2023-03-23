Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05FE96C5D65
	for <lists+linux-pci@lfdr.de>; Thu, 23 Mar 2023 04:45:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230154AbjCWDpc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 22 Mar 2023 23:45:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230025AbjCWDp1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 22 Mar 2023 23:45:27 -0400
Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D7D82BF15;
        Wed, 22 Mar 2023 20:45:23 -0700 (PDT)
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxct.zte.com.cn (FangMail) with ESMTPS id 4Phrp91qMyz501SW;
        Thu, 23 Mar 2023 11:45:21 +0800 (CST)
Received: from xaxapp01.zte.com.cn ([10.88.99.176])
        by mse-fl2.zte.com.cn with SMTP id 32N3jAUI058150;
        Thu, 23 Mar 2023 11:45:11 +0800 (+08)
        (envelope-from ye.xingchen@zte.com.cn)
Received: from mapi (xaxapp02[null])
        by mapi (Zmail) with MAPI id mid31;
        Thu, 23 Mar 2023 11:45:12 +0800 (CST)
Date:   Thu, 23 Mar 2023 11:45:12 +0800 (CST)
X-Zmail-TransId: 2afa641bcb48fffffffff41-66350
X-Mailer: Zmail v1.0
Message-ID: <202303231145121987818@zte.com.cn>
Mime-Version: 1.0
From:   <ye.xingchen@zte.com.cn>
To:     <sergio.paracuellos@gmail.com>
Cc:     <lpieralisi@kernel.org>, <kw@linux.com>, <robh@kernel.org>,
        <bhelgaas@google.com>, <matthias.bgg@gmail.com>,
        <angelogioacchino.delregno@collabora.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Subject: =?UTF-8?B?W1BBVENIXSBQQ0k6IG10NzYyMTogVXNlIGRldl9lcnJfcHJvYmUoKQ==?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl2.zte.com.cn 32N3jAUI058150
X-Fangmail-Gw-Spam-Type: 0
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 641BCB51.001/4Phrp91qMyz501SW
X-Spam-Status: No, score=0.0 required=5.0 tests=SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Ye Xingchen <ye.xingchen@zte.com.cn>

Replace the open-code with dev_err_probe() to simplify the code.

Signed-off-by: Ye Xingchen <ye.xingchen@zte.com.cn>
---
 drivers/pci/controller/pcie-mt7621.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/pcie-mt7621.c b/drivers/pci/controller/pcie-mt7621.c
index 63a5f4463a9f..964de0e8c6a0 100644
--- a/drivers/pci/controller/pcie-mt7621.c
+++ b/drivers/pci/controller/pcie-mt7621.c
@@ -220,10 +220,9 @@ static int mt7621_pcie_parse_port(struct mt7621_pcie *pcie,
 	}

 	port->pcie_rst = of_reset_control_get_exclusive(node, NULL);
-	if (PTR_ERR(port->pcie_rst) == -EPROBE_DEFER) {
-		dev_err(dev, "failed to get pcie%d reset control\n", slot);
-		return PTR_ERR(port->pcie_rst);
-	}
+
+	return dev_err_probe(dev, PTR_ERR(port->pcie_rst),
+			     "failed to get pcie%d reset control\n", slot);

 	snprintf(name, sizeof(name), "pcie-phy%d", slot);
 	port->phy = devm_of_phy_get(dev, node, name);
-- 
2.25.1
