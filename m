Return-Path: <linux-pci+bounces-45250-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CE0DFD3C2A4
	for <lists+linux-pci@lfdr.de>; Tue, 20 Jan 2026 09:55:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E26AD641BE7
	for <lists+linux-pci@lfdr.de>; Tue, 20 Jan 2026 08:34:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB6B93BF2EF;
	Tue, 20 Jan 2026 08:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AZZln0+l"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFB763B961E;
	Tue, 20 Jan 2026 08:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768897872; cv=none; b=oaduWz0igA8bGQlOu36Nc6ZIB5lzH1urc033HabjrWkncbYq9SfZE7PeIoTorOgnk2VI+Crj/T/cxK3oU6OZjUMnoYTxaFLuIJEisS39i7PHRBOuX12UhzpQNHwrPxqAOuudb43NqaEsEnNDNtoPuxYtN4nQqPfIPNl22SiQ4Lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768897872; c=relaxed/simple;
	bh=ybobKlLqgzRRQErpTQFwqacYgn+/shHNZw2eXZIJ0kM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KyKwVIF9n1br3peGFpX/N2QvHLXyPoeuDN5CRhSYf4KQlOkMJxlbOMGZCYTaRRILjQUGxMoqX3Peat0112kPt5J4QdjR8nPOij7w1nZyosOH5Fz0v8vsH1HCwinv2PhFNBNah4Nm3GaySXv2GJXz6T2VPlEJwDBdsw65S5iWTJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AZZln0+l; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768897871; x=1800433871;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ybobKlLqgzRRQErpTQFwqacYgn+/shHNZw2eXZIJ0kM=;
  b=AZZln0+lbXLmTf/0niXRdngoyGLbO8939/Ju+7Cls9x9URbYdUPPl1ni
   6Rwr8x9oeODZ6VTP4+1EUjN96u9hzwiPFqmvHfv4j/FD0CW03ixHponKG
   ebOlLjPkv7WIXr96SjV/8zW0Mze52CL8o1LNVzufEO0pZAtzw+J9OWlbm
   Tjr4DmHpqTFAX5Dvy5OzC3SgFvj5li7KRWjZnJnpiq3IZBkUfrKQYgLHA
   oLZaE+DvTTc1dn92PQosGMFtmeyTMGwZZD+UmVOMGCbdig9JTXk0Zwz1J
   XffewdWAeFP9ev2ibJxHASNGwrlaZ+q1LXNPm4pBXwLjauNdFglE0gNNc
   A==;
X-CSE-ConnectionGUID: 53q6vwjIR8GOO/QYHDdkpg==
X-CSE-MsgGUID: qGeYX8JsS5Gd/YgSEkeOlQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11676"; a="70071904"
X-IronPort-AV: E=Sophos;i="6.21,240,1763452800"; 
   d="scan'208";a="70071904"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2026 00:31:10 -0800
X-CSE-ConnectionGUID: N3jlgTR+Rgm5RSzD6uKP2Q==
X-CSE-MsgGUID: PnhGM5MWT5az0LkVVhmv3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,240,1763452800"; 
   d="scan'208";a="210530638"
Received: from krybak-mobl1.ger.corp.intel.com (HELO pujfalus-desk.intel.com) ([10.245.246.55])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2026 00:31:06 -0800
From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
To: lgirdwood@gmail.com,
	broonie@kernel.org,
	tiwai@suse.de,
	bhelgaas@google.com
Cc: linux-sound@vger.kernel.org,
	kai.vehmanen@linux.intel.com,
	ranjani.sridharan@linux.intel.com,
	yung-chuan.liao@linux.intel.com,
	pierre-louis.bossart@linux.dev,
	linux-kernel@vger.kernel.org,
	kw@linux.com,
	linux-pci@vger.kernel.org
Subject: [PATCH 0/4] ASoC/SOF/PCI/Intel: Support for Nova Lake
Date: Tue, 20 Jan 2026 10:31:44 +0200
Message-ID: <20260120083148.12063-1-peter.ujfalusi@linux.intel.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

this series adds audio support for the NVL variant of the
Nova Lake family.
NVL also based on ACE4 audio subsystem, but with higher clock
rate, more DSP memory and more DSP cores (4 vs 2) compared to
NVL-S.

Regards,
Peter
---
Peter Ujfalusi (4):
  PCI: pci_ids: Add Intel Nova Lake audio Device ID
  ASoC: SOF: Intel: add support for Nova Lake NVL
  ALSA: hda: core: intel-dsp-config:: Add support for NVL
  ALSA: hda: controllers: intel: add support for Nova Lake

 include/linux/pci_ids.h           |  1 +
 sound/hda/controllers/intel.c     |  1 +
 sound/hda/core/intel-dsp-config.c |  4 ++++
 sound/soc/sof/intel/hda.h         |  1 +
 sound/soc/sof/intel/nvl.c         | 24 ++++++++++++++++++++++++
 sound/soc/sof/intel/pci-nvl.c     | 31 +++++++++++++++++++++++++++++++
 6 files changed, 62 insertions(+)

-- 
2.52.0


