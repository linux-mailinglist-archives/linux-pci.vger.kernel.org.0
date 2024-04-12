Return-Path: <linux-pci+bounces-6183-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 450358A2F9B
	for <lists+linux-pci@lfdr.de>; Fri, 12 Apr 2024 15:36:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C743BB225B9
	for <lists+linux-pci@lfdr.de>; Fri, 12 Apr 2024 13:36:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53E0483CD3;
	Fri, 12 Apr 2024 13:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i1y1lOn9"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A96D97E108;
	Fri, 12 Apr 2024 13:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712929009; cv=none; b=K+Te1xJsCDSU4UZa2zt+brr3ttsWgwSJz0xLYTMNVXfGCN2hIE3h2bhY0LFVMOhr2Ps/p+PBCjPXqb68V+Gng+YuM6SuZAGYr00VqAM7fMNkd3YSv3holVmKfY4OmQWuCROfOQtssAorSymBPGFhytUHCn4RyKsCEXAPwNQfRiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712929009; c=relaxed/simple;
	bh=UA1sS56M2vTYHjdAbQdVD560pz+AgXlcwN7dZXpHgAk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=D1MT7zCQmX4PqwzoFwC29Ol0jmoco1cw5x0Hn5+VnCFn8xNpdpR99lT0LgjYu7AomNL2BCqDJkyDdSvelCycKePT/CzT8IclZlAgBBhRIqlMqfAHSEtJXsEaMUPxZD+13Wh96kXE1Oxb3ywsXTncf40yqJboauwS3uik8esAx74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i1y1lOn9; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712929007; x=1744465007;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=UA1sS56M2vTYHjdAbQdVD560pz+AgXlcwN7dZXpHgAk=;
  b=i1y1lOn9mG7lba9/BkIsfDqsnS6/z/gpit+8HPn0b5+oAgmd5aiVmdlh
   wv4xk6xNcaTbSo2WuLvBgaXZJqkhjsMuYRkIB7T5NRmotPh+zIgmUG+n2
   O6HjRErCy/GOVLLAEtyy6++RRhz5LIvc39QIwmviqJIs0DB0j8eClq1/h
   lMd4WqdwaSbLFnEpNYdIJrfwzl4QpORV/JRH5M3PKW9fpblB7HyrXeKXt
   41ZUUmmpjNdNdgMflJTPlbgnH/RilHQQ/FWVDHX6awV0jxvocCvFbt1Hh
   gPXpm3SJmmtFzQHHLv5vxXAJsE862rSE940wNRpVqKQhVrnbEw+xmp1k2
   A==;
X-CSE-ConnectionGUID: ES3oa4UPQc6f1azagZjptw==
X-CSE-MsgGUID: 70F8Aei6TC+YZ2JjC3CMWg==
X-IronPort-AV: E=McAfee;i="6600,9927,11041"; a="25897874"
X-IronPort-AV: E=Sophos;i="6.07,196,1708416000"; 
   d="scan'208";a="25897874"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2024 06:36:46 -0700
X-CSE-ConnectionGUID: ZBZQ50teQMiKo5vgjat3hQ==
X-CSE-MsgGUID: 9eukN5+eSm6g0F6L2hBfoQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,196,1708416000"; 
   d="scan'208";a="58662876"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.32])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2024 06:36:43 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver O'Halloran <oohall@gmail.com>,
	Lukas Wunner <lukas@wunner.de>
Cc: linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v3 0/2] PCI: Consolidate TLP Log reading and printing
Date: Fri, 12 Apr 2024 16:36:33 +0300
Message-Id: <20240412133635.3831-1-ilpo.jarvinen@linux.intel.com>
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

v3:
- Small rewording in a commit message

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


