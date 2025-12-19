Return-Path: <linux-pci+bounces-43429-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4647CCD1391
	for <lists+linux-pci@lfdr.de>; Fri, 19 Dec 2025 18:52:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6406A3047902
	for <lists+linux-pci@lfdr.de>; Fri, 19 Dec 2025 17:51:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B33AA3246ED;
	Fri, 19 Dec 2025 17:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="njsQLQk0"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58A7B33C19A;
	Fri, 19 Dec 2025 17:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766166166; cv=none; b=Vwh+W+5uS+HxZa9Mrh6LlaTB8rPUm194VXAov06Iy4r6Zfzalnapx0S7Mius3a4cfKnD6oxaTpT2v6H+s0Hy3n3VrTyqSZXgc53/ZbcbIITH2WQdKRx6pnfQWZdKmQu668Ydi5U3adYv9kixBcvCv0+xjGmf9w7l7L6TjThnv3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766166166; c=relaxed/simple;
	bh=bMvGZiYL4xkf5D+OsYqyhw4q+JZofmR3kO/s/ckGLYU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OnWDUVaOFwnW+Nj0mJfpRdIsIzzpfupNFNnTgink2LhBdx5TEFtlkNWnMAJZUS8XHTLHDBQYaIfJfxI4T3i2ZhySPsmjDev3JV3v9YHuXpRz95vJ3+pUH6aYKZO0LPwc/DIj1Lm5kaqnkDTlNUGQBFIxgWAZASlnxgxrByRMZsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=njsQLQk0; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1766166164; x=1797702164;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bMvGZiYL4xkf5D+OsYqyhw4q+JZofmR3kO/s/ckGLYU=;
  b=njsQLQk0DgtX/wcj2+6pT+dDUXA80BWQgXkPHnv1YJ1n+dC2H7hPXddo
   +6riRx0qrJelZjQ33pblXQmzPh753TK6GlJP0IevYYWLW8lWHEydnlSOm
   PXE2keaGn35wsfBv/bOY27DVvD59BiDadbxqzY9+uaKewPvm7igh2REk3
   jcxnJXO1fvGb1WnMMs8SnxadhBCeXrUq+bv928Ra2AbxLznUgsfvqD4AH
   Oebal9kVG0E4A9PtzEmY+R1oOOd/NO+VurwX+i+ky/m6zsRL6Rxw6cbXa
   6siH38ppUga609kspn+N/eOHpskU/lJJL3XOGF5fG/RNaV4ATwSpuIyWW
   w==;
X-CSE-ConnectionGUID: PvQsYP4mTmiacGWBVx6OCg==
X-CSE-MsgGUID: t1onHBw6Q9SUtxdo9Cf41A==
X-IronPort-AV: E=McAfee;i="6800,10657,11647"; a="67880682"
X-IronPort-AV: E=Sophos;i="6.21,161,1763452800"; 
   d="scan'208";a="67880682"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2025 09:42:44 -0800
X-CSE-ConnectionGUID: cKvUx6oqTdK6pI6C/rQIbA==
X-CSE-MsgGUID: PngX/G79S2W6hobgLslamw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,161,1763452800"; 
   d="scan'208";a="198497090"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.61])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2025 09:42:40 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Dominik Brodowski <linux@dominikbrodowski.net>,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 14/23] resource: Mark res given to resource_assigned() as const
Date: Fri, 19 Dec 2025 19:40:27 +0200
Message-Id: <20251219174036.16738-15-ilpo.jarvinen@linux.intel.com>
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

The caller may hold a const struct resource which will trigger an
unnecessary warning when calling resource_assigned() as it will not
modify res in anyway.

Mark resource_assigned()'s struct resource *res parameter const to
avoid the compiler warning.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 include/linux/ioport.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/ioport.h b/include/linux/ioport.h
index 9afa30f9346f..60ca6a49839c 100644
--- a/include/linux/ioport.h
+++ b/include/linux/ioport.h
@@ -338,7 +338,7 @@ static inline bool resource_union(const struct resource *r1, const struct resour
  * Check if this resource is added to a resource tree or detached. Caller is
  * responsible for not racing assignment.
  */
-static inline bool resource_assigned(struct resource *res)
+static inline bool resource_assigned(const struct resource *res)
 {
 	return res->parent;
 }
-- 
2.39.5


