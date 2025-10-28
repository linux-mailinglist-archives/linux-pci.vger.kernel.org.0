Return-Path: <linux-pci+bounces-39562-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7C1CC163EB
	for <lists+linux-pci@lfdr.de>; Tue, 28 Oct 2025 18:42:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7206B3B4104
	for <lists+linux-pci@lfdr.de>; Tue, 28 Oct 2025 17:39:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65D7234DB49;
	Tue, 28 Oct 2025 17:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lKlO0SE+"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7B2234DB67;
	Tue, 28 Oct 2025 17:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761673089; cv=none; b=SsU3NT6SviTJiWx8P4UpicNaqbAGTukp98c+ealmXi/3+B9BXYwjfViOcKAYOzp1qV7ZQDRMWlosedTC9qurZtPUJH20nkfBQ/3YFkphVj6Cjy4A5zqTeubrA/cu1XJ110q1fZzkDgEv3pn8dGmyFRYOZW5mlwGrde5c46dDKbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761673089; c=relaxed/simple;
	bh=rj0qgordGZNB+YdPjKDmtqTEG5yrczqeTMJCDVNmgm0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ei4vc9CWr7GgqRO/uudFvjLGS5AKllW9+4sG78GiLQh9NktFCvDe6ySqLqWtga5aJcmHFf5rBZXUNpGaDbaIiGZ22Zzxvi5dS1W5SWJFzDAcJNA76uPC0jHV31EcXgQzyh+OpaifDX6FpqRzLHgU0g10SSUlQvToBUkKoo3rI3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lKlO0SE+; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761673084; x=1793209084;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rj0qgordGZNB+YdPjKDmtqTEG5yrczqeTMJCDVNmgm0=;
  b=lKlO0SE+ySQt2SnEVkSpwL2LALVyugAxRv2/9pwjSnMTVSJWjZkOjGHL
   fRvYSBMeH/p1gMFr9xYxxqHcmefiuZLap+9EZGCSsa6WXYmoq/j6VZePF
   /BpL7smY44giXGfWsGcZNcWLbfFpd4t92W0Gmb+hfg2p1cZe18CUbFpN5
   B/HumSTNcSiZqoQTBKS7v2cq194/r7gYratyi/mIfw/1tTYrJhuk357rS
   SG6dR0q+utO2IJt+2ce8IgBzZT0DANM2KeZ/hL0RTKKkw74CDmlT+h8Eq
   UMXUF5JG0hNSJkQH9VELC8d4Mvb152vVifwibKfnbmaJ5SaNzmdAlSktT
   A==;
X-CSE-ConnectionGUID: h944opP6S4mbbmHZ658q5w==
X-CSE-MsgGUID: QQSBrH6aTiGa0JCUHlWjvg==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="81413276"
X-IronPort-AV: E=Sophos;i="6.19,261,1754982000"; 
   d="scan'208";a="81413276"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2025 10:38:03 -0700
X-CSE-ConnectionGUID: CNDiVW/JRC2hDk9azTLjtQ==
X-CSE-MsgGUID: jG6aT9CEQn60hVk9anqSKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,261,1754982000"; 
   d="scan'208";a="185304310"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.182])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2025 10:37:56 -0700
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
Subject: [PATCH 9/9] PCI: Prevent restoring assigned resources
Date: Tue, 28 Oct 2025 19:35:51 +0200
Message-Id: <20251028173551.22578-10-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251028173551.22578-1-ilpo.jarvinen@linux.intel.com>
References: <20251028173551.22578-1-ilpo.jarvinen@linux.intel.com>
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
index 8da83b612c59..28d6ae822c0b 100644
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


