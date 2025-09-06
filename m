Return-Path: <linux-pci+bounces-35609-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 69E55B470C2
	for <lists+linux-pci@lfdr.de>; Sat,  6 Sep 2025 16:39:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1ED3D7B4BEF
	for <lists+linux-pci@lfdr.de>; Sat,  6 Sep 2025 14:37:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 305672F49E9;
	Sat,  6 Sep 2025 14:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AP9PRAy2"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F18781E1E00;
	Sat,  6 Sep 2025 14:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757169442; cv=none; b=L2r0Y8QrRqHIFE0ZKloTEiCsWaNKUvjqR50ZNEB5/Thnqj4RjACd0c2SwKzZB1ex+agkncjLKLfs2gT6l6x/VLlJPUuhr5NC9V0R7qsh5goO1q1wHgLO0wRn7f85OXMLJ58mLYcdOFdcSqxfi/jpK6aqtR6Uoz05sTbgg9YdRrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757169442; c=relaxed/simple;
	bh=CU9T0V6J9tb9Id3BFIdxdN9dllemVrBDTK7lGJ+tm+M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BG7Sbb7JVH9vN/v0cMWfaWLA/yGBfj/s1wflpm0NKAgJ6SyYXS3fshvJUiPvXIR2uZejlg+R0tDogNGSUPC3udpZmx403zZ9UAbCJ1W3ZS1KErcXQ3se7sqTSiftxch1eSu8RjhdYqmpTws3EpK3RFdRa3EPT0UUo/+6qZycq+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AP9PRAy2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C6CFC4CEF7;
	Sat,  6 Sep 2025 14:37:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757169441;
	bh=CU9T0V6J9tb9Id3BFIdxdN9dllemVrBDTK7lGJ+tm+M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AP9PRAy27Rp2HjTon3vFa3hlvduhj7MFO/15RXEaGo8shDhhy80MguFSeZQ1xskan
	 ub0lMgBtFfRWBNP+EG3awKyVC68/C6RgxEXbY/bE+Nc8RH8EDhz/A5aVuOLh09Up6z
	 HzVFpPirjpRVwx9ceTu31v66eHrz+7i30m12O7BcvmDqEEkkbbDfOYCBv/9P5bgW1e
	 9xcZzGAGIAib2nqIk4Zj4qtS/tEcf+mwCEbqRi1MO24uIkUWDRl7NS9oB/a7clSq3h
	 PJrm97KKpFwdCOpdiD4a7Tj4IcD5zVhPlNUj3Qb3BkFrJC5iacxpm2J03Lg0XQbh71
	 m3WBTLI631+Aw==
From: "Mario Limonciello (AMD)" <superm1@kernel.org>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: Pavel Machek <pavel@kernel.org>,
	Len Brown <lenb@kernel.org>,
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
Subject: [PATCH v6 RESEND 10/11] drm/amd: Avoid evicting resources at S5
Date: Sat,  6 Sep 2025 09:36:41 -0500
Message-ID: <20250906143642.2590808-11-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250906143642.2590808-1-superm1@kernel.org>
References: <20250906143642.2590808-1-superm1@kernel.org>
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
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 01d234cf81564..9b7f9e9c06404 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -5012,6 +5012,10 @@ static int amdgpu_device_evict_resources(struct amdgpu_device *adev)
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


