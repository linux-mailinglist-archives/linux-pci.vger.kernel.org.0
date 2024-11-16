Return-Path: <linux-pci+bounces-16982-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2A729CFFE2
	for <lists+linux-pci@lfdr.de>; Sat, 16 Nov 2024 17:36:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00CF4282E8D
	for <lists+linux-pci@lfdr.de>; Sat, 16 Nov 2024 16:36:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9CBAF9CB;
	Sat, 16 Nov 2024 16:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WdE3iNrQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A530418A6D5
	for <linux-pci@vger.kernel.org>; Sat, 16 Nov 2024 16:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731774981; cv=none; b=EFBkjPb4yRuWS5RpKB3xDSFW4M+hd7Uo6Om4B13aecJ7zz+4febtOJTt4b0lg+9GrRnw8D+w/CxahzIyd/Ph0VOAsvMY2uCmmtzJ0wUT/azgcZN0eplQJ7wQc4dp0+/r1cLSrQQ0iF8gTkxGDW/Bxg9Q272si82bFtB0NFLwQmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731774981; c=relaxed/simple;
	bh=SlN/xkv2h1nTy/SSDUnI5IQ0q1BJajoSiTu2IIeDb/0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CmWGb124xTKiXIIKC0hSwaVeEi3L21J7WXFbWgI7jVeXZlMS6UrBCmkqWr/xMLP9UY0Yd+kDkUxmzy2TE/vcYiO1qFmIosx0SFK4fO3Q36z2XU1idYkQZWnjJj51WCePk8guA/WCrvHreORZzq2LZhRXpL4SOBzQb6BQmynGFVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WdE3iNrQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5106FC4CED2;
	Sat, 16 Nov 2024 16:36:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731774981;
	bh=SlN/xkv2h1nTy/SSDUnI5IQ0q1BJajoSiTu2IIeDb/0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WdE3iNrQ+vM2W/Xqcw83oSM6b7gF6lPE5p2noisBhBgBbpFr2iQI4/x0j9lpZ/Aw9
	 pw8ySjDk6XNzKn93sJWxAXC/N6QaAOQHVYMtVPh+qCO7GMoXoyOGzYg9RK3bkQ3cgW
	 g9mZUviB1z9pZC4xeTTUsIW1Izm2RBBxw1o/RxMkQUXtrFWIESG39M6EUrPR1c8Lxc
	 NLX98BjnWKhHpPjN7EgYoA+6zCIoe7EiXg6PNqSDHtIQbBdwVjYMya3WLQUW5GHyXI
	 cUgiu2RCRqFuqUO9TYAXcj/CGrxH2G290vYV/nffPqhAJkXG3kUHPGyZqeTkkpuDC3
	 6anGup7P6CbBg==
From: Niklas Cassel <cassel@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Frank Li <Frank.Li@nxp.com>,
	Jesper Nilsson <jesper.nilsson@axis.com>,
	Niklas Cassel <cassel@kernel.org>,
	linux-pci@vger.kernel.org
Subject: [PATCH v3 2/4] PCI: endpoint: Add size check for fixed size BARs in pci_epc_set_bar()
Date: Sat, 16 Nov 2024 17:36:01 +0100
Message-ID: <20241116163558.2606874-8-cassel@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241116163558.2606874-6-cassel@kernel.org>
References: <20241116163558.2606874-6-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1826; i=cassel@kernel.org; h=from:subject; bh=SlN/xkv2h1nTy/SSDUnI5IQ0q1BJajoSiTu2IIeDb/0=; b=kA0DAAoWyWQxo5nGTXIByyZiAGc4yfShPVIdOid5GHu/GV/jqvrdHKpCjmasbS3a1Uu/s76wz oh1BAAWCgAdFiEETfhEv3OLR5THIdw8yWQxo5nGTXIFAmc4yfQACgkQyWQxo5nGTXJ8KQD+Lrlp oeqXC9XZpGvtwOrfEHzSViNQlmn1dn5L7JBs00IA/iYad3U/7IAUt4wtTUHh20Pwb92hpLuI1Gl H9EkoHHcJ
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

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

Signed-off-by: Niklas Cassel <cassel@kernel.org>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
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
2.47.0


