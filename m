Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7D6946CBE4
	for <lists+linux-pci@lfdr.de>; Wed,  8 Dec 2021 05:04:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244077AbhLHEIN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 7 Dec 2021 23:08:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232257AbhLHEIM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 7 Dec 2021 23:08:12 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1B8FC061756;
        Tue,  7 Dec 2021 20:04:40 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id k4so944719pgb.8;
        Tue, 07 Dec 2021 20:04:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=a9TA9nZ89a//BemP2uNfcdJdyv/5bJCk0Nuq1NhjtJE=;
        b=EdYzLhY2O7I+PIs0LpAAJf/zEUszq2DAtC8dRvwY9yXaOwKKTdeFd8Sf+tbhtD4Nyo
         zVwlHYEjeUohtYuGg0FJMWWpFmKdmfR1EkO9wB66LQ9H5OolGCUHCx2Bi3rePRtMsfC/
         nXjGXOsMrNrlR82VQZgMxgmthlnU9usTR0sXsXhc2TUAO9wDV3qWF/E7MfF2hBx9zU2R
         U5UFp7cVAhSgeKnDXU2yXRryEC7xs4kFGKMOv50s4bDcoK7NY6EPJCbAw6xT4KqSNEbG
         n9Vo6okpuYWlGsNAX6vzFdfC3FIa6Vsm84XdWgvXOkMkaLocoPrOhZfdaqOiso7DKuOl
         UM1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=a9TA9nZ89a//BemP2uNfcdJdyv/5bJCk0Nuq1NhjtJE=;
        b=yfut3hV/OVDVw9TuVmoOqxu+hY/tZx9sYOpTnc3ORJDog5RdOE0dyEOJ4PrhntUtLu
         /t1WYqojbe7Rxe+Ch/DeOag/Rrok+j/OKALAsPhegR2bBO/wNITkeCZ79oCP38gMvHzC
         n9+qciC8URVefUjvK9ENSao1E4UpbAu4n++oYjSRiREl0JsN0FEmiWmemhrTcDH4VVlR
         0eK36FZ8B07rDptnGyD7y59gSzA0wnfhNkYC5/fnj7fwon3S81ZroV4gfnN9Mj3oxWUk
         +HQt41PcSF5/884HU8gX6gNcljZAy/a+qwX2RwadpKGgU3tYSfYdImRZLSuEECrHvdTL
         K4lA==
X-Gm-Message-State: AOAM531mVIU1rsYqMsw04rjeGUNrafo6gbA/9L25My1RovnYYFfooSN4
        6pHuyOmElIUc0UN577PJxcCujF4z2I0=
X-Google-Smtp-Source: ABdhPJzGkKR5b+RzpkMH3/mBvr034Po/exe+doSkL1WfXQ54wpUHZ9xmtBGjRpiG2xFzW/3wCcXZQg==
X-Received: by 2002:a63:150c:: with SMTP id v12mr27426514pgl.442.1638936279988;
        Tue, 07 Dec 2021 20:04:39 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id c18sm1320684pfl.201.2021.12.07.20.04.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Dec 2021 20:04:39 -0800 (PST)
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
Subject: [PATCH v3 2/6] ARM: dts: Cygnus: Update PCIe PHY node unit name(s)
Date:   Tue,  7 Dec 2021 20:04:28 -0800
Message-Id: <20211208040432.3658355-3-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211208040432.3658355-1-f.fainelli@gmail.com>
References: <20211208040432.3658355-1-f.fainelli@gmail.com>
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
index d6e2b2ba3a19..8153b60c87b7 100644
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

