Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D27A0596265
	for <lists+linux-pci@lfdr.de>; Tue, 16 Aug 2022 20:26:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235754AbiHPS0K (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 16 Aug 2022 14:26:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237074AbiHPS0G (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 16 Aug 2022 14:26:06 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B873868BC
        for <linux-pci@vger.kernel.org>; Tue, 16 Aug 2022 11:26:00 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id ba1so3039458wrb.5
        for <linux-pci@vger.kernel.org>; Tue, 16 Aug 2022 11:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=conchuod.ie; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=vN0DGeJfb4elpBHq3mALobUym6adR42yLX1wd+NKgEE=;
        b=PEQa+TuOt73fuVOb7T3+1Hy22N+kDixRACSlic+zJdWgAlesuDfvE1jahD01g/8cdj
         JtjLszP3D/e60G+3P/Rt5/iBz9VWfQF602riMmjeed8yuXTxodssttItwsAyz0GrBQZo
         6LmHwXV6CqeUfz64pE5IPXKtJ1n9S1FreF+47P+iL8HB8IR1vVJdH5psvqQJAAo3dCRq
         DL/y+a0eof3Bq6c8BzMHERC/3fGHJeLd1TPzHyp3//AleEyFOUblv3dKavXn72ZfaRSc
         07f2TgjpW+yB32DviJVBg2Kdf2NeR/iovjRACiByAy90F94WBIc+It5pE/ThbMRTHttV
         4HTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=vN0DGeJfb4elpBHq3mALobUym6adR42yLX1wd+NKgEE=;
        b=btZhC62nO/IcHj8b7bZVwF8362UHdGhPNgcLRJhaW8Su4GU8kcCvqPxo4MGYBqqU6I
         DlrOMDrnhsVzHsFKGAz2hQa4z6n7QXpdGrmTbsTJSqgtxBJiEXmBGSevL6JOcCQUv0sF
         BVW4DYfCOrif/RXzygiCtDwY9a2Sjxo4F3nw8ptTlv5rJb6hnFfgZ6iEFu5oCvG1HOzz
         gbXmTScuP0+x354bVo8QH47vvolz6ueBalytOJZe+mPsfv4/mnwVTR1yYNxuO+92o2hx
         8Lc3MJZC4okdvE35SabKnTCkJoUmWEGXeHF7UtqxplXQf/F/KVXl0mvQvU8Otq5V+XzA
         4ztA==
X-Gm-Message-State: ACgBeo1I84Binbwh4KLb4wnDBx7Dx5xVxdJYiBOobfx0wwwwtOnhE6R+
        ZPNiFU/YV4Y+Rw9ndlbace8hAw==
X-Google-Smtp-Source: AA6agR7sTCd254G+0o5Cw9GOa0R6pQiko3YyBwBowV/CViwJLAAOXwkNioukcNooVtKoYy4ChxnydA==
X-Received: by 2002:a5d:5081:0:b0:220:6262:be0b with SMTP id a1-20020a5d5081000000b002206262be0bmr11725612wrt.228.1660674358778;
        Tue, 16 Aug 2022 11:25:58 -0700 (PDT)
Received: from henark71.. ([109.76.58.63])
        by smtp.gmail.com with ESMTPSA id s17-20020a1cf211000000b003a603fbad5bsm4015482wmc.45.2022.08.16.11.25.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Aug 2022 11:25:58 -0700 (PDT)
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
Subject: [PATCH v2 3/6] riscv: dts: microchip: mpfs: fix incorrect pcie child node name
Date:   Tue, 16 Aug 2022 19:25:45 +0100
Message-Id: <20220816182547.3454843-4-mail@conchuod.ie>
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

