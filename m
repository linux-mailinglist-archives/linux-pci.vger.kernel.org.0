Return-Path: <linux-pci+bounces-16251-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 911089C0A25
	for <lists+linux-pci@lfdr.de>; Thu,  7 Nov 2024 16:33:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 490401F22F4D
	for <lists+linux-pci@lfdr.de>; Thu,  7 Nov 2024 15:33:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21E15212D07;
	Thu,  7 Nov 2024 15:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LUwBRMfX"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA54629CF4;
	Thu,  7 Nov 2024 15:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730993593; cv=none; b=GkMjakIkEJt4xOc0iiK5Mu4U9N+hJyNcrB9lcmelmURnFDx2wHTWgbXcO76Hb7/EBLvR8YnjgdubxxaCq/96eQ0wffw39wnCwrBU6PCfQykCOSWeuGDTiHievZT2VstM8W8uq53fPxEDxdOdRte/g1QwbeJGSPcvdkSALMJu50k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730993593; c=relaxed/simple;
	bh=b2xKdidBH48y+1hjUYSNmGCdaQIGQdqE3pXSKipDMPc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=L2ttboy/0v3RxCyfKuEylUhZ2EvHKS5NdBJpbTLFZ8JbHTmb0tVDiwMXDmG5LaqHq6+ZeYsRrFwun8+Qaludt5sTt6pIBr3OsaZFqm5YuN6DrneObgKUDIyX28Dv+o+eUL5xsMKe/W5UWBQz9KeqS1CgjoHwf+sBtvw6wIlw3qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LUwBRMfX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B255C4CECC;
	Thu,  7 Nov 2024 15:33:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730993592;
	bh=b2xKdidBH48y+1hjUYSNmGCdaQIGQdqE3pXSKipDMPc=;
	h=From:To:Cc:Subject:Date:From;
	b=LUwBRMfX2EQZ8YknvydxZ7++w9PLidGNiajYSyTi3cygoA7t2zRgiho6AOcDZ9WiD
	 cj6Eg7Bz3kgMkfRqZouFi83/NuorOzc4GEclfKzZUe6h0YogWoosAzECkB3mC3EULA
	 kR4WxQNm9XVMKZ/Ww+jwzhFJ9TR4oTr4sNf6RT232XrxvnpRoPOiKbJEUGZrzSSZFn
	 rNkVAVN9pnww6DmYhNHqSNXgUtZbW3BlfJ8l88yMNG7toSKxBFgGEQTO2ourPp4z5z
	 3Suo10102Sj+qeHd4bsgywz0WxGSJm9u8zQN3OQxgLuZOtZqtzp/GdLnAsGGZJrZ1/
	 +5jNIKwRRNi4Q==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	=?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] PCI: mvebu: Use for_each_of_range() iterator for parsing "ranges"
Date: Thu,  7 Nov 2024 09:32:55 -0600
Message-ID: <20241107153255.2740610-1-robh@kernel.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The mvebu "ranges" is a bit unusual with its own encoding of addresses,
but it's still just normal "ranges" as far as parsing is concerned.
Convert mvebu_get_tgt_attr() to use the for_each_of_range() iterator
instead of open coding the parsing.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
Compile tested only.
---
 drivers/pci/controller/pci-mvebu.c | 26 +++++++++-----------------
 1 file changed, 9 insertions(+), 17 deletions(-)

diff --git a/drivers/pci/controller/pci-mvebu.c b/drivers/pci/controller/pci-mvebu.c
index 29fe09c99e7d..d4e3f1e76f84 100644
--- a/drivers/pci/controller/pci-mvebu.c
+++ b/drivers/pci/controller/pci-mvebu.c
@@ -1179,37 +1179,29 @@ static int mvebu_get_tgt_attr(struct device_node *np, int devfn,
 			      unsigned int *tgt,
 			      unsigned int *attr)
 {
-	const int na = 3, ns = 2;
-	const __be32 *range;
-	int rlen, nranges, rangesz, pna, i;
+	struct of_range range;
+	struct of_range_parser parser;
 
 	*tgt = -1;
 	*attr = -1;
 
-	range = of_get_property(np, "ranges", &rlen);
-	if (!range)
+	if (of_pci_range_parser_init(&parser, np))
 		return -EINVAL;
 
-	pna = of_n_addr_cells(np);
-	rangesz = pna + na + ns;
-	nranges = rlen / sizeof(__be32) / rangesz;
-
-	for (i = 0; i < nranges; i++, range += rangesz) {
-		u32 flags = of_read_number(range, 1);
-		u32 slot = of_read_number(range + 1, 1);
-		u64 cpuaddr = of_read_number(range + na, pna);
+	for_each_of_range(&parser, &range) {
 		unsigned long rtype;
+		u32 slot = upper_32_bits(range.bus_addr);
 
-		if (DT_FLAGS_TO_TYPE(flags) == DT_TYPE_IO)
+		if (DT_FLAGS_TO_TYPE(range.flags) == DT_TYPE_IO)
 			rtype = IORESOURCE_IO;
-		else if (DT_FLAGS_TO_TYPE(flags) == DT_TYPE_MEM32)
+		else if (DT_FLAGS_TO_TYPE(range.flags) == DT_TYPE_MEM32)
 			rtype = IORESOURCE_MEM;
 		else
 			continue;
 
 		if (slot == PCI_SLOT(devfn) && type == rtype) {
-			*tgt = DT_CPUADDR_TO_TARGET(cpuaddr);
-			*attr = DT_CPUADDR_TO_ATTR(cpuaddr);
+			*tgt = DT_CPUADDR_TO_TARGET(range.cpu_addr);
+			*attr = DT_CPUADDR_TO_ATTR(range.cpu_addr);
 			return 0;
 		}
 	}
-- 
2.45.2


