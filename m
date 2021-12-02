Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87427466DD3
	for <lists+linux-pci@lfdr.de>; Fri,  3 Dec 2021 00:35:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376637AbhLBXgX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 2 Dec 2021 18:36:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376374AbhLBXgV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 2 Dec 2021 18:36:21 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40739C06174A;
        Thu,  2 Dec 2021 15:32:58 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id 137so1287597pgg.3;
        Thu, 02 Dec 2021 15:32:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LnAQBRW/XPFSuQTMYCsaVUHc/hz2Ejomkgj8kU/9KMw=;
        b=Xff9rcHAM6k7LbBrQNy7ISlNyMoT4myTbREHD1qm8QfxGkxBSAxoC5y62fWOdmfyeO
         GYZ5IdKeosStMR6shBMskOmdLl/tbs5j7c6DKWB4qg/Qe+BpHezgSO6KMYiP2Bif8rTa
         JOHLe+42sf5MDk3lWl7+h8TTDNUv3pKikpMwaRFfBExXdBK0V1lWKIqVU2aldO66M8qG
         bSn/GdKK/TpLl5vzE5YeLZfothZutJGbav6785iYflc+1T784/qMkjZQmX/OPG06TcKH
         UjyvcQG9iTwcdFIPeEpEciinn6onG0GkH1dgAguB6J1siWIlTxuDoXhD7oD3l3LjQ8Ut
         aXEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LnAQBRW/XPFSuQTMYCsaVUHc/hz2Ejomkgj8kU/9KMw=;
        b=ynMtLI6XGfwTMNr7xuD4Qok/al4o03vtb2fXwM7o189/SIkiIjgrpWi69zM2m4zCiw
         vKjtlvteSh6nVjFzibdrclmMmGoiEwvoyh0oqS3eRokCagmT0sdMW7lchjJz0MjSu78E
         iA/rYgkCp2vFjmixRGCRYfXiTJENQCRZhBvnxrgaWvIfmRiLy7UPBE9whl1mIN1aP3PP
         ilW4qQnISQStQKqq+OB7qoFJaOq2c+06PnLsojAhXDP101LdNnzQ31KIM6LmoKlBtZ3/
         cpIs7pVYwJ9Jmf5h7i2VmBOYcp16x0iynSjdUCO21Vl9bItJRkPjEkRJNCkZXwvLFRDm
         ZIRQ==
X-Gm-Message-State: AOAM533kaykMZwnfjBVbOIwgzmngiSXiE2l6zjy/5vv3zMrZrsb9ZCND
        jmAUE88lkqcvYijUGQGPOX0ggiuFxCI=
X-Google-Smtp-Source: ABdhPJxYc9iQmOwv7JyGntgBnnysJJNKUMj7RhhYtauBNVUFqrD6brr+Cb+whUR6Yq8CQ7qXZfonjg==
X-Received: by 2002:a63:1ca:: with SMTP id 193mr1849594pgb.88.1638487977336;
        Thu, 02 Dec 2021 15:32:57 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id j1sm809118pfe.158.2021.12.02.15.32.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Dec 2021 15:32:56 -0800 (PST)
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
Subject: [PATCH 2/5] ARM: dts: HR2: Fixed iProc PCIe controller properties
Date:   Thu,  2 Dec 2021 15:32:45 -0800
Message-Id: <20211202233248.1190797-3-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211202233248.1190797-1-f.fainelli@gmail.com>
References: <20211202233248.1190797-1-f.fainelli@gmail.com>
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

