Return-Path: <linux-pci+bounces-214-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D2587FB3CB
	for <lists+linux-pci@lfdr.de>; Tue, 28 Nov 2023 09:15:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2C539B213DA
	for <lists+linux-pci@lfdr.de>; Tue, 28 Nov 2023 08:15:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AFC9179BE;
	Tue, 28 Nov 2023 08:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RHUCTUN8"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6E2B168CA;
	Tue, 28 Nov 2023 08:15:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B476C433C7;
	Tue, 28 Nov 2023 08:15:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701159324;
	bh=hZl0Zl2shFZ9nd3i3exKHPLcrEYuE5Q2dGx/0v/2UmE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RHUCTUN8GpfK2qw9YG3t3WUpZ9OZZSAgsODxI7qZCH9vzISzi1F8eC0qa1rW5f6Sz
	 alWD3mRUTC9KjJpB7dC6VmfJiQVnEDyR+FM3y+r44EVKNAe4imgDRToE4wMRMg9+2y
	 UjsOlhGo0e9M6QqzwuTYr+aWI0ikhFWMYPlNdNiICzSd+ClUWMPv4Pv0Ex7kxwCsgT
	 UqrXJKK1RcWvnrMaYvxA/7lBqafpUrydIE8HvK8lnG6+8dn9LVJPrAIySV4NdkwgC5
	 iEbVty5i6hi2WP3/RgfLY1r6g4NDNHN6eXkJS4NN1W1i5nZkIrZmQpCQ/TEpa94/Da
	 zA2Vsjp4h0AeQ==
Received: from johan by xi.lan with local (Exim 4.96.2)
	(envelope-from <johan+linaro@kernel.org>)
	id 1r7tG4-00053r-1s;
	Tue, 28 Nov 2023 09:15:52 +0100
From: Johan Hovold <johan+linaro@kernel.org>
To: "Lorenzo Pieralisi" <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	"Bjorn Helgaas" <bhelgaas@google.com>
Cc: Andy Gross <agross@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Nirmal Patel <nirmal.patel@linux.intel.com>,
	Jonathan Derrick <jonathan.derrick@linux.dev>,
	linux-arm-msm@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan+linaro@kernel.org>,
	stable@vger.kernel.org,
	Michael Bottini <michael.a.bottini@linux.intel.com>,
	"David E . Box" <david.e.box@linux.intel.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 2/6] PCI: vmd: Fix deadlock when enabling ASPM
Date: Tue, 28 Nov 2023 09:15:08 +0100
Message-ID: <20231128081512.19387-3-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231128081512.19387-1-johan+linaro@kernel.org>
References: <20231128081512.19387-1-johan+linaro@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The vmd_pm_enable_quirk() helper is called from pci_walk_bus() during
probe to enable ASPM for controllers with VMD_FEAT_BIOS_PM_QUIRK set.

Since pci_walk_bus() already holds a pci_bus_sem read lock, use the new
locked helper to enable link states in order to avoid a potential
deadlock (e.g. in case someone takes a write lock before reacquiring
the read lock).

Fixes: f492edb40b54 ("PCI: vmd: Add quirk to configure PCIe ASPM and LTR")
Cc: stable@vger.kernel.org      # 6.3
Cc: Michael Bottini <michael.a.bottini@linux.intel.com>
Cc: David E. Box <david.e.box@linux.intel.com>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/pci/controller/vmd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index 94ba61fe1c44..0452cbc362ee 100644
--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -751,7 +751,7 @@ static int vmd_pm_enable_quirk(struct pci_dev *pdev, void *userdata)
 	if (!(features & VMD_FEAT_BIOS_PM_QUIRK))
 		return 0;
 
-	pci_enable_link_state(pdev, PCIE_LINK_STATE_ALL);
+	pci_enable_link_state_locked(pdev, PCIE_LINK_STATE_ALL);
 
 	pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_LTR);
 	if (!pos)
-- 
2.41.0


