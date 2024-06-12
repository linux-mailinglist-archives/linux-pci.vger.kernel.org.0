Return-Path: <linux-pci+bounces-8628-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 97D05904BD8
	for <lists+linux-pci@lfdr.de>; Wed, 12 Jun 2024 08:47:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 864241C225CF
	for <lists+linux-pci@lfdr.de>; Wed, 12 Jun 2024 06:47:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA3A9169AC1;
	Wed, 12 Jun 2024 06:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SeJkcUML"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24CDE6F076
	for <linux-pci@vger.kernel.org>; Wed, 12 Jun 2024 06:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718174857; cv=none; b=uCUcPKZMlRfyilAVixZqbs05YAlR7w8QpI15LhkOT6GZ7J1HnT9p92SJBQwB4oovoLbwGiB9eRf0lb1MM/xe2Zm0xyXYRanwq8ZKMfET6xOfKdvCsBmkbrex2iMWi5LIYqoXXvFjawz41MHXlodtuxS1FHdtw0j3d38x/9vHsoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718174857; c=relaxed/simple;
	bh=249Jx5AQaxd0bNYD2GTJyZuwIG0Fy8JJ/BYO5WsK68c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cCjLW7at4yRd8vfLIvCixnF4BesXaE2HuoSKAT8M67s4oW+MofKF6JWhB26FQPRjP0vr7+SwDhp/ACu4Vy/zezcVchSHMJIpi+SqO4GERUsVE7J2TZG4sH/ae64Hgv4sv+UdNBI95NQEicsjMB5sXxbKunkd75cv0ZH3Fzxsn+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SeJkcUML; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718174856; x=1749710856;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=249Jx5AQaxd0bNYD2GTJyZuwIG0Fy8JJ/BYO5WsK68c=;
  b=SeJkcUMLWE28lNsGHCBQBajHRPWeYiJBaEaU2PSEoKPXOgvuNjpNSj/x
   v5Q62QxWYOZEJ68OqNz6Ybft9lm1inaYhkeHxfS+VUXOgtnZ4BhVb4UiQ
   RN5J93PM49Nm5UayRIvUF8WZsuYDDWdKo3UglNTpgs4CCG71taF7Db5qj
   N+4tzs+DMqJjxnGYnwFObltQ1kVKZn4Swa6wAmG85K+2tVg2vVAE3Grb2
   2LbVeW4R+ahDdwIcMaplgSz4GCxmRnuBefdLlx1Lv6fA+Fkj8Cm01P6f/
   SiRJS9jSTRpH07oW5h2I8+/947vVMNgaG0Sh2doNYKCeDaMjV2vkp1R5E
   Q==;
X-CSE-ConnectionGUID: iGT7Z2vnSraNFDbjvOrmEw==
X-CSE-MsgGUID: AiOklNVhQFaucoapS8snuw==
X-IronPort-AV: E=McAfee;i="6600,9927,11100"; a="15145882"
X-IronPort-AV: E=Sophos;i="6.08,232,1712646000"; 
   d="scan'208";a="15145882"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2024 23:47:36 -0700
X-CSE-ConnectionGUID: qraIR0ifRouPRFVmy51D1Q==
X-CSE-MsgGUID: +kdNbNIVQc6im4c+fJx8cw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,232,1712646000"; 
   d="scan'208";a="39751182"
Received: from iklimasz-mobl1.ger.corp.intel.com (HELO pbossart-mobl6.intel.com) ([10.245.246.56])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2024 23:47:33 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de,
	broonie@kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 0/3] ALSA/PCI: add PantherLake audio support
Date: Wed, 12 Jun 2024 08:47:06 +0200
Message-ID: <20240612064709.51141-1-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add the PCI ID for PantherLake.

Since there's a follow-up patchset for ASoC, these 3 patches could be
applied to the ASoC tree. Otherwise an immutable branch would be
needed.

Pierre-Louis Bossart (3):
  PCI: pci_ids: add INTEL_HDA_PTL
  ALSA: hda: hda-intel: add PantherLake support
  ALSA: hda: intel-dsp-config: Add PTL support

 include/linux/pci_ids.h      | 1 +
 sound/hda/intel-dsp-config.c | 9 +++++++++
 sound/pci/hda/hda_intel.c    | 2 ++
 3 files changed, 12 insertions(+)

-- 
2.43.0


