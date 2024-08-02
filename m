Return-Path: <linux-pci+bounces-11185-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A52DF945DEF
	for <lists+linux-pci@lfdr.de>; Fri,  2 Aug 2024 14:40:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6529D284618
	for <lists+linux-pci@lfdr.de>; Fri,  2 Aug 2024 12:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36A011E288E;
	Fri,  2 Aug 2024 12:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SXSmyeqW"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 459151E287E;
	Fri,  2 Aug 2024 12:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722602425; cv=none; b=WqjfOE7zXNAQWUawzI/X1Pk4avQDc6bi64BVMlbPT4hcnLeq7PJF2Tg+0IEBvf22HEU/ygEIgARnigiPho1lS30tOz/Qcls5J4Ksza0AwEBKAdZ6z7XMpJroTkMfowe2k9KCeODAt0/d8B7pWpONkV6IPzKogKwZ2UrYaKthSik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722602425; c=relaxed/simple;
	bh=WTSJwv/19uap5j9vdOZH9IINjQPo/rKXf2y1UW7I5Ig=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jbXxRRkkCXrWDxzdEkA6qJFnsHyiTovbC1x3DqPwJhDfrt+7HIbAHEREy/3i7nd4IvuIz7jEG8y+wGW+4hLoitHzbkU3LmLx3gS0vSP5Sm3dGsTUlLuZ1o7Hz2d5CHFmCnf+Ohuca4+cA/ZQODOUcsA/0f9chFP1MyudqQA2fb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SXSmyeqW; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722602423; x=1754138423;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=WTSJwv/19uap5j9vdOZH9IINjQPo/rKXf2y1UW7I5Ig=;
  b=SXSmyeqWo+idgd9iDfL0PBhrHp5oRI65iWyeCppUZgwCIJ2Fy5oF36qJ
   3Z3rvjjhCAecPnwE0qXftc0GeuZAmro7CCrnnXkR8luhnCG+NB/ZkrT2p
   svn6zwEY1KKgQcKrn/N4dqc0Vg2g5zLTqeV9gQldGlPQwZ88M01M4KONj
   T343V4OREHpjTWCt7OEtDlYfnsfNrivHaGpzbchxhASEapWC9QYVPX57b
   KVXDfE0az+kZyBYoLXhnsu9Lfk57TVV9Jsoz+6ty72jrnEBytgIuDJXPT
   MJa1PlqMU4lZeC3UlVQCM4LCOYiOmhIprETDt6toOhjY0tWOo7ZEWptt0
   Q==;
X-CSE-ConnectionGUID: Pl5sXy6NQMOAYp0od5cHNQ==
X-CSE-MsgGUID: e6tGJvJFRzS84OCzDbtAyA==
X-IronPort-AV: E=McAfee;i="6700,10204,11152"; a="24488162"
X-IronPort-AV: E=Sophos;i="6.09,257,1716274800"; 
   d="scan'208";a="24488162"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2024 05:40:22 -0700
X-CSE-ConnectionGUID: CWHzzN24SrqeQhVc6ZEudw==
X-CSE-MsgGUID: VBN6K++MS8SZ0DYAT0XFCg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,257,1716274800"; 
   d="scan'208";a="55024685"
Received: from ltuz-desk.ger.corp.intel.com (HELO pbossart-mobl6.intel.com) ([10.245.246.89])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2024 05:40:20 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: linux-sound@vger.kernel.org
Cc: alsa-devel@alsa-project.org,
	tiwai@suse.de,
	broonie@kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH v4 0/5] ASoC/SOF/PCI/Intel: add PantherLake support
Date: Fri,  2 Aug 2024 14:40:06 +0200
Message-ID: <20240802124011.173820-1-pierre-louis.bossart@linux.intel.com>
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

All the dependencies required in the initial versions are now
available in ASoc for-next branch.

v4: topology name simplification for rt722

v3: add configuration with rt722 on Link3 

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


