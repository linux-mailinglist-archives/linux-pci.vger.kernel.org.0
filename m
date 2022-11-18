Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52F0262F7A2
	for <lists+linux-pci@lfdr.de>; Fri, 18 Nov 2022 15:35:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242454AbiKROfI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 18 Nov 2022 09:35:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242458AbiKROeN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 18 Nov 2022 09:34:13 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE8316E541
        for <linux-pci@vger.kernel.org>; Fri, 18 Nov 2022 06:33:42 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id d9so9492910wrm.13
        for <linux-pci@vger.kernel.org>; Fri, 18 Nov 2022 06:33:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vtHGgz0aNZ8O4g5t85qJZBMPGFrxhFl4205fva4OsWQ=;
        b=BO8ROg5BJ6RGrVq0ohOOCYibPNqDvqoYFsCNTT11mx497PxFVxShxxsUfRwD4SK3cU
         TsZeYKUDcFOgHM4ELTZR4kNhfhkVLT/4o4ZGY670L9bRsP9uoQWoBWQyXIKx2pvTA9yP
         tphOK/1eDercWalNOehohRD0IVAjqv6ZLEgDoBj/MOW9ryORoKz/iYRO8WCuI1/SBf9u
         PZOhT4cdxEljiB1lmm06JfNbtsFmU6F5TMo262xjqipEVdKPbrudHDle9L7ubqqfzPvv
         mIImRMlOFpbPJYYhNmDAtX4e7tXnVMbIct1UMMktGogpQgzgf1iHHYMB54R7vE9uhzWQ
         bZnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vtHGgz0aNZ8O4g5t85qJZBMPGFrxhFl4205fva4OsWQ=;
        b=fmlfXU4vgrYfrJG1i/pjC7blOaZry18gQvsbFkQU3O5le7N7iV5LRhdLGk1JL+FpVn
         dpkhtzt/dgDOVsgnRncm8G9KaxjrPtDiXeqFVGLh5PceREsCTQJYR+zKkbzN0AYTQjSo
         MdC9FwEi1Z4w9aZVhtlPEbVTzW4n30w/6jBSv0KSknF5SA5KPsE8hpxHVFZNVGq0p337
         OkdSYqJG//Kp3CVFTmWmVOdYNfRQ/18zncfLNU+1rwLbHhinB9yHLlLOe3jCBXU0bnB3
         bXmgV5j5AR4A3LQqLzu+GB42kq3pnchQTEEKKBnSqfroU+epUQzisISvQynA+ZnPehib
         DF0Q==
X-Gm-Message-State: ANoB5pm3ZcT0ONs1qvCfwUlFLYv0EGyVi5YaB8a+UERL20MhDY0K91eW
        PFgMeJ+gjMgt9z6sPrJev0laEA==
X-Google-Smtp-Source: AA0mqf4XNekGInOYNeUSa4phDRGqqyxVcnEtfIoRmwb92p+n2ynVm0c1NWFDdqoA08jLtN/J9Y9ReQ==
X-Received: by 2002:a5d:4408:0:b0:236:b877:d24a with SMTP id z8-20020a5d4408000000b00236b877d24amr4372700wrq.162.1668782021283;
        Fri, 18 Nov 2022 06:33:41 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id j21-20020a05600c1c1500b003cfb7c02542sm5436726wms.11.2022.11.18.06.33.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 06:33:40 -0800 (PST)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Fri, 18 Nov 2022 15:33:33 +0100
Subject: [PATCH 07/12] dt-bindings: power: remove deprecated
 amlogic,meson-gx-pwrc.txt bindings
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20221117-b4-amlogic-bindings-convert-v1-7-3f025599b968@linaro.org>
References: <20221117-b4-amlogic-bindings-convert-v1-0-3f025599b968@linaro.org>
In-Reply-To: <20221117-b4-amlogic-bindings-convert-v1-0-3f025599b968@linaro.org>
To:     Jakub Kicinski <kuba@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Eric Dumazet <edumazet@google.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Vinod Koul <vkoul@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        "David S. Miller" <davem@davemloft.net>
Cc:     linux-media@vger.kernel.org, netdev@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-mmc@vger.kernel.org,
        linux-rtc@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>,
        devicetree@vger.kernel.org
