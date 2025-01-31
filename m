Return-Path: <linux-pci+bounces-20603-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A6C1EA24294
	for <lists+linux-pci@lfdr.de>; Fri, 31 Jan 2025 19:30:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27838167037
	for <lists+linux-pci@lfdr.de>; Fri, 31 Jan 2025 18:30:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF7E215F330;
	Fri, 31 Jan 2025 18:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZOoO1/Ie"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89E337081F
	for <linux-pci@vger.kernel.org>; Fri, 31 Jan 2025 18:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738348221; cv=none; b=bbEEDwQjNTtdI423LWgFqUs/5D3aNxwsgkCr8Jjr8UzRImdYwssek3Z25O8y6GJ9CL6/dVWPqmgGqxeenMVNON+o5XrWV8gEDWTwOcs0tFdG2bp9e/Dccgl0rtm+0sxmLAao3iL4k9VU9+BmrHLznlIseBB9WrdLeBkPZnHmWl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738348221; c=relaxed/simple;
	bh=E0Rq0Qg/tPg5NuSXgKHce8fejwLFHu6o0/X5AcGaq2g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=blzbOH+rygEniIG8alRMBmFNexDl9QP960slU5zGAFG+9skjnz6E5dKcfPM2IiWJbbiu6Ufxf1rs65ZgS/Vk4UouZIa1Wr5sPzv414FknTxRrekN7OatC09UwrJcW/2UkGMCOyJbbc2Djgn3VVHYr6pALwkVEZQyZ9GNd7bVdQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZOoO1/Ie; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2DACC4CED1;
	Fri, 31 Jan 2025 18:30:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738348221;
	bh=E0Rq0Qg/tPg5NuSXgKHce8fejwLFHu6o0/X5AcGaq2g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZOoO1/IeCLaT3T0JopN75kMlYwH4y1w6BBCtp/0avF08AY3L2CKP/sTzxypmaOhRH
	 ZGbnx6sPHd+5w8usUDUw1t9MdPsSl0OoxOnlzQKDWSH4Bl/HUI/S/twHZ/ViX6ZpJw
	 jsMO606mD3cwO2VuvdG4JV72hwS6PkwMycihgSi2YJKr3bgZwg9gXVywBd1ZVA9eqG
	 EIl0EH9FMWEmCsoEex/SvrMqEFCXkvpCTqpEK0SXzRjNVyVGLGuHZjiROWHHGU+6m6
	 qQAk5g9VZYlDRgwd5pmb5/hSGuNCYZcF4qHRhrTyLJEHBTzs7yBYs8hLFjlP/qzKta
	 hysAs/SuiiQ4g==
From: Niklas Cassel <cassel@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Udit Kumar <u-kumar1@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Niklas Cassel <cassel@kernel.org>,
	linux-pci@vger.kernel.org
Subject: [PATCH v4 1/7] PCI: endpoint: Allow EPF drivers to configure the size of Resizable BARs
Date: Fri, 31 Jan 2025 19:29:50 +0100
Message-ID: <20250131182949.465530-10-cassel@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250131182949.465530-9-cassel@kernel.org>
References: <20250131182949.465530-9-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3672; i=cassel@kernel.org; h=from:subject; bh=E0Rq0Qg/tPg5NuSXgKHce8fejwLFHu6o0/X5AcGaq2g=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGNLniq1K5b6zPbO5o/0z44ZVCToF56aqOhRyJl/dFNATv rWma19ZRykLgxgXg6yYIovvD5f9xd3uU44r3rGBmcPKBDKEgYtTACbSaM7wv1Rl3qL2rif8nzu6 zMKZcvPWyQTEuC262L99pxtL+quH9Qz/M/fdOvFxdn/951V+n3kvL5C9oLxqYop/oNY3YbsA3v7 1bAA=
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

A resizable BAR is different from a normal BAR in a few ways:
-The minimum size of a resizable BAR is 1 MB.
-Each BAR that is resizable has a Capability and Control register in the
 Resizable BAR Capability structure.

