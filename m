Return-Path: <linux-pci+bounces-26000-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E2704A90667
	for <lists+linux-pci@lfdr.de>; Wed, 16 Apr 2025 16:30:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3C8D188FB13
	for <lists+linux-pci@lfdr.de>; Wed, 16 Apr 2025 14:28:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03ADD1DF742;
	Wed, 16 Apr 2025 14:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f1gwotxw"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3C471DED57
	for <linux-pci@vger.kernel.org>; Wed, 16 Apr 2025 14:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744813692; cv=none; b=LZVbuhw0/XdmIuA4l06rEhkkSjOeYPG9PgF4cLecuOso+R3+cav2boO5Anyrqhev9Y5dGiFcBm0nweEBkk49M3NKJxy/kzJvQckpZ9FP/w1ns2NG99S40ijJ8CgRZht5SfrwDlNrYzIsMh53fCGzxg0F+U5fR2WH4c/G88yHy68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744813692; c=relaxed/simple;
	bh=YohtpSKfziHQfMPNcNaGHRCZ3p7uL5Xf3nCpnAqt2us=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=d1JkIosbNvqSAFDV7Ubr/3LxrOL21esrC3FmlJ+MIMc8JN/HWObKZHKPEXVPkUGaUbw0xlqBXpRvFmOl42bKS0ofcuFMr3dPwZ+h0kCtYP6aLNZ0sn33krNa7QgaGrUdZ1fDw78wcFIM5agEyHCFcNo4cbEVTjo95XrD1DZy9SM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f1gwotxw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3340C4AF0D;
	Wed, 16 Apr 2025 14:28:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744813692;
	bh=YohtpSKfziHQfMPNcNaGHRCZ3p7uL5Xf3nCpnAqt2us=;
	h=From:To:Cc:Subject:Date:From;
	b=f1gwotxw8qmedNGFyJRw+hTIvIeLRizf3DPhc4hSAPcwnjmnwKmg5oalAo00kvQqv
	 +dpTyPmDKid5E7Mrz7nHDpP+08ZKx3VqELDemHzFHSvYKBt6Ya0zlT+FaiB8kDNNCI
	 JzExyn0z1sT06R9r/aTQps4wyyzGn4FH2zRVMUL2SIFSCnoBsYCqZx7jF/I2MdYgkB
	 x2O0oS+5yGdH16Tj1tMfiuLWxr0pPljQuuXmYNRqK2w+d8517VqI/H5T9W+Sty1LIP
	 0qD3yobzffiFR61gYw0tfd2SinZ7Kw2FZC7cdnMG9WEBoH/Y5pcuVLEgnDvM3JnNfw
	 XSx6v41BmWm8Q==
From: Niklas Cassel <cassel@kernel.org>
To: Shawn Lin <shawn.lin@rock-chips.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>
Cc: Niklas Cassel <cassel@kernel.org>,
	linux-pci@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH RESEND] PCI: rockchip-ep: Mark RK3399 as intx_capable
Date: Wed, 16 Apr 2025 16:27:49 +0200
Message-ID: <20250416142749.336298-2-cassel@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=996; i=cassel@kernel.org; h=from:subject; bh=YohtpSKfziHQfMPNcNaGHRCZ3p7uL5Xf3nCpnAqt2us=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGNL/70ud225mUuCSez2hyl9kUt0ZzXSJuU5bvbUc/e4p+ m5J3pXSUcrCIMbFICumyOL7w2V/cbf7lOOKd2xg5rAygQxh4OIUgImIcjAyXP85/0uJXNy7F+y+ N7/ZGe74ESGX+mexQ5i6UlqQWsPFXQx/xabkxhZwKGRsnqK/tufL0ofbH/j//9d5XdhDW+mw7yY LBgA=
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

RK3399 can raise INTx interrupts, as can be seen by
rockchip_pcie_ep_send_intx_irq().

This is also in line with the register description of
PCIE_CLIENT_LEGACY_INT_CTRL, section "17.6.3 PCIe Client Detail Register
Description" of the RK3399 TRM.

Thus, mark RK3399 as intx_capable.

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/pci/controller/pcie-rockchip-ep.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/controller/pcie-rockchip-ep.c b/drivers/pci/controller/pcie-rockchip-ep.c
index 85ea36df2f59..626f6b31b0f6 100644
--- a/drivers/pci/controller/pcie-rockchip-ep.c
+++ b/drivers/pci/controller/pcie-rockchip-ep.c
@@ -694,6 +694,7 @@ static const struct pci_epc_features rockchip_pcie_epc_features = {
 	.linkup_notifier = true,
 	.msi_capable = true,
 	.msix_capable = false,
+	.intx_capable = true,
 	.align = ROCKCHIP_PCIE_AT_SIZE_ALIGN,
 };
 
-- 
2.49.0


