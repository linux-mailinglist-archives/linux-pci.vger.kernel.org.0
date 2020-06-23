Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AA6A205538
	for <lists+linux-pci@lfdr.de>; Tue, 23 Jun 2020 16:55:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732874AbgFWOzj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 23 Jun 2020 10:55:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732738AbgFWOzj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 23 Jun 2020 10:55:39 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9F7EC061573;
        Tue, 23 Jun 2020 07:55:38 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id e15so6199444edr.2;
        Tue, 23 Jun 2020 07:55:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rSShYoiZuyH2JUu2VPJiVE0CBFdCwj/MFQetEFw6dJk=;
        b=jiyFd4W4DRKlvqYwkPpgQ/YkwtO+fIZhekR3JeOrDCN8/Loe2VTtvOpNYa2UZLC4hX
         2/SQnFNAfcGwU4e/pssylpBEi7SaFVqunARH0O1JodnptajCy0Tb+mTdzDwVg8B1DH5Q
         fFbxlqjiD+N1WzQPC/lqiX5PeNF2qUpkAyrXhrUz5Dlxn96XT/HSbwpRw5imt8dzEtH2
         J63Jf+rEEKu3Kf6sW41UyAYF929po29gXgE70JhrZWeDS6zgUUYvNtyKvx3jKBD9VZSE
         UC8Uc8sBPc/0c8rW3s/MeWVcU2ogUTgyP4QceBMg6bBX61c8f9sflRrvBGlmNn15g5zh
         cVWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rSShYoiZuyH2JUu2VPJiVE0CBFdCwj/MFQetEFw6dJk=;
        b=hxaOUQR95l5A6TwpXws6CfRR0bVedOC62IHbe4yQZ1e1+FDowuslSJZNSY3gKxOSxg
         eolMYBOsvCQdowFaBlzeZtf8J3sc0STwDcVTtV0HShw/s3+Th3vO+xIsrV6MeEqI6tF6
         /vxfgvUjMiwQFXFMgC8xyCHjQUyqejhIQ6cxkat3f0uko8OeyToo4I/Y4PjP5M4zaoDw
         w7ytOf7+RwoEbQ2M/bR9WcblxBmE/tfnWFjwP1WD5AQ51VXJtVebwlDowHHxwNa6Y7hy
         mKMUn1pzbQYzexTaHIrJIHwuRaLp8L8BisJQOcGNmyXAOjmeifTn5TQWuCDNM1odGS2F
         L9mg==
X-Gm-Message-State: AOAM530K+YImEr9DnCA82I9aNqzevc8QBoPPSKa9oYdY1F6D0Bu5ygdb
        MI/egnxo5/EGaMcLR22hrc4/J+E8
X-Google-Smtp-Source: ABdhPJz+jiX/nfuajM9vf5i0JXam3TM9ozBPu0Fj4NKu9j2mgDF2CaG5HvOzfeu2fJioF+Y3gsCS4A==
X-Received: by 2002:a05:6402:1481:: with SMTP id e1mr22264556edv.113.1592924137559;
        Tue, 23 Jun 2020 07:55:37 -0700 (PDT)
Received: from localhost (pd9e51079.dip0.t-ipconnect.de. [217.229.16.121])
        by smtp.gmail.com with ESMTPSA id q7sm8693452eja.69.2020.06.23.07.55.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2020 07:55:35 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Jon Hunter <jonathanh@nvidia.com>, linux-pci@vger.kernel.org,
        linux-tegra@vger.kernel.org
Subject: [PATCH v2 2/2] PCI: tegra: Remove PLL power supplies
Date:   Tue, 23 Jun 2020 16:55:28 +0200
Message-Id: <20200623145528.1658337-2-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200623145528.1658337-1-thierry.reding@gmail.com>
References: <20200623145528.1658337-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

The Tegra PCI controller driver doesn't need to control the PLL power
supplies directly, but rather uses the pads provided by the XUSB pad
controller, which in turn is responsible for supplying power to the
PLLs.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/pci/controller/pci-tegra.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/controller/pci-tegra.c b/drivers/pci/controller/pci-tegra.c
index 235b456698fc..f87a09d21eb0 100644
--- a/drivers/pci/controller/pci-tegra.c
+++ b/drivers/pci/controller/pci-tegra.c
@@ -2025,7 +2025,7 @@ static int tegra_pcie_get_regulators(struct tegra_pcie *pcie, u32 lane_mask)
 		pcie->supplies[i++].supply = "hvdd-pex";
 		pcie->supplies[i++].supply = "vddio-pexctl-aud";
 	} else if (of_device_is_compatible(np, "nvidia,tegra210-pcie")) {
-		pcie->num_supplies = 6;
+		pcie->num_supplies = 3;
 
 		pcie->supplies = devm_kcalloc(pcie->dev, pcie->num_supplies,
 					      sizeof(*pcie->supplies),
@@ -2033,14 +2033,11 @@ static int tegra_pcie_get_regulators(struct tegra_pcie *pcie, u32 lane_mask)
 		if (!pcie->supplies)
 			return -ENOMEM;
 
-		pcie->supplies[i++].supply = "avdd-pll-uerefe";
 		pcie->supplies[i++].supply = "hvddio-pex";
 		pcie->supplies[i++].supply = "dvddio-pex";
-		pcie->supplies[i++].supply = "dvdd-pex-pll";
-		pcie->supplies[i++].supply = "hvdd-pex-pll-e";
 		pcie->supplies[i++].supply = "vddio-pex-ctl";
 	} else if (of_device_is_compatible(np, "nvidia,tegra124-pcie")) {
-		pcie->num_supplies = 7;
+		pcie->num_supplies = 4;
 
 		pcie->supplies = devm_kcalloc(dev, pcie->num_supplies,
 					      sizeof(*pcie->supplies),
@@ -2050,11 +2047,8 @@ static int tegra_pcie_get_regulators(struct tegra_pcie *pcie, u32 lane_mask)
 
 		pcie->supplies[i++].supply = "avddio-pex";
 		pcie->supplies[i++].supply = "dvddio-pex";
-		pcie->supplies[i++].supply = "avdd-pex-pll";
 		pcie->supplies[i++].supply = "hvdd-pex";
-		pcie->supplies[i++].supply = "hvdd-pex-pll-e";
 		pcie->supplies[i++].supply = "vddio-pex-ctl";
-		pcie->supplies[i++].supply = "avdd-pll-erefe";
 	} else if (of_device_is_compatible(np, "nvidia,tegra30-pcie")) {
 		bool need_pexa = false, need_pexb = false;
 
-- 
2.27.0

