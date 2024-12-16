Return-Path: <linux-pci+bounces-18517-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2B5C9F3570
	for <lists+linux-pci@lfdr.de>; Mon, 16 Dec 2024 17:11:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 116FC163EDD
	for <lists+linux-pci@lfdr.de>; Mon, 16 Dec 2024 16:11:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D17BF14A095;
	Mon, 16 Dec 2024 16:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gZUP1DBW"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DC83193430;
	Mon, 16 Dec 2024 16:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734365446; cv=none; b=rVvbhoZVpNmLi27TKW/6S9No1zLuCQcFhGNgY4S5lk2JR0HvD7/4ogUwR093YCFTYa5nxgNjWAIyb0EJdaUJuCeQQgkW61ctG66zB3KbBsrXzokxM71flZTVNsafqdbqF8G42yoIBTBVLy+k+QlIpXJRNth/Pwurid4mwcrmNGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734365446; c=relaxed/simple;
	bh=3pgiIp1ZgAgTA1StdehyboBWAMBtoT+jkzi2UeAtxoE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DHsX7h03odLwy6Ej3CpdpTMiiPBVMd6XijywhzZ7+5HHWJMtuIupsstaaMvDYYZOWOnyOVKaXt+mG5ZB63IvM+sYcPW7L6eiy5nSbRCMG5oe+/vnhQX8TgKCq6VyW6R3X96mUVt9p+FVDF4bFeF35yD48vetvWa/z5PApxP4VKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gZUP1DBW; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734365445; x=1765901445;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3pgiIp1ZgAgTA1StdehyboBWAMBtoT+jkzi2UeAtxoE=;
  b=gZUP1DBW8u8PWdfV/RNuGbjQ2v55CGGpKdRu2wnwuZl9TY1UoxDSM7rM
   8559RcHppcYF7NjGkwaDx/sK36vcPclceIL1tSI+SKAIqbPtEb3CTgoE8
   6qoUzoGFCxJwWHF+g8XUE/tPA7Fk1jAMg0rZfrXzY7gDS6RYNqUszKTWF
   oZRq5QyTW921cEw8ckePOUOphAREMJ6MMgg9fRDgri9wWabHCtNToIr2n
   TzdZvS9rUq9X/0SpN/HOnmHTQAkn4SdDfEaxT9Sn2NdrQpXeE48zvyw1c
   z+EUgKHoRXqicwLVxet3ICrwcajHkNi3bDGr45v8QklKa9hg9m5XH93XQ
   A==;
X-CSE-ConnectionGUID: H+L3Mf4+TWGBHj3vyGX4AQ==
X-CSE-MsgGUID: BRJdhZaIRoWO4jOL43DVzw==
X-IronPort-AV: E=McAfee;i="6700,10204,11282"; a="45761362"
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="45761362"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2024 08:10:44 -0800
X-CSE-ConnectionGUID: FIKKxg6uQFidlzOQxQBWDA==
X-CSE-MsgGUID: 7mBoGB7gQVuGvk/jIrgGow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,239,1728975600"; 
   d="scan'208";a="97015516"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.29])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2024 08:10:42 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org,
	Karolina Stolarek <karolina.stolarek@oracle.com>,
	linux-kernel@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	"Oliver O'Halloran" <oohall@gmail.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 3/4] PCI: shpchp: Cleanup logging and debug wrappers
Date: Mon, 16 Dec 2024 18:10:11 +0200
Message-Id: <20241216161012.1774-4-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241216161012.1774-1-ilpo.jarvinen@linux.intel.com>
References: <20241216161012.1774-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The shpchp hotplug driver defines logging wrappers ctrl_*() and another
set of wrappers with generic names which are just duplicates of
existing generic printk() wrappers. Only the former are useful to
preserve as they handle the controller dereferencing (the latter are
also unused).

The "shpchp_debug" module parameter is used to enable debug logging.
The generic ability to turn on/off debug prints dynamically covers this
usecase already so there is no need to module specific debug handling.
The ctrl_dbg() wrapper also uses a low-level pci_printk() despite
always using KERN_DEBUG level.

Convert ctrl_dbg() to use the pci_dbg() and remove "shpchp_debug" check
from it.

Removing the non-ctrl variants of logging wrappers and "shpchp_debug"
module parameter as they are no longer used.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/pci/hotplug/shpchp.h      | 18 +-----------------
 drivers/pci/hotplug/shpchp_core.c |  3 ---
 2 files changed, 1 insertion(+), 20 deletions(-)

diff --git a/drivers/pci/hotplug/shpchp.h b/drivers/pci/hotplug/shpchp.h
index f0e2d2d54d71..f9e57dce010b 100644
--- a/drivers/pci/hotplug/shpchp.h
+++ b/drivers/pci/hotplug/shpchp.h
@@ -33,24 +33,8 @@ extern bool shpchp_poll_mode;
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
-	do {								\
-		if (shpchp_debug)					\
-			pci_printk(KERN_DEBUG, ctrl->pci_dev,		\
-					format, ## arg);		\
-	} while (0)
+	pci_dbg(ctrl->pci_dev, format, ## arg);
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


