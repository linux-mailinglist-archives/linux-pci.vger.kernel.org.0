Return-Path: <linux-pci+bounces-21060-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFD48A2E621
	for <lists+linux-pci@lfdr.de>; Mon, 10 Feb 2025 09:17:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88BEA165863
	for <lists+linux-pci@lfdr.de>; Mon, 10 Feb 2025 08:17:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54C391BEF70;
	Mon, 10 Feb 2025 08:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="leqdpL20"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 880501BEF63;
	Mon, 10 Feb 2025 08:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739175421; cv=none; b=muVgsvmgIXmcBnb0hgRkQDu/HL03LY5ID27fnFSJL5131W4+92j73WQD6Ppr9IKbBn2/vsB7ZuoNHYWQLFCF26Yj6GP5MHL/Z7hKnuwP9cg8RWcxZYkzqTXyuV08FHcY7YMYlLgmwedAYVq9jhlOq+mxRbTq1Q4pPhNGXHluFgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739175421; c=relaxed/simple;
	bh=NP5E0mJ0xn91zThT0Htx3tC0BFtRmRmLQo0PahHODh8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IU7W1mVaqyGWpIb4tDWKo10ENVhKddsUyhIJVfR2Ipgz4B0RPiAU0pthkLtCCyD+kHM8PHSZbADGKVqDmZ9bT34DGUNQKmcGm64cm2eDKx/IBfk+0s04geTdo9pBo+LarnVz33QqJdvRszPejjbJKHdQC2GD9xCMGcVoMUjhXhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=leqdpL20; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739175420; x=1770711420;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NP5E0mJ0xn91zThT0Htx3tC0BFtRmRmLQo0PahHODh8=;
  b=leqdpL20ZuLUnD0n7B6k25hoAKMneYVaVpde+soIMHBDF61BArYrvXtH
   mQ/3pUwnbLZIqcFGtaDeHvYni9wUU4kMmIoQ3wLY/Rk6JRLaLyg3oTSLv
   4SWMj9aA25YuayUQjzxvSjPAjd+HG5BE73pl2OcyjsZs9UKNRW40nAyyV
   FxIdEM6lRlufRuqxi6/xE8fB35AE3qj35ktJK6YjAZcYW4wZHJT9FKvfU
   87o7MLUHHWRN9EgmWgJw2/r7kNU77MZRqdNCmyb4xbLDrQBJgh1Jf/jw5
   k0c6fh/w5p7tyxH1+4gsyYnMoDq+dkP16n/jv9NhiUCWx+3/us0yrNjAI
   Q==;
X-CSE-ConnectionGUID: dwjeXkYqQOiUIlJ7QTMY9A==
X-CSE-MsgGUID: cbu5oJgVQkqWoEdMXT8nqw==
X-IronPort-AV: E=McAfee;i="6700,10204,11340"; a="39629798"
X-IronPort-AV: E=Sophos;i="6.13,274,1732608000"; 
   d="scan'208";a="39629798"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2025 00:16:56 -0800
X-CSE-ConnectionGUID: +xZN4RSXQ+yqrsAVk5cRgg==
X-CSE-MsgGUID: dA298BB6SBiFLwBG0dJPSQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,274,1732608000"; 
   d="scan'208";a="112638718"
Received: from slindbla-desk.ger.corp.intel.com (HELO pujfalus-desk.intel.com) ([10.245.246.224])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2025 00:16:52 -0800
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
Subject: [PATCH v2 1/4] PCI: pci_ids: add INTEL_HDA_PTL_H
Date: Mon, 10 Feb 2025 10:17:27 +0200
Message-ID: <20250210081730.22916-2-peter.ujfalusi@linux.intel.com>
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

Add Intel PTL-H audio Device ID.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
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


