Return-Path: <linux-pci+bounces-32697-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 65A4EB0D0D3
	for <lists+linux-pci@lfdr.de>; Tue, 22 Jul 2025 06:11:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 536481888F25
	for <lists+linux-pci@lfdr.de>; Tue, 22 Jul 2025 04:11:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B122228C5B8;
	Tue, 22 Jul 2025 04:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zm37Brpw"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8836B28C5B4;
	Tue, 22 Jul 2025 04:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753157457; cv=none; b=Q0WgATTRKmgQGhKv4Nw3JxPlYhmr1aWT4nFKBhqI+bBOMIlIck0SnVJ7zK2Rpal2xntqtTZClchr/Z8dr74QcWK9nSxyJwpqmKGImj4i9AyzFRUjr5koQZDhwoWM+haS1IDb1BgLN+fEGN5c6ypHctYdf0gDt+AQFHQgva/K82s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753157457; c=relaxed/simple;
	bh=SO48SSCClsG29iB6kfZExF+7QC9O2KIYl8N/lhW/E3E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LDfqd8WBndP/SrQvW+OV1lCjTUPZHYVKKpQCUSH3RH9dIUNbPA39YjIBTxae/FtT3pUqeMytWi3sMYKz6+BuvyZrJudf67VBuSObRPKZ6nFDt8BLR42TAkshZdD1qxHmlk8k0qJbMNgAYgW1d0+wUOffZ7MRQ43BD1l9tLaiwLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zm37Brpw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43952C4CEEB;
	Tue, 22 Jul 2025 04:10:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753157457;
	bh=SO48SSCClsG29iB6kfZExF+7QC9O2KIYl8N/lhW/E3E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Zm37BrpwNNJGZf7gdSZ7nb4nX5sBFrgvk543/IQLqHvVXizjVJtPpv8ABkBhAkOfY
	 4cS4vYR5s8mRTGGHYSG/7EVVvZt5CgWjyHKes7xXj1Ajmm3NI2MYrhXLKJZ+s+WpQI
	 bAEk5d9Q/EHBdrDC8Db62c/qYgPYbfEC0AE/pDxtwv2uQkTMeClBnt48MkTHLryodw
	 3m8DUwzm0pQ9Qe0KXUQAjoY6bGN3/S4sh2aSlOWWjVb4r9fvwTbD1ZdkmjKARfJ0Kb
	 n2h6eaypw5/TJlm1bvp86GcpQ0eJEAAdCz4U6ym9TTAAOOZPgGj5u8obeSdEEv+TCw
	 mnvWDDDWfVv0Q==
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
Subject: [PATCH v5 1/2] fbcon: Stop using screen_info_pci_dev()
Date: Mon, 21 Jul 2025 23:10:50 -0500
Message-ID: <20250722041051.3354121-2-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250722041051.3354121-1-superm1@kernel.org>
References: <20250722041051.3354121-1-superm1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mario Limonciello <mario.limonciello@amd.com>

screen_info_pci_dev() relies upon resources being set up for devices
before walking and thus isn't a good candidate for video_is_primary_device()
when called as part of PCI device initialization.

The device argument passed to video_is_primary_device() already has the
necessary information.  Check that directly instead.

Suggested-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 arch/x86/video/video-common.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/x86/video/video-common.c b/arch/x86/video/video-common.c
index 4bbfffec4b640..e0aeee99bc99e 100644
--- a/arch/x86/video/video-common.c
+++ b/arch/x86/video/video-common.c
@@ -30,6 +30,8 @@ bool video_is_primary_device(struct device *dev)
 {
 #ifdef CONFIG_SCREEN_INFO
 	struct screen_info *si = &screen_info;
+	struct resource res[SCREEN_INFO_MAX_RESOURCES];
+	ssize_t i, numres;
 #endif
 	struct pci_dev *pdev;
 
@@ -45,8 +47,14 @@ bool video_is_primary_device(struct device *dev)
 		return true;
 
 #ifdef CONFIG_SCREEN_INFO
-	if (pdev == screen_info_pci_dev(si))
-		return true;
+	numres = screen_info_resources(si, res, ARRAY_SIZE(res));
+	for (i = 0; i < numres; ++i) {
+		if (!(res[i].flags & IORESOURCE_MEM))
+			continue;
+
+		if (pci_find_resource(pdev, &res[i]))
+			return true;
+	}
 #endif
 
 	return false;
-- 
2.48.1


