Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB35947357A
	for <lists+linux-pci@lfdr.de>; Mon, 13 Dec 2021 21:00:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242745AbhLMUAQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Dec 2021 15:00:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242723AbhLMUAN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 13 Dec 2021 15:00:13 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E1A0C061751;
        Mon, 13 Dec 2021 12:00:13 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id gx15-20020a17090b124f00b001a695f3734aso14297883pjb.0;
        Mon, 13 Dec 2021 12:00:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AmoK+hw/VDuDSmUiZvkIrRjThwbV3KHs/0+W71eQGM4=;
        b=BfGQkA2MEDqbzbk0LyDZf6AqU+nW9QooJK1Vn/fWMRPRf0z+lSF2Zj/7K1YvIl3Rs2
         IfL5YzBsa/XsKEdtLaZhl/MPj1RJ1yIUwnfXm96wBPhYNan4XSrMVbrPuI9um6wwl7r0
         MV6lQr0nFa5WVhkAxZgzTAp6nOe7/4eN+UVOrI1Jh9HDpXPKhH7Tt2axtp2UI6LS/LQC
         UaXefzUApgvO7IOeUleAgq+0OKoHHelQeG+dnHnEIw0SvcuTDWOp8bikUlQCaz+4BbTs
         sv/7AjjBU7GYhE6ak8xz5OsIDkh0MQEWxlVIf7tQSF94Putdeb5NNwODdZjxTN+XYLiA
         duyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AmoK+hw/VDuDSmUiZvkIrRjThwbV3KHs/0+W71eQGM4=;
        b=3fDrNXNaI+bkhhPhEM+OP9m64nRv/KfaafoZ08XusdsMLbgRV1VBYEWIhLQOhhzqMy
         +szCqxzp7AWKuTQNxBSaCl5UE6tpmC/ZuUOTHwBk2vTPW7liLZLvceaWG1DWYcqLb6C6
         FJ/bKN8nARIlMoGYEpub/LoiFtX0hYmog7chcJidsdsoKEmth+7wv1BI0vDqANmbK41z
         Af/jOnKtRACxAJ8ooPGTpBZpWVh/wVAIG/0qwCYDgZ7yS2mFzEfoguMyH4OQVZ+xDKUN
         hNrFOD23V9PFHBZ4w3bzAHpoNoc5JaaYRghHQ0dSClBMyKsq6rLBUEvVZ4eJ1RaPc8l5
         h/sQ==
X-Gm-Message-State: AOAM5334tqH54b7AfeiYfNlBPieRtpDX33Blukvop/CD94nQ/ZiWCIUm
        ClKBA+8Ucy7yVxcidCNIZLmdd9fBx58=
X-Google-Smtp-Source: ABdhPJxZFbLjSS9SsXbrP9keog8Ej1sYIgPTr25p84FbEJ3zKlMVAz9SF25WhAf316o+myt8MeL5/Q==
X-Received: by 2002:a17:90b:4d08:: with SMTP id mw8mr468152pjb.236.1639425612527;
        Mon, 13 Dec 2021 12:00:12 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id z14sm13926195pfh.60.2021.12.13.12.00.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Dec 2021 12:00:12 -0800 (PST)
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
Subject: [PATCH 1/6] ARM: dts: Cygnus: Fixed iProc PCIe controller properties
Date:   Mon, 13 Dec 2021 11:02:16 -0800
Message-Id: <20211213190221.355678-2-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211213190221.355678-1-f.fainelli@gmail.com>
References: <20211213190221.355678-1-f.fainelli@gmail.com>
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

