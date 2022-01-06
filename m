Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C5D0486740
	for <lists+linux-pci@lfdr.de>; Thu,  6 Jan 2022 17:03:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240844AbiAFQDu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 6 Jan 2022 11:03:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240884AbiAFQDs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 6 Jan 2022 11:03:48 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A797CC061212;
        Thu,  6 Jan 2022 08:03:48 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id v25so2958747pge.2;
        Thu, 06 Jan 2022 08:03:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5dT86tBwDZRV1+HRjJU72lkLB4v9H+Y+3vey7BiyYNs=;
        b=B+2zGrku2UL9VY7W1qquw6ncR2iOIot+MYbsfHolNha1kVqUqYAPqhEEpjPk5DwZBn
         8tlwoLz62gx+FUSa70lES5zuysTF0m9eSxIlni/uZT3cjsV0I2AO9p2nuJrii0r1hMJQ
         Tb2nrvXp+Di5HGF+xZ8RdJddUChNTM9JwZh6xVL+ZBmILt6KpIQZb+2El3WVAkIkIybZ
         0W/AKeDq3qJpEYA+Ost5t+ktA+e9bMYd/cVtwP20jYALP9Un1bVIpE5o+yRZGxBaUb3H
         uo+/TOQsUsOkXtWMi33RNPsrJvutGNs25L0OgmrPNzp9322KRheF8N7Ct83siFvZ4Uof
         D97g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=5dT86tBwDZRV1+HRjJU72lkLB4v9H+Y+3vey7BiyYNs=;
        b=EyLTr+kb2TPedCSZgf0p+97LBcixEQv0agZ1jlnMBYHekMkSZ5qzOedgpMd+B1LN2u
         GVyQm/JcQiL0HCWyH/ms0k/2QBPuIKlCObVZcvF5YZTJ7QgTSoEkELzsW+TqEOJwbWZa
         72FNRBvn5GJdiVT4mK+QDVDHIKPf/fWV/7DMccoK/VikN7iecZa1fKfzZYD5MuPeTKNF
         glgwLNYmX6d8yI3UFY1B0jVWdM5jy/6iQl7fZxtIMZkKfyPlKw4o9e6v9GhrXhJJNYqG
         tFL9Bx495q5Xt1lneaWU2kcAnPJ2No2WNR6eN1mDtWLVtYTdJrjoXUs0Q+gmfr8JXd1n
         y5gA==
X-Gm-Message-State: AOAM530aYUyCGxLSALpeu1atm8IeOsTbCZbGWwx30l3BjYMIkV5k8TKy
        AzDZDUmPXWLFzF3+R0hEgAS57pgIIUw=
X-Google-Smtp-Source: ABdhPJwkGG8nmAsmSlVxaYf4GZ7GnRNaoH6USwzTvf3wkGhONj9co+WIgJ8Uwa3ot4UKiNlylFhVAw==
X-Received: by 2002:a63:1ca:: with SMTP id 193mr18612679pgb.497.1641485028037;
        Thu, 06 Jan 2022 08:03:48 -0800 (PST)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.11.250])
        by smtp.gmail.com with ESMTPSA id q19sm2376316pgb.77.2022.01.06.08.03.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jan 2022 08:03:47 -0800 (PST)
From:   Jim Quinlan <jim2101024@gmail.com>
To:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
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
Subject: [PATCH v11 3/7] dt-bindings: PCI: Add bindings for Brcmstb EP voltage regulators
Date:   Thu,  6 Jan 2022 11:03:26 -0500
Message-Id: <20220106160332.2143-4-jim2101024@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220106160332.2143-1-jim2101024@gmail.com>
References: <20220106160332.2143-1-jim2101024@gmail.com>
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

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
---
 .../bindings/pci/brcm,stb-pcie.yaml           | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml b/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
index 22f2ef446f18..3e3c8929c97c 100644
--- a/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
@@ -159,5 +159,24 @@ examples:
                                  <0x42000000 0x1 0x80000000 0x3 0x00000000 0x0 0x80000000>;
                     brcm,enable-ssc;
                     brcm,scb-sizes =  <0x0000000080000000 0x0000000080000000>;
+
+                    /* PCIe bridge, Root Port */
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
+                            };
+                    };
             };
     };
-- 
2.17.1

