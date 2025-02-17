Return-Path: <linux-pci+bounces-21598-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 99FBDA37F0D
	for <lists+linux-pci@lfdr.de>; Mon, 17 Feb 2025 10:57:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC69E1693F7
	for <lists+linux-pci@lfdr.de>; Mon, 17 Feb 2025 09:56:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BF37216607;
	Mon, 17 Feb 2025 09:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lujQwAiC"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AD292165F9;
	Mon, 17 Feb 2025 09:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739786175; cv=none; b=hj2reX221E9mB1mBGJci2NBtaGG/ydhPGWTCXLJBr9LipZuQLTVcDQ+ZJim7Vb8IRWoPMOQvEd8Q3mkJb70RD6HaQFeWvw8IvVq9LWDQYOaPODR3a7I0bGc2WsuCBauU7LRV5B96AVp5ipOstM6tvAdZTod2wrf72YU54dE9lxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739786175; c=relaxed/simple;
	bh=JKcb9cL94tNcPawYqghUvzw19gc0TQZJXoekcw5QLh4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kDd+2Yj9VqLi7nQrBOQjcvsYB7dH2ZCZw3DQLrsz+s13qifkoDZYhrsodU+og141/1Vvx/HksX0J0qvCVuq3x0j2W64uXKGOnEMBf8Bs5T7UXpOKmk4xFjM2/WkPoUvoa9SkOddo7Eq2m4VQgQA2Hw3vJ972dlafg5nz/xGQmgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lujQwAiC; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739786174; x=1771322174;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JKcb9cL94tNcPawYqghUvzw19gc0TQZJXoekcw5QLh4=;
  b=lujQwAiCYpn6AnlTVWl6Lkc3QpSV79DQHyjj+kN/C0c2QWSJ3pKyPlx2
   C4N8k7gpZJ5xd8WExRUU8p+Xx2d4yqvXmVrOAF/A8qdNOawzr3v3I9T5O
   nzBaXnaY0HfR21MUUXhOmx2wE0RLe9O2PqIrFS/1QI3jyyj7Kiui+zhYY
   7mkbmK1XArw56pXNnQryiYE0oH2iGZLutZJPmQOCU7WgmABoG+T+ruPIX
   ir2KrMpfry7/L2AgDIy+yEmIpEsDzVxfLryMIpM1eDysM5dL9R31mLDbv
   ruwBFc0Sd+6fFbHWnav3g9YbUJ33SVUFvoKg024ZiRWOndWLgsuUNN89W
   w==;
X-CSE-ConnectionGUID: dx5L4VXpQEmF6f7BA97Oow==
X-CSE-MsgGUID: NUOXq1h2R1y7EbRtQAct4A==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="40584403"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="40584403"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2025 01:56:14 -0800
X-CSE-ConnectionGUID: jRSumhs9RsO9h6LtalkJMw==
X-CSE-MsgGUID: E7COLFkoSWuwoLDMWYiFYQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="119288888"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.163])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2025 01:56:12 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v2 2/2] PCI: shpchp: Remove "shpchp_debug" module parameter
Date: Mon, 17 Feb 2025 11:55:50 +0200
Message-Id: <20250217095550.2789-3-ilpo.jarvinen@linux.intel.com>
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

The "shpchp_debug" module parameter is used to enable debug logging.
The generic ability to turn on/off debug prints dynamically covers this
use case already so there is no need for module specific debug handling.
The ctrl_dbg() wrapper also uses a low-level pci_printk() despite
always using KERN_DEBUG level.

Remove "shpchp_debug" parameter and convert ctrl_dbg() to use the
pci_dbg().

From now on, shpchp can be debugged using the normal dynamic debugger
by setting CONFIG_DYNAMIC_DEBUG=y and then either adding to kernel
cmdline:

  dyndbg="file drivers/pci/hotplug/shpchp* +p"

or using this command on a running kernel:

  echo 'file drivers/pci/hotplug/shpchp* +p' > /sys/kernel/debug/dynamic_debug/control

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/pci/hotplug/shpchp.h      | 6 +-----
 drivers/pci/hotplug/shpchp_core.c | 3 ---
 2 files changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/pci/hotplug/shpchp.h b/drivers/pci/hotplug/shpchp.h
index 10ba0bfac419..a425530e0939 100644
--- a/drivers/pci/hotplug/shpchp.h
+++ b/drivers/pci/hotplug/shpchp.h
@@ -34,11 +34,7 @@ extern int shpchp_poll_time;
 extern bool shpchp_debug;
 
 #define ctrl_dbg(ctrl, format, arg...)					\
-	do {								\
-		if (shpchp_debug)					\
-			pci_printk(KERN_DEBUG, ctrl->pci_dev,		\
-					format, ## arg);		\
-	} while (0)
+	pci_dbg(ctrl->pci_dev, format, ## arg)
 #define ctrl_err(ctrl, format, arg...)					\
 	pci_err(ctrl->pci_dev, format, ## arg)
 #define ctrl_info(ctrl, format, arg...)					\
diff --git a/drivers/pci/hotplug/shpchp_core.c b/drivers/pci/hotplug/shpchp_core.c
index a10ce7be7f51..0c341453afc6 100644
--- a/drivers/pci/hotplug/shpchp_core.c
+++ b/drivers/pci/hotplug/shpchp_core.c
@@ -22,7 +22,6 @@
 #include "shpchp.h"
 
 /* Global variables */
-bool shpchp_debug;
 bool shpchp_poll_mode;
 int shpchp_poll_time;
 
@@ -33,10 +32,8 @@ int shpchp_poll_time;
 MODULE_AUTHOR(DRIVER_AUTHOR);
 MODULE_DESCRIPTION(DRIVER_DESC);
 
-module_param(shpchp_debug, bool, 0644);
 module_param(shpchp_poll_mode, bool, 0644);
 module_param(shpchp_poll_time, int, 0644);
-MODULE_PARM_DESC(shpchp_debug, "Debugging mode enabled or not");
 MODULE_PARM_DESC(shpchp_poll_mode, "Using polling mechanism for hot-plug events or not");
 MODULE_PARM_DESC(shpchp_poll_time, "Polling mechanism frequency, in seconds");
 
-- 
2.39.5


