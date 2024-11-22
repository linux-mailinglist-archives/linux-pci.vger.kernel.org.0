Return-Path: <linux-pci+bounces-17208-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 555359D5E79
	for <lists+linux-pci@lfdr.de>; Fri, 22 Nov 2024 12:57:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D3CFEB24EEE
	for <lists+linux-pci@lfdr.de>; Fri, 22 Nov 2024 11:57:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB18C1DE2B5;
	Fri, 22 Nov 2024 11:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tJLdtfhq"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C75F01DE2A4
	for <linux-pci@vger.kernel.org>; Fri, 22 Nov 2024 11:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732276667; cv=none; b=COoV1Hs7K9XjHLDtlk15v/+B1rF9MxjhvRlZx+iDdosIYz2Qs7fNbar+7x1b6RPupeuU2h4d8K+l8CMVSye2YLabaFWNAwHJoJdC03DzOAqZA5uLrieGbNJNJ3N1Q1L5A83Li53hDKpT6KNezpk3Iv8StQK8e1aMXCCAxnhOK80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732276667; c=relaxed/simple;
	bh=bp4gTYfxr4o5rF6v3uVH2tPluH/lbIksLfFv6D+dFVw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o78PibI+xN5REE3/ZsDQh/qR5Lm4p53PHvi+TRPJsLCf9wYT94Csn+qrl0KdZGo14xwekzqXUUl78rvKIAFdvDIrp3fPmfomPdi0IJBfMWZl45vslVCTqp7uSKD2ZkgZ2qHbRz337xpTq+PBzDxGTb9jSQ/QjkFeqqhE8HcMzN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tJLdtfhq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFDC0C4CECE;
	Fri, 22 Nov 2024 11:57:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732276667;
	bh=bp4gTYfxr4o5rF6v3uVH2tPluH/lbIksLfFv6D+dFVw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tJLdtfhq0OletroR1bgIKeDhRwPilvBc7+lEBBwsAUVFpJH37bCa3ok523gWYzOih
	 IUQ4UJJHOxZWaP5i1kxw0r7oNjTRLpDPbdV0GPT3jVBKUbsh+mH6bKjGi+/Vbo29mk
	 nGwg+km6Gz1OBm3CwpMBq+w50sHIZ6C2hM0iizNifBU6LDtWVRGyUzQ8VO05z1IUeb
	 fhfNW5lJGmK/Bpo0Zq2KXgwJbj82bamqW+CBiFCwOmotzyVt+dXwqwt+MSEFs0e6Tx
	 V32utF2Wf72yHCaQGk/XGkG7Km1bI83J6Kkc5+Y3NwaLOsTE3NnIK+89e94+faZ3yU
	 qL4RvsC3OK7JA==
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
Subject: [PATCH v4 4/5] PCI: endpoint: Add size check for fixed size BARs in pci_epc_set_bar()
Date: Fri, 22 Nov 2024 12:57:13 +0100
Message-ID: <20241122115709.2949703-11-cassel@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241122115709.2949703-7-cassel@kernel.org>
References: <20241122115709.2949703-7-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1824; i=cassel@kernel.org; h=from:subject; bh=bp4gTYfxr4o5rF6v3uVH2tPluH/lbIksLfFv6D+dFVw=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGNIdCmc/ioqJ9zFKnzFFfPvcBxNjD0mbRh9/F7g57OLkT UGsq3J/d5SyMIhxMciKKbL4/nDZX9ztPuW44h0bmDmsTCBDGLg4BWAin84x/NM0nP2Th0F4ZpBR 3NLvzz5fYeyYKOFfHzhpzcymg9UqiioM/3RPeEy3e6y3dGe6AHOKihT/uu0Wa6xl9bapJ1lrNB2 5wwoA
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


