Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6718B46A4F7
	for <lists+linux-pci@lfdr.de>; Mon,  6 Dec 2021 19:52:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347779AbhLFS4S (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 6 Dec 2021 13:56:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347664AbhLFS4R (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 6 Dec 2021 13:56:17 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B35AC0613F8;
        Mon,  6 Dec 2021 10:52:48 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id g18so11029574pfk.5;
        Mon, 06 Dec 2021 10:52:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LnAQBRW/XPFSuQTMYCsaVUHc/hz2Ejomkgj8kU/9KMw=;
        b=AUSyKNocDDhvxw3qgxImNlXZDrs/lOwsmV+mEHz57mXOUlr9iagfHE9ZtjKkGagzg1
         vIJnj0lFdCGjKesfi4X9uL0/Pc/8K0DLgxb6BUBBWOOcZeTpt6oKiRVtQUdvnHlBbufZ
         LKLUGQQXmLwTe/x1jZ/DnUmZFLFgBgziDtJHSttKS2tC8dPrml1AjTvD4y/SUS8WwROq
         OWd2W7PGIr5CgUJDvk1GEqGH5NC5pyX9nf01OhfRkrpoOV6VvfGcX5AfCIyY2v3L7RDh
         KbNQN/+b2BMCMg5rjoBP3OHNwxrH1hO2vaOc/AVVvcF94b0Vbbgi9LdsR+NgRuo52svI
         HIYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LnAQBRW/XPFSuQTMYCsaVUHc/hz2Ejomkgj8kU/9KMw=;
        b=qQsYsq6lGGBEEilUDJQim2sU0m727puV5roK0zaHKUiMa2XOOaD9wCYcLN1591HECs
         dHV6Y3gW00FKFoxfCEliQQtRk6PSvCCWZrT2LCwtPFmklkmimUJkyRJ+LxTovWFOaOeZ
         Oinj60hd0aFHJqhk+ZWHcIjdzN8+1IeHHK4e9Bvr5Fthi6IxKOcz+/5LLth46BJcWkfL
         /WEyiUpBBiCD0YOtMgSuUJL/R+ZsyD35fXxfHdvGWtpxMUlCH3KHkVltcUNuuzNgUCdh
         T94VN0jXmtCjGIDneWgCl3fTItuc8LOOLxVAnB5M9FdJBnRLjt3fU6+eiQYxW0QE6L6j
         rVlg==
X-Gm-Message-State: AOAM5301BOAcpVr+ryIy5LxORlTfGszs8pYrUfXh6nvFjMEyhy70UfOK
        7AmF5oJ9SctXMMdo+WI/5d7qPIrAHbU=
X-Google-Smtp-Source: ABdhPJxk/NqcGi9fD4ygwQLfetE3jtuNqoqktZK3a/RoKr3r0q7PNqpAwS9aFTmp9/uqPw4jBdPdzg==
X-Received: by 2002:a63:f749:: with SMTP id f9mr20041831pgk.330.1638816767624;
        Mon, 06 Dec 2021 10:52:47 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id u22sm14323432pfk.148.2021.12.06.10.52.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Dec 2021 10:52:47 -0800 (PST)
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
Subject: [PATCH v2 2/5] ARM: dts: HR2: Fixed iProc PCIe controller properties
Date:   Mon,  6 Dec 2021 10:52:39 -0800
Message-Id: <20211206185242.2098683-3-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211206185242.2098683-1-f.fainelli@gmail.com>
References: <20211206185242.2098683-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Rename the msi controller unit name to 'msi' to avoid collisions with
the 'msi-controller' boolean property and add the missing
'interrupt-controller' property which is necessary.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/arm/boot/dts/bcm-hr2.dtsi | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/bcm-hr2.dtsi b/arch/arm/boot/dts/bcm-hr2.dtsi
index 84cda16f68a2..bd2f1d04161f 100644
--- a/arch/arm/boot/dts/bcm-hr2.dtsi
+++ b/arch/arm/boot/dts/bcm-hr2.dtsi
@@ -298,6 +298,7 @@ pcie0: pcie@18012000 {
 		compatible = "brcm,iproc-pcie";
 		reg = <0x18012000 0x1000>;
 
+		interrupt-controller;
 		#interrupt-cells = <1>;
 		interrupt-map-mask = <0 0 0 0>;
 		interrupt-map = <0 0 0 0 &gic GIC_SPI 186 IRQ_TYPE_LEVEL_HIGH>;
@@ -318,7 +319,7 @@ pcie0: pcie@18012000 {
 		status = "disabled";
 
 		msi-parent = <&msi0>;
-		msi0: msi-controller {
+		msi0: msi {
 			compatible = "brcm,iproc-msi";
 			msi-controller;
 			interrupt-parent = <&gic>;
@@ -334,6 +335,7 @@ pcie1: pcie@18013000 {
 		compatible = "brcm,iproc-pcie";
 		reg = <0x18013000 0x1000>;
 
+		interrupt-controller;
 		#interrupt-cells = <1>;
 		interrupt-map-mask = <0 0 0 0>;
 		interrupt-map = <0 0 0 0 &gic GIC_SPI 192 IRQ_TYPE_LEVEL_HIGH>;
@@ -354,7 +356,7 @@ pcie1: pcie@18013000 {
 		status = "disabled";
 
 		msi-parent = <&msi1>;
-		msi1: msi-controller {
+		msi1: msi {
 			compatible = "brcm,iproc-msi";
 			msi-controller;
 			interrupt-parent = <&gic>;
-- 
2.25.1

