Return-Path: <linux-pci+bounces-11035-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBA2C942C62
	for <lists+linux-pci@lfdr.de>; Wed, 31 Jul 2024 12:50:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A96B1C21AFE
	for <lists+linux-pci@lfdr.de>; Wed, 31 Jul 2024 10:50:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE8991AD3E6;
	Wed, 31 Jul 2024 10:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sfAeW2Q3"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A80C41A7F79;
	Wed, 31 Jul 2024 10:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722423018; cv=none; b=qEv/sreyniTbRlFlJIkDqWRQoeIcuIJSHlDj/EJPkvPhgyvew+Tgkpz1pv+qqrcKLrizIVCU9s2TnLwCBFKR54sGJF1lDhPJZNYkza9vMVx2SBiNSnOqvDc5lDddclSvH6QdCrWyJ93vwXHyIL2tbM7WqjmDXrXxjxDzvhIHMjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722423018; c=relaxed/simple;
	bh=+Tkqhar4vQYGZIgL28NlgG1tVNG3i9So+0zA8BWKYOU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WG5NB+IMjyH4csRZKvmWoo2lHr0qO+g5C+1giO3yD/rL/WnUonbs/zfeE1PzrXnr6rklchuhMblGcVpxrr8u3dwOreBIYs1Vg+VhvsuM1lrmyY+aGWc6h3ipRmOP7ca5gCLlRpfLQrsS9KbE/svfcI70kOmGzxClCJCkpjtJYTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sfAeW2Q3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4D40BC4AF0C;
	Wed, 31 Jul 2024 10:50:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722423018;
	bh=+Tkqhar4vQYGZIgL28NlgG1tVNG3i9So+0zA8BWKYOU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=sfAeW2Q3INQ/Wgs52gQOY7e1a3f0KB5NN3Z5uAAYgjsrcr/iQLUhnkMZgy54B93Os
	 fNQUSkgrA8JM5BFdcUwT6L+Hvqq2WLFosiEJ0+VWmuN/QXVEOMhFo0OJPQCpD3qsfl
	 RvyZ2vJ2ULqzxWbw11R8if+NG6dotqI0h1ExnQW2lFnWYOrxNQJM2I+22bocDd3JvL
	 01o9NALX5HJXTdybl1UFZqwk1K9Q0Npp7DAHkUozkHjoU2PdkTtDSnjtEMuns1hIXF
	 k7TW31csjRDJb1CWSvC5joQhApzn/Ig/laloVc+QbNdQiqtuZykfeyySTNbGRIL0eS
	 2/7BhJTg4KeFA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3687BC52D6D;
	Wed, 31 Jul 2024 10:50:18 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.linaro.org@kernel.org>
Date: Wed, 31 Jul 2024 16:20:05 +0530
Subject: [PATCH v3 02/13] PCI: qcom-ep: Reword the error message for
 receiving unknown global IRQ event
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240731-pci-qcom-hotplug-v3-2-a1426afdee3b@linaro.org>
References: <20240731-pci-qcom-hotplug-v3-0-a1426afdee3b@linaro.org>
In-Reply-To: <20240731-pci-qcom-hotplug-v3-0-a1426afdee3b@linaro.org>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1256;
 i=manivannan.sadhasivam@linaro.org; h=from:subject:message-id;
 bh=B8RUdvVv9QEg4h2fDtSWIh3luhRVOKTDULQMHpO/Rk0=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBmqhbiPvlBYFkyQTm0FUkbIjHMH/+/ZAg11HCjV
 xz5OPlMCDyJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCZqoW4gAKCRBVnxHm/pHO
 9fAkB/9WOZ4Pm2vf1vP5hHdw6Ggj3kP1To3Upq1DZPNUvBuxAfX3SX7dC3Ec1cwU48Ig/RWN8fR
 4mB7xUJOFQa+XKdRaAp4nH/I39Pfnze4V4UZuoPuTMvZ6186dX4gm3alkr3ElT1RbwkKXLmUfMt
 Ml7vht4ZW7OgGLMCWTsNQDRUaddRLqmlrmyhniidJYOYFV/mzfO8HSXDkgwLh23sgVmLoqQ+zWI
 5ttBWDYgVU55MHsvjIbhRaG3VJaSRo3CtuxjytmhZu5yJ7EoSDLBQSPzQNVXsPOcj0jLcqVD9uJ
 2XmiqdsNSDOyUwy8/85yTfrnuvIoN1yGMptRMN+npS3NWfdc
X-Developer-Key: i=manivannan.sadhasivam@linaro.org; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008
X-Endpoint-Received: by B4 Relay for
 manivannan.sadhasivam@linaro.org/default with auth_id=185
X-Original-From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Reply-To: manivannan.sadhasivam@linaro.org

From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Current error message just prints the contents of PARF_INT_ALL_STATUS
register as if like the IRQ event number. It could mislead the users.
Reword it to make it clear that the error message is actually showing the
interrupt status register to help debug spurious IRQ events.

While at it, let's also switch over to dev_WARN_ONCE() so that any IRQ
storm won't flood the kernel log buffer.

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/controller/dwc/pcie-qcom-ep.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom-ep.c b/drivers/pci/controller/dwc/pcie-qcom-ep.c
index 972a90eba494..0bb0a056dd8f 100644
--- a/drivers/pci/controller/dwc/pcie-qcom-ep.c
+++ b/drivers/pci/controller/dwc/pcie-qcom-ep.c
@@ -679,7 +679,8 @@ static irqreturn_t qcom_pcie_ep_global_irq_thread(int irq, void *data)
 		dw_pcie_ep_linkup(&pci->ep);
 		pcie_ep->link_status = QCOM_PCIE_EP_LINK_UP;
 	} else {
-		dev_err(dev, "Received unknown event: %d\n", status);
+		dev_WARN_ONCE(dev, 1, "Received unknown event. INT_STATUS: 0x%08x\n",
+			      status);
 	}
 
 	return IRQ_HANDLED;

-- 
2.25.1



