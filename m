Return-Path: <linux-pci+bounces-17169-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B6039D4FA0
	for <lists+linux-pci@lfdr.de>; Thu, 21 Nov 2024 16:23:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41EA3283729
	for <lists+linux-pci@lfdr.de>; Thu, 21 Nov 2024 15:23:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 085E51DD880;
	Thu, 21 Nov 2024 15:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SWq5H2XI"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D66381DAC97
	for <linux-pci@vger.kernel.org>; Thu, 21 Nov 2024 15:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732202613; cv=none; b=HxqL+AtaTCFFfUmS+t5YVgYr51h9JpFZdhWlhkIdFElHl1drp5d4wLLGhxTbhpKIJO9J7EH05paKpGdXQXfBNEIegrrIhToQchmmR2vqsFBzgLQIvp6cT3fXyAkvLLFV1lpDtOGG9VX3hmCdzFtYqNTwAdCwgUEJ8stu2LShMRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732202613; c=relaxed/simple;
	bh=WsfEHAX1wZ4aUa6SONyBTWTwV6pCUGpOHFse8ejWykg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bz96nYZHd6QaJghqROM1cbd1nAFVI3sX7I7yD5NfCDcxiXnFHb4CYZsppbggXlAs1K/leF32uRMiLQAEYlLe96no8c5Be8pt/aNoReAAZ3MqXWxxL0qRZSBOSoyJU09Ta86Qa3QkE+sdEoS3sHwk01M0WGwWMwfpeEbG3tRDxaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SWq5H2XI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1451C4CECD;
	Thu, 21 Nov 2024 15:23:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732202613;
	bh=WsfEHAX1wZ4aUa6SONyBTWTwV6pCUGpOHFse8ejWykg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SWq5H2XIT0G8RxwcT7PeTscYjDgG41VMFc7zFi5ucoOfYWLpKets9WS/JwKJWsbak
	 mk6CtPq4DCEA+21wtFCVNMUpmyb8tuqM6sTzlP/DAeh7idq7u+Y5AlOK/i9DmSksCk
	 ihcrDCr3XrEJd0bVwd4H0ZZg564GQv5yGlPqYMlGFpF7d6Ol04X7se9GW0ovxSwkIr
	 Ob/lPwbXUqmBToJGvWAND3Wo1TtPTilRutAUemtrDoJvb45/U8ahfKy02OICDAz/ed
	 AY05ZZ40GbFyoSS/hUsgxlzFdG/vxY/WEBX2IgfkomwLAqAHOqQlDPCO6ayFrLprfd
	 I9oawwPkoIWag==
From: Niklas Cassel <cassel@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>
Cc: Damien Le Moal <dlemoal@kernel.org>,
	linux-pci@vger.kernel.org,
	Frank Li <Frank.Li@nxp.com>,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH v2 1/2] PCI: endpoint: pci-epf-test: Add support for capabilities
Date: Thu, 21 Nov 2024 16:23:20 +0100
Message-ID: <20241121152318.2888179-5-cassel@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241121152318.2888179-4-cassel@kernel.org>
References: <20241121152318.2888179-4-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2411; i=cassel@kernel.org; h=from:subject; bh=WsfEHAX1wZ4aUa6SONyBTWTwV6pCUGpOHFse8ejWykg=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGNLtA7L+u34Jl57xIFXsuqKybtUK6x89JTv2MnHc9c2Qt U1LPn60o5SFQYyLQVZMkcX3h8v+4m73KccV79jAzGFlAhnCwMUpABN5VsXwT/up25wEW+aupxLz EllsZCdrNl5jzL1Z4XmrLPFavoqOCiND648HYRqXGBduLSxZvLjZ4rB1/8NZE10C97drOt1/mhH HAQA=
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
2.47.0


