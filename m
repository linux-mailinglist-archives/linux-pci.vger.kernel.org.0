Return-Path: <linux-pci+bounces-43857-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E16FECEA085
	for <lists+linux-pci@lfdr.de>; Tue, 30 Dec 2025 16:12:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 502BA303D300
	for <lists+linux-pci@lfdr.de>; Tue, 30 Dec 2025 15:07:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28A9731A049;
	Tue, 30 Dec 2025 15:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vA2cvGRT"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F396F3191C2;
	Tue, 30 Dec 2025 15:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767107261; cv=none; b=FT7ETfursXGWqgEL11+m/N90kMTWKO5MlE9pil9tgjfbGoDNc4aSdU79Sf8OKyAr0iaX6lhYC0B6rkuYcvB9/LuybV5p6M2vUMiJOJYKfUz8mjyREIEUZ5/H8OhhDIfJqD5Y0V+iq5Vav2rFUoTj9NQZXDMETEn8pW4tmeEgcg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767107261; c=relaxed/simple;
	bh=ZmgHyGVZ7Y7Lhqp48jneVD1fuTR1V2+N9+xDDw6lxOw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=V6s8Zpsx+pTaBu/kIshwXRvlNUKySGVG7IMSTeSLq0377nupKPE5cTqZgfz1MnTD90OetFBeCi0TysMdfuIO9x/TCZbGrVBZJchwMOSSMmZ/tXogQcmxOtrJBc6mYSOecY8t0Mk0DV8ITlmHUGgsQzXs1EfZnHzYgg383FgHzmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vA2cvGRT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 872B9C19422;
	Tue, 30 Dec 2025 15:07:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767107260;
	bh=ZmgHyGVZ7Y7Lhqp48jneVD1fuTR1V2+N9+xDDw6lxOw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=vA2cvGRT2lbEqxbWkWR40R8d+/XZL51bbotUPtV9o4MWMzPCOndXbSO5S4CB3A/o/
	 5e6T0vAA8D6+tsKC79jtRMf/XDRwvjMayB/ZF79YLV9Ox+8evjOrSUua0ZeQMsG5TL
	 eAb43NKUFSezd4cWx7fRYN6iL/QTJxo+zPkJZjrsDVv57Y65kqtzGdhEF1GOIK5mdv
	 LK+EGGlvv/Q1AhyZmNubCOMwerziz9Qwv85+ehYr3pMqplzlarPy/pQAsezBQiiQUC
	 ZnAWVTVuB5gzskAdpoK2tiy3SL/YJZActwtkxj+4AfZKOWHEfWDhkDUyPyUYQVzFqE
	 Mu6KnBc1yvQ5Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C560EE0213;
	Tue, 30 Dec 2025 15:07:40 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org>
Date: Tue, 30 Dec 2025 20:37:35 +0530
Subject: [PATCH v3 4/4] PCI: dwc: Only skip the dw_pcie_wait_for_link()
 failure if it returns -ENODEV
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251230-pci-dwc-suspend-rework-v3-4-40cd485714f5@oss.qualcomm.com>
References: <20251230-pci-dwc-suspend-rework-v3-0-40cd485714f5@oss.qualcomm.com>
In-Reply-To: <20251230-pci-dwc-suspend-rework-v3-0-40cd485714f5@oss.qualcomm.com>
To: Jingoo Han <jingoohan1@gmail.com>, 
 Manivannan Sadhasivam <mani@kernel.org>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
 vincent.guittot@linaro.org, zhangsenchuan@eswincomputing.com, 
 Shawn Lin <shawn.lin@rock-chips.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1204;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=CClkmOJOF6jdGk3GCx6uryCHLsqrAzBQPUqzwqi9zYU=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBpU+q61ZwmA12k0gctA5+P95OGdr4n6fxaFZeCz
 A8XkQzl0ziJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCaVPqugAKCRBVnxHm/pHO
 9dXJB/9Ss2PGxk0OVINcrmeDre6/hDbM6zBt2dMRWud6SNfN2XSafS6Ha1km6Rd9ed0iBQJMJxI
 S6Cu8DVrMTCfn1wlzrzXd2fl3jEh4yWoF1dB50k4rTGpebBFUVJ91MtQqheXdHXZ5rKWQk/pF51
 GjcJIGjgZuczOkTi7+kP4yQeTW0O9gmjkuNKt85WSPaa772s4mq+7ulhRKnpLDU8OLk4CvxBCHe
 r9VcAFOjS9G6RSIruuEq69jnY4ti/RDtfpAZKYHbtnd4vI7vxX+e6viFwB6btMY4N6TARjR2ts+
 xJZHMMQZMmIpn0DbYDqrFJ16P1xUQThz3AMo46xG0dQQ2YrP
X-Developer-Key: i=manivannan.sadhasivam@oss.qualcomm.com; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008
X-Endpoint-Received: by B4 Relay for
 manivannan.sadhasivam@oss.qualcomm.com/default with auth_id=461
X-Original-From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Reply-To: manivannan.sadhasivam@oss.qualcomm.com

From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

dw_pcie_wait_for_link() now returns -ENODEV if the device is not found on
the bus and -ETIMEDOUT if the link fails to come up for any other reasons.
And it is incorrect to skip the link up failures other than device not
found. So only skip the failure for device not found case and handle
failure for other reasons.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
---
 drivers/pci/controller/dwc/pcie-designware-host.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index fad0cbedefbc..ccde12b85463 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -675,8 +675,10 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
 			goto err_remove_edma;
 	}
 
-	/* Ignore errors, the link may come up later */
-	dw_pcie_wait_for_link(pci);
+	/* Skip failure if the device is not found as it may show up later */
+	ret = dw_pcie_wait_for_link(pci);
+	if (ret && ret != -ENODEV)
+		goto err_stop_link;
 
 	ret = pci_host_probe(bridge);
 	if (ret)

-- 
2.48.1



