Return-Path: <linux-pci+bounces-23451-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 93E21A5CCAB
	for <lists+linux-pci@lfdr.de>; Tue, 11 Mar 2025 18:48:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B905D3B932D
	for <lists+linux-pci@lfdr.de>; Tue, 11 Mar 2025 17:47:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DCD9262818;
	Tue, 11 Mar 2025 17:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Tc66RtRb"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CE45262D18;
	Tue, 11 Mar 2025 17:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741715249; cv=none; b=aaPia1wx+WaEyWq7NO/ZPHqWu3pgty6RbpLWLcVv84jj4WMGWfaKokbD7jkDXtFYweTq0walBMBiCB1mEe3kPGHl2+byqtIl0XcNnzcmY2Zip5y4ksLJfqXSy2V/VzGNXrFoLzwJ8qbucO7g6S5dXUcn2Fhd5Gi6X8KVTA4DiTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741715249; c=relaxed/simple;
	bh=w7LIh57Ny/AtYF3IssH43Id/ZYUebLk4F68rc+M9SjA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CSikXqj5iScIkgjibWmIBxD2aATPcYMwvNXhM5IdG6xNumkuraMo9PrdUM945zqehpEPR+CwqF0Jz7ZQkNDKvqGs+qjU7jVfHpZ+OII7gEKVzy5Y6qeejh/XIp29VqByBJKW+he+HJt4idijgQBmft73ofOCgS2oxZBfB7Zii6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Tc66RtRb; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741715248; x=1773251248;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=w7LIh57Ny/AtYF3IssH43Id/ZYUebLk4F68rc+M9SjA=;
  b=Tc66RtRbownVibrKtlfP58mKP8GByMIn+6DYVRCr0zZtdBdk3+FseGgV
   ywGHTkFnQcdyh0YeZbeTZK9UbBon9jEUZgY4UeRgd1sIlFzLYHZf9g1rk
   3AdvUL9y4jIX8brMobmQjRN+6ZqeBvGChQ7LPG1r/EUxtq6aAbkx2Xg1R
   bOtgI7hR4QYbWVasOe70xjA8vh8Kg4NcvjNDv3T90sb63gPauhuCYipMi
   hIn4+Y/qvLMU4Q724XlOOoJKex7zMbraMUVt8Ucqz5M3EHyqADjVk+T/6
   gl0YsRpkZbC1WayOVsNBpatQXKaKv/DfHwYEmcYAjFQIJHf+QAilD7jEy
   Q==;
X-CSE-ConnectionGUID: oI7a2IOmQ1aNE0KSh+QmHA==
X-CSE-MsgGUID: 8RyLkWugTF+X1Kg0OXIDaA==
X-IronPort-AV: E=McAfee;i="6700,10204,11370"; a="46415002"
X-IronPort-AV: E=Sophos;i="6.14,239,1736841600"; 
   d="scan'208";a="46415002"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2025 10:47:28 -0700
X-CSE-ConnectionGUID: sIwJlPsVTDGiDx7vlLmVew==
X-CSE-MsgGUID: aQtSORMDSZ+hXYspBm9MVQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,239,1736841600"; 
   d="scan'208";a="125291619"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.251])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2025 10:47:26 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 4/4] PCI: Move cardbus IO size declarations into pci/pci.h
Date: Tue, 11 Mar 2025 19:47:01 +0200
Message-Id: <20250311174701.3586-4-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250311174701.3586-1-ilpo.jarvinen@linux.intel.com>
References: <20250311174701.3586-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

For some reason, cardbus related io/mem size declarations are in
linux/pci.h, whereas non-cardbus sizes are already in pci/pci.h.
Move all them into one place in pci/pci.h.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/pci/pci.h   | 2 ++
 include/linux/pci.h | 2 --
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 3e05e5506041..f88e28519f5c 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -266,6 +266,8 @@ extern unsigned long pci_hotplug_io_size;
 extern unsigned long pci_hotplug_mmio_size;
 extern unsigned long pci_hotplug_mmio_pref_size;
 extern unsigned long pci_hotplug_bus_size;
+extern unsigned long pci_cardbus_io_size;
+extern unsigned long pci_cardbus_mem_size;
 
 /**
  * pci_match_one_device - Tell if a PCI device structure has a matching
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 9a703355ef06..f9424478a19a 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -2332,8 +2332,6 @@ extern int pci_pci_problems;
 #define PCIPCI_ALIMAGIK		32	/* Need low latency setting */
 #define PCIAGP_FAIL		64	/* No PCI to AGP DMA */
 
-extern unsigned long pci_cardbus_io_size;
-extern unsigned long pci_cardbus_mem_size;
 extern u8 pci_dfl_cache_line_size;
 extern u8 pci_cache_line_size;
 
-- 
2.39.5


