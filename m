Return-Path: <linux-pci+bounces-8321-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 668208FCC02
	for <lists+linux-pci@lfdr.de>; Wed,  5 Jun 2024 14:11:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F216E1F23F93
	for <lists+linux-pci@lfdr.de>; Wed,  5 Jun 2024 12:11:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA7991B0C03;
	Wed,  5 Jun 2024 11:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="btUFbAXU"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A29CA1B0BFD;
	Wed,  5 Jun 2024 11:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717588424; cv=none; b=HMW/0cKcpcTH36XIBwvHWpx6vsoHH0Ul/Ngwo+3kiH+Xq3As9F8ZZK3TjC5wDaFl/G2uU/uh5jepzdOVZtTLHsb34ZqZ3uX0capIzbQ6HhVYGFNVffzWQ0MkM24WaMft70xMtN3UyrybB8Syzg+ZLRStgnG+J04vQTuJVTf78Q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717588424; c=relaxed/simple;
	bh=vhDDdQ4mkVBhBoXaS6zbaZs73Z/ikEhUNXe5gkRdvvQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SSlM8IRDNFVig/UwhAf5vCAjJANMe8qkTg307hyvyBRdcD0pdHfLJunCuIwOB8W3ZAKBKd3gLM3WiL4AmRxwYg5ucRzSPDEff86M/o0zQyHOoE68YFepN2rcGWI/2c3Zqd8TOy4J/poQXGy6gShEZH6tsfjTUN8bCgYJAQGiUBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=btUFbAXU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64FEFC32781;
	Wed,  5 Jun 2024 11:53:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717588424;
	bh=vhDDdQ4mkVBhBoXaS6zbaZs73Z/ikEhUNXe5gkRdvvQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=btUFbAXU7+HByjD3DPGhghtehVcK2Fq/8myTKLpWloQvB9kbMYySQBPwgWvrhe45Q
	 NBNLtLxr/7U0SKq1j/WhLDFsNP0SX4o/u4uQGU0wm9z9YA2UjUF8sVP6OiV5WUdHWK
	 0HPDJuqepXt5LiGa8dqcepZiQaxlhqH4i57cU61hWyiMvxGvci3oqmqKPVtLzJ9LLR
	 BekITGAP1g+pvY0+cnD/uTz3hgZdZpLYff/NfYLALoLPsjLeE94tIGfTsozw9p6pdf
	 GlZKciQBSVX9f7VY5iuynpdIUz3hiWgAwFKuRVKF/2NqNGFXuo8y8EOQ/jWBhnuoua
	 chFaR3OTs6SwA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Mario Limonciello <mario.limonciello@amd.com>,
	Eric Heintzmann <heintzmann.eric@free.fr>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Sasha Levin <sashal@kernel.org>,
	linux-pci@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 06/12] PCI/PM: Avoid D3cold for HP Pavilion 17 PC/1972 PCIe Ports
Date: Wed,  5 Jun 2024 07:53:11 -0400
Message-ID: <20240605115334.2963803-6-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240605115334.2963803-1-sashal@kernel.org>
References: <20240605115334.2963803-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.92
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
index 67956bfebf879..0399204941dbe 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -2991,6 +2991,18 @@ static const struct dmi_system_id bridge_d3_blacklist[] = {
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


