Return-Path: <linux-pci+bounces-8325-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E2058FCC66
	for <lists+linux-pci@lfdr.de>; Wed,  5 Jun 2024 14:19:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8B08296851
	for <lists+linux-pci@lfdr.de>; Wed,  5 Jun 2024 12:19:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E2261990B4;
	Wed,  5 Jun 2024 11:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HLwJWAUS"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 444031BA89E;
	Wed,  5 Jun 2024 11:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717588523; cv=none; b=Y+MI/VY8bJvsEqafJHAZTTOCNWhRClnuMJCCdZPc9l7KhZLjDIFfkpZU9ze/1w8yuMFZ48GqOmBzcIWpKAXP9lSyZsv0FVJ+b+ONzAWaeE0LQnIkHBSSQsuTa4/44bhDamR5WQYSoHLX2IzYF67+AIsAESikR/xKrsaURJRh+tE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717588523; c=relaxed/simple;
	bh=7BgoD1Te/ofFCaNZUnrVRTv7nU7IXLSPK3C/Bx4GeOY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IS5uEm9CKcCbQYo1zKQJrsG3LESemHP02lInoVzuLrBpHLkSwiS8ss6OvFugHQnW6nUkTRTVAXUyQxFq7Vf98CzT8+HChtiCOorvASh6hCcUeJhlEPgJ7P2D/mTR54Kpn6S7UqQPfJWauAjXuugRB/JoiGDSJkHzfmc/LeNlZCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HLwJWAUS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55063C32781;
	Wed,  5 Jun 2024 11:55:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717588523;
	bh=7BgoD1Te/ofFCaNZUnrVRTv7nU7IXLSPK3C/Bx4GeOY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HLwJWAUSQmhp1uJdANrOdRH3fkBoGE5AZYxbQ6oMcyyBNO6F2PYnG2ABLvR1+f7r6
	 tEjWi5W/opKREJsY+MytF33AgEd9HkdHkrVip+hVBFE2BOVhNDxZFXp+resCgAhMqy
	 1WWkeL+G+azZOBIVLpIo+D+yprZYrMskEcgggufhTj/DgoeI43CgdpVft/ITlORCUe
	 m05JETqO/Em47dERsRNpXFLOzlahfKhLOrBURaQE4g+vPmHQkRhIhuvUewThs637Vc
	 Hjj2nbRYF+RVo9jYvhdXwGHfd50gIOXZz5ectnlHM/RNefMnACJG+cv/rgl6djIW7m
	 WgG4Pal9adeUw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Mario Limonciello <mario.limonciello@amd.com>,
	Eric Heintzmann <heintzmann.eric@free.fr>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Sasha Levin <sashal@kernel.org>,
	linux-pci@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 3/4] PCI/PM: Avoid D3cold for HP Pavilion 17 PC/1972 PCIe Ports
Date: Wed,  5 Jun 2024 07:55:11 -0400
Message-ID: <20240605115518.2964670-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240605115518.2964670-1-sashal@kernel.org>
References: <20240605115518.2964670-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.19.315
Content-Transfer-Encoding: 8bit

From: Mario Limonciello <mario.limonciello@amd.com>

[ Upstream commit 256df20c590bf0e4d63ac69330cf23faddac3e08 ]

Hewlett-Packard HP Pavilion 17 Notebook PC/1972 is an Intel Ivy Bridge
system with a muxless AMD Radeon dGPU.  Attempting to use the dGPU fails
with the following sequence:

  ACPI Error: Aborting method \AMD3._ON due to previous error (AE_AML_LOOP_TIMEOUT) (20230628/psparse-529)
  radeon 0000:01:00.0: not ready 1023ms after resume; waiting
  radeon 0000:01:00.0: not ready 2047ms after resume; waiting
  radeon 0000:01:00.0: not ready 4095ms after resume; waiting
  radeon 0000:01:00.0: not ready 8191ms after resume; waiting
  radeon 0000:01:00.0: not ready 16383ms after resume; waiting
  radeon 0000:01:00.0: not ready 32767ms after resume; waiting
  radeon 0000:01:00.0: not ready 65535ms after resume; giving up
  radeon 0000:01:00.0: Unable to change power state from D3cold to D0, device inaccessible

The issue is that the Root Port the dGPU is connected to can't handle the
transition from D3cold to D0 so the dGPU can't properly exit runtime PM.

The existing logic in pci_bridge_d3_possible() checks for systems that are
newer than 2015 to decide that D3 is safe.  This would nominally work for
an Ivy Bridge system (which was discontinued in 2015), but this system
appears to have continued to receive BIOS updates until 2017 and so this
existing logic doesn't appropriately capture it.

Add the system to bridge_d3_blacklist to prevent D3cold from being used.

Link: https://lore.kernel.org/r/20240307163709.323-1-mario.limonciello@amd.com
Reported-by: Eric Heintzmann <heintzmann.eric@free.fr>
Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3229
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Tested-by: Eric Heintzmann <heintzmann.eric@free.fr>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/pci.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 2ac400adaee11..4f229cb5d2a9f 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -2530,6 +2530,18 @@ static const struct dmi_system_id bridge_d3_blacklist[] = {
 			DMI_MATCH(DMI_BOARD_VERSION, "Continental Z2"),
 		},
 	},
+	{
+		/*
+		 * Changing power state of root port dGPU is connected fails
+		 * https://gitlab.freedesktop.org/drm/amd/-/issues/3229
+		 */
+		.ident = "Hewlett-Packard HP Pavilion 17 Notebook PC/1972",
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "Hewlett-Packard"),
+			DMI_MATCH(DMI_BOARD_NAME, "1972"),
+			DMI_MATCH(DMI_BOARD_VERSION, "95.33"),
+		},
+	},
 #endif
 	{ }
 };
-- 
2.43.0


