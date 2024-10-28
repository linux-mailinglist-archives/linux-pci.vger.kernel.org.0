Return-Path: <linux-pci+bounces-15467-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B00559B3814
	for <lists+linux-pci@lfdr.de>; Mon, 28 Oct 2024 18:46:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 679D51F224F7
	for <lists+linux-pci@lfdr.de>; Mon, 28 Oct 2024 17:46:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5C9E1DF97C;
	Mon, 28 Oct 2024 17:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M8BewfFT"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59E841DF728;
	Mon, 28 Oct 2024 17:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730137257; cv=none; b=TzQwM9qvOq4T4J0AVJNNYRI+iygQkqVpik97+E9G44wLRarz9hYnHjRhYJN81g/wknME5YLFhgNHhs5nt7spQYrUOnzsP9RYBltvoscqbSQ7ZlYsbKgYqoUHUPzWsmU3b65e/+muLmsHYgoC6Blx+sGW9Ks+mSfyurVgoPwg7zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730137257; c=relaxed/simple;
	bh=pvINoLHq6l9nIxPlCPp+1s3OsvmOtl071TwnDrIzjiE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=DxQWyzUDCz5sIwY9frNVqfY3X/MoHlhaCHwtwNCvMv1ulb8KjnF1psfeEs0HPdi7hq0JHf05DF7IwdxuC+opCEFnn2jY+anAXIwFvtaVFhAo3zTo74TjYJPEOE1jsbobDJ41yc9JxhTN1N224K5BILrkZtgpg99vaR8O8T34t7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M8BewfFT; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730137256; x=1761673256;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=pvINoLHq6l9nIxPlCPp+1s3OsvmOtl071TwnDrIzjiE=;
  b=M8BewfFT1MJPrF3A14ukOSlcISJCFpCvVCcLscbjyhMT/7GGdc0TqfzA
   fuMB8lYmJI/NkeilVKLsAlOPPsg3XjJ7RpF6OQmF69Isc1v2peRE5BWdO
   t+RJDKtOlZ0mFC04Z9GuancQF16oKtloMp13gOuN322nnyzDLPN2x4uTx
   8KEqy1glQE1QH0TSHesKINrKr/ZFegE1jnevhedxp+ez/JtmdfXAv+DTP
   r/xWiLmzY2MSIX0NqNGfBCDJAbSFRxu4r1KwNjPuZUGjdp8VUlOK9oS0s
   O6q2LvIE3+2PqEcvpprrcMddiKk4etBOXA8ItqszWVTw8NzMUwsMxugHn
   A==;
X-CSE-ConnectionGUID: hVjQoqHzRDeVvFq+HDfNJg==
X-CSE-MsgGUID: M0UJzNFIQya5lzYyajTDUA==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="33440522"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="33440522"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2024 10:40:55 -0700
X-CSE-ConnectionGUID: UW5GFhVaSBuLZX8+aOiv+A==
X-CSE-MsgGUID: YtKJJ8E8SZGJhrA2g9b7fA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,239,1725346800"; 
   d="scan'208";a="105014987"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.203])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2024 10:40:53 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 0/3] PCI/sysfs: move to sysfs funcs to pci-sysfs.c & do small tweaks
Date: Mon, 28 Oct 2024 19:40:43 +0200
Message-Id: <20241028174046.1736-1-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi all,

This series moves reset related sysfs functions into the correct file
and does small style related improvements.

This series is based on top of commit 2985b1844f3f ("PCI: Fix
reset_method_store() memory leak") in pci/misc branch to avoid
conflict with the code move.


Ilpo Järvinen (3):
  PCI/sysfs: Move reset related sysfs code to correct file
  PCI/sysfs: Use __free() in reset_method_store()
  PCI/sysfs: Remove unnecessary zero in initializer

 drivers/pci/pci-sysfs.c | 108 ++++++++++++++++++++++++++++++++++
 drivers/pci/pci.c       | 125 +---------------------------------------
 drivers/pci/pci.h       |   3 +-
 3 files changed, 110 insertions(+), 126 deletions(-)

-- 
2.39.5


