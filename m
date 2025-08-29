Return-Path: <linux-pci+bounces-35113-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D57CBB3BC31
	for <lists+linux-pci@lfdr.de>; Fri, 29 Aug 2025 15:16:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EEFB25A01BC
	for <lists+linux-pci@lfdr.de>; Fri, 29 Aug 2025 13:15:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB4B332143B;
	Fri, 29 Aug 2025 13:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Qv/7LjUp"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 730ED31B106;
	Fri, 29 Aug 2025 13:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756473202; cv=none; b=lv6JRAsBbMntnbdKoOzXZ7xFbLvgqCEHaY/UYhYsyLAtIN89o6uPUa6gYTMmnBsL1K29Zgs8pgBKjYSxcmGlKUxnguivuGH+uDbskssk83v/13pcC/3ynAc4fjmroDuB21f7ARtDmn4EuWw+uZlsZcLZIqrA4P8DhW9QboSE3ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756473202; c=relaxed/simple;
	bh=o2Tt89cuBk3WUGDZBobPOIeB382G6GaG+7wq9Rfpk4A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Rj8K9C4cNQ9ceGcIKNDXbg1sdfSMwaLtEtB+ppRwMJ96+dBDW63V05/oGsMNoawqj5loKkYD7jQ5aHGj9p4iskBQWI0hmb9PZ2VjjRQe6jCsmG5yanXKFpwVC6kdv/ljf25es/dGKr3HmCUYSowoMramjRH/jztUh4i/frzJ6ZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Qv/7LjUp; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756473202; x=1788009202;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=o2Tt89cuBk3WUGDZBobPOIeB382G6GaG+7wq9Rfpk4A=;
  b=Qv/7LjUpSThc24ju0fy3v+abi18BHBuhumC2H003FzTFAVqEiq6cTwH2
   QZkT6U9QziXYRHe6b5XxcYzebS2BuZCAJWdpvmOsQMZbSCrw9BgIoatEo
   UYU7Y4U/MwWlKpZHIvULJv+WuGJwBs1sW7Zwmx65I/ADgbkAWCZZlyGvy
   avNsihI51k/oVvxOqjvDEhHgw6UHAFxvEsJ6caAOYOncFhRkAhWOj7NPk
   ZTSS+L0dGbc5wFi3F0DAoi5VdhPAxAVXKhc7liRTDAnOgPLDYEbEshNIM
   /eKipuu+Vn4QTgtPL1KryfOD6Ig674sK59RhOrDPJTfCM6ileWAPXzrS+
   Q==;
X-CSE-ConnectionGUID: HDzvXb52R92WdNP0cTy1Dg==
X-CSE-MsgGUID: LjwAdoh/RsiVlAcno1a82g==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="62587473"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="62587473"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2025 06:13:22 -0700
X-CSE-ConnectionGUID: avH+pETgSIaueTlSN+Xt2Q==
X-CSE-MsgGUID: yXhXeFwiTyS7NxeJrq8m1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,221,1751266800"; 
   d="scan'208";a="175656775"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.225])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2025 06:13:18 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v2 16/24] PCI: Use pbus_select_window_for_type() during IO window sizing
Date: Fri, 29 Aug 2025 16:11:05 +0300
Message-Id: <20250829131113.36754-17-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250829131113.36754-1-ilpo.jarvinen@linux.intel.com>
References: <20250829131113.36754-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Convert pbus_size_io() to use pbus_select_window_for_type().

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/pci/setup-bus.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 47f1a4747607..a21d6367e525 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -1122,8 +1122,7 @@ static void pbus_size_io(struct pci_bus *bus, resource_size_t min_size,
 			 struct list_head *realloc_head)
 {
 	struct pci_dev *dev;
-	struct resource *b_res = find_bus_resource_of_type(bus, IORESOURCE_IO,
-							   IORESOURCE_IO);
+	struct resource *b_res = pbus_select_window_for_type(bus, IORESOURCE_IO);
 	resource_size_t size = 0, size0 = 0, size1 = 0;
 	resource_size_t children_add_size = 0;
 	resource_size_t min_align, align;
-- 
2.39.5


