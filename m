Return-Path: <linux-pci+bounces-21596-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C60F3A37F08
	for <lists+linux-pci@lfdr.de>; Mon, 17 Feb 2025 10:56:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A07C16CCA0
	for <lists+linux-pci@lfdr.de>; Mon, 17 Feb 2025 09:56:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B0A92163B0;
	Mon, 17 Feb 2025 09:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HLIFETDf"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04EB021639F;
	Mon, 17 Feb 2025 09:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739786159; cv=none; b=YSNYEz2sbdh6TxeGWu/nYCdPTRB/4wUv3V2d6CGzCnyiaATBj4nAdgGp2mE95AUQYs1UNcLhUNcdhGJVZO0ULnvk/Tsewb84OQpPlkNJu6Rv2BX7EBkHLQUclKFjTS51HmlivwIpUrPp//LpLdzTm76lGlzVm51o0ennB3axDIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739786159; c=relaxed/simple;
	bh=mfPefVETAgRMxKiD80APtRBBjkcuYBiNiJnktP5O6sM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=Ok1xoZSvslJCRhH7wad/boSaktBzhis6t1TPV73ZOyyIzc3WLr2Z7KcaD/mtx6HEs2FBvJFWd37KU3gnfpdw2JhydW33oWhpEtCJIiFv7SoQCmf9sU1k4tOwUe8+NgXYfNPHFWKoYbKdtl4/Nh6uLvOjNIBCRWE/ZnC4UH0+khY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HLIFETDf; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739786158; x=1771322158;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=mfPefVETAgRMxKiD80APtRBBjkcuYBiNiJnktP5O6sM=;
  b=HLIFETDfetxDsox4PbfwDnAcBYLIScHFS7TWodDulggGV8GM7aiLKzKl
   b5ave2ZpgGHvzznqq0GdpFTiXFBiEkF1DifNqpeHih2Xj/DAXQ8hP/sbI
   GpeZiPI8GJRtl4bl0+bBjDoNBXFMIkXvVcsu4HqRc295V2YMu2rgSKIXx
   zse22unVe4TAPjJs7J5YHpJiJrvPJknMxgaQy2NItBRTLr4bKU2BY8K18
   et5IET2zul67x55hoNim9Lejvt/IrfJZ0u875pP56ClupOGYILfakH+xv
   OE+GIxuWsojmoCceyur7ZiwX2S766wiwB6kjIC/mzw2LzVS2UvriqbPSB
   A==;
X-CSE-ConnectionGUID: gH7/8aoHTkC9O8UWcfiKhg==
X-CSE-MsgGUID: d1sEYQRBTOiT+03BKqtH6g==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="40584382"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="40584382"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2025 01:55:58 -0800
X-CSE-ConnectionGUID: 4KXKF5qqSG6cHO+hXJTLgA==
X-CSE-MsgGUID: Nxn171mhQp+cKg8TKTNXiw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="119288805"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.163])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2025 01:55:56 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v2 0/2] PCI: shpchp: Debug & logging cleanup
Date: Mon, 17 Feb 2025 11:55:48 +0200
Message-Id: <20250217095550.2789-1-ilpo.jarvinen@linux.intel.com>
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

This series cleans up debug/logging in shpchp driver.

The series is an update for the only remaining patch in the pci_printk()
removal series. To avoid breaking build, pci_printk() itself will only
be removed in the next kernel release because both AER and shpchp used
it and are in different topic branches.

v2:
- Split removal of logging wrappers and module parameter removal to
  own patches
- Explain how dynamic debugging can be enabled

Ilpo Järvinen (2):
  PCI: shpchp: Remove unused logging wrappers
  PCI: shpchp: Remove "shpchp_debug" module parameter

 drivers/pci/hotplug/shpchp.h      | 18 +-----------------
 drivers/pci/hotplug/shpchp_core.c |  3 ---
 2 files changed, 1 insertion(+), 20 deletions(-)


base-commit: d75ee0a7b0125636687a3f71c169bec04a576107
-- 
2.39.5


