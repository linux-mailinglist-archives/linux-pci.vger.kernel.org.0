Return-Path: <linux-pci+bounces-8707-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6941A90642B
	for <lists+linux-pci@lfdr.de>; Thu, 13 Jun 2024 08:37:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 067C8B2174A
	for <lists+linux-pci@lfdr.de>; Thu, 13 Jun 2024 06:37:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71323137753;
	Thu, 13 Jun 2024 06:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="irhoQ9gv"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8B3412C7E3;
	Thu, 13 Jun 2024 06:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718260666; cv=none; b=j431q3TSea+Q/VBOYdlhLwLiV9e3oDEEFdWVa5FbE8nCZE60Tnt8BP6poXbf3LwSS/6AM8/E6VbxHEDZ7cMBcX3AirGOS/sWDwJKQLAk6I88pgyx7MMbEOleGaNu9+QOu7mg/mH4rcpwHptxeGUSn1PLZLoksw6j8EYgddXA1J0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718260666; c=relaxed/simple;
	bh=ONxqZUwSB91wyQpYjEvWjtZBUsrSB8OmWi61DcHx7HM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nY0OZYygChmlXkaoofOE2qY52XTHfsCyS2TyMstQrxl6R4XsWpcBywABg0C5JlkZ52mweL695MnFNiiAgHgbsbm68r2d5ZoyANfMfwwzCPNsW14+UnfCzuP6pMe9EcKJgnrmoOabX5kCM/vsbkd5vKe0IhcUDa4w6eBxLqmnDa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=irhoQ9gv; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718260665; x=1749796665;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ONxqZUwSB91wyQpYjEvWjtZBUsrSB8OmWi61DcHx7HM=;
  b=irhoQ9gvI6EwbxujdQqNCrB83Md4LPhPG1LuSeyEHbHYCXRRzKS/FI0L
   tc3oyTi8YugYDsAiybSXblj6CVFhXMCEDFoEEpacShY9EniHriKhyKsKL
   sg1ri6bA4+A/HKOrdkPJ44drqYnZpUosWd6S4h5wCbIX0ygo1CcdwiAKi
   3Z2pNp6wd+uGxlMlIIxyeN8Ko9BgkwtZ58guFaNDdLoOL5tK08A5jco2A
   lZGa9wVggzKLuaGaTJ2HnJqzBILv8rmAtwA3Z4LrbXLfe8XMLCEorSjvl
   Du6g53e+xjIKG9isBXHzv/LvA5EBv94irNhYo+IOrNdBaBjRGDvprgoCu
   Q==;
X-CSE-ConnectionGUID: FlgUGFWDTv642z9ahqXEuQ==
X-CSE-MsgGUID: I9gFUk6RQcamB4ILl8Dr9g==
X-IronPort-AV: E=McAfee;i="6700,10204,11101"; a="25736594"
X-IronPort-AV: E=Sophos;i="6.08,234,1712646000"; 
   d="scan'208";a="25736594"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2024 23:37:45 -0700
X-CSE-ConnectionGUID: M4T4MqXfQKOVirQ5sYmTSg==
X-CSE-MsgGUID: Ql1aBbx/RrOwqmStiHjiSQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,234,1712646000"; 
   d="scan'208";a="39960898"
Received: from fdefranc-mobl3.ger.corp.intel.com (HELO pbossart-mobl6.intel.com) ([10.245.246.108])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2024 23:37:42 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: linux-sound@vger.kernel.org
Cc: alsa-devel@alsa-project.org,
	tiwai@suse.de,
	broonie@kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH v2 0/5] ASoC/SOF/PCI/Intel: add PantherLake support
Date: Thu, 13 Jun 2024 08:37:27 +0200
Message-ID: <20240613063732.241157-1-pierre-louis.bossart@linux.intel.com>
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

v2: changed order of patches to fix git bisect error reported by Intel
kbuild bot
https://lore.kernel.org/oe-kbuild-all/202406131144.L6gW0I47-lkp@intel.com/


Bard Liao (2):
  ASoC: Intel: soc-acpi-intel-ptl-match: add rt711-sdca table
  ASoC: Intel: soc-acpi-intel-ptl-match: Add rt722 support

Fred Oh (1):
  ASoC: SOF: Intel: add PTL specific power control register

Pierre-Louis Bossart (2):
  ASoC: Intel: soc-acpi: add PTL match tables
  ASoC: SOF: Intel: add initial support for PTL

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


