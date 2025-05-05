Return-Path: <linux-pci+bounces-27230-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C7B0AAAC06
	for <lists+linux-pci@lfdr.de>; Tue,  6 May 2025 04:07:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08EAF17C937
	for <lists+linux-pci@lfdr.de>; Tue,  6 May 2025 02:06:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1642A3BE7DA;
	Mon,  5 May 2025 23:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IJDLMfGv"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E22022ECE3A;
	Mon,  5 May 2025 23:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746486641; cv=none; b=RRbqGyu13LqJfdU0p0s05ej/ni+CVoKSFaze3WM7dx31Rfx/Fsu0f59o53mnNo+Yx3gzCbrXX21Pu/6lT/XxS0zJb6pl6ubQpHupdsJrBOiyR6wP98v37xod3dT6C0IPQi7Tbl5hmx+mi6ncc3xqnMGKlunjSGaN7LsQrX1U0Wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746486641; c=relaxed/simple;
	bh=Pzoi8OuRys6DQCLBi29pGjyIgS/8lJ6+LuHaGC91nHY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aWdf5eK16E+WVvVk2opysHXtBbueYDPfM1fwm6JHciYKeyqVlOhrXTYYYhLqubPMjj34SNNV4DavCBqxa5jDQxhyFA/UrLQ6WAbfBRnYC7y9o+HyA7J4FtPE4ioi2BGip5qBYe/Bcy+NFFDMzybdfTb8Sf4tvY6mxAXJsBIVBfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IJDLMfGv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1ED08C4CEF2;
	Mon,  5 May 2025 23:10:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746486639;
	bh=Pzoi8OuRys6DQCLBi29pGjyIgS/8lJ6+LuHaGC91nHY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IJDLMfGvUeb/doBBlmZTPb3tFdf+ewlwiVXDKYKPzqyB04sFTMKnG0g3/zuHdN0uu
	 KjAMzOO4YTMXgXXWlmoYp+h/8IC+cbXDsxYB6hzi5vFMYtrY3bFpiEkwRBC0iXlS/O
	 0+EXzpyB9rB1tLMrRdMENd3sAGh4uXRNVZ8X3AIVsXwIvjoRUjgWW/H5D9yGRcSJMr
	 2qs/V4sH/3+ePYDhZWeZLF0t51vKxcoEWSoD/kYdq0vStRxOCW2jYk11aS6WkCz8Jq
	 1pmwCyC/tSdBoQ1tIvXmc3masXzyWlGm1Z7qc5fGFZNbS3b91DDNKGYByuoWGu6Zmb
	 k1SWia1pb3ZMA==
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
Subject: [PATCH AUTOSEL 6.1 130/212] x86/kaslr: Reduce KASLR entropy on most x86 systems
Date: Mon,  5 May 2025 19:05:02 -0400
Message-Id: <20250505230624.2692522-130-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505230624.2692522-1-sashal@kernel.org>
References: <20250505230624.2692522-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.136
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
index 230f1dee4f095..e0b0ec0f82457 100644
--- a/arch/x86/mm/kaslr.c
+++ b/arch/x86/mm/kaslr.c
@@ -109,8 +109,14 @@ void __init kernel_randomize_memory(void)
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
index 55c028af4bd94..c4f9ac5c00c12 100644
--- a/drivers/pci/Kconfig
+++ b/drivers/pci/Kconfig
@@ -184,6 +184,12 @@ config PCI_P2PDMA
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


