Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A6BA47DC99
	for <lists+linux-pci@lfdr.de>; Thu, 23 Dec 2021 02:11:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345655AbhLWBL2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 22 Dec 2021 20:11:28 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:49548 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345634AbhLWBLZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 22 Dec 2021 20:11:25 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 403BB61C1E;
        Thu, 23 Dec 2021 01:11:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 713A5C36AE5;
        Thu, 23 Dec 2021 01:11:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640221884;
        bh=WOUkdh1NbhxbQ1Gq4rElA7a5wF5ya9shQ6vgwd/J/8o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XcYlS6fRfQS5o3OiQzeKUPl9PX6YTj2xTyv9ColCT1RtYUuHzUKFtXz6deCitMebs
         ujbGSOpKfSzSVneNicgpv2ntPkZycMsm160HY1uY4aNM8POK6nYtHEXA0UD00BVw+K
         lirrCj5b/2h0WqSUS01XHiO6pKGWvRc9n+BZ5p+F3lVjn2D+TYhUeTG6n326zd6gtI
         Mmu5U9oWU4y1CiZXRB/d4fyCPIr/Ij6WSMxYZKsO/TjnVOQrqYthIlpF0JbvJe2rYj
         8q68Be8X2r86adz+5jA3TtNouIAfdgu20nxQZM+vBRWh5NEtIE5JIOFn1r7cj/dxc6
         kquiE7eh9B8Vw==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     linux-pci@vger.kernel.org, Fan Fei <ffclaire1224@gmail.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Shuah Khan <skhan@linuxfoundation.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Tom Joseph <tjoseph@cadence.com>, linux-omap@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 08/23] PCI: j721e: Drop pointless of_device_get_match_data() cast
Date:   Wed, 22 Dec 2021 19:10:39 -0600
Message-Id: <20211223011054.1227810-9-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211223011054.1227810-1-helgaas@kernel.org>
References: <20211223011054.1227810-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

of_device_get_match_data() returns "void *", so no cast is needed when
assigning the result to a pointer type.  Drop the unnecessary cast.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Cc: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Tom Joseph <tjoseph@cadence.com>
Cc: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
---
 drivers/pci/controller/cadence/pci-j721e.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/cadence/pci-j721e.c b/drivers/pci/controller/cadence/pci-j721e.c
index 918e11082e6a..cd43d1898482 100644
--- a/drivers/pci/controller/cadence/pci-j721e.c
+++ b/drivers/pci/controller/cadence/pci-j721e.c
@@ -354,7 +354,7 @@ static int j721e_pcie_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct device_node *node = dev->of_node;
 	struct pci_host_bridge *bridge;
-	struct j721e_pcie_data *data;
+	const struct j721e_pcie_data *data;
 	struct cdns_pcie *cdns_pcie;
 	struct j721e_pcie *pcie;
 	struct cdns_pcie_rc *rc;
@@ -367,7 +367,7 @@ static int j721e_pcie_probe(struct platform_device *pdev)
 	int ret;
 	int irq;
 
-	data = (struct j721e_pcie_data *)of_device_get_match_data(dev);
+	data = of_device_get_match_data(dev);
 	if (!data)
 		return -EINVAL;
 
-- 
2.25.1

