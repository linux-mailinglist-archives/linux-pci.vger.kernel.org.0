Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C824450FEF3
	for <lists+linux-pci@lfdr.de>; Tue, 26 Apr 2022 15:23:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350877AbiDZNZM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 26 Apr 2022 09:25:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350856AbiDZNZI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 26 Apr 2022 09:25:08 -0400
Received: from mxout3.routing.net (mxout3.routing.net [IPv6:2a03:2900:1:a::8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEAF0340C3;
        Tue, 26 Apr 2022 06:21:58 -0700 (PDT)
Received: from mxbox1.masterlogin.de (unknown [192.168.10.88])
        by mxout3.routing.net (Postfix) with ESMTP id CDA2F600EB;
        Tue, 26 Apr 2022 13:21:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
        s=20200217; t=1650979317;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0XQG5DLhB+jNApDK1YIKuO1LF1Y97r9eKhU3JEKU6y4=;
        b=WdPC0Bwg8MQ/iu87CcwMkOs3SAjgXEwdAmyyXziI6sTAlCrqaBCfz+MGvkhGjEJmDMLb+D
        1Uo/0yVjC5gdUQlyP1TBfXwP6FvcSYyg+NLxN8CSmdtTRXcqe73U5mQX3e9qQjZIUfjfSc
        IJq7GMLBCpOl9perOomcZc8U5g2OB1U=
Received: from localhost.localdomain (fttx-pool-80.245.77.37.bambit.de [80.245.77.37])
        by mxbox1.masterlogin.de (Postfix) with ESMTPSA id CF9C2405FE;
        Tue, 26 Apr 2022 13:21:55 +0000 (UTC)
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
Subject: [RFC/RFT v2 02/11] dt-bindings: soc: grf: add pcie30-{phy,pipe}-grf
Date:   Tue, 26 Apr 2022 15:21:30 +0200
Message-Id: <20220426132139.26761-3-linux@fw-web.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220426132139.26761-1-linux@fw-web.de>
References: <20220426132139.26761-1-linux@fw-web.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mail-ID: 83805134-6690-4eb9-bcc4-f816f2fbb981
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Frank Wunderlich <frank-w@public-files.de>

Add compatibles for PCIe v3 General Register Files.

Signed-off-by: Frank Wunderlich <frank-w@public-files.de>

---
changes in v2:
- add soc-part to pcie3-phy-grf
---
 Documentation/devicetree/bindings/soc/rockchip/grf.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/soc/rockchip/grf.yaml b/Documentation/devicetree/bindings/soc/rockchip/grf.yaml
index 3be3cfd52f7b..4564ff0bfd7a 100644
--- a/Documentation/devicetree/bindings/soc/rockchip/grf.yaml
+++ b/Documentation/devicetree/bindings/soc/rockchip/grf.yaml
@@ -14,6 +14,9 @@ properties:
     oneOf:
       - items:
           - enum:
+              - rockchip,rk3568-pcie3-phy-grf
+              - rockchip,rk3588-pcie3-phy-grf
+              - rockchip,rk3588-pcie3-pipe-grf
               - rockchip,rk3288-sgrf
               - rockchip,rk3566-pipe-grf
               - rockchip,rk3568-usb2phy-grf
-- 
2.25.1

