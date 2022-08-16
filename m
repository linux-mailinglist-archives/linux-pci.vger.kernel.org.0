Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA82859626C
	for <lists+linux-pci@lfdr.de>; Tue, 16 Aug 2022 20:27:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231820AbiHPS0N (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 16 Aug 2022 14:26:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237083AbiHPS0H (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 16 Aug 2022 14:26:07 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54D7986C39
        for <linux-pci@vger.kernel.org>; Tue, 16 Aug 2022 11:26:03 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id n4so13575203wrp.10
        for <linux-pci@vger.kernel.org>; Tue, 16 Aug 2022 11:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=conchuod.ie; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=qOyz6Sg85RbWT2/Ms96NRUeJwTK6SHK6KdVqomRoy/M=;
        b=KrY4rxTH3L2TNT0Tj7Ea3n6H60cPP7wN7CFj0YwfZL3/tcHo7JcjAQR1cc9nCseY1Q
         CvSDX4Df1TuJvhRh0FUuNmuoYgfcd89WAuYpiQrxgJ36llVyw9SsimpFpQWVu02nWXcT
         GP9mZWjTux2x2gc3JPak5n3rBobhufro0EeesPdqdBTidWMJ+++fPtnXFwpd1jRaQ5uC
         AdM9UySn5X8nhrYKXkCGiq3sgYwQu5bBzjyBUZLqbo0GGVQfxEfmjHcQYruR4qw0hSOm
         qQQhOVUcytvQsE2/9LnFust0O3PVqEWZT76F7BbyLUy+nlQFXQ/WJkUS2M6MKFTbAD49
         f7XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=qOyz6Sg85RbWT2/Ms96NRUeJwTK6SHK6KdVqomRoy/M=;
        b=Rl83/t2+1RuNDk631kgjrS4ZrTPVsBffYTRkSIW3fjjky4VLblvkNJ9z2qHOQkkJ6B
         HKtSiYIPx/7nKoeOj2QFr4NlA3a6y/LPWyyfw4ffouTjWbJ9T1XiNlTLo/1XcsYgnZ0O
         jEQOQFmtq8S1t/plAcKvHhgOciQP0Dx9ete16Po/VT6nPmofGDad7UZ/kTYkRaAM3wxc
         a8c/4A+ec7MODTvJELokU4AIO4tQqyBpTH0V7HDcg11IGTQT4fICvvLa2GDqglleGWUN
         dE3li+6cFxiwrRPVQNWsSftWjy/nBbLeggDfu41L1Zr9IY1FGpb+n5t3rl+6p1l6KdoD
         yAfA==
X-Gm-Message-State: ACgBeo3Kef6/WC+JNmn83lLR/HDVG9Agsv6eDgHxbfviO8XD3CbrnfSI
        O7tQxqJpykmfiTXVZkDsX4CSLA==
X-Google-Smtp-Source: AA6agR5Eq/Dh2TGsSUxt13F3p2fStw1nzu0BqbZ6aF8bKxqUzWnpGd8AlGfuE2KkOMjcylA72rOhbQ==
X-Received: by 2002:a5d:4a84:0:b0:225:20e3:3ba6 with SMTP id o4-20020a5d4a84000000b0022520e33ba6mr881999wrq.306.1660674361600;
        Tue, 16 Aug 2022 11:26:01 -0700 (PDT)
Received: from henark71.. ([109.76.58.63])
        by smtp.gmail.com with ESMTPSA id s17-20020a1cf211000000b003a603fbad5bsm4015482wmc.45.2022.08.16.11.26.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Aug 2022 11:26:00 -0700 (PDT)
From:   Conor Dooley <mail@conchuod.ie>
To:     Daire McNamara <daire.mcnamara@microchip.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Greentime Hu <greentime.hu@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Conor Dooley <conor.dooley@microchip.com>
Cc:     linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: [PATCH v2 5/6] riscv: dts: microchip: mpfs: remove bogus card-detect-delay
Date:   Tue, 16 Aug 2022 19:25:47 +0100
Message-Id: <20220816182547.3454843-6-mail@conchuod.ie>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220816182547.3454843-1-mail@conchuod.ie>
References: <20220816182547.3454843-1-mail@conchuod.ie>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Conor Dooley <conor.dooley@microchip.com>

Recent versions of dt-schema warn about a previously undetected
undocumented property:
arch/riscv/boot/dts/microchip/mpfs-icicle-kit.dtb: mmc@20008000: Unevaluated properties are not allowed ('card-detect-delay' was unexpected)
        From schema: Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml

There are no GPIOs connected to MSSIO6B4 pin K3 so adding the common
cd-debounce-delay-ms property makes no sense. The Cadence IP has a
register that sets the card detect delay as "DP * tclk". On MPFS, this
clock frequency is not configurable (it must be 200 MHz) & the FPGA
comes out of reset with this register already set.

Fixes: bc47b2217f24 ("riscv: dts: microchip: add the sundance polarberry")
Fixes: 0fa6107eca41 ("RISC-V: Initial DTS for Microchip ICICLE board")
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
v2022.08 or later of dt-schema is required.
---
 arch/riscv/boot/dts/microchip/mpfs-icicle-kit.dts | 1 -
 arch/riscv/boot/dts/microchip/mpfs-polarberry.dts | 1 -
 2 files changed, 2 deletions(-)

diff --git a/arch/riscv/boot/dts/microchip/mpfs-icicle-kit.dts b/arch/riscv/boot/dts/microchip/mpfs-icicle-kit.dts
index ee548ab61a2a..f3f87ed2007f 100644
--- a/arch/riscv/boot/dts/microchip/mpfs-icicle-kit.dts
+++ b/arch/riscv/boot/dts/microchip/mpfs-icicle-kit.dts
@@ -100,7 +100,6 @@ &mmc {
 	disable-wp;
 	cap-sd-highspeed;
 	cap-mmc-highspeed;
-	card-detect-delay = <200>;
 	mmc-ddr-1_8v;
 	mmc-hs200-1_8v;
 	sd-uhs-sdr12;
diff --git a/arch/riscv/boot/dts/microchip/mpfs-polarberry.dts b/arch/riscv/boot/dts/microchip/mpfs-polarberry.dts
index dc11bb8fc833..c87cc2d8fe29 100644
--- a/arch/riscv/boot/dts/microchip/mpfs-polarberry.dts
+++ b/arch/riscv/boot/dts/microchip/mpfs-polarberry.dts
@@ -70,7 +70,6 @@ &mmc {
 	disable-wp;
 	cap-sd-highspeed;
 	cap-mmc-highspeed;
-	card-detect-delay = <200>;
 	mmc-ddr-1_8v;
 	mmc-hs200-1_8v;
 	sd-uhs-sdr12;
-- 
2.37.1

