Return-Path: <linux-pci+bounces-34246-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C329CB2BA53
	for <lists+linux-pci@lfdr.de>; Tue, 19 Aug 2025 09:16:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05CDD1BC03A6
	for <lists+linux-pci@lfdr.de>; Tue, 19 Aug 2025 07:16:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5772F28488C;
	Tue, 19 Aug 2025 07:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f0ZvuWHD"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2582A156678;
	Tue, 19 Aug 2025 07:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755587700; cv=none; b=dSIYPr7EVZGrfRPsO39jDeKVonLZBtTA7Y+4hygAR89Lp+1TwGJFhY9PA0YtSjUJhR1RlqwOGZDbR7aCdmF7M/RWVL0VsXi60A4kd16HdACLjVdU4w7Er110cBzm6Yzjg7Q0NIcrqg5BYm9XNcZxHn+274bBLXJhTJhR1L+pfBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755587700; c=relaxed/simple;
	bh=4ynEP/LZdmDMVF5wOF01p56ypGM5aDpiB2c+7/2LclI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GhLHzqRjc6lr+8ROZaQIlE0Gz8OU/cYBAgUvv92+ZpL32N36+udxCpragOE8GCea/3hxP/cg7wPpADetaoB+QSrw5fp2PmXPkinN6hx45fLKYhw53P5VSVL35Rqc/I8qZljErua4zYdzj6dbB1RbXvdxnigcfiTCTHFciyfvjlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f0ZvuWHD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C44DAC116B1;
	Tue, 19 Aug 2025 07:14:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755587699;
	bh=4ynEP/LZdmDMVF5wOF01p56ypGM5aDpiB2c+7/2LclI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=f0ZvuWHDF8KN89qEVd0d0pCjLnTqYcyrDAJPrBuG6N8SyaBlMHQrLWqDAQEohy90q
	 5lMFEX3VxaySwHms/K38AuUGjbucnGTtn59EyAZ41Yngk6dR42Ss1M/U0C8a0u4r+p
	 IU3Ax276LZrJGTjwj0wM+J4A5lYlhgIpTyw6SDj8jD4au9Ge9zPXWOv1ri4YaOat4s
	 xwUWLLj0nE7LH3MAV/uRqS7FScTJuj1THolArtMZBKuOSkhwQMwFwhiRgbn/jbHJm9
	 sovwksgP6hH7+yUQrIj35enU66Bk8QXtJw2dQfsSs5Vv1JptEDOEacQOWjO2/M6790
	 VXLKtfXP7MMuA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5768CA0EE6;
	Tue, 19 Aug 2025 07:14:59 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org>
Date: Tue, 19 Aug 2025 12:44:50 +0530
Subject: [PATCH 1/6] PCI: qcom: Wait for PCIE_RESET_CONFIG_WAIT_MS after
 PERST# deassert
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250819-pci-pwrctrl-perst-v1-1-4b74978d2007@oss.qualcomm.com>
References: <20250819-pci-pwrctrl-perst-v1-0-4b74978d2007@oss.qualcomm.com>
In-Reply-To: <20250819-pci-pwrctrl-perst-v1-0-4b74978d2007@oss.qualcomm.com>
To: Manivannan Sadhasivam <mani@kernel.org>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, Saravana Kannan <saravanak@google.com>
Cc: linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, 
 Brian Norris <briannorris@chromium.org>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2012;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=nLv3p5NCWxDbWHE2Z9fkpVFUk3/5sd3FgmEvC3XmSR8=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBopCRwHaNQlIGTz2WlNHiLQk/TU/lg6dlcKu/OW
 2+SQDBN8C2JATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCaKQkcAAKCRBVnxHm/pHO
 9RC3B/9InRKjynqx2jgZo/S6kWGMeiLWVsr5SMXAngTM1r+pslxKagLJ3vLPV74z4Q9fP0cOi/7
 8lSM5rQJe0z0UprD2GqemPsIHmN80aXWjyKwX0ZW5CZcadJWzx8idNe46VfjJ55oP7dPM46YLhI
 MHOu2mjeiId5VtRwKGZKzuy/b+Qn6mDWl5fepDjolPffoeGbqwvhg4qk+c95ZxM0l5kcw7Cf5Xg
 PFGM/Y9Z9VoFVN6sRitO3h+5gZZ7WAKOPlMYH23Ihfr9WEKx7kErnWt/rAIyGCQWpy9ylazRZbC
 HmkLHmVAfJu/+r/ZfgC+Ojn1qg1QlAI4klip3lNgIhGW4WVm
X-Developer-Key: i=manivannan.sadhasivam@oss.qualcomm.com; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008
X-Endpoint-Received: by B4 Relay for
 manivannan.sadhasivam@oss.qualcomm.com/default with auth_id=461
X-Original-From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Reply-To: manivannan.sadhasivam@oss.qualcomm.com

From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

PCIe spec r6.0, sec 6.6.1 mandates waiting for 100ms before deasserting
PERST# if the downstream port does not support Link speeds greater than
5.0 GT/s. But in practice, this delay seem to be required irrespective of
the supported link speed as it gives the endpoints enough time to
initialize.

Hence, add the delay by reusing the PCIE_RESET_CONFIG_WAIT_MS definition if
the linkup_irq is not supported. If the linkup_irq is supported, the driver
already waits for 100ms in the IRQ handler post link up.

Also, remove the redundant comment for PCIE_T_PVPERL_MS. Finally, the
PERST_DELAY_US sleep can be moved to PERST# assert where it should be.

Fixes: 82a823833f4e ("PCI: qcom: Add Qualcomm PCIe controller driver")
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 294babe1816e4d0c2b2343fe22d89af72afcd6cd..bcd080315d70e64eafdefd852740fe07df3dbe75 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -302,20 +302,22 @@ static void qcom_perst_assert(struct qcom_pcie *pcie, bool assert)
 	else
 		list_for_each_entry(port, &pcie->ports, list)
 			gpiod_set_value_cansleep(port->reset, val);
-
-	usleep_range(PERST_DELAY_US, PERST_DELAY_US + 500);
 }
 
 static void qcom_ep_reset_assert(struct qcom_pcie *pcie)
 {
 	qcom_perst_assert(pcie, true);
+	usleep_range(PERST_DELAY_US, PERST_DELAY_US + 500);
 }
 
 static void qcom_ep_reset_deassert(struct qcom_pcie *pcie)
 {
-	/* Ensure that PERST has been asserted for at least 100 ms */
+	struct dw_pcie_rp *pp = &pcie->pci->pp;
+
 	msleep(PCIE_T_PVPERL_MS);
 	qcom_perst_assert(pcie, false);
+	if (!pp->use_linkup_irq)
+		msleep(PCIE_RESET_CONFIG_WAIT_MS);
 }
 
 static int qcom_pcie_start_link(struct dw_pcie *pci)

-- 
2.45.2



