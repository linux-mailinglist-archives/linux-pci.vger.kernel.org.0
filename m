Return-Path: <linux-pci+bounces-43970-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 76E86CF0F38
	for <lists+linux-pci@lfdr.de>; Sun, 04 Jan 2026 13:51:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 47D90300FE23
	for <lists+linux-pci@lfdr.de>; Sun,  4 Jan 2026 12:51:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7B192C1585;
	Sun,  4 Jan 2026 12:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KpSU+cgZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73945283FD9;
	Sun,  4 Jan 2026 12:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767531101; cv=none; b=rWyf+29bPrd28Qzm+Wg2q/ye6h6hOMTlct0MeOigTRI546IdnLO3HmDfqvcEMEzIGHzhBZPI7xBfNxfG6JbVoKV1K18YMsdxjPOPIZy++AjG+M4JLU5LAd2B6pHz+QYRJHrC5vRtVoyFVDFlCR2WRt7cQ8M8w/ukv1RU8JP8vWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767531101; c=relaxed/simple;
	bh=SMVM6faXQA9IInezI/KP+IAH3tEDFTmoI5LTU9C412g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GaAiNWNx7CK2nCJVUg+lxg/NLhMhxMNSNhFZ7k8X6Qw/zEvkCLa/qyRK//Nk5IRJhKPph/AVuWBU/dIZb5dhmHjjTGLyFju6jiXbZ3K0/EoQqOD1ITSWTqncAu00JL3n249wHlO84wCFZvBaRi0UQ9Uq2yAoqOLX1AFn9Sf+jkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KpSU+cgZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54F54C4CEF7;
	Sun,  4 Jan 2026 12:51:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767531100;
	bh=SMVM6faXQA9IInezI/KP+IAH3tEDFTmoI5LTU9C412g=;
	h=From:To:Cc:Subject:Date:From;
	b=KpSU+cgZwvo27FofIIXrgIgfcUPC4sGcusXeeNU66rQNTwLZnczQ1HCwoI15T9ZvJ
	 XAsp54uByKIgrUXRC1dak31Gm0FwFs1WQi+pIoEZ0VVoFUvnkhfLpq7JPo4nMoMQT7
	 uCeAjgChAbb+wF2b7DrwLEnL2P1z28BPS8i7Dn1oNmCpI1LzpkJXK/hYIXwUBaWBge
	 kNFUeoGWUmvaknc7P1EdiOGKSQuJuFgC3N4NN7408yiiKAlB/h3rkEy3pyWRV6k5uh
	 ls2sBTbjDkpEgHCAn7LOreTd7rLoakQl5nB2hIthbm8ps5so1MngpgtwieLoAiKPhg
	 Li4qN+oMTm3KQ==
From: Leon Romanovsky <leon@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Alex Williamson <alex@shazbot.org>,
	Ankit Agrawal <ankita@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bjorn Helgaas <helgaas@kernel.org>
Subject: [PATCH] PCI/P2PDMA: Add missing struct p2pdma_provider documentation
Date: Sun,  4 Jan 2026 14:51:28 +0200
Message-ID: <20260104-fix-p2p-kdoc-v1-1-6d181233f8bc@nvidia.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Change-ID: 20260104-fix-p2p-kdoc-3f503e6d6a55
X-Mailer: b4 0.15-dev-a6db3
Content-Transfer-Encoding: 8bit

From: Leon Romanovsky <leonro@nvidia.com>

Two fields in struct p2pdma_provider were not documented, which resulted
in the following kernel-doc warning:

  Warning: include/linux/pci-p2pdma.h:26 struct member 'owner' not described in 'p2pdma_provider'
  Warning: include/linux/pci-p2pdma.h:26 struct member 'bus_offset' not described in 'p2pdma_provider'

Repro:

  $ scripts/kernel-doc -none include/linux/pci-p2pdma.h

Fixes: f58ef9d1d135 ("PCI/P2PDMA: Separate the mmap() support from the core logic")
Reported-by: Bjorn Helgaas <helgaas@kernel.org>
Closes: https://lore.kernel.org/all/20260102234033.GA246107@bhelgaas
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 include/linux/pci-p2pdma.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/pci-p2pdma.h b/include/linux/pci-p2pdma.h
index 517e121d2598..873de20a2247 100644
--- a/include/linux/pci-p2pdma.h
+++ b/include/linux/pci-p2pdma.h
@@ -20,6 +20,8 @@ struct scatterlist;
  * struct p2pdma_provider
  *
  * A p2pdma provider is a range of MMIO address space available to the CPU.
+ * @owner: Device to which this provider belongs.
+ * @bus_offset: Bus offset for p2p communication.
  */
 struct p2pdma_provider {
 	struct device *owner;

---
base-commit: f8f9c1f4d0c7a64600e2ca312dec824a0bc2f1da
change-id: 20260104-fix-p2p-kdoc-3f503e6d6a55

Best regards,
--  
Leon Romanovsky <leonro@nvidia.com>


