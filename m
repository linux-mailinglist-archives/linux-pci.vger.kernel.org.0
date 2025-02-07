Return-Path: <linux-pci+bounces-20889-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 87FF4A2C3D2
	for <lists+linux-pci@lfdr.de>; Fri,  7 Feb 2025 14:38:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4EE63AA54C
	for <lists+linux-pci@lfdr.de>; Fri,  7 Feb 2025 13:37:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B23081F7069;
	Fri,  7 Feb 2025 13:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AfT77RRM"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3810E1F55EF;
	Fri,  7 Feb 2025 13:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738935426; cv=none; b=ibTz4TcYYVMlbooMb+bbE64w4tjedYMVLsDmsfAkie2diMot1vglY+okwYzEitYSljMU6Xhd67uj3rRpgq2HBM84+UEnMWbk6SQy9bm+hph1f+FWkMFX5CD2UPC2p+NA4LL6jsSpre09hNNrdhEgb2Ym0wr2KI21p3JL7tjCgCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738935426; c=relaxed/simple;
	bh=aDzybtpnIf/JlwCcL7s9evunDlX/wkc6eG4zzTWpQ/4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UTeUgKF6yzIYMEqqsmoF8u3m7Rmw3719D4PsawhDS/PUaRX+sAFyoRGNkPu05gwegl1eynl3LxzJMKRxP+sMf72GCsla0+NPFEW0AolRm83UaBPejabppP/XHdzlvNGXaNi4PsEdXjn5SCOI7yRBY/9Le3Im03H6Q6ZeXTyOqbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AfT77RRM; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738935425; x=1770471425;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=aDzybtpnIf/JlwCcL7s9evunDlX/wkc6eG4zzTWpQ/4=;
  b=AfT77RRMgiNHnohNX4P4dlRkEdctkqZ2912ft8YPSlJvLLYj/6Ad6dl/
   mCovC/k4fDBQxsvXlx1+IXvs6K0+6Ci65g5De734aQJmOEKZCb2bYuiNP
   Rja0c/vHALR9TwwnMxqh27L7CiHljfkhgzM9YEFevD7HxJKcbtRuJaavT
   laPDT5LBZFHdZvUOrl2uWaj7VT7H3sVAJW9zaFo/JCcNylXYb+8HFrOwK
   +c/nLQfSyREPAfUOnkai+JProFJZsmnxzSwSZM92zMmpgfsNurvjVDA1J
   Qzb0mqP4YaDlqOuGgC+ZNNXgWBdF0Lm7aM9PRaZILgQ2MGDzOtkXV373Z
   w==;
X-CSE-ConnectionGUID: qtOmLwVpSB+4EVdDZemmhA==
X-CSE-MsgGUID: zkN7Ub/LRyGMHjwJczJ9DA==
X-IronPort-AV: E=McAfee;i="6700,10204,11338"; a="39268415"
X-IronPort-AV: E=Sophos;i="6.13,267,1732608000"; 
   d="scan'208";a="39268415"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2025 05:37:05 -0800
X-CSE-ConnectionGUID: ezymigm7SJmZWtyLxZahNg==
X-CSE-MsgGUID: dqN31duPSm6SymGkAnpcoA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="148739843"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO pujfalus-desk.intel.com) ([10.245.246.100])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2025 05:37:02 -0800
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
Subject: [PATCH 1/4] PCI: pci_ids: add INTEL_HDA_PTL_H
Date: Fri,  7 Feb 2025 15:37:33 +0200
Message-ID: <20250207133736.4591-2-peter.ujfalusi@linux.intel.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250207133736.4591-1-peter.ujfalusi@linux.intel.com>
References: <20250207133736.4591-1-peter.ujfalusi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

More PCI ids for Intel audio.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 include/linux/pci_ids.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index de5deb1a0118..1a2594a38199 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -3134,6 +3134,7 @@
 #define PCI_DEVICE_ID_INTEL_HDA_LNL_P	0xa828
 #define PCI_DEVICE_ID_INTEL_S21152BB	0xb152
 #define PCI_DEVICE_ID_INTEL_HDA_BMG	0xe2f7
+#define PCI_DEVICE_ID_INTEL_HDA_PTL_H	0xe328
 #define PCI_DEVICE_ID_INTEL_HDA_PTL	0xe428
 #define PCI_DEVICE_ID_INTEL_HDA_CML_R	0xf0c8
 #define PCI_DEVICE_ID_INTEL_HDA_RKL_S	0xf1c8
-- 
2.48.1


