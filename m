Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25755466DD5
	for <lists+linux-pci@lfdr.de>; Fri,  3 Dec 2021 00:35:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376571AbhLBXgY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 2 Dec 2021 18:36:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358237AbhLBXgW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 2 Dec 2021 18:36:22 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62A4BC06174A;
        Thu,  2 Dec 2021 15:32:59 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id q17so817469plr.11;
        Thu, 02 Dec 2021 15:32:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Fh6iQu7Naqo1ecQG71P7/0hN4M900Ip7WZ2Cnzd+y5A=;
        b=OlXm9+JtvxqHHwrgZmb3Y4z6XA08r2GhmCsFOrBYisKjsD3vfV1HSXMw+31BV+I0p7
         eof4+Kv4s7C82t3gIpTxT/cb76RnPHgCiVqpNZbQ0B2QmtmieFhYoXKsp3OepOgyjMgM
         tJAS6QXgoGAteRSlxCjuSEQs701S1ht10eBEA1+usPfUv6+7dJKHKSqsJv2hb71u3wcd
         v9TW4qsFQfV4Zgs8w57/9p2ZMIjWuOK115myiAAd4cNwRqgZKQQkCmAi+dB/W9CZ/y0A
         fUqAmxFWW3Qdd4qAE4N1t+fxdD9feSClk67sekcXrExiI5Vm3aD4HhXoPzBxH5kqAUfw
         I3DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Fh6iQu7Naqo1ecQG71P7/0hN4M900Ip7WZ2Cnzd+y5A=;
        b=z0rpfhgaTvEr9S79m9tb4g9kThheUvWinP2F/chzqI67SU8ahafUSDhjX8IqjREIk5
         BL/+PES5c9gha8/2j+GS8cJozHhLNLaIVl5P+703cC5cRjYlnrnL5E5uuBjrJMXmFJ42
         3CizjmWiUjhc6/VdbRHbfpsJPw9yEy3Q6oS3vsm9uFBJSdcABNg9WaNtLufirGcOqszx
         WgF4fJqTzjc/pu9YEISZIfaiVBNtNcgLtYnD5Twy3Z9012xpV5FDzJUgAfuIhQ16z/eQ
         VOrPnnvvOV1Jw732U2GR7Qdncp25gd9RxTZ6oqAq9HKnD2ZRpeLxjTTuHWrjUjMU5hYF
         m2HA==
X-Gm-Message-State: AOAM530d+6UUjlBOquQE+pzcaQUC1i0Kfl7WgY1s+qyNyotgt8ewvI6r
        AqvgXQake35rcbC803OK/5nIkg9T3ck=
X-Google-Smtp-Source: ABdhPJycgCYQWBHeQ91eEWlg8wPzQZeKvxbXgTJIRZHQHNEuFHX4zzTrQFgrkvueY1mlQcj94CqLdQ==
X-Received: by 2002:a17:90b:390a:: with SMTP id ob10mr9593749pjb.216.1638487978567;
        Thu, 02 Dec 2021 15:32:58 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id j1sm809118pfe.158.2021.12.02.15.32.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Dec 2021 15:32:58 -0800 (PST)
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
Subject: [PATCH 3/5] ARM: dts: NSP: Fixed iProc PCIe controller properties
Date:   Thu,  2 Dec 2021 15:32:46 -0800
Message-Id: <20211202233248.1190797-4-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211202233248.1190797-1-f.fainelli@gmail.com>
References: <20211202233248.1190797-1-f.fainelli@gmail.com>
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

