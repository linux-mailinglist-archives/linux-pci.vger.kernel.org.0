Return-Path: <linux-pci+bounces-21061-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BB76A2E624
	for <lists+linux-pci@lfdr.de>; Mon, 10 Feb 2025 09:17:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AAE651889A25
	for <lists+linux-pci@lfdr.de>; Mon, 10 Feb 2025 08:17:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E86B1BD4F7;
	Mon, 10 Feb 2025 08:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZUBpjUxZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E18A11BD00C;
	Mon, 10 Feb 2025 08:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739175429; cv=none; b=VlcPN6UDcG1BbgsFlRlvCB2GKajHMB3NuQVB6lcLC0LvIV5k5CZYeTsqiNkTL7SnKczr6Gmdvvgo6Rv1LUhhnrMo+AvLfXJ5r+9r8dw6ESWWSlahx3XhpT37p5Hnahtt+2upjFd54AmjHSiSD8PJQogyKt4/hqyC23yb+UBfOQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739175429; c=relaxed/simple;
	bh=A5u2EQ2Nop9oS18StJ61oBM+f6vZFxzFKfftc/9fUJU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ihr7jXo7SvU+Sb6WKmUX9O9+n3WDenxOp1L5dodbW3MpSxGfgx2dDMr/2irssU4XzCJ85eD/esvZ1ogrFRz8oB4asi2QXQxVmoJ2PEeIrNEaJ2io2maJxByxouPfMdBJA5jB0urld7nIbuYCEM69YZg/RtqTfI/GP6zcAbkGxZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZUBpjUxZ; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739175428; x=1770711428;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=A5u2EQ2Nop9oS18StJ61oBM+f6vZFxzFKfftc/9fUJU=;
  b=ZUBpjUxZ9fLhX9AfQJgKaCOqJt7YFty3PBlLQgvGQHg3ktPE4thGYBgA
   Isho1Jynt2l/3a5r61QsbJ7sE50OZeG1simrq360duMhB6Ui2v2sxa4zF
   39FZBFwUm4rFc2+hPKe0d06ZT1qyVpj3ItqHKsWz/LzmUFTc8apCHZZvc
   o+myYmnwcj6+uqRhFU8MLOGJ78OKYLL4m58KrGlupaXaZlPszAzhyEiWb
   OlZTh85cqipZzYZG/VQ5Nr3R7+eyM3PofTMQi7QbYml0+sbMnL/6Cw/pH
   tZfZZG3rrhnid3cccI4VO/pyqqEoSMZwJanWjOhr16iUD8qGKOPsvZSwr
   Q==;
X-CSE-ConnectionGUID: N0V0nVVHRrueEJzreoCXug==
X-CSE-MsgGUID: t82D9FzoTde3z9NeZLGjdw==
X-IronPort-AV: E=McAfee;i="6700,10204,11340"; a="39629860"
X-IronPort-AV: E=Sophos;i="6.13,274,1732608000"; 
   d="scan'208";a="39629860"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2025 00:17:00 -0800
X-CSE-ConnectionGUID: 2i3/4D94TXyYljbktJN0Kg==
X-CSE-MsgGUID: moagOiODQt6VMBDVW+TcXA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,274,1732608000"; 
   d="scan'208";a="112638728"
Received: from slindbla-desk.ger.corp.intel.com (HELO pujfalus-desk.intel.com) ([10.245.246.224])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2025 00:16:56 -0800
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
Subject: [PATCH v2 2/4] ALSA: hda: intel-dsp-config: Add PTL-H support
Date: Mon, 10 Feb 2025 10:17:28 +0200
Message-ID: <20250210081730.22916-3-peter.ujfalusi@linux.intel.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250210081730.22916-1-peter.ujfalusi@linux.intel.com>
References: <20250210081730.22916-1-peter.ujfalusi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

Use same recipes as PTL for PTL-H.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 sound/hda/intel-dsp-config.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/sound/hda/intel-dsp-config.c b/sound/hda/intel-dsp-config.c
index f564ec7af194..ce3ae2cba660 100644
--- a/sound/hda/intel-dsp-config.c
+++ b/sound/hda/intel-dsp-config.c
@@ -539,6 +539,11 @@ static const struct config_entry config_table[] = {
 		.flags = FLAG_SOF | FLAG_SOF_ONLY_IF_DMIC_OR_SOUNDWIRE,
 		.device = PCI_DEVICE_ID_INTEL_HDA_PTL,
 	},
+	{
+		.flags = FLAG_SOF | FLAG_SOF_ONLY_IF_DMIC_OR_SOUNDWIRE,
+		.device = PCI_DEVICE_ID_INTEL_HDA_PTL_H,
+	},
+
 #endif
 
 };
-- 
2.48.1


