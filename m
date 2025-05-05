Return-Path: <linux-pci+bounces-27204-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62A60AAA318
	for <lists+linux-pci@lfdr.de>; Tue,  6 May 2025 01:09:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 65C897B2C61
	for <lists+linux-pci@lfdr.de>; Mon,  5 May 2025 23:05:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B27D2EC02B;
	Mon,  5 May 2025 22:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FtcsRP45"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6E532EC027;
	Mon,  5 May 2025 22:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746483777; cv=none; b=u1GcKv8j95rPcoNu9ubPxe2Js5bhkatZhSwsnHE6KpKeBW21FlOAVY/ZBx16gi/F6iRIYGPm5juV7fYOk0L/RGb/ZfUQAfmpEW1cz5Jnnt9ANmR/B3I369V5M/W55D5DtW7TMMIxNJn2GQBPXAlznaO2XnywejOqKvi+Qnfk7Eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746483777; c=relaxed/simple;
	bh=xH85xPGyFvNEPB2DspZSW0SjwYfEHvEu14y6gt6Dme0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gwnCugBLSZZVVYO8hB3Lf7be5jGoOWvDlYvCdibtQsB0CBrusaJur/qpwi99brOo+Yl3Ni9N9Vv16Qq8n7Krj7rczhLbXcALBGtLyl/LvRl5jDUu3oPwr2BIlXRC9t110iRrO2JWJC+Yf40+x6BcV9eOjA6/w1D5ddN8NLAfjyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FtcsRP45; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81DB3C4CEE4;
	Mon,  5 May 2025 22:22:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746483776;
	bh=xH85xPGyFvNEPB2DspZSW0SjwYfEHvEu14y6gt6Dme0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FtcsRP45tA5sebP/9W4bmUetxbYPf1dNimx2QDmE22/h1blTLoUtgGF8X4wk9ASNu
	 1MWlfzDh2UzfZuuQvJ0almCYU4/603+TtFqFW5/18djk2vT2/xgQFJqYdWHVIctQqE
	 p6MLPrmUa1Y0tX3MZumUiWnJ4HhYohc97DxXndHfeI8HkAmkg+xByOgrJBo85Z81Sc
	 pVEX5KWLgLJT54jXHL6thYK3j6/2LnAE91zlJNgLw0Fp/1pfGwYlxrvAIaXDcb00O5
	 aa2VxapiOUbuy6aYg76A1r14bvmrSWnwrpHE4+7zfIYVjMOLcnyT/giSF6hdP2OryO
	 T4n7cK+xIPVIQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Christian Bruel <christian.bruel@foss.st.com>,
	Niklas Cassel <cassel@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	kw@linux.com,
	bhelgaas@google.com,
	Frank.Li@nxp.com,
	dlemoal@kernel.org,
	linux-pci@vger.kernel.org
Subject: [PATCH AUTOSEL 6.14 213/642] PCI: endpoint: pci-epf-test: Fix double free that causes kernel to oops
Date: Mon,  5 May 2025 18:07:09 -0400
Message-Id: <20250505221419.2672473-213-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
Content-Transfer-Encoding: 8bit

From: Christian Bruel <christian.bruel@foss.st.com>

[ Upstream commit 934e9d137d937706004c325fa1474f9e3f1ba10a ]

Fix a kernel oops found while testing the stm32_pcie Endpoint driver
with handling of PERST# deassertion:

During EP initialization, pci_epf_test_alloc_space() allocates all BARs,
which are further freed if epc_set_bar() fails (for instance, due to no
free inbound window).

However, when pci_epc_set_bar() fails, the error path:

  pci_epc_set_bar() ->
    pci_epf_free_space()

does not clear the previous assignment to epf_test->reg[bar].

Then, if the host reboots, the PERST# deassertion restarts the BAR
allocation sequence with the same allocation failure (no free inbound
window), creating a double free situation since epf_test->reg[bar] was
deallocated and is still non-NULL.

Thus, make sure that pci_epf_alloc_space() and pci_epf_free_space()
invocations are symmetric, and as such, set epf_test->reg[bar] to NULL
when memory is freed.

Reviewed-by: Niklas Cassel <cassel@kernel.org>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Christian Bruel <christian.bruel@foss.st.com>
Link: https://lore.kernel.org/r/20250124123043.96112-1-christian.bruel@foss.st.com
[kwilczynski: commit log]
Signed-off-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/endpoint/functions/pci-epf-test.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
index 2409787cf56d9..bce3ae2c0f652 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -738,6 +738,7 @@ static int pci_epf_test_set_bar(struct pci_epf *epf)
 		if (ret) {
 			pci_epf_free_space(epf, epf_test->reg[bar], bar,
 					   PRIMARY_INTERFACE);
+			epf_test->reg[bar] = NULL;
 			dev_err(dev, "Failed to set BAR%d\n", bar);
 			if (bar == test_reg_bar)
 				return ret;
@@ -929,6 +930,7 @@ static void pci_epf_test_free_space(struct pci_epf *epf)
 
 		pci_epf_free_space(epf, epf_test->reg[bar], bar,
 				   PRIMARY_INTERFACE);
+		epf_test->reg[bar] = NULL;
 	}
 }
 
-- 
2.39.5


