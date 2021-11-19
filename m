Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CB7045787D
	for <lists+linux-pci@lfdr.de>; Fri, 19 Nov 2021 23:08:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234457AbhKSWLO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 19 Nov 2021 17:11:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234391AbhKSWLM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 19 Nov 2021 17:11:12 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B8BBC061574;
        Fri, 19 Nov 2021 14:08:09 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id q17so9136384plr.11;
        Fri, 19 Nov 2021 14:08:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7FMM33BgaDXx9wEJ77VEFyRdRiWrhK4qqNx3A3Rw4xQ=;
        b=qouy1VCikNtWXl5c1BkmoZhh8O9nxnXAYAo5ln/jrgF60O/mra9X8rvx2tUVctEWmv
         PZOounY6UlD3r5oI8cj1Vx0Y3DH/vsiWGQMqAqj6Vntbw8XMoz6O8yZuTuSw7+4NrdCJ
         K7IiCD1GW1LdhwUKLBLubhhHkYWGiKaXCUWV2H+qoZN3KeLs+4l/9BCsLL4ivzkrTJYb
         FTeyPzAkBIjj7lJBMfbDUVXM3t4k1vVt2AJpLvG/LuIizF3Rxr7rPr2MUEUQATscAy96
         WQ1SysjIFPoGuXf3Z01VNdAzb5Mxw2ckdh4aol+nnlqf99QB3klXw7HPgl3OIKRKyaeJ
         CaYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7FMM33BgaDXx9wEJ77VEFyRdRiWrhK4qqNx3A3Rw4xQ=;
        b=fMMJcI9B2cmb3aFhX1mUGVcKwsbT4gE/FkwiWxrI/cfo9h/AB7jHcOX4Y/C0r3s+WK
         8m4FpUu16mnsdV0oIm89GyESy3oJ3pbdMNF/Xvb/r9LwSu/37HR7WWv3MF9EG5LXwwlD
         ovCjYss/HUNsrqGC1fveZGg1cn+gDzVEE40ygTB6pBLYqinCKHcNpRsRQu0lVGSpyZzm
         lp1jC4Ky9Ftktqfe3E7ySPEHIqjHF56nuxJt7GRW19vWGgmf7QvCY/Adfv8FJ2ZtbkVI
         UZwS07ACbH0HHkQt5l9vctNQY+lCAg5kbmByO1qL1xAoiQ9CUJ+nWReuV/UPmv7ovpx6
         q4sQ==
X-Gm-Message-State: AOAM533GuMetfhLMMzTdX7TS2ndeFEBuWZcMd1YF9LuA6yZgj+TfNIzX
        wPA/koXcCyUvPy24Xhb0y/8Wml4uTueAOQ==
X-Google-Smtp-Source: ABdhPJxFy5pQVWOP/nGjpyJRTiOKzysS5T0HPsFOfuCrJFDcryBFXtNi/7ENHQg15+kOFjv5rHYWtQ==
X-Received: by 2002:a17:902:b20a:b0:143:7add:5ab7 with SMTP id t10-20020a170902b20a00b001437add5ab7mr79967248plr.71.1637359688852;
        Fri, 19 Nov 2021 14:08:08 -0800 (PST)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.11.250])
        by smtp.gmail.com with ESMTPSA id t2sm612940pfd.36.2021.11.19.14.08.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Nov 2021 14:08:07 -0800 (PST)
From:   Jim Quinlan <jim2101024@gmail.com>
To:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Rob Herring <robh@kernel.org>, Mark Brown <broonie@kernel.org>,
        bcm-kernel-feedback-list@broadcom.com, jim2101024@gmail.com,
        james.quinlan@broadcom.com
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Saenz Julienne <nsaenzjulienne@suse.de>,
        linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM BCM7XXX
        ARM ARCHITECTURE),
        linux-rpi-kernel@lists.infradead.org (moderated list:BROADCOM
        BCM2711/BCM2835 ARM ARCHITECTURE),
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v9 3/7] dt-bindings: PCI: Add bindings for Brcmstb EP voltage regulators
Date:   Fri, 19 Nov 2021 17:07:50 -0500
Message-Id: <20211119220756.18628-4-jim2101024@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211119220756.18628-1-jim2101024@gmail.com>
References: <20211119220756.18628-1-jim2101024@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add bindings for Brcmstb EP voltage regulators.  A new mechanism is to be
added to the Linux PCI subsystem that will allocate and turn on/off
regulators.  These are standard regulators -- vpcie12v, vpcie3v3, and
vpcie3v3aux -- placed in the DT in the bridge node under the host bridge
device.

The use of a regulator property in the pcie EP subnode such as
"vpcie12v-supply" depends on a pending pullreq to the pci-bus.yaml
file at

https://github.com/devicetree-org/dt-schema/pull/63

Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
---
 .../bindings/pci/brcm,stb-pcie.yaml           | 23 +++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml b/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
index 22f2ef446f18..7113a7f726e7 100644
--- a/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
@@ -159,5 +159,28 @@ examples:
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

