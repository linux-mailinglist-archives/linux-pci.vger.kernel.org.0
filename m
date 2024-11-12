Return-Path: <linux-pci+bounces-16536-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0897E9C5963
	for <lists+linux-pci@lfdr.de>; Tue, 12 Nov 2024 14:43:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF27A1F21CF5
	for <lists+linux-pci@lfdr.de>; Tue, 12 Nov 2024 13:43:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 872847083D;
	Tue, 12 Nov 2024 13:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b4Bq6TYI"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCDA28614E;
	Tue, 12 Nov 2024 13:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731418958; cv=none; b=uP6RUQj0YxudSnsCOUzIUgoEfJgBlMPIzH7jpRa9Ftt1+GcrWJKIk0M67ju/xgU09b9WYTd85AKIdsBI/O+zOfG6wmIlabb6B+mHPNR6d3t1En+fJGsCf3xC8ru7pPIG1/tukVkPWEwHEyLfnT1TWxCJR0U6ji07+KrDwmaGr6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731418958; c=relaxed/simple;
	bh=7tbqlEq0BGuzVf0SVSuxaMB9hCOlShsw/+ReKdtFfzg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=XOHV2G+WZL4q/rQ++1c2cqasZVnaQkjpj0qUjHXIec7L6s5C+5OeWTh8Yzf0AF3U4Rrb5oT905HdDYYtvPYLsRoSO0yrQVfU2tmNTDYVgH3wB7j+F89IWgbYiZuZ/dbcnV1lZtZRlFZgPD4OzlV8bF5+EKQUj9bvWoMaL1u0KHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=b4Bq6TYI; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731418957; x=1762954957;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=7tbqlEq0BGuzVf0SVSuxaMB9hCOlShsw/+ReKdtFfzg=;
  b=b4Bq6TYIn9e/7o+0SecrlwCtIZ+hwe1BxO0MnjDMcAuZGxkqBXaWhQi9
   dNWMTxpQPHU2DXXO9t13XGUk2/RsSBMohKZZomboG/TCszV/uAQEfnYi9
   E9rKpHuRT65ntXRrYGQLPxUr/8dLT0eyPO/eFOa0hENqiTU9fRJCMc0OA
   qW96Q0THDfWlDZuJd4khbaeKLVhz7WbNr6WngiXwaYDWWwgYVCAm5Tb9I
   YP10RF8F3DA+0s7E+885dFFZJbOcaJZ4fW9qCtJYw97qqUcx3WOkUVUeq
   de0MEahKE2bMu7IvHtm91SH9A+cIB9iCsxQWoCyiY/YuyMJdV85XHGXKJ
   Q==;
X-CSE-ConnectionGUID: Rw3vIpXjQ86Sux8Fy/OU1g==
X-CSE-MsgGUID: cJDuN1HYRKausux1O6qMrg==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="31213033"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="31213033"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2024 05:42:35 -0800
X-CSE-ConnectionGUID: NEuytxN8TqiOZRnq950Cjg==
X-CSE-MsgGUID: wn7vMLI6SwqMoaQvBsDduw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,148,1728975600"; 
   d="scan'208";a="91499895"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.234])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2024 05:42:33 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: =?UTF-8?q?Micha=C5=82=20Winiarski?= <michal.winiarski@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH] PCI: Fix BAR resizing when VF BARs are assigned
Date: Tue, 12 Nov 2024 15:42:25 +0200
Message-Id: <20241112134225.9837-1-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

__resource_resize_store() attempts to release all resources of the
device before attempting the resize. The loop, however, only covers
standard BARs (< PCI_STD_NUM_BARS). If a device has VF BARs that are
assigned, pci_reassign_bridge_resources() finds the bridge window still
has some assigned child resources and returns -NOENT which makes
pci_resize_resource() to detect an error and abort the resize.

Similarly, an assigned Expansion ROM resource prevents the resize.

Change the release loop to cover both the VF BARs and Expansion ROM
which allows the resize operation to release the bridge windows and
attempt to assigned them again with the different size.

As __resource_resize_store() checks first that no driver is bound to
the PCI device before resizing is allowed, SR-IOV cannot be enabled
during resize so it is safe to release also the IOV resources.

Fixes: 8bb705e3e79d ("PCI: Add pci_resize_resource() for resizing BARs")
Reported-by: Michał Winiarski <michal.winiarski@intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/pci/pci-sysfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 5d0f4db1cab7..80b01087d3ef 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -1440,7 +1440,7 @@ static ssize_t __resource_resize_store(struct device *dev, int n,
 
 	pci_remove_resource_files(pdev);
 
-	for (i = 0; i < PCI_STD_NUM_BARS; i++) {
+	for (i = 0; i < PCI_BRIDGE_RESOURCES; i++) {
 		if (pci_resource_len(pdev, i) &&
 		    pci_resource_flags(pdev, i) == flags)
 			pci_release_resource(pdev, i);
-- 
2.39.5


