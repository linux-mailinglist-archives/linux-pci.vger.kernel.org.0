Return-Path: <linux-pci+bounces-8633-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BF54904C2C
	for <lists+linux-pci@lfdr.de>; Wed, 12 Jun 2024 08:59:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BB2F1B2346E
	for <lists+linux-pci@lfdr.de>; Wed, 12 Jun 2024 06:59:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 520BE1649DB;
	Wed, 12 Jun 2024 06:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G+eIKMLQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D35E12D75F
	for <linux-pci@vger.kernel.org>; Wed, 12 Jun 2024 06:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718175566; cv=none; b=DKrnEtS3B614M7/wSa2mp9hySRGBP9ur7m8JNrDw9JnHRSwcKu76uKKvh6T8ihF8YZ/+h7hho6NToWMzn+ICOIg2bMir7mkW+QUAlqodXaA8z7c9KJQQZvfcVR7GS1GX1SzpEFysDSlg2h+LjPmSLCyKhzlUoajXvlPYLZDZ99c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718175566; c=relaxed/simple;
	bh=3kGtXqPNTI6+znpzbrWbnTAox2zm1Vd8WVrUNVVII14=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rFZGUEGoVAwAx3FnpScEXneNWryJtR25Uo6To3+KThWdCwE4La+cryLfcFfGn6WAH+gs8lQUOy2V9Z0MRXasxraIP/pnR/EnFMRS9MWfcW6h5aIxsL9/To3zeeiMOUHeF8JI9XaUV8ilQxToN7YV90BZPWArHnIGpDmYDYGcEG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G+eIKMLQ; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718175564; x=1749711564;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=3kGtXqPNTI6+znpzbrWbnTAox2zm1Vd8WVrUNVVII14=;
  b=G+eIKMLQF7QgwCpSEjK4P3xn/zANmg26J1kETBT/OYsTlRs3CYUdW3T0
   EqcYXEcdO3ZzYDJ+shmBL5VIBwwqpf1F6yDONfscZMvCtgxIbdlu7VJkd
   oJnjWNK3OxVQbhwzF1jxygNNEynyyrDCrvm8v2gu/w5dBN9uuAlTNSpyS
   9f/vJPuuY4t3DXM6DzpKU/8bB/XCQeJz4WlaHgLpJRgOGtFWrUaZT/6ei
   y/0OZ8rMgYDS/AaZ6CvS4pQbg97XLPPqrXATEmxdCWqhRAcck9ArU5sQo
   XRCM4FyX5HFFwCgodzWkKs7o4cxMZ8qaZz+y5pJhcmcQWf+4No055kqcU
   w==;
X-CSE-ConnectionGUID: 07alkQPORLS277i280I+EA==
X-CSE-MsgGUID: hl1KUHylSJa9lPLJJTmS+g==
X-IronPort-AV: E=McAfee;i="6600,9927,11100"; a="15147401"
X-IronPort-AV: E=Sophos;i="6.08,232,1712646000"; 
   d="scan'208";a="15147401"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2024 23:59:23 -0700
X-CSE-ConnectionGUID: gbtX+fY8QoKCYoPFEyQpIg==
X-CSE-MsgGUID: 9R1l8MqVQFyxY9UcIsXgjw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,232,1712646000"; 
   d="scan'208";a="70486822"
Received: from iklimasz-mobl1.ger.corp.intel.com (HELO pbossart-mobl6.intel.com) ([10.245.246.56])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2024 23:59:22 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de,
	broonie@kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 0/5] ASoC/SOF/PCI/Intel: add PantherLake support
Date: Wed, 12 Jun 2024 08:58:53 +0200
Message-ID: <20240612065858.53041-1-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add initial support for the PantherLake platform, and initial ACPI
configurations.

This patchset depends on the first patch of "[PATCH 0/3] ALSA/PCI: add
PantherLake audio support"

Bard Liao (2):
  ASoC: Intel: soc-acpi-intel-ptl-match: add rt711-sdca table
  ASoC: Intel: soc-acpi-intel-ptl-match: Add rt722 support

Fred Oh (1):
  ASoC: SOF: Intel: add PTL specific power control register

Pierre-Louis Bossart (2):
  ASoC: SOF: Intel: add initial support for PTL
  ASoC: Intel: soc-acpi: add PTL match tables

 include/sound/soc-acpi-intel-match.h          |   2 +
 sound/soc/intel/common/Makefile               |   1 +
 .../intel/common/soc-acpi-intel-ptl-match.c   | 121 ++++++++++++++++++
 sound/soc/sof/intel/Kconfig                   |  17 +++
 sound/soc/sof/intel/Makefile                  |   2 +
 sound/soc/sof/intel/hda-dsp.c                 |   1 +
 sound/soc/sof/intel/hda.h                     |   1 +
 sound/soc/sof/intel/lnl.c                     |  27 ++++
 sound/soc/sof/intel/mtl.c                     |  16 ++-
 sound/soc/sof/intel/mtl.h                     |   2 +
 sound/soc/sof/intel/pci-ptl.c                 |  77 +++++++++++
 sound/soc/sof/intel/shim.h                    |   1 +
 12 files changed, 266 insertions(+), 2 deletions(-)
 create mode 100644 sound/soc/intel/common/soc-acpi-intel-ptl-match.c
 create mode 100644 sound/soc/sof/intel/pci-ptl.c

-- 
2.43.0


