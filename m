Return-Path: <linux-pci+bounces-18631-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 387BA9F4CEB
	for <lists+linux-pci@lfdr.de>; Tue, 17 Dec 2024 14:56:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F05087A5C60
	for <lists+linux-pci@lfdr.de>; Tue, 17 Dec 2024 13:55:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C9D21F471B;
	Tue, 17 Dec 2024 13:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YK5ctmIH"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1602250F8;
	Tue, 17 Dec 2024 13:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734443697; cv=none; b=kmenrBZZFGBo/RFXnQWc3ByrIjZOA/1yygRf4FJUP8esFsXgLt3HRR2ippBRjiAOi0rnzIFAqcYeeWmCPM1GLMrEXpss+LCTIxoIubWPtXzKo1RnUY+R6DRB10YzP00sN/lgGUsuVIQK+pas46X4YzJqDMyP6UK0foHjGvjfGpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734443697; c=relaxed/simple;
	bh=78Wv8nMlCG60akINHhov8RPvttOjLmyuKns1EZFOA6o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KNe6FDvp2pUs5UNCqQL1bgjGdMMsRAmJBR+Kq6BvvUHtfXJYQ+azZ05C1qhRsaG8MHLT0UjZnxO1UeHhlOVOtuzsrKtXuW+ZsAjnI99Wy+fAjrjJ72bxTJOhhAgUxcNPwEd0RG5DQScaaXdnptjfOPLbG8WasTO95YkzUVeGEHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YK5ctmIH; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734443696; x=1765979696;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=78Wv8nMlCG60akINHhov8RPvttOjLmyuKns1EZFOA6o=;
  b=YK5ctmIHCZQ8e0zTpXCFfOtCTsAG4SCkJ3kXwrtJfC7jjuahxmchwaH8
   0/2QOLMv0gzpn6EuxJxbDR1AodTmvhm5mSkcVfP4mQk7QVj88HiwTLMi1
   gfLaCP0T1zIgroINMf9aApTQD+XGIcKCXftuRhRk3IsUINkJr+aue++IU
   pVXky6wozSvRl5wT+Bg5Nvrezi+x34mGrj89t3xSTfpw5qwC0/cN//ylX
   eUStRhoP/h+d89MDq82DzhU4eUZeb5Q1OqAh9nmg/0Hu4q0gE9jMrihUX
   iS5cJNyriWGCSjICgAROlcNlEJHBn+ihI/FdHsGIMkxDSRePIeqtPxov7
   Q==;
X-CSE-ConnectionGUID: pfaeI1DmTQe+JBhPN81Kfw==
X-CSE-MsgGUID: iHdAyj9XQHqAVEDdbE1G2w==
X-IronPort-AV: E=McAfee;i="6700,10204,11288"; a="34907193"
X-IronPort-AV: E=Sophos;i="6.12,242,1728975600"; 
   d="scan'208";a="34907193"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2024 05:54:55 -0800
X-CSE-ConnectionGUID: 8CCMSOeyTHyAtmhp1Io8pA==
X-CSE-MsgGUID: XwD4+LjuTLygjhr7Skm2xg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,242,1728975600"; 
   d="scan'208";a="97435519"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.192])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2024 05:54:51 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Lukas Wunner <lukas@wunner.de>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	linux-kernel@vger.kernel.org
Cc: Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver O'Halloran <oohall@gmail.com>,
	linuxppc-dev@lists.ozlabs.org,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v7 4/8] PCI: Use unsigned int i in pcie_read_tlp_log()
Date: Tue, 17 Dec 2024 15:53:54 +0200
Message-Id: <20241217135358.9345-5-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241217135358.9345-1-ilpo.jarvinen@linux.intel.com>
References: <20241217135358.9345-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Loop variable i counting from 0 upwards does not need to be signed so
make it unsigned int.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/pci/pcie/tlp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pcie/tlp.c b/drivers/pci/pcie/tlp.c
index 2bf15749cd31..65ac7b5d8a87 100644
--- a/drivers/pci/pcie/tlp.c
+++ b/drivers/pci/pcie/tlp.c
@@ -24,7 +24,8 @@
 int pcie_read_tlp_log(struct pci_dev *dev, int where,
 		      struct pcie_tlp_log *log)
 {
-	int i, ret;
+	unsigned int i;
+	int ret;
 
 	memset(log, 0, sizeof(*log));
 
-- 
2.39.5


