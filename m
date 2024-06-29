Return-Path: <linux-pci+bounces-9428-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6934691C9BF
	for <lists+linux-pci@lfdr.de>; Sat, 29 Jun 2024 02:17:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A21E1C220CC
	for <lists+linux-pci@lfdr.de>; Sat, 29 Jun 2024 00:17:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53B6763C;
	Sat, 29 Jun 2024 00:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VapOddPd"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2817D36D;
	Sat, 29 Jun 2024 00:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719620270; cv=none; b=sf9sR99abLhF5UClIn1zLYKzBQDyzHkdKgUg6ZaXFONiYbu1CdTR2BaLxZxQ8jVz7RoBG9Uuqe3ge81HMaC39fWt5UtvHzA9shZx7FShwm/5wHBYnscY4lPPDu6q4+WQOPs4j7f4VeiO5TZHOI0QdPr5myOhx8KsP/4d0KYX26A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719620270; c=relaxed/simple;
	bh=E9ytvBNNpOzkV+9AHmeeZHisJk7Eu6Bv2AJblo/vDmI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=r2HOrBcc1GFZov2qR4nvMOhRtUf5pUcYgYXDbR3j7TPuAX0IE7wxI3TDvzbLz/yIA+5Cum96TTrsnXZW5Tp2u2569YTAuUGA0KuXEXxUZC7AGe/ppr8AXXq1/+HvKpDgkWIz3yA38wy2FzSsERrYHCgBd+cZXQGwJXY5WrCy0H4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VapOddPd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19037C116B1;
	Sat, 29 Jun 2024 00:17:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719620269;
	bh=E9ytvBNNpOzkV+9AHmeeZHisJk7Eu6Bv2AJblo/vDmI=;
	h=From:To:Cc:Subject:Date:From;
	b=VapOddPd5d9WkifpuTsA6Gq6J+wjBd2KuIfjitCOkzafnvn0sFtpAd/MTLM6ZRO98
	 JyfvhQQv6eFIADeNX3lN3ZRFQI4WAKsP7pzEfD7B/2ACl1dVT3CvshVEEf67SSfjI4
	 lUZJOMPdo5kj7c5EGgGDKiYS5ZSy2RFjIXG/INbzPiAmH/BrO8ll0Nk7WliEvlRZdG
	 TeDt/TOF4psalvicycCMv8Jox5b95W9TqvtlCUWqb6Of58AcX0e2ynaJa0EQ4zGe6f
	 XYsXmB8q1tH0QKDOCG336pqZ1tzKoNhyE+Fxxil8JuB93ZJtPGZxOUz89eUBHq0zuB
	 csDn+3cGJeT1A==
From: superm1@kernel.org
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org (open list:PCI SUBSYSTEM),
	linux-kernel@vger.kernel.org (open list),
	Mario Limonciello <mario.limonciello@amd.com>,
	Tony Murray <murraytony@gmail.com>
Subject: [PATCH] PCI/PM: Avoid D3cold for HP Spectre x360 Convertible 15-ch0xx PCIe Ports
Date: Fri, 28 Jun 2024 19:17:43 -0500
Message-ID: <20240629001743.1573581-1-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mario Limonciello <mario.limonciello@amd.com>

HP Spectre x360 Convertible 15-ch0xx is an Intel Kaby Lake-G system that
contains an AMD Polaris Radeon dGPU.
Attempting to use the dGPU fails with the following sequence:

  amdgpu 0000:01:00.0: not ready 1023ms after resume; waiting
  amdgpu 0000:01:00.0: not ready 2047ms after resume; waiting
  amdgpu 0000:01:00.0: not ready 4095ms after resume; waiting
  amdgpu 0000:01:00.0: not ready 8191ms after resume; waiting
  amdgpu 0000:01:00.0: not ready 16383ms after resume; waiting
  amdgpu 0000:01:00.0: not ready 32767ms after resume; waiting
  amdgpu 0000:01:00.0: not ready 65535ms after resume; giving up
  amdgpu 0000:01:00.0: Unable to change power state from D3cold to D0, device inaccessible
  [drm:atom_op_jump [amdgpu]] *ERROR* atombios stuck in loop for more than 20secs aborting

The issue is that the Root Port the dGPU is connected to can't handle the
transition from D3cold to D0 so the dGPU can't properly exit runtime PM.

The existing logic in pci_bridge_d3_possible() checks for systems that are
newer than 2015 to decide that D3 is safe, but this system appears not to
work properly.

Add the system to bridge_d3_blacklist to prevent D3cold from being used.

Reported-and-tested-by: Tony Murray <murraytony@gmail.com>
Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3389
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/pci/pci.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 35fb1f17a589..65e3a550052f 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -2965,6 +2965,17 @@ static const struct dmi_system_id bridge_d3_blacklist[] = {
 			DMI_MATCH(DMI_BOARD_VERSION, "95.33"),
 		},
 	},
+	{
+		/*
+		 * Changing power state of root port dGPU is connected fails
+		 * https://gitlab.freedesktop.org/drm/amd/-/issues/3229
+		 */
+		.ident = "HP Spectre x360 Convertible 15-ch0xx",
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "HP"),
+			DMI_MATCH(DMI_BOARD_NAME, "83BB"),
+		},
+	},
 #endif
 	{ }
 };
-- 
2.43.0


