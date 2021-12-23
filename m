Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01AF347DC97
	for <lists+linux-pci@lfdr.de>; Thu, 23 Dec 2021 02:11:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345627AbhLWBL1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 22 Dec 2021 20:11:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345652AbhLWBLY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 22 Dec 2021 20:11:24 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA7DFC061746;
        Wed, 22 Dec 2021 17:11:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 4D0ADCE1EFD;
        Thu, 23 Dec 2021 01:11:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5862DC36AE5;
        Thu, 23 Dec 2021 01:11:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640221880;
        bh=8ozT1NnqkwytB+gwY3dvSdAg57IGoiJh+NMjyrG5TXA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oyPoF7LNrBKwHu9Z0WIPQfpnPnPTcI66gGGVzgbjwpxYfd0RkuyNatl41Daem9rpI
         ymAh+c463R5vh8aIIUOIiUfxWwJ8Vufz5rCxY0DDa10PD3kBIWe5iO/De+TLCJQZkt
         6KdZ+bRch8nw3vbJnPSG5n035962dXAXrf4HaNjn0YppPYX0M954ccHf4t+D9U1kMQ
         SM4Q2FLSCCxyVZ2xNUY9Axo9xfqt6EexjKOqx16uzP6QXSLCtBRPV7/tEorfJsSqly
         CAFQdiyDwUm/jFjNXi9c8zU4AwkQBFFuz/d+Nn4VWoAGz3ToITWpZDNob2DnylZ6b2
         ZLQyuSOstvh9g==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     linux-pci@vger.kernel.org, Fan Fei <ffclaire1224@gmail.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Shuah Khan <skhan@linuxfoundation.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH v2 06/23] PCI: keystone: Prefer of_device_get_match_data()
Date:   Wed, 22 Dec 2021 19:10:37 -0600
Message-Id: <20211223011054.1227810-7-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211223011054.1227810-1-helgaas@kernel.org>
References: <20211223011054.1227810-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Fan Fei <ffclaire1224@gmail.com>

The keystone driver only needs the device data, not the whole struct
of_device_id.  Use of_device_get_match_data() instead of of_match_device().
No functional change intended.

[bhelgaas: commit log]
Signed-off-by: Fan Fei <ffclaire1224@gmail.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Cc: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/pci/controller/dwc/pci-keystone.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
index 865258d8c53c..bf4755cb6c50 100644
--- a/drivers/pci/controller/dwc/pci-keystone.c
+++ b/drivers/pci/controller/dwc/pci-keystone.c
@@ -1087,7 +1087,6 @@ static int __init ks_pcie_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct device_node *np = dev->of_node;
 	const struct ks_pcie_of_data *data;
-	const struct of_device_id *match;
 	enum dw_pcie_device_mode mode;
 	struct dw_pcie *pci;
 	struct keystone_pcie *ks_pcie;
@@ -1104,8 +1103,7 @@ static int __init ks_pcie_probe(struct platform_device *pdev)
 	int irq;
 	int i;
 
-	match = of_match_device(of_match_ptr(ks_pcie_of_match), dev);
-	data = (struct ks_pcie_of_data *)match->data;
+	data = of_device_get_match_data(dev);
 	if (!data)
 		return -EINVAL;
 
-- 
2.25.1

