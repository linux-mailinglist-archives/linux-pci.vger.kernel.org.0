Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FA7A1DF332
	for <lists+linux-pci@lfdr.de>; Sat, 23 May 2020 01:48:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387425AbgEVXsn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 22 May 2020 19:48:43 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:39239 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387413AbgEVXsm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 22 May 2020 19:48:42 -0400
Received: by mail-io1-f67.google.com with SMTP id q129so4206165iod.6;
        Fri, 22 May 2020 16:48:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UVLALo+Rw4G28pn8E/Fr1iTDsfsUKpN35tQ7eb98FMg=;
        b=kBYJ75pXlKxk7Kg2+8PUlP8ezH4TADIErDx/Y+jy1z8XVqs4nB3fQe//hdheAznJZx
         bppRgxaqLnzLM9RpJdmzaizyQb0jxRNXD0Ov5zFVnHxCi5Zoi13BPOSP17OJhOg4EIvR
         +IE5hRGqBGbqNQaSo4Hi1fBaxTrGUQqSYEX6H4c0em4iGovTRXQ7cPqQWUi38lrst4tA
         PD0l0+0JKRc4uMeUoSUrdC+EWU6y538uCFoeqdXZSHIhZqETqSxC5o2l3zAe7SYpLl2Z
         dagabO0mVYG+rEn2u7NfIauv3tezA/zzwHgfJVJVsXIQ3Z/K9YI2yTahsbQZRN8Pr9jp
         FB3w==
X-Gm-Message-State: AOAM530+Zqw7qBEEYLtd1AhaPfbNLeNVipMD3EiXmJmMQXyHXeAK8QDz
        LHgTTjb0Efe7DQTF+B7d7dcZmhU=
X-Google-Smtp-Source: ABdhPJzSme6sM1qHBaImIWc5kpH40B37+rjqfkGC+CAaVZMzhxyay108QnlcxCdxriE8AeY4K14g7w==
X-Received: by 2002:a5d:8613:: with SMTP id f19mr5238435iol.173.1590191320399;
        Fri, 22 May 2020 16:48:40 -0700 (PDT)
Received: from xps15.herring.priv ([64.188.179.252])
        by smtp.googlemail.com with ESMTPSA id w23sm4390877iod.9.2020.05.22.16.48.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2020 16:48:39 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-tegra@vger.kernel.org
Subject: [PATCH 06/15] PCI: tegra: Use pci_host_probe() to register host
Date:   Fri, 22 May 2020 17:48:23 -0600
Message-Id: <20200522234832.954484-7-robh@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200522234832.954484-1-robh@kernel.org>
References: <20200522234832.954484-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The tegra host driver does the same host registration and bus scanning
calls as pci_host_probe, so let's use it instead.

Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Jonathan Hunter <jonathanh@nvidia.com>
Cc: linux-tegra@vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/pci/controller/pci-tegra.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/pci/controller/pci-tegra.c b/drivers/pci/controller/pci-tegra.c
index e3e917243e10..3cae96dfe75d 100644
--- a/drivers/pci/controller/pci-tegra.c
+++ b/drivers/pci/controller/pci-tegra.c
@@ -2670,7 +2670,6 @@ static int tegra_pcie_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct pci_host_bridge *host;
 	struct tegra_pcie *pcie;
-	struct pci_bus *child;
 	struct resource *bus;
 	int err;
 
@@ -2721,20 +2720,12 @@ static int tegra_pcie_probe(struct platform_device *pdev)
 	host->map_irq = tegra_pcie_map_irq;
 	host->swizzle_irq = pci_common_swizzle;
 
-	err = pci_scan_root_bus_bridge(host);
+	err = pci_host_probe(host);
 	if (err < 0) {
 		dev_err(dev, "failed to register host: %d\n", err);
 		goto pm_runtime_put;
 	}
 
-	pci_bus_size_bridges(host->bus);
-	pci_bus_assign_resources(host->bus);
-
-	list_for_each_entry(child, &host->bus->children, node)
-		pcie_bus_configure_settings(child);
-
-	pci_bus_add_devices(host->bus);
-
 	if (IS_ENABLED(CONFIG_DEBUG_FS)) {
 		err = tegra_pcie_debugfs_init(pcie);
 		if (err < 0)
-- 
2.25.1

