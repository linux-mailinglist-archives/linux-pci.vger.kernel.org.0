Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33AE8470B63
	for <lists+linux-pci@lfdr.de>; Fri, 10 Dec 2021 21:05:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235729AbhLJUIj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Dec 2021 15:08:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234979AbhLJUIg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 10 Dec 2021 15:08:36 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34845C061746;
        Fri, 10 Dec 2021 12:05:01 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id z6so6969461plk.6;
        Fri, 10 Dec 2021 12:05:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gJQK36BD9v6i9FoL2nXzpTZoKDQwTZYXnXaGqRHg6E8=;
        b=Ij0uDbl18r6SrV+rjRUqOUIJqz7Q3dFpbxtYBBnvP4T/ysHlVRTxx6O3FfKh8p9WRg
         MngUnoacTdcLU/v1H+/w6ztPhQoFPG5jU/Adtqdp0sceZi9TD46PNFDTkKLADPp4CKwP
         tsFVbSsbo0EIwN6JIY9pySKCOD0yVbDzLzfkVM9eVzA7GAel4BdGa6EXS4X3ubyQEvb+
         Q2EbzeYmjRlOPQtxjMN8ZOhpRQg3iByIa9c1MF2LZWkkiOrYCpsF6fPHFLQNJ0YboRJa
         IDZRBS4jGxlIT/Jb3mJIZ2HPwRNpOfyNToZkpK+WH33EGoylOW33Y5CGYrhmBONpXtM1
         YmRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gJQK36BD9v6i9FoL2nXzpTZoKDQwTZYXnXaGqRHg6E8=;
        b=vIBeHPygVLOFGr8YZVUbu/CwaFr3oBF/7tiSruT2RZY1s2hav9vQ13OondW4Y7Kq+A
         rNjTJ3Q3j+T/mdvKGKYJNfNf8dQ8FLn4tCqSlJ4elY5/WkuK0ydPgO5vrQoZWgAZxHzp
         6dxlwYjRWz8/DfORioSQlBxuZ9j4EYcTTKzW8BTmhaz+BYSVHhuqeYuRRTcUvZLFqM/l
         8C0vN0o/nd4vU3lIHcmca0Ac9aO88cwA5Lyexh/stgJeQ3CQULKdCpGPW/ioKtGvpTE7
         UVfOakY6iSCwRRRYXzyzNa7JRKW4cYJmAKV0KG3jsRFs0HwOyNS7JXV0hfbyOy4yDxgo
         5JNg==
X-Gm-Message-State: AOAM532U2Ckw8j1qGfGs6KFW/7s/LAO7ZcP8bklVA6wbx5VCW9jeB3so
        8E2GW/u1ko5xu74JtlzYHh6uxkaeu88=
X-Google-Smtp-Source: ABdhPJwNsc4rBcK3tDzuApXI8p3EnUS0VPylGdf7J1VkqWysvqc1CietawzK6jNOoXFHds4/+JRFVg==
X-Received: by 2002:a17:90b:3ecd:: with SMTP id rm13mr25925346pjb.157.1639166700116;
        Fri, 10 Dec 2021 12:05:00 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id g13sm3474463pjc.39.2021.12.10.12.04.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Dec 2021 12:04:59 -0800 (PST)
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
Subject: [PATCH v4 2/6] ARM: dts: Cygnus: Update PCIe PHY node unit name(s)
Date:   Fri, 10 Dec 2021 12:04:47 -0800
Message-Id: <20211210200451.3849106-3-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211210200451.3849106-1-f.fainelli@gmail.com>
References: <20211210200451.3849106-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Update the PCIe PHY node unit name and its sub-nodes to help with
upcoming changes converting the Cygnus PCIe PHY DT binding to YAML and
later the iProc PCIe controller binding to YAML.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/arm/boot/dts/bcm-cygnus.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/bcm-cygnus.dtsi b/arch/arm/boot/dts/bcm-cygnus.dtsi
index e73a19409d71..ad65be871938 100644
--- a/arch/arm/boot/dts/bcm-cygnus.dtsi
+++ b/arch/arm/boot/dts/bcm-cygnus.dtsi
@@ -112,18 +112,18 @@ otp: otp@301c800 {
 			status = "disabled";
 		};
 
-		pcie_phy: phy@301d0a0 {
+		pcie_phy: pcie_phy@301d0a0 {
 			compatible = "brcm,cygnus-pcie-phy";
 			reg = <0x0301d0a0 0x14>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 
-			pcie0_phy: phy@0 {
+			pcie0_phy: pcie-phy@0 {
 				reg = <0>;
 				#phy-cells = <0>;
 			};
 
-			pcie1_phy: phy@1 {
+			pcie1_phy: pcie-phy@1 {
 				reg = <1>;
 				#phy-cells = <0>;
 			};
-- 
2.25.1

