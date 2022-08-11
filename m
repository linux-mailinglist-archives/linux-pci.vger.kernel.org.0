Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1083A590767
	for <lists+linux-pci@lfdr.de>; Thu, 11 Aug 2022 22:33:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235976AbiHKUd2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 11 Aug 2022 16:33:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235787AbiHKUd0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 11 Aug 2022 16:33:26 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B0299F0FA
        for <linux-pci@vger.kernel.org>; Thu, 11 Aug 2022 13:33:18 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id m17-20020a7bce11000000b003a5bedec07bso1490937wmc.0
        for <linux-pci@vger.kernel.org>; Thu, 11 Aug 2022 13:33:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=conchuod.ie; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=44JZfQo8qBDZMgfCdrZJwZLuiR284QlmRSCfMxTvtpo=;
        b=Rg+2K2aUJR5EC4EzeEhjweVggh3LGAxXDW+n+myh6+YEfAOfixSRbOplNLuQc+hbCh
         k+KeOqNm6R7kogF4zChBu0vPRB6/t4pC7dpmsahLZa0MR1bkVO2XWKiYhLL+J8YqQUDk
         ZtKBGxLruXNAffh3BmuL+H6PQwULOjdofcVTtJDehPnCkEwCuYwFQvxMN+8on0EzLv0W
         8hG4NzCnIC7nauXERnsjmeIsK9LpEBmZMluKZGrodeAYGFQJLpKQqnVMGITSegeShwjt
         CAS9qdr1VnbdcCuBIY3JiurrcquUlr5/UocbOVp2P97KWNRvHxATlrQBQ9jfvz51J/Lu
         zNfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=44JZfQo8qBDZMgfCdrZJwZLuiR284QlmRSCfMxTvtpo=;
        b=yE9gDmIPbOmrPSSHLsvOlWA1mja0AM5yT5SW9fAXM9sRFEP+MxQJD/8FxRIAnA0Yqx
         7s3+SzcOf8t/+AJuUmd5+jVedkWuj2glp1YWnC2iR4/jcZShTwU83yHcjGL1PU/GsAMO
         24xDC7rsBjBTdePyVnUQljxZ3joKZ+y3S1p6dIixsgIhoKmeQXMnGzO5I8jfm9a4mvAZ
         3L39L6jOzeb+7NeaFN/rAvz7aqBPSmN0cOGKiygNcmy09+jNgipEK7385EI4/yfSPhWP
         Cq7TGFcccwx1tArbLS+9qiD3ueE4RolE4DZIW6wAE388HfVSjO4w4yixo/NTyAY8r9f/
         zUXg==
X-Gm-Message-State: ACgBeo0v0INZLrUKNzWnrAR4DbXIDoNlAhmncoKcseTiFTvPWnTBF9Bq
        inx7gKpYlRK/huXNCHPqHuDhhQ==
X-Google-Smtp-Source: AA6agR5N8mHJgZv+snXP8haUdkqppQ+4312cBLsCj598n23ICeGirf1H5+hFJyDA92da/FyY+BkSUQ==
X-Received: by 2002:a05:600c:3845:b0:3a3:19e8:829e with SMTP id s5-20020a05600c384500b003a319e8829emr6647580wmr.11.1660249996798;
        Thu, 11 Aug 2022 13:33:16 -0700 (PDT)
Received: from henark71.. ([109.76.58.63])
        by smtp.gmail.com with ESMTPSA id i12-20020adfefcc000000b0021f1ec8776fsm86643wrp.61.2022.08.11.13.33.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Aug 2022 13:33:16 -0700 (PDT)
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
Subject: [PATCH 1/4] dt-bindings: PCI: fu740-pci: fix missing clock-names
Date:   Thu, 11 Aug 2022 21:33:04 +0100
Message-Id: <20220811203306.179744-2-mail@conchuod.ie>
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

The commit in the fixes tag removed the clock-names property from the
SiFive FU740 PCI Controller dt-binding, but it was already in the dts
for the FU740. dtbs_check was not able to pick up on this at the time
but v2022.08 of dt-schema now can:

arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dtb: pcie@e00000000: Unevaluated properties are not allowed ('clock-names' was unexpected)
        From schema: linux/Documentation/devicetree/bindings/pci/sifive,fu740-pcie.yaml

The Linux driver does not use this property, but outside of the kernel
this property may have users. Re-add the property and its "clocks"
dependency.

Fixes: b92225b034c0 ("dt-bindings: PCI: designware: Fix 'unevaluatedProperties' warnings")
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
I went back and forth on removing the property from the dts, but this
seems like the change that is more conservative..
---
 .../devicetree/bindings/pci/sifive,fu740-pcie.yaml          | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/sifive,fu740-pcie.yaml b/Documentation/devicetree/bindings/pci/sifive,fu740-pcie.yaml
index 195e6afeb169..c7a9a2dc0fa6 100644
--- a/Documentation/devicetree/bindings/pci/sifive,fu740-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/sifive,fu740-pcie.yaml
@@ -51,6 +51,12 @@ properties:
     description: A phandle to the PCIe power up reset line.
     maxItems: 1
 
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    const: pcie_aux
+
   pwren-gpios:
     description: Should specify the GPIO for controlling the PCI bus device power on.
     maxItems: 1
-- 
2.37.1

