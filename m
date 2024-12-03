Return-Path: <linux-pci+bounces-17562-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D74A99E1371
	for <lists+linux-pci@lfdr.de>; Tue,  3 Dec 2024 07:39:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 66596B222BB
	for <lists+linux-pci@lfdr.de>; Tue,  3 Dec 2024 06:39:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C89BF185B48;
	Tue,  3 Dec 2024 06:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t+3GhLh0"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A43703398B
	for <linux-pci@vger.kernel.org>; Tue,  3 Dec 2024 06:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733207946; cv=none; b=gRUsBibFH6bQ3XA8D5LPiSkv2dbEAn4qg8IvPDQC3TxMEi6Zq9o4VhMqM2LN+id1TXpVlM6JBLTuD/Nqn47ihXR+zvM/8u5nNN5AkAzRPehlwC4Vx31e5zSPV82XI7mCaXV1VKmzbyFHNEC9AMfsuIfuj7Wzg16zVD3uwIyFkME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733207946; c=relaxed/simple;
	bh=URC8jjitYYzxj8YduEPzCG10PYCgH7e9KkToluni70U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mgLq7juQn7blUXmtdBtSSM1bPayWZS9sbu11+eqRPTKZUT04g7l8hriiQyih1nsuU+KlbxkvQoGPvqkeOmAegfGsxv2+2ygpYrczWqWor8qnT7Nk5hMRFpbBzkqpzOUSRCJFoZDyXpIszwJuvdr8E2X1cqMr0SmNQ2p7OuRmMdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t+3GhLh0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AC77C4CEDA;
	Tue,  3 Dec 2024 06:39:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733207946;
	bh=URC8jjitYYzxj8YduEPzCG10PYCgH7e9KkToluni70U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=t+3GhLh0BirVr3439krXV1jmcLaQr8iHP0ZtRGPZGeh6snWL9U5y8CfgVwX8racVk
	 ycJ9grCrhfPwufy81cU6ZI3xuBmuxMBPMa0tFS54kKuOsYghvZtaezyj9g0w51fGs+
	 V1bI7BNSrslnUMpWko/zpxDdHfsiFEirdSq49yTDQWJCkVf3EAbiXhh1K6C1aZhcMa
	 nPY4VVXyrBkNxZgw3wCy0dXazNIkH13GvBmq9DFx5fr6c45NOR4WsmS0tyNNI719Hv
	 LEaG1v6TVBWPdneTdpX7YC7W4teT079/jNYG/YFH/F/Kt9rAkArWRjKfi89vXB2hKJ
	 w2cq9hFzkiyEg==
From: Niklas Cassel <cassel@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>
Cc: Damien Le Moal <dlemoal@kernel.org>,
	linux-pci@vger.kernel.org,
	Frank Li <Frank.Li@nxp.com>,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH v3 1/2] PCI: endpoint: pci-epf-test: Add support for capabilities
Date: Tue,  3 Dec 2024 07:38:53 +0100
Message-ID: <20241203063851.695733-5-cassel@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241203063851.695733-4-cassel@kernel.org>
References: <20241203063851.695733-4-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2524; i=cassel@kernel.org; h=from:subject; bh=URC8jjitYYzxj8YduEPzCG10PYCgH7e9KkToluni70U=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGNL9ljdOvXfpAZfuhcP8F3u3f3mn+cQ/6dLnz8IrgrmF0 +ZlRt1Y3FHKwiDGxSArpsji+8Nlf3G3+5TjindsYOawMoEMYeDiFICJHOtlZPglns4o4VDSEhv+ ceaxC7oK7JPv/lqf7MmhwrsgjN2kyYaRYVfazrKTnJHs4nnzmYXXWLIvXCRncvbrQVGX83LH3aZ FsAIA
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

The test BAR is on the EP side is allocated using pci_epf_alloc_space(),
which allocates the backing memory using dma_alloc_coherent(), which will
return zeroed memory regardless of __GFP_ZERO was set or not.

This means that running a new version of pci-endpoint-test.c (host side)
with an old version of pci-epf-test.c (EP side) will not see any
capabilities being set (as intended), so this is backwards compatible.

Additionally, the EP side always allocates at least 128 bytes for the test
BAR (excluding the MSI-X table), this means that adding another register at
offset 0x30 is still within the 128 available bytes.

For now, we only add the CAP_UNALIGNED_ACCESS capability.

Set CAP_UNALIGNED_ACCESS if the EPC driver can handle any address (because
it implements the .align_addr callback).

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/pci/endpoint/functions/pci-epf-test.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
index ef6677f34116..7351289ecddd 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -44,6 +44,8 @@
 
 #define TIMER_RESOLUTION		1
 
+#define CAP_UNALIGNED_ACCESS		BIT(0)
+
 static struct workqueue_struct *kpcitest_workqueue;
 
 struct pci_epf_test {
@@ -74,6 +76,7 @@ struct pci_epf_test_reg {
 	u32	irq_type;
 	u32	irq_number;
 	u32	flags;
+	u32	caps;
 } __packed;
 
 static struct pci_epf_header test_header = {
@@ -739,6 +742,20 @@ static void pci_epf_test_clear_bar(struct pci_epf *epf)
 	}
 }
 
+static void pci_epf_test_set_capabilities(struct pci_epf *epf)
+{
+	struct pci_epf_test *epf_test = epf_get_drvdata(epf);
+	enum pci_barno test_reg_bar = epf_test->test_reg_bar;
+	struct pci_epf_test_reg *reg = epf_test->reg[test_reg_bar];
+	struct pci_epc *epc = epf->epc;
+	u32 caps = 0;
+
+	if (epc->ops->align_addr)
+		caps |= CAP_UNALIGNED_ACCESS;
+
+	reg->caps = cpu_to_le32(caps);
+}
+
 static int pci_epf_test_epc_init(struct pci_epf *epf)
 {
 	struct pci_epf_test *epf_test = epf_get_drvdata(epf);
@@ -763,6 +780,8 @@ static int pci_epf_test_epc_init(struct pci_epf *epf)
 		}
 	}
 
+	pci_epf_test_set_capabilities(epf);
+
 	ret = pci_epf_test_set_bar(epf);
 	if (ret)
 		return ret;
-- 
2.47.1


