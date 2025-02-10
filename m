Return-Path: <linux-pci+bounces-21059-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8298EA2E61F
	for <lists+linux-pci@lfdr.de>; Mon, 10 Feb 2025 09:17:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A69A3A8929
	for <lists+linux-pci@lfdr.de>; Mon, 10 Feb 2025 08:16:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23ACF1B85D6;
	Mon, 10 Feb 2025 08:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Wd6+Jbfw"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68C37185B62;
	Mon, 10 Feb 2025 08:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739175417; cv=none; b=aaImDCPM5T4NXnp+/b+OHg2g3sG2L24KhcU1T3gBvQyltSER5FDMbBf5aP05UXqSm1PDMEzSfpk88jLnZv0BjHKzCbRs9gjm+LslVbVIC77Zb1dIAGMcdC0ry6q9i+raOE9/5Cy7qh289SD2GGzePe+fZxXAv1755tIx1XRfzo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739175417; c=relaxed/simple;
	bh=RUtPk1rDw/fT5TrMDeTltRRfah+6wBW+dWQgNzcvTiM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DW4Um2M/mudT4j7vDt9zKTQNZaEE5ACRA9rBMIxKSAh3ZJDl6OycotcAl3EgFAsmE8TSJ2bt46+SGME021FhljKY/WY4PW8yf4ZEfhAhfAgbKalGLdFqxzX4/ffUm+4bUHeCRLCEQebO9ZbSxf9NPk93Tjo0mRK9MYEbqU8cr7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Wd6+Jbfw; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739175416; x=1770711416;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=RUtPk1rDw/fT5TrMDeTltRRfah+6wBW+dWQgNzcvTiM=;
  b=Wd6+JbfwMhGtbQ/WfWnCuSBFWIecAQzP2RNdPtLBfTnKDfO0rrPEgBva
   NoaKTBEs8JUEwepyXctilWNh+U/XhzCuAq2jF6lgcwW7JIqviHzHJ3GZe
   JrChlw8Q9yiF0m0T8kIoyAcl6jA5W78m+5HO8jN8fTzXUZngi2bQAbxBL
   LyRYKwunxDcJKgrPANS0BHO0UwCbkjisgwtQFe4t4VRSYo/Xe2sMp25xW
   qCn6CY8JlpZ+0z7mC3Zxe65fSanBAv/4ljd9a5xjiXL85qhdc84t5Oii7
   cKgju5fFS71gRF8PEJFCj7AM18rmpz4y1Y6SSDQJT7FS+mqhd8Tn+XRuT
   w==;
X-CSE-ConnectionGUID: 2bq2DPmNTkSamZ4mpAxY/w==
X-CSE-MsgGUID: fcDKp/xOR3mZmWlix6Ja7w==
X-IronPort-AV: E=McAfee;i="6700,10204,11340"; a="39629758"
X-IronPort-AV: E=Sophos;i="6.13,274,1732608000"; 
   d="scan'208";a="39629758"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2025 00:16:53 -0800
X-CSE-ConnectionGUID: qG1G8AYhTsWuqCyvEDaLbA==
X-CSE-MsgGUID: hhlq+FQqR4Gb4FmfxZxaDw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,274,1732608000"; 
   d="scan'208";a="112638684"
Received: from slindbla-desk.ger.corp.intel.com (HELO pujfalus-desk.intel.com) ([10.245.246.224])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2025 00:16:49 -0800
From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
To: lgirdwood@gmail.com,
	broonie@kernel.org,
	tiwai@suse.com
Cc: linux-sound@vger.kernel.org,
	kai.vehmanen@linux.intel.com,
	ranjani.sridharan@linux.intel.com,
	yung-chuan.liao@linux.intel.com,
	pierre-louis.bossart@linux.dev,
	bhelgaas@google.com,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/4] ASoC/SOF/PCI/Intel: add PantherLake H support
Date: Mon, 10 Feb 2025 10:17:26 +0200
Message-ID: <20250210081730.22916-1-peter.ujfalusi@linux.intel.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

Changes since v1:
- Updated the commit messages
- added the Acked-by from Bjorn and Mark

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


