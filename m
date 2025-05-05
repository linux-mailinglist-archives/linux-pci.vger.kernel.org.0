Return-Path: <linux-pci+bounces-27218-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 54968AAA9C2
	for <lists+linux-pci@lfdr.de>; Tue,  6 May 2025 03:21:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2398016C561
	for <lists+linux-pci@lfdr.de>; Tue,  6 May 2025 01:20:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 563812D37F9;
	Mon,  5 May 2025 22:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="udJm84e4"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40FAB2C2FA4;
	Mon,  5 May 2025 22:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746485116; cv=none; b=VwHKsAZOXnC7ywwx8eiVieWMn5cOUgStBFFT4Z/pWi2WZTJUCumdmJVYpdtxniy5oXxcx68mM8QjbHIeJ1GmtB6Re5MVgvSGRolJA6yhhuCJoZb2r2Z9lmPTQhg7+/OYw9blydbacXLFhNQroxGRSRttKf7hfNwfYyHDYRWggGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746485116; c=relaxed/simple;
	bh=YjpmIakx+Puf8sOQYZdurC/r+cE9C29XfW9VvJmq6JQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W9BW4ae3s36SVtKOvUZgdEmmFTmHk1Wb0OY0cY/VWsVkBf8wTf6tG7WlJlnOjIFBy1uJW5ZYpYyk+ef61WhIdxt5zz8A+R0HsszlNMlQluDmfVWtV0Dhz1HQDCZY5jyvDF9X+TL4fwfSxATroPPh9gqeQERcjXwmhTd50bzR1Fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=udJm84e4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9A37C4CEE4;
	Mon,  5 May 2025 22:45:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746485115;
	bh=YjpmIakx+Puf8sOQYZdurC/r+cE9C29XfW9VvJmq6JQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=udJm84e4UjERqUkrY0m+2FU/hCqtRBAJHc4WoHBuLoUUH1niiyRNYk+/jDH+aMFYr
	 T8ae4sFgWLQ/WN89RkpoHJi3uFp6al+lY1S6wRv6+PiPpleUTYtyjwDahSOIWF/gjj
	 aoE4EHjyWsNFpTVxNZvtx7UrwOQDA67Kp5VCCY11reC+GBGjkogv4YNlxQhQEIw95w
	 qTsL2CkM3CW/EaF/yKI0WYjTnIO8Oj9laddLbZiLln53tEUI2cCU/P8VTr7WLPTOow
	 upvpifMaSWynqTPAGg2xetv7kdDoI23BA+nBpfb+wHJcYGmT3Ct95U9PaFkoKiteU4
	 GppObzK0vlkwA==
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
	jiangwang@kylinos.cn,
	linux-pci@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 169/486] PCI: endpoint: pci-epf-test: Fix double free that causes kernel to oops
Date: Mon,  5 May 2025 18:34:05 -0400
Message-Id: <20250505223922.2682012-169-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505223922.2682012-1-sashal@kernel.org>
References: <20250505223922.2682012-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.26
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
index 14b4c68ab4e1a..21aa3709e2577 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -703,6 +703,7 @@ static int pci_epf_test_set_bar(struct pci_epf *epf)
 		if (ret) {
 			pci_epf_free_space(epf, epf_test->reg[bar], bar,
 					   PRIMARY_INTERFACE);
+			epf_test->reg[bar] = NULL;
 			dev_err(dev, "Failed to set BAR%d\n", bar);
 			if (bar == test_reg_bar)
 				return ret;
@@ -878,6 +879,7 @@ static void pci_epf_test_free_space(struct pci_epf *epf)
 
 		pci_epf_free_space(epf, epf_test->reg[bar], bar,
 				   PRIMARY_INTERFACE);
+		epf_test->reg[bar] = NULL;
 	}
 }
 
-- 
2.39.5


