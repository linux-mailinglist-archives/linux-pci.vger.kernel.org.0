Return-Path: <linux-pci+bounces-14479-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CEBB399D298
	for <lists+linux-pci@lfdr.de>; Mon, 14 Oct 2024 17:28:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4C53CB27F88
	for <lists+linux-pci@lfdr.de>; Mon, 14 Oct 2024 15:28:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6D151AB538;
	Mon, 14 Oct 2024 15:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t1zaARpt"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A012E1AAE00;
	Mon, 14 Oct 2024 15:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728919516; cv=none; b=s2BdohIh3grzmGZnIYE8Da+ShHM67Py4E1k6SgVReHWzhLZOtVlpk33kmrwo5vUtwGUaXF1QVnvnsqWTk3BpRqSyWK4ek46um6aTfsVt5KiMCyJByUU+AzwztTQgyRpY+pGMCJw1ESNEfhWZAADlqz6IUKAnXJVwmZct8HpzqdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728919516; c=relaxed/simple;
	bh=hS0sb+6oNOgPc3WYv1Lobl2azHFyEHVXBQuVnWLPR4Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Z8t2fsdB8ZBHbndq0OrIGFAsIlbsMabPNhjGm1I9L3q38TQlZOMa/LRib4Xa1JJmaqIXF7Ldn/lnkbnTtJHTzueKlThpA9kIHNrhHYf3pMlRaiXULz+gAvmdMkxH/UzQrhCMrfZDcO1/ngfo9csEn1GTcd+LImpi28bod1HpIXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t1zaARpt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FC87C4CEC3;
	Mon, 14 Oct 2024 15:25:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728919516;
	bh=hS0sb+6oNOgPc3WYv1Lobl2azHFyEHVXBQuVnWLPR4Q=;
	h=From:To:Cc:Subject:Date:From;
	b=t1zaARptC5NRLY/+fKGIXj9iAHaQQz/c4v/7SJqxoqub1Zgp1RR+kTOafxwsQ0xHU
	 yCL4yR9N/zz4snk7z6MZETr/0kSCfiTj5Rorh9XKifRNcE8CahiRnp1W9EJUMg2z3m
	 7+XCDjifVXzyLI6fuYxBT3bCbf/GaqyGCPf2gcMrUhfAoX5f0IgRSo+0Ee+F4XJJHt
	 7PoUcRgzUNiBZESfOPCcMq8bpxvSzKBcYzinE0/Nbod8AYA5GT1NylZ+hlenHiscku
	 /DldY+fZYSyfIzdawFiHHgMIc0jBY2AZJfWLkwMms87F07s6do6lYeCrkY66BdClJ3
	 DA/FeU0W/0SgA==
From: Mario Limonciello <superm1@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org (open list:PCI SUBSYSTEM),
	linux-kernel@vger.kernel.org (open list),
	dri-devel@lists.freedesktop.org,
	Mario Limonciello <mario.limonciello@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	"Luke D . Jones" <luke@ljones.dev>
Subject: [PATCH] PCI/VGA: Don't assume only VGA device found is the boot VGA device
Date: Mon, 14 Oct 2024 10:25:02 -0500
Message-ID: <20241014152502.1477809-1-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mario Limonciello <mario.limonciello@amd.com>

The ASUS GA605W has a NVIDIA PCI VGA device and an AMD PCI display device.

```
65:00.0 VGA compatible controller: NVIDIA Corporation AD106M [GeForce RTX 4070 Max-Q / Mobile] (rev a1)
66:00.0 Display controller: Advanced Micro Devices, Inc. [AMD/ATI] Strix [Radeon 880M / 890M] (rev c1)
```

The fallback logic in vga_is_boot_device() flags the NVIDIA dGPU as the
boot VGA device, but really the eDP is connected to the AMD PCI display
device.

Drop this case to avoid marking the NVIDIA dGPU as the boot VGA device.

Suggested-by: Alex Deucher <alexander.deucher@amd.com>
Reported-by: Luke D. Jones <luke@ljones.dev>
Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3673
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/pci/vgaarb.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/pci/vgaarb.c b/drivers/pci/vgaarb.c
index 78748e8d2dba..05ac2b672d4b 100644
--- a/drivers/pci/vgaarb.c
+++ b/drivers/pci/vgaarb.c
@@ -675,13 +675,6 @@ static bool vga_is_boot_device(struct vga_device *vgadev)
 		return true;
 	}
 
-	/*
-	 * Vgadev has neither IO nor MEM enabled.  If we haven't found any
-	 * other VGA devices, it is the best candidate so far.
-	 */
-	if (!boot_vga)
-		return true;
-
 	return false;
 }
 
-- 
2.43.0


