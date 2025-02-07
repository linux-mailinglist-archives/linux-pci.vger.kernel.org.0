Return-Path: <linux-pci+bounces-20891-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 593AFA2C3CF
	for <lists+linux-pci@lfdr.de>; Fri,  7 Feb 2025 14:37:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CDE3016B526
	for <lists+linux-pci@lfdr.de>; Fri,  7 Feb 2025 13:37:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73FB71F8EF1;
	Fri,  7 Feb 2025 13:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ba/2A3e9"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6DEE1F8AC0;
	Fri,  7 Feb 2025 13:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738935433; cv=none; b=c1Lp483rwCzw2cS/P/+w9eJW+I1lB2fg4YtgF5V9gBFE01svFtkdxWYzCZBp9+bd1cGdE8lEBZKv09EuZvXjuqnCGgKHJN9nBRxGLrwYC1s06meSX38YQXabRJ6N9Pz/XbpWdZNuUQNWdvkIsLg75AXgqjpCxVc6KW3KY0zg3tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738935433; c=relaxed/simple;
	bh=HUEX+jOJKQ8HDRUrrsvAcXd0ktW5Qr3AEqgWm8o9Md0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hRt7ixhFeyaNZ6aXO7s2nZ0ll+PYt13mhq8wa+A/9Tof34jLWU47kn3mPdb24+GqpQzvNrzD5b6VBteAy0P3y5wyaum8rca7Q4GAttxvVknEqtzEMUfL0FUcThG4GZZzyNIWyyx17RmsIX3pbZmFYo/NchW9SgausIyzC+rUTKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ba/2A3e9; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738935432; x=1770471432;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HUEX+jOJKQ8HDRUrrsvAcXd0ktW5Qr3AEqgWm8o9Md0=;
  b=Ba/2A3e9NeU0O6jZu42yzUtqnNAiPiWcrOasAQRhS61cJWk2KXGKp8ey
   sncoRLBHtTDXB1hxfT0F7bShrFPykDWL5GmPf+B8SVrhTNabiZ7mlSsq/
   nA32o4SBkwjJXcwGHR6i0cP/hrr/o6/h5KnqP0MMoIvj8rJ94dO1J6fOp
   VbbGIsvBmBk1CVoXstzeYnR1S8A//ZqDzvx0P33O/qdZyZh7rVHl4EhKl
   z5vaFvS3gR+GH+QDct2psHPUcCQ3uJgurCEgRZtMnpk/p6MfGVFhvaLXn
   zE7RO7Z72SKAzqX4QKoFGuM2/HTbFC7Cfg6rBvLra/gbIQu3Is3Au7K3G
   Q==;
X-CSE-ConnectionGUID: yMrOXdUITJKxos3pmdJsBA==
X-CSE-MsgGUID: Go/0IEbGSyeDbibdSQw+ag==
X-IronPort-AV: E=McAfee;i="6700,10204,11338"; a="39268445"
X-IronPort-AV: E=Sophos;i="6.13,267,1732608000"; 
   d="scan'208";a="39268445"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2025 05:37:12 -0800
X-CSE-ConnectionGUID: Sn6Wbf4hRC+KnQveXB6Uzw==
X-CSE-MsgGUID: AtcsYrJ6SKyTR/K0Y+JwoQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="148739884"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO pujfalus-desk.intel.com) ([10.245.246.100])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2025 05:37:09 -0800
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
Subject: [PATCH 3/4] ASoC: SOF: Intel: pci-ptl: Add support for PTL-H
Date: Fri,  7 Feb 2025 15:37:35 +0200
Message-ID: <20250207133736.4591-4-peter.ujfalusi@linux.intel.com>
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

PTL-H uses the same configuration as PTL.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 sound/soc/sof/intel/pci-ptl.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/sof/intel/pci-ptl.c b/sound/soc/sof/intel/pci-ptl.c
index 0aacdfac9fb4..c4fb6a2441b7 100644
--- a/sound/soc/sof/intel/pci-ptl.c
+++ b/sound/soc/sof/intel/pci-ptl.c
@@ -50,6 +50,7 @@ static const struct sof_dev_desc ptl_desc = {
 /* PCI IDs */
 static const struct pci_device_id sof_pci_ids[] = {
 	{ PCI_DEVICE_DATA(INTEL, HDA_PTL, &ptl_desc) }, /* PTL */
+	{ PCI_DEVICE_DATA(INTEL, HDA_PTL_H, &ptl_desc) }, /* PTL-H */
 	{ 0, }
 };
 MODULE_DEVICE_TABLE(pci, sof_pci_ids);
-- 
2.48.1


