Return-Path: <linux-pci+bounces-13826-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E885C99057B
	for <lists+linux-pci@lfdr.de>; Fri,  4 Oct 2024 16:10:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A97D7283AC5
	for <lists+linux-pci@lfdr.de>; Fri,  4 Oct 2024 14:10:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E3E82139C9;
	Fri,  4 Oct 2024 14:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WDzZp96y"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20028215F41
	for <linux-pci@vger.kernel.org>; Fri,  4 Oct 2024 14:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728051005; cv=none; b=XzF6SKRXcgJPWqWoeQFcFQrNwOXencgq/w1LPblAXOO5DYftb+RAYpvXITotuKkYif67RbhrCD4hzkkLXgLt4ZQms86+NY19e4H4uA0IXpYb8OELF3B2fDeJzhdnW71qVY0f+qUTBJGW+BdmZVBAyNEoIAMpsZan+UddsXPvW7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728051005; c=relaxed/simple;
	bh=bXLMz5oUWP48+uJ53mJJ1a5Yqox6fFgpG+XoSqUvARo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Rql2KI+CRsIG89ZVXhymWMeUM9brnd9+SKw9YUJfAtbGCsYT0MpBRp809j8NpfCsj8QienGuAR2OTeX22RjETP7YeB9AEIrO5zKwuXGPEtLs/T7fLS+AL9Wk5wga1ZOs7mpFWNXh2PPOniSyTqawRbzvGrs+Z8T8RApFILHSkn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WDzZp96y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 676EBC4CEC6;
	Fri,  4 Oct 2024 14:10:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728051004;
	bh=bXLMz5oUWP48+uJ53mJJ1a5Yqox6fFgpG+XoSqUvARo=;
	h=From:To:Cc:Subject:Date:From;
	b=WDzZp96yCHgo5eN7YBE72vin8wob73+31PpJMXO4m5cgWxtG7rQWYqER8W8gw94Yw
	 HNhtiB+B9Mp+jIBV0fyTJro0h75rdjFs0XcmVyyQwq6UQR2nOnZtTvWxnq2xSRG5M+
	 USIX7bjuAlnUui5AR6R6idUmEdRFfKKBGLJmR2LflWpNdAvzreJXkDddxI4MV9lSR2
	 UmacIGD+ejXE/ohU34RJ20JCZSy/SwOQ/ccYZeKK1tmf9ZdZRtGRNnkZQcAnE1OUiO
	 /LU6DdrWnlAIgH5E0+R/OFAgD0Q3WTEifHJXmtsDal7s5TEPYQgYnADUAckxbXht/A
	 TfE2LsXoTru6g==
From: Damien Le Moal <dlemoal@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	linux-pci@vger.kernel.org
Cc: Niklas Cassel <niklas.cassel@wdc.com>
Subject: [PATCH] PCI: dwc: endpoint: Clear outbound address on unmap
Date: Fri,  4 Oct 2024 23:10:00 +0900
Message-ID: <20241004141000.5080-1-dlemoal@kernel.org>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In addition to clearing the atu index bit in ob_window_map, also clear
the address mapped (outbound_addr array) in dw_pcie_ep_unmap_addr(), to
make sure that dw_pcie_find_index() does not endup matching again an ATU
index that was already unmapped.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 drivers/pci/controller/dwc/pcie-designware-ep.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index 501e527c188e..7f4c082a2d90 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -294,6 +294,7 @@ static void dw_pcie_ep_unmap_addr(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 	if (ret < 0)
 		return;
 
+	ep->outbound_addr[atu_index] = 0;
 	dw_pcie_disable_atu(pci, PCIE_ATU_REGION_DIR_OB, atu_index);
 	clear_bit(atu_index, ep->ob_window_map);
 }
-- 
2.46.2


