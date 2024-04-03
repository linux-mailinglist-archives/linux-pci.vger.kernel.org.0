Return-Path: <linux-pci+bounces-5612-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E95E896B87
	for <lists+linux-pci@lfdr.de>; Wed,  3 Apr 2024 12:05:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 789B0B2582F
	for <lists+linux-pci@lfdr.de>; Wed,  3 Apr 2024 10:03:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52484136672;
	Wed,  3 Apr 2024 10:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YtwosOw7"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA130135A57;
	Wed,  3 Apr 2024 10:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712138543; cv=none; b=ShPjzabxluZYfSCxeMqQr7DF31wvs1u3NMSXp/006gR0Qe9o88e0V1G4skH2OlWanNfXE6A/K8XpnSsopnm0ElLWprPi/Cns3ccYNhayq/A1S1aJ6/OIXWI+DOzMkUwl72c0CalWg5iDSPWSg1ZqNUAB+Edq94lW8t2X6xxmsks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712138543; c=relaxed/simple;
	bh=zMcY2t+u5tG57730wu67hVX3WkpcRHiwmVhu+ZGk6bc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=TnRvIjKNNcER/daws2AkFKa/jtuvqb4649/ItaJzwLdcWXU5zMSsWuWtrN1ERUUuy3DjQ33/gRbVoBRbSGgIdK0M/sDBTB9wIlt9hxSQSr4mi4iPESiYSTa9NPPn/s46CdGWd1TvhkSR/kocTkRortwH2UJkFYUanc3VcpttM58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YtwosOw7; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712138542; x=1743674542;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=zMcY2t+u5tG57730wu67hVX3WkpcRHiwmVhu+ZGk6bc=;
  b=YtwosOw7hsurj3pwzyZ/HZRQ8xiaMGX/7t20Ujrj9YQy9N49rBnxU6oA
   drtEiDzr060qiq0kRY+IvJHL8w7WPaPZZM36os27GWHg2M06+PiTdl4iW
   XOykmEAkZxlTPiPvw1GY6WfUIdaEDxf1EdMZ0DXJy/2kaZJxLHHlDsgSQ
   8zP4T7dXFEgNqHvxCGG1CJi2e4K6qFsphPXNDJeAhUyIHhsKS0dKb5Lmt
   okv2Oz074yOeIvwIFLvOcbfBA7Q+E9JsfO6/qG3tl3lQZQjVNiFWqXwzf
   HKklUcEyxiYU+onR3xTeEryV/U4zUrdGF6himWQJs7FfoMrc5ehrs9rZN
   g==;
X-CSE-ConnectionGUID: rBzYW4AnSw2EiHQhFcHjVQ==
X-CSE-MsgGUID: 3nkQl70EQJuar/ww+fvveQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11032"; a="24815747"
X-IronPort-AV: E=Sophos;i="6.07,177,1708416000"; 
   d="scan'208";a="24815747"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2024 03:02:21 -0700
X-CSE-ConnectionGUID: HTPohwHPT7OpZR498eG0uw==
X-CSE-MsgGUID: jFkbpWRlQsCVwgNVqJ/cgg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,177,1708416000"; 
   d="scan'208";a="23084724"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.24])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2024 03:02:19 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	"Oliver O'Halloran" <oohall@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v2 0/2] PCI: Consolidate TLP Log reading and printing
Date: Wed,  3 Apr 2024 13:02:04 +0300
Message-Id: <20240403100206.4403-1-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This series has the remaining patches of the AER & DPC TLP Log handling
consolidation.

v2:
- Don't add EXPORT()s
- Don't include igxbe changes
- Don't use pr_cont() as it's incompatible with pci_err() and according
  to Andy Shevchenko should not be used in the first place

Ilpo Järvinen (2):
  PCI: Add TLP Prefix reading into pcie_read_tlp_log()
  PCI: Create helper to print TLP Header and Prefix Log

 drivers/pci/ats.c             |  2 +-
 drivers/pci/pci.c             | 66 +++++++++++++++++++++++++++++++----
 drivers/pci/pcie/aer.c        | 14 +++-----
 drivers/pci/pcie/dpc.c        | 23 +++++++-----
 drivers/pci/probe.c           | 14 +++++---
 include/linux/aer.h           |  7 +++-
 include/linux/pci.h           |  2 +-
 include/uapi/linux/pci_regs.h |  2 ++
 8 files changed, 98 insertions(+), 32 deletions(-)

-- 
2.39.2