These registers contain the supported sizes and the currently selected
size of a resizable BAR.

The supported sizes is a bitmap of the supported sizes. The selected size
is a single value that is equal to one of the supported sizes.

A resizable BAR thus has to be configured differently than a
BAR_PROGRAMMABLE BAR, which usually sets the BAR size/mask in a vendor
specific way.

The PCI endpoint framework currently does not support resizable BARs.

Add a BAR type BAR_RESIZABLE, so that an EPC driver can support resizable
BARs properly.

Note that the pci_epc_set_bar() API takes a struct pci_epf_bar which tells
the EPC driver how it wants to configure the BAR.

struct pci_epf_bar only has a single size struct member.

This means that an EPC driver will only be able to set a single supported
size. This is perfectly fine, as we do not need the complexity of allowing
a host to change the size of the BAR. If someone ever wants to support
resizing a resizable BAR, the pci_epc_set_bar() API can be extended in the
future.

With these changes, we allow an EPF driver to configure the size of
Resizable BARs, rather than forcing them to a 1 MB size.

Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/pci/endpoint/pci-epc-core.c | 4 ++++
 drivers/pci/endpoint/pci-epf-core.c | 4 ++++
 include/linux/pci-epc.h             | 4 ++++
 3 files changed, 12 insertions(+)

diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
index 9e9ca5f8e8f8..10dfc716328e 100644
--- a/drivers/pci/endpoint/pci-epc-core.c
+++ b/drivers/pci/endpoint/pci-epc-core.c
@@ -609,6 +609,10 @@ int pci_epc_set_bar(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 	if (!epc_features)
 		return -EINVAL;
 
+	if (epc_features->bar[bar].type == BAR_RESIZABLE &&
+	    (epf_bar->size < SZ_1M || (u64)epf_bar->size > (SZ_128G * 1024)))
+		return -EINVAL;
+
 	if (epc_features->bar[bar].type == BAR_FIXED &&
 	    (epc_features->bar[bar].fixed_size != epf_bar->size))
 		return -EINVAL;
diff --git a/drivers/pci/endpoint/pci-epf-core.c b/drivers/pci/endpoint/pci-epf-core.c
index 50bc2892a36c..394395c7f8de 100644
--- a/drivers/pci/endpoint/pci-epf-core.c
+++ b/drivers/pci/endpoint/pci-epf-core.c
@@ -274,6 +274,10 @@ void *pci_epf_alloc_space(struct pci_epf *epf, size_t size, enum pci_barno bar,
 	if (size < 128)
 		size = 128;
 
+	/* According to PCIe base spec, min size for a resizable BAR is 1 MB. */
+	if (epc_features->bar[bar].type == BAR_RESIZABLE && size < SZ_1M)
+		size = SZ_1M;
+
 	if (epc_features->bar[bar].type == BAR_FIXED && bar_fixed_size) {
 		if (size > bar_fixed_size) {
 			dev_err(&epf->dev,
diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
index e818e3fdcded..91ce39dc0fd4 100644
--- a/include/linux/pci-epc.h
+++ b/include/linux/pci-epc.h
@@ -188,11 +188,15 @@ struct pci_epc {
  * enum pci_epc_bar_type - configurability of endpoint BAR
  * @BAR_PROGRAMMABLE: The BAR mask can be configured by the EPC.
  * @BAR_FIXED: The BAR mask is fixed by the hardware.
+ * @BAR_RESIZABLE: The BAR implements the PCI-SIG Resizable BAR Capability.
+ *		   NOTE: An EPC driver can currently only set a single supported
+ *		   size.
  * @BAR_RESERVED: The BAR should not be touched by an EPF driver.
  */
 enum pci_epc_bar_type {
 	BAR_PROGRAMMABLE = 0,
 	BAR_FIXED,
+	BAR_RESIZABLE,
 	BAR_RESERVED,
 };
 
-- 
2.48.1


