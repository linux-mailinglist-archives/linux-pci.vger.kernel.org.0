Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1094E470B5F
	for <lists+linux-pci@lfdr.de>; Fri, 10 Dec 2021 21:05:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234468AbhLJUIf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Dec 2021 15:08:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234470AbhLJUIe (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 10 Dec 2021 15:08:34 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64206C061746;
        Fri, 10 Dec 2021 12:04:59 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id k26so9362207pfp.10;
        Fri, 10 Dec 2021 12:04:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AmoK+hw/VDuDSmUiZvkIrRjThwbV3KHs/0+W71eQGM4=;
        b=Q/0j4b2n1cnd2/EDcxEQl3atzWCUwjieqdansp1ksLFCuLqV8yQTZBiJjvDKr/s0Ql
         gY7WmJhPAs0J8linWOYYi1Z9SOWANqtrHYjBdjJBUIoYgFynx4u7xv8UPTkJ3A1iYNmU
         hMFiV5OPxWRof4QNoIJJNznnNkIzXnpT4KDKsK66fKSiyaVVBLrXvUyeXEFm17By7ZEA
         6/hvlJ5gPl4ZDAz67qVTa1HFx+dFEllbXuMjTJtMM00LCZkUL+o+l0LjdXnfYoZQyTJb
         6aTiNmCp83/YY3L0rA7V7v+S39yaAMpbKfKJZcP2LBJAvwmccRElmKuuJXP1XkVNLTbE
         Flhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AmoK+hw/VDuDSmUiZvkIrRjThwbV3KHs/0+W71eQGM4=;
        b=rrVIkVzFwj36CFu/qFkS50bq1sTEt41eeqzMXWzQLZbXvYNxu3ZVEssJ9wEfsSu/l4
         hmtxx5r7YgE2SLuDyIhZ3cJ9owlUV94I4KtOrXdd1As6FdrtowjxvJhSb/coohQC3YJO
         YZBQkHwDkNXh2Xw48PAUcXHdVHSgeC6ao5sz0PvGYvkrI/SzDSa556Aytnkwr+c510tr
         eDKGlLm7fnvyhRjhl+pDllnFoixkWhNp+pgSKtcdNlD6CnQpEm8lSPmlhGolPer69rCC
         DB7HJgC4Ct/I3EDBZj0Kx4kHrmg3mm0iQIoefyWrQ8C1H7bknlD3Hz28UQc8ZjQIeCmr
         hpSw==
X-Gm-Message-State: AOAM532qvU82uUyQg+E4C6ir5okJ87Y44JuyKIsVMV3gnyxUAIIVbsXc
        Z4KR4eTxZK1/dV+/k9DSztvTZ2p0TRU=
X-Google-Smtp-Source: ABdhPJwNMMu4Mn5fZltQrNnEW9dBDYATcLWTwW+KuSXrocRqB1yRieox3c1OaUzyYDIPjtc1o6ZVSQ==
X-Received: by 2002:a63:6687:: with SMTP id a129mr39784982pgc.477.1639166698480;
        Fri, 10 Dec 2021 12:04:58 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id g13sm3474463pjc.39.2021.12.10.12.04.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Dec 2021 12:04:57 -0800 (PST)
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
Subject: [PATCH v4 1/6] ARM: dts: Cygnus: Fixed iProc PCIe controller properties
Date:   Fri, 10 Dec 2021 12:04:46 -0800
Message-Id: <20211210200451.3849106-2-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211210200451.3849106-1-f.fainelli@gmail.com>
References: <20211210200451.3849106-1-f.fainelli@gmail.com>
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

