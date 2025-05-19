Return-Path: <linux-pci+bounces-27919-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 00184ABB6BD
	for <lists+linux-pci@lfdr.de>; Mon, 19 May 2025 10:07:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 436067A3712
	for <lists+linux-pci@lfdr.de>; Mon, 19 May 2025 08:06:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D936A267B95;
	Mon, 19 May 2025 08:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l3Oye9eR"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AB884B1E76;
	Mon, 19 May 2025 08:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747642071; cv=none; b=JJI1KDvZlvjrEDaehgo7wExL6mrzOLnv+fHYPHEi8pxZUUie5zCyC0Px0J+XcLZuA9LI0b8krMAJChJ62Fw1wDg5aR3bY458N/5xM/+hBQwGCdTQ0as5RbAaMeS9Rh2Dj5bfMggSiQI33PgKbwfFw9gBLQWcY9yKYHW45RjU+mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747642071; c=relaxed/simple;
	bh=JLeWHAnLgnW13tBLYVzMl8kjd+UbLkzM0dHdMfNKK9g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rdx6xXGf6gMJbi8pT9ZWwtMeq6X5c2HNpROV3i6o/HOKLy9E3uUORplvGn4gKK6XdzBC7xnxsSW3Ea63sW8TQAgJhkgteaDR775/rA9SKN2Z8FmRb+6bAc/6a1C3B17R8Pys7w1V7/8/hsXCba3qtHP9oC9eQ8n5gPeh1T9VVA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l3Oye9eR; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747642069; x=1779178069;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=JLeWHAnLgnW13tBLYVzMl8kjd+UbLkzM0dHdMfNKK9g=;
  b=l3Oye9eRWaNJzEF25ui/3CDlG1voh//rGNhe5Wpw8Yw0YnmnBKgF3uX+
   sg5uIgFw/5nA5lN//R0zY7CpytID9I9Px/k59ceEzh0fMHZuj2Bix2b3k
   zDGjeDcyHPJUMIEXZhEPOt7CEL39jHkTQ7InfOHEpepDv6HtuCvRNNbax
   adt/VIh9/vjs3yVTbbJe3iZ3Knytw3+pzcuUGg6jNNoO3eHDHMjKuiwWf
   9BAcHejnzpWFZUlDeIMUaN37UWhMydgOGXJvim5Rn/ScvE9dVwxV5rEzx
   XoFRSaXpMBUROXraKBqx/I4D2v1cBhl9ZG/+isWNN3i3BqucN3+rapQMW
   g==;
X-CSE-ConnectionGUID: A/GmD9ITRYyH9s+fYhY7gQ==
X-CSE-MsgGUID: HGLOUuxmSdKih9LulcJFdQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11437"; a="52163497"
X-IronPort-AV: E=Sophos;i="6.15,300,1739865600"; 
   d="scan'208";a="52163497"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2025 01:07:48 -0700
X-CSE-ConnectionGUID: BSSWDcMUR6e3PRXrcWoviA==
X-CSE-MsgGUID: 8bM6wIo3S5SBv83I45HXMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,300,1739865600"; 
   d="scan'208";a="139205800"
Received: from mwiniars-desk2.ger.corp.intel.com (HELO pujfalus-desk.intel.com) ([10.245.246.4])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2025 01:07:44 -0700
From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
To: lgirdwood@gmail.com,
	broonie@kernel.org
Cc: linux-sound@vger.kernel.org,
	kai.vehmanen@linux.intel.com,
	ranjani.sridharan@linux.intel.com,
	yung-chuan.liao@linux.intel.com,
	pierre-louis.bossart@linux.dev,
	guennadi.liakhovetski@linux.intel.com,
	bhelgaas@google.com,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kw@linux.com
Subject: [PATCH v2 0/5] ASoC/SOF/PCI/Intel: add Wildcat Lake support
Date: Mon, 19 May 2025 11:08:50 +0300
Message-ID: <20250519080855.16977-1-peter.ujfalusi@linux.intel.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

Changes since v1:
- The PCI ID patch commit subject and message updated
- Reviewed-by, Acked-by tags added to patches

The audio IP in Wildcat Lake (WCL) is largely identical to the one in
Panther Lake, the main difference is the number of DSP cores, memory
and clocking.
It is based on the same ACE3 architecture.

In SOF the PTL topologies can be re-used for WCL to reduce duplication
of code and topology files. 

Regards,
Peter
---


Kai Vehmanen (1):
  ALSA: hda: add HDMI codec ID for Intel WCL

Peter Ujfalusi (4):
  PCI: Add Intel Wildcat Lake audio Device ID
  ASoC: SOF: Intel: add initial support for WCL
  ALSA: hda: intel-dsp-config: Add WCL support
  ALSA: hda: hda-intel: add Wildcat Lake support

 include/linux/pci_ids.h       |  1 +
 sound/hda/intel-dsp-config.c  |  6 +++++-
 sound/pci/hda/hda_intel.c     |  2 ++
 sound/pci/hda/patch_hdmi.c    |  1 +
 sound/soc/sof/intel/hda.h     |  1 +
 sound/soc/sof/intel/pci-ptl.c | 30 ++++++++++++++++++++++++++++++
 sound/soc/sof/intel/ptl.c     | 23 +++++++++++++++++++++++
 7 files changed, 63 insertions(+), 1 deletion(-)

-- 
2.49.0


