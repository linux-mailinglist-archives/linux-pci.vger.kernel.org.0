Return-Path: <linux-pci+bounces-18378-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B9AFC9F0F2A
	for <lists+linux-pci@lfdr.de>; Fri, 13 Dec 2024 15:33:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7959F282438
	for <lists+linux-pci@lfdr.de>; Fri, 13 Dec 2024 14:33:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F62C1E1C1F;
	Fri, 13 Dec 2024 14:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LJE3ZyhX"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBC0E1E1C0F;
	Fri, 13 Dec 2024 14:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734100410; cv=none; b=BlNTFH0osdgr4D7OygfVxC2U2JywZERXc7GP7FYPNEWw77RKIGc9UWF1gubmNKlCL3cry+bNtSDDSlG9rlqMFh2y3sl1NZVeBOgfm5n7fQclBteH+VD2eXjywXmVlZrr93JWqupybjp1SXATrJ0mxw5cTacYlU2+qWvIg6NS6Zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734100410; c=relaxed/simple;
	bh=hf3uPTsI8CFcJFUPNdC68/VsTO/Oc1Od5Tl6oCQzNgs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UwJ5oDkfZQ01PFHgcO+McCfrNK3YcZU+RgszfCqIoaWcPedLuPkSbNHaofRNOgxUmVyTlvqOKOJp48XfjwGsXjLeo6oZFuSQ75gXmVdQzpTvSVsZ9szF7MNOBJ8e8RSFBVleNp3ts+z+yD/PchbusflyhAPJBlxskab/WScX19A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LJE3ZyhX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CF6EC4CED0;
	Fri, 13 Dec 2024 14:33:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734100409;
	bh=hf3uPTsI8CFcJFUPNdC68/VsTO/Oc1Od5Tl6oCQzNgs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LJE3ZyhXqbMTrh21qkf7fSIuuCt5O7ZVy8jshQSMR/9B6neJf9pkYw82a+P00jcOH
	 Xus4Nliq82zT2tKTSj+5kDK0HsZqfvfgWfLQOBWFDWufrYTH1nJYJjjDw65IOhg9kB
	 upcloYBvfpYixjZZMPGH9/43q2D3dd6YkIb67HYM4lVZA5u972qRD4p6KBbGDMWIc7
	 BbW0J+5P5LnTRZx/mFssov+bMAu1fpYFkr8o3vVDR3PfxmlDokNZw/sZQKET8vkG/U
	 t+qWYEob1DQ73uw5xNJ0WaJJSG2L6mz4od3JV6oBvjhdThsgtdTQztN3WYZKA/MtwW
	 uAaIWP2QDp8/Q==
From: Niklas Cassel <cassel@kernel.org>
To: Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Frank Li <Frank.Li@nxp.com>,
	Jesper Nilsson <jesper.nilsson@axis.com>,
	Niklas Cassel <cassel@kernel.org>,
	stable@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: [PATCH v6 1/6] PCI: dwc: ep: Write BAR_MASK before iATU registers in pci_epc_set_bar()
Date: Fri, 13 Dec 2024 15:33:02 +0100
Message-ID: <20241213143301.4158431-9-cassel@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241213143301.4158431-8-cassel@kernel.org>
References: <20241213143301.4158431-8-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2752; i=cassel@kernel.org; h=from:subject; bh=hf3uPTsI8CFcJFUPNdC68/VsTO/Oc1Od5Tl6oCQzNgs=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGNJjXBct6Wbb8SJTfM7maG5177wXy+Ijz1/lea/tmb8s1 urys8rqjlIWBjEuBlkxRRbfHy77i7vdpxxXvGMDM4eVCWQIAxenAExEeiYjw0veA68dfAJV7388 eTt6f4iRvel6rz/XLoqf6WKduCPI3ZzhD5dw2jHmaz9nP/LgdLtu9/LFTwatySv6/otNdV13NXB jBhsA
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

The "DesignWare Cores PCI Express Controller Register Descriptions,
Version 4.60a", section "1.21.70 IATU_LWR_TARGET_ADDR_OFF_INBOUND_i",
fields LWR_TARGET_RW and LWR_TARGET_HW both state that:
"Field size depends on log2(BAR_MASK+1) in BAR match mode."

I.e. only the upper bits are writable, and the number of writable bits is
dependent on the configured BAR_MASK.

If we do not write the BAR_MASK before writing the iATU registers, we are
relying the reset value of the BAR_MASK being larger than the requested
BAR size (which is supplied in the struct pci_epf_bar which is passed to
pci_epc_set_bar()). The reset value of the BAR_MASK is SoC dependent.

Thus, if the struct pci_epf_bar requests a BAR size that is larger than the
reset value of the BAR_MASK, the iATU will try to write to read-only bits,
which will cause the iATU to end up redirecting to a physical address that
is different from the address that was intended.

Thus, we should always write the iATU registers after writing the BAR_MASK.

Cc: stable@vger.kernel.org
Fixes: f8aed6ec624f ("PCI: dwc: designware: Add EP mode support")
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 .../pci/controller/dwc/pcie-designware-ep.c   | 28 ++++++++++---------
 1 file changed, 15 insertions(+), 13 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index f3ac7d46a855..bad588ef69a4 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -222,19 +222,10 @@ static int dw_pcie_ep_set_bar(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 	if ((flags & PCI_BASE_ADDRESS_MEM_TYPE_64) && (bar & 1))
 		return -EINVAL;
 
-	reg = PCI_BASE_ADDRESS_0 + (4 * bar);
-
-	if (!(flags & PCI_BASE_ADDRESS_SPACE))
-		type = PCIE_ATU_TYPE_MEM;
-	else
-		type = PCIE_ATU_TYPE_IO;
-
-	ret = dw_pcie_ep_inbound_atu(ep, func_no, type, epf_bar->phys_addr, bar);
-	if (ret)
-		return ret;
-
 	if (ep->epf_bar[bar])
-		return 0;
+		goto config_atu;
+
+	reg = PCI_BASE_ADDRESS_0 + (4 * bar);
 
 	dw_pcie_dbi_ro_wr_en(pci);
 
@@ -246,9 +237,20 @@ static int dw_pcie_ep_set_bar(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 		dw_pcie_ep_writel_dbi(ep, func_no, reg + 4, 0);
 	}
 
-	ep->epf_bar[bar] = epf_bar;
 	dw_pcie_dbi_ro_wr_dis(pci);
 
+config_atu:
+	if (!(flags & PCI_BASE_ADDRESS_SPACE))
+		type = PCIE_ATU_TYPE_MEM;
+	else
+		type = PCIE_ATU_TYPE_IO;
+
+	ret = dw_pcie_ep_inbound_atu(ep, func_no, type, epf_bar->phys_addr, bar);
+	if (ret)
+		return ret;
+
+	ep->epf_bar[bar] = epf_bar;
+
 	return 0;
 }
 
-- 
2.47.1


