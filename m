Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D638146F5BA
	for <lists+linux-pci@lfdr.de>; Thu,  9 Dec 2021 22:14:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232721AbhLIVRz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 Dec 2021 16:17:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231681AbhLIVRy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 9 Dec 2021 16:17:54 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49370C0617A2;
        Thu,  9 Dec 2021 13:14:20 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id np3so5366691pjb.4;
        Thu, 09 Dec 2021 13:14:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=SdN+YJ62TXrTSxCxmD4U/e88GUhW9Xo7AMa+zjJB9y8=;
        b=CEZjJ6rON2Dxa3ezTLBnLvMR8JtdoIvoXMd6bldW5WACutcqoiVcGHoSrvrq+9u4h/
         7qmo9g7x2ghdZF2IcsOBZvXjyma44FYIVcdfXR82SeNEXVqaNSzkNBSycZ6RznMZu1XW
         gJsfvSpJzUsqqY1TiaIAKSnEtpp9lJGY0Tiiz20PMsXtZMMcvVQ6JJ3Uk7GKyGWVINFF
         ZM9uTpIZFm3izf0KLV7TVfpNc9fNkuCsG+o0SdEa5xqRvtc7NJpdZ3lNSQkJuHhni5yA
         gNzedWwEu1UkpKi9mWsutT5EcyGEGhQAujI/9dkYlJpPvAw5GulJL5PErUSUgE0walqI
         2cwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=SdN+YJ62TXrTSxCxmD4U/e88GUhW9Xo7AMa+zjJB9y8=;
        b=FBbAca7NswvJzYwz6Xr1bV9EJAZyYEk6YW1h6NJQtcwKVRUTWbbTWvw1yJYSMK8RlE
         K4HiwokCEONXwDy0M6qpZg7sRUvZDKo6Ma3mJ0vI8k+Vg2bgrlFyf+fGuIKP11PrTUi2
         Pcc3dg4gHFMfqDLpJv1rHq4G1r/dPFdWoQj0XjfjynzipuQE521cYzL1E9c2O0Z6bGKm
         8HGBEFpd19SKgYWcb+mshYo2TCP99ZaE6IvZsA/mQE5aWmgLZfmd9juqW+uS4vYIUbbh
         oTZ01a88er++J++LXxJ0dfo1r9FUESdARzXj7A51jp1khYfVyDsjYnIbcukpry4cL8mF
         IWZA==
X-Gm-Message-State: AOAM532ZlGFo0m8RNsVtv9mTgVrJb/cO47Z7UPEX3uiYGvggWA5SDUHc
        5KWPFqehs0KTzmN/Eab8t+ebevGs3QI=
X-Google-Smtp-Source: ABdhPJzqVVumJ3K1t4eLgI7bjrMOMjAALVydzHN2xhAvcY7W0nVSPYKGnq9OxqzOvAQMmVZEUhty7Q==
X-Received: by 2002:a17:903:2004:b0:142:6344:2c08 with SMTP id s4-20020a170903200400b0014263442c08mr70192503pla.51.1639084459578;
        Thu, 09 Dec 2021 13:14:19 -0800 (PST)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.11.250])
        by smtp.gmail.com with ESMTPSA id y4sm617800pfi.178.2021.12.09.13.14.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Dec 2021 13:14:19 -0800 (PST)
From:   Jim Quinlan <jim2101024@gmail.com>
To:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Rob Herring <robh@kernel.org>, Mark Brown <broonie@kernel.org>,
        bcm-kernel-feedback-list@broadcom.com, jim2101024@gmail.com,
        james.quinlan@broadcom.com
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Saenz Julienne <nsaenzjulienne@suse.de>,
        linux-rpi-kernel@lists.infradead.org (moderated list:BROADCOM
        BCM2711/BCM2835 ARM ARCHITECTURE),
        linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM
        BCM2711/BCM2835 ARM ARCHITECTURE),
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v10 2/7] dt-bindings: PCI: Correct brcmstb interrupts, interrupt-map.
Date:   Thu,  9 Dec 2021 16:14:00 -0500
Message-Id: <20211209211407.8102-3-jim2101024@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211209211407.8102-1-jim2101024@gmail.com>
References: <20211209211407.8102-1-jim2101024@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The "pcie" and "msi" interrupts were given the same interrupt when they are
actually different.  Interrupt-map only had the INTA entry; the INTB, INTC,
and INTD entries are added.

Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
Acked-by: Florian Fainelli <f.fainelli@gmail.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml b/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
index 1fe102743f82..22f2ef446f18 100644
--- a/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
@@ -143,11 +143,15 @@ examples:
                     #address-cells = <3>;
                     #size-cells = <2>;
                     #interrupt-cells = <1>;
-                    interrupts = <GIC_SPI 148 IRQ_TYPE_LEVEL_HIGH>,
+                    interrupts = <GIC_SPI 147 IRQ_TYPE_LEVEL_HIGH>,
                                  <GIC_SPI 148 IRQ_TYPE_LEVEL_HIGH>;
                     interrupt-names = "pcie", "msi";
                     interrupt-map-mask = <0x0 0x0 0x0 0x7>;
-                    interrupt-map = <0 0 0 1 &gicv2 GIC_SPI 143 IRQ_TYPE_LEVEL_HIGH>;
+                    interrupt-map = <0 0 0 1 &gicv2 GIC_SPI 143 IRQ_TYPE_LEVEL_HIGH
+                                     0 0 0 2 &gicv2 GIC_SPI 144 IRQ_TYPE_LEVEL_HIGH
+                                     0 0 0 3 &gicv2 GIC_SPI 145 IRQ_TYPE_LEVEL_HIGH
+                                     0 0 0 4 &gicv2 GIC_SPI 146 IRQ_TYPE_LEVEL_HIGH>;
+
                     msi-parent = <&pcie0>;
                     msi-controller;
                     ranges = <0x02000000 0x0 0xf8000000 0x6 0x00000000 0x0 0x04000000>;
-- 
2.17.1

