Return-Path: <linux-pci+bounces-19457-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF762A0490F
	for <lists+linux-pci@lfdr.de>; Tue,  7 Jan 2025 19:15:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 93F787A27E4
	for <lists+linux-pci@lfdr.de>; Tue,  7 Jan 2025 18:15:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97C021EE006;
	Tue,  7 Jan 2025 18:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iGMENbX0"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C4CC1EE7DC
	for <linux-pci@vger.kernel.org>; Tue,  7 Jan 2025 18:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736273736; cv=none; b=Ai2YDsx6QWFLpZh+Na4GZ2Q44WNRThCa6ZXoP0djgw7sVsYwAjV7tSVAlX59jR0ip7wsKxHYa2EyN7A+iKqCt6pIncfGJBNKtZ5Yd1qMSIyhGcInPbMtL6suHyB8SCB/75YMGoX44bA8UKvCdyfiQVzAkneoHK8t617BuZSgeWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736273736; c=relaxed/simple;
	bh=dsOF55gCBp2ClK+Wep4E7OIkJHnlYk6Yk3WYdTKco9M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d0DwtkDaw4n35ac1hykTPbG9ZEDckiVqi37Y57vvSB9sofrYsEPaUynySj9AeefUd4GwEt9pkHr9jRsGlkzry/vZY1tLiIy1uvAHZxJGa84frNfmJHphOHXLTNflWL62RNLcdIAmlzwOlT94TZfgkaE8Oj7Sfb+mixmuBho4pmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iGMENbX0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3137C4CED6;
	Tue,  7 Jan 2025 18:15:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736273735;
	bh=dsOF55gCBp2ClK+Wep4E7OIkJHnlYk6Yk3WYdTKco9M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iGMENbX00OTG117OYdUb4LUcy4QZLKAtGLne35SwHpPBgvhZHx+VryWSrzoug/xtO
	 t6hkSIddx+UbaNk97jf+N0N5P3o5zMuISXpkPPTK4NdscqdTHZBqB/K/WGB1fpFW5Z
	 MYdyjpE91/+hfwFSW7s8bu6CB38jsIXud2y/lhz44APCWRsm6RouiLiN3a3ZtGgT2o
	 3DEpQw0OjdW4oiWE0kMrGLAAlqaSbN8Dz4p6FYvhILDeSKuSgc1DNADVj8bkr4EgGj
	 ar7hIH178SrRoJzxFN5oax0vHrSxtYQDVidg2zfJ8OoPYeRlOn8WU4BKLZ5LeARRM+
	 jJJZGzoXqGhVQ==
From: Niklas Cassel <cassel@kernel.org>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	linux-pci@vger.kernel.org
Subject: [PATCH 4/6] PCI: keystone: Describe resizable BARs as resizable BARs
Date: Tue,  7 Jan 2025 19:14:54 +0100
Message-ID: <20250107181450.3182430-12-cassel@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250107181450.3182430-8-cassel@kernel.org>
References: <20250107181450.3182430-8-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1286; i=cassel@kernel.org; h=from:subject; bh=dsOF55gCBp2ClK+Wep4E7OIkJHnlYk6Yk3WYdTKco9M=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGNJr8xXePDm5TOZYxOzbsyPOemkZvyi8vOKmveAtCf+TB 3WvGOpd6ChlYRDjYpAVU2Tx/eGyv7jbfcpxxTs2MHNYmUCGMHBxCsBEFFYwMqxbWXFFZ86MdQ2K TKdsP7au7bb/G1dyem9666y5jJFP1q9mZNidWnrO+zJTZqXiXkM3kwmxzbo+xbc339+6bpVPifL qPVwA
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

Looking at "12.2.2.4.15 PCIe Subsystem BAR Configuration" in the
AM65x TRM:
https://www.ti.com/lit/ug/spruid7e/spruid7e.pdf

We can see that BAR2 and BAR5 are not Fixed BARs, but actually Resizable
BARs.

Now when we actually have support for Resizable BARs, let's configure
these BARs as such.

Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/pci/controller/dwc/pci-keystone.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
index 63bd5003da45..fdc610ec7e5e 100644
--- a/drivers/pci/controller/dwc/pci-keystone.c
+++ b/drivers/pci/controller/dwc/pci-keystone.c
@@ -966,10 +966,10 @@ static const struct pci_epc_features ks_pcie_am654_epc_features = {
 	.msix_capable = true,
 	.bar[BAR_0] = { .type = BAR_RESERVED, },
 	.bar[BAR_1] = { .type = BAR_RESERVED, },
-	.bar[BAR_2] = { .type = BAR_FIXED, .fixed_size = SZ_1M, },
+	.bar[BAR_2] = { .type = BAR_RESIZABLE, },
 	.bar[BAR_3] = { .type = BAR_FIXED, .fixed_size = SZ_64K, },
 	.bar[BAR_4] = { .type = BAR_FIXED, .fixed_size = 256, },
-	.bar[BAR_5] = { .type = BAR_FIXED, .fixed_size = SZ_1M, },
+	.bar[BAR_5] = { .type = BAR_RESIZABLE, },
 	.align = SZ_1M,
 };
 
-- 
2.47.1


