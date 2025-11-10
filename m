Return-Path: <linux-pci+bounces-40792-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 544ACC4995C
	for <lists+linux-pci@lfdr.de>; Mon, 10 Nov 2025 23:33:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2EF8B3AF766
	for <lists+linux-pci@lfdr.de>; Mon, 10 Nov 2025 22:31:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6539B3431FA;
	Mon, 10 Nov 2025 22:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rmwSZj/R"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3837A3431E6;
	Mon, 10 Nov 2025 22:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762813793; cv=none; b=lagb2bkWdecUOlzWNyQf6Y7rBxj0SffEqp0gxRF2KV7PSAjgPtmbV0UW6jT+cSeZnIL4wp92iUsf/p485JcsSe1HQqOPumytzTfXro9ExWV1no0dS3IAiDrFKy6ppxwl2mAvvcTq/H0V4M7JgHKUx+mZCde2N8XLUu5/q07RmF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762813793; c=relaxed/simple;
	bh=psqvw1U6/SBJm+8SC9eq36+YROk3NZIjyrzaiC/0Ys0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ehS4DiQiHD2gqTnhrE/A/sA+hTU2AwLDn4qqIXpC92c+UAL0TTfXKW3JqTF8fpBNTd0lzW62x//afYvJAKKDbAIVp5Tzm7/kpBIKm14I9FL+YhTIUGLPhI7sXfZGLyG/Erq4ruaKOc65EqffDFqfrCeFWjhb1b4IDjbNKdxFMV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rmwSZj/R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98D44C19423;
	Mon, 10 Nov 2025 22:29:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762813792;
	bh=psqvw1U6/SBJm+8SC9eq36+YROk3NZIjyrzaiC/0Ys0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rmwSZj/Rzf9cPQBKu+Fe1z4KaQXQxyTON//wGOlmmhHpzxrYpozRO3vbbIppWtMCj
	 gWOy+RTwukP3QWrVKfR7FARDJppBvELnHxBg85I8TqFqPq7eEhaXWGtdMOwIQNdYQX
	 fr0IuMxKP37DvWYFQ826uoe2IMag5HpP/FPxjxwNKXreN14pJ6yIxtDtVWJIkkHHnW
	 uNE4EhGfEsYZWuMz3WuK3VfgwsPttdYdzzyLBSxsWJ3c69R6P5Gp7jN5F13ls10HVx
	 tC1xyAXUjkxxI7QGikQsZoQVt+XfqcEkQuKCJseFBmwqNZtg0+scUe1qN+HnF1rIhD
	 ztVLNbx+Bwlfw==
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org
Cc: Christian Zigotzky <chzigotzky@xenosoft.de>,
	Manivannan Sadhasivam <mani@kernel.org>,
	mad skateman <madskateman@gmail.com>,
	"R . T . Dickinson" <rtd2@xtra.co.nz>,
	Darren Stevens <darren@stevens-zone.net>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Lukas Wunner <lukas@wunner.de>,
	luigi burdo <intermediadc@hotmail.com>,
	Al <al@datazap.net>,
	Roland <rol7and@gmx.com>,
	Hongxing Zhu <hongxing.zhu@nxp.com>,
	hypexed@yahoo.com.au,
	linuxppc-dev@lists.ozlabs.org,
	debian-powerpc@lists.debian.org,
	linux-kernel@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v2 4/4] PCI/ASPM: Avoid L0s and L1 on Freescale Root Ports
Date: Mon, 10 Nov 2025 16:22:28 -0600
Message-ID: <20251110222929.2140564-5-helgaas@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251110222929.2140564-1-helgaas@kernel.org>
References: <20251110222929.2140564-1-helgaas@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bjorn Helgaas <bhelgaas@google.com>

Christian reported that f3ac2ff14834 ("PCI/ASPM: Enable all ClockPM and
ASPM states for devicetree platforms") broke booting on the A-EON X5000.

Override the L0s and L1 Support advertised in Link Capabilities by the
X5000 Root Ports ([1957:0451]) so we don't try to enable those states.

Fixes: f3ac2ff14834 ("PCI/ASPM: Enable all ClockPM and ASPM states for devicetree platforms")
Fixes: df5192d9bb0e ("PCI/ASPM: Enable only L0s and L1 for devicetree platforms")
Reported-by: Christian Zigotzky <chzigotzky@xenosoft.de>
Link: https://lore.kernel.org/r/db5c95a1-cf3e-46f9-8045-a1b04908051a@xenosoft.de
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/quirks.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 922c77c627a1..b94264cd3833 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -2523,6 +2523,7 @@ static void quirk_disable_aspm_l0s_l1(struct pci_dev *dev)
  * disable both L0s and L1 for now to be safe.
  */
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ASMEDIA, 0x1080, quirk_disable_aspm_l0s_l1);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_FREESCALE, 0x0451, quirk_disable_aspm_l0s_l1);
 
 /*
  * Some Pericom PCIe-to-PCI bridges in reverse mode need the PCIe Retrain
-- 
2.43.0


