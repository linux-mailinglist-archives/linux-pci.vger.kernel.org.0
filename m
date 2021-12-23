Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A87C47DC94
	for <lists+linux-pci@lfdr.de>; Thu, 23 Dec 2021 02:11:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345630AbhLWBLZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 22 Dec 2021 20:11:25 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:49458 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345633AbhLWBLT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 22 Dec 2021 20:11:19 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7953C61D98;
        Thu, 23 Dec 2021 01:11:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99289C36AEA;
        Thu, 23 Dec 2021 01:11:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640221878;
        bh=Vi54mz/4hxthWCKu01W9eiBvXWzlLPEqbkFMBL2+LVo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=s8pS7WSXaJ0we2kX41QnNq/kpLw+seDJ3eV4B93lirSpLX5GpXn+Bbo0C3ZCOk4/8
         5gFIVA7fGAsUgrZr0Z464BSzLnRCdORcsIpJALlPPF4356Jp6SlngEywHUK7lZEG10
         DwfSW3skPCtAOHQzhq4aElCd92JQB3W5MzTmURuw2EHN+qU/2FGo0pelCtU/J9uDsZ
         x7qNWAPz+NqXfGuzYP7+zIGvItWvY0KwWKDENdmCdpHy9dpv8jyG4+mqvfmuQF0Ebn
         CDbbEVXrNmOqeoRbmP4iFSS0Y9zTTX+ue28n2wZ0y3QAduCZSheod9nnfoFgOLBP9w
         ZNOiV0Z2Emd+Q==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     linux-pci@vger.kernel.org, Fan Fei <ffclaire1224@gmail.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Shuah Khan <skhan@linuxfoundation.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 05/23] PCI: dra7xx: Prefer of_device_get_match_data()
Date:   Wed, 22 Dec 2021 19:10:36 -0600
Message-Id: <20211223011054.1227810-6-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211223011054.1227810-1-helgaas@kernel.org>
References: <20211223011054.1227810-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Fan Fei <ffclaire1224@gmail.com>

The dra7xx driver only needs the device data, not the whole struct
of_device_id.  Use of_device_get_match_data() instead of of_match_device().
No functional change intended.

[bhelgaas: commit log]
Signed-off-by: Fan Fei <ffclaire1224@gmail.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Cc: Kishon Vijay Abraham I <kishon@ti.com>
Cc: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
---
 drivers/pci/controller/dwc/pci-dra7xx.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-dra7xx.c b/drivers/pci/controller/dwc/pci-dra7xx.c
index a4221f6f3629..12d19183e746 100644
--- a/drivers/pci/controller/dwc/pci-dra7xx.c
+++ b/drivers/pci/controller/dwc/pci-dra7xx.c
@@ -697,16 +697,14 @@ static int dra7xx_pcie_probe(struct platform_device *pdev)
 	struct device_node *np = dev->of_node;
 	char name[10];
 	struct gpio_desc *reset;
-	const struct of_device_id *match;
 	const struct dra7xx_pcie_of_data *data;
 	enum dw_pcie_device_mode mode;
 	u32 b1co_mode_sel_mask;
 
-	match = of_match_device(of_match_ptr(of_dra7xx_pcie_match), dev);
-	if (!match)
+	data = of_device_get_match_data(dev);
+	if (!data)
 		return -EINVAL;
 
-	data = (struct dra7xx_pcie_of_data *)match->data;
 	mode = (enum dw_pcie_device_mode)data->mode;
 	b1co_mode_sel_mask = data->b1co_mode_sel_mask;
 
-- 
2.25.1

