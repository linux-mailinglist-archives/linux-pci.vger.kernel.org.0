Return-Path: <linux-pci+bounces-13520-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 289C19861E1
	for <lists+linux-pci@lfdr.de>; Wed, 25 Sep 2024 17:03:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E57B428C0F9
	for <lists+linux-pci@lfdr.de>; Wed, 25 Sep 2024 15:03:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09F25142E6F;
	Wed, 25 Sep 2024 14:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mK/ir/F4"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C34B143890
	for <linux-pci@vger.kernel.org>; Wed, 25 Sep 2024 14:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727275549; cv=none; b=akkrcZ0+/71RubwXf5mjS4ZX0eqA63wQsRXqE5DJL35Ri4AjgrbjhSeLoLgBzQ94ob04zMIvya2j0rDQUSI/ydAtsCeCxoeHkrvoxk6L/VjdZtojp0XosJLsHlx8NBF+T+6bI6OFftxn9iePwO7RhY5/BST8hAy7aeOfMgvOl0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727275549; c=relaxed/simple;
	bh=1K+IQBTDR3o2GnEzsXafV3+2Jz5aJx0ClKBLZmm+KJg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ubo/ZdqajV6y6PIP3v5Y4IceC8C6WeBdmr3outTu6cPMgSsp9vRNVT7/VNgrERF6u3qk6lPo57rzayF/Wjo8ciCdPBwOSxt4WfJgA2TZnwJTiYTqAuIAweZ3qxqGic6dwO3OtZeFaCz0UFmxADDJp24pJu3p+r9MzJB9hpwkw3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mK/ir/F4; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727275549; x=1758811549;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1K+IQBTDR3o2GnEzsXafV3+2Jz5aJx0ClKBLZmm+KJg=;
  b=mK/ir/F4XXHUpSd5EuWGuEMO0eUzlFZrcBLrAqTdsd3mvn6zVvsyHeZW
   hDVuWDdLz4ey+w4YzvWXzaGSndUzzcnpwVVIsdrOjp/TUe5h4Jwn+BiBq
   gWhOKnttQYq6HlGQTVwxEEaOKxouomoMaaN8NPtbyF32e2U4OljElSt+C
   fHT09bc9CpPi3wO/bUbfOzfyAuIG3kh+u+o2xsOaUEcoBdi7CW1u5shh6
   ikKjK4PgHabUaLB9RZIDJ95ZedhpgqC4Ig8CUqNC3oNJUQBZAzt54Tzwy
   3TUCgneSXCgrs8Wa9GmPgXWKg7uvDAQTL6zdPR4kmXf8BU5XlTj7xRJHS
   w==;
X-CSE-ConnectionGUID: BV8JQ2IAR6ip2129/7LLOA==
X-CSE-MsgGUID: fHnWpFBHTs+HNORm45rhUA==
X-IronPort-AV: E=McAfee;i="6700,10204,11206"; a="26470653"
X-IronPort-AV: E=Sophos;i="6.10,257,1719903600"; 
   d="scan'208";a="26470653"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2024 07:45:48 -0700
X-CSE-ConnectionGUID: WsZF+1UHRDqrX3bO2ocNYA==
X-CSE-MsgGUID: tv/43O3vTamCvYYOGTkCgg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,257,1719903600"; 
   d="scan'208";a="71941653"
Received: from stinkpipe.fi.intel.com (HELO stinkbox) ([10.237.72.74])
  by fmviesa008.fm.intel.com with SMTP; 25 Sep 2024 07:45:45 -0700
Received: by stinkbox (sSMTP sendmail emulation); Wed, 25 Sep 2024 17:45:44 +0300
From: Ville Syrjala <ville.syrjala@linux.intel.com>
To: intel-gfx@lists.freedesktop.org
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	linux-pci@vger.kernel.org
Subject: [PATCH 5/6] drm/i915/pm: Do pci_restore_state() in switcheroo resume hook
Date: Wed, 25 Sep 2024 17:45:25 +0300
Message-ID: <20240925144526.2482-6-ville.syrjala@linux.intel.com>
X-Mailer: git-send-email 2.44.2
In-Reply-To: <20240925144526.2482-1-ville.syrjala@linux.intel.com>
References: <20240925144526.2482-1-ville.syrjala@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Ville Syrjälä <ville.syrjala@linux.intel.com>

Since this switcheroo stuff bypasses all the core pm we
have to manually manage the pci state. To that end add the
missing pci_restore_state() to the switcheroo resume hook.
We already have the pci_save_state() counterpart on the
suspend side.

I suppose this might not matter in practice as the
integrated GPU probably won't lose any state in D3,
and I presume there are no machines where this code
would come into play with an Intel discrete GPU.

Arguably none of this code should exist in the driver
in the first place, and instead the entire switcheroo
mechanism should be rewritten and properly integrated into
core pm code...

Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: linux-pci@vger.kernel.org
Cc: intel-gfx@lists.freedesktop.org
Signed-off-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
---
 drivers/gpu/drm/i915/i915_driver.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/i915/i915_driver.c b/drivers/gpu/drm/i915/i915_driver.c
index fe7c34045794..c3e7225ea1ba 100644
--- a/drivers/gpu/drm/i915/i915_driver.c
+++ b/drivers/gpu/drm/i915/i915_driver.c
@@ -1311,6 +1311,8 @@ int i915_driver_resume_switcheroo(struct drm_i915_private *i915)
 	if (ret)
 		return ret;
 
+	pci_restore_state(pdev);
+
 	ret = i915_drm_resume_early(&i915->drm);
 	if (ret)
 		return ret;
-- 
2.44.2


