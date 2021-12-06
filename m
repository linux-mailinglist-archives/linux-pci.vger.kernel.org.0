Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DE6E46A4F5
	for <lists+linux-pci@lfdr.de>; Mon,  6 Dec 2021 19:52:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347708AbhLFS4R (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 6 Dec 2021 13:56:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347703AbhLFS4Q (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 6 Dec 2021 13:56:16 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7596AC061746;
        Mon,  6 Dec 2021 10:52:47 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id s137so11353589pgs.5;
        Mon, 06 Dec 2021 10:52:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qfMnWEkKpTQ6QyzDA+87Y6nTeMiakHXXBU0v7/zR+po=;
        b=lwQlBT2XtdjkhFGq110xFLLSv3rFV4syG4DdRKsnpE5CleEIZyr3U9GsSgAHjSh3j0
         XpQN9s6pDc3+vQb+RcIBRbb+I2pdQ3mSNndV+jhKYeYQS0Q7+3YKAbrBltG7wu3Inzqs
         RCPRPNL24nKy/lzDxp+z12Y5Ney0viFenXIr0zxXI1wcMv9l17NJ/sFXk6t20qot3kOe
         AQjC09i1STzrGR3Mx+FcJYyr/IUkwIlUrZjWdjfd5qHXtn04aJFjXMZ8T8WqRRvAnV0U
         5WMBZv4ACAT69I9QWcq6DaRxHiDMWiWBhXxxCpaT593hlej0vAVn3heDQ5gFcb3Jij8d
         JaoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qfMnWEkKpTQ6QyzDA+87Y6nTeMiakHXXBU0v7/zR+po=;
        b=QLNssARhEhZ48TcpBvreTqYXHUjc89+3EKQ5vA1Pip9wVtgE8VkIayRO4pSdlKACY9
         6qROvFaeXNN1ok0TVPekShf+QqJb82SUw0BORZvaOgTpMwOFaeebfyN/19+xelYc0Y65
         DrDDJdnwwb5rJV4AXw0tdlh2eHaUeK8zHurEc4g+6KmYbd/HI4RJytN8uBLlblF6ET85
         +m5BKmitsO++WRUdHCFmidd++x2VHgxLwFEFYmwg+P371MAiBaOTkxbymb/O1z5PsbpQ
         BArUIfocLVmQDtZKXya0Jxkw6RWVpqHS8/FnEBEnj2QtZcStmpOiVCRdE70OWkVLnmvh
         s/FA==
X-Gm-Message-State: AOAM531KbS1x736GkCcOe4OIXtfOBEsM0XfAa/rDNrvWCw0EdB3xzQG1
        kelGL10qnw34/EkW9lEJD/CD7FdJpNw=
X-Google-Smtp-Source: ABdhPJzNLAa8kejzkcnP0+SD2XTXkPG6nhL2CuDsHdSdTXYFslofUOTdXcjDxHX0SYDhDZnFBglM7w==
X-Received: by 2002:a63:540c:: with SMTP id i12mr2313489pgb.244.1638816766473;
        Mon, 06 Dec 2021 10:52:46 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id u22sm14323432pfk.148.2021.12.06.10.52.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Dec 2021 10:52:45 -0800 (PST)
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
Subject: [PATCH v2 1/5] ARM: dts: Cygnus: Fixed iProc PCIe controller properties
Date:   Mon,  6 Dec 2021 10:52:38 -0800
Message-Id: <20211206185242.2098683-2-f.fainelli@gmail.com>
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
'interrupt-controller' property which is necessary. We also need to
re-arrange the 'ranges' property to show the two cells as being separate
instead of combined since the DT checker is not able to differentiate
otherwise.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/arm/boot/dts/bcm-cygnus.dtsi | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/bcm-cygnus.dtsi b/arch/arm/boot/dts/bcm-cygnus.dtsi
index 8ecb7861ce10..ea19d1b56400 100644
--- a/arch/arm/boot/dts/bcm-cygnus.dtsi
+++ b/arch/arm/boot/dts/bcm-cygnus.dtsi
@@ -263,6 +263,7 @@ pcie0: pcie@18012000 {
 			compatible = "brcm,iproc-pcie";
 			reg = <0x18012000 0x1000>;
 
+			interrupt-controller;
 			#interrupt-cells = <1>;
 			interrupt-map-mask = <0 0 0 0>;
 			interrupt-map = <0 0 0 0 &gic GIC_SPI 100 IRQ_TYPE_LEVEL_HIGH>;
@@ -274,8 +275,8 @@ pcie0: pcie@18012000 {
 			#address-cells = <3>;
 			#size-cells = <2>;
 			device_type = "pci";
-			ranges = <0x81000000 0 0	  0x28000000 0 0x00010000
-				  0x82000000 0 0x20000000 0x20000000 0 0x04000000>;
+			ranges = <0x81000000 0 0	  0x28000000 0 0x00010000>,
+				 <0x82000000 0 0x20000000 0x20000000 0 0x04000000>;
 
 			phys = <&pcie0_phy>;
 			phy-names = "pcie-phy";
@@ -283,7 +284,7 @@ pcie0: pcie@18012000 {
 			status = "disabled";
 
 			msi-parent = <&msi0>;
-			msi0: msi-controller {
+			msi0: msi {
 				compatible = "brcm,iproc-msi";
 				msi-controller;
 				interrupt-parent = <&gic>;
@@ -298,6 +299,7 @@ pcie1: pcie@18013000 {
 			compatible = "brcm,iproc-pcie";
 			reg = <0x18013000 0x1000>;
 
+			interrupt-controller;
 			#interrupt-cells = <1>;
 			interrupt-map-mask = <0 0 0 0>;
 			interrupt-map = <0 0 0 0 &gic GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>;
@@ -309,8 +311,8 @@ pcie1: pcie@18013000 {
 			#address-cells = <3>;
 			#size-cells = <2>;
 			device_type = "pci";
-			ranges = <0x81000000 0 0	  0x48000000 0 0x00010000
-				  0x82000000 0 0x40000000 0x40000000 0 0x04000000>;
+			ranges = <0x81000000 0 0	  0x48000000 0 0x00010000>,
+				 <0x82000000 0 0x40000000 0x40000000 0 0x04000000>;
 
 			phys = <&pcie1_phy>;
 			phy-names = "pcie-phy";
@@ -318,7 +320,7 @@ pcie1: pcie@18013000 {
 			status = "disabled";
 
 			msi-parent = <&msi1>;
-			msi1: msi-controller {
+			msi1: msi {
 				compatible = "brcm,iproc-msi";
 				msi-controller;
 				interrupt-parent = <&gic>;
-- 
2.25.1

