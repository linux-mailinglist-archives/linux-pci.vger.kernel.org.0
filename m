Return-Path: <linux-pci+bounces-4955-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 333688810FD
	for <lists+linux-pci@lfdr.de>; Wed, 20 Mar 2024 12:32:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CCEFBB21C1F
	for <lists+linux-pci@lfdr.de>; Wed, 20 Mar 2024 11:32:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 371773D57A;
	Wed, 20 Mar 2024 11:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cicb0NJw"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 135303D566
	for <linux-pci@vger.kernel.org>; Wed, 20 Mar 2024 11:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710934338; cv=none; b=BYDKNic7vZ0NjMkPz0KYES2cskMT9UaD0jcPECWXgDCS6vJjEayPSN/aklU7m5SLIuM/oVr2dHAg0oD0C2R9i0CLKx82TzdJIrPQgd5nfo6cvyee3xaDcZuSbEV+LBMOWWshJE8nkK4SHTjsKVJHZIit/wVckvvSdRKBGQgDTNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710934338; c=relaxed/simple;
	bh=X8GTmTOMsGGtNaPPdmCyGMfJX9TsguvdNZ5uoAo8URU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z/YlJvd33gDCMIuSOjKWcK/xjVKzefsUYEVql4bch5w+wlbvDL/Ed1gwjj36o9tyeTv3rz+ZAKQk6M1aiCdeJDc66u3RFEDlpUebpXaD67osLIhsyTRfk3XCjCd92KXUFEamssOtWVM1E90mwWBmlUDN/LByvmSO6w3CBo9UOJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cicb0NJw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98702C433B1;
	Wed, 20 Mar 2024 11:32:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710934337;
	bh=X8GTmTOMsGGtNaPPdmCyGMfJX9TsguvdNZ5uoAo8URU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Cicb0NJwc15vbAu46x+unI6Qbshkd0oKe6E39mbJbiI1FIAZvh+f3VfougjSUOvRK
	 fgRJI/QRnKu60fUVM4HY6fPEANj5KZ1TQHhBOlkfh+0chc9VJtVjzHXJzLpkQ/Ttok
	 VmCCxWEHVnmO9lDM9WvQ3tZXm1v2dABfFm6Jc3IM7M/JAoVl4pYD/b2cM1d9R02SmR
	 YVyyxJ7xuu0J1wLeVgI9zH4NWm/AQLWtp53hgLkkjQgvOyYCkKKwug/m6JhlMS2ep9
	 VRhz0CPruG+1dTJIn0kFZDEVgzSnXZLcuivUSfMk7zQlv2JLpdWKJSfJPHLEAxun+w
	 /VS3b2L7Ck55Q==
From: Niklas Cassel <cassel@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: Shradha Todi <shradha.t@samsung.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	linux-pci@vger.kernel.org
Subject: [PATCH v4 2/7] PCI: endpoint: Allocate a 64-bit BAR if that is the only option
Date: Wed, 20 Mar 2024 12:31:49 +0100
Message-ID: <20240320113157.322695-3-cassel@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240320113157.322695-1-cassel@kernel.org>
References: <20240320113157.322695-1-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pci_epf_alloc_space() already sets the 64-bit flag if the BAR size is
larger than 2GB, even if the caller did not explicitly request a 64-bit
BAR.

Thus, let pci_epf_alloc_space() also set the 64-bit flag if the hardware
description says that the specific BAR can only be 64-bit.

Signed-off-by: Niklas Cassel <cassel@kernel.org>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/endpoint/pci-epf-core.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/endpoint/pci-epf-core.c b/drivers/pci/endpoint/pci-epf-core.c
index 0a28a0b0911b..323f2a60ab16 100644
--- a/drivers/pci/endpoint/pci-epf-core.c
+++ b/drivers/pci/endpoint/pci-epf-core.c
@@ -255,6 +255,8 @@ EXPORT_SYMBOL_GPL(pci_epf_free_space);
  * @type: Identifies if the allocation is for primary EPC or secondary EPC
  *
  * Invoke to allocate memory for the PCI EPF register space.
+ * Flag PCI_BASE_ADDRESS_MEM_TYPE_64 will automatically get set if the BAR
+ * can only be a 64-bit BAR, or if the requested size is larger than 2 GB.
  */
 void *pci_epf_alloc_space(struct pci_epf *epf, size_t size, enum pci_barno bar,
 			  const struct pci_epc_features *epc_features,
@@ -304,9 +306,10 @@ void *pci_epf_alloc_space(struct pci_epf *epf, size_t size, enum pci_barno bar,
 	epf_bar[bar].addr = space;
 	epf_bar[bar].size = size;
 	epf_bar[bar].barno = bar;
-	epf_bar[bar].flags |= upper_32_bits(size) ?
-				PCI_BASE_ADDRESS_MEM_TYPE_64 :
-				PCI_BASE_ADDRESS_MEM_TYPE_32;
+	if (upper_32_bits(size) || epc_features->bar[bar].only_64bit)
+		epf_bar[bar].flags |= PCI_BASE_ADDRESS_MEM_TYPE_64;
+	else
+		epf_bar[bar].flags |= PCI_BASE_ADDRESS_MEM_TYPE_32;
 
 	return space;
 }
-- 
2.44.0


