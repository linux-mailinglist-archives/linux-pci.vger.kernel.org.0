Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0116C444895
	for <lists+linux-pci@lfdr.de>; Wed,  3 Nov 2021 19:49:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231380AbhKCSwc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 3 Nov 2021 14:52:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbhKCSw2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 3 Nov 2021 14:52:28 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A5ACC061203;
        Wed,  3 Nov 2021 11:49:51 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id t21so3116697plr.6;
        Wed, 03 Nov 2021 11:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=XxDFU6zngH2MiSJPUrDOxFHmK942PXrD/2AGczC8Ul8=;
        b=pZG5T96zGfFKOpbOk4/fe7AakdF5UfixT2t71nwLmhH5Mx0X+IqI0nA1ljOfxTfLuH
         BplUo3adJ8WAG5PaZT5lVlKfHBk0oQzabZ/g4SUiOYrQPEN7Yo+c1jKM4MamKeiww10n
         DdHaN09TRhET2EMztgaY6Pc8BfS7jpN8wh8MZ7WckLx0UMiW4oSogYTIhpCvJTVR10GZ
         O5OPrMn8nbqKa8rQLbYP1PY+tlfSA4n1Y1ZplmD1zzEtQ1qvgVFHOQF0FOQe9KgyloG6
         HKyl4g8GpreFi6bV8OGgBJbm8QLWoseN5CqHiAlRIuj7VE1tNcjciO2MJrP1cwxz7CxX
         5SVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=XxDFU6zngH2MiSJPUrDOxFHmK942PXrD/2AGczC8Ul8=;
        b=31Tva6kz14KjKbVqxhjQPohEiUph6TMyksfK6poXcNCuLGX6Ad1D0AdTHI/6katVKX
         /XxtDyJUDeXrDFCgIpmwtnT0GB8s6v9LzKfWLWtpFcI522R9phoCMHg5ixa6Hj1BmWiK
         7c7kl7SxVgBdLj1ss384jgcgdgxtzg6zEsASthkNlkjdCBxKBN/TH5n1V8GCCPvSqIMn
         Q1iqntzKkTTVmuUziYtVWu11QHQt47sDywwBZ5wxxTZ8kcP7SDPqztvMUu9EBIhHPbuS
         z0AJ+88SzbmHJkRz1sE2dUe9FW5+7PNPgJ5CvL+LEvrST/qWRZG3crRfARD14L5n5xw4
         2Kkw==
X-Gm-Message-State: AOAM531tzNPgRPV6D4u5kygeTfmPEMUjM48VME0lXY6/2phoDlU8jK6v
        /cG7R4X0habqEcpp82T9p6i84NxXIln/gw==
X-Google-Smtp-Source: ABdhPJwATqSP80m9Am/wm/Wa6I9Nc5RO2ocnh2+BqVcYLRdPASPmpaMTg8hrU7YBav6nVeR3Ynw2qg==
X-Received: by 2002:a17:90b:3802:: with SMTP id mq2mr16547475pjb.213.1635965390969;
        Wed, 03 Nov 2021 11:49:50 -0700 (PDT)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.11.250])
        by smtp.gmail.com with ESMTPSA id j6sm2379065pgq.0.2021.11.03.11.49.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Nov 2021 11:49:50 -0700 (PDT)
From:   Jim Quinlan <jim2101024@gmail.com>
To:     linux-pci@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Rob Herring <robh@kernel.org>, Mark Brown <broonie@kernel.org>,
        bcm-kernel-feedback-list@broadcom.com, jim2101024@gmail.com,
        james.quinlan@broadcom.com
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Saenz Julienne <nsaenzjulienne@suse.de>,
        linux-rpi-kernel@lists.infradead.org (moderated list:BROADCOM
        BCM2711/BCM2835 ARM ARCHITECTURE),
        linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM
        BCM2711/BCM2835 ARM ARCHITECTURE),
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v7 2/7] dt-bindings: PCI: Add bindings for Brcmstb EP voltage regulators
Date:   Wed,  3 Nov 2021 14:49:32 -0400
Message-Id: <20211103184939.45263-3-jim2101024@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211103184939.45263-1-jim2101024@gmail.com>
References: <20211103184939.45263-1-jim2101024@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Similar to the regulator bindings found in "rockchip-pcie-host.txt", this
allows optional regulators to be attached and controlled by the PCIe RC
driver.  That being said, this driver searches in the DT subnode (the EP
node, eg pci-ep@0,0) for the regulator property.

The use of a regulator property in the pcie EP subnode such as
"vpcie12v-supply" depends on a pending pullreq to the pci-bus.yaml
file at

https://github.com/devicetree-org/dt-schema/pull/63

Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
---
 .../bindings/pci/brcm,stb-pcie.yaml           | 23 +++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml b/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
index 508e5dce1282..ef2427320b7d 100644
--- a/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
@@ -158,5 +158,28 @@ examples:
                                  <0x42000000 0x1 0x80000000 0x3 0x00000000 0x0 0x80000000>;
                     brcm,enable-ssc;
                     brcm,scb-sizes =  <0x0000000080000000 0x0000000080000000>;
+
+                    /* PCIe bridge */
+                    pci@0,0 {
+                            #address-cells = <3>;
+                            #size-cells = <2>;
+                            reg = <0x0 0x0 0x0 0x0 0x0>;
+                            compatible = "pciclass,0604";
+                            device_type = "pci";
+                            vpcie3v3-supply = <&vreg7>;
+                            ranges;
+
+                            /* PCIe endpoint */
+                            pci-ep@0,0 {
+                                    assigned-addresses =
+                                        <0x82010000 0x0 0xf8000000 0x6 0x00000000 0x0 0x2000>;
+                                    reg = <0x0 0x0 0x0 0x0 0x0>;
+                                    compatible = "pci14e4,1688";
+                                    #address-cells = <3>;
+                                    #size-cells = <2>;
+
+                                    ranges;
+                            };
+                    };
             };
     };
-- 
2.17.1

