Return-Path: <linux-pci+bounces-2413-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 02F2783624E
	for <lists+linux-pci@lfdr.de>; Mon, 22 Jan 2024 12:44:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 914EA1F2150E
	for <lists+linux-pci@lfdr.de>; Mon, 22 Jan 2024 11:44:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D5333D56B;
	Mon, 22 Jan 2024 11:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Zc0oP46+"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC6BF3D3BC;
	Mon, 22 Jan 2024 11:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.55.52.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705923695; cv=none; b=CLdveub9mrodnnLokbpOYDO7Jy30VB75F8ZiTW7QdtLlkK9CT+L4Q8TCBuKzMYQLiedQnSkAntCpreevKLWSgFIx620/nq8tAwfd072IHIC/gTHRs5tQnsGnN/OrkZa3zLaRg6uLH6hCo36nvKGRyMMfwrKv6UJ9f/SD/oQfxYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705923695; c=relaxed/simple;
	bh=TFWI6JTKREohL41oXLi1D5cttfNwbBSLh8m7YgHZDUg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PAm+J11DMDZdhjejr8I8mFu0dI8JjeBj0U13hmDx04PCun4TsUwHYRuAKP4u0oKwJBOtIUINCcGhsHADf6ibuJNFq83yWYC3FQiH66E5kOcBV9by73dEBV04WEZ8qC2JLCJynrfAVxe3HW8KnTnUKtNUDdZn1qFd/ayLRL+Ukiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Zc0oP46+; arc=none smtp.client-ip=192.55.52.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705923693; x=1737459693;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=TFWI6JTKREohL41oXLi1D5cttfNwbBSLh8m7YgHZDUg=;
  b=Zc0oP46+2c3YTs6ZRrxSzC2w+MyvRR3FozqmHryTVPkMrdLyB+7weC6h
   oYkTsZOCy2qDATPdtt+IWWCV9S9Z0XsZCPtJi/8jmc95uxSBU8/l7dJah
   pvyPEcyUv+5DDxyPp+TEUOqdYKFJ8uozmbuJA36uPEoLkJpztIYyMh2xu
   4jUCrak0xKNwf9zBE/D3ZhBaYi0CWY84mDxAJ1QTQxlTcGY6fgAyCwQsJ
   ryCp5A54wFcldGpBDsFjZyO0o25ZkEuH6tj4lScMQNlWI7Bwx38gJ+2qG
   pQcQmZ8wvgqoyCdgQjqqwhOhbCFwZuy2pGNYKEtNykWWyI80F9ec6xPu+
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10960"; a="432347123"
X-IronPort-AV: E=Sophos;i="6.05,211,1701158400"; 
   d="scan'208";a="432347123"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2024 03:41:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10960"; a="904825864"
X-IronPort-AV: E=Sophos;i="6.05,211,1701158400"; 
   d="scan'208";a="904825864"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2024 03:41:26 -0800
Received: from svinhufvud.ger.corp.intel.com (localhost [IPv6:::1])
	by kekkonen.fi.intel.com (Postfix) with ESMTP id E3EFC11FAD4;
	Mon, 22 Jan 2024 13:41:21 +0200 (EET)
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
Subject: [PATCH v3 0/2] Small runtime PM API changes
Date: Mon, 22 Jan 2024 13:41:20 +0200
Message-Id: <20240122114121.56752-1-sakari.ailus@linux.intel.com>
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
<URL:https://git.kernel.org/pub/scm/linux/kernel/git/sailus/linux-next.git/log/?h=pm>

Later on, users calling pm_runtime_mark_last_busy() immediately followed
by __pm_runtime_put_autosuspend() will be switched back to
pm_runtime_put_autosuspend() once its behaviour change has been done (a
patch near top of that branch). I'll provide these once the preceding ones
have been merged.

Comments are welcome.

since v2:

- Rebase on v6.8-rc1 (no changes).

- Add Rodrigo's Reviewed-by: to the 1st patch.

since v1:

- patch 1: Rename __pm_runtime_get_conditional() as
  pm_runtime_get_conditional().

- patch 1: Reword documentation on driver use of
  pm_runtime_get_conditional().

Sakari Ailus (2):
  pm: runtime: Simplify pm_runtime_get_if_active() usage
  pm: runtime: Add pm_runtime_put_autosuspend() replacement

 Documentation/power/runtime_pm.rst      | 22 ++++++++-----
 drivers/accel/ivpu/ivpu_pm.c            |  2 +-
 drivers/base/power/runtime.c            | 10 ++++--
 drivers/gpu/drm/i915/intel_runtime_pm.c |  2 +-
 drivers/gpu/drm/xe/xe_pm.c              |  2 +-
 drivers/media/i2c/ccs/ccs-core.c        |  2 +-
 drivers/media/i2c/ov64a40.c             |  2 +-
 drivers/media/i2c/thp7312.c             |  2 +-
 drivers/net/ipa/ipa_smp2p.c             |  2 +-
 drivers/pci/pci.c                       |  2 +-
 include/linux/pm_runtime.h              | 44 ++++++++++++++++++++++---
 sound/hda/hdac_device.c                 |  2 +-
 12 files changed, 68 insertions(+), 26 deletions(-)

-- 
2.39.2


