Return-Path: <linux-pci+bounces-32673-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C4B8B0CABF
	for <lists+linux-pci@lfdr.de>; Mon, 21 Jul 2025 20:57:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 25C817B1292
	for <lists+linux-pci@lfdr.de>; Mon, 21 Jul 2025 18:56:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D3F621FF2B;
	Mon, 21 Jul 2025 18:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fkzwoKaX"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03EAD1FE44B;
	Mon, 21 Jul 2025 18:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753124250; cv=none; b=EppzDIPJAc/ibAmF5/KLe20Cys4Chh6l5JHksP264Io9vPxWd88LAry7enBZWqExrMDoXpdQf/qlOBsHpRTmIoAICFHwwpn0lteCfpf2SSW+L95fzBWXBmPsVcU4UK6Sg37g3V7OGrTX654vceRcZE8BQJhBWMzibtxGaQQ1Nmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753124250; c=relaxed/simple;
	bh=BhzF/8x7nIu8yKK8Fbml0CqlRTvMR2bpBiH6njen/gQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aXpPq6W6tWu7Zgzr+7IOkoMZIPPuHCTkz70WNzLfnzYGy8iahBZ90068orpBFourrWwlYaddFLBI0Qbzq6mA0pPpNVAf4i6wTGq+OObjaGgReTzRUc5jH4T0BpYkiAHnADzD//bGQrzSTWyBmGRQoYFIryKQL4cIDGTcVQyaT/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fkzwoKaX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AF0DC4CEED;
	Mon, 21 Jul 2025 18:57:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753124249;
	bh=BhzF/8x7nIu8yKK8Fbml0CqlRTvMR2bpBiH6njen/gQ=;
	h=From:To:Cc:Subject:Date:From;
	b=fkzwoKaXLnW2fevV9ehM53EElfSr7LeO3MKRCqYE38Qp0EUrj3s5u+6ebA26frHRB
	 eVH/iVPzPtQqER5FanWl+UdxKbdLIRcXkLjLX3aCOfgBwLz/iUIzJK47O0lIV2CaI/
	 dIKkQdkaXj2eZG2T6/dyAFnei8W7ii8PzxDRITLBTj9zVrz8Y/o2mRF/MElGpHit62
	 BsZRUzrVGavVtUNoJMpdQ8cI90hTcg2g2la5UO6jq1NtcLiTTNLaY76pEhYZutK8ry
	 AbGM4iK3pknj5kSh07xYMyiD0tKpXYlhcj1xRp1TUh048yYe5P9WjXk4AfPJzyFo/s
	 /Iw5Bkugy3sZA==
From: Mario Limonciello <superm1@kernel.org>
To: David Airlie <airlied@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: Alex Deucher <alexander.deucher@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Simona Vetter <simona@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	dri-devel@lists.freedesktop.org (open list:DRM DRIVERS),
	linux-kernel@vger.kernel.org (open list),
	linux-pci@vger.kernel.org (open list:PCI SUBSYSTEM),
	Daniel Dadap <ddadap@nvidia.com>,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v4 0/1] Move `boot_display` from PCI to DRM
Date: Mon, 21 Jul 2025 13:57:25 -0500
Message-ID: <20250721185726.1264909-1-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mario Limonciello <mario.limonciello@amd.com>

Shortly after the series for introducing boot_display was merged
Manivannan Sadhasivam suggested that it's better not to introduce
new top level PCI attributes where possible.

He proposed that the boot_display attribute should be provided by DRM
instead and that userspace should look for that.

Change the owner of `boot_display` from the PCI device to the DRM card.
This should also have the side effect that non-PCI DRM drivers can
add support more easily.

NOTE: If acceptable this should be merged through the PCI tree as it
depends upon changes and symbols from the boot_display series.

Mario Limonciello (1):
  PCI: Move boot display attribute to drm

 Documentation/ABI/testing/sysfs-bus-pci |  9 -----
 drivers/gpu/drm/drm_sysfs.c             | 41 ++++++++++++++++++++++
 drivers/pci/pci-sysfs.c                 | 45 -------------------------
 3 files changed, 41 insertions(+), 54 deletions(-)


base-commit: c4f2dc1e5293c4383844d8161d9922adda534e7c
-- 
2.43.0


