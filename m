Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A04F9466DD0
	for <lists+linux-pci@lfdr.de>; Fri,  3 Dec 2021 00:35:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376284AbhLBXgU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 2 Dec 2021 18:36:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358237AbhLBXgT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 2 Dec 2021 18:36:19 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8018C06174A;
        Thu,  2 Dec 2021 15:32:56 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id u80so1076311pfc.9;
        Thu, 02 Dec 2021 15:32:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qfMnWEkKpTQ6QyzDA+87Y6nTeMiakHXXBU0v7/zR+po=;
        b=O+mn66YAcB+7LtgFahZ1b/UFgirqR/bcBCt0C/OYEFaoAemZMa5R3v0qQjaOTr+Rq5
         vt646or1NexZ8Ll/G6bYRM7dHBdcdK6IQ09JNcHFmAHRpOloDNHcU2kDfhscWTAaxjYf
         R6PZatnWYpSF4nyivMjeMqOaVANZ371P0QkV1LDpp+UKOhYQimDzTqAKxIwSkSq32FVp
         4q53hmf/C1u65pnzuvyBn5AsTfpe4nCKboN0PuuUnc0++04kqQRZ4RHSlasZyeAbKdyH
         AwsQAP+jtgYKSH20DNgT0dGlxbzNLLclJJl55FfSatpEZ8PfobiZVzIMk3R2C9aJDTbv
         pdmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qfMnWEkKpTQ6QyzDA+87Y6nTeMiakHXXBU0v7/zR+po=;
        b=KTR8wMaXO4vpcP3Q81DiYH+y3EFdhgGSgunw1aQzSLrySzOrsoV7kMTf2/Chs8uzNi
         7mE8GDs7Y1cEA5jQ6nF/TMswtCoXdRYYKu3hl3qhRDghNFNgk4tZA73Y35ijR26l1mj3
         TThGzvtDhudcWriICoPDS/cYpnJy9xNq7COeq5tkNG8O6B/DFNO4AMyJIC2cBKYqTCGq
         Ibkzr/Xf+E1mmO1tJONfMQilE+rdc+C99GsnX+Fz6tBgK5la07EoTsIe2ZZpUj7zYVIE
         hx3jArAGN4biCYRzOeLN9ngAzM6pVNGqbqE8pyI5OuwKL5zLF4Q5dgrr/HzWbgwyTle0
         mRPg==
X-Gm-Message-State: AOAM530LqhEK2zAKUDjRB8t+aPX+oJ43oatxM9HCsKoThWMhJSlDxC7M
        s02kSwEDKbAU7m7HQDX9NvNGp+D27zQ=
X-Google-Smtp-Source: ABdhPJy/fi08qdbd1TJnHiUqctywOUkce6UxS6av0xNi0AD4P8x6zFFtnAEZ1c5Ay+eVKsnzxoWdNA==
X-Received: by 2002:a63:4c50:: with SMTP id m16mr1838288pgl.508.1638487975870;
        Thu, 02 Dec 2021 15:32:55 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id j1sm809118pfe.158.2021.12.02.15.32.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Dec 2021 15:32:55 -0800 (PST)
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
Subject: [PATCH 1/5] ARM: dts: Cygnus: Fixed iProc PCIe controller properties
Date:   Thu,  2 Dec 2021 15:32:44 -0800
Message-Id: <20211202233248.1190797-2-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211202233248.1190797-1-f.fainelli@gmail.com>
References: <20211202233248.1190797-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Rename the msi controller unit name to 'msi' to avoid collisions
with the 'msi-controller' boolean property and add the missing
'interrupt-controller' property which is necessary. We also need to
re-arrange the 'ranges' property to show the two cells as being separate
instead of combined since the DT checker is not able to differentiate
otherwise.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/arm/boot/dts/bcm-cygnus.dtsi | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/bcm-cygnus.dtsi b/arch/arm/boot/dts/bcm-cygnus.dtsi
index 8ecb7861ce10..ea19d1b56400 100644
--- a/arch/arm/boot/dts/bcm-cygnus.dtsi
+++ b/arch/arm/boot/dts/bcm-cygnus.dtsi
@@ -263,6 +263,7 @@ pcie0: pcie@18012000 {
 			compatible = "brcm,iproc-pcie";
 			reg = <0x18012000 0x1000>;
 
+			interrupt-controller;
 			#interrupt-cells = <1>;
 			interrupt-map-mask = <0 0 0 0>;
 			interrupt-map = <0 0 0 0 &gic GIC_SPI 100 IRQ_TYPE_LEVEL_HIGH>;
@@ -274,8 +275,8 @@ pcie0: pcie@18012000 {
 			#address-cells = <3>;
 			#size-cells = <2>;
 			device_type = "pci";
-			ranges = <0x81000000 0 0	  0x28000000 0 0x00010000
-				  0x82000000 0 0x20000000 0x20000000 0 0x04000000>;
+			ranges = <0x81000000 0 0	  0x28000000 0 0x00010000>,
+				 <0x82000000 0 0x20000000 0x20000000 0 0x04000000>;
 
 			phys = <&pcie0_phy>;
 			phy-names = "pcie-phy";
@@ -283,7 +284,7 @@ pcie0: pcie@18012000 {
 			status = "disabled";
 
 			msi-parent = <&msi0>;
-			msi0: msi-controller {
+			msi0: msi {
 				compatible = "brcm,iproc-msi";
 				msi-controller;
 				interrupt-parent = <&gic>;
@@ -298,6 +299,7 @@ pcie1: pcie@18013000 {
 			compatible = "brcm,iproc-pcie";
 			reg = <0x18013000 0x1000>;
 
+			interrupt-controller;
 			#interrupt-cells = <1>;
 			interrupt-map-mask = <0 0 0 0>;
 			interrupt-map = <0 0 0 0 &gic GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>;
@@ -309,8 +311,8 @@ pcie1: pcie@18013000 {
 			#address-cells = <3>;
 			#size-cells = <2>;
 			device_type = "pci";
-			ranges = <0x81000000 0 0	  0x48000000 0 0x00010000
-				  0x82000000 0 0x40000000 0x40000000 0 0x04000000>;
+			ranges = <0x81000000 0 0	  0x48000000 0 0x00010000>,
+				 <0x82000000 0 0x40000000 0x40000000 0 0x04000000>;
 
 			phys = <&pcie1_phy>;
 			phy-names = "pcie-phy";
@@ -318,7 +320,7 @@ pcie1: pcie@18013000 {
 			status = "disabled";
 
 			msi-parent = <&msi1>;
-			msi1: msi-controller {
+			msi1: msi {
 				compatible = "brcm,iproc-msi";
 				msi-controller;
 				interrupt-parent = <&gic>;
-- 
2.25.1

