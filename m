Return-Path: <linux-pci+bounces-17679-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CB339E4232
	for <lists+linux-pci@lfdr.de>; Wed,  4 Dec 2024 18:46:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D998287AD7
	for <lists+linux-pci@lfdr.de>; Wed,  4 Dec 2024 17:46:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E05B2312E5;
	Wed,  4 Dec 2024 17:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OiyVZ19d"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 728EC2312E2;
	Wed,  4 Dec 2024 17:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733332363; cv=none; b=pxzRMxVVLCCQH8+zBo49WXHE/AuPOEGYidjYSu3NvyPD9paunyBfo9VTRhtr8rkxlSZ+urlkA2fwRjyEfX5ug7Z9MDWqoZ8P3mywM37EnboLJyb/hG/FScvd8+lRugr9P0KANHNzl9rUL+j1cd1YIbHB2wqLJr54UFwoNg4D+LM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733332363; c=relaxed/simple;
	bh=mZm1Wa9Y/xB8oQtSH4gfHJeDg7CBtkeGspwV8L4wpOA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r1ux7QDk3k/BWyDa4nMDd6tPZg4ghQSSx5qWMATQ9cTNnvk/lKufYpVpw3xWPIWJkPujJGtJuAywtRxExr0ZOZnfeXeXs5Y5XJhlY0ACVdNaHmmHR2LMm8/blJ7ibCjTOec9LtBm/2Ld5JAHByga4Y9JM2bZIkChIJqzILoQ3zQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OiyVZ19d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0712C4CECD;
	Wed,  4 Dec 2024 17:12:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733332363;
	bh=mZm1Wa9Y/xB8oQtSH4gfHJeDg7CBtkeGspwV8L4wpOA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OiyVZ19d2qXqaHVpMXkT8hIm70yymWJYLlIXgr2sMoGmvL3MooBeklnZJJMhRvOll
	 qmyoNV33zayUYItMJUTF+uO9VS9vY+UkCO06G/hWkQ+hf1GWVOSlxQwfx58rq7nYwT
	 Gp7kMuGxYUqYxJBxofkyx/0oY6d4iafguSbBqC/vVIbbX9UMnJBfyp0Y8Nr+xezZxd
	 wdITdCZMmYYfubXKerF2KaEu6Tg8v5lFulnSNRD/tSzIDy6Ot7JaFYiwsFkgRkkSiy
	 /pCLNkuunc09GbMMzU6b2OTet8jvTLAMuIs1lJlcgvULuGZDH/EMirxCLin7uWNjk5
	 u/JKeoyLRJpcw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Nirmal Patel <nirmal.patel@linux.ntel.com>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Sasha Levin <sashal@kernel.org>,
	nirmal.patel@linux.intel.com,
	lpieralisi@kernel.org,
	kw@linux.com,
	bhelgaas@google.com,
	linux-pci@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 05/12] PCI: vmd: Add DID 8086:B06F and 8086:B60B for Intel client SKUs
Date: Wed,  4 Dec 2024 11:01:02 -0500
Message-ID: <20241204160115.2216718-5-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241204160115.2216718-1-sashal@kernel.org>
References: <20241204160115.2216718-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.63
Content-Transfer-Encoding: 8bit

From: Nirmal Patel <nirmal.patel@linux.ntel.com>

[ Upstream commit b727484cace4be22be9321cc0bc9487648ba447b ]

Add support for this VMD device which supports the bus restriction mode.
The feature that turns off vector 0 for MSI-X remapping is also enabled.

Link: https://lore.kernel.org/r/20241011175657.249948-1-nirmal.patel@linux.intel.com
Signed-off-by: Nirmal Patel <nirmal.patel@linux.ntel.com>
Signed-off-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/controller/vmd.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index 6ac0afae0ca18..ade18991e7366 100644
--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -1114,6 +1114,10 @@ static const struct pci_device_id vmd_ids[] = {
 		.driver_data = VMD_FEATS_CLIENT,},
 	{PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_VMD_9A0B),
 		.driver_data = VMD_FEATS_CLIENT,},
+	{PCI_VDEVICE(INTEL, 0xb60b),
+                .driver_data = VMD_FEATS_CLIENT,},
+	{PCI_VDEVICE(INTEL, 0xb06f),
+                .driver_data = VMD_FEATS_CLIENT,},
 	{0,}
 };
 MODULE_DEVICE_TABLE(pci, vmd_ids);
-- 
2.43.0


