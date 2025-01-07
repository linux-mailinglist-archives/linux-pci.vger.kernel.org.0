Return-Path: <linux-pci+bounces-19458-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A1F74A0490E
	for <lists+linux-pci@lfdr.de>; Tue,  7 Jan 2025 19:15:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BA73165E4D
	for <lists+linux-pci@lfdr.de>; Tue,  7 Jan 2025 18:15:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9BB7198A0D;
	Tue,  7 Jan 2025 18:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dXWQuw4u"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D4D6199931
	for <linux-pci@vger.kernel.org>; Tue,  7 Jan 2025 18:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736273738; cv=none; b=TRrS3Xqqo6GS17ZIukMVXoEHckYFU5OazucRYr2/o/Ei/hGBYTP8eS/WlBubTPlbCXbKVEpazD6nGM9mSwjbuozGNRpaFT9z+PPZ/arO2Wy2C30yXbN8/cAN6I+K3qzp6MWDz9682QXydkD3CVRbASVM8CXapUb/WtQPDBZ7BD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736273738; c=relaxed/simple;
	bh=9O4nRSIfQmKcND2iuEtQIlbKli8kf9nI8aNTK97IxIc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MI0w4wXeDxAmT04aI0vRGiY//QY949SAnmtuq701sr1QJHnuu/Cwq7YO5F/PZMv0rMyGaskYC8gVhQ0RC0S4qrf2oOXgfUZ6yEjIg7389r21Xr2NOGEGpoOK9Ot/BB5E2M/bQGGkwb/OV9W+3JZpw/hO5N9e3TK3QMnG3t8H5YE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dXWQuw4u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17BC0C4CEDD;
	Tue,  7 Jan 2025 18:15:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736273737;
	bh=9O4nRSIfQmKcND2iuEtQIlbKli8kf9nI8aNTK97IxIc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dXWQuw4uGDguVWZ5O+D4YKYmhD0xqN1zldP77u1wg4DimYCbhQlpWruUhSs0CBaxk
	 C6xp4UCHHE9HuMAVvROfpvD68wHN6PcbyKjbniHUYIJR9uALGKPSaub2CZb0xqXnmk
	 WXr4OlX3M9HTHQvt7cCuGBUQ7FYz96ZwvtkSZEb2imjHMBNH04AJX3iRvQ4IajHW6V
	 XpxqNl8VnZYi93nQFRScg8r2ghWxMmJVd0HFalURMAe1czjcXLNTnIDAVuHWzHJXcK
	 GJnBtb3PRVQ+23yA/NoIgHdU73bkWJ2j3p4i3Q/vfF7KLwZmWXufp1buSznYaHL659
	 5xEe+tkdGr/OQ==
From: Niklas Cassel <cassel@kernel.org>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	linux-pci@vger.kernel.org
Subject: [PATCH 5/6] PCI: keystone: Specify correct alignment requirement
Date: Tue,  7 Jan 2025 19:14:55 +0100
Message-ID: <20250107181450.3182430-13-cassel@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250107181450.3182430-8-cassel@kernel.org>
References: <20250107181450.3182430-8-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1604; i=cassel@kernel.org; h=from:subject; bh=9O4nRSIfQmKcND2iuEtQIlbKli8kf9nI8aNTK97IxIc=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGNJr8xVll55u3cHToJPoHTdjd/vSlXL917lzpWp07a8nf T4Ys9Sio5SFQYyLQVZMkcX3h8v+4m73KccV79jAzGFlAhnCwMUpABOJX8Lw37nZjl/Qzbxc7k2c CLvYme7tL4W6cyZOOtF1mEWwwnalKSPD3qtzowz9diUxme+ureDiZkgTfRQVtuzhgcoJ+vZPS1d xAAA=
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


