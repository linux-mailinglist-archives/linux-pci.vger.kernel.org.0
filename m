Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3005347357B
	for <lists+linux-pci@lfdr.de>; Mon, 13 Dec 2021 21:00:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242718AbhLMUAR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Dec 2021 15:00:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242740AbhLMUAP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 13 Dec 2021 15:00:15 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2679C0613F8;
        Mon, 13 Dec 2021 12:00:14 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id l10so4529235pgm.7;
        Mon, 13 Dec 2021 12:00:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gJQK36BD9v6i9FoL2nXzpTZoKDQwTZYXnXaGqRHg6E8=;
        b=K0OG6uTL6De5VzSzRtrpbp/M1UzPrJprFbWePRrOJ1PSVM4WDt66GqHE++pSszJEVD
         zL+B+DWrvfYdqd6Dgo0hWmoEiDw+lb/v4OENI9ZGOceohei/86lfUEgFuFyJRB/24cEW
         SmbBvZnDr7pIsXBJyjPhoYGo+B+srJ4/uRC9h4Q4J0xdfOED8lUCS42NJfxIM0w4Kwxd
         v5tHzYCRoOXcFt+orAinFtJfrAswLQdXH/UcmBtHcJZQ7MtnvzMrdutvOz4PRFyBn1z8
         35MfmUhwQFuNEWDHQLYEaPqVULDqg7D7RizAF7O+smPNjVP/fm/meJVU7yuhQC7Ce96f
         J4nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gJQK36BD9v6i9FoL2nXzpTZoKDQwTZYXnXaGqRHg6E8=;
        b=WKbitWuvz4zMJ/WNQAclZSZB4qKc+K2j8WkDWZisTcv2ayg8UEE3NBW8bbu4RVvRQN
         Fq5SLE8Bo1GbfQm8LhBVQ42+5pC7W5o63w0T/G3TkWsyUV1DuenBwUZ8mRo63Ju2W+J2
         Y5yW0eMmxidiyxc2dRmNHghkP1PkLFVgpYjeC3YFuLIeNTBOUl0aZlITzCPdszQmib3V
         xQFK7ECEmrFoOjsVvk4QNhDnMbF9rC0CGPPZ8tHIRDaHaC0Ez562QjqibDBkBpie6uM2
         1/PsUV47LVjSXq+7X8zcI83DrfRR5xWgb5H0DOYzrmX6mXiu+A7W1BlyLiMR+OvCYkib
         DDHw==
X-Gm-Message-State: AOAM531R14z2jp96/5+TSuBu/HhmZ6cyIndzMF/WXNilS7a+KnjHAMEJ
        mKPqD6Umz/b62O+J1zU7VVxdoMoiYo4=
X-Google-Smtp-Source: ABdhPJx53bDjC+FMM1LdETs/pbj3ZJHVG6bGsfbFWXPp/cSMivgOt3juMzdxKIxIuMzd/WgcG4Jbeg==
X-Received: by 2002:a05:6a00:b49:b0:49f:cc01:10ff with SMTP id p9-20020a056a000b4900b0049fcc0110ffmr338110pfo.42.1639425613987;
        Mon, 13 Dec 2021 12:00:13 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id z14sm13926195pfh.60.2021.12.13.12.00.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Dec 2021 12:00:13 -0800 (PST)
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
Subject: [PATCH 2/6] ARM: dts: Cygnus: Update PCIe PHY node unit name(s)
Date:   Mon, 13 Dec 2021 11:02:17 -0800
Message-Id: <20211213190221.355678-3-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211213190221.355678-1-f.fainelli@gmail.com>
References: <20211213190221.355678-1-f.fainelli@gmail.com>
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

