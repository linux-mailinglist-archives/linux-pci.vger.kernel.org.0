Return-Path: <linux-pci+bounces-43419-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 629CACD131C
	for <lists+linux-pci@lfdr.de>; Fri, 19 Dec 2025 18:42:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F18FF304A4E5
	for <lists+linux-pci@lfdr.de>; Fri, 19 Dec 2025 17:41:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47ADC33BBA3;
	Fri, 19 Dec 2025 17:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cjZZHFbW"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50B1E25743D;
	Fri, 19 Dec 2025 17:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766166080; cv=none; b=Z/DBy472s4Ivfuxwy71Hgabe6fNZaHcE+UlAbpfnvJlkE2NiTghHxgNQjnc0LxqX6O34fwV8LilVFPXld69fYTwD27RZC+Vu1NUv7uDSTeLBMypwNBkeQP+/uG8OwSvXZL6Ig7obtCC9UjxJrICu5KMBYcVPFnV3cSCKgKfK4Ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766166080; c=relaxed/simple;
	bh=IS0b1rvSOqM2WFifaawrpvVUG/hQ5ryHxMToY69RVt8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sPEJUweHcLCvLQaZII4iJ1RQXOs8g7OUKZmavjSikGViamd1AW8A0n5kDEHeG27OHMApC3QcTr/HPVQTiE9tvG3zyW4YLBKPVlNS7uUiZ7RISMLMPktJiKCkuYM3KS6UEvS/lQdbS6diAkOgP3I2GqB00Cg50/Pb3io3MTOkeOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cjZZHFbW; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1766166078; x=1797702078;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IS0b1rvSOqM2WFifaawrpvVUG/hQ5ryHxMToY69RVt8=;
  b=cjZZHFbWZq2VwE4LdHG0kMte8/9RYq3MqKA0MuHxtu9lL0Jz9Xt1j4hT
   zMnYJRCiBzOfCqtVXktgusQa5JxlZKYfbOKQ85zbQr+L10jD91SBt0DZu
   ZEnGix8MjlwDyNkNr6bSVuebsBJu9AlH7KY7u+UmwWSPDeLNk1O66setK
   cchzjIUhifCp3sY6Ku/hZ2fjv6HAMKJZELHrVQUHw1hVeLA7jmVTy9jBc
   IIiUYrlJ6UTg3rjsWQcGVwW3eldQds3GV0V08Vk0H3q/aOl+nh246MJ6P
   mMJX5DT3sGCDsIATaNh1nHyllSxxYAir0CgzYkj1q31Wive2EGFh9/H+S
   g==;
X-CSE-ConnectionGUID: pgkqoq9cSEeT12dysXosVg==
X-CSE-MsgGUID: Dh5Bx2JiQvu7FK8jnkITOg==
X-IronPort-AV: E=McAfee;i="6800,10657,11647"; a="68173823"
X-IronPort-AV: E=Sophos;i="6.21,161,1763452800"; 
   d="scan'208";a="68173823"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2025 09:41:18 -0800
X-CSE-ConnectionGUID: mwvi3oR5QRCLPC/jCS+HXg==
X-CSE-MsgGUID: qM5Vnyj1Q4Sl3PMUC2htpw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,161,1763452800"; 
   d="scan'208";a="198974843"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.61])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2025 09:41:16 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Dominik Brodowski <linux@dominikbrodowski.net>,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 04/23] resource: Increase MAX_IORES_LEVEL to 8
Date: Fri, 19 Dec 2025 19:40:17 +0200
Message-Id: <20251219174036.16738-5-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251219174036.16738-1-ilpo.jarvinen@linux.intel.com>
References: <20251219174036.16738-1-ilpo.jarvinen@linux.intel.com>
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
index e4e9bac12e6e..c5f03ac78e44 100644
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


