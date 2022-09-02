Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C3ED5AB48A
	for <lists+linux-pci@lfdr.de>; Fri,  2 Sep 2022 16:58:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236395AbiIBO6U (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 2 Sep 2022 10:58:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236380AbiIBO5p (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 2 Sep 2022 10:57:45 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CAE810E3;
        Fri,  2 Sep 2022 07:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1662128557; x=1693664557;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=A0wOjkGsQ3icV4sYzW6juzBiZor0CRzjl5/cGd/VbdU=;
  b=Gv2gn/0fBZQ89o2tLIlh3l/aXaeQ1rnSqiBvX+fo/tRjTZvaXNw4g+N+
   djqFxTI2n+H4TLBx0NfAGaHmCzcB9DqA6LoR8s7umxpUgROImaatu0bzl
   Y9k//6pF7A0sTUiFfsiwIffQBUJz6JnC9f6ofUHaSVOsNfFPxMKRms9IZ
   KdaTYKqq+kcU0rmagw5+byzHmqKSqtA+k+b0aXPegka4hJzmRAIsUpojO
   kahz18M5wwInWtA+rc2EI/GzRu0FJ1QprRjGz6e759SmqwbVrP5xatNRn
   7gBLfKVe18kyJ1IHznX8viQIiNa1s98YCryhGs4OE+bzMa2h1grjYL3rS
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,283,1654585200"; 
   d="scan'208";a="175388520"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 02 Sep 2022 07:22:34 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Fri, 2 Sep 2022 07:22:31 -0700
Received: from daire-X570.emdalo.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.12 via Frontend Transport; Fri, 2 Sep 2022 07:22:28 -0700
From:   <daire.mcnamara@microchip.com>
To:     <aou@eecs.berkeley.edu>, <bhelgaas@google.com>,
        <conor.dooley@microchip.com>, <devicetree@vger.kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <kw@linux.com>,
        <linux-pci@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        <lpieralisi@kernel.org>, <palmer@dabbelt.com>,
        <paul.walmsley@sifive.com>, <robh+dt@kernel.org>, <robh@kernel.org>
CC:     <cyril.jean@microchip.com>, <padmarao.begari@microchip.com>,
        <heinrich.schuchardt@canonical.com>,
        <david.abdurachmanov@gmail.com>,
        "Daire McNamara" <daire.mcnamara@microchip.com>
Subject: [PATCH v1 2/4] riscv: dts: microchip: add fabric address translation properties
Date:   Fri, 2 Sep 2022 15:22:00 +0100
Message-ID: <20220902142202.2437658-3-daire.mcnamara@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220902142202.2437658-1-daire.mcnamara@microchip.com>
References: <20220902142202.2437658-1-daire.mcnamara@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Daire McNamara <daire.mcnamara@microchip.com>

On PolarFire SoC both in- & out-bound address translations occur in two
stages. The specific translations are tightly coupled to the FPGA
designs and supplement the {dma-,}ranges properties. The first stage of
the translation is done by the FPGA fabric & the second by the root
port.
Add outbound address translation information so that the translation
tables in the root port's bridge layer can be configured to account for
the translation done by the FPGA fabric on Icicle Kit reference design.

Signed-off-by: Daire McNamara <daire.mcnamara@microchip.com>
---
 arch/riscv/boot/dts/microchip/mpfs-icicle-kit-fabric.dtsi | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/boot/dts/microchip/mpfs-icicle-kit-fabric.dtsi b/arch/riscv/boot/dts/microchip/mpfs-icicle-kit-fabric.dtsi
index 98f04be0dc6b..6839650e7d1b 100644
--- a/arch/riscv/boot/dts/microchip/mpfs-icicle-kit-fabric.dtsi
+++ b/arch/riscv/boot/dts/microchip/mpfs-icicle-kit-fabric.dtsi
@@ -57,7 +57,11 @@ pcie: pcie@3000000000 {
 		interrupt-map-mask = <0 0 0 7>;
 		clocks = <&fabric_clk1>, <&fabric_clk3>;
 		clock-names = "fic1", "fic3";
-		ranges = <0x3000000 0x0 0x8000000 0x30 0x8000000 0x0 0x80000000>;
+		ranges = <0x0000000 0x0 0x0000000 0x30 0x0000000 0x0 0x8000000>,
+			 <0x3000000 0x0 0x8000000 0x30 0x8000000 0x0 0x80000000>;
+		microchip,outbound-fabric-translation-ranges =
+			 <0x0000000 0x0 0x0000000 0x30 0x0000000 0x0 0x8000000>,
+			 <0x3000000 0x0 0x8000000 0x30 0x8000000 0x0 0x80000000>;
 		dma-ranges = <0x02000000 0x0 0x00000000 0x0 0x00000000 0x1 0x00000000>;
 		msi-parent = <&pcie>;
 		msi-controller;
-- 
2.25.1

