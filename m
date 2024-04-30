Return-Path: <linux-pci+bounces-6880-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B62DB8B7548
	for <lists+linux-pci@lfdr.de>; Tue, 30 Apr 2024 14:02:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2381AB224CB
	for <lists+linux-pci@lfdr.de>; Tue, 30 Apr 2024 12:02:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC26613F006;
	Tue, 30 Apr 2024 12:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RPhfPTWz"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 948FC13D289;
	Tue, 30 Apr 2024 12:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714478559; cv=none; b=g/uJc1tRiZWlpsIjjn4lCzsOi4kcD2myKjMc/6CHpgq9xk3n8xMB731K1ys2wT/MhwFwm/l+KBtz5enPPYJK9B3BtzhfT0/VDMsGsFp+I9Cny6P7HgX+NdS75+dZgLnxqQ94lhpjUK/3m4azN3o3TwgYEiqtDd9fWFZ8UhyxdtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714478559; c=relaxed/simple;
	bh=58kdoqhkMWSvOTNRnkUL+Dx7X57eBg3JtCaWStyIDvY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CajqnOGD4b6Vyesp0GRtQTtVyPOKdFSN4i9flo709bwBFIp1IfXLRAOGzFBh1vql5Qbqfa6MtFQ1RIQYzoh3f7oA3XgtUb7GTQr1XDWzTuznaXAaMGZPuSxr7B2mGOfx+oez8UWpMvwPobF4w1b4Nz8Rbxe5fkQUjcsXk6yZleo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RPhfPTWz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAD3DC4AF18;
	Tue, 30 Apr 2024 12:02:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714478559;
	bh=58kdoqhkMWSvOTNRnkUL+Dx7X57eBg3JtCaWStyIDvY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=RPhfPTWzDlztDQhqRthOfAZP5enmulZUPfQ2XfzPMNkCldQmz7hZ244X+v5M1kanl
	 ioN+QUU1hSr2ap8Ij27km+2oQAbN34D1mnn4CoqqF7IlD9MeFdWe8VtTrQkxy6W8iL
	 e5eolMVPfHUxatLCwJ3gBO7/Veg58A2bV4XnQDmW7VU91fgETCv0O20wyZHaNaRJhB
	 0KBfj1x1Hz5vmAi5NUf9LkVyehZP3NScze1ZJQ4voXpFOlR68iDfbBN5sQEWJlyZIH
	 2uU+tUcL2CmnFwzdJFmXLqMZWFWNm75Z9OV6sBJiqUY4aQJul6dg7oDjGskmbnXq+x
	 K46+ywLPCskYA==
From: Niklas Cassel <cassel@kernel.org>
Date: Tue, 30 Apr 2024 14:01:07 +0200
Subject: [PATCH v2 10/14] PCI: dw-rockchip: Add explicit
 rockchip,rk3588-pcie compatible
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240430-rockchip-pcie-ep-v1-v2-10-a0f5ee2a77b6@kernel.org>
References: <20240430-rockchip-pcie-ep-v1-v2-0-a0f5ee2a77b6@kernel.org>
In-Reply-To: <20240430-rockchip-pcie-ep-v1-v2-0-a0f5ee2a77b6@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=941; i=cassel@kernel.org;
 h=from:subject:message-id; bh=58kdoqhkMWSvOTNRnkUL+Dx7X57eBg3JtCaWStyIDvY=;
 b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGNIM7m4wuHXfeubc5mtHJD8yafyV/aSwM7bsRsTCj4Lt/
 69NXm3ytaOUhUGMi0FWTJHF94fL/uJu9ynHFe/YwMxhZQIZwsDFKQATORjKyDCxXuNKxnc/63/N
 U5zCNzdlZUzSXxoYJncy9nNQ5IRz53sY/spGWOaEBnBw6qfvN14iuGhuo5nT3bLXavV7JF77nxM
 MZQQA
X-Developer-Key: i=cassel@kernel.org; a=openpgp;
 fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA

The rockchip-dw-pcie.yaml device tree binding already defines
rockchip,rk3588-pcie as a supported compatible string.

Add an explicit rockchip,rk3588-pcie entry to make it easier to find the
driver that implements this compatible string.

Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/pci/controller/dwc/pcie-dw-rockchip.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
index f985539fb00a..f38d267e4e64 100644
--- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
+++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
@@ -400,6 +400,10 @@ static const struct of_device_id rockchip_pcie_of_match[] = {
 		.compatible = "rockchip,rk3568-pcie",
 		.data = &rockchip_pcie_rc_of_data,
 	},
+	{
+		.compatible = "rockchip,rk3588-pcie",
+		.data = &rockchip_pcie_rc_of_data,
+	},
 	{},
 };
 

-- 
2.44.0


