Return-Path: <linux-pci+bounces-25367-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 29A0FA7DACD
	for <lists+linux-pci@lfdr.de>; Mon,  7 Apr 2025 12:12:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E74F01889DF5
	for <lists+linux-pci@lfdr.de>; Mon,  7 Apr 2025 10:12:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C7EB22F388;
	Mon,  7 Apr 2025 10:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FLFbQ7yI"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEDD3218EB8;
	Mon,  7 Apr 2025 10:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744020747; cv=none; b=p5WJlsWjZ/VaNscZet7DRovA7jOmAvENRmjvgO2PyVUWrrL1xzWbFN2AkfDW7JESFKi9KDdf2fs2uFqXDBSk9CSBB3dvElfiFaC9ujseaFk+n+1/374aPIuJbCJcMl+D7f+8XYPfNqZElkwselXy0YZKn1OO+gBhKMPiXpIk4Fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744020747; c=relaxed/simple;
	bh=K3DG0bMMEz1uPWU6J3xz+Ige5xV56dzjntpw21l7ULE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=j/vyg4xvposo+cjEarUtnkxMBozntyhdYN6MnETh8yjwnJN/PdhoJtzvIBme5hNyRo8AUMaobMibLxoNCwLSTA2W0HEw9sqMl4aVGvwvpo7QF2FLQJ37wEHZjbA4wF+PXGwHudB3etuOfYAoyFWs9x92nx+i+GAS1c9z13qnf/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FLFbQ7yI; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744020746; x=1775556746;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=K3DG0bMMEz1uPWU6J3xz+Ige5xV56dzjntpw21l7ULE=;
  b=FLFbQ7yIJ/1GFKG8Z3g7R6/iEkXpvNqvkjBDTv+Lx0KziCV9R6QawbPJ
   jp/N7zngpodhcD+fDeQYURJV6oEY9RF45AgGPvLkHq756UW6qELcK1llL
   kd251RWdKxfr+rjM5gLnGr1prRJIhyThuNaS4ThsFSiMPfLvFPFiMcRA7
   JCI9a2uWFhzEpPpdhKQ04XFcGg9fAX+6B9GUrEdWAwlmfBcUEKKhkJULp
   1Ac3h5o/dBK8NEzpu9N5DveHz+HPd2LlHMbsqMB9v2OAKTLQhfrGy0xaL
   74zhD5eUtlRtffsBkE6u90KfD0uvTNbQgHJD+vuSFwvYnAypC7wWYTdx5
   g==;
X-CSE-ConnectionGUID: vRh87bNsQ3yFC8uVD5dKTg==
X-CSE-MsgGUID: dR+FuR52QGaRQZifKDKUBw==
X-IronPort-AV: E=McAfee;i="6700,10204,11396"; a="45566500"
X-IronPort-AV: E=Sophos;i="6.15,194,1739865600"; 
   d="scan'208";a="45566500"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2025 03:12:25 -0700
X-CSE-ConnectionGUID: Tc05M2lnQ9GUAeoPPhB9XA==
X-CSE-MsgGUID: vWKYQRT8RD+QqnFnJ5prVw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,194,1739865600"; 
   d="scan'208";a="132762534"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.229])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2025 03:12:24 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 1/1] PCI: Remove pci_printk()
Date: Mon,  7 Apr 2025 13:12:14 +0300
Message-Id: <20250407101215.1376-1-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

include/linux/pci.h provides low-level pci_printk() interface that is
not used since the commits fab874e12593 ("PCI/AER: Descope pci_printk()
to aer_printk()") and 588021b28642 ("PCI: shpchp: Remove 'shpchp_debug'
module parameter"). PCI logging should not use pci_printk() but pci_*()
wrappers that follow the usual logging wrapper patterns.

Remove pci_printk().

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 include/linux/pci.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/include/linux/pci.h b/include/linux/pci.h
index 0e8e3fd77e96..e293ad5d840d 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -2694,9 +2694,6 @@ void pci_uevent_ers(struct pci_dev *pdev, enum  pci_ers_result err_type);
 
 #include <linux/dma-mapping.h>
 
-#define pci_printk(level, pdev, fmt, arg...) \
-	dev_printk(level, &(pdev)->dev, fmt, ##arg)
-
 #define pci_emerg(pdev, fmt, arg...)	dev_emerg(&(pdev)->dev, fmt, ##arg)
 #define pci_alert(pdev, fmt, arg...)	dev_alert(&(pdev)->dev, fmt, ##arg)
 #define pci_crit(pdev, fmt, arg...)	dev_crit(&(pdev)->dev, fmt, ##arg)

base-commit: 7d06015d936c861160803e020f68f413b5c3cd9d
-- 
2.39.5


