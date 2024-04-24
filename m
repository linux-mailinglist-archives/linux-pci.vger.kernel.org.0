Return-Path: <linux-pci+bounces-6637-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 315888B0DCA
	for <lists+linux-pci@lfdr.de>; Wed, 24 Apr 2024 17:17:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60BCE1C250B0
	for <lists+linux-pci@lfdr.de>; Wed, 24 Apr 2024 15:17:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACE7115F306;
	Wed, 24 Apr 2024 15:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ba7psUIT"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83E5715EFD5;
	Wed, 24 Apr 2024 15:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713971820; cv=none; b=IJ6v6YBRfSFQ7fdod5m77Vfwi02uCNLMiP5CKcpfk8Ij7lCFzT2dg4nWwKKnHlanaB/rriiAI9SSkzqzefJ25HmlYRg5799V5tTgmX4BWi8lOOjvAm4ktYI6tAXqXngsWWYPXq0ppr3fomu66LEB0KkdcKr2clFoOOg7otJX4hM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713971820; c=relaxed/simple;
	bh=lzJ2BxKBBswxjN9lBrWUoaKYI/aG2NTtIprX120aOD4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nzu8HdtGTdlbDpTzK9V5QlEl5QkpryG2dHFBeAQxCSBJ9FRwgwb1bKFMAnOIFNCXKILambUCGr3H8FJgGr7hdzmvvloEps8ycz6ORg+cqml+HWlbb1cPDkrUtBqvhLK444G1Tjfi3BkUNETgSu2+aQrhTKs+pVNurV9Pkow6yo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ba7psUIT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FF7BC2BD10;
	Wed, 24 Apr 2024 15:16:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713971820;
	bh=lzJ2BxKBBswxjN9lBrWUoaKYI/aG2NTtIprX120aOD4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Ba7psUITfYaamhPT4xpDGamucpKFzYs3Ehx3Vb6GMRTvm7oh3Mg1PxALqUWCXQTJQ
	 HugfSqJq7HhuVFrVKQ+7yalh2PfJCsXfsUsRp/kXzJwZPX8sLwo0l5wgrkt4B9P53h
	 MbZxaZDauxhGyNMET7/KPSMZrDrNBZxMlGEYMqCCX6f4wLoGCFLs3ErQAJcvAi2LVn
	 fstu94srRpXrpVLKpz95JBSe7eaxtNHGzdrkW1bArTm1Fv9Ym+f+EDxymXaX9AnOZ4
	 DNBPUPkwuiGUZjbrKlUQCARQakfBx3CtbP583HdLLidW6npALEPkh2azMQOGSHAEIL
	 fOcXuUN8Z7A0w==
From: Niklas Cassel <cassel@kernel.org>
Date: Wed, 24 Apr 2024 17:16:23 +0200
Subject: [PATCH 05/12] PCI: dw-rockchip: Fix weird indentation
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240424-rockchip-pcie-ep-v1-v1-5-b1a02ddad650@kernel.org>
References: <20240424-rockchip-pcie-ep-v1-v1-0-b1a02ddad650@kernel.org>
In-Reply-To: <20240424-rockchip-pcie-ep-v1-v1-0-b1a02ddad650@kernel.org>
To: Jingoo Han <jingoohan1@gmail.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 Niklas Cassel <cassel@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
 Damien Le Moal <dlemoal@kernel.org>, Jon Lin <jon.lin@rock-chips.com>, 
 Shawn Lin <shawn.lin@rock-chips.com>, Simon Xue <xxm@rock-chips.com>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-rockchip@lists.infradead.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1116; i=cassel@kernel.org;
 h=from:subject:message-id; bh=lzJ2BxKBBswxjN9lBrWUoaKYI/aG2NTtIprX120aOD4=;
 b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGNI0lYJaP+8uuPPRYcJk89cfdZqU3HL8YhSP9z57uLU7y
 EY+YPn9jlIWBjEuBlkxRRbfHy77i7vdpxxXvGMDM4eVCWQIAxenAEzkPT/DP+1NTa8MFV4fFN9z
 a2u/ft2mifmcigeqn+xaWHbCzWzm53WMDF37Fyy8flaKJdzwj2boi+vLjxmYHT4X4r21oWym62s
 fI04A
X-Developer-Key: i=cassel@kernel.org; a=openpgp;
 fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA

Fix the indentation of rockchip_pcie_{readl,writel}_apb() parameters to
match the opening parenthesis.

Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/pci/controller/dwc/pcie-dw-rockchip.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
index d6842141d384..1993c430b90c 100644
--- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
+++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
@@ -60,14 +60,13 @@ struct rockchip_pcie {
 	struct irq_domain		*irq_domain;
 };
 
-static int rockchip_pcie_readl_apb(struct rockchip_pcie *rockchip,
-					     u32 reg)
+static int rockchip_pcie_readl_apb(struct rockchip_pcie *rockchip, u32 reg)
 {
 	return readl_relaxed(rockchip->apb_base + reg);
 }
 
-static void rockchip_pcie_writel_apb(struct rockchip_pcie *rockchip,
-						u32 val, u32 reg)
+static void rockchip_pcie_writel_apb(struct rockchip_pcie *rockchip, u32 val,
+				     u32 reg)
 {
 	writel_relaxed(val, rockchip->apb_base + reg);
 }

-- 
2.44.0


