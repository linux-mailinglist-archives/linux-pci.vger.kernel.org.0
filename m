Return-Path: <linux-pci+bounces-8655-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F2E6C904F5D
	for <lists+linux-pci@lfdr.de>; Wed, 12 Jun 2024 11:33:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2D821C210CE
	for <lists+linux-pci@lfdr.de>; Wed, 12 Jun 2024 09:33:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED45C16DEB2;
	Wed, 12 Jun 2024 09:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TKpsIqZb"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D0C116D9AC;
	Wed, 12 Jun 2024 09:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718184800; cv=none; b=S4Jrbxy08IaT/y+JXLKqfGSoQVmeoSRhi+zHDu2d/daiOES1crUV7vn5DiO/0VmWYtkXcXkQdtTsN3TKt/JqtHIey60GiznLPXumPPc9idrdVdCqLAv7nlB9f5VsEaLrWdhZlEX+2ySrmIdRvNUZTADHjHmKFdhvIq8qU7Mj1jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718184800; c=relaxed/simple;
	bh=GL4nKRoUa9GkN2VIgnRKxP5jpO2kVuOsRHsPt3n+/2U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=Vuor3PGXkFmxKAgZO9S8PaDfhY/YtNihUijf11P8Fl1uBSR2RiGBGl3h5hENbzHTP8StWD+ZpxEMLlP0BnM9oiOwyaoAodu0Wp0Dfhqk7Y4QffgUhjMfzVAmNamuP49OD3V0s2bCSKbFR0S76JBAexZUr8dV+BMRB8o5FsmK88w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TKpsIqZb; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718184799; x=1749720799;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=GL4nKRoUa9GkN2VIgnRKxP5jpO2kVuOsRHsPt3n+/2U=;
  b=TKpsIqZb/6SFjYVhzMCk4xx2lkNBM48MSVaouHpoNPVBBBTf57JQJUl3
   lKEc9GrBEIiCM2lwY/MYEAF/xGwMFqc4Md9E+4e5Q1uwDZJXoMG1CVL0U
   gZ/hQkjtsipTegqOjEHn/0CeXBHs585lVM+sW33tRS2Z2OoD5Mh4O1lqG
   1bMje3ZoXm0qJUJsyVhG3gTNf0Y4x54oGmgCFa23dG8NyqU0xmfnKkCSB
   qFvbDvqfhzRq5ygpHF78UZdHPisUhS8ye/kv4xg9jUea45QBPkwq60lNG
   Yc6aQNxkEbYy21obL21vpH+/XQcJf24AgwiJV2493ralKal1eesfKzQUh
   Q==;
X-CSE-ConnectionGUID: UZEA+910SMSGM794WBBwXw==
X-CSE-MsgGUID: LpWoGJ/VSkqZTsrue/CDnA==
X-IronPort-AV: E=McAfee;i="6600,9927,11100"; a="14661123"
X-IronPort-AV: E=Sophos;i="6.08,232,1712646000"; 
   d="scan'208";a="14661123"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2024 02:33:19 -0700
X-CSE-ConnectionGUID: 5O+HJgx5Qi22kyyQsudUDQ==
X-CSE-MsgGUID: A8EnF27yTNi4C3qy2+2GRQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,232,1712646000"; 
   d="scan'208";a="39589102"
Received: from unknown (HELO localhost) ([10.245.247.204])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2024 02:33:09 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 1/1] PCI: Remove extra parenthesis from calculate_mem_align()
Date: Wed, 12 Jun 2024 12:32:49 +0300
Message-Id: <20240612093250.17544-1-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

RHS of <<= does not need parenthesis so remove them.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---

This patch can be folded into the commit 658bf5d36dc5 ("PCI: Make
minimum bridge window alignment reference more obvious") in
pci/resource if so desired.
---
 drivers/pci/setup-bus.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 11ee60b9ca71..23082bc0ca37 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -960,7 +960,7 @@ static inline resource_size_t calculate_mem_align(resource_size_t *aligns,
 	for (order = 0; order <= max_order; order++) {
 		resource_size_t align1 = 1;
 
-		align1 <<= (order + __ffs(SZ_1M));
+		align1 <<= order + __ffs(SZ_1M);
 
 		if (!align)
 			min_align = align1;
-- 
2.39.2


