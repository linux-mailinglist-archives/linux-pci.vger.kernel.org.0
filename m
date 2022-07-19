Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07F0057A964
	for <lists+linux-pci@lfdr.de>; Tue, 19 Jul 2022 23:51:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239946AbiGSVvC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 19 Jul 2022 17:51:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240662AbiGSVut (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 19 Jul 2022 17:50:49 -0400
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E83563919;
        Tue, 19 Jul 2022 14:50:48 -0700 (PDT)
Received: by mail-io1-f44.google.com with SMTP id n7so12938338ioo.7;
        Tue, 19 Jul 2022 14:50:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gc70hJeeC4K1a4Pl7tIbgu2cZMCaW6mozT61jHtq/W8=;
        b=7Im3jhV2tH4MYapGfPVGZODmOzxVikifAShqy99obO/+slqQPQa8fmeSzqsiQS7Me3
         F8n5xAKfVll0u2JPAcdoyx+8OV48Ia1itgF3wi4NecslASUhu3hb3ZXA1YVJMz6Z1vPB
         aoRoMoWn5eooCYHVNLWwfk6OHMOBxmhjlpbPvzSsJg4S7TjCoT8oq9Z1bnIOj+cO0fsa
         yZaN4BepPap039NhL9e2LSQBZsE2WHeI1YwZhrGmdwfznVFYjkipMyDLrOPyipfK3LnE
         tNh8QHXYbR3wA8PkG249P3isei6y40O64FRuORjEp2CkiZKgiFifSR+6ZWrhmk8gk4ZW
         MZ3A==
X-Gm-Message-State: AJIora+leEC8zN3FvUJ7LFN3YkAocV/EtnkU3ZOiwT+MVPe52IpHo4fj
        8wflDxfzqS+aNyCcaw7xIg==
X-Google-Smtp-Source: AGRyM1vB1qedxrzyJ7eOI2IVp8x9uka7FzHJ8J9G8xA9jnI0//tRCURnZwNNgNmHczWifPRkOylYZg==
X-Received: by 2002:a05:6638:16d4:b0:341:44c4:8191 with SMTP id g20-20020a05663816d400b0034144c48191mr14543773jat.32.1658267446843;
        Tue, 19 Jul 2022 14:50:46 -0700 (PDT)
Received: from xps15.herring.priv ([64.188.179.248])
        by smtp.googlemail.com with ESMTPSA id n3-20020a056638110300b0033efc8857c0sm7087676jal.50.2022.07.19.14.50.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jul 2022 14:50:46 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Richard Zhu <hongxing.zhu@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
Cc:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: PCI: fsl,imx6q-pcie: Add missing type for 'reset-gpio-active-high'
Date:   Tue, 19 Jul 2022 15:50:31 -0600
Message-Id: <20220719215031.1875860-1-robh@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

'reset-gpio-active-high' is missing a type definition and is not a common
property. The type is boolean.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
index 252e5b72aee0..376e739bcad4 100644
--- a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
@@ -144,6 +144,7 @@ properties:
     description: If present then the reset sequence using the GPIO
       specified in the "reset-gpio" property is reversed (H=reset state,
       L=operation state) (optional required).
+    type: boolean
 
   vpcie-supply:
     description: Should specify the regulator in charge of PCIe port power.
-- 
2.34.1

