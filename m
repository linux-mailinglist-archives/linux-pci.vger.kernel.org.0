Return-Path: <linux-pci+bounces-18002-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 765F59EAC6F
	for <lists+linux-pci@lfdr.de>; Tue, 10 Dec 2024 10:37:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E373188B69D
	for <lists+linux-pci@lfdr.de>; Tue, 10 Dec 2024 09:37:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B50D7223307;
	Tue, 10 Dec 2024 09:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L2ETE7vx"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D79D2AEE7
	for <linux-pci@vger.kernel.org>; Tue, 10 Dec 2024 09:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733823285; cv=none; b=itEXiPcRxIfPs3TAUfDwVHrqiDX1s3lYNFqR/TXpo/SrHDVQcr2h5yJz/UIbkhKrbEP9+Nim0xys/aNL4bYrZLQNxXv/2GchI3AZsuKBVLb7mXtWdMEek/jZke88RejH95MwgMzUC7+SLK88qE0KuS3/YIJiLHaIeUllTbEJrac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733823285; c=relaxed/simple;
	bh=fvnoQyhJzDikdPgkmR97fnyZzwgdUNiPmqC+qs3AwAw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vDD+0El5teNw6ouEh4jUTwpZXL4Fs0L86jjyJM3O1ioWJhLU4CFEQmPCx3sNRKxREOVk27DDBMTR6wGYj147VI0iTI+ndXPypKEisEZin0WTMV614YC+LvyUjT8qWXHpAIF2wB5TK9vMGBC4FjLWJyWt8KPMFyRi52nDdRTNkOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L2ETE7vx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81396C4CEE1;
	Tue, 10 Dec 2024 09:34:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733823285;
	bh=fvnoQyhJzDikdPgkmR97fnyZzwgdUNiPmqC+qs3AwAw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=L2ETE7vxPF4hk/KozYU3ufGaAtE0SWvZOA4aS1w3Yrp5JF08u/enOahC7F5Fur2Ko
	 dJkGOv/6QLvqlsBQ5yRyrFn5NzyWhHjskHbpmVDrPmkdQBfLYbUYPlQDNJV3+Fx3E0
	 cVNZr+MraDgvhfPoJOWpCeqgVCVcCGd/qcHL9HvAJmzmuqGApb5PkXqrS0NojXIq03
	 9rPsLyvKitf4IdR/yOvYNSEXGMyIfMzpIXotrn+zaCELV1TK7iGMCbAZArWQg+0aEH
	 CLGKROqFZGhgHAI2K5H2M55Jpyt8gO79Wdc1P/HyCZRI7WrUwMjubTa+nkXYp0LMP9
	 U29EuUQ9qR3dg==
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
Subject: [PATCH v3 04/17] nvmet: Add drvdata field to struct nvmet_ctrl
Date: Tue, 10 Dec 2024 18:33:55 +0900
Message-ID: <20241210093408.105867-5-dlemoal@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241210093408.105867-1-dlemoal@kernel.org>
References: <20241210093408.105867-1-dlemoal@kernel.org>
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


