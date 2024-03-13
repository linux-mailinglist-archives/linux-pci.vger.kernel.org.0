Return-Path: <linux-pci+bounces-4782-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A493087A64E
	for <lists+linux-pci@lfdr.de>; Wed, 13 Mar 2024 11:59:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 598B21F217A0
	for <lists+linux-pci@lfdr.de>; Wed, 13 Mar 2024 10:59:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C9D23E485;
	Wed, 13 Mar 2024 10:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NDE403aY"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68EFC3D552
	for <linux-pci@vger.kernel.org>; Wed, 13 Mar 2024 10:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710327524; cv=none; b=Mtg0JowSIjynG6JAVLEo7dw03okTkVIU/NkrUO5XLt3aJn0nlLC19ZqaQk+kDfnG4zQo/olyz4q9Mb9GWbh1YY3+Zs0BH2xSYfwiLu4LTNWNYEyJZXDMnIOLGFsco067xZ83Oa4dtD3NPOm+osl7UPZQ27MYwqeXRLljZo0EIZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710327524; c=relaxed/simple;
	bh=fjgTQUcExh1iJN93AN1TOYbTttNnPvt1KtONXArKbVU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uJFkcREPI9i18lKkjIP9I2LG42HxFtX+Kd6lto0hV9RIfXxZ7u3c2UKMkAXyP7TInhxgyzKbsb1BafzlJkNxfon8ypVY8fUT7bVTBCEkXLYyZs6ZnIOTOsX42RmgJzow1j7+0RtykZkizGGJWaqNqbhcg9FmFpfbjtIG3fwtF5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NDE403aY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F2FBC433A6;
	Wed, 13 Mar 2024 10:58:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710327524;
	bh=fjgTQUcExh1iJN93AN1TOYbTttNnPvt1KtONXArKbVU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NDE403aYJxTfmtcvNmGiBxyYVhAWw4vBrWslmk+SQgqAFAnpqWDh3JAjdAK4pi23x
	 Ijzds15pTvw6eUlaFZiCqYCf/BeBaRgkG/5bM4ezJqh6H2xv2FDy2yUTMeiIOUMcGK
	 d7u0V+OdeNzM9RiYy/t/cX+nEIe7UD1XZ4Q4dWZIKOeg1pXOerZOFcliE63+e/4Pyb
	 uAh4Qf9fI8ZL24pZuzU+Qh0uf6ZipBG1DnPOs3Ib++1ptoVP4qD478v81MEmMZzvU/
	 +g4W/6YNby72nF11givw9j0rbW5OOxFQNEHN3dhTowmWF+ywGVyN66pBfM9eolWwQw
	 6nPRWMiksknSA==
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
Subject: [PATCH v3 8/9] PCI: rockchip-ep: Set a 64-bit BAR if requested
Date: Wed, 13 Mar 2024 11:58:00 +0100
Message-ID: <20240313105804.100168-9-cassel@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240313105804.100168-1-cassel@kernel.org>
References: <20240313105804.100168-1-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Ever since commit f25b5fae29d4 ("PCI: endpoint: Setting a BAR size > 4 GB
is invalid if 64-bit flag is not set") it has been impossible to get the
.set_bar() callback with a BAR size > 4 GB, if the BAR was also not
requested to be configured as a 64-bit BAR.

It is however possible that an EPF driver configures a BAR as 64-bit,
even if the requested size is < 4 GB.

Respect the requested BAR configuration, just like how it is already
repected with regards to the prefetchable bit.

Signed-off-by: Niklas Cassel <cassel@kernel.org>
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


