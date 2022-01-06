Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2F0848673D
	for <lists+linux-pci@lfdr.de>; Thu,  6 Jan 2022 17:03:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240848AbiAFQDq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 6 Jan 2022 11:03:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240865AbiAFQDq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 6 Jan 2022 11:03:46 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B754CC061201;
        Thu,  6 Jan 2022 08:03:45 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id s1so2953463pga.5;
        Thu, 06 Jan 2022 08:03:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=SdN+YJ62TXrTSxCxmD4U/e88GUhW9Xo7AMa+zjJB9y8=;
        b=pZSDNXVBUjpW4Vz+1npVATF5jK5aLGSV9iNcNWEoaO2Vpseob1m0TSu0aY4lU65zQd
         TWg2RMqFpeeIZ+YanrmFW/7Pc0N5uKfPWp7CNOfvXRIHnaijGuxUY5uE2LGJpeLqdllj
         zg1URwv+fmxcMuimypwigGNGBYI+bxVr58RJYs2BKW66X6KsrQn7jr2ikFTwDWFHq5wP
         lJY9e03IE0F1YhrJJ1C6MMRvuvpwNn5i8WYFASOCwZO4cBk0edJ4bCIE8AqzrJptMkpR
         qQyNrMmEgUPwlsGAxsNdiUeLLaI6DsLcvOmCWEnuLbqmAf9YAGx2U+p7fnu1yQMKRU3C
         ieiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=SdN+YJ62TXrTSxCxmD4U/e88GUhW9Xo7AMa+zjJB9y8=;
        b=UP18EoBTBZJWENgAFxhmnE4N59gYeHmUkFW0R815XZ2tgBsfY4KlIjqeYsJCI3uXpE
         Tgdg3+1YpFMvAadJrgtK3M+Hh4rvUhj+DcKV/NHarg5oqD3fevamwltxTRNmiRduSOKY
         S7dTTeYeWgC8Yyrxsysh2pQhfvTwDcPmLT7LcSG18g9DNuhGCOatBO+JBSeBI4Bbk2mH
         v6oBm4dYkJaB3zqhJmYoEFnKW4MECemzTeG3zHjQuoNTe6Z6v6261RVkdEPq3azm3ApU
         7FUeIpZMCfOZMdT/IXqPz0bN+PI6+imzMD02F6DtB5zOi4LXGEjKSjtzbRHxIAwLZnbL
         7WNQ==
X-Gm-Message-State: AOAM530Tx8HZXDYd/Tnz9ngatwDT0necPVzVXfExBT+STBM55N8rajtx
        1aK92zB/jVRFKj0KA8r1JdvMbHD1yqA=
X-Google-Smtp-Source: ABdhPJxMMul3ldncZfyDJ69TT+quVA6wkcOPZWP4sRDEUwiRE92/drHcvZyHGvZQuGQV+BIUK0wOVg==
X-Received: by 2002:a63:7408:: with SMTP id p8mr48886911pgc.73.1641485025029;
        Thu, 06 Jan 2022 08:03:45 -0800 (PST)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.11.250])
        by smtp.gmail.com with ESMTPSA id q19sm2376316pgb.77.2022.01.06.08.03.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jan 2022 08:03:44 -0800 (PST)
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
        linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM BCM7XXX
        ARM ARCHITECTURE),
        linux-rpi-kernel@lists.infradead.org (moderated list:BROADCOM
        BCM2711/BCM2835 ARM ARCHITECTURE),
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v11 2/7] dt-bindings: PCI: Correct brcmstb interrupts, interrupt-map.
Date:   Thu,  6 Jan 2022 11:03:25 -0500
Message-Id: <20220106160332.2143-3-jim2101024@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220106160332.2143-1-jim2101024@gmail.com>
References: <20220106160332.2143-1-jim2101024@gmail.com>
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

