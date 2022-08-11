Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CDEF590763
	for <lists+linux-pci@lfdr.de>; Thu, 11 Aug 2022 22:33:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235462AbiHKUd3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 11 Aug 2022 16:33:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235848AbiHKUd0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 11 Aug 2022 16:33:26 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2D6A9F189
        for <linux-pci@vger.kernel.org>; Thu, 11 Aug 2022 13:33:21 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id z12so22544121wrs.9
        for <linux-pci@vger.kernel.org>; Thu, 11 Aug 2022 13:33:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=conchuod.ie; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=ClSH5MXXgUZguA19Coz32EYS83xElJy9jIFIyLAmeC4=;
        b=HHhe+yarKbkwIYZ1mXaOthZ0VXyo310D1cBk8s8PGKXtS+FAnYRo1gNG6ylVj/7gLo
         BD1+qLMXw3jHjaKmycrt6e1OAv4CCWriwslsnWnsihoR/ceQgpKaw/ZZ6agol8h0tpdV
         l02Ole49suUd2QEsa7+uNZY+ANEboqWovjQ41L3onQLVlcUDQTarQNGtsJLt8FArM1MM
         H2MDT+rXQSH4wqI56vlK6Bwt19CVBV2XqoaYwT8ClmSccYovi+z7rS+pap22DWMy7KMA
         jJBA8lhBOgEw9qEA4SepES7pXBFrOAfewHEorcKXkVi7YaO9c1U7I4skrO+n+EWweBdU
         rtFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=ClSH5MXXgUZguA19Coz32EYS83xElJy9jIFIyLAmeC4=;
        b=iEeivnSZfCeG9TtB98ZAqx5VgZWfykE8ABnHiAgU+6kD81BqYLwkIaZGzSnYJXYVDq
         czjqKp+YFtTXgCzZbxUcJIXgrVSNIWgZyN1ny/bhzuteHxTP/GJuvBoX7ZTO6DYoQfd8
         +tZ4Spu14sRmRdqwQOSbvfULaTOZhU7OulGL6JnDRos+Y1W5Xly4kqElkdSelbXSHwbd
         QcZ0KaJIOVBuvgxFfj5p8dLZ25+zGeQjZAibZIdeqPR0UgqvAW+EaP0qurDGIsFVgLOk
         Si4NlciZZ32Vxo3WY5xQ80LTqHE4Pui+G2eGjeuJdUDIDqSAMonW2LoXG/vTSZQujPb1
         MZbw==
X-Gm-Message-State: ACgBeo30KoBfoHpEqm6LhyeOSyP4E3V29CcPcXLHmtUCCsEDuXN0UBO5
        tH6sjF0R5iZ9oKL/Qf2kxa3DlQ==
X-Google-Smtp-Source: AA6agR4uUqIg2eHjtpt4HwLt+LlA2AAP/WjAN+bsQ7P2wHGzFMVwBV3+ZG92fs39ZgDOkKMy3JKrZg==
X-Received: by 2002:a5d:4345:0:b0:21a:3b82:ad57 with SMTP id u5-20020a5d4345000000b0021a3b82ad57mr361149wrr.176.1660250000231;
        Thu, 11 Aug 2022 13:33:20 -0700 (PDT)
Received: from henark71.. ([109.76.58.63])
        by smtp.gmail.com with ESMTPSA id i12-20020adfefcc000000b0021f1ec8776fsm86643wrp.61.2022.08.11.13.33.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Aug 2022 13:33:19 -0700 (PDT)
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
Subject: [PATCH 4/4] dt-bindings: PCI: microchip,pcie-host: fix missing address translation property
Date:   Thu, 11 Aug 2022 21:33:07 +0100
Message-Id: <20220811203306.179744-5-mail@conchuod.ie>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220811203306.179744-1-mail@conchuod.ie>
References: <20220811203306.179744-1-mail@conchuod.ie>
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

When the PCI controller node was added to the PolarFire SoC dtsi,
dt-schema was not able to detect the presence of some undocumented
properties due to how it handled unevaluatedProperties. v2022.08
introduces better validation, producing the following error:

arch/riscv/boot/dts/microchip/mpfs-polarberry.dtb: pcie@2000000000: Unevaluated properties are not allowed ('clock-names', 'microchip,axi-m-atr0' were unexpected)
        From schema: Documentation/devicetree/bindings/pci/microchip,pcie-host.yaml

Fixes: 528a5b1f2556 ("riscv: dts: microchip: add new peripherals to icicle kit device tree")
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
I feel like there's a pretty good chance that this is not the way this
should have been done and the property should be marked as deprecated
but I don't know enough about PCI to answer that.
---
 .../devicetree/bindings/pci/microchip,pcie-host.yaml  | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/microchip,pcie-host.yaml b/Documentation/devicetree/bindings/pci/microchip,pcie-host.yaml
index 9b123bcd034c..9ac34b33c4b2 100644
--- a/Documentation/devicetree/bindings/pci/microchip,pcie-host.yaml
+++ b/Documentation/devicetree/bindings/pci/microchip,pcie-host.yaml
@@ -71,6 +71,17 @@ properties:
   msi-parent:
     description: MSI controller the device is capable of using.
 
+  microchip,axi-m-atr0:
+    description: |
+      Depending on the FPGA bitstream, the AXIM address translation table in the
+      PCIe controllers bridge layer may need to be configured. Use this property
+      to set the address offset. For more information, see Section 1.3.3,
+      "PCIe/AXI4 Address Translation" of the PolarFire SoC PCIe User Guide:
+      https://www.microsemi.com/document-portal/doc_download/1245812-polarfire-fpga-and-polarfire-soc-fpga-pci-express-user-guide
+    $ref: /schemas/types.yaml#/definitions/uint32-matrix
+    minItems: 2
+    maxItems: 2
+
   legacy-interrupt-controller:
     type: object
     properties:
-- 
2.37.1

