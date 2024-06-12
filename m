Return-Path: <linux-pci+bounces-8629-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA814904BD9
	for <lists+linux-pci@lfdr.de>; Wed, 12 Jun 2024 08:47:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C00561C22566
	for <lists+linux-pci@lfdr.de>; Wed, 12 Jun 2024 06:47:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 340F3167DA4;
	Wed, 12 Jun 2024 06:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OfbyQtv9"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B5196F076
	for <linux-pci@vger.kernel.org>; Wed, 12 Jun 2024 06:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718174860; cv=none; b=Nd5OovPoRQdysTPy0DjGZN0jfcOpgO+qpk6VcoXRBHg0EuB6CJ7bXFPy584MkDOokoSu3Isc3I8iP+UKsKpOG7T1MyDyD3G+GSdCcxQ/MlOV1OXWf6bo4yFcl8Luh7Ctc5bTO70M8NAxlg4F+bQ0p4shX4cXeEUiSTLmjnuml4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718174860; c=relaxed/simple;
	bh=kMKRUMZi3LwsLYnKnwrFIcZsrJQPpEX0yid2nCNeb9c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MZCxpvBnclicyCDAS3bQmO8Rs7C1eEBFY83hJX6k3TpJtt8IAGgyq1hiBbDVSe9AkgKjeqTpr/wlIJbpqBXTXFOHVGXqowgtjqGI+lOWqUk4GhIu8MWqMSVm/tvvtShMuZk9eqe3P6E4ISsnEQsbutyMGnm+D2MCe0Qrvv/31/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OfbyQtv9; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718174859; x=1749710859;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kMKRUMZi3LwsLYnKnwrFIcZsrJQPpEX0yid2nCNeb9c=;
  b=OfbyQtv95VwaJAmrjtJkun+BXMR2Gm5v5SpYNmvtXvpa9+4goCEzJr8E
   y3lVYOafD5jYCPB6ZGG1aOfHEWxEz8RJGNPX3s1J1MBRqDyN4M+KJ45H6
   2oV2VI3kMuopNmPaU8vCiQWlRaEuVT+pL06nxgsY36QYJHldBd+CqtoFq
   j94StAppttPqdPHjEZFyCSMbNQeW1fJa4No2rELrkIM8CoOd58llfZW6l
   iR/D4rA6ib9mW8FFPCUDVYmcUs/VfbRnH8zw+wFWl5IElqOTTRfJOKTZQ
   gXnyxBohOKYmuz7myL0P4VZdnEkz+VrgNmGnbWN+lA2dfBwW7Q6n9krwC
   A==;
X-CSE-ConnectionGUID: FqdYfChZR5+1HCjmY6V/Qw==
X-CSE-MsgGUID: eOinSXCXThexvzit1or5eg==
X-IronPort-AV: E=McAfee;i="6600,9927,11100"; a="15145890"
X-IronPort-AV: E=Sophos;i="6.08,232,1712646000"; 
   d="scan'208";a="15145890"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2024 23:47:39 -0700
X-CSE-ConnectionGUID: g5eXDeh/QVGCnIy6nEcnYg==
X-CSE-MsgGUID: bD8F6WK6Tv+6Ka3TOlGgRQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,232,1712646000"; 
   d="scan'208";a="39751209"
Received: from iklimasz-mobl1.ger.corp.intel.com (HELO pbossart-mobl6.intel.com) ([10.245.246.56])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2024 23:47:36 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de,
	broonie@kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	=?UTF-8?q?P=C3=A9ter=20Ujfalusi?= <peter.ujfalusi@linux.intel.com>,
	Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>
Subject: [PATCH 1/3] PCI: pci_ids: add INTEL_HDA_PTL
Date: Wed, 12 Jun 2024 08:47:07 +0200
Message-ID: <20240612064709.51141-2-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240612064709.51141-1-pierre-louis.bossart@linux.intel.com>
References: <20240612064709.51141-1-pierre-louis.bossart@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

More PCI ids for Intel audio.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Reviewed-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
---
 include/linux/pci_ids.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index 942a587bb97e..0168c6a60148 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -3112,6 +3112,7 @@
 #define PCI_DEVICE_ID_INTEL_HDA_LNL_P	0xa828
 #define PCI_DEVICE_ID_INTEL_S21152BB	0xb152
 #define PCI_DEVICE_ID_INTEL_HDA_BMG	0xe2f7
+#define PCI_DEVICE_ID_INTEL_HDA_PTL	0xe428
 #define PCI_DEVICE_ID_INTEL_HDA_CML_R	0xf0c8
 #define PCI_DEVICE_ID_INTEL_HDA_RKL_S	0xf1c8
 
-- 
2.43.0


