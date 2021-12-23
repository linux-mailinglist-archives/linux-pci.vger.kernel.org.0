Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57E3747DC92
	for <lists+linux-pci@lfdr.de>; Thu, 23 Dec 2021 02:11:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345616AbhLWBLT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 22 Dec 2021 20:11:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345594AbhLWBLS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 22 Dec 2021 20:11:18 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1473DC061574;
        Wed, 22 Dec 2021 17:11:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AB60561D47;
        Thu, 23 Dec 2021 01:11:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB616C36AE5;
        Thu, 23 Dec 2021 01:11:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640221877;
        bh=iOkvvyDco++xwaeJXqOOlWMRlL/DkfMGvNa4DoNqUTQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Q7E39IHl8weHJkVn1UAIb9+guzhHDgYPnNQzt9wSq/FHdc/97cDonVlM2/hQ/lIUH
         gAdKyWS8xDCLCKNsVflsNlRTbNUkJwrRe7zSgyjDGEm+P2S9D6ehwc/QBtNEnIy7q1
         uMXH6dwvg4J7DacnAsgZosBP+kdDCocgwkWQlLSjgYRl6xtqVLqHC1B8jAY6K9/38L
         B2ShZqx9M15IxpoVcW6YmIyjsyL3wBJJDhud0sNBn+dSmadnnPcZTiUIu8+pMJ/QI8
         kGJQ/ukDXaVFKNKQVRNgF9nKWlQmnS0GoqVfUJbFj65IE+khgHt13OEmVD001RWEAV
         b+DjnCLYnFlGQ==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     linux-pci@vger.kernel.org, Fan Fei <ffclaire1224@gmail.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Shuah Khan <skhan@linuxfoundation.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Subject: [PATCH v2 04/23] PCI: designware-plat: Prefer of_device_get_match_data()
Date:   Wed, 22 Dec 2021 19:10:35 -0600
Message-Id: <20211223011054.1227810-5-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211223011054.1227810-1-helgaas@kernel.org>
References: <20211223011054.1227810-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Fan Fei <ffclaire1224@gmail.com>

The designware-plat driver only needs the device data, not the whole struct
of_device_id.  Use of_device_get_match_data() instead of of_match_device().
No functional change intended.

[bhelgaas: commit log]
Signed-off-by: Fan Fei <ffclaire1224@gmail.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Cc: Jingoo Han <jingoohan1@gmail.com>
Cc: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
---
 drivers/pci/controller/dwc/pcie-designware-plat.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-plat.c b/drivers/pci/controller/dwc/pcie-designware-plat.c
index 8851eb161a0e..0c5de87d3cc6 100644
--- a/drivers/pci/controller/dwc/pcie-designware-plat.c
+++ b/drivers/pci/controller/dwc/pcie-designware-plat.c
@@ -122,15 +122,13 @@ static int dw_plat_pcie_probe(struct platform_device *pdev)
 	struct dw_plat_pcie *dw_plat_pcie;
 	struct dw_pcie *pci;
 	int ret;
-	const struct of_device_id *match;
 	const struct dw_plat_pcie_of_data *data;
 	enum dw_pcie_device_mode mode;
 
-	match = of_match_device(dw_plat_pcie_of_match, dev);
-	if (!match)
+	data = of_device_get_match_data(dev);
+	if (!data)
 		return -EINVAL;
 
-	data = (struct dw_plat_pcie_of_data *)match->data;
 	mode = (enum dw_pcie_device_mode)data->mode;
 
 	dw_plat_pcie = devm_kzalloc(dev, sizeof(*dw_plat_pcie), GFP_KERNEL);
-- 
2.25.1

