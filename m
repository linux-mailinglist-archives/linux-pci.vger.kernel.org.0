Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE4F26E43C2
	for <lists+linux-pci@lfdr.de>; Mon, 17 Apr 2023 11:27:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230449AbjDQJ1m (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 17 Apr 2023 05:27:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230149AbjDQJ1U (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 17 Apr 2023 05:27:20 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4184F5270;
        Mon, 17 Apr 2023 02:27:14 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id kt6so24195557ejb.0;
        Mon, 17 Apr 2023 02:27:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681723632; x=1684315632;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gXA2hp0m2ISM3D3+h81RjtKD9xln/dgRYjKYAUjtQ4k=;
        b=oFabUIkr/m+0dhBqr8gVR8KkmRWL++HZH5j8rqMLnfN4+mOJ7wqUzQN7uhdmu9CGFc
         r2Kt6WHNPtSupwxNXGrMLT99fMxTWPfoa50ZUgybjirQYOxzCIu6YvXamevyDKRbg0o3
         Mbi14eDAFyAcRJ3GWk1kiLYr+DAiCZOqLUIsH3FLuIkTBU4jqdIFxP272npGnLsTsgov
         Ij8LcwcoX3pELHwOnuF4SXzcXP2Y90Qp3zDLRvR6KvXrGXQMUj+hcDRq4qi0/XMn3wxT
         iL+QxlB+2034pcH0jRjVKbRkVKVLHDslyTpWNCblg87MHyAmRWg2mFYay3DihUMuo99v
         jyDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681723632; x=1684315632;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gXA2hp0m2ISM3D3+h81RjtKD9xln/dgRYjKYAUjtQ4k=;
        b=JrRiLmqFfbSdDGSvlgZf6tKYPjF/vLJ3rdmPt5AsWhqFjt7Xv3OJiW4MvxnUU7KbMg
         6waGnlfLHNfS7Q/xnS+JNb+go/9nfRoLOENtfwKO+AO4tDU6RoCzPl0Us7r8Y9xh2Tqx
         6QW19UKn7WWIXblpzJMCabGQ3cAlo/Dev5gfRz/Rtyxpxc9Qk5Cg5APdnpYIO7oWASj8
         n4fezK4r0HkXPRl/5Kr8axymOe9imnhtWTP9lQsKvvN4WkdZaNoGuf+R+496kB8sw+Ec
         x5uAsZ3bjChsnl7avK9eqM4+QVVVyrKiTl0e1IipyDnEnuM4tjONek0BvQrLYy5eRgtb
         F+uw==
X-Gm-Message-State: AAQBX9fs0mzRjBHkEjsJ7kipfTw4yLJ3jRc5Aw4jjZ1/hdJKWKZ/l+/P
        /M5c9bm7TUB8dvBVL/iXE4EoiB2Jr/bGxA==
X-Google-Smtp-Source: AKy350Z3d3oZ8gjXp0kYIKMiHU1JEUW9LT2ioCMIwpyqXxaeVrEBUwYD28cDIam7VOdX9oBt6oWo9w==
X-Received: by 2002:a17:906:d8c6:b0:94e:afb6:eda2 with SMTP id re6-20020a170906d8c600b0094eafb6eda2mr6322692ejb.8.1681723632708;
        Mon, 17 Apr 2023 02:27:12 -0700 (PDT)
Received: from A13PC04R.einet.ad.eivd.ch ([193.134.219.72])
        by smtp.googlemail.com with ESMTPSA id p20-20020a170906615400b0094aa087578csm6398596ejl.171.2023.04.17.02.27.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Apr 2023 02:27:12 -0700 (PDT)
From:   Rick Wertenbroek <rick.wertenbroek@gmail.com>
To:     alberto.dassatti@heig-vd.ch
Cc:     xxm@rock-chips.com, Rick Wertenbroek <rick.wertenbroek@gmail.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Johan Jonker <jbx6244@gmail.com>,
        Brian Norris <briannorris@chromium.org>,
        Corentin Labbe <clabbe@baylibre.com>,
        Caleb Connolly <kc@postmarketos.org>,
        Judy Hsiao <judyhsiao@chromium.org>,
        Arnaud Ferraris <arnaud.ferraris@collabora.com>,
        Hugh Cole-Baker <sigmaris@gmail.com>,
        linux-pci@vger.kernel.org, linux-rockchip@lists.infradead.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 06/11] dt-bindings: PCI: Update the RK3399 example to a valid one
Date:   Mon, 17 Apr 2023 11:26:24 +0200
Message-Id: <20230417092631.347976-7-rick.wertenbroek@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230417092631.347976-1-rick.wertenbroek@gmail.com>
References: <20230417092631.347976-1-rick.wertenbroek@gmail.com>
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

