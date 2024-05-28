Return-Path: <linux-pci+bounces-7902-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FC6D8D1D61
	for <lists+linux-pci@lfdr.de>; Tue, 28 May 2024 15:48:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 105291F235B2
	for <lists+linux-pci@lfdr.de>; Tue, 28 May 2024 13:48:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BD3F13C822;
	Tue, 28 May 2024 13:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qeNX+y0n"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 075FA16C879
	for <linux-pci@vger.kernel.org>; Tue, 28 May 2024 13:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716904132; cv=none; b=ZhlgsS5ZWkI06UlPGT8dnz391JlE763MiF5QXlC82LViMI96CJS7I4+Uqi4MJKvjQUzNcd84Z23H7mn+SZ5Q4exWOePfkAIxAm8QDTSm01FjZ2wNmspshMARFVY2N/092aPbhen01OqPYKdFIA7SIGoVEYLIIHinjMjmjH8JKBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716904132; c=relaxed/simple;
	bh=J+fC+7FJfCkAcYVMnX+BGcp/73tjL/xgqVNvw0jxhkE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dTUsJJpbTGulB2rXw1JavNXb9zMKgBoekpoQW6atWS9zMlJxQ28l6L8BIroLy2yRk3fMSf9p1Tcqsp4CNyqrbonbbRTSZvV+q7if7JgTz1BfmtoP/bxoW/m29JLTzjYCZyekLsmAkAtoksF4qGAQU21D8tMX6BKQGmutZtrwuTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qeNX+y0n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74D1CC3277B;
	Tue, 28 May 2024 13:48:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716904131;
	bh=J+fC+7FJfCkAcYVMnX+BGcp/73tjL/xgqVNvw0jxhkE=;
	h=From:To:Cc:Subject:Date:From;
	b=qeNX+y0nVAQjvGYYZexGQcMreQ6+YewOdKlioknTLfk+5dIJyGZVwwDYdkBWnOLcr
	 wmkk8H68T7COzp4zzBP4P0S0d4avL42/pfask9Dr9BPpnYDxYTUWtZSy+QOvN4lHBq
	 456arB6DsFFREvhlF3tNdWkKF6p0qzvzbF7+t2XjbPcYiZTX2vJOw/5S2FiqwZc3c4
	 QRjac/hqwN8AB894TBGvtfp18w5jTg4JIkKwU9pvsttVrRp29WZ6thezocsYmIpN2x
	 HmAP0CdatiCEVTsTVOtxgjzcQNgbBeaklPTy/g2NqEG3zAdazOvL3lbiLzfoaC8njx
	 +fwkrkLcXD1Nw==
From: Niklas Cassel <cassel@kernel.org>
To: Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	linux-pci@vger.kernel.org
Subject: [PATCH] PCI: dwc: ep: Enforce DWC specific 64-bit BAR limitiation
Date: Tue, 28 May 2024 15:48:40 +0200
Message-ID: <20240528134839.8817-2-cassel@kernel.org>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1501; i=cassel@kernel.org; h=from:subject; bh=J+fC+7FJfCkAcYVMnX+BGcp/73tjL/xgqVNvw0jxhkE=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGNJCH2zPuvvIUOPEPet54dMjIlXrHvhvPLHsroSFS3LVN YuHnYqMHaUsDGJcDLJiiiy+P1z2F3e7TzmueMcGZg4rE8gQBi5OAZjIo58Mv5gbnK42uEyX/7mc 01GO/elilV+FSrreDvsyzj2rqZELFGdk6P0k8+XggYaFd37u/Wp5Wz7WJW1r1qpzik3xSiY8HCo TWAE=
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

From the DWC EP databook 5.96a, section "3.5.7.1.4 General Rules for BAR
Setup (Fixed Mask or Programmable Mask Schemes Only)":

"Any pair (for example BARs 0 and 1) can be configured as one 64-bit BAR,
two 32-bit BARs, or one 32-bit BAR."

"BAR pairs cannot overlap to form a 64-bit BAR. For example, you cannot
combine BARs 1 and 2 to form a 64-bit BAR."

While this limitation does exist in some other PCI endpoint controllers,
e.g. cdns_pcie_ep_set_bar(), the limitation does not appear to be defined
in the PCIe specification itself, thus add an explicit check for this in
dw_pcie_ep_set_bar() (rather than pci_epc_set_bar()).

Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/pci/controller/dwc/pcie-designware-ep.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index f22252699548..42db3c3bbe96 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -227,6 +227,13 @@ static int dw_pcie_ep_set_bar(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 	int ret, type;
 	u32 reg;
 
+	/*
+	 * DWC does not allow BAR pairs to overlap, e.g. you cannot combine BARs
+	 * 1 and 2 to form a 64-bit BAR.
+	 */
+	if ((flags & PCI_BASE_ADDRESS_MEM_TYPE_64) && (bar & 1))
+		return -EINVAL;
+
 	reg = PCI_BASE_ADDRESS_0 + (4 * bar);
 
 	if (!(flags & PCI_BASE_ADDRESS_SPACE))
-- 
2.45.1


