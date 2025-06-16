Return-Path: <linux-pci+bounces-29883-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BA62ADB812
	for <lists+linux-pci@lfdr.de>; Mon, 16 Jun 2025 19:51:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56A2E188B952
	for <lists+linux-pci@lfdr.de>; Mon, 16 Jun 2025 17:51:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4B11289E33;
	Mon, 16 Jun 2025 17:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lz69+ILc"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 917B0288C12;
	Mon, 16 Jun 2025 17:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750096237; cv=none; b=e1ekZtNz7jp0+6jsSXyqefsWsHITbffyT+6sF4msaryeQsajyLPDp8i1+6MPeSfMHcJ+Hqpvb7lxkihJjjYV8OgY3Ahl3IJfgWYOzxfn+UgTX2tT6ayVYsnWBqTrhSlLWL1kCrB63/xmp6hFzc1oRMoYMklVslOVKAOOHSC6UTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750096237; c=relaxed/simple;
	bh=EYdTArwvin65wexM18vPdaMIRqB0lvbLE4DDyu8zn9s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QYqFi1VRyH8e450GBxGDYK0PkWdcOHEhd44Oq+9WmyksiCu+FAo8oM9HPjIo4VO7KFXbuo+hZWICIxOU0/YHuhPA/f6jwSAmg3MxOH4/Yvb5yhYnp7x2uxf7Gh65017CY1eGf2nz6AUMryZl9Vxhck3RfhSWKZNeyr4Qctrf5Xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lz69+ILc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BC6CC4CEEE;
	Mon, 16 Jun 2025 17:50:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750096237;
	bh=EYdTArwvin65wexM18vPdaMIRqB0lvbLE4DDyu8zn9s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Lz69+ILcUuW20dCmN1poltLdx3jHTjFuwNxjysxjh9HKN99J4nnLGkDxnl2O8sSWq
	 GD/ai/Wx01l2Xu3m5hHjOnDtU1Ulgo2NWQaSdWNdC/UsRJg0gsRk3TPPLQMrZgs3bj
	 xJlN2rDUmCe8YgjRmvg+Wplm58bA47FO1fWVGjToAIVCvsBCUk4xtxxbPuiBS8KoHD
	 TVbt+RmJssWrj0TdRCD0ODjeY7OPEKJ96hErIZU4Yp9gkJyx2VHLG0v8mRYliXpjzy
	 dECJR74IrtAV8DKICBdt6a10wV0HgL1kr/jWC76bQUdMNjpwBaHDUcSPsUMh/WIm6f
	 RP9Jkjv7DdPYw==
From: Mario Limonciello <superm1@kernel.org>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	Alex Deucher <alexander.deucher@amd.com>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: amd-gfx@lists.freedesktop.org (open list:RADEON and AMDGPU DRM DRIVERS),
	linux-pm@vger.kernel.org (open list:HIBERNATION (aka Software Suspend, aka swsusp)),
	linux-pci@vger.kernel.org (open list:PCI SUBSYSTEM),
	linux-kernel@vger.kernel.org (open list),
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Danilo Krummrich <dakr@kernel.org>,
	"James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	dri-devel@lists.freedesktop.org (open list:DRM DRIVERS),
	linux-scsi@vger.kernel.org (open list:SCSI SUBSYSTEM),
	linux-usb@vger.kernel.org (open list:USB SUBSYSTEM),
	Mario Limonciello <mario.limonciello@amd.com>,
	AceLan Kao <acelan.kao@canonical.com>,
	Kai-Heng Feng <kaihengf@nvidia.com>,
	Mark Pearson <mpearson-lenovo@squebb.ca>,
	Denis Benato <benato.denis96@gmail.com>,
	=?UTF-8?q?Merthan=20Karaka=C5=9F?= <m3rthn.k@gmail.com>
Subject: [PATCH v4 3/5] drm/amd: Avoid evicting resources at S5
Date: Mon, 16 Jun 2025 12:50:17 -0500
Message-ID: <20250616175019.3471583-4-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250616175019.3471583-1-superm1@kernel.org>
References: <20250616175019.3471583-1-superm1@kernel.org>
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
v3: https://lore.kernel.org/linux-pm/20250609024619.407257-1-superm1@kernel.org/T/#me6db0fb946e3d604a8f3d455128844ed802c82bb
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 8edd88328749b..c5d8f6d551238 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4966,6 +4966,10 @@ static int amdgpu_device_evict_resources(struct amdgpu_device *adev)
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


