Return-Path: <linux-pci+bounces-13177-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ECA919782B2
	for <lists+linux-pci@lfdr.de>; Fri, 13 Sep 2024 16:37:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7CB67B2298A
	for <lists+linux-pci@lfdr.de>; Fri, 13 Sep 2024 14:37:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1E613B782;
	Fri, 13 Sep 2024 14:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fC4JtrO0"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A6D1383BF;
	Fri, 13 Sep 2024 14:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726238242; cv=none; b=LJ3g+uHZ9hEmiHOKoVNk/LlDE8qHycIXhk7tp+Jm8iOnOLvwN4Sd+3oe4ppt9VCY/ZW+7uQBy2KFNL+6P36y4GgUkEKQTTVXkarLoc+B71o1jaAVBh0DyjKi3pdmO+PEKHywGj1urk4txqtULiNKNfa8/Xt7bIO0kU2fF2geUFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726238242; c=relaxed/simple;
	bh=vrR9lSZtbojiA2EubTfEXC7NUqhoH2bBkEIK7kkkTFA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u41sFlFu29shO2IGJRBdWd5SLVGRUWGUvLS6NwjUwW5PpBms3xNG92tdUINaPSrhW6uD4BLmMm0J4M1yRVDY7AqX/MsVV1vf3o1/fBFvtew+Rz9iPHHXHpltxRYgr1JV9b7cQXNXyMwlbE2bdVjmIQ6PpZlyB6lIGkgD/HMac8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fC4JtrO0; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726238241; x=1757774241;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vrR9lSZtbojiA2EubTfEXC7NUqhoH2bBkEIK7kkkTFA=;
  b=fC4JtrO0E0Ef0u78eYfkSs7rbcTavWipuklmTuKgam10fzuyK8x0IxEr
   DLooiaTCjtEdxJ+8d1EaIqT1vzVdB+rbxQNvhXPZNX1gfnAtpW5LF+sJg
   PW5zodsJXGrlHTtKX3pMkLVt7vctNwrfc8B+xKiPqRRp+DPKEKNiOLYwl
   d/lHu3QQWBJmmzd82TUdfIPRdSnYi8h3HB6jYporKu5zgvwmSsPL86hMw
   67O04SCaYCB7rC/AHl+17NJiZ5X73ZPg9bIHbgtvEixVIkm+84dEZp0sb
   yp0rtoQ1zobfVXifnL//NDAtgl7Y8n3v7r4/DNaPP/lvOASs6pxMYHx5J
   A==;
X-CSE-ConnectionGUID: l4jCSsizQTeR6YJIt4I/5Q==
X-CSE-MsgGUID: GPWeN7RHTGScPlTQMUyj6w==
X-IronPort-AV: E=McAfee;i="6700,10204,11194"; a="28886522"
X-IronPort-AV: E=Sophos;i="6.10,226,1719903600"; 
   d="scan'208";a="28886522"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2024 07:37:21 -0700
X-CSE-ConnectionGUID: 4Ad/XL1YSjipkJFyp6pVbg==
X-CSE-MsgGUID: a6/9cR+jSM+V6/nc+ovmxg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,226,1719903600"; 
   d="scan'208";a="68400273"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.154])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2024 07:37:18 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver O'Halloran <oohall@gmail.com>,
	Lukas Wunner <lukas@wunner.de>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	linux-kernel@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v6 4/8] PCI: Use unsigned int i in pcie_read_tlp_log()
Date: Fri, 13 Sep 2024 17:36:28 +0300
Message-Id: <20240913143632.5277-5-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240913143632.5277-1-ilpo.jarvinen@linux.intel.com>
References: <20240913143632.5277-1-ilpo.jarvinen@linux.intel.com>
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
2.39.2


