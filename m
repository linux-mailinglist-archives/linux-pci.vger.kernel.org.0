Return-Path: <linux-pci+bounces-32696-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD3E1B0D0D1
	for <lists+linux-pci@lfdr.de>; Tue, 22 Jul 2025 06:11:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F21F23A6683
	for <lists+linux-pci@lfdr.de>; Tue, 22 Jul 2025 04:10:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A2BF28C2D8;
	Tue, 22 Jul 2025 04:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NJ8yVbhm"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 724FB4C92;
	Tue, 22 Jul 2025 04:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753157456; cv=none; b=TRp6kN6I8ZPWbSL9X3RDCDZ/sFtQ1O4PNvMM5yygYPiH9d63J2B4LcAg7+dFzG/6m2+8DlSI69G0nP5QMM3evk7VH+Ga6IQ0X5Mh3IoZ+da4vvhFPatT9Xxr3lz/WAQn+nA47xNlnOPnAdL5hbKILeGFZDPasClfFFwV2gJHwF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753157456; c=relaxed/simple;
	bh=FH7yks64NF643MaNnJLEAGnr3ziSpbc76lbP3ZXYW1M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CluBkAjdBho2qsXyxu15PRnno11Cd7+xIMiH8SFnQkjEi08r+vu0Duhz0SIUdopb/SNhMzvuBny1Lin4hQ8sPDX3wYNqtDf4TdvSAP2IfyNu2sZuiCuJxpsiXDo2g498+Qw+a+cl0HKO9Dwp5kRX2HBsb5KQI3a/pcteRpXmBFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NJ8yVbhm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7038C4CEF1;
	Tue, 22 Jul 2025 04:10:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753157456;
	bh=FH7yks64NF643MaNnJLEAGnr3ziSpbc76lbP3ZXYW1M=;
	h=From:To:Cc:Subject:Date:From;
	b=NJ8yVbhmwkYdTSvohJFHgXSfMVdYq8MKiRO6iJTgorH4zcdSgIX+1fblApJOPT+pL
	 qH/lMGjO4kpCxjjGngKUpCaTTfYnvXucTeNInjG013K7t/e3age9IGaBVqT/IZDuSB
	 PCDM/KQKlMbVq/+ckotEdJ2XTwnyaPg2vjffFJ1tO8NeZzmYQZLGBD/c/eJ70dOF6J
	 gEPx05Mu5FgkjOkyP6SJXQj0J7k1v2JP5h7N4iAIzS206RdwM8i6nPqkXDUfCqA8w6
	 9DjIA5HAdLE2bn7WMzY9zsVxFsADgT60mgARn+POvyeDn8FYdw/nsY0ZUOVEjEXRfS
	 TBgTBK6wcnMHg==
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
Subject: [PATCH v5 0/2] Alternative approach for boot_display visibility
Date: Mon, 21 Jul 2025 23:10:49 -0500
Message-ID: <20250722041051.3354121-1-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mario Limonciello <mario.limonciello@amd.com>

The past few days there have been various discussions about what to do
with the boot_display sysfs file so that it doesn't need to be made so
late in startup.

Bjorn had an aha moment pointing out that there is no reason to "find"
the PCI device using screen_info_pci_dev() because the device is already
known.  Instead we just need to check if it has the screen resources.

This series adjusts the boot_display behavior to use that and then convert
boot_display into a static sysfs file that can be loaded when the device
is created without needing to change visibility.

This is an ALTERNATIVE to moving it to DRM, which is what v4 does [1].
Either solution can be picked up depending upon the collective decision
whether to keep boot_display file in PCI core or DRM core.

Link: https://lore.kernel.org/linux-pci/20250721185726.1264909-1-superm1@kernel.org/T/#me4356b3a172cbdafe83393bedce10f17a86e0da7

Mario Limonciello (2):
  fbcon: Stop using screen_info_pci_dev()
  PCI: Adjust visibility of boot_display attribute instead of creation

 arch/x86/video/video-common.c | 12 ++++++--
 drivers/pci/pci-sysfs.c       | 58 ++++++++++++-----------------------
 2 files changed, 30 insertions(+), 40 deletions(-)

-- 
2.48.1


