Return-Path: <linux-pci+bounces-19660-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 931CCA0B492
	for <lists+linux-pci@lfdr.de>; Mon, 13 Jan 2025 11:28:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6846B3A13C9
	for <lists+linux-pci@lfdr.de>; Mon, 13 Jan 2025 10:28:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CE973C1F;
	Mon, 13 Jan 2025 10:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eKze5RCg"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78314235C07
	for <linux-pci@vger.kernel.org>; Mon, 13 Jan 2025 10:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736764088; cv=none; b=XYZZgMpP5q9bq6vSzBauaVMfIjJRPkRKb7XQnu211r5GOyrT4cvUB0UmVQaXAjrYcutfxLHx6Uhns5gY1pfT8tu9SJn4omszo4TmpuVj5B9phc3IJowA1p5aiJH6ThOmFK6wNxNYg9daOqLXmKed5vqPBOkYLHCdBj0lqgB2qCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736764088; c=relaxed/simple;
	bh=9O4nRSIfQmKcND2iuEtQIlbKli8kf9nI8aNTK97IxIc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A9LLgsnNMdoNUbPvNld6KnWkZKS2g2gis826+mVF1GbTGe5aa4dvKR6RyUXNgNGb7Ry/IQ+pzQQkJCb6G1LlDl3kDvvBuQ+KnRR+AZ0E+E6IiAgKz6/P1/pBBhYclruiqxGpQLJzzBMkRvQEs6OjzdE4B3B1WC5gJ40c0Ec7cqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eKze5RCg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6D04C4CEE2;
	Mon, 13 Jan 2025 10:28:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736764088;
	bh=9O4nRSIfQmKcND2iuEtQIlbKli8kf9nI8aNTK97IxIc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eKze5RCgbzv8dcfTltJK+m1k4CNZG9GWYrTjuoyVrMzaBEIp1ZCwlW7fBl625nSl5
	 eamfezyBTn7aqy4vgWMqAFIITmlXqUXTV5oL8tVUDe2PUjubEa//39dJE1XU5HxaSi
	 seWMT7hnCRukri4nPeJBMORy+IyvzqWNqcX+hEUX4+t0+ytesBk/AOTlA/CYF/Cq4k
	 cyUJK+Av20Zx7GUtkCbQJX+r1Xem86fiSsH1fc3mIvmcC2avbhiwDSDlNGjvu121P0
	 xZCj+qsICu0dtjkAUQC51ffKc6xmH0DWSc7hoviT4bh2KdGm9W1C1/4DYDpxkNVehU
	 O3DUBpewH6D2g==
From: Niklas Cassel <cassel@kernel.org>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Udit Kumar <u-kumar1@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Niklas Cassel <cassel@kernel.org>,
	linux-pci@vger.kernel.org
Subject: [PATCH v3 5/6] PCI: keystone: Specify correct alignment requirement
Date: Mon, 13 Jan 2025 11:27:36 +0100
Message-ID: <20250113102730.1700963-13-cassel@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250113102730.1700963-8-cassel@kernel.org>
References: <20250113102730.1700963-8-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1604; i=cassel@kernel.org; h=from:subject; bh=9O4nRSIfQmKcND2iuEtQIlbKli8kf9nI8aNTK97IxIc=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGNJbXs2UXXq6dQdPg06id9yM3e1LV8r1X+fOlarRtb+e9 PlgzFKLjlIWBjEuBlkxRRbfHy77i7vdpxxXvGMDM4eVCWQIAxenAExENIORYXXRdLatfAq/dySx nnNl4z5ipmESL6uQcSlM5ATHmpCe5wz/A0Sa74k9SK39e0cgwGFf5cmiFT8PLa8323eog7VDcd0 PdgA=
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

The support for a specific iATU alignment was added in
commit 2a9a801620ef ("PCI: endpoint: Add support to specify alignment for
buffers allocated to BARs").

This commit specifically mentions both that the alignment by each DWC
based EP driver should match CX_ATU_MIN_REGION_SIZE, and that AM65x
specifically has a 64 KB alignment.

This also matches the CX_ATU_MIN_REGION_SIZE value specified by
"12.2.2.4.7 PCIe Subsystem Address Translation" in the AM65x TRM:
https://www.ti.com/lit/ug/spruid7e/spruid7e.pdf

This higher value, 1 MB, was obviously an ugly hack used to be able to
handle Resizable BARs which have a minimum size of 1 MB.

Now when we actually have support for Resizable BARs, let's configure the
iATU alignment requirement to the actual requirement.
(BARs described as Resizable will still get aligned to 1 MB.)

Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/pci/controller/dwc/pci-keystone.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
index fdc610ec7e5e..76a37368ae4f 100644
--- a/drivers/pci/controller/dwc/pci-keystone.c
+++ b/drivers/pci/controller/dwc/pci-keystone.c
@@ -970,7 +970,7 @@ static const struct pci_epc_features ks_pcie_am654_epc_features = {
 	.bar[BAR_3] = { .type = BAR_FIXED, .fixed_size = SZ_64K, },
 	.bar[BAR_4] = { .type = BAR_FIXED, .fixed_size = 256, },
 	.bar[BAR_5] = { .type = BAR_RESIZABLE, },
-	.align = SZ_1M,
+	.align = SZ_64K,
 };
 
 static const struct pci_epc_features*
-- 
2.47.1


