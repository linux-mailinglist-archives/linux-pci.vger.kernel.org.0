Return-Path: <linux-pci+bounces-20908-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E4FBDA2C866
	for <lists+linux-pci@lfdr.de>; Fri,  7 Feb 2025 17:19:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F2613A2335
	for <lists+linux-pci@lfdr.de>; Fri,  7 Feb 2025 16:18:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D651182D9;
	Fri,  7 Feb 2025 16:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e5YYyGpq"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AACF23C8C5;
	Fri,  7 Feb 2025 16:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738945140; cv=none; b=baZLFE7bqgVORnXH+qnY5GJo+tLd5+r1rZditjhXRYp2pgpMz+iitl58pmNunCQQEhdcIj70S2BVjDzax4eQru5hKAf+3UbR0vN+v61SWaldO6k5dwRKovRXdNfVW2CFS/pOdXw5HXGzif11Q8jQcLY20pvC1Px1BbaHz4unQ1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738945140; c=relaxed/simple;
	bh=ffYOgS4UhPejR6mXfcmPkQCxK4R+XKjUS4+aNbxNe9I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=IWMlzgB5CVdqhFRWTvQO085vCKd8rbKOC7MizdmN3sLMZd055T0GXCRT1oE2ky2jf4yFYzelVL03Ygga7YrYw/zbNvmfGeV/3kizXZy12jlu5hEvtCanwAaHlpmGrq5lkWAoAnWnhLGh9Ca1en9+vy+9w3JEmWj+NC9HjIwEhpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e5YYyGpq; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738945139; x=1770481139;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ffYOgS4UhPejR6mXfcmPkQCxK4R+XKjUS4+aNbxNe9I=;
  b=e5YYyGpq6sSS236QgoiGWyfGl3eOCVUqhSOERgEXFupUC1zjFURAzyvX
   GFC2yJNj2khlSc3ICsnVE3otpFAnuObEaamtXdfDPMYQ61Efn15eLCiBz
   QCOBDy3OGHNTWIWCIYrzS1/tVFfO2vUPqcnlNdAoLHKBaDhj6uLZz1ns1
   cuKC6fvgZpY0h5xzCeicm2W69kOPGGQUeqghDLBmZ/C8qvSxhTJBCU85e
   2fcV6vEIYd37X0KE28BBrdwD1en2TDG4EgZIUlPr8qoQf5Bm5rZyor2V/
   6IbSoAyrsT5UIkkn3PcjGYrh3H+8ZEe2MlkzJXzIF48mk6U0N6vcRC/nY
   Q==;
X-CSE-ConnectionGUID: zYUjbysLRCOdfSCxpwGcSQ==
X-CSE-MsgGUID: K6oxL43qT92dal6QKpJ8tQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11338"; a="57006818"
X-IronPort-AV: E=Sophos;i="6.13,267,1732608000"; 
   d="scan'208";a="57006818"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2025 08:18:58 -0800
X-CSE-ConnectionGUID: uxOX1lgPSoii9D6Sxtphgg==
X-CSE-MsgGUID: Prm7B2SPQRG+ICL20NFI0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="116502373"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.116])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2025 08:18:54 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org,
	Lukas Wunner <lukas@wunner.de>,
	Yazen Ghannam <yazen.ghannam@amd.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: linux-kernel@vger.kernel.org,
	Borislav Petkov <bp@alien8.de>,
	linux-edac@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	"Oliver O'Halloran" <oohall@gmail.com>,
	Tony Luck <tony.luck@intel.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v2 0/2] PCI: Add support for logging Flit Mode TLPs (PCIe6)
Date: Fri,  7 Feb 2025 18:18:34 +0200
Message-Id: <20250207161836.2755-1-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This series adds support for Flit Mode (PCIe6).

v2:
- Rebased

Ilpo Järvinen (2):
  PCI: Track Flit Mode Status & print it with link status
  PCI: Handle TLP Log in Flit mode

 drivers/pci/hotplug/pciehp_hpc.c |  5 +--
 drivers/pci/pci.c                | 12 ++++---
 drivers/pci/pci.h                |  6 ++--
 drivers/pci/pcie/aer.c           |  1 +
 drivers/pci/pcie/dpc.c           | 18 ++++++++--
 drivers/pci/pcie/tlp.c           | 56 ++++++++++++++++++++++----------
 drivers/pci/probe.c              |  5 +--
 include/linux/aer.h              | 12 +++++--
 include/linux/pci.h              |  1 +
 include/ras/ras_event.h          | 12 +++----
 include/uapi/linux/pci_regs.h    |  6 +++-
 11 files changed, 94 insertions(+), 40 deletions(-)


base-commit: 2014c95afecee3e76ca4a56956a936e23283f05b
-- 
2.39.5


