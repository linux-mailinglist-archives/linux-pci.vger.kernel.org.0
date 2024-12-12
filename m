Return-Path: <linux-pci+bounces-18264-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B05929EE528
	for <lists+linux-pci@lfdr.de>; Thu, 12 Dec 2024 12:35:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D01A1883688
	for <lists+linux-pci@lfdr.de>; Thu, 12 Dec 2024 11:35:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 965A0211714;
	Thu, 12 Dec 2024 11:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cctn3u4B"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 734B4211A22
	for <linux-pci@vger.kernel.org>; Thu, 12 Dec 2024 11:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734003316; cv=none; b=E8nFaENHjazLsk4ly21PzqveWGuh4nXG2CswW3AR47sBQI3/enVWaO5gCMXxvzfm9SRmAm8cuiFtzGP2d8rQAezVQdQkxSfaDcx1ye7M4GHERGkbt9T5g+mQR33/AORuK16OMle/QSEcfjPMivFPG61V/elUoKuJOMoPahvpjis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734003316; c=relaxed/simple;
	bh=dZBG+7Cr8qW6187cdSEai55I2p24hR3EwtjXgP/1ONw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e/GJ8Zy4V/J3UUbe//1vpjWKQK9AzMvtpAd91aM3uROcyOP54zSIwN4C+OmAdYLyWMKB+4nY1nHKCNEjmNhI32D5FFH2Oca7glFWNdHQ8KibRnLz1Zs0kkwFPUXp8CMrRHH1BRwA7Cv76PE/f3XOa6EFgdFngVYnq2LaoBY/f6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cctn3u4B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8062C4CECE;
	Thu, 12 Dec 2024 11:35:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734003316;
	bh=dZBG+7Cr8qW6187cdSEai55I2p24hR3EwtjXgP/1ONw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Cctn3u4BAFt/PozMhGE5GKDcbt90Wd/QjYlE3Yp8P8uxDDDdjFQZSlAjOtkbV0rUT
	 T0ywfepox7xxy+EFwGO1GoOEu0N7ydBvOG9CoKlQgB+M8YIozJe6n7wuk3KdA0ZHc5
	 bJBx8sQJdMvbV40qKSeXXDjERk6e12+yiPR2QNhAJABmpBnpnHdBDcCZmixoyJFi8j
	 1xKo2Yve5sZGf4X+o4T5fc6tdv2BTq3cmkIVMjeMD0CFPDhftVCNMRB2j0Ktcgvj43
	 BWLyCKN3LyeWD1qZJK2+DVKZdE1W9CSvRvvO0v6WyzwVAqprhQsWl9v+7Z9/q3H2Pv
	 HWNNq9F0g2Srg==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-nvme@lists.infradead.org,
	Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-pci@vger.kernel.org,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: Rick Wertenbroek <rick.wertenbroek@gmail.com>,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH v4 05/18] nvmet: Add drvdata field to struct nvmet_ctrl
Date: Thu, 12 Dec 2024 20:34:27 +0900
Message-ID: <20241212113440.352958-6-dlemoal@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241212113440.352958-1-dlemoal@kernel.org>
References: <20241212113440.352958-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allow a target driver to attach private data to a target controller by
adding the new field drvdata to struct nvmet_ctrl.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Tested-by: Rick Wertenbroek <rick.wertenbroek@gmail.com>
---
 drivers/nvme/target/nvmet.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index e68f1927339c..abcc1f3828b7 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -238,6 +238,8 @@ struct nvmet_ctrl {
 	struct nvmet_subsys	*subsys;
 	struct nvmet_sq		**sqs;
 
+	void			*drvdata;
+
 	bool			reset_tbkas;
 
 	struct mutex		lock;
-- 
2.47.1


