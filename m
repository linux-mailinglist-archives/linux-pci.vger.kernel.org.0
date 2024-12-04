Return-Path: <linux-pci+bounces-17665-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CBF489E41EB
	for <lists+linux-pci@lfdr.de>; Wed,  4 Dec 2024 18:39:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A483C1688BF
	for <lists+linux-pci@lfdr.de>; Wed,  4 Dec 2024 17:39:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64A9620D507;
	Wed,  4 Dec 2024 17:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ku/fo5eD"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 380DE20CCEC;
	Wed,  4 Dec 2024 17:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733332299; cv=none; b=ogdPDLZiZFQakHCAjfo6eNd/5eM6pyQ1XByvtQU6Bwt0ESp0WAnNONDNLcJsUcjVz3LU+CQyzlmNc6jO3bzCKSWfTUe3qaYDGV6FM2EE/eSW9P4OmpYSsWCwxVT5gwIVLklZLLHfRSMyN5oNdynpu4uqIGtjDS9QI+DvoANUaGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733332299; c=relaxed/simple;
	bh=aNELj2R4hNSsBB2Ijcpi0CDd3nfn+3tdpBPbxd20Kd4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X4H6dgd7e2H1B3sJYdwS+mG7pJuGUNiE02D4v0AKoL/7vPBCQGsCT+Kwv46zotf5X8N+BgOIMCgjNyyFR8RtY874VrQIGboH5RYetOWwSSt27urUypDKkjuCQ9NECCPtIN0NzPV+VDd8EXfq7bToXMvl4s/SGKfSsYMVRt8i8ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ku/fo5eD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36B42C4CEDF;
	Wed,  4 Dec 2024 17:11:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733332298;
	bh=aNELj2R4hNSsBB2Ijcpi0CDd3nfn+3tdpBPbxd20Kd4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ku/fo5eDhJFcwe5aR58fIGNVFn4KfwaOwtD2wg0UPY4Q0cSLUfs0j41U44tNBa6Cm
	 2DRwQMLnmDlMk1H8w/FwiQBiVwpOYuwyuxBC1Rsmy9g//e6e3mzaP1xAyXUe+DxJX4
	 bTFH5lABGnqDHaF00HCaTAXVGGHUY3PqX/yxMwPSgLYe74cWOuoy1oJV9OH+q7B4j1
	 WeD22gSzEdOzubjfm4cku/TClpKv9JeLEVbmKuJjkaOCLRDyA1J39LxxeN4DmsXG3h
	 yTRXVQBqXVr2r/BMhbTQe6m/mU15hqA4FGjgaPYgG4vewNJaDqciz6VnscAkCo5VFO
	 ZVn0G1Mhz+Sjw==
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
Subject: [PATCH AUTOSEL 6.12 05/15] PCI: vmd: Add DID 8086:B06F and 8086:B60B for Intel client SKUs
Date: Wed,  4 Dec 2024 10:59:53 -0500
Message-ID: <20241204160010.2216008-5-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241204160010.2216008-1-sashal@kernel.org>
References: <20241204160010.2216008-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.1
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
index 264a180403a0e..8a036d6b7d497 100644
--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -1100,6 +1100,10 @@ static const struct pci_device_id vmd_ids[] = {
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


