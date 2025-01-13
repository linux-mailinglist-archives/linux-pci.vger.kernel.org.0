Return-Path: <linux-pci+bounces-19697-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EAC1A0C576
	for <lists+linux-pci@lfdr.de>; Tue, 14 Jan 2025 00:16:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74ECB1886C40
	for <lists+linux-pci@lfdr.de>; Mon, 13 Jan 2025 23:16:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5C0B1FAC33;
	Mon, 13 Jan 2025 23:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cD1EB+uS"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 899531FA827;
	Mon, 13 Jan 2025 23:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736810169; cv=none; b=cTmp7uuvx1D/d8x/g88oa173JKHp1Wj40UG02E/HcTd1chetDK39G2ZvTUmXZSTNKCNWAS5C0z7wYNkBFyzKrILx4fKEtdxcg3KwU1xxtw4+ASWtxVeZHz2/rCQ6ee6htXn5UCKe4J2YX0tUe9CowZxSqIjZd8Fr8ff1QGRLNuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736810169; c=relaxed/simple;
	bh=THCOc+6FhZ0Ytb1uKtGAy7Kq8WlBqzKDbLOKYQldIPE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ur2oUhveGdsPRxFkllM6sQmsE40WXpIn71KN+hJ95nJF6FaluEDVGIdRzbLMyu2QdUz60e9STjinugLAfa4fdGq1ksDxft87Ri+HwenQJFDaKmWlegKa74NqJOby+y9kOqEBNHX0jIX0pZ7HYfI6ErnNGFcdd6WCRFlRAe0SqXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cD1EB+uS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46885C4CEEA;
	Mon, 13 Jan 2025 23:16:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736810169;
	bh=THCOc+6FhZ0Ytb1uKtGAy7Kq8WlBqzKDbLOKYQldIPE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cD1EB+uSpXwfHZ9Xm3u0gJv7DkooqWP544zNM6/rgOer0bnHJ2PXcKpaZGq2uZkpG
	 FadackyBCRSYs0VCjI8hTHjO9VHl6d3d3Bki1V821YguHB0v5hCtgwUjTEe/fk/9lo
	 +cBKqhMnOIi4lRiMr4fTrm1OQ65iQLEbp8P48JxxeDLQSBN8+MNLKhj+/wXidVwKSG
	 do/Zcs+IQQKRihi1bFz7c84hbI8Ddnc8M13ks7A4iCaiHAEFB7pUNYDiUCDgznhR6b
	 lw7Uz0jqrNcMnCtwgb4tq9D81p7UCjwoO8aj8nNufWkuHREZaz/1tmrd36ERVqb9fJ
	 P/u4889RNmVHw==
From: Bjorn Helgaas <helgaas@kernel.org>
To: Rob Herring <robh@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v2 4/4] sparc/PCI: Update reference to devm_of_pci_get_host_bridge_resources()
Date: Mon, 13 Jan 2025 17:15:57 -0600
Message-Id: <20250113231557.441289-5-helgaas@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250113231557.441289-1-helgaas@kernel.org>
References: <20250113231557.441289-1-helgaas@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bjorn Helgaas <bhelgaas@google.com>

5bd51b35c7cb ("PCI: Rework of_pci_get_host_bridge_resources() to
devm_of_pci_get_host_bridge_resources()") converted and renamed
of_pci_get_host_bridge_resources().  Update the comment reference to match.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Acked-by: Andreas Larsson <andreas@gaisler.com>
---
 arch/sparc/kernel/pci_common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sparc/kernel/pci_common.c b/arch/sparc/kernel/pci_common.c
index 5eeec9ad6845..2576f4f31309 100644
--- a/arch/sparc/kernel/pci_common.c
+++ b/arch/sparc/kernel/pci_common.c
@@ -361,7 +361,7 @@ void pci_determine_mem_io_space(struct pci_pbm_info *pbm)
 	int i, saw_mem, saw_io;
 	int num_pbm_ranges;
 
-	/* Corresponding generic code in of_pci_get_host_bridge_resources() */
+	/* Corresponds to generic devm_of_pci_get_host_bridge_resources() */
 
 	saw_mem = saw_io = 0;
 	pbm_ranges = of_get_property(pbm->op->dev.of_node, "ranges", &i);
-- 
2.34.1


