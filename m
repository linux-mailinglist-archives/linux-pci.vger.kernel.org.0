Return-Path: <linux-pci+bounces-6777-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 99A1D8B55C3
	for <lists+linux-pci@lfdr.de>; Mon, 29 Apr 2024 12:49:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C27E1F23612
	for <lists+linux-pci@lfdr.de>; Mon, 29 Apr 2024 10:49:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2C503BBC7;
	Mon, 29 Apr 2024 10:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hV0rZwhv"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 537EF3B295;
	Mon, 29 Apr 2024 10:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714387699; cv=none; b=fxZlOtpDBInA8g7Ynv7kw7KZZby0W+pTOU4XcsJJFAb5iwIph2rvqFEIwQQSqoexpg/sjmc6pSbsZjFQAezZoLVoulU4Ai07mXbxIK3dYQAHVeCZ01ZJ9nUhy90wJmBDB1nzf3muQz8/3roZNZzDHtWTBpCLLZtWdcHy0EwcJY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714387699; c=relaxed/simple;
	bh=3qNUeNNqvAX2EUpER+BCy2WtfN/wfJPQesC9InOcInY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HHgcPBeNGykBdMaKu2FeyTIf1aEP6R8XzrZofGXQ4LVo0LCHLbWsRZQCRIHkkHt7sLDs4L6qEdP54D3UuYlf2p94h2Mb2/Dxqs/ICgDo5nI1qkE707CttCEmbRAVFx3Nw5puxcQOnCHN4FT/BT5NpzOPMDFWRtsia/zPVEGo58M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hV0rZwhv; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714387698; x=1745923698;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3qNUeNNqvAX2EUpER+BCy2WtfN/wfJPQesC9InOcInY=;
  b=hV0rZwhvrSPBjcuu0ekLoViJi7dWmLOaCQDPOY/5VuSACztOHR9A06n1
   jci3LPFYf6zAO6AtJAXjPyWjSwZ4FvKWj+6O98AGk/ExrNCd5ZZBGM9kb
   MRVmbgne5kLJwcbZzcTCBtojy8o/v554DuACDBSSJIEG3uItDytZBn11T
   JdmsMtpH+CqBnPUfs9WhoXtP3P0YO4Wtv2sEra1IfBb91OdF0BBmtzuYf
   1FAGj/CPvdBHBbhcnzUoz3kDjWy5Mwhx45VdLXlVAM0OmktNOK5DvklIj
   inIMcx584adibGbJ5+pO/MsxbMZvOIQfjKXCGh6BJJS3YmNPRoPmWE3ej
   g==;
X-CSE-ConnectionGUID: SYekFPNDSFCOP89w4CKohg==
X-CSE-MsgGUID: q4JRwSLLTOOhAYEcFI/dRA==
X-IronPort-AV: E=McAfee;i="6600,9927,11057"; a="20729455"
X-IronPort-AV: E=Sophos;i="6.07,239,1708416000"; 
   d="scan'208";a="20729455"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2024 03:48:17 -0700
X-CSE-ConnectionGUID: GKf41xG9T0G5foS4CYye8A==
X-CSE-MsgGUID: z23Bu2lZSkGhazCdiU8p9Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,239,1708416000"; 
   d="scan'208";a="26067723"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.45])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2024 03:48:14 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Rob Herring <robh@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 10/10] PCI: v3: Use generic PCI Conf Type 0/1 helpers
Date: Mon, 29 Apr 2024 13:46:33 +0300
Message-Id: <20240429104633.11060-11-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240429104633.11060-1-ilpo.jarvinen@linux.intel.com>
References: <20240429104633.11060-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Convert v3 to use pci_conf{0,1}_addr() from PCI core to calculate PCI
Configuration Space address for Type 0/1 access.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/pci/controller/pci-v3-semi.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/pci-v3-semi.c b/drivers/pci/controller/pci-v3-semi.c
index 460a825325dd..a07323148007 100644
--- a/drivers/pci/controller/pci-v3-semi.c
+++ b/drivers/pci/controller/pci-v3-semi.c
@@ -327,7 +327,7 @@ static void __iomem *v3_map_bus(struct pci_bus *bus,
 		 *  3:1 = config cycle (101)
 		 *  0   = PCI A1 & A0 are 0 (0)
 		 */
-		address = PCI_FUNC(devfn) << 8;
+		address = pci_conf0_addr(devfn, offset);
 		mapaddress = V3_LB_MAP_TYPE_CONFIG;
 
 		if (slot > 12)
@@ -354,7 +354,7 @@ static void __iomem *v3_map_bus(struct pci_bus *bus,
 		 *  0   = PCI A1 & A0 from host bus (1)
 		 */
 		mapaddress = V3_LB_MAP_TYPE_CONFIG | V3_LB_MAP_AD_LOW_EN;
-		address = (busnr << 16) | (devfn << 8);
+		address = pci_conf1_addr(busnr, devfn, offset, false);
 	}
 
 	/*
@@ -375,7 +375,7 @@ static void __iomem *v3_map_bus(struct pci_bus *bus,
 	       v3->base + V3_LB_BASE1);
 	writew(mapaddress, v3->base + V3_LB_MAP1);
 
-	return v3->config_base + address + offset;
+	return v3->config_base + address;
 }
 
 static void v3_unmap_bus(struct v3_pci *v3)
-- 
2.39.2


