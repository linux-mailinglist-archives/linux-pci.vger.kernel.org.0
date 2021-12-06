Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78FBF46A4FC
	for <lists+linux-pci@lfdr.de>; Mon,  6 Dec 2021 19:53:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347821AbhLFS4V (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 6 Dec 2021 13:56:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347794AbhLFS4T (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 6 Dec 2021 13:56:19 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7B46C061746;
        Mon,  6 Dec 2021 10:52:50 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id gx15-20020a17090b124f00b001a695f3734aso645744pjb.0;
        Mon, 06 Dec 2021 10:52:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1kNfzxGCClPnpkpcKrueQLAKijX+MF7pULsui0hZ2MI=;
        b=XdJ2/UR+oBQgVKqQmg963h0ZjX4MNojQf9yfB2C7k8gkZrc8z5gI4RFiZjbIYAYShG
         NaDqNaE9RHQ4VXanSs9Rv8bT1BZXgnWBUPC38V3Z1773gu2+RgGBlTmcSdHx6lshyt6L
         7RVpX0i3xitRtex3wljRMr3nSxp7proU0SLtOc117ZngWeJ3sXR6BAKaUuwUFLvJX3RP
         ARi/uz7de9UdN7L0NnNJ0BqoJT24lDIKSjEraT0REa6OTkITniODj4m6BkJwkoM13seD
         fcMW/UXAlZL4Y9zNF1aP5FwJEuGM2Didk7bE8/9/Y0IkovLv0k7f00Ch9zqgDvUADFtn
         fnSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1kNfzxGCClPnpkpcKrueQLAKijX+MF7pULsui0hZ2MI=;
        b=HXNie7zrZiyH1Zv7CsZIoo781J7kjCeLj97D7JsY+mzhhA6SXdjn1vL4FPkAmOZmml
         UBjWf6mQDEFiq7UnPMHlYYLr9yj8qlUWm0rMeik2HXWwVsizPgHo3y8ujtz8eYd+Jbnw
         s0kl4NcHrQ2d+KtTjpDqV0Plfi76e0vREb+jpHuLX2FTE6Ng2Ed9LreAH0ikn7dF71gw
         VwKKnlgPQj3TDP3VWM9chCcLujhUOFT9PAmUDt+FffXPq5+vyw297lOP1T3NWr4gKp58
         hAeR5kLW2n4GxHKMwxZBDrGCzpfrXHH0DT17lf6cA1Aip9p4AqY1xf5DL0UId8sC6FkJ
         gsZQ==
X-Gm-Message-State: AOAM533Ty2WuNK37h59e2Sd++tUANW+JzJ9/cUJ+B2faVYe+CthTyKc2
        3elpHygSZ7s9ecaM+XgLRTUqEunB3LU=
X-Google-Smtp-Source: ABdhPJx2sR7cEAKdjOKkrChXCG/nIkaHE6d2lpyNWLZJGkWcWrvdJcSXZhiLevJll2TFV24bZBtb6A==
X-Received: by 2002:a17:902:c643:b0:141:cf6b:6999 with SMTP id s3-20020a170902c64300b00141cf6b6999mr45772141pls.80.1638816769867;
        Mon, 06 Dec 2021 10:52:49 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id u22sm14323432pfk.148.2021.12.06.10.52.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Dec 2021 10:52:49 -0800 (PST)
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
Subject: [PATCH v2 4/5] arm64: dts: ns2: Add missing interrupt-controller property
Date:   Mon,  6 Dec 2021 10:52:41 -0800
Message-Id: <20211206185242.2098683-5-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211206185242.2098683-1-f.fainelli@gmail.com>
References: <20211206185242.2098683-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add the missing interrupt-controller property to the Northstar 2 iProc
PCIe controller node(s) in preparation for validating the PCIe
controller DT.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/arm64/boot/dts/broadcom/northstar2/ns2.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/broadcom/northstar2/ns2.dtsi b/arch/arm64/boot/dts/broadcom/northstar2/ns2.dtsi
index 2cfeaf3b0a87..0e10d2dd38cf 100644
--- a/arch/arm64/boot/dts/broadcom/northstar2/ns2.dtsi
+++ b/arch/arm64/boot/dts/broadcom/northstar2/ns2.dtsi
@@ -116,6 +116,7 @@ pcie0: pcie@20020000 {
 		reg = <0 0x20020000 0 0x1000>;
 		dma-coherent;
 
+		interrupt-controller;
 		#interrupt-cells = <1>;
 		interrupt-map-mask = <0 0 0 0>;
 		interrupt-map = <0 0 0 0 &gic 0 GIC_SPI 281 IRQ_TYPE_LEVEL_HIGH>;
@@ -147,6 +148,7 @@ pcie4: pcie@50020000 {
 		reg = <0 0x50020000 0 0x1000>;
 		dma-coherent;
 
+		interrupt-controller;
 		#interrupt-cells = <1>;
 		interrupt-map-mask = <0 0 0 0>;
 		interrupt-map = <0 0 0 0 &gic 0 GIC_SPI 305 IRQ_TYPE_LEVEL_HIGH>;
-- 
2.25.1