X-Mailer: b4 0.10.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Remove the deprecated amlogic,meson-gx-pwrc.txt bindings, which was
replaced by the amlogic,meson-ee-pwrc.yaml bindings.

The amlogic,meson-gx-pwrc-vpu compatible isn't used anymore since [1]
was merged in v5.8-rc1 and amlogic,meson-g12a-pwrc-vpu either since [2]
was merged in v5.3-rc1.

[1] commit 5273d6cacc06 ("arm64: dts: meson-gx: Switch to the meson-ee-pwrc bindings")
[2] commit f4f1c8d9ace7 ("arm64: dts: meson-g12: add Everything-Else power domain controller")

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 .../bindings/power/amlogic,meson-gx-pwrc.txt       | 63 ----------------------
 1 file changed, 63 deletions(-)

diff --git a/Documentation/devicetree/bindings/power/amlogic,meson-gx-pwrc.txt b/Documentation/devicetree/bindings/power/amlogic,meson-gx-pwrc.txt
deleted file mode 100644
index 99b5b10cda31..000000000000
--- a/Documentation/devicetree/bindings/power/amlogic,meson-gx-pwrc.txt
+++ /dev/null
@@ -1,63 +0,0 @@
-Amlogic Meson Power Controller
-==============================
-
-The Amlogic Meson SoCs embeds an internal Power domain controller.
-
-VPU Power Domain
-----------------
-
-The Video Processing Unit power domain is controlled by this power controller,
-but the domain requires some external resources to meet the correct power
-sequences.
-The bindings must respect the power domain bindings as described in the file
-power-domain.yaml
-
-Device Tree Bindings:
----------------------
-
-Required properties:
-- compatible: should be one of the following :
-	- "amlogic,meson-gx-pwrc-vpu" for the Meson GX SoCs
-	- "amlogic,meson-g12a-pwrc-vpu" for the Meson G12A SoCs
-- #power-domain-cells: should be 0
-- amlogic,hhi-sysctrl: phandle to the HHI sysctrl node
-- resets: phandles to the reset lines needed for this power demain sequence
-	as described in ../reset/reset.txt
-- clocks: from common clock binding: handle to VPU and VAPB clocks
-- clock-names: from common clock binding: must contain "vpu", "vapb"
-	corresponding to entry in the clocks property.
-
-Parent node should have the following properties :
-- compatible: "amlogic,meson-gx-ao-sysctrl", "syscon", "simple-mfd"
-- reg: base address and size of the AO system control register space.
-
-Example:
--------
-
-ao_sysctrl: sys-ctrl@0 {
-	compatible = "amlogic,meson-gx-ao-sysctrl", "syscon", "simple-mfd";
-	reg =  <0x0 0x0 0x0 0x100>;
-
-	pwrc_vpu: power-controller-vpu {
-		compatible = "amlogic,meson-gx-pwrc-vpu";
-		#power-domain-cells = <0>;
-		amlogic,hhi-sysctrl = <&sysctrl>;
-		resets = <&reset RESET_VIU>,
-			 <&reset RESET_VENC>,
-			 <&reset RESET_VCBUS>,
-			 <&reset RESET_BT656>,
-			 <&reset RESET_DVIN_RESET>,
-			 <&reset RESET_RDMA>,
-			 <&reset RESET_VENCI>,
-			 <&reset RESET_VENCP>,
-			 <&reset RESET_VDAC>,
-			 <&reset RESET_VDI6>,
-			 <&reset RESET_VENCL>,
-			 <&reset RESET_VID_LOCK>;
-		clocks = <&clkc CLKID_VPU>,
-			 <&clkc CLKID_VAPB>;
-		clock-names = "vpu", "vapb";
-	};
-};
-
-

-- 
b4 0.10.1
