Return-Path: <linux-pci+bounces-4960-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49608881101
	for <lists+linux-pci@lfdr.de>; Wed, 20 Mar 2024 12:32:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 825ED1C21FD8
	for <lists+linux-pci@lfdr.de>; Wed, 20 Mar 2024 11:32:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C47533D964;
	Wed, 20 Mar 2024 11:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b0z853G/"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A080B3D961
	for <linux-pci@vger.kernel.org>; Wed, 20 Mar 2024 11:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710934352; cv=none; b=apHe5e4nKpGCkRaV+RbwuHO7vzW9Qg7AuYFL0IXr6PKLF3sD3OCYPED88Ln4Wc1i/BARm7sx4vzVgEt653pdbqJEIK5PqYKB2CyA2sguvseQp4xfaKIItJJNGL/hXfHTxDquJtSKdBpc0QpeJQxTszJHA5d7j7HO33dcYpMtiJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710934352; c=relaxed/simple;
	bh=q66K0XDfqa4FH1mzvBlDGOW/HIb2nk503TpvzVrO3uw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ETO6m/APr4BkxBRcGQR8ZNTv23c30J894oUREqRfQuSColonZP1B119Qy+gnQ6Q1cWBS9YRfsDMyjL52buZaHvDCKwkCzRIpPjetr+/RIKaBBdC1MlFjtJd2qOwU3TQZVYVHvtE54uufKxncbBOJL+HLIv/fiuaFVmqYmXLIXbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b0z853G/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A65BC433B1;
	Wed, 20 Mar 2024 11:32:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710934352;
	bh=q66K0XDfqa4FH1mzvBlDGOW/HIb2nk503TpvzVrO3uw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=b0z853G/KCqIKbAzHMyET5yPiC7NK9lhx6S1JnpJ9Bn8BYyNrNZtk2RWP/rw2QKGZ
	 4/wlPBkWWEsHZ7UVFUbIYaOCWcJHakfF12kS1JMAMdzAHEXAguURm59a7Rkt5DHvzj
	 SbkbieyE2zIIXHVDLLvQR0uSCJ1ybo2901O1svpFTIiq6Wm2IMfzPEVdUq3F3dm6Ae
	 x8dYsbKKphtdT8cCnOb2jF0NRVezO5BlHl5zviXSG+n2hVOvQlwMorxgPxE8B1U9e1
	 B5lyaIClz7Ot/n1M1vf8TOY0IXZRtApjsRYNtfkAeMBkcRXts0NNLIbPUCQPTQsj7W
	 h0mQZgU+k+SxA==
From: Niklas Cassel <cassel@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>
Cc: Shradha Todi <shradha.t@samsung.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	linux-pci@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v4 7/7] PCI: rockchip-ep: Set a 64-bit BAR if requested
Date: Wed, 20 Mar 2024 12:31:54 +0100
Message-ID: <20240320113157.322695-8-cassel@kernel.org>
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

Ever since commit f25b5fae29d4 ("PCI: endpoint: Setting a BAR size > 4 GB
is invalid if 64-bit flag is not set") it has been impossible to get the
.set_bar() callback with a BAR size > 2 GB (yes, 2GB!), if the BAR was
also not requested to be configured as a 64-bit BAR.

It is however possible that an EPF driver configures a BAR as 64-bit,
even if the requested size is < 4 GB.

Respect the requested BAR configuration, just like how it is already
repected with regards to the prefetchable bit.

Signed-off-by: Niklas Cassel <cassel@kernel.org>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/controller/pcie-rockchip-ep.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pcie-rockchip-ep.c b/drivers/pci/controller/pcie-rockchip-ep.c
index c9046e97a1d2..57472cf48997 100644
--- a/drivers/pci/controller/pcie-rockchip-ep.c
+++ b/drivers/pci/controller/pcie-rockchip-ep.c
@@ -153,7 +153,7 @@ static int rockchip_pcie_ep_set_bar(struct pci_epc *epc, u8 fn, u8 vfn,
 		ctrl = ROCKCHIP_PCIE_CORE_BAR_CFG_CTRL_IO_32BITS;
 	} else {
 		bool is_prefetch = !!(flags & PCI_BASE_ADDRESS_MEM_PREFETCH);
-		bool is_64bits = sz > SZ_2G;
+		bool is_64bits = !!(flags & PCI_BASE_ADDRESS_MEM_TYPE_64);
 
 		if (is_64bits && (bar & 1))
 			return -EINVAL;
-- 
2.44.0


