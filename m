Return-Path: <linux-pci+bounces-17405-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FA3C9DA5C9
	for <lists+linux-pci@lfdr.de>; Wed, 27 Nov 2024 11:31:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9FC32857A0
	for <lists+linux-pci@lfdr.de>; Wed, 27 Nov 2024 10:31:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0680A198850;
	Wed, 27 Nov 2024 10:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QlvVic8/"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D60D4D2FB
	for <linux-pci@vger.kernel.org>; Wed, 27 Nov 2024 10:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732703446; cv=none; b=gybSMC2UKKIq+sHE578rN2MPNEB20g3I7FvzGjF63PkCGFlvU1gzYKifoHopmZw2I5Zf3YUOkPE8uqmmKSFGaNQeu2u1tKay3+vZbIhUvm+fESzuDSlkFf7L/AhIZdFX7eVyq8l71PsUlQYGJleEwkCz6JAxqOwzQv6Beed5VRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732703446; c=relaxed/simple;
	bh=JPAPPTYojFjkEssBwOlkkI+afZc5nd+o0CH9b5v2RkU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lIF/gkC1LfjoBoPrkhmqaMWc52gIiQwtxX9IHyyTizIpCbi8Gje5tUZkMtWwYBYQKYQ/zOhN7V/PGTN1A8+38FCuGXPdAMiKTMSyvc23CtNYDo8IuylDjY35ONShiBRUeKLnKuBBfMV7HM/QmHi2rIQKKj1C6t4tGUz/gXEYjkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QlvVic8/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 836AFC4CED2;
	Wed, 27 Nov 2024 10:30:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732703446;
	bh=JPAPPTYojFjkEssBwOlkkI+afZc5nd+o0CH9b5v2RkU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QlvVic8/kl3lHliQIpaZ8FOlNQROmTYWJOpiqgzZlZpBR+Jd0AB0vETBYhO8hiXxL
	 fcKYtypjrsacRov4fLOnfMSh6wzL2dtV2QtqysjiPD/Yrldj50Mwi0A+nM7DefIyII
	 XDktBOPCFnfXFjDUXYwdqZdSXgLEmcpMyRMeHEHjZp+G8bC3OucNxI8U++TlflwBb3
	 HzzOB1wJJjh9G6V3/urWvzADtciQv8j00Mtr4IKSgLVNny9Aaz+eJTs7Nx8Tn6Q7wn
	 xRBIql+2X2C/7tagdhdQYJb3xj/zmPOQSWBkJ/kCt9utz7U4GCdmxxdXezapEQ+sbR
	 PEc16Nyc8ph5A==
From: Niklas Cassel <cassel@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Frank Li <Frank.Li@nxp.com>,
	Jesper Nilsson <jesper.nilsson@axis.com>,
	Niklas Cassel <cassel@kernel.org>,
	linux-pci@vger.kernel.org
Subject: [PATCH v5 5/6] PCI: endpoint: Add size check for fixed size BARs in pci_epc_set_bar()
Date: Wed, 27 Nov 2024 11:30:21 +0100
Message-ID: <20241127103016.3481128-13-cassel@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241127103016.3481128-8-cassel@kernel.org>
References: <20241127103016.3481128-8-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1895; i=cassel@kernel.org; h=from:subject; bh=JPAPPTYojFjkEssBwOlkkI+afZc5nd+o0CH9b5v2RkU=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGNLdvuxj7s+s8+wWv5BtsZrvU1HMxXzfGXvP8cwT5p1wK VCr9f/SjlIWBjEuBlkxRRbfHy77i7vdpxxXvGMDM4eVCWQIAxenAEykipWRYZcix5PbRyUP6li/ /GAueM8/KO7jhJaCKqnFsvtnPN6z8hvD/3LN7tkHl9QmJ004IsOYq6bLod5o17BA1fHM21/GpbL BvAA=
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

A BAR of type BAR_FIXED has a fixed BAR size (the size cannot be changed).

When using pci_epf_alloc_space() to allocate backing memory for a BAR,
pci_epf_alloc_space() will always set the size to the fixed BAR size if
the BAR type is BAR_FIXED (and will give an error if you the requested size
is larger than the fixed BAR size).

However, some drivers might not call pci_epf_alloc_space() before calling
pci_epc_set_bar(), so add a check in pci_epc_set_bar() to ensure that an
EPF driver cannot set a size different from the fixed BAR size, if the BAR
type is BAR_FIXED.

The pci_epc_function_is_valid() check is removed because this check is now
done by pci_epc_get_features().

Signed-off-by: Niklas Cassel <cassel@kernel.org>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/endpoint/pci-epc-core.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
index bed7c7d1fe3c..c69c133701c9 100644
--- a/drivers/pci/endpoint/pci-epc-core.c
+++ b/drivers/pci/endpoint/pci-epc-core.c
@@ -609,10 +609,17 @@ EXPORT_SYMBOL_GPL(pci_epc_clear_bar);
 int pci_epc_set_bar(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 		    struct pci_epf_bar *epf_bar)
 {
-	int ret;
+	const struct pci_epc_features *epc_features;
+	enum pci_barno bar = epf_bar->barno;
 	int flags = epf_bar->flags;
+	int ret;
 
-	if (!pci_epc_function_is_valid(epc, func_no, vfunc_no))
+	epc_features = pci_epc_get_features(epc, func_no, vfunc_no);
+	if (!epc_features)
+		return -EINVAL;
+
+	if (epc_features->bar[bar].type == BAR_FIXED &&
+	    (epc_features->bar[bar].fixed_size != epf_bar->size))
 		return -EINVAL;
 
 	if ((epf_bar->barno == BAR_5 && flags & PCI_BASE_ADDRESS_MEM_TYPE_64) ||
-- 
2.47.0


