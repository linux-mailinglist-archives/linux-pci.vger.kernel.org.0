Return-Path: <linux-pci+bounces-19592-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DADFA070DE
	for <lists+linux-pci@lfdr.de>; Thu,  9 Jan 2025 10:07:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94B6E3A2FB4
	for <lists+linux-pci@lfdr.de>; Thu,  9 Jan 2025 09:07:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C47B204C0E;
	Thu,  9 Jan 2025 09:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GmvQ8RTu"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48574204089
	for <linux-pci@vger.kernel.org>; Thu,  9 Jan 2025 09:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736413633; cv=none; b=cwU4cNmw2+5kVEfiYzAf4RDDv9a/obuwhsuev//2l2Eo3TRlfrZwrRAI6OIwwtCMQlr3cK6b1IS9foIqGwAAwwTVLuISbgZVDfr9hR4IRfvircpEci2tDd6j1EfnIuJ4mADhvD231pDS7Ybk5s3tVP3ADHlJcwcbwp6J7uV0Vw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736413633; c=relaxed/simple;
	bh=fH/+PtW6Al/BgLEY0tVX9tkQABLvNtrARmIww7kOrA0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m/4pT7GZPE5ZppR6yD+uE255txjIeU/l4FLDmEWF+BVDCfMhdfFWqFSle2quupoCisLCPQVRCkdFal7lLuYAXt34hrPSBzRI99hkgamn+WNlbACnABosbmb9zfgQZq4D10sixTn1L3G3eFmRtHS9ZC7PQlfKaRxwjgFL33oX7Zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GmvQ8RTu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35F08C4CED2;
	Thu,  9 Jan 2025 09:07:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736413632;
	bh=fH/+PtW6Al/BgLEY0tVX9tkQABLvNtrARmIww7kOrA0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GmvQ8RTuwYo9O7BH14/xi+qUJ+oydkzX4DHh9cBYeCTrgTvjQKAue4rC1oh3ZxEPF
	 pftqBA0/ydmu7hkhqlABl6DHFBjgxoXZ+Hk+2T/apydUCruVgIM2H6kinCHxaePqSq
	 9HjYmvKmMMzmpI62gGg/++Pi3TmGmbI+D8Jw8trZdyKAHt5DoNDVaFs2eLnSlUn/JU
	 I7K2x+k0sn4f5Hj8EYjO1RmplUpT+HuUS+VK/vOKEIr7TS70qNSto/Aiwk97ba1ZtJ
	 Mtzx5whiY9t8SH4XBWVJ849LHicYVqS8ynPX/z6j++4y4777SikKph+pmZFYg55Xnh
	 Ov6OZ6j3Dt8LQ==
From: Niklas Cassel <cassel@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	linux-pci@vger.kernel.org
Subject: [PATCH v2 1/6] PCI: endpoint: Add BAR type BAR_RESIZABLE
Date: Thu,  9 Jan 2025 10:06:53 +0100
Message-ID: <20250109090652.110905-9-cassel@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250109090652.110905-8-cassel@kernel.org>
References: <20250109090652.110905-8-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3008; i=cassel@kernel.org; h=from:subject; bh=fH/+PtW6Al/BgLEY0tVX9tkQABLvNtrARmIww7kOrA0=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGNLrJ27cMifhZ7BqcrzDIr130y5+K3f0mdtyuuuo9qPZa 81eVDVO6ShlYRDjYpAVU2Tx/eGyv7jbfcpxxTs2MHNYmUCGMHBxCsBEVrxi+MW09t6Xp7mPnzEc ncq4e78p35KvO2xNVy8vLFt0L+uym81lhn9WifdPb0/Oy+kRCplmmV0c/351CnNaf6KZ2Nq6hS1 PPnMCAA==
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

With these changes, an EPC driver will be able to support resizable BARs
(we intentionally only support a single supported resizable BAR size).

Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/pci/endpoint/pci-epf-core.c | 4 ++++
 include/linux/pci-epc.h             | 3 +++
 2 files changed, 7 insertions(+)

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
index e818e3fdcded..e9d5ed23914f 100644
--- a/include/linux/pci-epc.h
+++ b/include/linux/pci-epc.h
@@ -188,11 +188,14 @@ struct pci_epc {
  * enum pci_epc_bar_type - configurability of endpoint BAR
  * @BAR_PROGRAMMABLE: The BAR mask can be configured by the EPC.
  * @BAR_FIXED: The BAR mask is fixed by the hardware.
+ * @BAR_RESIZABLE: The BAR implements the PCI-SIG Resizable BAR Capability.
+ *                 An EPC driver can currently only set a single supported size.
  * @BAR_RESERVED: The BAR should not be touched by an EPF driver.
  */
 enum pci_epc_bar_type {
 	BAR_PROGRAMMABLE = 0,
 	BAR_FIXED,
+	BAR_RESIZABLE,
 	BAR_RESERVED,
 };
 
-- 
2.47.1


