Return-Path: <linux-pci+bounces-19288-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DFB7A01268
	for <lists+linux-pci@lfdr.de>; Sat,  4 Jan 2025 06:00:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9226D1884C15
	for <lists+linux-pci@lfdr.de>; Sat,  4 Jan 2025 05:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 223E213CA8A;
	Sat,  4 Jan 2025 05:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QwICOefW"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8ECE14A4EB
	for <linux-pci@vger.kernel.org>; Sat,  4 Jan 2025 05:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735966848; cv=none; b=f6kcxWCwD+VQEISgmPluFOlh4GfumP2i0bRJWJiCr00JFAINarXDtDK9sENk3Xu+7GH35GOt3AcJpxpuooKM/0a6/vwynkdiKpP8P28BAn6xG6S970eOH1BlwaeiUGSzsfsHggjhmIhlrvfdFLcIDjyVJF2VIQu0HypUjoZKDDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735966848; c=relaxed/simple;
	bh=p1XyrBL8a77sSRG6UZmdKw8GtdrJgme1YzapYAfDP6Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BQ3359y5mEhkliNL5Ls1PO3PvyVvHPA5StHwFPB5UpoEyR24Q8VJX+oQjQ3P65ZYfT89HsNM2YGv0cZ0d9IAAzkIrT1TA+wohsucywScdzJI9IZAmfWwXM+DBahLYJNAx1fBqzzE18+Oc+UojJ1ncCrzyIWEd3c8dxb45sqzm5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QwICOefW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6ADE6C4CEE1;
	Sat,  4 Jan 2025 05:00:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735966847;
	bh=p1XyrBL8a77sSRG6UZmdKw8GtdrJgme1YzapYAfDP6Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QwICOefWbti2TmMc6FSulKUFrMX8w5PXLrouq4FTuw0Z4sYHlShcbfH4F8Tco3+YY
	 m9Fe65xkVfWfGg+lcLJzJGvxj5bDVFoYmxBGTZzyWEytMwJbrBKOQ/k/4ezPThjvww
	 cPg1S4RbqkZis1fVLwtDLxHeFB3b/7TfvUdVSH9Mo9IL+qarO5Turt2iWr07PDh5kT
	 ZDFNeiR442vwkgwpWUR6nr6OQm8KZ9Ool+GxUdHmU9pvnItlj032xmkwpiGtLUY67x
	 +ZpovLmuJRlWMJB6xV33OPJyp6qKRKk+fpfrwut4ZowHWBFH1w4jX7L8WhVg0iBuPn
	 k8gG6RRL6BY5w==
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
Subject: [PATCH v9 12/18] nvmet: Introduce get/set_feature controller operations
Date: Sat,  4 Jan 2025 13:59:45 +0900
Message-ID: <20250104045951.157830-13-dlemoal@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250104045951.157830-1-dlemoal@kernel.org>
References: <20250104045951.157830-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The implementation of some features cannot always be done generically by
the target core code. Arbitraion and IRQ coalescing features are
examples of such features: their implementation must be provided (at
least partially) by the target controller driver.

Introduce the set_feature() and get_feature() controller fabrics
operations (in struct nvmet_fabrics_ops) to allow supporting such
features.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Tested-by: Rick Wertenbroek <rick.wertenbroek@gmail.com>
Tested-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/nvme/target/nvmet.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 86bb2852a63b..8325de3382ee 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -416,6 +416,10 @@ struct nvmet_fabrics_ops {
 	u16 (*create_cq)(struct nvmet_ctrl *ctrl, u16 cqid, u16 flags,
 			 u16 qsize, u64 prp1, u16 irq_vector);
 	u16 (*delete_cq)(struct nvmet_ctrl *ctrl, u16 cqid);
+	u16 (*set_feature)(const struct nvmet_ctrl *ctrl, u8 feat,
+			   void *feat_data);
+	u16 (*get_feature)(const struct nvmet_ctrl *ctrl, u8 feat,
+			   void *feat_data);
 };
 
 #define NVMET_MAX_INLINE_BIOVEC	8
-- 
2.47.1


