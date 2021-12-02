Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7CF8466DD7
	for <lists+linux-pci@lfdr.de>; Fri,  3 Dec 2021 00:35:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377247AbhLBXgZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 2 Dec 2021 18:36:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377151AbhLBXgX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 2 Dec 2021 18:36:23 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ACFCC06174A;
        Thu,  2 Dec 2021 15:33:00 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id u11so844854plf.3;
        Thu, 02 Dec 2021 15:33:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1kNfzxGCClPnpkpcKrueQLAKijX+MF7pULsui0hZ2MI=;
        b=R1PsNU1iJRJKM4V2GpdeJIki2v+Lxh8raRTN+BrJ5H6o2XMW98nOqyVYmB/u4rJplz
         nio25qTk3FgtlZT13kyfCI41v+V/eQ9W02fZ5fROseRHgtaqRMIBK7o9AmE/kauskQeR
         1+XJ+SQI//ozxmA6DM0rldEJfe0ouT13LIRtUkesHVkibL/HBpuiL8t1S3y/FcPDRxzX
         ilK17J/LDKFqxMD9EQnxvUum2C/q2sz0mQUUpqNlu0WxlOv4hPFfwwoenglbNdiDN9uB
         kB+thxRg392qfLiqCdulzHjLCHkoGV387xX0Xf7/MrgxWsxTnvmJ8KZ63t8/k5v/H0ce
         tWwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1kNfzxGCClPnpkpcKrueQLAKijX+MF7pULsui0hZ2MI=;
        b=4kU3XJ3I4e6069cWl9iNt2zajq93iwtvFlZJU7EyOQwApGGjfEiosLVjSWXjMBrGBD
         YnTGB9n4S6kNqIg06CvsOcyblWNgDN44GQapgN8aMWje01td08BdSWZ+kNAvT2G+Hhbr
         rqlL+WdbJtbGTxoIE4wPoc55Wk3ryDqyXJ13Z9cRJj1fRAN0WU4tv3TijFlW2PMxzNu9
         ZPGtyQQKcV3W5LjzaMBkwpWI3U8ILsxolO4Yyk/rxmQU//HOgPdwnvZvWFWXFEPnvE9Q
         F3iEy/XcKifqKeFJes53Rz0cH2mdwMGNQ6zSi3mORgG9mNAEoQG4QxsCS8IgEtqqHkwn
         ng6w==
X-Gm-Message-State: AOAM532nFQDxwmO+L2eRVkyCQx+/UAgNeo5Rn9KANe/xPIdtbIZIMPTn
        thab2JBfDhyW5qevmeDvmLOgcgWjwkE=
X-Google-Smtp-Source: ABdhPJyCuLxU3VWPAkY85ll/BbOr/ms28vbHeUzuRDEO67RmCna/AuIlUhFHTvBKx7P34FDx714pXA==
X-Received: by 2002:a17:902:e9c6:b0:141:c588:99b2 with SMTP id 6-20020a170902e9c600b00141c58899b2mr18615480plk.63.1638487979729;
        Thu, 02 Dec 2021 15:32:59 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id j1sm809118pfe.158.2021.12.02.15.32.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Dec 2021 15:32:59 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     devicetree@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com (maintainer:BROADCOM IPROC ARM
        ARCHITECTURE),
        linux-pci@vger.kernel.org (open list:PCI SUBSYSTEM),
        linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM IPROC ARM
        ARCHITECTURE), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 4/5] arm64: dts: ns2: Add missing interrupt-controller property
Date:   Thu,  2 Dec 2021 15:32:47 -0800
Message-Id: <20211202233248.1190797-5-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211202233248.1190797-1-f.fainelli@gmail.com>
References: <20211202233248.1190797-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add the missing interrupt-controller property to the Northstar 2 iProc
PCIe controller node(s) in preparation for validating the PCIe
controller DT.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/arm64/boot/dts/broadcom/northstar2/ns2.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/broadcom/northstar2/ns2.dtsi b/arch/arm64/boot/dts/broadcom/northstar2/ns2.dtsi
index 2cfeaf3b0a87..0e10d2dd38cf 100644
--- a/arch/arm64/boot/dts/broadcom/northstar2/ns2.dtsi
+++ b/arch/arm64/boot/dts/broadcom/northstar2/ns2.dtsi
@@ -116,6 +116,7 @@ pcie0: pcie@20020000 {
 		reg = <0 0x20020000 0 0x1000>;
 		dma-coherent;
 
+		interrupt-controller;
 		#interrupt-cells = <1>;
 		interrupt-map-mask = <0 0 0 0>;
 		interrupt-map = <0 0 0 0 &gic 0 GIC_SPI 281 IRQ_TYPE_LEVEL_HIGH>;
@@ -147,6 +148,7 @@ pcie4: pcie@50020000 {
 		reg = <0 0x50020000 0 0x1000>;
 		dma-coherent;
 
+		interrupt-controller;
 		#interrupt-cells = <1>;
 		interrupt-map-mask = <0 0 0 0>;
 		interrupt-map = <0 0 0 0 &gic 0 GIC_SPI 305 IRQ_TYPE_LEVEL_HIGH>;
-- 
2.25.1

