Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 180B546CBE8
	for <lists+linux-pci@lfdr.de>; Wed,  8 Dec 2021 05:04:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244087AbhLHEIQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 7 Dec 2021 23:08:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244092AbhLHEIP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 7 Dec 2021 23:08:15 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC764C061574;
        Tue,  7 Dec 2021 20:04:43 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id z6so695997plk.6;
        Tue, 07 Dec 2021 20:04:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6PtQ+iCOtg8wKI/383IxFyqZ9i0rudNbH4n4NHCffbA=;
        b=hiBHP3RLA2HLAaYLJqIfsdqkg/LQ3RY9Gjy0+4n0PnQsg6ccgRNSmdzhVtUDqSZ8kd
         QqMiTvwyURKDFr/t4rWZxhVPA4nVVwq5PxEpIf77EFetpEx6ATh2mwNSY80dNT0GRefP
         1A3V36zjGo4/QsjmRsYxC67yK1sk6S68DFiRJja4niRFx48BcMSKe+eYNx+K1PRrsIhW
         GUmrWNALFT6ktpZX+noXJxa8u77g1ajAoXVlFJLD8/lFJB8Csn+iz19Gn6Grti4tvvYH
         zVF4MAUAwRsimQxpIQc5T1AVEo3T0NxYmaDRPla3kUh8njqr7mCNowFK9kmxE806Zb7B
         YZNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6PtQ+iCOtg8wKI/383IxFyqZ9i0rudNbH4n4NHCffbA=;
        b=GQs5WSl5/SNoUngYM93HxuFnz/2TEeTo2zBxP2Q6ANsOu8Szw/27KuNOtA00Np7RkV
         AVbxhlypsRHQIXvllUYGw+m5iOpVyBMgtDCTFc818lKezyzmMYILLJ+2i9c7xEJZZbja
         /H9uXZVugCf2jJVuc7mjbetmS//Juf57g/+mlgCmO/GhiYjy7QigAFtZA9AyHyn0VD16
         RWJNZ4m5LT564grHSjc2MW7NUZiextzpHvAffPDfswrlra5SikpyBAkuapoG1FignQ+R
         k5yuQ0CwtGHFghSB7BsUYA80KqiB9kyV/lmh7KsQYNXl40x111iGoktGBUiQCm+AdMb6
         ukRw==
X-Gm-Message-State: AOAM530o9pOxkabdQQPdNznm+yqOIrY6jW8mQemdtBgwKX89AVxrYGuD
        lvD3+zjn+R9HUDSE6EKhfpa0f3s16JI=
X-Google-Smtp-Source: ABdhPJxmAPfb0esNolnSCnGT4tzw+ApkU7E/3KxYmMLFUg/Cq7uItECQ35tWeSoqBDIDX/2iXQRRoA==
X-Received: by 2002:a17:90b:4b03:: with SMTP id lx3mr4182432pjb.18.1638936283046;
        Tue, 07 Dec 2021 20:04:43 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id c18sm1320684pfl.201.2021.12.07.20.04.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Dec 2021 20:04:42 -0800 (PST)
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
Subject: [PATCH v3 4/6] ARM: dts: NSP: Fixed iProc PCIe MSI sub-node
Date:   Tue,  7 Dec 2021 20:04:30 -0800
Message-Id: <20211208040432.3658355-5-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211208040432.3658355-1-f.fainelli@gmail.com>
References: <20211208040432.3658355-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Rename the msi controller unit name to 'msi' to avoid collisions with
the 'msi-controller' boolean property.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/arm/boot/dts/bcm-nsp.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/bcm-nsp.dtsi b/arch/arm/boot/dts/bcm-nsp.dtsi
index 1c08daa18858..f242763c3bde 100644
--- a/arch/arm/boot/dts/bcm-nsp.dtsi
+++ b/arch/arm/boot/dts/bcm-nsp.dtsi
@@ -587,7 +587,7 @@ pcie0: pcie@18012000 {
 		status = "disabled";
 
 		msi-parent = <&msi0>;
-		msi0: msi-controller {
+		msi0: msi {
 			compatible = "brcm,iproc-msi";
 			msi-controller;
 			interrupt-parent = <&gic>;
@@ -624,7 +624,7 @@ pcie1: pcie@18013000 {
 		status = "disabled";
 
 		msi-parent = <&msi1>;
-		msi1: msi-controller {
+		msi1: msi {
 			compatible = "brcm,iproc-msi";
 			msi-controller;
 			interrupt-parent = <&gic>;
@@ -661,7 +661,7 @@ pcie2: pcie@18014000 {
 		status = "disabled";
 
 		msi-parent = <&msi2>;
-		msi2: msi-controller {
+		msi2: msi {
 			compatible = "brcm,iproc-msi";
 			msi-controller;
 			interrupt-parent = <&gic>;
-- 
2.25.1

