Return-Path: <linux-pci+bounces-41132-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 59491C590D9
	for <lists+linux-pci@lfdr.de>; Thu, 13 Nov 2025 18:16:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9897D50071A
	for <lists+linux-pci@lfdr.de>; Thu, 13 Nov 2025 16:37:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0EC1363C76;
	Thu, 13 Nov 2025 16:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d502RUC/"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FC7B361DDD;
	Thu, 13 Nov 2025 16:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763051329; cv=none; b=DFKC8vghNbgChRFOQ6u3XXzPo30t2tnj5ITuixUOW+Lg8MLx6ZC4RuVu19VZwv8KOZOIxnZL+gezvbsqp1BpDHYiY06zTl/WgIIMY7kAjNAOu0FQE9BLNelRuIBanSI0QGexBnhdqGskiHgqBDNqow4RKvek0act8P/Uorcpk2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763051329; c=relaxed/simple;
	bh=00YqMn1xgNfaa8IyKneU1YTwVRsL/5ObnW9VBzHq/ws=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pyFWrMtKpw5bgQwPR7my5Ih2HHjzph6ZqX2Mw/IQz3bra4tl/c4vZe0N9QM0QLaL3kbfLs9TasGREx9nd6TOAtvCxbQsBC2qO/8MzZrdiLLGqGB+nwP9Ko5KWxbNeY+2UooyPZJXQIDv5NXzPCPrt7KLUsDOs8V2pv763OlnFh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=d502RUC/; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763051328; x=1794587328;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=00YqMn1xgNfaa8IyKneU1YTwVRsL/5ObnW9VBzHq/ws=;
  b=d502RUC/EoG0ni9d5LYjvL0TLwWXkYQacJ7D1CwO+CWr+Y8uJa/0xn+F
   CwrlliRfR4tnfnJndCjuy8BdlV2VO7wr/BdyuMlAe7t8oF/GG+AoBusYd
   hzXcljP5sGsZfeLV9fFjx3TUNXQQddcwtnZ1+xTOZho1jm7q/xLFDChPT
   8PAyluVND05nKVhy8/a/9Ne7zDg+0rBYKX45JrjnA1MNT2hyWGqbRXC2w
   6IWm5OfHFmRt2Jew0fSJI4Edyw8/aJaJw79sBkX4VcTwDSx2FkVKMQox6
   soNG09hPOI3GEqCfhabJ6Ql4s0qKkr/Co5Yfp11Y8Pz+UB0kv2Nu9HhRH
   w==;
X-CSE-ConnectionGUID: y19DAXtWTCOMJiiseUIFBA==
X-CSE-MsgGUID: nQJhqQ0JS5ag2r7MXyFF1g==
X-IronPort-AV: E=McAfee;i="6800,10657,11612"; a="75817081"
X-IronPort-AV: E=Sophos;i="6.19,302,1754982000"; 
   d="scan'208";a="75817081"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2025 08:28:47 -0800
X-CSE-ConnectionGUID: 3UTbcYBIT6uFhTCEDf9Vtw==
X-CSE-MsgGUID: M1wNkJYUSeS9uzt+zjeutg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,302,1754982000"; 
   d="scan'208";a="189184706"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.164])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2025 08:28:41 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Simon Richter <Simon.Richter@hogyros.de>,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	amd-gfx@lists.freedesktop.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	David Airlie <airlied@gmail.com>,
	dri-devel@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	linux-pci@vger.kernel.org,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Simona Vetter <simona@ffwll.ch>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	=?UTF-8?q?Micha=C5=82=20Winiarski?= <michal.winiarski@intel.com>,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v2 11/11] PCI: Prevent restoring assigned resources
Date: Thu, 13 Nov 2025 18:26:28 +0200
Message-Id: <20251113162628.5946-12-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251113162628.5946-1-ilpo.jarvinen@linux.intel.com>
References: <20251113162628.5946-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

restore_dev_resource() copies saved addresses and flags from the struct
pci_dev_resource back to the struct resource, typically, during
rollback from a failure or in preparation for a retry attempt.

If the resource is within resource tree, the resource must not be
modified as the resource tree could be corrupted. Thus, it's a bug to
call restore_dev_resource() for assigned resources (which did happen
due to logic flaws in the BAR resize rollback).

Add WARN_ON_ONCE() into restore_dev_resource() to detect such bugs
easily and return without altering the resource to prevent corruption.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/pci/setup-bus.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 7e268960954b..1d9fc078c7ad 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -15,6 +15,7 @@
  */
 
 #include <linux/bitops.h>
+#include <linux/bug.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
@@ -135,6 +136,9 @@ static void restore_dev_resource(struct pci_dev_resource *dev_res)
 {
 	struct resource *res = dev_res->res;
 
+	if (WARN_ON_ONCE(res->parent))
+		return;
+
 	res->start = dev_res->start;
 	res->end = dev_res->end;
 	res->flags = dev_res->flags;
-- 
2.39.5


