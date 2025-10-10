Return-Path: <linux-pci+bounces-37826-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D9AFBCE3B3
	for <lists+linux-pci@lfdr.de>; Fri, 10 Oct 2025 20:27:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3491C189B720
	for <lists+linux-pci@lfdr.de>; Fri, 10 Oct 2025 18:27:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FFC32FDC26;
	Fri, 10 Oct 2025 18:26:10 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AACB2FD7DD;
	Fri, 10 Oct 2025 18:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760120769; cv=none; b=skcjS6GxR7UUvl8yzvcj4U4IvK2p2pgqEA/CFVG5h/6C3JWZrprREmHLLxvHQxuEyFAmj6wBDgGHADDljSBlWSWlHZ3CfCvEGQJ4ldeM/yY1ZUp71szTdbIdBQs0daDgwX8sY23Dj7Y9s59dfyGodSaTfkDOYOnMZVh+rxiUs1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760120769; c=relaxed/simple;
	bh=pv2BzdMiDcx5mA6iDiHhMRhod6ykyXxVkx7QlBdz8s4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kYikHVxtDttKqW4x//HFgma5LYFcA9RdgbCo3N/K252gwX46+yytbvtyev7HwqS5G4+8bagIpOj+mnmxBJqpDhGKHoBcrg3CrgvRXR1UDhJ7mZR+7rol8JAaBcDH+1jOBH357AX+tV7PHpP1f8wyzPHD4IBOh1r9EqTj0eZe01k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D5F5C116D0;
	Fri, 10 Oct 2025 18:26:08 +0000 (UTC)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Date: Fri, 10 Oct 2025 11:25:49 -0700
Subject: [PATCH 3/3] PCI: qcom: Treat PHY and PERST# as optional for the
 new binding
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251010-pci-binding-v1-3-947c004b5699@oss.qualcomm.com>
References: <20251010-pci-binding-v1-0-947c004b5699@oss.qualcomm.com>
In-Reply-To: <20251010-pci-binding-v1-0-947c004b5699@oss.qualcomm.com>
To: Bjorn Helgaas <bhelgaas@google.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Abraham I <kishon@kernel.org>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1590;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=pv2BzdMiDcx5mA6iDiHhMRhod6ykyXxVkx7QlBdz8s4=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBo6U+9/pmvF/0/iMFkn4KsRGiXzoc2/ZoKzqajQ
 Pz5Kza93ROJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCaOlPvQAKCRBVnxHm/pHO
 9ZLKB/9ySihbtl5s3z7AJTC+NHAWOU+c+b3SOe3+gOhoPw6sTCgYueTHjcYC0kE/6EQ7kycN0st
 AdsUMqwhgJW/mA+VhN0P3hS9XR06Fu5mS+TpXIID+OSiJs5DcOlKueNL/Tn8kla4w0PtgJUobuR
 2tFdzxyUZDPQG9hcM4ExCwC5JmT22aDVTgkvQ02tRwUf+KFeBW65uqHs3tEerSqt2oZ/T8szHqk
 zajLFePJBtHpzMUZICmmsHM/fCR0GTrSlkFS4BZFyg7iJQpF3U07fYyvdojbY/k0aXULLNBPXKB
 6ITOj6AYBpFhlCKzkHmqsdXfuYm2wyjtTtSHri++3qpa/Nss
X-Developer-Key: i=manivannan.sadhasivam@oss.qualcomm.com; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008

Even for the new DT binding where the PHY and PERST# properties are
specified in the Root Port, both are optional. Hence, treat them as
optional in the driver too.

If both properties are not specified, then fall back to parsing the legacy
binding for backwards compatibility.

Fixes: a2fbecdbbb9d ("PCI: qcom: Add support for parsing the new Root Port binding")
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 805edbbfe7eba496bc99ca82051dee43d240f359..d380981cf3ad78f549de3dc06bd2f626f8f53920 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -1720,13 +1720,20 @@ static int qcom_pcie_parse_port(struct qcom_pcie *pcie, struct device_node *node
 
 	reset = devm_fwnode_gpiod_get(dev, of_fwnode_handle(node),
 				      "reset", GPIOD_OUT_HIGH, "PERST#");
-	if (IS_ERR(reset))
+	if (IS_ERR(reset) && PTR_ERR(reset) != -ENOENT)
 		return PTR_ERR(reset);
 
-	phy = devm_of_phy_get(dev, node, NULL);
+	phy = devm_of_phy_optional_get(dev, node, NULL);
 	if (IS_ERR(phy))
 		return PTR_ERR(phy);
 
+	/*
+	 * If both PHY and PERST# properties are not specified, then try the
+	 * legacy binding.
+	 */
+	if (PTR_ERR(reset) == -ENOENT && !phy)
+		return -ENOENT;
+
 	port = devm_kzalloc(dev, sizeof(*port), GFP_KERNEL);
 	if (!port)
 		return -ENOMEM;

-- 
2.48.1


