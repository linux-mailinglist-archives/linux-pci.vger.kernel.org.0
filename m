Return-Path: <linux-pci+bounces-35679-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BE4DB4951A
	for <lists+linux-pci@lfdr.de>; Mon,  8 Sep 2025 18:23:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A6F61BC5946
	for <lists+linux-pci@lfdr.de>; Mon,  8 Sep 2025 16:22:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B279030FC2B;
	Mon,  8 Sep 2025 16:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JgZktLa+"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D04930F939
	for <linux-pci@vger.kernel.org>; Mon,  8 Sep 2025 16:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757348397; cv=none; b=cCGxGZ4VdR6TkTvCMOPsLr1+awgP32NwG95wALU6/wjGDfv249DVZpXESDWBy67AXWprAiAqg1VSp2azq7G7Bh2+dSzL91R8NUDmE2qJ2kbEQ/ygruK1qRulU9esQRxPP6yDgH9c/Pg53cieeiGGoPSbZ9GxqS429oyM3FZY1So=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757348397; c=relaxed/simple;
	bh=TQdEl3swo1CiyYVrdBjpFs5kf9S+uEhtXvrX4JbGqwE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Zv62cMJptX+ZH7naNu7DTtaAxAw/BoD9ChPP3Skn5b8KlMbY8qTHFZgOFLGTJH4IQYIevsD5eVhhFGygU8DUA7fqMg+9eMi8EueC/B5UlfaUfXdFMzgHumzHomNw20N1RNQskMkkeLoW2JNmZf7MC4enR70gM9farA1H0YAnv9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JgZktLa+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56A25C4CEF1;
	Mon,  8 Sep 2025 16:19:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757348397;
	bh=TQdEl3swo1CiyYVrdBjpFs5kf9S+uEhtXvrX4JbGqwE=;
	h=From:To:Cc:Subject:Date:From;
	b=JgZktLa+FOOeBKnD2SXY696SJzIKE0rlBBRHFQ38A/kTc3r1yGfLeVoeG8qTAgWJm
	 7evUDSqZe/HXCLpNcP2/9nJj3TbAdpgsprEgZIisKQBbRgHfu600E3uU1EnnOalmLQ
	 jcj3EL2DfF7mS1zd6GFVqWeT0iZYMZAkBiQ5HHTyCei8LuRhA1jCW2Ms1pY5+kIyiL
	 sRYTnxKYseoSnPSBEhW4ou160xLLCtin0y7Za1bWzJQ30GX4WMn0gSbngFmA/HKNQX
	 xPaANQFP18mTL280y4mM+yU02dyr4M53JAtDKIwC/b4yFv0dzj3cU+NUAMRdAi9GFO
	 9knc+9rhDuc8A==
From: Niklas Cassel <cassel@kernel.org>
To: Manivannan Sadhasivam <mani@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Frank Li <Frank.Li@nxp.com>
Cc: Niklas Cassel <cassel@kernel.org>,
	linux-pci@vger.kernel.org
Subject: [PATCH] PCI: endpoint: pci-epf-test: Fix doorbell test support
Date: Mon,  8 Sep 2025 18:19:42 +0200
Message-ID: <20250908161942.534799-2-cassel@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2413; i=cassel@kernel.org; h=from:subject; bh=TQdEl3swo1CiyYVrdBjpFs5kf9S+uEhtXvrX4JbGqwE=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGDL2M8ntfCEmdmYXg4ZlqtIKG2EPpnsmmeF/DFZuefx1+ akz3Du7OkpZGMS4GGTFFFl8f7jsL+52n3Jc8Y4NzBxWJpAhDFycAjAR11ZGhmltk3Skak06FTdW ereHsc7LevLpc13i6Z3pq57Y15u8YGT4Z1q45NHJV1V650yu61eKrxQ6Knngw8PMLV+3Ovb95D3 bwAIA
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

The doorbell feature temporarily overrides the inbound translation to
point to the address stored in epf_test->db_bar.phys_addr.
(I.e. it calls set_bar() twice, without ever calling clear_bar(), as
calling clear_bar() would clear the BAR's PCI address assigned by the
host).

Thus, when disabling the doorbell, restore the inbound translation to
point to the memory allocated for the BAR.

Without this, running the pci endpoint kselftest doorbell test case more
than once would fail.

Cc: Frank Li <Frank.Li@nxp.com>
Fixes: eff0c286aa91 ("PCI: endpoint: pci-epf-test: Add doorbell test support")
Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
Note: this is actually how the code looked like when it was submitted by
Frank, see pci_epf_test_disable_doorbell() in:
https://lore.kernel.org/linux-pci/20250710-ep-msi-v21-6-57683fc7fb25@nxp.com/
However, the code was modified, without notifying the list of this
non-trivial logical change, before being applied.

 drivers/pci/endpoint/functions/pci-epf-test.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
index e091193bd8a8a..b6ca1766a4ca9 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -772,12 +772,24 @@ static void pci_epf_test_disable_doorbell(struct pci_epf_test *epf_test,
 	u32 status = le32_to_cpu(reg->status);
 	struct pci_epf *epf = epf_test->epf;
 	struct pci_epc *epc = epf->epc;
+	int ret;
 
 	if (bar < BAR_0)
 		goto set_status_err;
 
 	pci_epf_test_doorbell_cleanup(epf_test);
-	pci_epc_clear_bar(epc, epf->func_no, epf->vfunc_no, &epf_test->db_bar);
+
+	/*
+	 * The doorbell feature temporarily overrides the inbound translation to
+	 * point to the address stored in epf_test->db_bar.phys_addr.
+	 * (I.e. it calls set_bar() twice, without ever calling clear_bar(), as
+	 * calling clear_bar() would clear the BAR's PCI address assigned by the
+	 * host). Thus, when disabling the doorbell, restore the inbound
+	 * translation to point to the memory allocated for the BAR.
+	 */
+	ret = pci_epc_set_bar(epc, epf->func_no, epf->vfunc_no, &epf->bar[bar]);
+	if (ret)
+		goto set_status_err;
 
 	status |= STATUS_DOORBELL_DISABLE_SUCCESS;
 	reg->status = cpu_to_le32(status);
-- 
2.51.0


