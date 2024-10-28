Return-Path: <linux-pci+bounces-15470-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BAB99B381A
	for <lists+linux-pci@lfdr.de>; Mon, 28 Oct 2024 18:47:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44FD31C222CD
	for <lists+linux-pci@lfdr.de>; Mon, 28 Oct 2024 17:47:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36E5C1DFDA8;
	Mon, 28 Oct 2024 17:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="brPWufeU"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B6401DFDAA;
	Mon, 28 Oct 2024 17:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730137280; cv=none; b=LZTQRJ41Kn34yGmCs7t5+Yp4MQ3QXPUgp04OjgL9CjRA4N38hoEzWwRlyL2BiiIh6aunth8MXFXFb12js60JavQ5btxsuub7EyAUUkaay63fmUavV1dxM5Zu5Cj5i550HS6rhtN33ZWBzFlAj1RD8NFLIUYdyXSk9t9dDzhlfMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730137280; c=relaxed/simple;
	bh=i5G90KkQo1fIqXBoB1CFEzaeiEeL+pJMdkG2HU1GL00=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b0Hsye3Noeflp+BAorHR3p7JtSkZ6nJUyE/jV/nkrGm/ogvnFvfjdFLfoKRLE5iFp7U7ySEVacGrx/KBPW4BY6eC0MmUQ68zksIqTTgcHgvGOYq0Ujne8icThBoXjYBeKY7/fhXPXrEuik6VK8XwChoXKvHNE+/7Z8G/ZccNX/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=brPWufeU; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730137279; x=1761673279;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=i5G90KkQo1fIqXBoB1CFEzaeiEeL+pJMdkG2HU1GL00=;
  b=brPWufeU+KstfCdNaOB5ko4vrysCHYOrhmw/BhoeR85vyaG8dFkDYs2l
   +7bGbVj6b2TnwfgaJtVWZ94b7nUQdBdFnZSSqD2/7d8uc8as67EeveEhC
   3dzopRC0dgWGX/rXK6Zmpbqt/QNgczSTeFe+JBLfZ//ig33guNw+gcEFv
   Omv/PFaTluBUkrzvefPlYyxFRqsM60aAoVAwyPf4GBaJIRhzKly9m1Cki
   hx9/qfjMX1WCuOk6ALd3q8uM3n4h5vvywcawPvGu6n90kPDg0GGR9lEwf
   byHFAQ8eWcAnWZ6jjB0BbEqQ6svTLyg6LwfcBnYjg/Yms2BiiS3R1bOuZ
   w==;
X-CSE-ConnectionGUID: +fcSXBVJTO6GvvJBgr6HmQ==
X-CSE-MsgGUID: DtKrlSs4STu+eEwQOjCaIQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="33440579"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="33440579"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2024 10:41:18 -0700
X-CSE-ConnectionGUID: 7bLXcGqfTEK8dvoZSnBbXA==
X-CSE-MsgGUID: AQdj4EpOTIC7AvZKB/2FCg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,239,1725346800"; 
   d="scan'208";a="105015063"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.203])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2024 10:41:16 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 3/3] PCI/sysfs: Remove unnecessary zero in initializer
Date: Mon, 28 Oct 2024 19:40:46 +0200
Message-Id: <20241028174046.1736-4-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241028174046.1736-1-ilpo.jarvinen@linux.intel.com>
References: <20241028174046.1736-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Providing empty initializer for an array is enough to set its elements
to zero. Thus, remove the redundant 0 from the initializer.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/pci/pci-sysfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 74e4e0917898..19da2f8e98e4 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -1433,7 +1433,7 @@ static ssize_t reset_method_store(struct device *dev,
 	struct pci_dev *pdev = to_pci_dev(dev);
 	char *tmp_options, *name;
 	int m, n;
-	u8 reset_methods[PCI_NUM_RESET_METHODS] = { 0 };
+	u8 reset_methods[PCI_NUM_RESET_METHODS] = {};
 
 	if (sysfs_streq(buf, "")) {
 		pdev->reset_methods[0] = 0;
-- 
2.39.5


