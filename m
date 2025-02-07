Return-Path: <linux-pci+bounces-20888-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C16DA2C3C6
	for <lists+linux-pci@lfdr.de>; Fri,  7 Feb 2025 14:37:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A50611881ECA
	for <lists+linux-pci@lfdr.de>; Fri,  7 Feb 2025 13:37:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED52F1EDA1A;
	Fri,  7 Feb 2025 13:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VxFjthoS"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E71D1EEA5D;
	Fri,  7 Feb 2025 13:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738935423; cv=none; b=A2ZY4XbpwVD4QdLcXCmZ+634Xv6ouYHn28Icte14+x1dvIVJ0WD3SksLlSMh5rHCb8cPSzJ0HGN6atKW7Neb2/zQml0a9zlxIBQUxzNA4VNTzc3sUtHExCrcF9fEK4/6hRuCJWxZKdFQQO07fiY0Ft7ciomWqnqQZC3OC/jT/ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738935423; c=relaxed/simple;
	bh=GrYVPUVCxBlwjDBUoGoznWr9p6kLpem8kAYPNvRZho8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=b/LOk+vOU21M/RhYVt3ZDJOZWlpzsVmTUWuoty1u8a0cLKEkHFLftfoNbEhi5dLNiC7tRw0dKzRm93LcT0Rlu0GYmr4MOvFxbrnVhPmHBbg1pogmxe/yowQw6vjNfDhjX2I6q+LFbmEdAmwBXKCMJdcEI0osFxNsce7gKj7FDtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VxFjthoS; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738935422; x=1770471422;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=GrYVPUVCxBlwjDBUoGoznWr9p6kLpem8kAYPNvRZho8=;
  b=VxFjthoSX6tvS9xd4f8WM1FRZW4T3DOC4u8gIasVtHyrCnO/wJOxls1f
   xWpLhTlYUQzAlLE+VtVURFQTU0MJhz9y9mFAoQdiNoGYT2+QoR9J/Bjgu
   5HdO2NBLpsIgzvF+Y31NcKiSjQiZghW6QheBU865QD4pAWT19FmOM/MeT
   VfL+Ij9IB/pMs3FRwS2jb0jZv9ImnZy+Ew5Yhc4LEeBdPUSsdil/IY4oJ
   l2Nh09RYRBhNv8RLtxxNSddr2SPbRpwERYrXD/3vO4HfeFyVzk/K9lW7x
   ecNBEnJ3rHV3qXns+yU2q1r4aniUPFM9Zwtf+EXP8MNoHRtnbHAw24U4R
   Q==;
X-CSE-ConnectionGUID: 5mGHrOl5Qra/kR2ZjWSnTA==
X-CSE-MsgGUID: +rzdJBvyR1KLvQ/qcTxpCw==
X-IronPort-AV: E=McAfee;i="6700,10204,11338"; a="39268393"
X-IronPort-AV: E=Sophos;i="6.13,267,1732608000"; 
   d="scan'208";a="39268393"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2025 05:37:01 -0800
X-CSE-ConnectionGUID: k6u9HrYgSVinBUJrrgOnuQ==
X-CSE-MsgGUID: n69htDP+Q4elLpfFFrYrJQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="148739840"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO pujfalus-desk.intel.com) ([10.245.246.100])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2025 05:36:58 -0800
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
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] ASoC/SOF/PCI/Intel: add PantherLake H support
Date: Fri,  7 Feb 2025 15:37:32 +0200
Message-ID: <20250207133736.4591-1-peter.ujfalusi@linux.intel.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

The audio IP in PTL-H is identical to the already supported PTL but the
PCI-ID has been changes due to the differences in the product's
configuration outside of audio.

To support PTL-H we really just need to wire up the new ID.

Regards,
Peter
---
Peter Ujfalusi (1):
  ASoC: SOF: Intel: pci-ptl: Add support for PTL-H

Pierre-Louis Bossart (3):
  PCI: pci_ids: add INTEL_HDA_PTL_H
  ALSA: hda: intel-dsp-config: Add PTL-H support
  ALSA: hda: hda-intel: add Panther Lake-H support

 include/linux/pci_ids.h       | 1 +
 sound/hda/intel-dsp-config.c  | 5 +++++
 sound/pci/hda/hda_intel.c     | 2 ++
 sound/soc/sof/intel/pci-ptl.c | 1 +
 4 files changed, 9 insertions(+)

-- 
2.48.1


