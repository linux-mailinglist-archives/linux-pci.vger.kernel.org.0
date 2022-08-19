Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28E5559A931
	for <lists+linux-pci@lfdr.de>; Sat, 20 Aug 2022 01:15:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240524AbiHSXOg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 19 Aug 2022 19:14:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240334AbiHSXOb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 19 Aug 2022 19:14:31 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99D69DDB44
        for <linux-pci@vger.kernel.org>; Fri, 19 Aug 2022 16:14:30 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id h24so6710527wrb.8
        for <linux-pci@vger.kernel.org>; Fri, 19 Aug 2022 16:14:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=conchuod.ie; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=1LGGHQ6p+mDphp3bmxn1t5fZUfaS0Whf3Mk8geT3R/0=;
        b=M0ofL3nLJRPapOip5zzM+C+RY4pKZpArvpShfp51JaedAQJPbcSiJLMbgN8hXZHax+
         pvu2X1mOJxCoPIBexYf3rhO4XapBs0sK8fFZ2aS9oZ4ZXapZpOxe7L9ecSBthoFsNGbj
         gjJHap1v2Obq9ZdbyLpA6Uxi9bLlzNMUttYqZJB4ua72mEqqGRCRupu+/v+DLrz0PVt9
         q8lT7zrMptgf34JAjxQntdAp0Qnr0mUZgFJJnJtVzmkxr2TGBlPQoE+jEb9JoEMkYjm9
         1xsXsrNMYjZsqX8mcrc262UZ4IrTyn58p1eFFZkQBu3HMcZAJnwVK2vMH9zl0nJ59PTB
         N47Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=1LGGHQ6p+mDphp3bmxn1t5fZUfaS0Whf3Mk8geT3R/0=;
        b=wE+SiQkcdRI5EqLsMBt97UIiCyQzkyyhhISV1pL+rjrH56+7H7ZAOhgv5EpfTxdWYE
         lnA7IXOuTu3UKFUdaCxy1anPWI6Ys2nYHAbOLvNjLcUjQ+regFM5vqSMfPkqtfN5oBVu
         b5CM/5CuvhhZpd7kyYirCkjlXkbMAnj0HFTK11nptIUWN570ozS+uAIj6SiCEr4JRZAr
         UqKwluDGmKrx1hDaTn2Sp9WuIrQSX82diJlqAB+BBC7rjDcT0djzBrqtPnJda0hX7ICW
         wv/AvkOFeT3cuNiUQpqmzsvbFFMvLJo/34K+ShMIXBn3jr9R/hw9InGluSsNxAXs0U7b
         K4rw==
X-Gm-Message-State: ACgBeo1N4hJYZhXuyC6yM3MY2Tns0yL826/zX2uSRJmFQFsFGfRIU4lr
        YmmeATVmdJOrFIq0Rza5TIcwCA==
X-Google-Smtp-Source: AA6agR5HUiYYHhjMNaA5RLf8rXmmkgRypSuuZuVTDp4Hep5U2Q4CO8SNj0TYTdzVU15m+IkUBb8akg==
X-Received: by 2002:a05:6000:2ab:b0:223:6167:a213 with SMTP id l11-20020a05600002ab00b002236167a213mr5328028wry.310.1660950869802;
        Fri, 19 Aug 2022 16:14:29 -0700 (PDT)
Received: from henark71.. ([109.76.58.63])
        by smtp.gmail.com with ESMTPSA id g17-20020a5d46d1000000b0020fff0ea0a3sm5198522wrs.116.2022.08.19.16.14.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 16:14:29 -0700 (PDT)
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
Subject: [PATCH v3 5/7] riscv: dts: microchip: mpfs: remove ti,fifo-depth property
Date:   Sat, 20 Aug 2022 00:14:14 +0100
Message-Id: <20220819231415.3860210-6-mail@conchuod.ie>
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

Recent versions of dt-schema warn about a previously undetected
undocument property on the icicle & polarberry devicetrees:

arch/riscv/boot/dts/microchip/mpfs-icicle-kit.dtb: ethernet@20112000: ethernet-phy@8: Unevaluated properties are not allowed ('ti,fifo-depth' was unexpected)
        From schema: Documentation/devicetree/bindings/net/cdns,macb.yaml

I know what you're thinking, the binding doesn't look to be the problem
and I agree. I am not sure why a TI vendor property was ever actually
added since it has no meaning... just get rid of it.

Fixes: bc47b2217f24 ("riscv: dts: microchip: add the sundance polarberry")
Fixes: 0fa6107eca41 ("RISC-V: Initial DTS for Microchip ICICLE board")
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
v2022.08 or later of dt-schema is required.
---
 arch/riscv/boot/dts/microchip/mpfs-icicle-kit.dts | 2 --
 arch/riscv/boot/dts/microchip/mpfs-polarberry.dts | 2 --
 2 files changed, 4 deletions(-)

diff --git a/arch/riscv/boot/dts/microchip/mpfs-icicle-kit.dts b/arch/riscv/boot/dts/microchip/mpfs-icicle-kit.dts
index 044982a11df5..ee548ab61a2a 100644
--- a/arch/riscv/boot/dts/microchip/mpfs-icicle-kit.dts
+++ b/arch/riscv/boot/dts/microchip/mpfs-icicle-kit.dts
@@ -84,12 +84,10 @@ &mac1 {
 
 	phy1: ethernet-phy@9 {
 		reg = <9>;
-		ti,fifo-depth = <0x1>;
 	};
 
 	phy0: ethernet-phy@8 {
 		reg = <8>;
-		ti,fifo-depth = <0x1>;
 	};
 };
 
diff --git a/arch/riscv/boot/dts/microchip/mpfs-polarberry.dts b/arch/riscv/boot/dts/microchip/mpfs-polarberry.dts
index 82c93c8f5c17..dc11bb8fc833 100644
--- a/arch/riscv/boot/dts/microchip/mpfs-polarberry.dts
+++ b/arch/riscv/boot/dts/microchip/mpfs-polarberry.dts
@@ -54,12 +54,10 @@ &mac1 {
 
 	phy1: ethernet-phy@5 {
 		reg = <5>;
-		ti,fifo-depth = <0x01>;
 	};
 
 	phy0: ethernet-phy@4 {
 		reg = <4>;
-		ti,fifo-depth = <0x01>;
 	};
 };
 
-- 
2.37.1

