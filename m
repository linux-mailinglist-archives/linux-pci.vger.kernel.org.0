Return-Path: <linux-pci+bounces-27217-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B46AAAA933
	for <lists+linux-pci@lfdr.de>; Tue,  6 May 2025 03:09:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14C3316D8E3
	for <lists+linux-pci@lfdr.de>; Tue,  6 May 2025 01:09:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1D6B359DF7;
	Mon,  5 May 2025 22:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J8aZJDJv"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBF3B359DE4;
	Mon,  5 May 2025 22:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746484970; cv=none; b=p/VDLkXbD9Z1+vJ49Y3K08rEG7/4rjLE2ApBXh+E2WdC6Rc293KCeu8MgphgUVX3Qzoc5bPoZcgGj/O3ky2AIA7iW5osZMCHcU5miRH7I5/6MQE3rAsbJ50OFSbGfLkR8/tUZG6hB3nuWBB88bFTNH1UTYyoMLdX+qGaQ1CrTHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746484970; c=relaxed/simple;
	bh=WjO+egmhL/vXMYc7GhB8oOhdYaKPrwDEGtWK5+ykUtk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NtIiEiTJ5VUHm5k1WiZU/r0j6SXEEV6M2Gbztq39LpANRZ8soN7Hsxra0XQN2quvjDJ0jamSbtemqCMUqAa/LPaQMe0n/LcyuWLj3J+978wYZmi9ft6F9WrEUotHjfLlrPGfgIOsSX+wBlTegG3rz/df3nMddgI1wgzL68A6jxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J8aZJDJv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5FC1C4CEE4;
	Mon,  5 May 2025 22:42:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746484969;
	bh=WjO+egmhL/vXMYc7GhB8oOhdYaKPrwDEGtWK5+ykUtk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=J8aZJDJvu2DZQQt0JDgA7zN8kSJLwbkd+dSMcQBsEq3/QVF9lNiPqrzWv3iknBRT7
	 iAeoeNIZVccs/B3D4h8zE+RKBMFZhXR6v14VmqOSu3Znnbqd5/XvI5rBqQnBa6mV+h
	 TJL8uvq8ZZ79nmSfHRCorL2UYjloerUJJVpavVytbjTAmQbYhHnjaJqkaWrV5ZP6hB
	 23uyA+VzPeruznH7Qbbw8K/ZiVznfi5GwSlDajmY8WSMQtw6elF3tIXICJcXPQH/u0
	 ieAOW4/gjSPMzpthkqzt62lOvxV4DIr0712LMbbtNCbH47aU/hbqNjmuPCxtI4Lk4w
	 JvT3Rrx+M/O6g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Frank Li <Frank.Li@nxp.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Sasha Levin <sashal@kernel.org>,
	jingoohan1@gmail.com,
	manivannan.sadhasivam@linaro.org,
	lpieralisi@kernel.org,
	kw@linux.com,
	linux-pci@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 101/486] PCI: dwc: Use resource start as ioremap() input in dw_pcie_pme_turn_off()
Date: Mon,  5 May 2025 18:32:57 -0400
Message-Id: <20250505223922.2682012-101-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505223922.2682012-1-sashal@kernel.org>
References: <20250505223922.2682012-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.26
Content-Transfer-Encoding: 8bit

From: Frank Li <Frank.Li@nxp.com>

[ Upstream commit 8f4a489b370e6612700aa16b9e4373b2d85d7503 ]

The msg_res region translates writes into PCIe Message TLPs. Previously we
mapped this region using atu.cpu_addr, the input address programmed into
the ATU.

"cpu_addr" is a misnomer because when a bus fabric translates addresses
between the CPU and the ATU, the ATU input address is different from the
CPU address.  A future patch will rename "cpu_addr" and correct the value
to be the ATU input address instead of the CPU physical address.

Map the msg_res region before writing to it using the msg_res resource
start, a CPU physical address.

Link: https://lore.kernel.org/r/20250315201548.858189-2-helgaas@kernel.org
Signed-off-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/controller/dwc/pcie-designware-host.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 120e2aca5164a..d428457d9c432 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -902,7 +902,7 @@ static int dw_pcie_pme_turn_off(struct dw_pcie *pci)
 	if (ret)
 		return ret;
 
-	mem = ioremap(atu.cpu_addr, pci->region_align);
+	mem = ioremap(pci->pp.msg_res->start, pci->region_align);
 	if (!mem)
 		return -ENOMEM;
 
-- 
2.39.5


