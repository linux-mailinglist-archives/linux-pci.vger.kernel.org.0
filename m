Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0788E46A4F9
	for <lists+linux-pci@lfdr.de>; Mon,  6 Dec 2021 19:53:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347800AbhLFS4T (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 6 Dec 2021 13:56:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347780AbhLFS4S (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 6 Dec 2021 13:56:18 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B164C061746;
        Mon,  6 Dec 2021 10:52:49 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id h24so8437577pjq.2;
        Mon, 06 Dec 2021 10:52:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Fh6iQu7Naqo1ecQG71P7/0hN4M900Ip7WZ2Cnzd+y5A=;
        b=cgwXwUhK77JLryRHawrkiy3prn6iFO2VZ8UqOyYOY9+V0uOMYxcmitBEh/4ND8qfkx
         ASjC7jExOprIbx4y1QYcY5IhWR8N6jOTJLno6uuGbODNa82P855i5qPpJwKLrk/PCrlO
         o99riJKTyUgLBEvHYpNNMdUR8XNQ905zN18mxGnFOY/wJiIRmrHh+PsXcll0I1988Wx8
         bB+zUgekmJuYR6RnqQBCfm74dO0RQcwz9yuDPh7+YzcZchiZTwbma+cuyte63oV8POJJ
         fuI6nztF3IZ17qjxWUEsNGAmpbE60HghXAsfItF5JsuwCeU/ZjECV8bIghPxTP8Nn6bp
         Zh8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Fh6iQu7Naqo1ecQG71P7/0hN4M900Ip7WZ2Cnzd+y5A=;
        b=zAGzgO0VkNFVoGBpGkSuakot1OT7821WHZ10MbepPm4Pn422RzKNR2iRR4IlZTZEAj
         +RhIgv1d2iiV6M/f4sCYBoxH0PR3zs2aT7hBH64fQpuXWblv4qhYPOjGZPwE2BL1Ks+1
         21smPIbr1pXkJRiN5I7pPLKoIgeYDgrdYhut8t2SUJbSCzSbDWI1AXLJGKkt6XRziJNT
         H+PnMu+48GM3aB9tQZDcrJKr5gwtP6WSnRinN73o8fEmy6HHNUQRfWf4ALVt0lg1cY0q
         4xXxpuZJNCmDaP+I7gKvJQD9ELUTm/89I7Tp8KIChUqYZSZvaC9huZ7n1nS94JOAzuG3
         3rUg==
X-Gm-Message-State: AOAM531QRpk1QrOsRj3rmK4z0E9CXFOyK/3f2GByQPwZ27UaNFitYDmv
        5hFsmyRtafMs6H7UfUeeTtw77DBAIkA=
X-Google-Smtp-Source: ABdhPJxOn7G0JZM2hSYvs6pdIl01zXc5ZHUSGi30M90nHVjLsj3ybrhFDtuz11R3mHn6LhsmybXl2A==
X-Received: by 2002:a17:903:11c4:b0:143:d220:9161 with SMTP id q4-20020a17090311c400b00143d2209161mr45516422plh.2.1638816768734;
        Mon, 06 Dec 2021 10:52:48 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id u22sm14323432pfk.148.2021.12.06.10.52.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Dec 2021 10:52:48 -0800 (PST)
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
Subject: [PATCH v2 3/5] ARM: dts: NSP: Fixed iProc PCIe controller properties
Date:   Mon,  6 Dec 2021 10:52:40 -0800
Message-Id: <20211206185242.2098683-4-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211206185242.2098683-1-f.fainelli@gmail.com>
References: <20211206185242.2098683-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Rename the msi controller unit name to 'msi' to avoid collisions
with the 'msi-controller' boolean property and add the missing
'interrupt-controller' property which is necessary.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/arm/boot/dts/bcm-nsp.dtsi | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/bcm-nsp.dtsi b/arch/arm/boot/dts/bcm-nsp.dtsi
index 1c08daa18858..8c57e904be7b 100644
--- a/arch/arm/boot/dts/bcm-nsp.dtsi
+++ b/arch/arm/boot/dts/bcm-nsp.dtsi
@@ -566,6 +566,7 @@ pcie0: pcie@18012000 {
 		compatible = "brcm,iproc-pcie";
 		reg = <0x18012000 0x1000>;
 
+		interrupt-controller;
 		#interrupt-cells = <1>;
 		interrupt-map-mask = <0 0 0 0>;
 		interrupt-map = <0 0 0 0 &gic GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH>;
@@ -587,7 +588,7 @@ pcie0: pcie@18012000 {
 		status = "disabled";
 
 		msi-parent = <&msi0>;
-		msi0: msi-controller {
+		msi0: msi {
 			compatible = "brcm,iproc-msi";
 			msi-controller;
 			interrupt-parent = <&gic>;
@@ -603,6 +604,7 @@ pcie1: pcie@18013000 {
 		compatible = "brcm,iproc-pcie";
 		reg = <0x18013000 0x1000>;
 
+		interrupt-controller;
 		#interrupt-cells = <1>;
 		interrupt-map-mask = <0 0 0 0>;
 		interrupt-map = <0 0 0 0 &gic GIC_SPI 137 IRQ_TYPE_LEVEL_HIGH>;
@@ -624,7 +626,7 @@ pcie1: pcie@18013000 {
 		status = "disabled";
 
 		msi-parent = <&msi1>;
-		msi1: msi-controller {
+		msi1: msi {
 			compatible = "brcm,iproc-msi";
 			msi-controller;
 			interrupt-parent = <&gic>;
@@ -640,6 +642,7 @@ pcie2: pcie@18014000 {
 		compatible = "brcm,iproc-pcie";
 		reg = <0x18014000 0x1000>;
 
+		interrupt-controller;
 		#interrupt-cells = <1>;
 		interrupt-map-mask = <0 0 0 0>;
 		interrupt-map = <0 0 0 0 &gic GIC_SPI 143 IRQ_TYPE_LEVEL_HIGH>;
@@ -661,7 +664,7 @@ pcie2: pcie@18014000 {
 		status = "disabled";
 
 		msi-parent = <&msi2>;
-		msi2: msi-controller {
+		msi2: msi {
 			compatible = "brcm,iproc-msi";
 			msi-controller;
 			interrupt-parent = <&gic>;
-- 
2.25.1

