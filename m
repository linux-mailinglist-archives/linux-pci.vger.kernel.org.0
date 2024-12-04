Return-Path: <linux-pci+bounces-17668-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9C809E41F6
	for <lists+linux-pci@lfdr.de>; Wed,  4 Dec 2024 18:40:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B2912849BE
	for <lists+linux-pci@lfdr.de>; Wed,  4 Dec 2024 17:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CC7420FAA7;
	Wed,  4 Dec 2024 17:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WC/0hcny"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 510AF20FAA1;
	Wed,  4 Dec 2024 17:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733332304; cv=none; b=LCMEGH1VSjOS7c6wrzivvQJ8s+xr0FCzDQGsST9QrZ4nIQD4ntvUzHpk9zDkUCxJrV2yVjSng4p9i72XPVzMa1Zs8qsE7UpYhDUkMGDminMIUz6zZdyV9/QJThDYurwS7t6qd3ATQojhbC4EXvJPeWV61tMogAVhosUAQ6mAE3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733332304; c=relaxed/simple;
	bh=YuE73BkZ0RKOKhmYk3ZgKO630w+ip7/J13UrungYeNk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nM4aO4HUtE5AXlGzi0rSO3SJuGAnW4D4vw4AXpuuy9WnN/RVI10Wcowf4qHMRJCZBVtNAZFn9LGp2BRyBVuQjUb+LQVL3lrpHcihcpmdHWBE3ZNOO6Dde3esIiMk6GuUviAqXhh7eqQsGxB8xqwTXh9LZ7XpQSWntprpQOXCEv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WC/0hcny; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEDE5C4CEDF;
	Wed,  4 Dec 2024 17:11:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733332304;
	bh=YuE73BkZ0RKOKhmYk3ZgKO630w+ip7/J13UrungYeNk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WC/0hcnykl2vTkT8Vb8PTP3N+gU/qS3gD56SClkJjf8NCKesZJRofW/JWwm1qUFZk
	 91MY+q+FfpYKdRaEfR7/cnwgHeq4V+wSNC3xR8+U+wRl0AZdK0UD8JOah6kGGnJRu1
	 m7Qpv9N3ErG/ezQLZvYUxnTr8DMgdinXrSL43fvSkShNtnWVvf4NIK+4emCGGSxe9z
	 js12QaqYrjlLWScPLpRg9ezQguNjfBnD9bZfCv6HK6wiOrOpVOSvnom5u3SMcEnzuP
	 T2kjO0qQz4CAM6GDckdQuJnLZzdEm+1ywfw/DaKB1kNTwEdGUBIzjcWzLtOh1PydB1
	 nVUKbXf4opY2A==
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
Subject: [PATCH AUTOSEL 6.12 08/15] PCI: starfive: Enable controller runtime PM before probing host bridge
Date: Wed,  4 Dec 2024 10:59:56 -0500
Message-ID: <20241204160010.2216008-8-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241204160010.2216008-1-sashal@kernel.org>
References: <20241204160010.2216008-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.1
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


