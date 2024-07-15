Return-Path: <linux-pci+bounces-10278-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B8DB93196D
	for <lists+linux-pci@lfdr.de>; Mon, 15 Jul 2024 19:34:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5603B283443
	for <lists+linux-pci@lfdr.de>; Mon, 15 Jul 2024 17:34:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 043C561FC5;
	Mon, 15 Jul 2024 17:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GCHwg1da"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFD8A55896;
	Mon, 15 Jul 2024 17:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721064829; cv=none; b=ZoU2hK7XFhYaO4utqcngu0MkaJrJEf9YGoeto2Cb00iqjw8ZQfnR6Hta2PdeHEV0Mjyvg1t0GzSrQA0GIsY4bB5QQGHKxhiwK+IQQIKPjy9nuSeogZ4Xp2ynIxQWlnYvos4SRGbsVIDK6Ppl7HSMxnWu5mnD2Kk8409Pj9XXRDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721064829; c=relaxed/simple;
	bh=2AeLNtUBMvyq43scfhfH+ATGBfIyG/I8IhPiiu0Thtw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=URYZHYs7jn0n3B4JUssVzGz8qDTA2zXoJwSkMR/JCNraV8QuqJUnxcVAwh7HShYI+ldYP0UwFqTljHLrJlUySbDLW5ZvyNlVQK9z2vp1FY/Ij7zp6PVxIMC11mdXQDzdyQOPl3sBXPUgc6CF60LOTqu5d0N7lqhoQ/NwPzLV9a8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GCHwg1da; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7037AC4AF0F;
	Mon, 15 Jul 2024 17:33:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721064829;
	bh=2AeLNtUBMvyq43scfhfH+ATGBfIyG/I8IhPiiu0Thtw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=GCHwg1daE9Guc4NPX3aR3QvcyBY4o0T+rOXGeBkRdZ4V6jrbxh6FxE1rIKouoncii
	 8RmyV+7Out+7488tC+s8i0q7IYbKh/JG6Z/Hs+OzlaKXZTN/Yx4vBWXZ4Mj1gkTisf
	 CPawBz7TregVgH2c2yNT9V9X9lhVEj10uJ3rkr3d96V93PL9x+nKbU7xIPfWwJ/Klp
	 nlj7kbrS9wD+KctcG0+4MFSIcFbFrpEx2m/8U05PgLPE4rAfihEAOz9LhK+ZPl/EBG
	 rmx0HrV3VxZ2O7Qm1MIng4JMhqKBpYOEL3g5ug4oBtvp4S3QIZqkSnQWgbhFTVDulG
	 scIYaNxBCJlsg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64CB8C3DA60;
	Mon, 15 Jul 2024 17:33:49 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.linaro.org@kernel.org>
Date: Mon, 15 Jul 2024 23:03:44 +0530
Subject: [PATCH 02/14] PCI: qcom-ep: Reword the error message for receiving
 unknown global IRQ event
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240715-pci-qcom-hotplug-v1-2-5f3765cc873a@linaro.org>
References: <20240715-pci-qcom-hotplug-v1-0-5f3765cc873a@linaro.org>
In-Reply-To: <20240715-pci-qcom-hotplug-v1-0-5f3765cc873a@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1070;
 i=manivannan.sadhasivam@linaro.org; h=from:subject:message-id;
 bh=JCsYTkuXXXhcuENPNzaZvR8u/dChlzvKuuKaF9P+7zw=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBmlV14QVjURbmKvogp/beRq+rrFjLZw7fylgAgA
 objhy0MyT2JATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCZpVdeAAKCRBVnxHm/pHO
 9XK4B/4trxc4KZfujiglm6c9LAzE6vUPsdr2rj/6hxTB844v6joCV7FZ97V+u4oqXWExMK1iFFR
 d4tWeUCRMfZfFEIEnyeEuSljW+e4elQZt7zpLT1gv7AFiukySJXrgyvbRwV/7rPxX1AAlhuwcUV
 epUijoRNuGLtSECo4A6j2wu8scZUpZWLssd0krrix7SIqqhIVFunPEdnjhI18+dTlNtot6Kb6CP
 I9k0VgZjGuFBEfWAa1BxKVTo1hNy/DIOBRNumFEhK6CiZGyHYuiGNbx2LIEbiyPR2lyXz933Le6
 uPIP+1QAhPwBGrPtDqvYpkJE6WKzHwv23olwzn1KgAXJTTpi
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

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/controller/dwc/pcie-qcom-ep.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom-ep.c b/drivers/pci/controller/dwc/pcie-qcom-ep.c
index 972a90eba494..cda5d8fdc03b 100644
--- a/drivers/pci/controller/dwc/pcie-qcom-ep.c
+++ b/drivers/pci/controller/dwc/pcie-qcom-ep.c
@@ -679,7 +679,8 @@ static irqreturn_t qcom_pcie_ep_global_irq_thread(int irq, void *data)
 		dw_pcie_ep_linkup(&pci->ep);
 		pcie_ep->link_status = QCOM_PCIE_EP_LINK_UP;
 	} else {
-		dev_err(dev, "Received unknown event: %d\n", status);
+		dev_err(dev, "Received unknown event. INT_STATUS: 0x%08x\n",
+			status);
 	}
 
 	return IRQ_HANDLED;

-- 
2.25.1



