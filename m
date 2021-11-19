Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C66C457879
	for <lists+linux-pci@lfdr.de>; Fri, 19 Nov 2021 23:08:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234317AbhKSWLO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 19 Nov 2021 17:11:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234286AbhKSWLI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 19 Nov 2021 17:11:08 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A9A1C061574;
        Fri, 19 Nov 2021 14:08:06 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id 28so9727198pgq.8;
        Fri, 19 Nov 2021 14:08:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=SdN+YJ62TXrTSxCxmD4U/e88GUhW9Xo7AMa+zjJB9y8=;
        b=OXp8MSbilwTmttnGLC/21f13Z6KyQ05Rx6hfbNx0hQlrVzvHAr7HYuQM6ERfKt2RlY
         uO6Qnd1JoKkEpq8OslqJONPW3DNXSM1Jhzp5CgGNEFlwZMCTWCf7FzqSamXk4sIe5Wll
         FuwAip0wibmXE2EleQyzDusP9eHVwzadCE6bm9LhQs82QkMWyS2NZ9b/ByvjZju8jlzW
         xwJCb7Dv9hlasCsLYQCUPmW8YiUogs/GWtQ5//F9o/3suayeJsRmJGAro9h+XwV4aePl
         PfGrtYBjSOaq6h3bDgn4J1HfYJmq6wZBiedugGK++gEOK0siS2e9DBfbE04Kt7SAIzRM
         wi5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=SdN+YJ62TXrTSxCxmD4U/e88GUhW9Xo7AMa+zjJB9y8=;
        b=DI2MUaHegtQ48gMVZHoOpcmpW4LvuTM5E3faD7EiU1QuMxOQeT4NW1TKEyrtywpYJX
         t0zsYJiAJxw83X9u9eByLFcDkHfn+saltMqrkVYednBEA9ZOgX7vUAn6YSLDDx6srrud
         vsSWOLK0LbTiGXYwPeToChc4GCLCoWx7Gy3tTpjlQJ9Ru16DhkYSWGXnDSHUKhRMiy1C
         f1++OLdSJuxZPAM0zjwm7DGfENe/iR2KuDfXpyALif4gZKhgaIo1chZWWi6BPDtWqErs
         dxN7MG7HgibPo5ZRr+27Ig44/29S9NIBS/x7IEFlauSAs6cRu5LsRiOZ8kwiEnZ17GCl
         XsCA==
X-Gm-Message-State: AOAM5318k4Zsr5P0Y8zsU2mPlveY0gAjXEK7rWUM1PrRTc8CusYxQLc2
        FWGvYb+3RctUIuxIAoZORe1zXAXqWnhjPw==
X-Google-Smtp-Source: ABdhPJzH681ogPXuizx1FhR1dB0O3FWsPhf1C1SLgnj8C4S4k5xTzla+QD2tHL+WWWqgejCeApdhHg==
X-Received: by 2002:a05:6a00:10d1:b0:47b:aa9b:1e7a with SMTP id d17-20020a056a0010d100b0047baa9b1e7amr26141445pfu.57.1637359685874;
        Fri, 19 Nov 2021 14:08:05 -0800 (PST)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.11.250])
        by smtp.gmail.com with ESMTPSA id t2sm612940pfd.36.2021.11.19.14.08.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Nov 2021 14:08:05 -0800 (PST)
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
Subject: [PATCH v9 2/7] dt-bindings: PCI: Correct brcmstb interrupts, interrupt-map.
Date:   Fri, 19 Nov 2021 17:07:49 -0500
Message-Id: <20211119220756.18628-3-jim2101024@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211119220756.18628-1-jim2101024@gmail.com>
References: <20211119220756.18628-1-jim2101024@gmail.com>
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

