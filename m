Return-Path: <linux-pci+bounces-12354-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0443F962CBD
	for <lists+linux-pci@lfdr.de>; Wed, 28 Aug 2024 17:46:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A30601F220D7
	for <lists+linux-pci@lfdr.de>; Wed, 28 Aug 2024 15:46:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B40551A38C1;
	Wed, 28 Aug 2024 15:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wni5p08Y"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85BBE83A18;
	Wed, 28 Aug 2024 15:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724859984; cv=none; b=RNeyoMlrrg2mcJ1TbX2ZUoCd4JCrYwvA6s7U/QUy1Vb2fcijJqbU8wpJSvN5CjAX1HsaxCD91pDQj84UDyhYwplLn/vG2EvydVI5IHOUt/rs5Lp7tm6CdKv1bYhmzlqBqDNjeX2S8NQRQO8agamJ/TmpPevI3y95WmIOglKHNZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724859984; c=relaxed/simple;
	bh=+Tkqhar4vQYGZIgL28NlgG1tVNG3i9So+0zA8BWKYOU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kpY0Wz0lbGNON+wOeUxgqHEsiiuSL/GfquLyJREiAQVRKPGlAE7KqrKB7H3b6WAS6N7Yeq7ek5l/uw1G3LXXIcQYVvVE8HK6ge0DOVbb5+5sqbCd9N5ZpUsYqLihd8/jabfobhju2QckMVukkGIzgLFUrQPIdShw3fYkxq+xXFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wni5p08Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3B09CC4AF17;
	Wed, 28 Aug 2024 15:46:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724859984;
	bh=+Tkqhar4vQYGZIgL28NlgG1tVNG3i9So+0zA8BWKYOU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Wni5p08Y4poqJ7JER7adnz1qawx2bLu9g3YNgIuzMOYx9sidu3IqiZYbUk+wnR1iI
	 ZozrhbHH+XRKdmv9+0EB5xQCkgpsKtKY1yacx61cSHK2xgFDDQja4LDyIPxw5o3KSd
	 peVqNOmQz0aYvU0BFOywptpS07TnwFnvcTajpAAoXDQC+SVBmv5KtKvZYhUkR8dkKK
	 PwP9Q9xUYFJJ3YP5y/Vc3XkB0UbiS1BXf7dDeyg8boMlL07U74IzjnJIZCGbi3cEn3
	 AOOid9h/+I03RurhNbQkbMFYOJ4kxv+Q/akh0YGsUKuMlksxs9f4SRpB/VxYmhuvk5
	 nsx8KCyFv62iA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24E2CC61CF0;
	Wed, 28 Aug 2024 15:46:24 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.linaro.org@kernel.org>
Date: Wed, 28 Aug 2024 21:16:12 +0530
Subject: [PATCH v4 02/12] PCI: qcom-ep: Reword the error message for
 receiving unknown global IRQ event
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240828-pci-qcom-hotplug-v4-2-263a385fbbcb@linaro.org>
References: <20240828-pci-qcom-hotplug-v4-0-263a385fbbcb@linaro.org>
In-Reply-To: <20240828-pci-qcom-hotplug-v4-0-263a385fbbcb@linaro.org>
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
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1256;
 i=manivannan.sadhasivam@linaro.org; h=from:subject:message-id;
 bh=B8RUdvVv9QEg4h2fDtSWIh3luhRVOKTDULQMHpO/Rk0=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBmz0ZLNt9QNPKv9NKAKbZ5eVVEDlJxVPTsCl4yZ
 H4jVagxg8KJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCZs9GSwAKCRBVnxHm/pHO
 9cEpB/4hP+YKCmtIoOu2Hobc2nRJn8ozN5UY9byuFg1YQ5A1UEpxS1qIj/AsDmQdV9VTq5uHzGM
 328jQY5jYgixBeIhqP4j1hMIWYRj1u/IsKn0n+dIuIU3dG6LE/YZ7nEKXToBSR72kQDRqO59alz
 WzXQTeR8g87j1LgD4ZjW61UaFEEWMFrDZFHezITn8NV9Oy0lbwJRaV7QDzlVgpuIWPkP2a7Kzhl
 dc2+VD7cLBgch/22b8vPvycHUyVl+UzorHJhFDRkSBx8eu7jpX78UD738y9xO7ESP5/Z9JwJNKC
 ucR+cweFjvWOdffPpzPYLz3GBumFwjJcJEGsVOy2gwP8c/UG
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



