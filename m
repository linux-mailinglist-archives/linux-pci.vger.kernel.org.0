Return-Path: <linux-pci+bounces-10441-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBEF59340EF
	for <lists+linux-pci@lfdr.de>; Wed, 17 Jul 2024 19:03:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A70F52848A2
	for <lists+linux-pci@lfdr.de>; Wed, 17 Jul 2024 17:03:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82EAC183061;
	Wed, 17 Jul 2024 17:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ADAy4Eok"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FC1E181B9A;
	Wed, 17 Jul 2024 17:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721235795; cv=none; b=koowZpbqiasKm44hl0hziNhk0+dY+YhOnvje6zYNcF/GOXCsSMuq3JZNJqwW6C6aRXw6rHa2ow99FaBcjYX6o84xT035fcewQBY3/eUnPeAJnXTlIHV37/vRVJy3gogVPTJsPXTvQdMNiQ/jwNiGSFAxavfeB+DEuyifRcQqMWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721235795; c=relaxed/simple;
	bh=+Tkqhar4vQYGZIgL28NlgG1tVNG3i9So+0zA8BWKYOU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oBUOpeobK2Oe/zEFeNiPmiJ3FpQH+lmNAEZOggmD9KTf7oKkXwOVfExs8XlbieIfqxPDv3xbLUGzkOAI/a0DMdt4J+pd4vRR/KUZzzNMV2sEHSEFCQojl1Cr20C1GBkJbqGGGK3MQikmEf+WTM88eUccryFhA8BeYGYmtc9DBMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ADAy4Eok; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E0626C32782;
	Wed, 17 Jul 2024 17:03:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721235795;
	bh=+Tkqhar4vQYGZIgL28NlgG1tVNG3i9So+0zA8BWKYOU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=ADAy4EokK98vyXeXYW5MT77jybMvGHPs73p6/SdOXYjy5xMoTncq+GXrw/YOJOeO2
	 F0BTW98E3RYolYZj5gbDnpCuJL7jRmlawYfFobrsXiZSuuSI9e1cnlXkyCRhx/E1Ui
	 PUUf+6/ppEIAqwz3OlSPh42cpUfl0DfXx+aiihqilj17ztWvD9xGwfynWtZ2sb9OlS
	 bbWxNRYtYieLkSzyNXdDATWrtOyv+xRCAAPJQw5StEGTL4oPenWPv33xG4ymh0ia4k
	 A4GxqEB95e9APlAyB+cTHfg0R9wyoow7u5fTH2p3SOBKZ+ISTTDV+mMc0m13f6O7rN
	 Ui7Uwm27HbQmw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA22DC3DA64;
	Wed, 17 Jul 2024 17:03:14 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.linaro.org@kernel.org>
Date: Wed, 17 Jul 2024 22:33:07 +0530
Subject: [PATCH v2 02/13] PCI: qcom-ep: Reword the error message for
 receiving unknown global IRQ event
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240717-pci-qcom-hotplug-v2-2-71d304b817f8@linaro.org>
References: <20240717-pci-qcom-hotplug-v2-0-71d304b817f8@linaro.org>
In-Reply-To: <20240717-pci-qcom-hotplug-v2-0-71d304b817f8@linaro.org>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1256;
 i=manivannan.sadhasivam@linaro.org; h=from:subject:message-id;
 bh=B8RUdvVv9QEg4h2fDtSWIh3luhRVOKTDULQMHpO/Rk0=;
 b=owGbwMvMwMUYOl/w2b+J574ynlZLYkib/tNXaTf3+oRjsXtz5yuu3C7eMKHk55G+qVlyZYt0J
 lY+eJ03s5PRmIWBkYtBVkyRJX2ps1ajx+kbSyLUp8MMYmUCmcLAxSkAE2l4wsHQMJ+VPVogK3H2
 x/uMN/f9Vb+W5VAql/rB74JId1/KqdzoU39NqzhyFKsuZhdPlXB3muSaGBTiViT/5mL0A5mQ5dx
 bkr0F9/eKG+09Ft78JGqOUgpLJHvvFcmYJadtNP9u6Jkxs7CzTWyXXad3dt+Z9PWTzjfN49vpbu
 Ucpll68OhFo4o7cd1hfvsmqjzhvCHG0SNgW8pi5uBbfchNxPSz2VyxWXVfGj0FHlQWsPyWvTx3d
 7elkmt9YW11eWN0r17wpfM+ue8k7V7/ybo7xTmGNfnszJVKC436Q8z1GpJWLdX4lPByxqTla6w6
 +V5tV8uf9TX90exPa/1tk1sLfrQYM/LYSN8rnqv3vvsFAA==
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



