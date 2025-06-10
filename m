Return-Path: <linux-pci+bounces-29303-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DB795AD3375
	for <lists+linux-pci@lfdr.de>; Tue, 10 Jun 2025 12:21:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE119174A7B
	for <lists+linux-pci@lfdr.de>; Tue, 10 Jun 2025 10:21:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B521A28D8D0;
	Tue, 10 Jun 2025 10:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E2p6GTTh"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFC6528C2C2;
	Tue, 10 Jun 2025 10:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749550872; cv=none; b=q1fR4HjIfo+0ka9vA8lU319ajLbmOgYfq9nDgEWGX1e4Nx1JjxQ5QtODjodpaWQp009udDYpTU7roiHg3BdNH5NpFh9CkUPicIOV8vlGl1XUpZQuuPFm6rE+4BkCeWjeuXLHFm50jh8B6YAOQjJisX+OO1nYnpgUu4ceTsR44wQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749550872; c=relaxed/simple;
	bh=5N56gxd7eiTVDu0e1+YTiAnXkuv2TmMh68XjUz4UO9w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=SNW3tvVP8i4AjMXPn+lhgq8+U/rJaFU8qFfenQYqK4zxtjugBqSq16V4oGljnt7Flwfgeqvp9MkCrU6+kXs0V82oQR4als8VDCcjHxqcsZkRQ9MX6GqswS1Ult7GT7Y9KlNJaKA7pmcNYkRo66mgcdwBVDkOpAxWILRWlF+xg6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=E2p6GTTh; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749550871; x=1781086871;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=5N56gxd7eiTVDu0e1+YTiAnXkuv2TmMh68XjUz4UO9w=;
  b=E2p6GTThZFGFEIp7wbQLwuaINL8EQz+gZ52wttcwGGm3gPd4B5X4R2Cl
   Ba7l/ctdzQsbK/kOvwhl2ZCgFegrPEIAnjZeOrbtDSo+C+vkwYFnhgWiW
   Mbj2F7QfrPZZSj9qgaeQghQDQzw9io6+cnjMbub1y1pSyUZdIuu3A9PeG
   Br0bm2c7yhT96V4xtECoeosItoCrErxvWn2Qbkrb+ioIh9L7T2v1apH2y
   xnx1ir59Gi//yEagQLth1N4ydndGfNBoWPb+EaiWwXEPJ2F2PwZznvlwg
   3bMsy9yzSPyFaXtrkP9SdUF0Ji3KC/S/EFkDm/9oARrDD/L7wssFi/N0O
   w==;
X-CSE-ConnectionGUID: 8IWWDbozRJu1Lsx2n4593g==
X-CSE-MsgGUID: vaQ4YP6/RCSdVVM5lblV2A==
X-IronPort-AV: E=McAfee;i="6800,10657,11459"; a="51739072"
X-IronPort-AV: E=Sophos;i="6.16,224,1744095600"; 
   d="scan'208";a="51739072"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2025 03:21:11 -0700
X-CSE-ConnectionGUID: llqcJ675TmCXQrUZXfdEcg==
X-CSE-MsgGUID: qHytsrJ/RVCsSYEIi/QkXg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,224,1744095600"; 
   d="scan'208";a="147370164"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.196])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2025 03:21:08 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Rio <rio@r26.me>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
Cc: linux-kernel@vger.kernel.org,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 0/2] PCI: Two resource fitting algorith fixes
Date: Tue, 10 Jun 2025 13:20:59 +0300
Message-Id: <20250610102101.6496-1-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Thanks to reporters bisecting their issues into the recent PCI
resource fitting and assignment rework changes, I've located two
issues in the algorithm which are addressed by this series.

Ilpo Järvinen (2):
  PCI: Relaxed tail alignment should never increase min_align
  PCI: Fix pdev_resources_assignable() disparity

 drivers/pci/setup-bus.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)


base-commit: 19272b37aa4f83ca52bdf9c16d5d81bdd1354494
-- 
2.39.5


