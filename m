Return-Path: <linux-pci+bounces-13515-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CBA899861DC
	for <lists+linux-pci@lfdr.de>; Wed, 25 Sep 2024 17:03:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E30E28B9E8
	for <lists+linux-pci@lfdr.de>; Wed, 25 Sep 2024 15:03:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 704B12F855;
	Wed, 25 Sep 2024 14:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="noDiH0BD"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA4253770D
	for <linux-pci@vger.kernel.org>; Wed, 25 Sep 2024 14:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727275532; cv=none; b=j69ulLTfw0QGAB97OsukROK3gmvTC9YAak2REFtbY6HmE7cWwbG0QpQUFmxVmYRz3ZSVFjVBlpTIE+W6HFejMvp4PTGlidlHzLR+4iPfTnkimCbu/W8xgqON2IQ5ZIAZ+98i3JUNXTIfZI5psX7eCDHFiHFcFGPowhU/64x3R34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727275532; c=relaxed/simple;
	bh=aSKOXtfRb6IIHrPBBBqYmZWBMi7dadENEpMMg1PlviA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nUAZ156ujXMfQOtOwjFr5OyuiiN6WKeT0APHB6J6Xc1jlIUzLhirOHxZnHQtG2W+uajusW16AdcfPkwxIYauamMwU92phIBO2gJqzm4V3LoVw+IR9f/wjbztP1JtwVlmRfxkHp602Z9wghmw1WxZvqTQxhPT3v08NCp65Nz8MvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=noDiH0BD; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727275531; x=1758811531;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=aSKOXtfRb6IIHrPBBBqYmZWBMi7dadENEpMMg1PlviA=;
  b=noDiH0BDhq4Yye2+QdypZY3AT17lqufHEYiKKti/yi1WWaTRM4R0nJgl
   aeGPDQnYIwx7oFNCqs7t97VvHISa0mxjp2QOTLSJkjgvEdpGcVcrktetv
   MmaEd6prSH7ARHb/io9gTnlXJx55FWOn9HKmtTqYVfmBckkiIf0+XQw/P
   urhuIncWddbn1fAwG+FxGhplckCyeFugEewWYv/vggDf/13ElveDKvVEV
   tcdzmSmF/xu4BsUnLAfvZllu61PfCpo277Xf8njUttogS6UzaKJC5aoux
   2GiyGRR6+y4ul796YEwPiDsHxhaMBCSiUf3j6xJn/oB24Qx1LaKQ+Qds6
   Q==;
X-CSE-ConnectionGUID: +WQqEhUsSsq4NiEltZtEUw==
X-CSE-MsgGUID: 5MvfpxLfTc2Y0thM11yq2A==
X-IronPort-AV: E=McAfee;i="6700,10204,11206"; a="26470583"
X-IronPort-AV: E=Sophos;i="6.10,257,1719903600"; 
   d="scan'208";a="26470583"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2024 07:45:30 -0700
X-CSE-ConnectionGUID: X1m7tzVoQG6B9HK19KNjxw==
X-CSE-MsgGUID: g1BOZW9wQny1LLgOMBBmuw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,257,1719903600"; 
   d="scan'208";a="71941473"
Received: from stinkpipe.fi.intel.com (HELO stinkbox) ([10.237.72.74])
  by fmviesa008.fm.intel.com with SMTP; 25 Sep 2024 07:45:27 -0700
Received: by stinkbox (sSMTP sendmail emulation); Wed, 25 Sep 2024 17:45:26 +0300
From: Ville Syrjala <ville.syrjala@linux.intel.com>
To: intel-gfx@lists.freedesktop.org
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	linux-pci@vger.kernel.org
Subject: [PATCH 0/6] drm/i915/pm: Clean up the hibernate vs. PCI D3 quirk
Date: Wed, 25 Sep 2024 17:45:20 +0300
Message-ID: <20240925144526.2482-1-ville.syrjala@linux.intel.com>
X-Mailer: git-send-email 2.44.2
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Ville Syrjälä <ville.syrjala@linux.intel.com>

Attempt to make i915 rely more on the standard pci pm
code instead of hand rolling a bunch of
pci_save_state()+pci_set_power_state() stuff in the
driver.

Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: linux-pci@vger.kernel.org

Ville Syrjälä (6):
  PCI/PM: Respect pci_dev->skip_bus_pm in the .poweroff() path
  drm/i915/pm: Hoist pci_save_state()+pci_set_power_state() to the end
    of pm _late() hook
  drm/i915/pm: Simplify pm hook documentation
  drm/i915/pm: Move the hibernate+D3 quirk stuff into noirq() pm hooks
  drm/i915/pm: Do pci_restore_state() in switcheroo resume hook
  drm/i915/pm: Use pci_dev->skip_bus_pm for hibernate vs. D3 workaround

 drivers/gpu/drm/i915/i915_driver.c | 121 +++++++++++++++++++----------
 drivers/pci/pci-driver.c           |  16 +++-
 2 files changed, 94 insertions(+), 43 deletions(-)

-- 
2.44.2


