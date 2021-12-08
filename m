Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9241346CBE0
	for <lists+linux-pci@lfdr.de>; Wed,  8 Dec 2021 05:04:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232306AbhLHEIL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 7 Dec 2021 23:08:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244077AbhLHEIK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 7 Dec 2021 23:08:10 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75F76C061574;
        Tue,  7 Dec 2021 20:04:39 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id r5so952081pgi.6;
        Tue, 07 Dec 2021 20:04:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4HXxSu2gPMhcps5sa6jyk5e2IIZg5iM9c1rXs+VhM6A=;
        b=iqOfLIN7fCiWY7C+553okIzVz1isalKGAq39L/xo9MHJg+7Xg8sJ3fhzbJUDk62Vzz
         o7VtgLVuunOQl4Yry45IF+HKpQxT6I5YC4yL11OcqS+WsPPzLPNL0NUJ1Rtyv6x92Qsz
         D4pUFl2LL1VRH2sGvlpOaDwTpmeSA+R7bkgSMvbfnYjh3Lv7++CQuI5iymiih8ATJsfN
         8Jk1x2wFbfbSTs9OAITPBbp4zwLznjL5IoXp3WQd2q+Hf/tRIFtIJEKUipPgu1SMc+JH
         WzECqubp33RMJX4Rcas2PCtaDv9HDFT99kYm95XueBT4GGhuFSFhM/tzA+Q6xPTioyXi
         5uDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4HXxSu2gPMhcps5sa6jyk5e2IIZg5iM9c1rXs+VhM6A=;
        b=a5Emq9tNo1pdfVcPtxVa8Ssa9xdtb5hFmWicb9EPFOIgFRCOj13NchkB/tYLjwAyJQ
         c9Bt9ynfFA+ZyTxbGvm7YqR7VN+tJQf3lcZOwTrk/QO1jlLtnS1W5DenMY0VXxVzQe4l
         ViuP29hN7mi5CId8w/6CxffkCbe9K2lwzIoLtYtdxB5/HZedDyfoq4bpkiejwZoWIJJQ
         ugb3Q04OCLH2RNMzRyfqzaRsuZ+MgXknhJEir0lbnKSzyyMWsahUuONZpjn9Se6ioTeK
         kDPhWyV8ZYPvu5wYUW54Git30F/z5IoRArXbrb97r1bWTqwSzkhpU2CJ4PG4rtZ5ihe5
         GgMw==
X-Gm-Message-State: AOAM5328ZfJoEIWHhRSxn6/Jku2k3yWoGj2c2Zceb/kfphXf6CWwN1ze
        O3KXxO5+nCRsVUvW5OMYRV1QfZgNOyQ=
X-Google-Smtp-Source: ABdhPJw3Z63ln1wMYmIq8JnnWDgqOMGmdjyelgUJgU/3ubh8JNENwUyXKiDRafZp+CM5D0lKgBcjxQ==
X-Received: by 2002:a63:85c3:: with SMTP id u186mr27255326pgd.201.1638936278516;
        Tue, 07 Dec 2021 20:04:38 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id c18sm1320684pfl.201.2021.12.07.20.04.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Dec 2021 20:04:38 -0800 (PST)
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
Subject: [PATCH v3 1/6] ARM: dts: Cygnus: Fixed iProc PCIe controller properties
Date:   Tue,  7 Dec 2021 20:04:27 -0800
Message-Id: <20211208040432.3658355-2-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211208040432.3658355-1-f.fainelli@gmail.com>
References: <20211208040432.3658355-1-f.fainelli@gmail.com>
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
 arch/arm/boot/dts/bcm-cygnus.dtsi | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/bcm-cygnus.dtsi b/arch/arm/boot/dts/bcm-cygnus.dtsi
index 8ecb7861ce10..d6e2b2ba3a19 100644
--- a/arch/arm/boot/dts/bcm-cygnus.dtsi
+++ b/arch/arm/boot/dts/bcm-cygnus.dtsi
@@ -274,8 +274,8 @@ pcie0: pcie@18012000 {
 			#address-cells = <3>;
 			#size-cells = <2>;
 			device_type = "pci";
-			ranges = <0x81000000 0 0	  0x28000000 0 0x00010000
-				  0x82000000 0 0x20000000 0x20000000 0 0x04000000>;
+			ranges = <0x81000000 0 0	  0x28000000 0 0x00010000>,
+				 <0x82000000 0 0x20000000 0x20000000 0 0x04000000>;
 
 			phys = <&pcie0_phy>;
 			phy-names = "pcie-phy";
@@ -283,7 +283,7 @@ pcie0: pcie@18012000 {
 			status = "disabled";
 
 			msi-parent = <&msi0>;
-			msi0: msi-controller {
+			msi0: msi {
 				compatible = "brcm,iproc-msi";
 				msi-controller;
 				interrupt-parent = <&gic>;
@@ -298,6 +298,7 @@ pcie1: pcie@18013000 {
 			compatible = "brcm,iproc-pcie";
 			reg = <0x18013000 0x1000>;
 
+			interrupt-controller;
 			#interrupt-cells = <1>;
 			interrupt-map-mask = <0 0 0 0>;
 			interrupt-map = <0 0 0 0 &gic GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>;
@@ -309,8 +310,8 @@ pcie1: pcie@18013000 {
 			#address-cells = <3>;
 			#size-cells = <2>;
 			device_type = "pci";
-			ranges = <0x81000000 0 0	  0x48000000 0 0x00010000
-				  0x82000000 0 0x40000000 0x40000000 0 0x04000000>;
+			ranges = <0x81000000 0 0	  0x48000000 0 0x00010000>,
+				 <0x82000000 0 0x40000000 0x40000000 0 0x04000000>;
 
 			phys = <&pcie1_phy>;
 			phy-names = "pcie-phy";
@@ -318,7 +319,7 @@ pcie1: pcie@18013000 {
 			status = "disabled";
 
 			msi-parent = <&msi1>;
-			msi1: msi-controller {
+			msi1: msi {
 				compatible = "brcm,iproc-msi";
 				msi-controller;
 				interrupt-parent = <&gic>;
-- 
2.25.1

