Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D1C56D5ACD
	for <lists+linux-pci@lfdr.de>; Tue,  4 Apr 2023 10:25:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234263AbjDDIZ0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 4 Apr 2023 04:25:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234193AbjDDIZQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 4 Apr 2023 04:25:16 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A87DF19BC;
        Tue,  4 Apr 2023 01:25:14 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id ek18so127306764edb.6;
        Tue, 04 Apr 2023 01:25:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680596714;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nz9Rt5llaKTGY8gvxSvQqyvro9YAn45RkiHqvQ+NW6Q=;
        b=cbd6vhqGnL/IKhxwKvQkqeLqbxgMQAj6qIxQKYNB+hULyN6c9r2m3BZiAEH0i3l0mS
         UIBzqoVgM2oMExcy8929mkZUYdxX0GvBAb+ufKauaXrxTAQ4Ofl/oQoNvlsXhP1QQqgE
         QeSBHHPHlJGzH/BK1EHBLTxnMKNv87m/N4weGn8Pqikky93Sxg7jyJBegSKh34di5kUV
         VVZpA5jB3kQ0lzZkU9KvVkUBA91haq7fQkFGzdEDE1L0/YjPDhr82XIuwjHkjJO90llh
         JwFr309c0r1X/OBFCg9Qu43Gs17XJW8r24z68ktMlZ0UaCVyyEK6qbGfMh2hq94/zziL
         asGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680596714;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nz9Rt5llaKTGY8gvxSvQqyvro9YAn45RkiHqvQ+NW6Q=;
        b=ChKvR3T+McQKCOA7dpZVZhxLylWHN2d9Q1kNT6d3XaiKgdrJ/RE6+2tcKkTb38omxT
         v11d/bvzpaEeMfTpyNvwaZ+mE2EZNvJ+WHBchEScVy4fJb6gjIqMtTAti5k1H2pZQVjw
         pVCd5cPsL4YOsHY0c2B4KNvbh2xW/mh6jPDJsvgvaCRttYqQYakNpXwWooFxSDYTRwhc
         HplUk0rkSm9W+dCK47TuOkojBkjJ6I4I8QmL6P63eyRKw+lWyuq26v49FnQxrJYJjh8R
         ZFhK6hG+obmP/4hy9l+De8zHUFevoz+IaQoB9atOojhNy++8xpOWDgwqlRTarkZdK78I
         w0+Q==
X-Gm-Message-State: AAQBX9cyqqubjRZ3eBce2UdOBQFUuPfjP1OBUztgAmjA4yqLVEEEpTR0
        WaTh1E6vXtyViUBtf0aU2wY=
X-Google-Smtp-Source: AKy350aXHXD8VID4zXf64e+YvsL7aQVBObI4XTPTF4eARYu187ArEiSIAleYEt+IuoWWbwj9nRBecQ==
X-Received: by 2002:a17:907:3e1a:b0:93e:fa12:aa1a with SMTP id hp26-20020a1709073e1a00b0093efa12aa1amr1864794ejc.1.1680596714183;
        Tue, 04 Apr 2023 01:25:14 -0700 (PDT)
Received: from A13PC04R.einet.ad.eivd.ch ([193.134.219.72])
        by smtp.googlemail.com with ESMTPSA id s5-20020a170906454500b008e54ac90de1sm5640652ejq.74.2023.04.04.01.25.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 01:25:13 -0700 (PDT)
From:   Rick Wertenbroek <rick.wertenbroek@gmail.com>
To:     alberto.dassatti@heig-vd.ch
Cc:     damien.lemoal@opensource.wdc.com, xxm@rock-chips.com,
        Rick Wertenbroek <rick.wertenbroek@gmail.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Johan Jonker <jbx6244@gmail.com>,
        Brian Norris <briannorris@chromium.org>,
        Caleb Connolly <kc@postmarketos.org>,
        Corentin Labbe <clabbe@baylibre.com>,
        Judy Hsiao <judyhsiao@chromium.org>,
        Lin Huang <hl@rock-chips.com>,
        Arnaud Ferraris <arnaud.ferraris@collabora.com>,
        Hugh Cole-Baker <sigmaris@gmail.com>,
        linux-pci@vger.kernel.org, linux-rockchip@lists.infradead.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 06/11] dt-bindings: PCI: Update the RK3399 example to a valid one
Date:   Tue,  4 Apr 2023 10:24:19 +0200
Message-Id: <20230404082426.3880812-7-rick.wertenbroek@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230404082426.3880812-1-rick.wertenbroek@gmail.com>
References: <20230404082426.3880812-1-rick.wertenbroek@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Update the example in the documentation a valid example.
The default max-outbound-regions is 32 but the example showed 16.
Address for mem-base was invalid. Added pinctrl.

Signed-off-by: Rick Wertenbroek <rick.wertenbroek@gmail.com>
---
 .../devicetree/bindings/pci/rockchip,rk3399-pcie-ep.yaml  | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/rockchip,rk3399-pcie-ep.yaml b/Documentation/devicetree/bindings/pci/rockchip,rk3399-pcie-ep.yaml
index 88386a6d7011..0c67e96096eb 100644
--- a/Documentation/devicetree/bindings/pci/rockchip,rk3399-pcie-ep.yaml
+++ b/Documentation/devicetree/bindings/pci/rockchip,rk3399-pcie-ep.yaml
@@ -47,14 +47,15 @@ examples:
 
         pcie-ep@f8000000 {
             compatible = "rockchip,rk3399-pcie-ep";
-            reg = <0x0 0xfd000000 0x0 0x1000000>, <0x0 0x80000000 0x0 0x20000>;
-            reg-names = "apb-base", "mem-base";
+            rockchip,max-outbound-regions = <32>;
             clocks = <&cru ACLK_PCIE>, <&cru ACLK_PERF_PCIE>,
               <&cru PCLK_PCIE>, <&cru SCLK_PCIE_PM>;
             clock-names = "aclk", "aclk-perf",
                     "hclk", "pm";
             max-functions = /bits/ 8 <8>;
             num-lanes = <4>;
+            reg = <0x0 0xfd000000 0x0 0x1000000>, <0x0 0xfa000000 0x0 0x2000000>;
+            reg-names = "apb-base", "mem-base";
             resets = <&cru SRST_PCIE_CORE>, <&cru SRST_PCIE_MGMT>,
               <&cru SRST_PCIE_MGMT_STICKY>, <&cru SRST_PCIE_PIPE> ,
               <&cru SRST_PCIE_PM>, <&cru SRST_P_PCIE>, <&cru SRST_A_PCIE>;
@@ -62,7 +63,8 @@ examples:
                     "pm", "pclk", "aclk";
             phys = <&pcie_phy 0>, <&pcie_phy 1>, <&pcie_phy 2>, <&pcie_phy 3>;
             phy-names = "pcie-phy-0", "pcie-phy-1", "pcie-phy-2", "pcie-phy-3";
-            rockchip,max-outbound-regions = <16>;
+            pinctrl-names = "default";
+            pinctrl-0 = <&pcie_clkreqnb_cpm>;
         };
     };
 ...
-- 
2.25.1

