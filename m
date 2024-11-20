Return-Path: <linux-pci+bounces-17115-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A98B9D3F8A
	for <lists+linux-pci@lfdr.de>; Wed, 20 Nov 2024 16:59:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC5421F221BC
	for <lists+linux-pci@lfdr.de>; Wed, 20 Nov 2024 15:59:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B61E14C5AE;
	Wed, 20 Nov 2024 15:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SBeKdanb"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E60F814A0A4
	for <linux-pci@vger.kernel.org>; Wed, 20 Nov 2024 15:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732118264; cv=none; b=liz8ObPTcz7QTi4/++C67E7AttDHo2RE7TuKjnLX8uXm0cCS2HhTYvgLHZnkLWXEKH04supnSNGzvciDNqtsmF8T2P3h2MlJw/DaEgXdTpu8u2+ec8sOxLvREhuCfE8YOrYRDLIHDOdqUw1eluwsHojgo6rR1+5MrDb9+/lYoNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732118264; c=relaxed/simple;
	bh=4CRDnwDGmlemh5GmK8CvV/Hyvt/wr3PKJNOwBChRGqY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eNHuAfN+3AmPaEmLgxFJiGVBL+nDlBqe95pL93NQBVopPIzjXHrAfFHG7IDtWPxKNj42S5Y56mbPx8CjiTiiylLgIBcrYQarNIYHrE2gyIcMLjAPdQa6DKtYBNlvAiISh5g64ypDgmnQaL9iECTF/VKHfjDKhwM881onUUxcCF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SBeKdanb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47031C4CED3;
	Wed, 20 Nov 2024 15:57:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732118263;
	bh=4CRDnwDGmlemh5GmK8CvV/Hyvt/wr3PKJNOwBChRGqY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SBeKdanbACAYxXYA0Mg/u3RijoD9rEb+FEtPh8gzdix58MZ5KD/fxox6BYXRc2HYl
	 8PhV/aSO3yPrtHIXkYr0VPMuI7VnioQd2vRYNgBRe8qAHGwzjdYdo0jwRTSdUt8pWU
	 YrQzv012J9rG9CzQ3sA24HouD56RportYbmMLyaE+pesWYrhjLi+CtV5pJ7BEbluSQ
	 lrw48/dZJD2HsQezy3k8i1XTbMnfDiJM7nlbuF9iPM3cnIycYBgopqyxb321SGB49c
	 cZXd8ZUZUuVAtBkK64YYkqYtVv4iHs8ica1UxvKixFzGfFYie+aCpEdh3gtB9sXpgR
	 cgMvatMb6kYfg==
From: Niklas Cassel <cassel@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>
Cc: Damien Le Moal <dlemoal@kernel.org>,
	linux-pci@vger.kernel.org,
	Frank Li <Frank.Li@nxp.com>,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH 1/2] PCI: endpoint: pci-epf-test: Add support for capabilities
Date: Wed, 20 Nov 2024 16:57:32 +0100
Message-ID: <20241120155730.2833836-5-cassel@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241120155730.2833836-4-cassel@kernel.org>
References: <20241120155730.2833836-4-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2056; i=cassel@kernel.org; h=from:subject; bh=4CRDnwDGmlemh5GmK8CvV/Hyvt/wr3PKJNOwBChRGqY=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGNLt2F69yCq4KMZ0SH79hcxnIa2P9eM3v8teZ1nbNjc8R FunWDO4o5SFQYyLQVZMkcX3h8v+4m73KccV79jAzGFlAhnCwMUpABPxrGH4H7vpDuOtyzqr90SJ WepI2r2wWLTpYQu/XOaF1Q90zEpWbmf4H7V5W+kP4WB7hV8Wmb/Tb5fc0l7/51j/UzH/GVFbowN j+AA=
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

The test BAR is allocated using pci_epf_alloc_space(), which allocates the
backing memory using dma_alloc_coherent(), which will return zeroed memory
regardless of __GFP_ZERO was set or not.

This means that running a new version of pci-endpoint-test.c (host side)
with and old version of pci-epf-test.c (EP side) will not see any
capabilities being set (as intended), so this is backwards compatible.

For now, only add the CAP_HAS_ALIGN_ADDR capability.

Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/pci/endpoint/functions/pci-epf-test.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
index ef6677f34116..e3a74a6fcb24 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -44,6 +44,8 @@
 
 #define TIMER_RESOLUTION		1
 
+#define CAP_HAS_ALIGN_ADDR		BIT(0)
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
+		caps |= CAP_HAS_ALIGN_ADDR;
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


