Return-Path: <linux-pci+bounces-8322-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BC1638FCC28
	for <lists+linux-pci@lfdr.de>; Wed,  5 Jun 2024 14:14:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE7FD1C203B5
	for <lists+linux-pci@lfdr.de>; Wed,  5 Jun 2024 12:14:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD076197A75;
	Wed,  5 Jun 2024 11:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XTyIDU2i"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94ED2197A6E;
	Wed,  5 Jun 2024 11:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717588464; cv=none; b=qtzjYD3gLNA9PGTwVO/rKOmtV3eaawOpKBj7Z6vOsOOoz3q+3eajt56lBPFAmNyQ15DaPvhU8uqb3SzCkzrC/re9r/dmOb+AmIOxfyqMRpWAIpihtkQVcsIqCmP7cPC1QbLN0aE90rjAhb98Rq2r2yDtwxUshzfczVhWMNvrvFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717588464; c=relaxed/simple;
	bh=tFWbbzDKU0f0XeHhNfACXerJYRh7P8oDGFiSiIz9rFU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C4/aYHqypP04cEpUjVHc3QptL5O822qp1Ilc7Y2cUGwpX4csyJ4QB0sMvaowENMDTx2TxvqFRNrt0lN34RnothfhW99ohm5s0PJ3wO52KczB5ffp/XWZbDQmwpnftgJfmoN6k0On2yFgjMO0Q8L0oOT8XcSL4EjWpYa8/T1uXXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XTyIDU2i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4F07C3277B;
	Wed,  5 Jun 2024 11:54:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717588464;
	bh=tFWbbzDKU0f0XeHhNfACXerJYRh7P8oDGFiSiIz9rFU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XTyIDU2ijVWN+ERYLvF3GYwbqx5Shwi6D+UTWsm9Tc2YFkZHx+sKlSLIqDRKfohOo
	 +LJPFxMhX+/OY1ZiYkAPmqCEq2ziq7lArjv9olwE2CeeZ+otU28uch4MomVp7isTMd
	 a+QkG0OEd2N36eP+H8oUx88rqrDMLuwZ7taPq+kkAjpoCfGNW+n/dEVGC6xpPLcC6A
	 1R4/geAIYeKso8FzQN+M4nbzP9wA68ElVmJ8BfennKQD0kbrZFD4O9HKhSIPI5n8B0
	 3t84uo3AdLL81jLe1wCSUPJ/aHzU+6/pBhIhaKo2IzbEfcwuA7gDp+K3nKTvSpfa3H
	 tL5g8DUnO2FcQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Mario Limonciello <mario.limonciello@amd.com>,
	Eric Heintzmann <heintzmann.eric@free.fr>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Sasha Levin <sashal@kernel.org>,
	linux-pci@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 5/9] PCI/PM: Avoid D3cold for HP Pavilion 17 PC/1972 PCIe Ports
Date: Wed,  5 Jun 2024 07:54:03 -0400
Message-ID: <20240605115415.2964165-5-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240605115415.2964165-1-sashal@kernel.org>
References: <20240605115415.2964165-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.160
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
index 36f1e604191e5..67216f4ea2151 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -2901,6 +2901,18 @@ static const struct dmi_system_id bridge_d3_blacklist[] = {
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


