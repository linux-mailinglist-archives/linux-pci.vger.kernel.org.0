Return-Path: <linux-pci+bounces-17401-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 255AD9DA5C6
	for <lists+linux-pci@lfdr.de>; Wed, 27 Nov 2024 11:31:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E060B284FF4
	for <lists+linux-pci@lfdr.de>; Wed, 27 Nov 2024 10:31:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 327FE1991B8;
	Wed, 27 Nov 2024 10:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CTb5G3cY"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08CF71991B2;
	Wed, 27 Nov 2024 10:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732703435; cv=none; b=kcf8vbgQyWTPzBckC2uESiINakk0b+d83CD/JdP4+ILvDYUY0ELTeNlag8bXQaaDBmvUJxpQV3URv9vav3u2780h2vjZzEO9C+xKwcRRtEKUmYPZOw2OZF2GTH97AhsJPBvjbBmt9D4c8l3GNsirEcmj+EtduHk2lwyv0J4cico=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732703435; c=relaxed/simple;
	bh=xKvC8c0LPS2zto1FLCcDihb3dhIOCSAgeRGoSrmHlcY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LaX6HEqBFOlHiQU29iNKjwbGmVOALz7Vz8BC0Ck+t2O/FuoAuRlX0aJr4Nh4G1o2LPKKTCzhwwyeXerXeAmLF27hq8iR3b7vQNGwfatuhHoyhB/sEc748LvmvaHstXcWh1HQ9U+KorIj+pHiN8CWYzwS/VCL5nI12JPwY+tYbbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CTb5G3cY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9936C4CECC;
	Wed, 27 Nov 2024 10:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732703434;
	bh=xKvC8c0LPS2zto1FLCcDihb3dhIOCSAgeRGoSrmHlcY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CTb5G3cYie5TF+VvR21B+rHiWXqE0oxBr0m4lPq0GI8eayHQ8dq5VEoDOFUkWnzlk
	 9NlvJ+NfyLb4NKX356tTTrhhrc+NC/ZziMnEmIT6sW115NVQO5U75MhA3+JGew5tya
	 mL1yBwC80VDgZofrhePHHouVOTo7rhngr0c7jFC3FAGGX/r7w4UkGF1YuuUcxw2EFo
	 4hnjHwJgjgeN0g4HOuACYrIZE3h+tbRKu/telI62y1V/us4Ji+A9EPCtwFaq6VgHPL
	 XMidNB4E3Cu6zwAE5dGJfJnTACeYCz72e6/6Tn5KrbM3f5blWIJ4ZfVkY9CoEkiV0i
	 fDF/KRxuTcewA==
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
Subject: [PATCH v5 1/6] PCI: dwc: ep: iATU registers must be written after the BAR_MASK
Date: Wed, 27 Nov 2024 11:30:17 +0100
Message-ID: <20241127103016.3481128-9-cassel@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241127103016.3481128-8-cassel@kernel.org>
References: <20241127103016.3481128-8-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2565; i=cassel@kernel.org; h=from:subject; bh=xKvC8c0LPS2zto1FLCcDihb3dhIOCSAgeRGoSrmHlcY=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGNLdvuxdH5onvsSPY+fHxq32Kw1Wbyp6IXNCVnPJsjUSO 48utjrp01HKwiDGxSArpsji+8Nlf3G3+5TjindsYOawMoEMYeDiFICJ3NzP8L/i9NsphxjEb8kX 26s07D5Qsu5Pn8Od5sL1qy5xLC7uyDjMyHBP8nKaR8fFOyJrjNUbZip6CTRayRn/6eWp5J+rM3V qLzcA
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

The DWC Databook description for the LWR_TARGET_RW and LWR_TARGET_HW fields
in the IATU_LWR_TARGET_ADDR_OFF_INBOUND_i registers state that:
"Field size depends on log2(BAR_MASK+1) in BAR match mode."

I.e. only the upper bits are writable, and the number of writable bits is
dependent on the configured BAR_MASK.

If we do not write the BAR_MASK before writing the iATU registers, we are
relying the reset value of the BAR_MASK being larger than the requested
size of the first set_bar() call. The reset value of the BAR_MASK is SoC
dependent.

Thus, if the first set_bar() call requests a size that is larger than the
reset value of the BAR_MASK, the iATU will try to write to read-only bits,
which will cause the iATU to end up redirecting to a physical address that
is different from the address that was intended.

Thus, we should always write the iATU registers after writing the BAR_MASK.

Cc: stable@vger.kernel.org
Fixes: f8aed6ec624f ("PCI: dwc: designware: Add EP mode support")
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
2.47.0


