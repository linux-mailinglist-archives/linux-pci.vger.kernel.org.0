Return-Path: <linux-pci+bounces-42261-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DD66C91E0C
	for <lists+linux-pci@lfdr.de>; Fri, 28 Nov 2025 12:51:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8CFF3AE318
	for <lists+linux-pci@lfdr.de>; Fri, 28 Nov 2025 11:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BCD03254AA;
	Fri, 28 Nov 2025 11:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jYZNRsHO"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89C333254B3;
	Fri, 28 Nov 2025 11:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764330673; cv=none; b=XFS5i4pspJ9xtGC17wRfenRG0dOBwt+UVckZksPFGi/CtbPefW2KzcZlEygzDcHNvMfMuhUcW5+yWkECLB9TPolrayNIHMfAQ06xbqy0BFYbjGa9e63/I+AOV77r5JTEPRYiPS7XNOWmFs6eU9ZI5K9phVukn5szggboRzJqqv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764330673; c=relaxed/simple;
	bh=f7e+ax9Ru72J3uJsHwCnUx8Tp2bSDJ1UUdD+RCIJtcs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Oauy3tRBfgs8cTNbMAlV08di4mGYjlphsW2cCdopa+B9sWtgPisEqhHKRU+69iEvUnLw8/F7/uZNHfYu5a4R6jlT7zzoEZFeGVeq3bhpmjBkcdF31GwDc+xfrGL65AAhbDHeRTikinkUkP+Xr3fuoolF0K9z1orLgKI+gAzvyRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jYZNRsHO; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764330671; x=1795866671;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=f7e+ax9Ru72J3uJsHwCnUx8Tp2bSDJ1UUdD+RCIJtcs=;
  b=jYZNRsHOtSF0AFrTc6OaPsAVkCiCgzHNjM7ZVzZQESeSs17F9OIfogA4
   L4phaBlVv7xabg9YdTURLVTbRx1ha/jPEbDFMZ1J3VIWmY4bbNMliAcyb
   qKd39idQcAqkWVLn4AVcR9yYwLPJ1T0BGCkYyJMf8f2j6r39pgYvVP1oJ
   yE6OWBi3X2Vueo8VgPCfmo3Z21xP4vN23757xTpXQxCxVnBR8BtxbupLv
   ZErkrIGYC3OVRB33Fisk8ZJKykNAP+B5V+159XqWGfz2XPp3tnpsrHe15
   7Z9b4WQgVXH5lrrcAudCmyTi+ScPAs/sD2Y29KR/mPdhoHij77YnzxcEF
   A==;
X-CSE-ConnectionGUID: 1uI9/OnRR06scdPN/W7nNQ==
X-CSE-MsgGUID: OhEMi9yNR5mLzT6fv3KJoA==
X-IronPort-AV: E=McAfee;i="6800,10657,11626"; a="66437159"
X-IronPort-AV: E=Sophos;i="6.20,232,1758610800"; 
   d="scan'208";a="66437159"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2025 03:51:10 -0800
X-CSE-ConnectionGUID: LnbTp9DGRl+1dwxMlrpg+g==
X-CSE-MsgGUID: 5HOVqoyiSyO+TzAv3Uo30g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,232,1758610800"; 
   d="scan'208";a="230725521"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.229])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2025 03:51:07 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Wei Yang <weiyang@linux.vnet.ibm.com>,
	=?UTF-8?q?Malte=20Schr=C3=B6der?= <malte+lkml@tnxip.de>,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 4/4] resource: Increase MAX_IORES_LEVEL to 8
Date: Fri, 28 Nov 2025 13:50:21 +0200
Message-Id: <20251128115021.4287-5-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251128115021.4287-1-ilpo.jarvinen@linux.intel.com>
References: <20251128115021.4287-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

While debugging a PCI resource allocation issue, the resources for many
nested bridges and endpoints got flattened in /proc/iomem by
MAX_IORES_LEVEL that is set to 5. This made the iomem output hard to
read as the visual hierarchy cues were lost.

Increase MAX_IORES_LEVEL to 8 to avoid flattening PCI topologies with
nested bridges so aggressively (the case in the Link has the deepest
resource at level 7 so 8 looks a reasonable limit).

Link: https://bugzilla.kernel.org/show_bug.cgi?id=220775
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 kernel/resource.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/resource.c b/kernel/resource.c
index b9fa2a4ce089..c5c907b3236d 100644
--- a/kernel/resource.c
+++ b/kernel/resource.c
@@ -82,7 +82,7 @@ static struct resource *next_resource(struct resource *p, bool skip_children,
 
 #ifdef CONFIG_PROC_FS
 
-enum { MAX_IORES_LEVEL = 5 };
+enum { MAX_IORES_LEVEL = 8 };
 
 static void *r_start(struct seq_file *m, loff_t *pos)
 	__acquires(resource_lock)
-- 
2.39.5


