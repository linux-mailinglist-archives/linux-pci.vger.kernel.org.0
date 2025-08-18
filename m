Return-Path: <linux-pci+bounces-34159-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C92FDB2969E
	for <lists+linux-pci@lfdr.de>; Mon, 18 Aug 2025 04:02:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 576271962C62
	for <lists+linux-pci@lfdr.de>; Mon, 18 Aug 2025 02:03:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4540248883;
	Mon, 18 Aug 2025 02:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mUtg+8Ix"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EA6B1A4F12;
	Mon, 18 Aug 2025 02:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755482494; cv=none; b=ZBUSO71g1eA7Si9JjzoXK4z67Ecs9XAGdCVZ0ZYeQpNjzrTicehM+oObtPd6bkoi91X7kA8KCimFbUr4SXqCDPnp0yKIRfSfFQ4ZJxc3fOzcDLC3hIr3daD2bgjVJhDme+mJhGGJikJASaYVl6Wgos9DHY2Xp8H4P4004Z2dEbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755482494; c=relaxed/simple;
	bh=lZO49mOiU9nMXanXitdCGns/iICvFzwUE7jh8Qy4c6w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ohdnr3EabyKpsCtzZbmZLuEKGXnDptwt7WXz+vu34XQpzpQBmtj4j79iNgTCmATZpPhUElTGokIL8O43NWZvqXn5Wb7nWDtdAn+KLxaptQc/KBtAksQiCRVr5DLj6iz1o/7lAUhSq4k05G+lJr2BROni7E8qBFFkjycofRrYeqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mUtg+8Ix; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FDAFC116D0;
	Mon, 18 Aug 2025 02:01:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755482494;
	bh=lZO49mOiU9nMXanXitdCGns/iICvFzwUE7jh8Qy4c6w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mUtg+8Ixy9rII4+MTHrxsWg2lHMVoOIpQR/uevnZUUNiL8AYL3DGCDC065EP9hc4+
	 KIBNLcFSq83JTNa6idb7GOgH63z+5vohfjSmW8zOff7/PLgEM7kQbvCETSgy71mLOX
	 E0SMtzXZR1S7Q0CZQnh4SFV8vmkcfsLiKRq/Tzz4O6BL+euQjBH4BJbgstZJVNupds
	 MEVZnwq06pFUi6CdsEHZhXVLvnRy+7B5WIlIT24rh4ZzV1X3CUCsvje3mLeJb14REO
	 /l1qZ042Pbr3Y3Qw0XzjNaqFWUBtOYP7NMiv9DhJdMArBSU+CjpRgAhS1rdzbtO7PI
	 YioaJY/MG/jKQ==
From: "Mario Limonciello (AMD)" <superm1@kernel.org>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: Pavel Machek <pavel@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Danilo Krummrich <dakr@kernel.org>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	"James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-pm@vger.kernel.org (open list:HIBERNATION (aka Software Suspend, aka swsusp)),
	amd-gfx@lists.freedesktop.org (open list:RADEON and AMDGPU DRM DRIVERS),
	dri-devel@lists.freedesktop.org (open list:DRM DRIVERS),
	linux-pci@vger.kernel.org (open list:PCI SUBSYSTEM),
	linux-scsi@vger.kernel.org (open list:SCSI SUBSYSTEM),
	linux-usb@vger.kernel.org (open list:USB SUBSYSTEM),
	linux-trace-kernel@vger.kernel.org (open list:TRACING),
	AceLan Kao <acelan.kao@canonical.com>,
	Kai-Heng Feng <kaihengf@nvidia.com>,
	Mark Pearson <mpearson-lenovo@squebb.ca>,
	=?UTF-8?q?Merthan=20Karaka=C5=9F?= <m3rthn.k@gmail.com>,
	Eric Naim <dnaim@cachyos.org>,
	"Mario Limonciello (AMD)" <superm1@kernel.org>,
	Denis Benato <benato.denis96@gmail.com>,
	Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH v6 10/11] drm/amd: Avoid evicting resources at S5
Date: Sun, 17 Aug 2025 21:01:00 -0500
Message-ID: <20250818020101.3619237-11-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250818020101.3619237-1-superm1@kernel.org>
References: <20250818020101.3619237-1-superm1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Normally resources are evicted on dGPUs at suspend or hibernate and
on APUs at hibernate.  These steps are unnecessary when using the S4
callbacks to put the system into S5.

Cc: AceLan Kao <acelan.kao@canonical.com>
Cc: Kai-Heng Feng <kaihengf@nvidia.com>
Cc: Mark Pearson <mpearson-lenovo@squebb.ca>
Cc: Denis Benato <benato.denis96@gmail.com>
Cc: Merthan Karakaş <m3rthn.k@gmail.com>
Tested-by: Eric Naim <dnaim@cachyos.org>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
---
v5:
 * No changes
v4:
 * Add A-b tag for Alex
 * https://lore.kernel.org/linux-pci/20250616175019.3471583-1-superm1@kernel.org/
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index f9b4c4321f67c..4e4b7a63cc61e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -5017,6 +5017,10 @@ static int amdgpu_device_evict_resources(struct amdgpu_device *adev)
 	if (!adev->in_s4 && (adev->flags & AMD_IS_APU))
 		return 0;
 
+	/* No need to evict when going to S5 through S4 callbacks */
+	if (system_state == SYSTEM_HALT || system_state == SYSTEM_POWER_OFF)
+		return 0;
+
 	ret = amdgpu_ttm_evict_resources(adev, TTM_PL_VRAM);
 	if (ret) {
 		dev_warn(adev->dev, "evicting device resources failed\n");
-- 
2.43.0


