Return-Path: <linux-pci+bounces-2473-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 13FCB838B20
	for <lists+linux-pci@lfdr.de>; Tue, 23 Jan 2024 10:57:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C20D6289BFC
	for <lists+linux-pci@lfdr.de>; Tue, 23 Jan 2024 09:57:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4748E5A10A;
	Tue, 23 Jan 2024 09:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GbaLFC2f"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 521965A781;
	Tue, 23 Jan 2024 09:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706003816; cv=none; b=bHg2nwWhBUeMCA/JA8mjh3wXry9s7GJOyQNHp2X8r9VwuiK1VzdK5uE0MliBMv3+u0mGPCAt8EW109k9XMzu8xi4fOEKlRPYovfoKREtDW9IHxtlJ3CVsaJpi1jBylqr5ndTm/ToGkMXvfm1yPsJ9J+pPMowysljvy04cMh/j70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706003816; c=relaxed/simple;
	bh=giqjHNiHA5lOOXvLyPmmD7zXAE91+Pqyfa9jWZiXxrk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Hvqli8CRUISjK/JNOIlQgZDwBdnAwQJekjwPf1LCcowhdMaNmJu8Vbijriv9WKfS4MLSJgrklqcWudLOOPa2StgVYwO7EUaTBHPtsJ3pkyDqH6wPe3Ut4pLFlAUpU70yR2KfeY1OpWVSyfMOy1GQt9iIUehcexy15qT8mmqqjoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GbaLFC2f; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706003815; x=1737539815;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=giqjHNiHA5lOOXvLyPmmD7zXAE91+Pqyfa9jWZiXxrk=;
  b=GbaLFC2fWlGW9+IB6Xgf8Bxcq4EaAD4lk3qS36kTvcsDd4X2bPqySXfJ
   FN8/q3O1seoEDpsnFF8Rg7WiEON+yJ00GR6P+UykLHekxsbKxvFcin08u
   mf03RParLv83OxPOlkMbZCtiaSK3ZAH1M0M9pX15UZkQKEgDSCtfPfpqG
   gHBY1tW5akeBrR89MqGFBWod9THaczH0u39CV3GVk4vQWu/YCwLii3s80
   UlTO4750NlOWHEF+T3XK6sTXi4r//zvWIeIPCfWY7aq6+DdXnUi9sEXur
   DHUK2abtM2AZEVOwUpIsbFA8K3S0VfUfT886WVhpMHFkp6X5yqthXQTVQ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10961"; a="365646"
X-IronPort-AV: E=Sophos;i="6.05,214,1701158400"; 
   d="scan'208";a="365646"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2024 01:56:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,214,1701158400"; 
   d="scan'208";a="27962082"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2024 01:56:47 -0800
Received: from svinhufvud.ger.corp.intel.com (localhost [IPv6:::1])
	by kekkonen.fi.intel.com (Postfix) with ESMTP id 2554111FC49;
	Tue, 23 Jan 2024 11:56:43 +0200 (EET)
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: linux-pm@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	laurent.pinchart@ideasonboard.com,
	Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>,
	Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Paul Elder <paul.elder@ideasonboard.com>,
	Alex Elder <elder@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Mark Brown <broonie@kernel.org>,
	dri-devel@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org,
	linux-media@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-sound@vger.kernel.org
Subject: [PATCH v4 0/3] Small runtime PM API changes
Date: Tue, 23 Jan 2024 11:56:41 +0200
Message-Id: <20240123095642.97303-1-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi folks,

Here's a small but a different set of patches for making two relatively
minor changes to runtime PM API. I restarted version numbering as this is
meaningfully different from the previous set.

pm_runtime_get_if_active() loses its second argument as it only made sense
to have ign_usage_count argument true.

The other change is also small but it has an effect on callers:
pm_runtime_put_autosuspend() will, in the future, be re-purposed to
include a call to pm_runtime_mark_last_busy() as well. Before this,
current users of the function are moved to __pm_runtime_put_autosuspend()
(added by this patchset) which will continue to have the current
behaviour.

I haven't included the conversion patches in this set as I only want to do
that once this set has been approved and merged. The tree specific patches
can be found here, on linux-next master (there are some V4L2 patches
there, too, please ignore them for now):
<URL:https://git.kernel.org/pub/scm/linux/kernel/git/sailus/linux-next.git/log/?

Later on, users calling pm_runtime_mark_last_busy() immediately followed
by __pm_runtime_put_autosuspend() will be switched back to
pm_runtime_put_autosuspend() once its behaviour change has been done (a
patch near top of that branch). I'll provide these once the preceding ones
have been merged.

Comments are welcome.

since v3:

- patch 1: Drop the previously added documentation on driver use of
  pm_runtime_get_conditional().

- Add a patch to make pm_runtime_get_conditional() static, including
  switching i915 to pm_runtime_get_if_{active,in_use}.

since v2:

- Rebase on v6.8-rc1 (no changes).

- Add Rodrigo's Reviewed-by: to the 1st patch.

since v1:

- patch 1: Rename __pm_runtime_get_conditional() as
  pm_runtime_get_conditional().

- patch 1: Reword documentation on driver use of
  pm_runtime_get_conditional().

Sakari Ailus (3):
  pm: runtime: Simplify pm_runtime_get_if_active() usage
  pm: runtime: Make pm_runtime_get_if_conditional() private
  pm: runtime: Add pm_runtime_put_autosuspend() replacement

 Documentation/power/runtime_pm.rst      | 22 +++++++++-------
 drivers/accel/ivpu/ivpu_pm.c            |  2 +-
 drivers/base/power/runtime.c            | 34 +++++++++++++++++++++++--
 drivers/gpu/drm/i915/intel_runtime_pm.c |  5 +++-
 drivers/gpu/drm/xe/xe_pm.c              |  2 +-
 drivers/media/i2c/ccs/ccs-core.c        |  2 +-
 drivers/media/i2c/ov64a40.c             |  2 +-
 drivers/media/i2c/thp7312.c             |  2 +-
 drivers/net/ipa/ipa_smp2p.c             |  2 +-
 drivers/pci/pci.c                       |  2 +-
 include/linux/pm_runtime.h              | 30 +++++++++++-----------
 sound/hda/hdac_device.c                 |  2 +-
 12 files changed, 72 insertions(+), 35 deletions(-)

-- 
2.39.2


