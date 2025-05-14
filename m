Return-Path: <linux-pci+bounces-27758-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D827AB75FE
	for <lists+linux-pci@lfdr.de>; Wed, 14 May 2025 21:35:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEDF9865DEE
	for <lists+linux-pci@lfdr.de>; Wed, 14 May 2025 19:34:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 856A02951A3;
	Wed, 14 May 2025 19:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DO6HimHt"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 595E22949F9;
	Wed, 14 May 2025 19:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747251280; cv=none; b=a5CxwRIreNp67D2upvPUOWqdfgE9o1pM7rGObfwNsFNYCRK9N2SLQl/ECOnxx8bn24H6niqiTvfvMuwyn3GklezOuqBsakjHLdWJEfa6/xxPqzeYNqoSpz0tFXWzlsuFIwqymtTAa7GOS4LRWADiR29qFAcQm3Cy/uM9DJpc8ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747251280; c=relaxed/simple;
	bh=LB2ONc/3BqVLy79e00jHCVU/mzynv4kwHq33TPW/jAA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tvXo/r4B7JFqTTZDcL953bjtfKf/wJsknv3d35FycLJjCjlcCnOR/dhKP6w1h+kGiCT9GJmDmcuDPAlTsnPHeBbABQDPR5fguTNgLyKAtdMrg4TJszAMrS82/siTTarSvKPE3Q8WXE9TV+kALrFoHOdExqybWad2hjE41pgQrqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DO6HimHt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D0D4C4CEF3;
	Wed, 14 May 2025 19:34:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747251279;
	bh=LB2ONc/3BqVLy79e00jHCVU/mzynv4kwHq33TPW/jAA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DO6HimHtI31Dcm16iw6Zla/z/RpuGxcX0zMJ6uEjmvrljF1ktSnKgCKJfwbtYt5Bb
	 lmyc0XfzMriIo2rHrUPGLPKiaSB4Kyk0Nz/+flbXZWKex+vFCsmYw6EQ/fy9eD8M1A
	 BiXlGkm6AqsHymRfbyFMgreVS3YaGjUiQotn4ysD1di7Gz1VfBOHo0m+3BnBrum6/h
	 jm5cHDNOz+VOUAVzVzEvKScbd3MH2pfD8rXOKIBXEnADMcm5sZx5927dimAuHrp1hx
	 tNbGKPoMQt8gInI2K1B/9xFGlGjsr9voeciB+fSDsaaQHfWc45ZmoBIeuMWnziHaic
	 cX2qCWAJ8XVuQ==
From: Mario Limonciello <superm1@kernel.org>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	Alex Deucher <alexander.deucher@amd.com>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: amd-gfx@lists.freedesktop.org (open list:RADEON and AMDGPU DRM DRIVERS),
	linux-pm@vger.kernel.org (open list:HIBERNATION (aka Software Suspend, aka swsusp)),
	linux-pci@vger.kernel.org (open list:PCI SUBSYSTEM),
	linux-kernel@vger.kernel.org (open list),
	Mario Limonciello <mario.limonciello@amd.com>,
	AceLan Kao <acelan.kao@canonical.com>,
	Kai-Heng Feng <kaihengf@nvidia.com>,
	Mark Pearson <mpearson-lenovo@squebb.ca>,
	Denis Benato <benato.denis96@gmail.com>,
	=?UTF-8?q?Merthan=20Karaka=C5=9F?= <m3rthn.k@gmail.com>
Subject: [PATCH v2 3/3] drm/amd: Avoid evicting resources at S5
Date: Wed, 14 May 2025 14:34:06 -0500
Message-ID: <20250514193406.3998101-4-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250514193406.3998101-1-superm1@kernel.org>
References: <20250514193406.3998101-1-superm1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Mario Limonciello <mario.limonciello@amd.com>

Normally resources are evicted on dGPUs at suspend or hibernate and
on APUs at hibernate.  These steps are unnecessary when using the S4
callbacks to put the system into S5.

Cc: AceLan Kao <acelan.kao@canonical.com>
Cc: Kai-Heng Feng <kaihengf@nvidia.com>
Cc: Mark Pearson <mpearson-lenovo@squebb.ca>
Cc: Denis Benato <benato.denis96@gmail.com>
Cc: Merthan Karakaş <m3rthn.k@gmail.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 4d1b54f58495a..ea1385b6d894f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4960,6 +4960,10 @@ static int amdgpu_device_evict_resources(struct amdgpu_device *adev)
 	if (!adev->in_s4 && (adev->flags & AMD_IS_APU))
 		return 0;
 
+	/* No need to evict when going to S5 through S4 callbacks */
+	if (system_state == SYSTEM_HALT || system_state == SYSTEM_POWER_OFF)
+		return 0;
+
 	ret = amdgpu_ttm_evict_resources(adev, TTM_PL_VRAM);
 	if (ret)
 		DRM_WARN("evicting device resources failed\n");
-- 
2.43.0


