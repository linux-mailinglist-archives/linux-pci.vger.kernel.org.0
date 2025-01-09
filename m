Return-Path: <linux-pci+bounces-19596-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C7815A070EA
	for <lists+linux-pci@lfdr.de>; Thu,  9 Jan 2025 10:08:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8EE70188A8F3
	for <lists+linux-pci@lfdr.de>; Thu,  9 Jan 2025 09:08:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0EBE214A70;
	Thu,  9 Jan 2025 09:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TSjPlr8H"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BCBC204089
	for <linux-pci@vger.kernel.org>; Thu,  9 Jan 2025 09:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736413643; cv=none; b=srzKT7E90+egKhx5FyFGjpio42Nd7GTv9hn5+CtYCzLkTt5zMlexF3ff8dAJWgWC4I9cr0aZOZFoMy1QcDoRr+NC591o4w/n62tGniK2Hhl3xHMLJOYoTKcheqPUKV7Vw6e+3KknbVx4N9sA2YVmoCmXFIMUd8QFOrmwRRZaPtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736413643; c=relaxed/simple;
	bh=9O4nRSIfQmKcND2iuEtQIlbKli8kf9nI8aNTK97IxIc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DgwosGci/XkmbCD8T33kH12QAHZXoAuEbszS7o4vKIfH9wXEhv/saEI6pKmeMFowNWFJovNB9YMZ3wEIp9KMXFOiIt1MKygyPvTzUp7DXJMemVTro6K8QRNlg0jyBys2SqrzLe7dkAHG20G89JqA6/G7m5gy9jvyoxFTwlYZ024=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TSjPlr8H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67B60C4CED2;
	Thu,  9 Jan 2025 09:07:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736413643;
	bh=9O4nRSIfQmKcND2iuEtQIlbKli8kf9nI8aNTK97IxIc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TSjPlr8HkUsMiIkLjMpY1K8jgvNRKvQg55njPzFFYp+TvpM34uk/uxT2tK+9KojFP
	 MdBMHXqweaTcRUzwzjsFr30q1r1kP36tKsNQ/lgBjDQpSxndJDUedKaM+szLXFySj8
	 m19JQk/LqAY3oz/zc8XbgOQKRW6hXUo8YO7i/mwY7HtDfjy7oBtwjdvXSttlFZP/BC
	 G42JVo01mx1Iis4rFjyMEXnZ/hM05TvZctS3+fBlubBiSfTJZ6yClUqn2/LTHHBl6e
	 CabSr0HG4Lyk5lKqJEI+KBunYpD4ZFc3IvLwnZvqlfWOYhh8bEVwQq1pwb5zEQI3uO
	 AcSTAFcKEn/Pg==
From: Niklas Cassel <cassel@kernel.org>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	linux-pci@vger.kernel.org
Subject: [PATCH v2 5/6] PCI: keystone: Specify correct alignment requirement
Date: Thu,  9 Jan 2025 10:06:57 +0100
Message-ID: <20250109090652.110905-13-cassel@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250109090652.110905-8-cassel@kernel.org>
References: <20250109090652.110905-8-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1604; i=cassel@kernel.org; h=from:subject; bh=9O4nRSIfQmKcND2iuEtQIlbKli8kf9nI8aNTK97IxIc=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGNLrJ26SXXq6dQdPg06id9yM3e1LV8r1X+fOlarRtb+e9 PlgzFKLjlIWBjEuBlkxRRbfHy77i7vdpxxXvGMDM4eVCWQIAxenAEwk4REjw+yTXy0sDxTOXbGm 7rzAsnShSbsM75sIHuqP3Lqc//etMAZGhs7j93v+//nzRkFI6lCq9/tDh7ZcW6Or8erJfyEDvtl GgfwA
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


