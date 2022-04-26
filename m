Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DC2150FED6
	for <lists+linux-pci@lfdr.de>; Tue, 26 Apr 2022 15:23:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350897AbiDZNZO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 26 Apr 2022 09:25:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350862AbiDZNZK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 26 Apr 2022 09:25:10 -0400
Received: from mxout4.routing.net (mxout4.routing.net [IPv6:2a03:2900:1:a::9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ADEA33A26;
        Tue, 26 Apr 2022 06:21:59 -0700 (PDT)
Received: from mxbox1.masterlogin.de (unknown [192.168.10.88])
        by mxout4.routing.net (Postfix) with ESMTP id CFDF4101299;
        Tue, 26 Apr 2022 13:21:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
        s=20200217; t=1650979317;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VGWdXOAbKYFsWdQ08Ig6m7ORNvxHvLu8Lks5JJidff8=;
        b=xVPVZVvS74xKRcCQuThE/vqu2FFK5C2u8JUAvtrHNfv79ipesUm4A62gY5k7RfwhcLjC7a
        tapzdOkHEpT4hNE8OUGpGOTaTg52fx4GTSCaYKDHw298zTf0KCKuMTGoPeCYBanajnPW7U
        70XtulkRSbzFo6d7nt6dLD1fdWyXD1w=
Received: from localhost.localdomain (fttx-pool-80.245.77.37.bambit.de [80.245.77.37])
        by mxbox1.masterlogin.de (Postfix) with ESMTPSA id BD203401C9;
        Tue, 26 Apr 2022 13:21:56 +0000 (UTC)
From:   Frank Wunderlich <linux@fw-web.de>
To:     linux-rockchip@lists.infradead.org
Cc:     Frank Wunderlich <frank-w@public-files.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Johan Jonker <jbx6244@gmail.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org
Subject: [RFC/RFT v2 03/11] dt-bindings: phy: rockchip: add PCIe v3 constants
Date:   Tue, 26 Apr 2022 15:21:31 +0200
Message-Id: <20220426132139.26761-4-linux@fw-web.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220426132139.26761-1-linux@fw-web.de>
References: <20220426132139.26761-1-linux@fw-web.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mail-ID: 74afaeeb-5fdb-4ebf-b1d4-688c81efa547
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Frank Wunderlich <frank-w@public-files.de>

Add constants that can be used in devicetree and driver for
PCIe v3 phy.

Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
---
v2:
- new patch because splitting out this file
- rename file from snps to rockchip
---
 include/dt-bindings/phy/phy-rockchip-pcie3.h | 21 ++++++++++++++++++++
 1 file changed, 21 insertions(+)
 create mode 100644 include/dt-bindings/phy/phy-rockchip-pcie3.h

diff --git a/include/dt-bindings/phy/phy-rockchip-pcie3.h b/include/dt-bindings/phy/phy-rockchip-pcie3.h
new file mode 100644
index 000000000000..93e57edd337d
--- /dev/null
+++ b/include/dt-bindings/phy/phy-rockchip-pcie3.h
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: (GPL-2.0+ OR MIT) */
+/*
+ * Copyright (c) 2021 Rockchip Electronics Co., Ltd.
+ */
+
+#ifndef _DT_BINDINGS_PHY_ROCKCHIP_PCIE3
+#define _DT_BINDINGS_PHY_ROCKCHIP_PCIE3
+
+/*
+ * pcie30_phy_mode[2:0]
+ * bit2: aggregation
+ * bit1: bifurcation for port 1
+ * bit0: bifurcation for port 0
+ */
+#define PHY_MODE_PCIE_AGGREGATION 4	/* PCIe3x4 */
+#define PHY_MODE_PCIE_NANBNB	0	/* P1:PCIe3x2  +  P0:PCIe3x2 */
+#define PHY_MODE_PCIE_NANBBI	1	/* P1:PCIe3x2  +  P0:PCIe3x1*2 */
+#define PHY_MODE_PCIE_NABINB	2	/* P1:PCIe3x1*2 + P0:PCIe3x2 */
+#define PHY_MODE_PCIE_NABIBI	3	/* P1:PCIe3x1*2 + P0:PCIe3x1*2 */
+
+#endif /* _DT_BINDINGS_PHY_ROCKCHIP_PCIE3 */
-- 
2.25.1

