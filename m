Return-Path: <linux-pci+bounces-21597-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 78EBAA37F12
	for <lists+linux-pci@lfdr.de>; Mon, 17 Feb 2025 10:58:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0CDAF1894D99
	for <lists+linux-pci@lfdr.de>; Mon, 17 Feb 2025 09:56:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DB482163AE;
	Mon, 17 Feb 2025 09:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Am+Votov"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74D05212B3A;
	Mon, 17 Feb 2025 09:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739786168; cv=none; b=o3TQ0e17tC+gM6ecVsVSewX1/5GWGRpzXfynVkEI1blxaLRmuJy708pKQD9ghpCJqzuprnDPkd/wpWvG1phEAVu3TgMa0YIUi7h4e+l78embSA6SAwms6/5BcmRojo50OBrXK8nioekg+KF4uShEFuGb4H+mXfUGrg80TczNZyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739786168; c=relaxed/simple;
	bh=Y5lANQ8YkAZIViJWOLnRXFcMUR3n6rQYo/hzMpmT8pw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aAJfPNBDFVZqEtj+hHbuTDS7GHiP7mQB+4SPhLqwEQ7ScFPKVMpUqkkdaox9lJZgbYccDAo7qFw8J0w8t8WcvG8DdUUHah1Fvs8/jhDxrogGJm0a6KgntdDeOD1BrWR+kSTP5r2er4A4MZNJnWjk5bRkaYewMy+ORteyTMNL9BA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Am+Votov; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739786167; x=1771322167;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Y5lANQ8YkAZIViJWOLnRXFcMUR3n6rQYo/hzMpmT8pw=;
  b=Am+Votov1gf4IR7gEx3A4Lf2ndty43uyCsXPP5QTu0gwaYPSMxedIprg
   V7ptedrJFcldGAChHRgmltytHDm8mmUwBHQbsjR9omd9mJrQ8slGPe7WD
   /JE1J2ChFqzZTt0PS86kmjBwp04iANAE1hmxvyUrr7DrsSL8bTR3cCSgF
   wECtolo9aPVr9GIy/Ee9GsbSOft8yNQbUi8T5cU9K9VZGJEBaMnSNrxpg
   27BQRRrBU1J5tHANUW71l1ayvlv2KHfBcEi1rpAljPD2kjyWZEPfbfMiZ
   Vfi2WlNGL/8Kp+hw1U9wf0HMOjoZPE8MbdBxW0txBbOs9p7jsReUTMG4y
   w==;
X-CSE-ConnectionGUID: 0HhlbAxQQ1izw1jI0iblkw==
X-CSE-MsgGUID: j9zQHrKGS12bsIL1ERgegQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="40584393"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="40584393"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2025 01:56:06 -0800
X-CSE-ConnectionGUID: kkFKJc6GQa60ZyE525mltg==
X-CSE-MsgGUID: o4eHIwg7S2CjcW2Tbmy8xQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="119288847"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.163])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2025 01:56:04 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v2 1/2] PCI: shpchp: Remove unused logging wrappers
Date: Mon, 17 Feb 2025 11:55:49 +0200
Message-Id: <20250217095550.2789-2-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250217095550.2789-1-ilpo.jarvinen@linux.intel.com>
References: <20250217095550.2789-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The shpchp hotplug driver defines logging wrapper with generic names
which are just duplicates of existing generic printk() wrappers. They
are also unused so remove them.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/pci/hotplug/shpchp.h | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/drivers/pci/hotplug/shpchp.h b/drivers/pci/hotplug/shpchp.h
index f0e2d2d54d71..10ba0bfac419 100644
--- a/drivers/pci/hotplug/shpchp.h
+++ b/drivers/pci/hotplug/shpchp.h
@@ -33,18 +33,6 @@ extern bool shpchp_poll_mode;
 extern int shpchp_poll_time;
 extern bool shpchp_debug;
 
-#define dbg(format, arg...)						\
-do {									\
-	if (shpchp_debug)						\
-		printk(KERN_DEBUG "%s: " format, MY_NAME, ## arg);	\
-} while (0)
-#define err(format, arg...)						\
-	printk(KERN_ERR "%s: " format, MY_NAME, ## arg)
-#define info(format, arg...)						\
-	printk(KERN_INFO "%s: " format, MY_NAME, ## arg)
-#define warn(format, arg...)						\
-	printk(KERN_WARNING "%s: " format, MY_NAME, ## arg)
-
 #define ctrl_dbg(ctrl, format, arg...)					\
 	do {								\
 		if (shpchp_debug)					\
-- 
2.39.5


