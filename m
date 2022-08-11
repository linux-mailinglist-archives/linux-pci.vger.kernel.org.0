Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D9AB590765
	for <lists+linux-pci@lfdr.de>; Thu, 11 Aug 2022 22:33:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235948AbiHKUd1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 11 Aug 2022 16:33:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235759AbiHKUd0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 11 Aug 2022 16:33:26 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90EB89F180
        for <linux-pci@vger.kernel.org>; Thu, 11 Aug 2022 13:33:20 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id v3so22625077wrp.0
        for <linux-pci@vger.kernel.org>; Thu, 11 Aug 2022 13:33:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=conchuod.ie; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=BMoCBhZDWFVbCIulovqGFO1GGwjU3Gb2EjVAgLDr/kM=;
        b=e1haM7gYHDueJmKbGFqDqB0CwdhTeSa2E4wt4JmEDSJbRCc95HOzVyhmhAR1aZMqqx
         WxkA1FzPGcrae9KDWdzDMQHZEb1i39i7aAL9rQ0/XQMl0cjzp27sbySRBMnLhzbUHVO9
         p7YPgrN5/LQYBe6cKzpCPAwLYeTnzOked1Fp12KP22d+INh+NSfPUx4OvjJU/VCDd81U
         gwIKYZTkvJayzWTODqIsBm7Mc+j7idl/i5AbrnvDIsmPMmT2pRhWCHNWRNL/NjJQmAK3
         REtDrCKW9kfVEhaxxP06EjHEUcaXvACDZ9Cu7GF6pF7rHNRdKy1UlQE0Abl+CgWbWCRX
         qlpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=BMoCBhZDWFVbCIulovqGFO1GGwjU3Gb2EjVAgLDr/kM=;
        b=RaoVF6SYeJ+cGJmZsoaJ075NaXoa5Qv1l8vjk6OSrMu4fC/O5Aq+C6VMRs79rh/OSy
         Y1PyKWnAPfoEz+TblTKmXauLV0zEvph8HsqjQGO9pL+Zvf+Pu96Shgwif68mnQBzoOsP
         ZvLVvWILBkPUwQIFvbtoDJh/SsinUNbvMX8y2JlolLEsOynJk4DzRrTEFRfJrBv5/a1J
         RwNFxUCC4ojL4Fkrb+0fpfNxuLmXzYyDQ3ATVOpou3eDhLU14/pq75anoWGA3iBfLrsW
         xPrmMMpYHqn0SxjUx5QrSTkFVneNeUI/9rXUIqkNMzYYKcglTeVxMdhNeAjOp+kIRhM7
         Zq+w==
X-Gm-Message-State: ACgBeo2IL5OO/05aQY6o45x1FfF0UcWe6LX/AO0MVnay6vzbyFMtPyIb
        Um0qbdktIKZhSXV/n2dc3uhy2A==
X-Google-Smtp-Source: AA6agR7XEt/HJ/k3HAKtCMICn0MmET4kycwS554nxvopStvc3/5uFdV66pz7zYk7eLXXULU8iWeBFw==
X-Received: by 2002:a5d:44c8:0:b0:21e:b750:2bda with SMTP id z8-20020a5d44c8000000b0021eb7502bdamr351862wrr.338.1660249999075;
        Thu, 11 Aug 2022 13:33:19 -0700 (PDT)
Received: from henark71.. ([109.76.58.63])
        by smtp.gmail.com with ESMTPSA id i12-20020adfefcc000000b0021f1ec8776fsm86643wrp.61.2022.08.11.13.33.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Aug 2022 13:33:18 -0700 (PDT)
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
Subject: [PATCH 3/4] dt-bindings: PCI: microchip,pcie-host: fix incorrect child node name
Date:   Thu, 11 Aug 2022 21:33:06 +0100
Message-Id: <20220811203306.179744-4-mail@conchuod.ie>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220811203306.179744-1-mail@conchuod.ie>
References: <20220811203306.179744-1-mail@conchuod.ie>
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

v2022.08 of dt-schema improved checking of unevaluatedProperties, and
exposed a previously unseen warning for the PCIe controller's interrupt
controller node name:

arch/riscv/boot/dts/microchip/mpfs-icicle-kit.dtb: pcie@2000000000: Unevaluated properties are not allowed ('clock-names', 'clocks', 'legacy-interrupt-controller', 'microchip,axi-m-atr0' were unexpected)
        From schema: Documentation/devicetree/bindings/pci/microchip,pcie-host.yaml

Make the property in the binding match the node name actually used in
the dts.

Fixes: dcd49679fb3a ("dt-bindings: PCI: Fix 'unevaluatedProperties' warnings")
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
This is another one Rob where I feel like I'm doing the wrong thing.
The Linux driver gets the child node without using the name, but
another OS etc could in theory (or reality), right?
---
 .../devicetree/bindings/pci/microchip,pcie-host.yaml          | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/microchip,pcie-host.yaml b/Documentation/devicetree/bindings/pci/microchip,pcie-host.yaml
index 2a2166f09e2c..9b123bcd034c 100644
--- a/Documentation/devicetree/bindings/pci/microchip,pcie-host.yaml
+++ b/Documentation/devicetree/bindings/pci/microchip,pcie-host.yaml
@@ -71,7 +71,7 @@ properties:
   msi-parent:
     description: MSI controller the device is capable of using.
 
-  interrupt-controller:
+  legacy-interrupt-controller:
     type: object
     properties:
       '#address-cells':
@@ -125,7 +125,7 @@ examples:
                     msi-controller;
                     bus-range = <0x00 0x7f>;
                     ranges = <0x03000000 0x0 0x78000000 0x0 0x78000000 0x0 0x04000000>;
-                    pcie_intc0: interrupt-controller {
+                    pcie_intc0: legacy-interrupt-controller {
                         #address-cells = <0>;
                         #interrupt-cells = <1>;
                         interrupt-controller;
-- 
2.37.1

