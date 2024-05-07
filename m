Return-Path: <linux-pci+bounces-7163-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BF2E8BE1DB
	for <lists+linux-pci@lfdr.de>; Tue,  7 May 2024 14:18:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C5D71F21DC3
	for <lists+linux-pci@lfdr.de>; Tue,  7 May 2024 12:18:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38BA3156F23;
	Tue,  7 May 2024 12:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CbNx7ldt"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7079F136E2D;
	Tue,  7 May 2024 12:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715084291; cv=none; b=kPZuyVc6IO+xk2Su+F5MaiiFYuLIdzfV69lMMG+5nYG2ikrNlV7q6L0RIdzV6bREKsSyK/mcMsXEc5xV5aNFdIXVRdr64ZSYWRQj+Um2EMAndzDn02oRfHXet/+OqMrpqzvYQ6JPc2etsISDaGaxbX5aYhOufiisrrCTtf/R7WQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715084291; c=relaxed/simple;
	bh=nM8UfwUrMmyJeDfGp32FgWig6Pd3e36Y+q3L8UXuPSc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=ZgtqX7m5PjoOFp+PQpL/Qer6INzzRovFdvCSnu5tFqycbJNTkysmx5E6CD+eWrOPjYvN4TV33Ua/zQpCxADW9Rj1iNoHuwoLIAtA9jLUFT72aRTFEXH4yuwih2WillKgizbA6kEcoRNrvjrwGDc+FmYMAmZk08EgCD9QQnH22rE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CbNx7ldt; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715084289; x=1746620289;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=nM8UfwUrMmyJeDfGp32FgWig6Pd3e36Y+q3L8UXuPSc=;
  b=CbNx7ldtsW2Tpbyb4LKw0H/V1sWM+6EtfBu7yJQtikKLsMOx2407Hrpu
   rqdMLbZ6g77KkimYiVlK+ULsnUplJyzqlwlMZLJ6FutT5Fs0nVENlymmi
   iS18JFqE8ErR2BVZVrSyyUQtuihuaerUsuJfAzyjt+SP/jxc+rYZSJr3v
   Jex5zT9QWUHF7stLFjXEHjGBq0GApvjDwrrABm6HTQqCHxLUXby3D15eo
   fMXR/mCOVfb3aelHOzpStTPcYe2M3Ht7qqrMd7tbCYPK7zFXIGCqg7ah8
   a6rz7p56C44s02ecOqIbectAjDxD5BDJ+nR5ncU7M++ijVYk8AsNZYvUs
   A==;
X-CSE-ConnectionGUID: zCj+OKKzRsufpz3p91xrCA==
X-CSE-MsgGUID: +2SST03kTZeqbAZ2sXjrPw==
X-IronPort-AV: E=McAfee;i="6600,9927,11065"; a="14661171"
X-IronPort-AV: E=Sophos;i="6.08,261,1712646000"; 
   d="scan'208";a="14661171"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2024 05:18:09 -0700
X-CSE-ConnectionGUID: 7NvjrNGdRDqAprFLTYLNmw==
X-CSE-MsgGUID: yXzhZ5BxRtOqqYaSMX3KMw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,261,1712646000"; 
   d="scan'208";a="28481456"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.74])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2024 05:18:06 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 1/1] PCI: Make pcie_bandwidth_capable() static
Date: Tue,  7 May 2024 15:17:58 +0300
Message-Id: <20240507121758.13849-1-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

pcie_bandwidth_capable() is only used within pci.c, make it static.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/pci/pci.c | 4 ++--
 drivers/pci/pci.h | 2 --
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index e5f243dd4288..23fb5d6c25b0 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -6065,8 +6065,8 @@ EXPORT_SYMBOL(pcie_get_width_cap);
  * and width, multiplying them, and applying encoding overhead.  The result
  * is in Mb/s, i.e., megabits/second of raw bandwidth.
  */
-u32 pcie_bandwidth_capable(struct pci_dev *dev, enum pci_bus_speed *speed,
-			   enum pcie_link_width *width)
+static u32 pcie_bandwidth_capable(struct pci_dev *dev, enum pci_bus_speed *speed,
+				  enum pcie_link_width *width)
 {
 	*speed = pcie_get_speed_cap(dev);
 	*width = pcie_get_width_cap(dev);
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 17fed1846847..fd44565c4756 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -293,8 +293,6 @@ void pci_bus_put(struct pci_bus *bus);
 const char *pci_speed_string(enum pci_bus_speed speed);
 enum pci_bus_speed pcie_get_speed_cap(struct pci_dev *dev);
 enum pcie_link_width pcie_get_width_cap(struct pci_dev *dev);
-u32 pcie_bandwidth_capable(struct pci_dev *dev, enum pci_bus_speed *speed,
-			   enum pcie_link_width *width);
 void __pcie_print_link_status(struct pci_dev *dev, bool verbose);
 void pcie_report_downtraining(struct pci_dev *dev);
 void pcie_update_link_speed(struct pci_bus *bus, u16 link_status);
-- 
2.39.2


