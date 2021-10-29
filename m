Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF8BF4403B5
	for <lists+linux-pci@lfdr.de>; Fri, 29 Oct 2021 22:03:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231144AbhJ2UGB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 29 Oct 2021 16:06:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230397AbhJ2UF7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 29 Oct 2021 16:05:59 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3EB6C061714;
        Fri, 29 Oct 2021 13:03:29 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id x7so5190782pfh.7;
        Fri, 29 Oct 2021 13:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=i/xlFeFGzhcgynIWoi7Dy7maGf++a2Lj0CJo9lD52eo=;
        b=GepHwVrZxe/sGAtgAU8y/aOWlfk5bidJZKMNnGKBvVhd1O0yS5ZYRsSnZs5PEupDOD
         XFh/8vpZICKn/+OD5sx6PcsEwM5EtZMdAmFgLVXQIfIIIhLe2ht3JKiXYzTcXov15tDs
         04O+okmaQnyLH8PY/fX8La0HKBwZD62f2HF+uCsCUifL3BNyYDPOqsojH1eJB3xniGA7
         SYpp7Jr/sq+NP1YoXCG7I+/fSy0jhpbjYOALDDOqlzO8TPFTOojDFoiI00a6WzyWLDyT
         YKa6eyT6ypCyuDBG7ZzQ9JBZhs07SOMpMrw4L/XiweSpu1zZeSMCUsD98qsUZFPe/UiT
         qZzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=i/xlFeFGzhcgynIWoi7Dy7maGf++a2Lj0CJo9lD52eo=;
        b=PCv1EU+dyYkzfsRrM3DMLUPbBAzhRI994X46OcPzWlqEb23rhwaHZvp3KbdgO/t/GW
         qkT23tAvv6Lf0abYAb/uSUxrM8QhafAMmR4I4RCJC4wITIlit0IxQDeJz2XELlIgIBtL
         wgeqhxMBBgILOxyAIxrReoEJY+0CrgMon4KDmwapaVfL6gvBLSdMKlpn2ssm3YoOumFB
         /aO9UTpRs+M7arx8Y9nGsYZEQX2JamL1T8Fn8YkJ96yknngEALeFL8/fDNq6SxXCOkMr
         ogVG1SNGw23P7ubuCj4cfuxLA/4TxPFnZSUUYylDuS4L0ONJ0DKrc7f6FCx9VIrfft/F
         ao+Q==
X-Gm-Message-State: AOAM532ODlkt7lOn3WiEmwEhi7Y1rFQTgaZzbegmxH8GLb9KXJmCrm+V
        coBnu/3vs1vN1OAtT5i5GWCIOsrnSrSPlw==
X-Google-Smtp-Source: ABdhPJwvZSqQE/QbehqXCsHdQjyZTJdGYntsE57MxjyPpWUTC+sJLUK5O246dAdal1NwP+lGT+k1Hw==
X-Received: by 2002:a62:754a:0:b0:47c:36b0:652 with SMTP id q71-20020a62754a000000b0047c36b00652mr12805931pfc.1.1635537809046;
        Fri, 29 Oct 2021 13:03:29 -0700 (PDT)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.11.250])
        by smtp.gmail.com with ESMTPSA id j16sm8775041pfj.16.2021.10.29.13.03.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Oct 2021 13:03:28 -0700 (PDT)
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
Subject: [PATCH v6 2/9] dt-bindings: PCI: Add bindings for Brcmstb EP voltage regulators
Date:   Fri, 29 Oct 2021 16:03:10 -0400
Message-Id: <20211029200319.23475-3-jim2101024@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211029200319.23475-1-jim2101024@gmail.com>
References: <20211029200319.23475-1-jim2101024@gmail.com>
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
 .../bindings/pci/brcm,stb-pcie.yaml           | 27 +++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml b/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
index 508e5dce1282..d90d867deb5c 100644
--- a/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
@@ -62,6 +62,10 @@ properties:
 
   aspm-no-l0s: true
 
+  vpcie12v-supply: true
+  vpcie3v3-supply: true
+  vpcie3v3aux-supply: true
+
   brcm,scb-sizes:
     description: u64 giving the 64bit PCIe memory
       viewport size of a memory controller.  There may be up to
@@ -158,5 +162,28 @@ examples:
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
+                            ranges;
+
+                            /* PCIe endpoint */
+                            pci-ep@0,0 {
+                                    assigned-addresses =
+                                        <0x82010000 0x0 0xf8000000 0x6 0x00000000 0x0 0x2000>;
+                                    reg = <0x0 0x0 0x0 0x0 0x0>;
+                                    compatible = "pci14e4,1688";
+                                    vpcie3v3-supply = <&vreg7>;
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

