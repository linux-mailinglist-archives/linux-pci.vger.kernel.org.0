Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FDD344CC61
	for <lists+linux-pci@lfdr.de>; Wed, 10 Nov 2021 23:17:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233750AbhKJWUa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 10 Nov 2021 17:20:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233558AbhKJWUZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 10 Nov 2021 17:20:25 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B961CC061766;
        Wed, 10 Nov 2021 14:15:10 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id y1so4128249plk.10;
        Wed, 10 Nov 2021 14:15:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=XxDFU6zngH2MiSJPUrDOxFHmK942PXrD/2AGczC8Ul8=;
        b=U8PlSZUXO2Nb4DgwDzXO5TM4bgwclJ59oz8A1dNV72ro2GUKVOZamS+TfYHezB0BRI
         lLsDAlIR1FnilVZhJS+/iTxU0OukeihbJETdBWX6hUCaQu1V8mc40VolvrSyA48W+rUo
         6+hT2xHS6T2TCsDVd3r8kyKFTGkWR/V6vxnrjdrI7nPhCgzhP/5e5CpfomOmm4goBIik
         u6VOhjkM2+vgnNLYqef/XjL0cVjCvPwzMB3Kjrg0LXbblonBBFCTHorkf8BNKLQ7P2ub
         Z8/D68ZyWdzwtoEciXUiOudqGCZFQTUluBVdHv/60GjdOppChbBDvJWYVxakr100NC20
         Tv7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=XxDFU6zngH2MiSJPUrDOxFHmK942PXrD/2AGczC8Ul8=;
        b=vxBsrPXtFbpUQI73SKpRIHqEn3auNQho8QT4k2bba0SuIbq4YAZgiJ0k9pll+69UbX
         rn+YEU8mwQQWFZu1ZbqbuUfCAk4R7Ns3iPCcRXqe0LtGaUE7xU94Z6zvP0oMLy/2PxoP
         BNwyb4d4hQMbo8HDOrjIofaRNMRQSFC1ODcxLm/ly5yrSSgd3r1uKnFdelIBLsGmmeux
         PChsGLP+HGde2mVYjUCVVbRgqw5wiK8acXe/OuPNCsF71gNXd8RO83S7zpK27ttzywh6
         kz5zjyv3JXochtc7I/NDWPIVEGtxcVqEpPuf0dCLax9ZElYUSEdQlg9hZPFy1ARD1Kap
         Pe8Q==
X-Gm-Message-State: AOAM53116kpHdjK8g3fF31wpSevLSFVdkiGSzdl8sBNRQDGzRrAfvHaW
        SPG37JDYTysUM8CL/VRbwBDdpbw4Jb5hLQ==
X-Google-Smtp-Source: ABdhPJz69xPfkDk7VZal+/vPVQLGzVtHQBOzwHeh1QSi55XAjMhcdOd99CHjXEDMq8GdsaYaog0big==
X-Received: by 2002:a17:902:7001:b0:141:67d3:adc6 with SMTP id y1-20020a170902700100b0014167d3adc6mr2207600plk.65.1636582510038;
        Wed, 10 Nov 2021 14:15:10 -0800 (PST)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.11.250])
        by smtp.gmail.com with ESMTPSA id q11sm611774pfk.192.2021.11.10.14.15.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Nov 2021 14:15:09 -0800 (PST)
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
Subject: [PATCH v8 3/8] dt-bindings: PCI: Add bindings for Brcmstb EP voltage regulators
Date:   Wed, 10 Nov 2021 17:14:43 -0500
Message-Id: <20211110221456.11977-4-jim2101024@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211110221456.11977-1-jim2101024@gmail.com>
References: <20211110221456.11977-1-jim2101024@gmail.com>
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

