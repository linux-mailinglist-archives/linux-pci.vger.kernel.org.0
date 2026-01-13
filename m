Return-Path: <linux-pci+bounces-44673-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 183B9D1B4FE
	for <lists+linux-pci@lfdr.de>; Tue, 13 Jan 2026 21:56:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 07C013005033
	for <lists+linux-pci@lfdr.de>; Tue, 13 Jan 2026 20:56:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7859B31AF07;
	Tue, 13 Jan 2026 20:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sYeU8l2U"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 560BE2FB0B3
	for <linux-pci@vger.kernel.org>; Tue, 13 Jan 2026 20:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768337797; cv=none; b=flYzPCG/JNtzAQ8yEjYsDV6Mxgm2c7wwl6xvDzKRfYiFkKOWJlgURvDtZMDwVDZZPrJLMveF8CyGx5kqW6mELlWAjt24r2fW1Yr+VbrRHKNiUpTBXA+6x/bx/GY8X/WYRtYiVU0M6eXj1J4koihC86sAaokuEUl/nX3UBO0CYJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768337797; c=relaxed/simple;
	bh=6F1sbeBCv9M/5fBXdF77n0o81yPx6RY/G2UhjOp3cO4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PySVLyKAbX64yKDObhwrOIHBNcGPzdD4u4zXRAfGUbJ6zX5W+hyTv0dgQgzCTNnh4tnpmSrHQ/FuQXTC/mGR32/IzFIId3p6+b3x+d6WnbSC41qce3V+XGHbVN9NaZ2DTIn16p9TR8vAkSBw5+NjC9TVqnQplf5PEEBLxzb3Voc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sYeU8l2U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 319FFC19422;
	Tue, 13 Jan 2026 20:56:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768337796;
	bh=6F1sbeBCv9M/5fBXdF77n0o81yPx6RY/G2UhjOp3cO4=;
	h=From:To:Cc:Subject:Date:From;
	b=sYeU8l2UyEqbIgoGSg0lltXJ6CA/A1BC9cX6ZsHlkezYjkpi55UVjuLUEJfEcKn5H
	 GcYPpR58pxfNnxc3B6xqlwIw3g5OCea7bN5TXAIkSSNaJH3TlG72/MakF8NxVW1mLD
	 mett0kWwVvzwUmCJywyLdl1oNa/XVFKqI9Kb44J7gtZwBPrFkDYJVltNKAVh/+u9NI
	 nsOoKBzLMB0Tbc6oITn/lU1K8tKKaqQR5qvNWJUYueXuvLiwesXzvUaBKwrcPEXzp6
	 guSgcr8SNAtevmMWkI6fCOukKfJAE4MLN3QGDUJQa244l13Cx511Whcykk0yWgubMn
	 2d55jqiUYXqHw==
From: "Mario Limonciello (AMD)" <superm1@kernel.org>
To: mario.limonciello@amd.com,
	bhelgaas@google.com,
	rafael@kernel.org
Cc: "Mario Limonciello (AMD)" <superm1@kernel.org>,
	kengyu@lexical.tw,
	Matthew Ruffell <matthew.ruffell@canonical.com>,
	linux-pci@vger.kernel.org
Subject: [PATCH] PCI: Enable Bus Master in pci_power_up()
Date: Tue, 13 Jan 2026 14:56:14 -0600
Message-ID: <20260113205626.127337-1-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit 4d4c10f763d78 ("PCI: Explicitly put devices into D0 when
initializing") addressed the issue of devices not being explicitly
initialized to D0 during system startup, resolving mismatches between
firmware and OS states.

However, this change affected devices lacking runtime PM, as noted in
commit 907a7a2e5bf40 ("PCI/PM: Set up runtime PM even for devices without
PCI PM").

Matthew however reports that there is additional problems specifically on
AWS NVME hardware that can't handle a kexec since these changes were
introduced.

During a kexec reboot ever since commit 4fc9bbf98fd66 ("PCI: Disable Bus
Master only on kexec reboot") bus mastering will be turned off, and this
is a different flow than is observed for shutdown/reboot.  The problem
appears to be that because the device is actually in D0 during the
startup routine, clearing bus mastering as part of pci_device_shutdown()
leads to a mismatch during the next kernel boot.

I'd hypothesize that the firmware on this platform normally sets bus
mastering as part of startup and the difference in kexec behavior lead to
an incongruity.

Set bus mastering when the device powers up to fix the mismatch.

Cc: kengyu@lexical.tw
Reported-by: Matthew Ruffell <matthew.ruffell@canonical.com>
Closes: https://lore.kernel.org/linux-pci/CAKAwkKvmdKxRRA4cR=jJEdyadon6uKXe+aFXaGSe=PNSgwDf9g@mail.gmail.com/
Fixes: 4d4c10f763d78 ("PCI: Explicitly put devices into D0 when initializing")
Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
---
NOTE:
This could also be addressed by disabling the clearing of bus mastering across
a kexec reboot if that is preferred.
---
 drivers/pci/pci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 13dbb405dc31f..c0c0b5c9bf838 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1323,6 +1323,7 @@ int pci_power_up(struct pci_dev *dev)
 		return -EIO;
 	}
 
+	pci_set_master(dev);
 	pci_read_config_word(dev, dev->pm_cap + PCI_PM_CTRL, &pmcsr);
 	if (PCI_POSSIBLE_ERROR(pmcsr)) {
 		pci_err(dev, "Unable to change power state from %s to D0, device inaccessible\n",
-- 
2.43.0


