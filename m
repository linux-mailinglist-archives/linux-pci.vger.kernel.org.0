Return-Path: <linux-pci+bounces-27209-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5D20AAA4EE
	for <lists+linux-pci@lfdr.de>; Tue,  6 May 2025 01:38:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECE344667CA
	for <lists+linux-pci@lfdr.de>; Mon,  5 May 2025 23:38:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7CC0308A47;
	Mon,  5 May 2025 22:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kwC9zo1c"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE8E8308A43;
	Mon,  5 May 2025 22:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746484097; cv=none; b=AibiBH+lNxF5Q5dmjiejHbPPsr5BADPvWCKdGNtadpU8PbAYX5SyGQnSr9yKWbutQ8De281RKBvPcnAcNREs8z4RDQbUY3hKcPBIQJQIQn+uog5wzXVmlZQSyNcphdfp238D/QXLFz2Khx7ARo7mibFf+pk6YFBXtONGBKDv3/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746484097; c=relaxed/simple;
	bh=LbwNQPmH3YH8ppLkj8a417vU4e/o88n1EcnIiZIhXvA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qeC3PJ6fCdSof1hcqnpulD0GR2lmn/DIvjY8IfHZDX8LoP8v9sl1dq3wccz4l/2G1uy8Vwh7t87FmBuNZRIYViqsZmwXCtG5afh7tWCjFBL7GV3KTgmwH+45fkrvTzaCgOJOyvnenYEmGX2q7osZxGEJFefFRmHCbcrOkfVr1kY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kwC9zo1c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E390CC4CEED;
	Mon,  5 May 2025 22:28:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746484097;
	bh=LbwNQPmH3YH8ppLkj8a417vU4e/o88n1EcnIiZIhXvA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kwC9zo1cJji1dzau94LWeUEFa1hRnGyW1C4PP0q30lm6YKf9vyaHt9rdxBEcKt3xV
	 KoNCVPrxMR1VmgzO9odIxPm6ATQKqQzVcWNUwSmWZQxE/ON5P/jn99iSEsAX26Ng5L
	 DEapaoJjE2CR3eewY22rH0kM5wzUJCd7hpDNOshF1blc0KXsMq+oEUn743VrOfdumA
	 BTMU4wU8JOEYSVHKKkz4aSiRLLr34NWVvu6PfsjZEw9j91fzPSebmYZRwGgmgEqOgW
	 Iw9CrzSYMZrpYnyd9UGx67ZjSYGhhdPs+9M+FK6p++sR/GbjALKwkkfeh4Xo4K0BQf
	 1l38Ld795GxIw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Balbir Singh <balbirs@nvidia.com>,
	Ingo Molnar <mingo@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Andy Lutomirski <luto@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	dave.hansen@linux.intel.com,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	x86@kernel.org,
	linux-pci@vger.kernel.org
Subject: [PATCH AUTOSEL 6.14 348/642] x86/kaslr: Reduce KASLR entropy on most x86 systems
Date: Mon,  5 May 2025 18:09:24 -0400
Message-Id: <20250505221419.2672473-348-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
Content-Transfer-Encoding: 8bit

From: Balbir Singh <balbirs@nvidia.com>

[ Upstream commit 7ffb791423c7c518269a9aad35039ef824a40adb ]

When CONFIG_PCI_P2PDMA=y (which is basically enabled on all
large x86 distros), it maps the PFN's via a ZONE_DEVICE
mapping using devm_memremap_pages(). The mapped virtual
address range corresponds to the pci_resource_start()
of the BAR address and size corresponding to the BAR length.

When KASLR is enabled, the direct map range of the kernel is
reduced to the size of physical memory plus additional padding.
If the BAR address is beyond this limit, PCI peer to peer DMA
mappings fail.

Fix this by not shrinking the size of the direct map when
CONFIG_PCI_P2PDMA=y.

This reduces the total available entropy, but it's better than
the current work around of having to disable KASLR completely.

[ mingo: Clarified the changelog to point out the broad impact ... ]

Signed-off-by: Balbir Singh <balbirs@nvidia.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Kees Cook <kees@kernel.org>
Acked-by: Bjorn Helgaas <bhelgaas@google.com> # drivers/pci/Kconfig
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Andy Lutomirski <luto@kernel.org>
Link: https://lore.kernel.org/lkml/20250206023201.1481957-1-balbirs@nvidia.com/
Link: https://lore.kernel.org/r/20250206234234.1912585-1-balbirs@nvidia.com
--
 arch/x86/mm/kaslr.c | 10 ++++++++--
 drivers/pci/Kconfig |  6 ++++++
 2 files changed, 14 insertions(+), 2 deletions(-)
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/mm/kaslr.c | 10 ++++++++--
 drivers/pci/Kconfig |  6 ++++++
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/arch/x86/mm/kaslr.c b/arch/x86/mm/kaslr.c
index 11a93542d1983..3c306de52fd4d 100644
--- a/arch/x86/mm/kaslr.c
+++ b/arch/x86/mm/kaslr.c
@@ -113,8 +113,14 @@ void __init kernel_randomize_memory(void)
 	memory_tb = DIV_ROUND_UP(max_pfn << PAGE_SHIFT, 1UL << TB_SHIFT) +
 		CONFIG_RANDOMIZE_MEMORY_PHYSICAL_PADDING;
 
-	/* Adapt physical memory region size based on available memory */
-	if (memory_tb < kaslr_regions[0].size_tb)
+	/*
+	 * Adapt physical memory region size based on available memory,
+	 * except when CONFIG_PCI_P2PDMA is enabled. P2PDMA exposes the
+	 * device BAR space assuming the direct map space is large enough
+	 * for creating a ZONE_DEVICE mapping in the direct map corresponding
+	 * to the physical BAR address.
+	 */
+	if (!IS_ENABLED(CONFIG_PCI_P2PDMA) && (memory_tb < kaslr_regions[0].size_tb))
 		kaslr_regions[0].size_tb = memory_tb;
 
 	/*
diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
index 2fbd379923fd1..5c3054aaec8c1 100644
--- a/drivers/pci/Kconfig
+++ b/drivers/pci/Kconfig
@@ -203,6 +203,12 @@ config PCI_P2PDMA
 	  P2P DMA transactions must be between devices behind the same root
 	  port.
 
+	  Enabling this option will reduce the entropy of x86 KASLR memory
+	  regions. For example - on a 46 bit system, the entropy goes down
+	  from 16 bits to 15 bits. The actual reduction in entropy depends
+	  on the physical address bits, on processor features, kernel config
+	  (5 level page table) and physical memory present on the system.
+
 	  If unsure, say N.
 
 config PCI_LABEL
-- 
2.39.5


