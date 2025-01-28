Return-Path: <linux-pci+bounces-20479-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D55B6A20FCF
	for <lists+linux-pci@lfdr.de>; Tue, 28 Jan 2025 18:54:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FDE11884DF8
	for <lists+linux-pci@lfdr.de>; Tue, 28 Jan 2025 17:54:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 737A91DE8AA;
	Tue, 28 Jan 2025 17:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mV/Bj6oK"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D7381DE8A6;
	Tue, 28 Jan 2025 17:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738086831; cv=none; b=RDhAmw+7wDp9Vxa6X3w1OB/EnI80pCVmxOSIYT+LZZLJamrPaSAuLuumGOZwCWZs3h2yCzlJySWF7BcX09i6/rhcxZXvgAU+bUvR1o8OIdbtmb48GiLLoTL1MUfqsR/W9yeYby+dHs9rNCQqz74htvIpQQkcSWOpXscN3qsnJos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738086831; c=relaxed/simple;
	bh=CDOs8WP2JNN/dHAwgr95DyRHckyBFA1Uf2K4mS/it3Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gOd3ctWKPxQOvarFIlR40FAD+HJHL9keK1X6PAEfyDexEqKKkwcBM96jQE74DivKoiU4+v4JiyXx8Df62Q6aIcW1YEnUbfmP4HsBTQF9Jcxu5lKoDw703dP4hqhEQkdRaoinT+0xnDqmVzcripdKT19e2HfA4zcrhl/NGOT1HVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mV/Bj6oK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99342C4CEE1;
	Tue, 28 Jan 2025 17:53:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738086830;
	bh=CDOs8WP2JNN/dHAwgr95DyRHckyBFA1Uf2K4mS/it3Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mV/Bj6oKixuq61K/2pm3gYPQ+tJTmDje8N3xpzt1wHQ4jODmhaC363xoJeOXsE/fC
	 VMr1bpuTCRA4Jwt6BNU+WrqNC192lROxJf0v5+Pf1ppmFI6TsPn6K6gf7IhhCVVlBz
	 NMot0Rhntmfu5BRdmZuGqET2nU2f4cydLNDUnbqL44r2jVNLHBE+q305O4Q4qHwMTC
	 9W2gf78+w+1hAOGtT9NG8pbujbnvStA9s6/SIU28wF1eKQKphqJBwYlsALsEA7B1dg
	 wODPftWLN4XxLVWtF8amBoG/hr8x7mJ3xXsbyjK3DcfnHUIyaZi1u2Mtr93KKoQWYF
	 wqOi8prq93z7A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Niklas Cassel <cassel@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Frank Li <Frank.Li@nxp.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Sasha Levin <sashal@kernel.org>,
	kw@linux.com,
	bhelgaas@google.com,
	linux-pci@vger.kernel.org
Subject: [PATCH AUTOSEL 6.13 02/15] PCI: endpoint: Add size check for fixed size BARs in pci_epc_set_bar()
Date: Tue, 28 Jan 2025 12:53:33 -0500
Message-Id: <20250128175346.1197097-2-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250128175346.1197097-1-sashal@kernel.org>
References: <20250128175346.1197097-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.13
Content-Transfer-Encoding: 8bit

From: Niklas Cassel <cassel@kernel.org>

[ Upstream commit f015b53d634a10fbceba545de70c3e109665c379 ]

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

Link: https://lore.kernel.org/r/20241213143301.4158431-13-cassel@kernel.org
Signed-off-by: Niklas Cassel <cassel@kernel.org>
Signed-off-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/endpoint/pci-epc-core.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
index bed7c7d1fe3c3..c69c133701c92 100644
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
2.39.5


