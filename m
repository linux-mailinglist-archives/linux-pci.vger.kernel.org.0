Return-Path: <linux-pci+bounces-44142-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 46461CFC901
	for <lists+linux-pci@lfdr.de>; Wed, 07 Jan 2026 09:18:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E6BF0304DB50
	for <lists+linux-pci@lfdr.de>; Wed,  7 Jan 2026 08:12:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BCBB285CB6;
	Wed,  7 Jan 2026 08:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ce56Ztky"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1113B284671;
	Wed,  7 Jan 2026 08:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767773521; cv=none; b=oKbY0WjKXfhB3hBzNlD5r/cliY19yPb6n0nUXNW4Mkcq56ko62kzZEAmsyXgSJW42l5+2DlJJ2QnR+PsNuW/4S/lGwPR0yXiDuBPQ22NAEwj9gJ5RIOLRzL1HkW25poKhyIgYTZGwrARLiFX8au5w76pH86S5QC3JmnLYdDeyeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767773521; c=relaxed/simple;
	bh=ZmgHyGVZ7Y7Lhqp48jneVD1fuTR1V2+N9+xDDw6lxOw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HD/83iYeogFhtBOaVPrVrGgIhigTayaeKVNbDxrEKT/8/2jRFF0n/Tm8yHRdis4QynkUt9mtwgOO9edEGybVw7YQkNGFtWcWS3vqLUuHrvY15HR8KkjRYG167jXyKbJ4mcFxDeXWG3lKadjNzdsD5MYB6GgwLHv7U3TJghi5bMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ce56Ztky; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id AF3B5C2BCB1;
	Wed,  7 Jan 2026 08:12:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767773520;
	bh=ZmgHyGVZ7Y7Lhqp48jneVD1fuTR1V2+N9+xDDw6lxOw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Ce56ZtkyAulwGbbYbx/fOCp2jbWkoJc0BD8o1riaZ9zPqwOLRATaeyV+V3N3TVwi6
	 PYwDwW0AGe7z2OpCtg8mDzoF0MULi0bdsNdE89GpT/LaY/HKbhmc2AzdtPqB4UTAWE
	 YhW+aKeEuq6tDQ4bVM4Dlr22KtuCdRSRoyjBQK3pYyUoX/tmzbt0YGY6irCj7AlZCY
	 9Q7yC4kBeZ7mFQ2pUg/71nXSGEgc6PMbAtd43fx0euxTgjPmMauWNlynqSGsZ3th6Y
	 KzXCxhCDez/V5KC5IG0cuZ2r1sX4SmJq4DYA31VMJwgyatSRxT9v2URnowsPweqxxt
	 amUa6SC+xSIEg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6E40CF6BFF;
	Wed,  7 Jan 2026 08:12:00 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org>
Date: Wed, 07 Jan 2026 13:41:57 +0530
Subject: [PATCH v4 4/6] PCI: dwc: Only skip the dw_pcie_wait_for_link()
 failure if it returns -ENODEV
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260107-pci-dwc-suspend-rework-v4-4-9b5f3c72df0a@oss.qualcomm.com>
References: <20260107-pci-dwc-suspend-rework-v4-0-9b5f3c72df0a@oss.qualcomm.com>
In-Reply-To: <20260107-pci-dwc-suspend-rework-v4-0-9b5f3c72df0a@oss.qualcomm.com>
To: Jingoo Han <jingoohan1@gmail.com>, 
 Manivannan Sadhasivam <mani@kernel.org>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
 vincent.guittot@linaro.org, zhangsenchuan@eswincomputing.com, 
 Shawn Lin <shawn.lin@rock-chips.com>, Richard Zhu <hongxing.zhu@nxp.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1204;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=CClkmOJOF6jdGk3GCx6uryCHLsqrAzBQPUqzwqi9zYU=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBpXhVOGmRP2AlbYJACIPOBXvP1+/o5cQd7NabzK
 z/MLTmp+ROJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCaV4VTgAKCRBVnxHm/pHO
 9UtFCACEtjoJo3LIhw+8whZppEXDWvFUJgzWrjFas8UhhcWf7Ra4CCWrNMBN6Vmp212C9RHtYkQ
 s/Tmskd2ukLK6xrFr+NM/y08MhV1Py5fUz5T2jY279wm3fXhnVFUQtK3p+y8K+Y5uOEmV33qS3m
 CJ5Ro2r6QWkfWq/6Xc0GvLp3rX8YwuKEmGgvJxX93Qdtpkj/gd98wGeMjBDyxTJIIiNhHlOoObZ
 hIAa+kq3R3V0BhkMqIAImUKK1PD5Ro0FOqlCiYRNlCFHRYk2M+XgxXNrfUd0DSA1VG3C0KaqUlp
 Nz3wuVzqevSWFHcoOU7qegpmU7AaAlrqwmGGQi3yhKVaxbqY
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



