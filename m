Return-Path: <linux-pci+bounces-29504-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 22DF2AD63DB
	for <lists+linux-pci@lfdr.de>; Thu, 12 Jun 2025 01:31:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EC8C67A5DAE
	for <lists+linux-pci@lfdr.de>; Wed, 11 Jun 2025 23:30:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01DC424503C;
	Wed, 11 Jun 2025 23:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZM4rTPBU"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D062923ABB7
	for <linux-pci@vger.kernel.org>; Wed, 11 Jun 2025 23:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749684684; cv=none; b=uA0KMMfBtJii+OazraQ4DP6QGb8RLVD8Lwtsd21AmFRWMfAJNvxWn84ItfnU2YrAs9+AedRYYOFd3wmJDvgUR8s/1snCpaUJZOq/shrnDSuSd60l+jHOxWZQ74tPQFa5bUBIZ85/wZvOYli+iO26SGvunZSF/NBmSc9/4umWy0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749684684; c=relaxed/simple;
	bh=moJ7A+Gs9j7N4diOKAMLmESYdOC9ZLaIWS82x7Na5Q8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AsP3Uha+wJHGSYpztszqkwuJbtNxrMrSMSWlV1+tmD6TYdbgPLRAR7HtVUxn1W2amjzY3DAxoiTOw03kRgKi4iljvM7H5a/TdHr0/yU5Hbq8y5SIUxlCiphjesr99T+8vYgD7t+JzjQIQS26j10nY0u9le4G7UWo+3BBbs1LBp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZM4rTPBU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95384C4CEE3;
	Wed, 11 Jun 2025 23:31:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749684682;
	bh=moJ7A+Gs9j7N4diOKAMLmESYdOC9ZLaIWS82x7Na5Q8=;
	h=From:To:Cc:Subject:Date:From;
	b=ZM4rTPBUbJilXZHlL6DD67bm9OQpewoVEoeqv39rg78pg4meihp+XKuW39iWpsY1G
	 V5usSkifPki1YJYivvLjgxHlKkGBBnDs7N7lhV+NMldAFcrYdEj9OZ+/gkkVHzaXdt
	 DDEw9ryhKkp06m8r6LDr9FLveyph0ye9mHgaUIS9Undljq1P4AlZ8XGCPV7jamzYv5
	 1/6+K/i2WOVt3kzdIZYGUbpWDZnqsaQLFBYDc7QrPvYzGxhMqD9jSVkhJgwmsABaT0
	 159KB4TwwMH4iGJPu/yxj7yMW3Byv1NTojtW0IcXEE+r+vyZoG2SQFndhjH6NJH1wi
	 BBGEkalSwyhCg==
From: Mario Limonciello <superm1@kernel.org>
To: mario.limonciello@amd.com,
	bhelgaas@google.com,
	rafael@kernel.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
	Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
	Nicolas Dichtel <nicolas.dichtel@6wind.com>,
	linux-pci@vger.kernel.org
Subject: [PATCH v2] PCI: Set up runtime PM on devices that don't support PCI PM
Date: Wed, 11 Jun 2025 18:31:16 -0500
Message-ID: <20250611233117.61810-1-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mario Limonciello <mario.limonciello@amd.com>

commit 4d4c10f763d7 ("PCI: Explicitly put devices into D0 when
initializing") intended to put PCI devices into D0, but in doing so
unintentionally changed runtime PM initialization not to occur on
devices that don't support PCI PM.  This caused a regression in vfio-pci
due to an imbalance with it's use.

Adjust the logic in pci_pm_init() so that even if PCI PM isn't supported
runtime PM is still initialized.

Cc: Alex Williamson <alex.williamson@redhat.com>
Reported-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Closes: https://lore.kernel.org/linux-pci/20250424043232.1848107-1-superm1@kernel.org/T/#m7e8929d6421690dc8bd6dc639d86c2b4db27cbc4
Reported-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Closes: https://lore.kernel.org/linux-pci/20250424043232.1848107-1-superm1@kernel.org/T/#m40d277dcdb9be64a1609a82412d1aa906263e201
Tested-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Fixes: 4d4c10f763d7 ("PCI: Explicitly put devices into D0 when initializing")
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v2:
 * remove pointless return
---
 drivers/pci/pci.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 3dd44d1ad829b..160a9a482c732 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -3222,14 +3222,14 @@ void pci_pm_init(struct pci_dev *dev)
 	/* find PCI PM capability in list */
 	pm = pci_find_capability(dev, PCI_CAP_ID_PM);
 	if (!pm)
-		return;
+		goto poweron;
 	/* Check device's ability to generate PME# */
 	pci_read_config_word(dev, pm + PCI_PM_PMC, &pmc);
 
 	if ((pmc & PCI_PM_CAP_VER_MASK) > 3) {
 		pci_err(dev, "unsupported PM cap regs version (%u)\n",
 			pmc & PCI_PM_CAP_VER_MASK);
-		return;
+		goto poweron;
 	}
 
 	dev->pm_cap = pm;
@@ -3274,6 +3274,7 @@ void pci_pm_init(struct pci_dev *dev)
 	pci_read_config_word(dev, PCI_STATUS, &status);
 	if (status & PCI_STATUS_IMM_READY)
 		dev->imm_ready = 1;
+poweron:
 	pci_pm_power_up_and_verify_state(dev);
 	pm_runtime_forbid(&dev->dev);
 	pm_runtime_set_active(&dev->dev);
-- 
2.43.0


