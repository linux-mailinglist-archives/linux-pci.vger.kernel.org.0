Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8216C6E5AD8
	for <lists+linux-pci@lfdr.de>; Tue, 18 Apr 2023 09:48:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231289AbjDRHsf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 18 Apr 2023 03:48:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231296AbjDRHsT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 18 Apr 2023 03:48:19 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AF7410D0;
        Tue, 18 Apr 2023 00:48:02 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id dm2so70933224ejc.8;
        Tue, 18 Apr 2023 00:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681804081; x=1684396081;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gXA2hp0m2ISM3D3+h81RjtKD9xln/dgRYjKYAUjtQ4k=;
        b=HeGTxBf5hkXgKM82MTFMBD1JwNMaS+brmpfjsfyAc/stReV+zQGDm3L7DAFgXeeV/a
         JtGc6oQfx9gdPrOTAtI99+AoIKG+35GFkwZfzG6YDvdSU/mynPuBMOHZvkK53auXYliz
         ec+/swgcYT4LWcH5qRDffWJRufhEc6tNZs8U24Aj9/vaL05AIuG+Yt8zKiszNDfHzPUi
         MKo8UkMoryGjbln11/5vjBmCsZx9MnGDVWD+SnXY0WIC+Qfw9PgT3zi+J8FUpN//gIrF
         uW4wlOC8bCTrcluf6WSaT1qvljqzMAiDARCbgrSDPq6eL1CYedPFG/W5lfdzCO34MYCS
         yfJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681804081; x=1684396081;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gXA2hp0m2ISM3D3+h81RjtKD9xln/dgRYjKYAUjtQ4k=;
        b=Z8+Y0gaXX5gERP/0qEQXG+mVnPSEdBsQsjdDoRINsK5t5pqazp3X7wArzGLxXExe3A
         E5bcvQdBXkoHmVt2lFt48Wv00iF6NWM/Oc023tEcIBnm8sG1MoTXdyptMjc0xqfDQ5jg
         CdI43RMRLAj5Qt81x9DrknfvhJTpMPCqNik2X6TN8hB78IsNqmWilGU3Vqp6xlC2lgho
         OA1lsgI/qxIbNOzNLfUyIS/ZbQ9KaqB8X3nu3eoKpxb208xcYkmhWq2SnLTkVt3olkSe
         Sgo6WK/T3pGXPuTEwrvFrPXfIBNMD+7p8hC+D1zMZa8t1rSWf5GW8tmA6451IyZgISDm
         Ql+g==
X-Gm-Message-State: AAQBX9cg9meeL3CgCIJegWWm1OS55LzlXH0aUc/fAfFK/iBeeki0tshW
        UsrX3rvnjf2OjKl68Rb7Px0=
X-Google-Smtp-Source: AKy350b3uvf3QU6Pks+6V6f07eNS+rVQtEMVNNrUYXPONdsugq3XZKDH6diqvWA5xXyFg9/1QyqaPQ==
X-Received: by 2002:a17:907:7f04:b0:94b:7743:3971 with SMTP id qf4-20020a1709077f0400b0094b77433971mr11033815ejc.63.1681804081136;
        Tue, 18 Apr 2023 00:48:01 -0700 (PDT)
Received: from A13PC04R.einet.ad.eivd.ch ([193.134.219.72])
        by smtp.googlemail.com with ESMTPSA id gs8-20020a1709072d0800b0094f694e4ecbsm3048545ejc.146.2023.04.18.00.47.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 00:48:00 -0700 (PDT)
From:   Rick Wertenbroek <rick.wertenbroek@gmail.com>
To:     alberto.dassatti@heig-vd.ch
Cc:     xxm@rock-chips.com, dlemoal@kernel.org,
        Rick Wertenbroek <rick.wertenbroek@gmail.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Caleb Connolly <kc@postmarketos.org>,
        Corentin Labbe <clabbe@baylibre.com>,
        Brian Norris <briannorris@chromium.org>,
        Johan Jonker <jbx6244@gmail.com>,
        Judy Hsiao <judyhsiao@chromium.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Hugh Cole-Baker <sigmaris@gmail.com>,
        Arnaud Ferraris <arnaud.ferraris@collabora.com>,
        linux-pci@vger.kernel.org, linux-rockchip@lists.infradead.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 06/11] dt-bindings: PCI: Update the RK3399 example to a valid one
Date:   Tue, 18 Apr 2023 09:46:53 +0200
Message-Id: <20230418074700.1083505-7-rick.wertenbroek@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230418074700.1083505-1-rick.wertenbroek@gmail.com>
References: <20230418074700.1083505-1-rick.wertenbroek@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Update the example in the documentation to a valid example.
Address for mem-base was invalid, it pointed to address
0x8000'0000 which is the upper region of the DDR which
is not necessarily populated depending on the board.
This address should point to the base of the memory
window region of the controller which is 0xfa00'0000.
Add missing pinctrl.

Signed-off-by: Rick Wertenbroek <rick.wertenbroek@gmail.com>
---
 .../devicetree/bindings/pci/rockchip,rk3399-pcie-ep.yaml      | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pci/rockchip,rk3399-pcie-ep.yaml b/Documentation/devicetree/bindings/pci/rockchip,rk3399-pcie-ep.yaml
index 88386a6d7011..6b62f6f58efe 100644
--- a/Documentation/devicetree/bindings/pci/rockchip,rk3399-pcie-ep.yaml
+++ b/Documentation/devicetree/bindings/pci/rockchip,rk3399-pcie-ep.yaml
@@ -47,7 +47,7 @@ examples:
 
         pcie-ep@f8000000 {
             compatible = "rockchip,rk3399-pcie-ep";
-            reg = <0x0 0xfd000000 0x0 0x1000000>, <0x0 0x80000000 0x0 0x20000>;
+            reg = <0x0 0xfd000000 0x0 0x1000000>, <0x0 0xfa000000 0x0 0x2000000>;
             reg-names = "apb-base", "mem-base";
             clocks = <&cru ACLK_PCIE>, <&cru ACLK_PERF_PCIE>,
               <&cru PCLK_PCIE>, <&cru SCLK_PCIE_PM>;
@@ -63,6 +63,8 @@ examples:
             phys = <&pcie_phy 0>, <&pcie_phy 1>, <&pcie_phy 2>, <&pcie_phy 3>;
             phy-names = "pcie-phy-0", "pcie-phy-1", "pcie-phy-2", "pcie-phy-3";
             rockchip,max-outbound-regions = <16>;
+            pinctrl-names = "default";
+            pinctrl-0 = <&pcie_clkreqnb_cpm>;
         };
     };
 ...
-- 
2.25.1

