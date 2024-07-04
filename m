Return-Path: <linux-pci+bounces-9785-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1795927224
	for <lists+linux-pci@lfdr.de>; Thu,  4 Jul 2024 10:53:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2BE01C23E22
	for <lists+linux-pci@lfdr.de>; Thu,  4 Jul 2024 08:53:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 248A318FC7F;
	Thu,  4 Jul 2024 08:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iUES+m0k"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 907881A38CF;
	Thu,  4 Jul 2024 08:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720083225; cv=none; b=RrtiANOlk1tMj9YeYi0IR+kPMN9pjIZ7Ktga5VRx9rSjJfs7P+Xsj4ANqoVT0+bqwPFJD1Go/4lmNV5k+r7pqs9FWk0v9UJqpxT2J2CpCzQnMJnumX92VHwY2p7HdwlXDzPjEFZP1fvEUD0hF0wTRILYLMX2XhWAX2Ywtp7ZeoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720083225; c=relaxed/simple;
	bh=UNRYpd+9f7kr4GRq9tXRcx9f9lwuRwZ87AXzjG7zi9E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=omj4Opygjd10e3j7/zexoH1rN9JUWsw8hLRgpAao92r0xVdvlSprZmhV8zM1MWlJoC9lOdzerNBMnFQ0W4+B3q0neDHmAX67qyNBr2toRA5fYah5Kp2A9pieOD3XYJeltODCAXURRpabZ/RXTVuVxsas/s+vLiUNY3L/Rnzuhwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iUES+m0k; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720083224; x=1751619224;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=UNRYpd+9f7kr4GRq9tXRcx9f9lwuRwZ87AXzjG7zi9E=;
  b=iUES+m0kQy9Fdr1Pnojg5OfAwFM2mZGmL5Ms5B5PopgyjNsbwMtjJH8b
   Np56+fr00G4XtN1w5NRAQDs5CHfUkmqNOnidvMVqjKYx1cAETJjbr7b8U
   6mvZ5+KvIuf5EcUpbbKgW5lb4r3QyT3MruLmbSDUHEGQe55h2PFJSCrB5
   BUIy+5cswGtPdKA9yBg2mKlZ8Zxl78M/nDEi3RyhKEhcF+oA/1bz0k7rR
   70pzgWkWCg9Mc3cJp7eKDkn+JM4YzTfrkDvATUN0Gw9s7QiFUVhiNSha6
   ed95OEKGaJvilTa3JGGWayvLHplGrMIVrac72TALGqhmaXYcEwAeVnNu+
   w==;
X-CSE-ConnectionGUID: INwi9b/8Qz2V6tqImtPHrA==
X-CSE-MsgGUID: bHcxPp9FSYm3SULqhgUI9A==
X-IronPort-AV: E=McAfee;i="6700,10204,11122"; a="17300573"
X-IronPort-AV: E=Sophos;i="6.09,183,1716274800"; 
   d="scan'208";a="17300573"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2024 01:53:43 -0700
X-CSE-ConnectionGUID: jqMlLn/0SVS5JDDFoCTFpw==
X-CSE-MsgGUID: 4i8Sin7YSB+U2199esydrQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,183,1716274800"; 
   d="scan'208";a="51708472"
Received: from bergbenj-mobl1.ger.corp.intel.com (HELO pbossart-mobl6.intel.com) ([10.245.246.90])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2024 01:53:40 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: linux-sound@vger.kernel.org
Cc: alsa-devel@alsa-project.org,
	tiwai@suse.de,
	broonie@kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH v3 0/6] ASoC/SOF/PCI/Intel: add PantherLake support
Date: Thu,  4 Jul 2024 10:53:24 +0200
Message-ID: <20240704085330.371332-1-pierre-louis.bossart@linux.intel.com>
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
PantherLake audio support". To apply this on the ASoC tree, a merge of
Takashi's for-next branch is required.

v3: add configuration with rt722 on Link3 

v2: changed order of patches to fix git bisect error reported by Intel
kbuild bot
https://lore.kernel.org/oe-kbuild-all/202406131144.L6gW0I47-lkp@intel.com/

Bard Liao (3):
  ASoC: Intel: soc-acpi-intel-ptl-match: add rt711-sdca table
  ASoC: Intel: soc-acpi-intel-ptl-match: Add rt722 support
  ASoC: Intel: soc-acpi-intel-ptl-match: add rt722 l3 adr

Fred Oh (1):
  ASoC: SOF: Intel: add PTL specific power control register

Pierre-Louis Bossart (2):
  ASoC: Intel: soc-acpi: add PTL match tables
  ASoC: SOF: Intel: add initial support for PTL

 include/sound/soc-acpi-intel-match.h          |   2 +
 sound/soc/intel/common/Makefile               |   1 +
 .../intel/common/soc-acpi-intel-ptl-match.c   | 145 ++++++++++++++++++
 sound/soc/sof/intel/Kconfig                   |  17 ++
 sound/soc/sof/intel/Makefile                  |   2 +
 sound/soc/sof/intel/hda-dsp.c                 |   1 +
 sound/soc/sof/intel/hda.h                     |   1 +
 sound/soc/sof/intel/lnl.c                     |  27 ++++
 sound/soc/sof/intel/mtl.c                     |  16 +-
 sound/soc/sof/intel/mtl.h                     |   2 +
 sound/soc/sof/intel/pci-ptl.c                 |  77 ++++++++++
 sound/soc/sof/intel/shim.h                    |   1 +
 12 files changed, 290 insertions(+), 2 deletions(-)
 create mode 100644 sound/soc/intel/common/soc-acpi-intel-ptl-match.c
 create mode 100644 sound/soc/sof/intel/pci-ptl.c

-- 
2.43.0


