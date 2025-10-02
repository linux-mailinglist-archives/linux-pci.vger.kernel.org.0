Return-Path: <linux-pci+bounces-37395-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B7F4FBB3425
	for <lists+linux-pci@lfdr.de>; Thu, 02 Oct 2025 10:44:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AEFDA7A899D
	for <lists+linux-pci@lfdr.de>; Thu,  2 Oct 2025 08:43:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 905592FD7D5;
	Thu,  2 Oct 2025 08:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KRLA4OMv"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B14F62FD7B1;
	Thu,  2 Oct 2025 08:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759394522; cv=none; b=Lu5Rgpdta7a02qLETbhXbU4Mbn04udmIado2RxfjJlPZSIYefYSyoxkmzpUjkjKt5nXxcTGayDeKh8yVQetJMUV5Vh/4dK5/Y46JdQ5ks6Xg3nNqsIMq3HIbrNvfeCUfGiZDxD0OsYpH0t/HpcuN9aTWlkEpV3/by4J2g1T9qJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759394522; c=relaxed/simple;
	bh=+FtP3eq0PeHkdOKnxERNZd0lz8T1pKK47VnKvzTXIDM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KtCgnxFKzYHz7/Y89z+OxEl807WI8clsq1oQj1V7EMei66XaeMAJuiaTISShR0B/95ExQ0PbYyYstXB0DP0UQL0akuhWnKlART1D0qiSo+Dj9eY1UvYXT0q/Mp2yplXyFq6kaE9kUzhnKal9IkXyFD4F5LsH5DwtoC/WIIs8smI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KRLA4OMv; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759394520; x=1790930520;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=+FtP3eq0PeHkdOKnxERNZd0lz8T1pKK47VnKvzTXIDM=;
  b=KRLA4OMvX1pQLliJtg8Y7OH/DVmoqerSSg0/ua9K6U1HuWOJF++wbuwC
   tzGpUAjJmvgU6qtE1AHV0yUeLq7JWXVC/UZWyJRvAh0bO+NpvO1+Q1yej
   TxlurCfhhKBJXZiJ1JRlvozZawo0Gsg8elT9IDYNvRY2EMjFoElVviRY/
   bJu1Vs6Nx2eaO5+vmIbz/K14GFQ/4wneK1iNq9b/uq6XHOgS7c4kNNJ5p
   g7DE9dusAiKCDAepjROs66OwdoIu/ZveRdKHGx8sz42MHPgBdPx/NYQI2
   b5as2xJe+ocPW/UwIzuUok0GMpKZ59ZX8+OR5WG/kvlBr4aNpFn8UjHEz
   A==;
X-CSE-ConnectionGUID: F5fIk4+nT465ivRO/RX6Ew==
X-CSE-MsgGUID: Z+Z53l98RbGlHRRcggNw7w==
X-IronPort-AV: E=McAfee;i="6800,10657,11569"; a="79099018"
X-IronPort-AV: E=Sophos;i="6.18,309,1751266800"; 
   d="scan'208";a="79099018"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2025 01:41:59 -0700
X-CSE-ConnectionGUID: jNtY2rMWTe2xjWafWBCFwA==
X-CSE-MsgGUID: txiw6bgrQ0O9wv9CHrBr7Q==
X-ExtLoop1: 1
Received: from slindbla-desk.ger.corp.intel.com (HELO pujfalus-desk.intel.com) ([10.245.246.8])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2025 01:41:56 -0700
From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
To: lgirdwood@gmail.com,
	broonie@kernel.org
Cc: linux-sound@vger.kernel.org,
	kai.vehmanen@linux.intel.com,
	ranjani.sridharan@linux.intel.com,
	yung-chuan.liao@linux.intel.com,
	pierre-louis.bossart@linux.dev,
	bhelgaas@google.com,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kw@linux.com
Subject: [PATCH 0/7] ASoC/SOF/PCI/Intel: Support for Nova Lake S
Date: Thu,  2 Oct 2025 11:42:45 +0300
Message-ID: <20251002084252.7305-1-peter.ujfalusi@linux.intel.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

this series adds initial support for NVL-S from the Nova Lake family.
NVL-S includes ACE4 audio subsystem, it has 2 DSP cores.

Regards,
Peter
---
Bard Liao (1):
  ASoC: Intel: soc-acpi-intel-nvl-match: add rt722 l3 support

Peter Ujfalusi (6):
  PCI: Add Intel Nova Lake S audio Device ID
  ALSA: hda/hdmi: intelhdmi: add HDMI codec ID for Intel NVL
  ASoC: Intel: soc-acpi: add NVL match tables
  ASoC: SOF: Intel: add initial support for NVL-S
  ALSA: hda: core: intel-dsp-config: Add support for NVL-S
  ALSA: hda: controllers: intel: add support for Nova Lake S

 include/linux/pci_ids.h                       |  1 +
 include/sound/soc-acpi-intel-match.h          |  2 +
 sound/hda/codecs/hdmi/intelhdmi.c             |  1 +
 sound/hda/controllers/intel.c                 |  2 +
 sound/hda/core/intel-dsp-config.c             |  8 ++
 sound/soc/intel/common/Makefile               |  1 +
 .../intel/common/soc-acpi-intel-nvl-match.c   | 90 +++++++++++++++++++
 sound/soc/sof/intel/Kconfig                   | 17 ++++
 sound/soc/sof/intel/Makefile                  |  2 +
 sound/soc/sof/intel/hda-dsp.c                 |  1 +
 sound/soc/sof/intel/hda.h                     |  1 +
 sound/soc/sof/intel/nvl.c                     | 55 ++++++++++++
 sound/soc/sof/intel/nvl.h                     | 14 +++
 sound/soc/sof/intel/pci-nvl.c                 | 82 +++++++++++++++++
 sound/soc/sof/intel/shim.h                    |  1 +
 15 files changed, 278 insertions(+)
 create mode 100644 sound/soc/intel/common/soc-acpi-intel-nvl-match.c
 create mode 100644 sound/soc/sof/intel/nvl.c
 create mode 100644 sound/soc/sof/intel/nvl.h
 create mode 100644 sound/soc/sof/intel/pci-nvl.c

-- 
2.51.0


