Return-Path: <linux-pci+bounces-33764-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A48AB21202
	for <lists+linux-pci@lfdr.de>; Mon, 11 Aug 2025 18:32:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B81683AF8DF
	for <lists+linux-pci@lfdr.de>; Mon, 11 Aug 2025 16:26:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B674F311C23;
	Mon, 11 Aug 2025 16:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hLnJICRx"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F0EB311C1D;
	Mon, 11 Aug 2025 16:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754929572; cv=none; b=ipHeEG3jQmxm1nRJzu49a9mhju3okLgKm6zMyKusZNLAU2QQUJX01YvIy6u8s6qGqpAbxfQLfmd2WPqeWvXVOv3v7574DmYq3n1L6nFTVg1rApDFe0KGFI5ql1nQLcZLwrnn7CwT15mSgwtNaAMWBSQkC0btUcE7uKCR9jC2Hlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754929572; c=relaxed/simple;
	bh=gNYAqjTZupx5u8E+7jSecXNAwLHiAD/o4N6Lakyj2Ms=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=W9GnZdbI0ikDHmwGs65GRY+a5DWLW2itPOyasXD/7Yx2yn3WJU/Kg8k2DqS6nP9m/QJcE9itMKm+W8D2IUeevgwX2i4DfzXqOkuooRqQ0Z5RAm0gAvDRhlFYtqAgoMq87g/uFlHkTd9VZCuCWe1RM/LkCFos8ddp6lYrIU0Nccw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hLnJICRx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D049EC4CEED;
	Mon, 11 Aug 2025 16:26:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754929572;
	bh=gNYAqjTZupx5u8E+7jSecXNAwLHiAD/o4N6Lakyj2Ms=;
	h=From:To:Cc:Subject:Date:From;
	b=hLnJICRxVvO+g1TrTgxNMNOHIqx1nOpQnsDyp+/Y2tv46pM4kk0J5kU5ibttX4wE+
	 KS/sETEhbDYwB5LXd0rFpd+rlvvdEWLE9afBF05qs01nNj5aM4o+qeH2fRaNiJSK4H
	 6d4cm6nwI23sw7sIc2NwgjqBByy6bmq4+to8KyKeEWZX31xaYf7UGt/dGZXPKMrYBs
	 IMkTR5HAMFinab6Bgi4BheyXhQy4USokXTThPHERcG4ZDZvxPqtg3AopUcuYfDiPQO
	 y+RDxkb/ur2tMG7gxlfiTxVG5RYkObjFbUUk7/iH2hsVAb5ndwxbpfI/nsvOfSVk2d
	 JGCv+/l0+MDvg==
From: "Mario Limonciello (AMD)" <superm1@kernel.org>
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
	Mario Limonciello <superm1@kernel.org>
Subject: [PATCH v10 0/4] Adjust fbcon console device detection
Date: Mon, 11 Aug 2025 11:26:02 -0500
Message-ID: <20250811162606.587759-1-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Systems with more than one GPU userspace doesn't know which one to be
used to treat as primary.  The concept of primary is important to be
able to decide which GPU is used for display and  which is used for
rendering.  If it's guessed wrong then both GPUs will be kept awake
burning a lot of power.

Historically it would use the "boot_vga" attribute but this isn't
present on modern GPUs.

This series started out as changes to VGA arbiter to try to handle a case
of a system with 2 GPUs that are not VGA devices and avoid changes to
userspace.  This was discussed but decided not to overload the VGA arbiter
for non VGA devices.

Instead move the x86 specific detection of framebuffer resources into x86
specific code that the fbcon can use to properly identify the primary
device. This code is still called from the VGA arbiter, and the logic does
not change there. To avoid regression default to VGA arbiter and only fall
back to looking up with x86 specific detection method.

In order for userspace to also be able to discover which device was the
primary video display device create a new sysfs file 'boot_display'.

A matching userspace implementation for this file is available here:
Link: https://gitlab.freedesktop.org/xorg/lib/libpciaccess/-/merge_requests/39
Link: https://gitlab.freedesktop.org/xorg/xserver/-/merge_requests/2038

Dave Airlie has been pinged for a comment on this approach.
Dave had suggested in the past [1]:

"
 But yes if that doesn't work, then maybe we need to make the boot_vga
 flag mean boot_display_gpu, and fix it in the kernel
"

This was one of the approached tried in earlier revisions and it was
rejected in favor of creating a new sysfs file (which is what this
version does).

As the dependendent symbols are in 6.17-rc1 this can merge through
drm-misc-next.

Link: https://gitlab.freedesktop.org/xorg/lib/libpciaccess/-/merge_requests/37#note_2938602 [1]

---
v10:
 * Add patches that didn't merge to v6.17-rc1 in
 * Move sysfs file to drm ownership

Mario Limonciello (AMD) (4):
  Fix access to video_is_primary_device() when compiled without
    CONFIG_VIDEO
  PCI/VGA: Replace vga_is_firmware_default() with a screen info check
  fbcon: Use screen info to find primary device
  DRM: Add a new 'boot_display' attribute

 Documentation/ABI/testing/sysfs-class-drm |  8 +++++
 arch/parisc/include/asm/video.h           |  2 +-
 arch/sparc/include/asm/video.h            |  2 ++
 arch/x86/include/asm/video.h              |  2 ++
 arch/x86/video/video-common.c             | 25 +++++++++++++-
 drivers/gpu/drm/drm_sysfs.c               | 41 +++++++++++++++++++++++
 drivers/pci/vgaarb.c                      | 31 +++--------------
 7 files changed, 83 insertions(+), 28 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-class-drm


base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
-- 
2.43.0


