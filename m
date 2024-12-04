Return-Path: <linux-pci+bounces-17675-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 110089E421D
	for <lists+linux-pci@lfdr.de>; Wed,  4 Dec 2024 18:44:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D77CC168D14
	for <lists+linux-pci@lfdr.de>; Wed,  4 Dec 2024 17:44:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98308206F14;
	Wed,  4 Dec 2024 17:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WuzE20DP"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DE9122E3FE;
	Wed,  4 Dec 2024 17:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733332338; cv=none; b=C0e2Err/1U44r+4o6f1/+u2QiFy7rGviE980pwp/G7X0+gdN+uot54VuVhK2MQVkJKr7AkVnPRiHxmRRexiJjJRIqGBAeuu8hmlQ01SoB9ebFvCE41JntiPP9ii/dUyK1SE0EyHcUVXeMEvcQAlKpJP69ORx4vxRUr2e4QwPyBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733332338; c=relaxed/simple;
	bh=YuE73BkZ0RKOKhmYk3ZgKO630w+ip7/J13UrungYeNk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G/8nVobd+tE214Kg4z33bZLsdbK7Y+W9Y+smxKIKzyvfeKMBrVeypTeXwqWFvcAvIgvvD58tkuXY4a9cuUofdw6EBstE+Tndi3W1XlvhHaC23B8we1VkhNTJvbfXJUYJIqDw81lmiPd7gHEi3mB9t766L1AuQ1+DiVhtZw/eyUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WuzE20DP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9017C4CEDF;
	Wed,  4 Dec 2024 17:12:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733332338;
	bh=YuE73BkZ0RKOKhmYk3ZgKO630w+ip7/J13UrungYeNk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WuzE20DP5hg7sHq/3s+F/v44/kiRZ525Ja1wgoRMVrxlZaFQg+qxzXTLY/U76VDxY
	 FYWFv399ctqUP6x03S1+pTGazDzhlsiuLBRYPMt+gWsx9siF60ZJCUoHJJgiehXAq2
	 N8WlWX+bz/mdqlZKl85sHss1EeIU8Q7DTMCGdsyw66L2tkNAK0uYflD/FzCKKjLHsG
	 Ou6Nqvh18kcstnkNIgedoaflFnZ7DLf/QE/uOE0sEzB82L4T+M/U1BU/dqIr/oM3Ei
	 LGraQXhhIW86obRSIuQCDMHrpp3hP+L9esxp7RLkwWGHAsmQYgvqTTsN2N262m4uFh
	 FCGBlxs/bFzlg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Mayank Rana <quic_mrana@quicinc.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Sasha Levin <sashal@kernel.org>,
	kevin.xie@starfivetech.com,
	lpieralisi@kernel.org,
	kw@linux.com,
	linux-pci@vger.kernel.org
Subject: [PATCH AUTOSEL 6.11 08/13] PCI: starfive: Enable controller runtime PM before probing host bridge
Date: Wed,  4 Dec 2024 11:00:33 -0500
Message-ID: <20241204160044.2216380-8-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241204160044.2216380-1-sashal@kernel.org>
References: <20241204160044.2216380-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11.10
Content-Transfer-Encoding: 8bit

From: Mayank Rana <quic_mrana@quicinc.com>

[ Upstream commit 6168efbebace0db443185d4c6701ca8170a8788d ]

A PCI controller device, e.g., StarFive, is parent to PCI host bridge
device. We must enable runtime PM of the controller before enabling runtime
PM of the host bridge, which will happen in pci_host_probe(), to avoid this
warning:

  pcie-starfive 940000000.pcie: Enabling runtime PM for inactive device with active children

Fix this issue by enabling StarFive controller device's runtime PM before
calling pci_host_probe() in plda_pcie_host_init().

Link: https://lore.kernel.org/r/20241111-runtime_pm-v7-1-9c164eefcd87@quicinc.com
Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Mayank Rana <quic_mrana@quicinc.com>
[bhelgaas: commit log]
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/controller/plda/pcie-starfive.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/plda/pcie-starfive.c b/drivers/pci/controller/plda/pcie-starfive.c
index c9933ecf68338..0564fdce47c2a 100644
--- a/drivers/pci/controller/plda/pcie-starfive.c
+++ b/drivers/pci/controller/plda/pcie-starfive.c
@@ -404,6 +404,9 @@ static int starfive_pcie_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	pm_runtime_enable(&pdev->dev);
+	pm_runtime_get_sync(&pdev->dev);
+
 	plda->host_ops = &sf_host_ops;
 	plda->num_events = PLDA_MAX_EVENT_NUM;
 	/* mask doorbell event */
@@ -413,11 +416,12 @@ static int starfive_pcie_probe(struct platform_device *pdev)
 	plda->events_bitmap <<= PLDA_NUM_DMA_EVENTS;
 	ret = plda_pcie_host_init(&pcie->plda, &starfive_pcie_ops,
 				  &stf_pcie_event);
-	if (ret)
+	if (ret) {
+		pm_runtime_put_sync(&pdev->dev);
+		pm_runtime_disable(&pdev->dev);
 		return ret;
+	}
 
-	pm_runtime_enable(&pdev->dev);
-	pm_runtime_get_sync(&pdev->dev);
 	platform_set_drvdata(pdev, pcie);
 
 	return 0;
-- 
2.43.0


