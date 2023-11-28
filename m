Return-Path: <linux-pci+bounces-210-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 221507FB3BF
	for <lists+linux-pci@lfdr.de>; Tue, 28 Nov 2023 09:15:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5344B1C20D7C
	for <lists+linux-pci@lfdr.de>; Tue, 28 Nov 2023 08:15:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D992E171B9;
	Tue, 28 Nov 2023 08:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FhT+l7PX"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B406616408;
	Tue, 28 Nov 2023 08:15:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F922C433C8;
	Tue, 28 Nov 2023 08:15:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701159324;
	bh=eo9kfCbX6q6KqiGf0IQeZw8TC/sg5ZoML6hbCiQxCyA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FhT+l7PXlqUxL/MIP3Y7OseSVvJgSBqwJ0NFYzrGzUipm7r2F6mpBdP7paJmdWhh+
	 DI/+/J1LQVf6MFh60xle1fwBz4Rn6xdu4/PVJeUPpl8zCp4brsWBv5N2s6dzEJAdfm
	 KQJX40OFdVLnW4sUIi67dD+58Lld9ceNlUMD69MeplYBC8g3HNDmaFPWfU9M7jHsct
	 dumf/hMFtcSHTaGCplamCJT0V4BxwbTkVybyHdT4TIgv1+sBzpij+PUErXnVQbwHmC
	 h1gsSSevRrwDSFsVkNd7VM3izHEij8WFraOW6fTjIjHTjJAGrZD/OmJ4XwPV3H8NAL
	 waHw9ivwGPlEg==
Received: from johan by xi.lan with local (Exim 4.96.2)
	(envelope-from <johan+linaro@kernel.org>)
	id 1r7tG4-00053v-2S;
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
	Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH v2 4/6] PCI: qcom: Clean up ASPM comment
Date: Tue, 28 Nov 2023 09:15:10 +0100
Message-ID: <20231128081512.19387-5-johan+linaro@kernel.org>
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

Break up the newly added ASPM comment so that it fits within the soft 80
character limit and becomes more readable.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 21523115f6a4..a6f08acff3d4 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -969,7 +969,10 @@ static int qcom_pcie_post_init_2_7_0(struct qcom_pcie *pcie)
 
 static int qcom_pcie_enable_aspm(struct pci_dev *pdev, void *userdata)
 {
-	/* Downstream devices need to be in D0 state before enabling PCI PM substates */
+	/*
+	 * Downstream devices need to be in D0 state before enabling PCI PM
+	 * substates.
+	 */
 	pci_set_power_state(pdev, PCI_D0);
 	pci_enable_link_state_locked(pdev, PCIE_LINK_STATE_ALL);
 
-- 
2.41.0


