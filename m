Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 463E859A92E
	for <lists+linux-pci@lfdr.de>; Sat, 20 Aug 2022 01:15:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239587AbiHSXOf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 19 Aug 2022 19:14:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239918AbiHSXOb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 19 Aug 2022 19:14:31 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37CC6D2EAA
        for <linux-pci@vger.kernel.org>; Fri, 19 Aug 2022 16:14:30 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id n7so6723906wrv.4
        for <linux-pci@vger.kernel.org>; Fri, 19 Aug 2022 16:14:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=conchuod.ie; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=vN0DGeJfb4elpBHq3mALobUym6adR42yLX1wd+NKgEE=;
        b=gCzTdWMPXSugSg9LBMqCSeD3JplhT7DIWaAbxBe7JlQULZyIYqyUNrHUrxqRv1nF0O
         IlFWgdYpoXqtffeSgF9cKPNsxJpUpc/ijbHjw7YRoPH9w3KpI/SLogztqwUGA14d3my0
         d4NJZCxPDt7vfVLMkJiCIns7c4tsFotmJEjMyJF/FrXxOAJhMjWYyQ8U5tovJyt/MirR
         VoTiA0Zp75abJqzzT0sClBB3tJwSPQS7fQNkRkq7U8MZgXY4t+EmEaY+WTcZJdMj/PBL
         UUFsOfiW3XCqKP0n9OSN5aLI1LVtUp9Vu7bz+TJ+3yFGhSr84TNfBlK4kNtu6s+kjHjM
         H9AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=vN0DGeJfb4elpBHq3mALobUym6adR42yLX1wd+NKgEE=;
        b=2B612D+W+EtrzWbCF82bbAI1hUQ+OlxjRJZj8HFBJvrlcs30fmCoK5coas2h0MmTT8
         qZNuI13kFEzkugadsEQHr+Vz4cDro++7Cg3zW8K0rtEkzYFYupf0JVsUsy8EizMdwGhO
         VgDIv8gF9eWSVEJt5cq3zmrmfG2n+wM+LUPPKKNwDFnJ2OVSaW9RhoSJ+OGSKGAs4d3I
         gv39ZBal4y0ciAw77Foi70b84GmkqxHa1gwwy7w4iesHmdkJlPjUXgr2c9MtF6HLvwnc
         5hygYqGmAIS3U+qamvOxnUSb4Ci9XsNzskMvwil54mqZPhvJ2eyVf7fxunj8MZwrqtlC
         Kg6w==
X-Gm-Message-State: ACgBeo33J8zob67eFEN3qsuP4uSkgmk+2L4Vx6ax0fJ7cNJG9jfDEGUs
        3x5De8oVnaSmqHGBu4gzPjELyQ==
X-Google-Smtp-Source: AA6agR5RqrcGo/ilIWgn0sQMbkFC+AIrrHqX1XG5e4BktUFXFPfuB61xoV/CrtIzIW8k7+CP+vOMKA==
X-Received: by 2002:a05:6000:144a:b0:220:7181:9283 with SMTP id v10-20020a056000144a00b0022071819283mr5097105wrx.158.1660950868698;
        Fri, 19 Aug 2022 16:14:28 -0700 (PDT)
Received: from henark71.. ([109.76.58.63])
        by smtp.gmail.com with ESMTPSA id g17-20020a5d46d1000000b0020fff0ea0a3sm5198522wrs.116.2022.08.19.16.14.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 16:14:28 -0700 (PDT)
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
Subject: [PATCH v3 4/7] riscv: dts: microchip: mpfs: fix incorrect pcie child node name
Date:   Sat, 20 Aug 2022 00:14:13 +0100
Message-Id: <20220819231415.3860210-5-mail@conchuod.ie>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220819231415.3860210-1-mail@conchuod.ie>
References: <20220819231415.3860210-1-mail@conchuod.ie>
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

Recent versions of dt-schema complain about the PCIe controller's child
node name:
arch/riscv/boot/dts/microchip/mpfs-icicle-kit.dtb: pcie@2000000000: Unevaluated properties are not allowed ('clock-names', 'clocks', 'legacy-interrupt-controller', 'microchip,axi-m-atr0' were unexpected)
            From schema: Documentation/devicetree/bindings/pci/microchip,pcie-host.yaml
Make the dts match the correct property name in the dts.

Fixes: 528a5b1f2556 ("riscv: dts: microchip: add new peripherals to icicle kit device tree")
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
v2022.08 of dt-schema is required to replicate.
---
 arch/riscv/boot/dts/microchip/mpfs.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/boot/dts/microchip/mpfs.dtsi b/arch/riscv/boot/dts/microchip/mpfs.dtsi
index 499c2e63ad35..e69322f56516 100644
--- a/arch/riscv/boot/dts/microchip/mpfs.dtsi
+++ b/arch/riscv/boot/dts/microchip/mpfs.dtsi
@@ -487,7 +487,7 @@ pcie: pcie@2000000000 {
 			msi-controller;
 			microchip,axi-m-atr0 = <0x10 0x0>;
 			status = "disabled";
-			pcie_intc: legacy-interrupt-controller {
+			pcie_intc: interrupt-controller {
 				#address-cells = <0>;
 				#interrupt-cells = <1>;
 				interrupt-controller;
-- 
2.37.1

