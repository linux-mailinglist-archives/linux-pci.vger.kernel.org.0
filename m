Return-Path: <linux-pci+bounces-27617-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F8F6AB4CC2
	for <lists+linux-pci@lfdr.de>; Tue, 13 May 2025 09:31:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6A7919E703C
	for <lists+linux-pci@lfdr.de>; Tue, 13 May 2025 07:31:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFB331DE2BC;
	Tue, 13 May 2025 07:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nObXVbjH"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0C743FBA7
	for <linux-pci@vger.kernel.org>; Tue, 13 May 2025 07:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747121489; cv=none; b=seWvYnfPERmvEAJiVxAdgPW/iTO99Lh0uLgBRVoqyfkhXhg4aO7Jr2x0iZ8ZyP8V16qrDAlRajUnOSvrI0oa00Sb0r5ydSROmqIzu1Jclv+jasaw8fvVys+XLUkNqGUkHZBcFosbWbcKn6GEH/af3Y5y+89Yj01oYCyEQ2xbX7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747121489; c=relaxed/simple;
	bh=4WkEcz0wUkvMSJ5icugGjJbdn2Os+FQPTScLRPNCi5A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jUTn5WY0bqgMjdKV9eOMSbMeiLVB96zv2XkRpVYsG5vL7YvJmmbX7SPXpB3KNS/b58HiEL90UKsGJG40xDk1Z6VxGSpD8hgnHfLhGwjiAamG7xXTSyM/NPBfONDTGsOLi9Hyom4Cf3t6T80YsjjWC930MoY5ig8rCWUBE79B42o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nObXVbjH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA5E6C4CEE4;
	Tue, 13 May 2025 07:31:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747121489;
	bh=4WkEcz0wUkvMSJ5icugGjJbdn2Os+FQPTScLRPNCi5A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nObXVbjHqVzi2qdMFzDZ/5bpyihjduTWXYmR6CU2jrlL581uGoay9PsPV8l11E4Gh
	 7YGklmk/rJKART86vozVNqtj8kpXb98l84thk8Xvek/mYwylOYK9+2JPFTVj1r2Z6s
	 AJaVCPviiwBUhZM96DG+gq7nj+2itIVSUUJxVruJYBSH6DvVdnG6PzSQOSjoBSAuIm
	 0YvE1OH1nSv4hTqlqF4Kk1kpZEnP4yXZ6T0vHkxcIWDuDgB5h8abKTO0LvdHBldN7c
	 590G+Zc7otelBEQmw4TnT9eyvEgV0ML1soBaQyAoDhtJYM8f6x6NhNmWxJ4UqfxUZV
	 klrtr+Q1SYOkQ==
From: Niklas Cassel <cassel@kernel.org>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>
Cc: Wilfred Mallawa <wilfred.mallawa@wdc.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	stable+noautosel@kernel.org,
	linux-pci@vger.kernel.org
Subject: [PATCH v2 5/6] PCI: endpoint: cleanup get_msix() callback
Date: Tue, 13 May 2025 09:31:00 +0200
Message-ID: <20250513073055.169486-13-cassel@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250513073055.169486-8-cassel@kernel.org>
References: <20250513073055.169486-8-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2586; i=cassel@kernel.org; h=from:subject; bh=4WkEcz0wUkvMSJ5icugGjJbdn2Os+FQPTScLRPNCi5A=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGDKUvhrNXcmX25EdK1Uxb5at1Oo74XcKrX3NT37/8eD0K ybmo7VRHaUsDGJcDLJiiiy+P1z2F3e7TzmueMcGZg4rE8gQBi5OAZgIuwLDP2Pxz9Fy6ez86rvS +Lo29zT3J81VXdOttufQiduxi8VjlzP8d9yqyNMuM4Eh1Hn5rwK5nEmP+3jqN9qceXWj6p/ztex ABgA=
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

The kdoc for pci_epc_get_msix() says:
"Invoke to get the number of MSI-X interrupts allocated by the RC"
the kdoc for the callback pci_epc_ops->get_msix() says:
"ops to get the number of MSI-X interrupts allocated by the RC from the
MSI-X capability register"

pci_epc_ops->get_msix() does however return the number of interrupts
in the encoding as defined by the Table Size field.

Nowhere in the kdoc does it say that the returned number of interrupts
is in Table Size encoding.

Thus, it is very confusing that the wrapper function (pci_epc_get_msix())
and the callback function (pci_epc_ops->get_msix()) don't return the same
value.

Cleanup the API so that the wrapper function and the callback function
will have the same semantics.

Cc: <stable+noautosel@kernel.org> # this is simply a cleanup
Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/pci/controller/cadence/pcie-cadence-ep.c | 2 +-
 drivers/pci/controller/dwc/pcie-designware-ep.c  | 2 +-
 drivers/pci/endpoint/pci-epc-core.c              | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/cadence/pcie-cadence-ep.c b/drivers/pci/controller/cadence/pcie-cadence-ep.c
index f307256826e6..bbb310135977 100644
--- a/drivers/pci/controller/cadence/pcie-cadence-ep.c
+++ b/drivers/pci/controller/cadence/pcie-cadence-ep.c
@@ -283,7 +283,7 @@ static int cdns_pcie_ep_get_msix(struct pci_epc *epc, u8 func_no, u8 vfunc_no)
 
 	val &= PCI_MSIX_FLAGS_QSIZE;
 
-	return val;
+	return val + 1;
 }
 
 static int cdns_pcie_ep_set_msix(struct pci_epc *epc, u8 fn, u8 vfn,
diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index e7a916bf6b2c..d74d21c42559 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -576,7 +576,7 @@ static int dw_pcie_ep_get_msix(struct pci_epc *epc, u8 func_no, u8 vfunc_no)
 
 	val &= PCI_MSIX_FLAGS_QSIZE;
 
-	return val;
+	return val + 1;
 }
 
 static int dw_pcie_ep_set_msix(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
index cc012373293a..7b4a9292f801 100644
--- a/drivers/pci/endpoint/pci-epc-core.c
+++ b/drivers/pci/endpoint/pci-epc-core.c
@@ -352,7 +352,7 @@ int pci_epc_get_msix(struct pci_epc *epc, u8 func_no, u8 vfunc_no)
 	if (interrupt < 0)
 		return 0;
 
-	return interrupt + 1;
+	return interrupt;
 }
 EXPORT_SYMBOL_GPL(pci_epc_get_msix);
 
-- 
2.49.0


