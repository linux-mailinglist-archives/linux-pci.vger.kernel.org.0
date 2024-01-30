Return-Path: <linux-pci+bounces-2797-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5901A842300
	for <lists+linux-pci@lfdr.de>; Tue, 30 Jan 2024 12:28:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D3C41C210B8
	for <lists+linux-pci@lfdr.de>; Tue, 30 Jan 2024 11:28:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2393A66B49;
	Tue, 30 Jan 2024 11:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T5ZBE44i"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22315657BC;
	Tue, 30 Jan 2024 11:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706614100; cv=none; b=WgSlaytZRoTwchKQkxOqmicrF9lCjLZe8im2oOhxX8z4X7huREBCqfyV/Zzu2rrLujnczIVVrdP8qlc0unaPU2OpLMH4PKmmM6sN76xOrWk3urw1gkD2qU7m28sVm4/CgN9CfALunWUXvISbcSsc1TwuKnEfZC6FmCAidG6sGKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706614100; c=relaxed/simple;
	bh=eJL/XKRz5Rj/B0GXTvlJ17kxFpJtQk9pJgOJUKAx18U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kqw8mrUYo9yC738I4dyiOpTgcKyloCnfBF/QcTJnBQXqNHyVLMulsQMT0drs0cHpm5RXzzcjAovdawJxDMQlQcI8DpO45/KOaCIiezc01wCjZMAUHBem09eOiJ02L8RXlXexWLcXTIrfKzPqcw99I5ELXQRJUqDzIk1mNM4IxTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T5ZBE44i; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706614098; x=1738150098;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=eJL/XKRz5Rj/B0GXTvlJ17kxFpJtQk9pJgOJUKAx18U=;
  b=T5ZBE44iGwk3VTXEYYj1WQqbzyxBac2kLQWJ6yVkpRtnqCyI3qFmPEcl
   BBGqWXBdG3ucZ3P6dQV1naXTfPS50lKZT1EcRz0jeL4e/oV0qQlQmTroQ
   H8ZGGzv8EVK5IBPmjhsNPqrJwl2MvPiOgrTnjmOxWXUAgJ05wQLHY1puN
   v2RZkpqMgItTTVBkrgjpyosVxarPKfWKUtgGZhwiFIYRvjEVNt6ILhDHT
   SWdRoM3Q1xjC1dDpgB987VosM7poA2NEOnpXZUWfgdcsnIVzfd5Oj/Xl4
   LCPB6Hj4yWBL9EkmDg6dL0NqYxTk/6IS4QJD//02Ch8hPdCRa8I0Nnpbf
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10968"; a="24727162"
X-IronPort-AV: E=Sophos;i="6.05,707,1701158400"; 
   d="scan'208";a="24727162"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2024 03:28:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10968"; a="878410341"
X-IronPort-AV: E=Sophos;i="6.05,707,1701158400"; 
   d="scan'208";a="878410341"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2024 03:28:10 -0800
Received: from svinhufvud.ger.corp.intel.com (localhost [IPv6:::1])
	by kekkonen.fi.intel.com (Postfix) with ESMTP id 8512811F8D2;
	Tue, 30 Jan 2024 13:28:05 +0200 (EET)
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
	linux-sound@vger.kernel.org,
	Bjorn Helgaas <helgaas@kernel.org>
Subject: [PATCH v5 0/2] Small runtime PM API changes
Date: Tue, 30 Jan 2024 13:28:04 +0200
Message-Id: <20240130112805.158790-1-sakari.ailus@linux.intel.com>
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

since v4:

- patch 1: Squash patch 2
  <URL:https://lists.freedesktop.org/archives/dri-devel/2024-January/438739.html>.

- patch 1: Add to documentation of pm_runtime_get_if_{active,in_use} that
  if PM runtime is disabled, an error is returned and the usage_count
  remains unmodified.

- patch 1: Fix spelling of "explicitly" in the commit message.

- Use upper case "PM:" prefix in subject.

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

Sakari Ailus (2):
  PM: runtime: Simplify pm_runtime_get_if_active() usage
  PM: runtime: Add pm_runtime_put_autosuspend() replacement

 Documentation/power/runtime_pm.rst      | 22 +++++++++-------
 drivers/accel/ivpu/ivpu_pm.c            |  2 +-
 drivers/base/power/runtime.c            | 35 +++++++++++++++++++++++--
 drivers/gpu/drm/i915/intel_runtime_pm.c |  5 +++-
 drivers/gpu/drm/xe/xe_pm.c              |  2 +-
 drivers/media/i2c/ccs/ccs-core.c        |  2 +-
 drivers/media/i2c/ov64a40.c             |  2 +-
 drivers/media/i2c/thp7312.c             |  2 +-
 drivers/net/ipa/ipa_smp2p.c             |  2 +-
 drivers/pci/pci.c                       |  2 +-
 include/linux/pm_runtime.h              | 30 ++++++++++-----------
 sound/hda/hdac_device.c                 |  2 +-
 12 files changed, 73 insertions(+), 35 deletions(-)

-- 
2.39.2


