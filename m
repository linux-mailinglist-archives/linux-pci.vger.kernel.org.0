Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 914EF59626F
	for <lists+linux-pci@lfdr.de>; Tue, 16 Aug 2022 20:27:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236559AbiHPS0R (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 16 Aug 2022 14:26:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237090AbiHPS0I (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 16 Aug 2022 14:26:08 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CA6F86C3F
        for <linux-pci@vger.kernel.org>; Tue, 16 Aug 2022 11:26:03 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id v3so13646899wrp.0
        for <linux-pci@vger.kernel.org>; Tue, 16 Aug 2022 11:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=conchuod.ie; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=0menBycPydf3OF4brxfxIM8hwmBUp4QdVL5XPrXyre0=;
        b=cq/wfBYlh9TNFle3AyyvA6aRqw5tapsXhJ5VOkQTJzEV+SvWLBxc0M7sv8kJVNFdJ5
         5JncrYyhkUkDXQWKF8FAx4sOG+2Ex6/MC0HoGJhU8vOvxPOwd8YhEMi9IQCLhhDbmhUD
         5joEaePchEDaqh7S5PvvzvcmKFLRa3Wqpo562J+IcuT6DJ4Rc6YKoH3AOuH7ki/Avy3R
         hLP2aCDDBDn0P/4xlwEI29MsDEgyaxsNArRWr+Y9os15aApcQqcS3ANBUaBPIP9sDbWh
         yow8teObOTaeHu0HIjh+iczV/cqIcV45gESM0bCY/PkvniEAUabK6pe1YdzVVW39fcvQ
         JHBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=0menBycPydf3OF4brxfxIM8hwmBUp4QdVL5XPrXyre0=;
        b=oFY+pzHsNYwC+5LpH7iOZhRovIgmtGou47N9VDR0PB8oOtp1TQz416tHvM62lNsg5T
         RJrMm+2vup4uRoXLrYw69mStzIb8WAARHdyIcQjmMP9FJaQpjRY0Ur8bAO+XM3BPM+NL
         JjItaQ/v/sNUQbsqtJZTllZgFR/nQQFPc4NQPrTObvm4RX+ei3sYOQVYKFV6E60y19Af
         DFli6H1E4JjlB2dpA14GN1OUqxKNN6xlJxRULfoAKgfPhWa566+WM9Sll5JivsiEpA/p
         ru7/6l8Gf1eY4ClQTUt6ndYs/DS0hykPzTGBIjPCX1FoMMg5XKQqFAF1Cuc4P26WpmnQ
         fGCw==
X-Gm-Message-State: ACgBeo29r4/HcRLCs8KExTcbG1Dz7gCEq6z4xKOMPkQbECLFsrqLkDTn
        LDe/JGg3d7sxMJJfBF1LtAgIDxEmjMjkkx79
X-Google-Smtp-Source: AA6agR6kxEpAlsWHGGaIsHWoq0lgu/Z8DXmzz/tOaQf+JXZgc8EJhMGnIovPSVPfRDBgUP5kkbMmOQ==
X-Received: by 2002:a5d:4d4d:0:b0:225:fbf:fbac with SMTP id a13-20020a5d4d4d000000b002250fbffbacmr4093198wru.623.1660674362913;
        Tue, 16 Aug 2022 11:26:02 -0700 (PDT)
Received: from henark71.. ([109.76.58.63])
        by smtp.gmail.com with ESMTPSA id s17-20020a1cf211000000b003a603fbad5bsm4015482wmc.45.2022.08.16.11.26.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Aug 2022 11:26:02 -0700 (PDT)
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
Subject: [PATCH v2 6/6] riscv: dts: microchip: mpfs: remove pci axi address translation property
Date:   Tue, 16 Aug 2022 19:25:48 +0100
Message-Id: <20220816182547.3454843-7-mail@conchuod.ie>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220816182547.3454843-1-mail@conchuod.ie>
References: <20220816182547.3454843-1-mail@conchuod.ie>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Conor Dooley <conor.dooley@microchip.com>

An AXI master address translation table property was inadvertently
added to the device tree & this was not caught by dtbs_check at the
time. Remove the property - it should not be in mpfs.dtsi anyway as
it would be more suitable in -fabric.dtsi nor does it actually apply
to the version of the reference design we are using for upstream.

Fixes: 528a5b1f2556 ("riscv: dts: microchip: add new peripherals to icicle kit device tree")
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 arch/riscv/boot/dts/microchip/mpfs.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/riscv/boot/dts/microchip/mpfs.dtsi b/arch/riscv/boot/dts/microchip/mpfs.dtsi
index e69322f56516..a1176260086a 100644
--- a/arch/riscv/boot/dts/microchip/mpfs.dtsi
+++ b/arch/riscv/boot/dts/microchip/mpfs.dtsi
@@ -485,7 +485,6 @@ pcie: pcie@2000000000 {
 			ranges = <0x3000000 0x0 0x8000000 0x20 0x8000000 0x0 0x80000000>;
 			msi-parent = <&pcie>;
 			msi-controller;
-			microchip,axi-m-atr0 = <0x10 0x0>;
 			status = "disabled";
 			pcie_intc: interrupt-controller {
 				#address-cells = <0>;
-- 
2.37.1

