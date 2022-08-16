Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E985C596262
	for <lists+linux-pci@lfdr.de>; Tue, 16 Aug 2022 20:26:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236600AbiHPS0J (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 16 Aug 2022 14:26:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237068AbiHPS0G (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 16 Aug 2022 14:26:06 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 381EF86B7B
        for <linux-pci@vger.kernel.org>; Tue, 16 Aug 2022 11:25:59 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id h1so5619285wmd.3
        for <linux-pci@vger.kernel.org>; Tue, 16 Aug 2022 11:25:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=conchuod.ie; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=FMkAjTRxFynoKfy/JBCi5zISG1GRJIQTYNHeDvaDnhc=;
        b=edWE/8Om/5nhi4bDasv/LIbOVfF6WqJ+jyLjdV2U57/KWwkiAZLjuSgliTEtKV3eDm
         2Ib2XEp6RLOwpim0ssuftuMa6c6upQpytEDq0mFmszL6W3YVjVEPD1R/hNMvKUef16id
         hxV655Qk8bLCNbcVyuJIgjbIMupSeJe8pcOU3EM8Ia1PoJd31xFM8MY+1qviVmLIk0hJ
         ub5tfTuqSHLH2meS7KyNVIA0QPr6gv9/xIVaRZj2P4CiDOnfovYMg8VUp6PtTF9sYRbA
         AEqW8lHeTMVn4k0kEyt7trr4QxLSHIS6ShpD3Nu/yRwub/Ip6BbP6ZmISwP/IYQJnODt
         JmrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=FMkAjTRxFynoKfy/JBCi5zISG1GRJIQTYNHeDvaDnhc=;
        b=mMUX2f98oCM/jWTW4CsUhqt0iK/whhxz2lCLWfCd8tn5+L3KUHJf022sIP5aKNJ4E1
         UpLnxw2yxRp4t0Wgw8VBuRP/XzVvbXajbzPuZL+MuwIx2t7QrsHAgSPC1pVIf5fo/g7H
         HRpsBxP3y6MfxMaY6CVYOja6mAsxHjpd3mE64aOc8rJlN2Q2r2LMTT5FmPRoGQObz6Qv
         iJtYXRL8vF3ZXZTeiekNy/QVessgZCFy0BoFOgQc0Ir7oy6WS9spQPnYJBZABw68JVTO
         qzCL4tYTfzZbNAnS0AN3dFNMdE8ppVYEFLGdOrOIz7xEDvSvHrttAznERZVUEYDeWaF8
         y05w==
X-Gm-Message-State: ACgBeo2iLKg93E2sLgghhSgEjh2BoLAMG+nG3sDW52tyENEVBIBwQZKH
        O1rKmSMI9Xy5Yb7S6OzCi3Ffkw==
X-Google-Smtp-Source: AA6agR5KC3j+XouQHP1FxiS6VJD6PbM4GQLhS+ON8+YKaVfbQ51bYX6+5FkVajNHT2pNc6KNfsSAjw==
X-Received: by 2002:a05:600c:1898:b0:3a5:b467:c3ef with SMTP id x24-20020a05600c189800b003a5b467c3efmr19356925wmp.178.1660674357641;
        Tue, 16 Aug 2022 11:25:57 -0700 (PDT)
Received: from henark71.. ([109.76.58.63])
        by smtp.gmail.com with ESMTPSA id s17-20020a1cf211000000b003a603fbad5bsm4015482wmc.45.2022.08.16.11.25.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Aug 2022 11:25:57 -0700 (PDT)
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
Subject: [PATCH v2 2/6] dt-bindings: PCI: microchip,pcie-host: fix missing clocks properties
Date:   Tue, 16 Aug 2022 19:25:44 +0100
Message-Id: <20220816182547.3454843-3-mail@conchuod.ie>
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

Recent versions of dt-schema warn about unevaluatedProperties:
arch/riscv/boot/dts/microchip/mpfs-icicle-kit.dtb: pcie@2000000000: Unevaluated properties are not allowed ('clock-names', 'clocks', 'legacy-interrupt-controller', 'microchip,axi-m-atr0' were unexpected)
        From schema: Documentation/devicetree/bindings/pci/microchip,pcie-host.yaml

The clocks are required to enable interfaces between the FPGA fabric
and the core complex, so add them to the binding.

Fixes: 6ee6c89aac35 ("dt-bindings: PCI: microchip: Add Microchip PolarFire host binding")
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
dt-schema v2022.08 is required to replicate
---
 .../bindings/pci/microchip,pcie-host.yaml     | 25 +++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/microchip,pcie-host.yaml b/Documentation/devicetree/bindings/pci/microchip,pcie-host.yaml
index edb4f81253c8..6bbde8693ef8 100644
--- a/Documentation/devicetree/bindings/pci/microchip,pcie-host.yaml
+++ b/Documentation/devicetree/bindings/pci/microchip,pcie-host.yaml
@@ -25,6 +25,31 @@ properties:
       - const: cfg
       - const: apb
 
+  clocks:
+    description:
+      Fabric Interface Controllers, FICs, are the interface between the FPGA
+      fabric and the core complex on PolarFire SoC. The FICs require two clocks,
+      one from each side of the interface. The "FIC clocks" described by this
+      property are on the core complex side & communication through a FIC is not
+      possible unless it's corresponding clock is enabled. A clock must be
+      enabled for each of the interfaces the root port is connected through.
+      This could in theory be all 4 interfaces, one interface or any combination
+      in between.
+    minItems: 1
+    items:
+      - description: FIC0's clock
+      - description: FIC1's clock
+      - description: FIC2's clock
+      - description: FIC3's clock
+
+  clock-names:
+    description:
+      As any FIC connection combination is possible, the names should match the
+      order in the clocks property and take the form "ficN" where N is a number
+      0-3
+    minItems: 1
+    maxItems: 4
+
   interrupts:
     minItems: 1
     items:
-- 
2.37.1

