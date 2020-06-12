Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 887DC1F7943
	for <lists+linux-pci@lfdr.de>; Fri, 12 Jun 2020 16:03:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726089AbgFLODJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 12 Jun 2020 10:03:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726085AbgFLODJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 12 Jun 2020 10:03:09 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED08FC03E96F;
        Fri, 12 Jun 2020 07:03:08 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id x14so9869261wrp.2;
        Fri, 12 Jun 2020 07:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aZNRsGSij8yEXoRL33rsv2fSZi9pkwOnUqRTKVPOJGo=;
        b=q8MOxvbMRb9Z74pxJ+Jrzy7qklzY2KHArIxgRj8vVsXInKI4DuhFQ5iqFjH4IUE5ZM
         1durRcrUVyUc0Sh5RDI27snx3KAGRx+MYEKxRcFVeefnmh+BYJHXmD5nIaOM4ogk2E+k
         usnRW3zkoJ/2GakAhV+uoZaDHMnh6UOJ4P9VW+SbKAoO6d7sYTPsDVNx4DUZH/OFWUJt
         geQPgCTReP5jnl3RUXINU0pRsuEc4ZC2RrXprn3ZL+89xu2wF9M2HlAR5hGv+rxvmsQ4
         Z34NS7TH5FshnKcKTzjABzPVya1Nidlm6YuofMltEIkuBRASt1r9qkiZJ56SrJ6/CN6a
         436A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aZNRsGSij8yEXoRL33rsv2fSZi9pkwOnUqRTKVPOJGo=;
        b=On8AF+PC0FVg0neyAR0cRmE/6QMM//ypdDMslyv2wydcIiW1qBVfxZl4VbWEGJvaDj
         CGI73JcC4a7zECJTXpKcT5OtqqNUZXK+Sz2IF+arGg2Cmz+PRX6b9t8N75bl8kXJhs8G
         khVmEsNosPUAhNE9pB4HB3lunn1aiHqfCU/uRsnH5OaN+DvP3aWvLHnWe4f4BvoPr2wp
         K0hZUmN5SO9sIVvgYx3i6iq5rE/cfPJDt8hYy7wRRbQ2Iobo6HEH9tahoV2uZIftqRHL
         rdxQRCl68heEb8EJy0Ug9834D8UtSJdkwgJqGZOxKb7TxQFn///ij4y71tw/WLmUP2bT
         R00A==
X-Gm-Message-State: AOAM530S01Gf8D4EzU6C1z1y2OZ/KmL3GCR/1ZhWEttSAoCOEfs85EKP
        etAK6hrwCRd7v6g9rOH5w1Q=
X-Google-Smtp-Source: ABdhPJzYiaoohxqrCEND9i4JKTHNRjwkvz2Le3u67elvIdpD2gyXz0emLtxheJa5nuG+0InojSn7Og==
X-Received: by 2002:adf:db47:: with SMTP id f7mr15772418wrj.101.1591970587680;
        Fri, 12 Jun 2020 07:03:07 -0700 (PDT)
Received: from localhost ([62.96.65.119])
        by smtp.gmail.com with ESMTPSA id y80sm9047336wmc.34.2020.06.12.07.03.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2020 07:03:06 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Rob Herring <robh@kernel.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-pci@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: [PATCH] PCI: tegra: Remove PLL power supplies
Date:   Fri, 12 Jun 2020 16:03:05 +0200
Message-Id: <20200612140305.2343139-1-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.24.1
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
2.24.1

