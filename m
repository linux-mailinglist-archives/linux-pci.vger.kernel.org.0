Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98936473581
	for <lists+linux-pci@lfdr.de>; Mon, 13 Dec 2021 21:00:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242723AbhLMUAU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Dec 2021 15:00:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242685AbhLMUAS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 13 Dec 2021 15:00:18 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0830BC061574;
        Mon, 13 Dec 2021 12:00:18 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id a23so10896205pgm.4;
        Mon, 13 Dec 2021 12:00:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6PtQ+iCOtg8wKI/383IxFyqZ9i0rudNbH4n4NHCffbA=;
        b=JnFbMV0LMmXIzckTtX8Obr1ifAqu/wbl1vW2hpL0SUTxv3UBHRr8236i5XnOPF6sPO
         /xmaRwSaP2aPJfKYBB5z/JTz/wGYpZo+F2lgH+ZyruYIa2h2aI+Dote8vgXfSLqjSeaW
         vlhq31tGSbrL2TiIJIL+j52d4lUkYFsfhNaVeCraNz7vYVygddW7/jzYnMOsItfA0pL3
         vT+fiwu1Zm2Zuucf6WkiheiR5CPbkbiEmGoJkeaH7Cj1B6aLIJY0vhlyKTxGVYKwinUo
         ZUuJ1oUlIuIYkeeWVtBKPgGd1kLYOLd9ehD6O2b7a51eU+5vH3pjQYmVSYwfO0vjVdGP
         dWcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6PtQ+iCOtg8wKI/383IxFyqZ9i0rudNbH4n4NHCffbA=;
        b=Bzt3NSWF/wGzMWUTGUCrpfodXA6c4HZQPV8V8QZ6+gBslc60/gPMkba9i40K/atWvM
         gqLfpHvtiacADmXt3F6xU9adv1Oeh1HXioWdChBDYN+IFPeNsOBjWD8NhtQswtPLZtYd
         acc7TNVWP1SWBEblinDn+75n/hlNgBFCxsHMhsCj92HUj8yMzsNMSUrUOmbpL0I1B69V
         vaHESsqfC5/FvVEIMHbIl01jCCBIORivEOCyIDYB7PYrrSmTSDaWI6q3z12S8N3jCy2p
         8NtHaOV6JzykdMgw8KnnaWNhBRxzP/169e2bMo5hzsrVCG9HROKE1dT/Kc/cQxhDO/+u
         v7Ow==
X-Gm-Message-State: AOAM530qZ8KY0nLrb/DuYhABfcuNTwAYKexJ6oqY005R5S3TfBSwcSJf
        KjhPyxJxzvVJmUPco4q+OkcyIi/e3S8=
X-Google-Smtp-Source: ABdhPJynEU9b7rmrBmSOm+qJmtCAtScHQDgPUp9E4j+THkymCTGx2DxOrNX5I8/MSpzs3G6yoamNsA==
X-Received: by 2002:a63:4516:: with SMTP id s22mr564873pga.170.1639425617194;
        Mon, 13 Dec 2021 12:00:17 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id z14sm13926195pfh.60.2021.12.13.12.00.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Dec 2021 12:00:16 -0800 (PST)
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
Subject: [PATCH 4/6] ARM: dts: NSP: Fixed iProc PCIe MSI sub-node
Date:   Mon, 13 Dec 2021 11:02:19 -0800
Message-Id: <20211213190221.355678-5-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211213190221.355678-1-f.fainelli@gmail.com>
References: <20211213190221.355678-1-f.fainelli@gmail.com>
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

