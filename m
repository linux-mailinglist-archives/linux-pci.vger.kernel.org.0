Return-Path: <linux-pci+bounces-18704-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 696F99F68C9
	for <lists+linux-pci@lfdr.de>; Wed, 18 Dec 2024 15:42:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF52F171704
	for <lists+linux-pci@lfdr.de>; Wed, 18 Dec 2024 14:40:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABE081F543B;
	Wed, 18 Dec 2024 14:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hGh40mUE"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B6461C2325;
	Wed, 18 Dec 2024 14:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734532717; cv=none; b=vAby0by+rILkJ0fmJTOrRbzB3K3RdzrGfIZGKeleLj6ATSIikqxfXOXGlyfV77XJPvpm6effMsdHtE6liNsIpz84R55D9YqvSdTypdTFoE787/qgbd1uCnF27Ubm0RqDPvV+l+JMpkAbVjDNQ2pc0j+AmFZLo+sSE+UZTRQPoRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734532717; c=relaxed/simple;
	bh=78Wv8nMlCG60akINHhov8RPvttOjLmyuKns1EZFOA6o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ANMXEq6lrBNeVv1OKWVk8PCXIyaY5J3Tgr0+erZ/BUM5kI0cZdOzfaKtMiQ+9rJsqC3UbccYQZdjBa/IymQfEwPgf+z1eTw1hffHsx5c7X1l0XlgcdINY8QFaNbdUEAlP2+tloxmvByfBXaA6H9SxN6759S4dLFIHgv6kdIhzi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hGh40mUE; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734532715; x=1766068715;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=78Wv8nMlCG60akINHhov8RPvttOjLmyuKns1EZFOA6o=;
  b=hGh40mUE+U6NCCNZ0+vcqfOE3Yf/+mG9d5qNA4P/TCToK1v136U6gR3o
   7JNVj0P8l3iVkNxpHS9IY24IOhnyvWlMiD1BU2YA8gajuJShzJeoznSXn
   2fEp1zk/1yPXUTbIm6t/y10NXvEDSHNZ00iz/CVC34YkuiR64e5yxSc3+
   rElKw0fzmS6+Cuj2lcTNPaEO62FgVRP+NmvKHgaF9O8hZrDNzZLYj1BiV
   g6Vz/yI8CCGSCmiB9ybCT5S8UEdO61fOWdrF45On80UpPvBo1NED/efnG
   EdpnC/Uh0A11auFDSACmJCLYcN+g8yj6aLhuVUmKfZrcVF+5LPutd8bfP
   Q==;
X-CSE-ConnectionGUID: mUIJyB62TimBExMyTYcV9Q==
X-CSE-MsgGUID: nQLLpg8QQwmJgs2UYCOc+g==
X-IronPort-AV: E=McAfee;i="6700,10204,11290"; a="22597429"
X-IronPort-AV: E=Sophos;i="6.12,244,1728975600"; 
   d="scan'208";a="22597429"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2024 06:38:34 -0800
X-CSE-ConnectionGUID: 033KUQ4YTuCSz2+5HwvFdg==
X-CSE-MsgGUID: PkjesBuCRDq5zfXJPGRbIA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="102974671"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.138])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2024 06:38:30 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Lukas Wunner <lukas@wunner.de>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Yazen Ghannam <yazen.ghannam@amd.com>,
	linux-kernel@vger.kernel.org
Cc: Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver O'Halloran <oohall@gmail.com>,
	linuxppc-dev@lists.ozlabs.org,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v8 4/7] PCI: Use unsigned int i in pcie_read_tlp_log()
Date: Wed, 18 Dec 2024 16:37:44 +0200
Message-Id: <20241218143747.3159-5-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241218143747.3159-1-ilpo.jarvinen@linux.intel.com>
References: <20241218143747.3159-1-ilpo.jarvinen@linux.intel.com>
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


