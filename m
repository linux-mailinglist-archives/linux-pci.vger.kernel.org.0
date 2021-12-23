Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB5B947DC8F
	for <lists+linux-pci@lfdr.de>; Thu, 23 Dec 2021 02:11:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345551AbhLWBLQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 22 Dec 2021 20:11:16 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:49372 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345529AbhLWBLQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 22 Dec 2021 20:11:16 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DFBEF61C2C;
        Thu, 23 Dec 2021 01:11:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28D20C36AE5;
        Thu, 23 Dec 2021 01:11:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640221875;
        bh=Ibnjc1Ag3vn7A29RC/T0gZzNpyuQKYqn+Ff07SRVx4Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZcfHxOmKbAHh1dur48h2G343diWQd0rLaQKK+YfADYBNoQA2tvOZSKISdBUNvGyH/
         mgi+Yeq0GCAzdt8cqaZ26PJ0n/PjZnT2loDxzVws1dNNYCwaKjwudaxLmCLcqyLUtF
         ElJt7+6TAtmb+U6U1/m46/m0UiO/prtTQQxh0iPXWY5vXpPMKp2alyxdFBzansjmyX
         JB1QSS9u938+RS3a0OICI4q2lm2T6XjKGWpuvw2SwH8PhUO3N+juflm85M/JS/O9cP
         OBhwax0V+HAv4vnKjtKWyK3wsAOMtaLYI4uMBZYwyGQJMZHaR46bXJcHkERc006RCq
         thqnbKcuXwSxA==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     linux-pci@vger.kernel.org, Fan Fei <ffclaire1224@gmail.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Shuah Khan <skhan@linuxfoundation.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Tom Joseph <tjoseph@cadence.com>
Subject: [PATCH v2 03/23] PCI: cadence: Prefer of_device_get_match_data()
Date:   Wed, 22 Dec 2021 19:10:34 -0600
Message-Id: <20211223011054.1227810-4-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211223011054.1227810-1-helgaas@kernel.org>
References: <20211223011054.1227810-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Fan Fei <ffclaire1224@gmail.com>

The cadence driver only needs the device data, not the whole struct
of_device_id.  Use of_device_get_match_data() instead of of_match_device().
No functional change intended.

[bhelgaas: commit log]
Signed-off-by: Fan Fei <ffclaire1224@gmail.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Cc: Tom Joseph <tjoseph@cadence.com>
---
 drivers/pci/controller/cadence/pcie-cadence-plat.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/cadence/pcie-cadence-plat.c b/drivers/pci/controller/cadence/pcie-cadence-plat.c
index a224afadbcc0..bac0541317c1 100644
--- a/drivers/pci/controller/cadence/pcie-cadence-plat.c
+++ b/drivers/pci/controller/cadence/pcie-cadence-plat.c
@@ -45,7 +45,6 @@ static int cdns_plat_pcie_probe(struct platform_device *pdev)
 {
 	const struct cdns_plat_pcie_of_data *data;
 	struct cdns_plat_pcie *cdns_plat_pcie;
-	const struct of_device_id *match;
 	struct device *dev = &pdev->dev;
 	struct pci_host_bridge *bridge;
 	struct cdns_pcie_ep *ep;
@@ -54,11 +53,10 @@ static int cdns_plat_pcie_probe(struct platform_device *pdev)
 	bool is_rc;
 	int ret;
 
-	match = of_match_device(cdns_plat_pcie_of_match, dev);
-	if (!match)
+	data = of_device_get_match_data(dev);
+	if (!data)
 		return -EINVAL;
 
-	data = (struct cdns_plat_pcie_of_data *)match->data;
 	is_rc = data->is_rc;
 
 	pr_debug(" Started %s with is_rc: %d\n", __func__, is_rc);
-- 
2.25.1

