Return-Path: <linux-pci+bounces-13808-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 11CC399001B
	for <lists+linux-pci@lfdr.de>; Fri,  4 Oct 2024 11:44:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8A4B1F2467A
	for <lists+linux-pci@lfdr.de>; Fri,  4 Oct 2024 09:44:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 574B815625A;
	Fri,  4 Oct 2024 09:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hd6YFWvz"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EECB1553A7
	for <linux-pci@vger.kernel.org>; Fri,  4 Oct 2024 09:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728034904; cv=none; b=AWEIPsB93VzWrFZNrBoBaEI2mFLZc15E4s2OigWzYMSrSniy3IYZqapjcnQRSgMcskFx782I3AF9RNS0wh42CBHDswJar7IIwhr2hMT4fZKfG4a5w+YGSSEO26MdUAD3RT5m/PFr+u8f67IyfPAeUMTDfOpkUdZ4WD9bNZew1uA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728034904; c=relaxed/simple;
	bh=KZZqfstOXWG/qdkoum2g5vqYTKy1gIux4ezNeXo25dQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=chQg3mlXsyrp4Qy16z8Sq9JH7KZ1ThbHzIQD5jGtamL3Bl5ZrWReV8JakqVOmXQinENpDHl9a6VTa0BCvPO/l1Ll4pjXx4Hw8T3E9VO8VI+zkG6Ijf0LANwi3qWqqhTBzVYSrV3nGCRfvN2vXbAzSJoqF/9xcGdEAHfeiXfO3JE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hd6YFWvz; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728034902; x=1759570902;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KZZqfstOXWG/qdkoum2g5vqYTKy1gIux4ezNeXo25dQ=;
  b=hd6YFWvzOhFVdyn7nWSBq9OkjHccrYdKdDHSHKjZUGGhAivGVSspxw38
   Sqq2MJrxs8FrpXN2bBqIRaBjDLeQ+IEUuDGwbZJ7vzOSFlvRHZxR+OsgA
   XrLO8MDYEn7N5B/PN49Esc4Rx9Q7VorSvbFAz4jKLUksXXePBqxZOt/ux
   WLoXZd6FuKR3v9XZ0+lLN+9HiS4bVLubpm2BhUHmLf7LtMPtcwI0Cqb8D
   lJrZkJgFE3WW9uAJXf0+MKkXoZ6wdNujNtnerHesT3MMB3OuQpyCLBrZE
   +AGT9QLY59mK/feMfBGukhyHGougz+LpbKumSx2XIMB41Xnq2gu7sTvt5
   w==;
X-CSE-ConnectionGUID: kK7QMMJMQu2S56UiPEf6YQ==
X-CSE-MsgGUID: cTNWX59oScuRZWNNPuuR8w==
X-IronPort-AV: E=McAfee;i="6700,10204,11214"; a="52656268"
X-IronPort-AV: E=Sophos;i="6.11,177,1725346800"; 
   d="scan'208";a="52656268"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2024 02:41:40 -0700
X-CSE-ConnectionGUID: rIj+tHnWSUyF7XiLta11tA==
X-CSE-MsgGUID: FPBzwbmUQAyU/+qY+fEZIA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,177,1725346800"; 
   d="scan'208";a="74975100"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2024 02:41:39 -0700
Received: from punajuuri.localdomain (punajuuri.localdomain [192.168.240.130])
	by kekkonen.fi.intel.com (Postfix) with ESMTP id 240D2120D8D;
	Fri,  4 Oct 2024 12:41:34 +0300 (EEST)
Received: from sailus by punajuuri.localdomain with local (Exim 4.96)
	(envelope-from <sakari.ailus@linux.intel.com>)
	id 1sweoY-000TdF-0R;
	Fri, 04 Oct 2024 12:41:34 +0300
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>
Cc: linux-pci@vger.kernel.org
Subject: [PATCH 32/51] PCI/portdrv: Switch to __pm_runtime_put_autosuspend()
Date: Fri,  4 Oct 2024 12:41:34 +0300
Message-Id: <20241004094134.113895-1-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241004094101.113349-1-sakari.ailus@linux.intel.com>
References: <20241004094101.113349-1-sakari.ailus@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pm_runtime_put_autosuspend() will soon be changed to include a call to
pm_runtime_mark_last_busy(). This patch switches the current users to
__pm_runtime_put_autosuspend() which will continue to have the
functionality of old pm_runtime_put_autosuspend().

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 drivers/pci/pcie/portdrv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/pcie/portdrv.c b/drivers/pci/pcie/portdrv.c
index 6af5e0425872..53f48065cc82 100644
--- a/drivers/pci/pcie/portdrv.c
+++ b/drivers/pci/pcie/portdrv.c
@@ -711,7 +711,7 @@ static int pcie_portdrv_probe(struct pci_dev *dev,
 		pm_runtime_set_autosuspend_delay(&dev->dev, 100);
 		pm_runtime_use_autosuspend(&dev->dev);
 		pm_runtime_mark_last_busy(&dev->dev);
-		pm_runtime_put_autosuspend(&dev->dev);
+		__pm_runtime_put_autosuspend(&dev->dev);
 		pm_runtime_allow(&dev->dev);
 	}
 
-- 
2.39.5


