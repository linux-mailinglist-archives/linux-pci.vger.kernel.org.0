Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0904B473BC1
	for <lists+linux-pci@lfdr.de>; Tue, 14 Dec 2021 04:58:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230000AbhLND61 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Dec 2021 22:58:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233473AbhLND61 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 13 Dec 2021 22:58:27 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A89A0C061574;
        Mon, 13 Dec 2021 19:58:26 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id gx15-20020a17090b124f00b001a695f3734aso15087755pjb.0;
        Mon, 13 Dec 2021 19:58:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AmoK+hw/VDuDSmUiZvkIrRjThwbV3KHs/0+W71eQGM4=;
        b=TxWekLjBbatS+wUHawW22nnqVmRfu5EEI2PugrNEoRElgmjBpAyLWzC7EXVsIrlile
         bA1P0iekLCtvm2zN968dsofv7hdkzl9unSFKYYbxH1F39t3gQZJjFZKbY/3STd4p4Yi3
         k6FEjCJL8KIQrIoKSLvRaf7V8H9TXKCM9cLB8ThI0K6dOYASPWzem1mRPQ7MXx1Q582G
         ZBuuhLJebj2/QBR7rFPS80AdWYJADH2gddu/wjI4m30/59EUGfV6Z3FduqWx2Bk+7MKm
         r9W86HwrVBwNWqP6+pzsAHmj0lu3M/6ao4R14ZVq0UjVnB9XEVlnFyv7lAvHpL2Luq3c
         1fWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AmoK+hw/VDuDSmUiZvkIrRjThwbV3KHs/0+W71eQGM4=;
        b=vAmCKYpJrIvIYF0N7PVtrLYk+knFZ1euLoV2tGeFgdvB1NTZWC6MgcRevod4x4xLsp
         rH3PDlHltBx6zHLZUcacFEiTBIgUHVamKPFIZfbsBo1IN0fKNKojhVkHqo3ctkcvqQYJ
         yus2xy+9wJNlsFazgJjjJuu59LNkBelZ6nB95Rm6MLFSlSU1EQdYQHydHGpL+cSbmrCf
         /K0MmTlenxgUKdGOzKeCSPEVLaUfHYNUws6lYjRw/bUACB56DZBYus3lZs+9VGAgiq74
         9liIt3wveJMlBIWVH/L34G7PW56kIteLIPNw0Z74NthlRFXa1zI2f5jDoMs8zhnqDqs5
         n9EQ==
X-Gm-Message-State: AOAM530vQFiBZoFvvdckvp+Im6Yimyy252d6uMYWvdW1k78QxLTMtNJS
        B5gXVBXpcBKDjE3pAZ7mvMtrO1FSdgs=
X-Google-Smtp-Source: ABdhPJwAo5BgBH1aH3aBZfk+YdSV45D+9nWr4FeaLa4KheTbhyw0cJBGMp1PqQBh5lRyRdJJEIning==
X-Received: by 2002:a17:902:d2c3:b0:146:6c28:191e with SMTP id n3-20020a170902d2c300b001466c28191emr2683833plc.7.1639454305876;
        Mon, 13 Dec 2021 19:58:25 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id o17sm11430356pgb.42.2021.12.13.19.58.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Dec 2021 19:58:25 -0800 (PST)
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
Subject: [PATCH v6 1/6] ARM: dts: Cygnus: Fixed iProc PCIe controller properties
Date:   Mon, 13 Dec 2021 19:58:15 -0800
Message-Id: <20211214035820.2984289-2-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211214035820.2984289-1-f.fainelli@gmail.com>
References: <20211214035820.2984289-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Rename the msi controller unit name to 'msi' to avoid collisions with
the 'msi-controller' boolean property. We also need to re-arrange the
'ranges' property to show the two cells as being separate instead of
combined since the DT checker is not able to differentiate otherwise.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/arm/boot/dts/bcm-cygnus.dtsi | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/bcm-cygnus.dtsi b/arch/arm/boot/dts/bcm-cygnus.dtsi
index 8ecb7861ce10..e73a19409d71 100644
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
@@ -309,8 +309,8 @@ pcie1: pcie@18013000 {
 			#address-cells = <3>;
 			#size-cells = <2>;
 			device_type = "pci";
-			ranges = <0x81000000 0 0	  0x48000000 0 0x00010000
-				  0x82000000 0 0x40000000 0x40000000 0 0x04000000>;
+			ranges = <0x81000000 0 0	  0x48000000 0 0x00010000>,
+				 <0x82000000 0 0x40000000 0x40000000 0 0x04000000>;
 
 			phys = <&pcie1_phy>;
 			phy-names = "pcie-phy";
@@ -318,7 +318,7 @@ pcie1: pcie@18013000 {
 			status = "disabled";
 
 			msi-parent = <&msi1>;
-			msi1: msi-controller {
+			msi1: msi {
 				compatible = "brcm,iproc-msi";
 				msi-controller;
 				interrupt-parent = <&gic>;
-- 
2.25.1

