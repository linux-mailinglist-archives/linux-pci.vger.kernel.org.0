Return-Path: <linux-pci+bounces-34575-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8306BB31D4F
	for <lists+linux-pci@lfdr.de>; Fri, 22 Aug 2025 17:06:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21B3BAA5619
	for <lists+linux-pci@lfdr.de>; Fri, 22 Aug 2025 14:57:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7FB6214232;
	Fri, 22 Aug 2025 14:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WhByaq4c"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAF96310624;
	Fri, 22 Aug 2025 14:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755874633; cv=none; b=REHjdP8TASU1rIw7VXvQqw1PMNrI8U4M626/bC/wgAICloouxDcdnjLaR/4jI3fBMN8cfSH7AZjNxwzVR8LQZRtY3vcZCYeyYivplx3A9+/cdf1v4e/EAYqbYlAXOyhsUG2o/WVv+LmIFmzNZCiLGC2bKceIxJU0rvRuwX8OsIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755874633; c=relaxed/simple;
	bh=ee6ivqpcnefQPqKlLb6mSNrXVqSqgxwUEWQuLhjZ8qY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fbRQcbWtNaG0MKx1CKS9g3OmW/Ws70hy/wMZWMJ4vdCKTGdXZgsmq/wGkk4PWgVNFr/ogs9VXB6OAZ90leN1GBHjLi9Cw3r0CBLIdM/fwOIYsiav86wquIBE4aaSUEyGgHCy+7klj9L3rI0ABcuUB9TFa2eiMhX2skWL9vZmEag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WhByaq4c; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755874632; x=1787410632;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ee6ivqpcnefQPqKlLb6mSNrXVqSqgxwUEWQuLhjZ8qY=;
  b=WhByaq4clo2Ag+fGhbswuzOUD1SweoCiYjGVJ6ewtS+LOoxJ/U7bWbpQ
   BLkvwuJ9FgQO/+0yKaE2Cq7bR+MJ5DrsKX47oyf6S2yhDMeHq1FB5vhs/
   pjNxYxQ/vfDyaVwTj26OCD/eTLiMlK2WWUqk9fKLBjajZf88xM3mfql2S
   vTILsE8QPx8ROBxYzaTNTP0V1DgR0NFtVys0Q/FbKgRXbj/Zff2hTJEq8
   T3sl/3Bjff0neiFUA33iXDaNpLuQwf7JsYv8ZCuGkVc+FA0y0I3URnWSf
   KZRp/PtC0MGqaFRa6dT/KVi/ja8iY+0eg21oy5G5o7h8rWc2vDj+7B4iO
   A==;
X-CSE-ConnectionGUID: c1CqQ8IzTwO5CEeJCP4HNA==
X-CSE-MsgGUID: ocHR2MOMTpGS3i3XfamfqQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11529"; a="69283127"
X-IronPort-AV: E=Sophos;i="6.17,309,1747724400"; 
   d="scan'208";a="69283127"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2025 07:57:11 -0700
X-CSE-ConnectionGUID: MCHsPL/ZRuqfR30RXNcprQ==
X-CSE-MsgGUID: LlCQKywETQWGsfuL1uTiAQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,309,1747724400"; 
   d="scan'208";a="169547072"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.115])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2025 07:57:07 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Andreas Larsson <andreas@gaisler.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	linux-m68k@lists.linux-m68k.org,
	linux-mips@vger.kernel.org,
	linux-pci@vger.kernel.org,
	sparclinux@vger.kernel.org,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Yinghai Lu <yinghai@kernel.org>,
	Igor Mammedov <imammedo@redhat.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Micha=C5=82=20Winiarski?= <michal.winiarski@intel.com>,
	linuxppc-dev@lists.ozlabs.org,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 06/24] PCI: Always claim bridge window before its setup
Date: Fri, 22 Aug 2025 17:55:47 +0300
Message-Id: <20250822145605.18172-7-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250822145605.18172-1-ilpo.jarvinen@linux.intel.com>
References: <20250822145605.18172-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

When the claim of a resource fails for the full range in
pci_claim_bridge_resource(), clipping the resource to a smaller size is
attempted. If the clipping successful, the new bridge window is
programmed and only as the last step the code attempts to claim the
resource again. The order of the last two steps is slightly illogical
and inconsistent with the assignment call chains.

If claiming the bridge window after clipping fails, the bridge window
that was setup is left in place.

Rework the logic such that the bridge window is claimed before calling
the relevant bridge setup function. This make the behavior consistent
with resource fitting call chains that always assign the bridge window
before programming it.

If claiming the bridge window fails, the clipped bridge window is no
longer setup but pci_claim_bridge_resource() returns without writing
the bridge window at all.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/pci/setup-bus.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index c5fc4e2825be..b477f68b236c 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -857,9 +857,16 @@ int pci_claim_bridge_resource(struct pci_dev *bridge, int i)
 	if ((bridge->class >> 8) != PCI_CLASS_BRIDGE_PCI)
 		return 0;
 
+	if (i > PCI_BRIDGE_PREF_MEM_WINDOW)
+		return -EINVAL;
+
+	/* Try to clip the resource and claim the smaller window */
 	if (!pci_bus_clip_resource(bridge, i))
 		return -EINVAL;	/* Clipping didn't change anything */
 
+	if (!pci_claim_resource(bridge, i))
+		return -EINVAL;
+
 	switch (i) {
 	case PCI_BRIDGE_IO_WINDOW:
 		pci_setup_bridge_io(bridge);
@@ -874,10 +881,7 @@ int pci_claim_bridge_resource(struct pci_dev *bridge, int i)
 		return -EINVAL;
 	}
 
-	if (pci_claim_resource(bridge, i) == 0)
-		return 0;	/* Claimed a smaller window */
-
-	return -EINVAL;
+	return 0;
 }
 
 /*
-- 
2.39.5


