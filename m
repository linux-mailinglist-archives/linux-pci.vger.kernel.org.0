Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 470B159A940
	for <lists+linux-pci@lfdr.de>; Sat, 20 Aug 2022 01:15:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241363AbiHSXOj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 19 Aug 2022 19:14:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242246AbiHSXOe (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 19 Aug 2022 19:14:34 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89DF3D2EAA
        for <linux-pci@vger.kernel.org>; Fri, 19 Aug 2022 16:14:33 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id r16so6720809wrm.6
        for <linux-pci@vger.kernel.org>; Fri, 19 Aug 2022 16:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=conchuod.ie; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=1zyqHrnqjTNMymEC/TbLOlsscOLg5SkRYxlyH7Tu2Ms=;
        b=Y8AD7r5Epuf9MXQ2+jv+dlo+KisSknvBlpvGlf/D+IiD9iTBxDKQ5D0kGW2ZkDBfJK
         TyKvVRquHMBJjPepEwyh7xDrU0VoGL94RietZ1RYfzka1+goKyIru/tmRTNC9ubgswY2
         7C+4K1MwwgAzWNLHphJlqXVL5a4rZqVQVlMOGYmmLzuhs1ZKtPsWUEDGofFP1sHIH/wY
         m95dlsgCLOt9UOfnchFoIXKKzh3nKQwdQkSWmwPvf2cOmUR3QNQAGQ3UwyDoWUSAvv7i
         9UY485pjhWoHEbFbH6nxyy8pgKz2+3vm2gTryx5AF6pby/lIBfQgg5AGPutVWiRKVOm1
         PhKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=1zyqHrnqjTNMymEC/TbLOlsscOLg5SkRYxlyH7Tu2Ms=;
        b=4+jhJG1+VLYChX8ZsNAMkwmKUApv4xHiCJ5P3oaXHnjZNviSdf6onOsOBkQN+SEe3O
         1rYZpmFfwmXIPGOj4qJ/4rjjKDf5vkA9fFDayyb4fM+Huk/c46dlsQYwxBnaGH5L3qw3
         0Iw9Uk1WUVH7fAKIv3gP5Ljv1pMrvnt+rr/BndHpSSXmmykVZCXMSqQceUgtRHagYmNR
         2D6eXhsK/Igy6o5BbKLFsq0qRIdliC0pyhFake2syZ0LyWPLerbpq28G0yxa5KzFq+yi
         UfZG0JAJ0/GjVTUokEG70hUK7R0p3Vq4nnXMT08KoipbTeisVl3brnEr/JdXfXJEVQOk
         fR9A==
X-Gm-Message-State: ACgBeo1ZJaqd9+6AYXfyasl0WYqDREWeRFkx4l4lu83B1BC0Dopwfh33
        NiwLIDdpsZvlFG567BPzYA6DeA==
X-Google-Smtp-Source: AA6agR4jJTOrQBvLUsU3COfZPaxQ1oU8l4Hl4SO0D5oMAjRdbWZOcdKruN9mdEbg+eLcUTkfChoGKQ==
X-Received: by 2002:a5d:404c:0:b0:225:1a39:d69f with SMTP id w12-20020a5d404c000000b002251a39d69fmr5405015wrp.576.1660950872099;
        Fri, 19 Aug 2022 16:14:32 -0700 (PDT)
Received: from henark71.. ([109.76.58.63])
        by smtp.gmail.com with ESMTPSA id g17-20020a5d46d1000000b0020fff0ea0a3sm5198522wrs.116.2022.08.19.16.14.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 16:14:31 -0700 (PDT)
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
Subject: [PATCH v3 7/7] riscv: dts: microchip: mpfs: remove pci axi address translation property
Date:   Sat, 20 Aug 2022 00:14:16 +0100
Message-Id: <20220819231415.3860210-8-mail@conchuod.ie>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220819231415.3860210-1-mail@conchuod.ie>
References: <20220819231415.3860210-1-mail@conchuod.ie>
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

Link: https://www.microsemi.com/document-portal/doc_download/1245812-polarfire-fpga-and-polarfire-soc-fpga-pci-express-user-guide # Section 1.3.3
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

