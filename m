Return-Path: <linux-pci+bounces-18432-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05ACF9F1CF1
	for <lists+linux-pci@lfdr.de>; Sat, 14 Dec 2024 07:07:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B555161DEF
	for <lists+linux-pci@lfdr.de>; Sat, 14 Dec 2024 06:07:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00CE141C69;
	Sat, 14 Dec 2024 06:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ENl+X2Cw"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D04DB27450
	for <linux-pci@vger.kernel.org>; Sat, 14 Dec 2024 06:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734156463; cv=none; b=tEZK6/bE0aUuevSTEGqzImAIx22EHvVV383/NrGmweVh2pBBKKIRwKrRVeBLvEkMoo/xHfhJpd6U9R94NSa1netKsarvxhYTCEohoMCe/hsI5zBIfl4YcgUFteGBnopcrwouNN4HWhhhaeuz+WtIF9TbpChzdGX24aMqWl8o8Cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734156463; c=relaxed/simple;
	bh=Tq5lne9E79bYedkcTiQtblQgzJZr02APslo5sZaYcwM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pJrEL6MQzXWYsl2KnhojKaaM8rlPLt6kFOMJEfIrggAev+4RLwgLeN8HAvThuQD1a70rfT9PikxnlWiggigKa4ZdcOCq7XPs0tZGYZiAAH2rPCUNRHgMMAR03nTVmgOBO4O+7OPfqtJiqlGagMkkNBiLBvbILjF88dlX2Ayx8Fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ENl+X2Cw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B90BC4CEDD;
	Sat, 14 Dec 2024 06:07:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734156463;
	bh=Tq5lne9E79bYedkcTiQtblQgzJZr02APslo5sZaYcwM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ENl+X2Cw9A0Pbl4nzgORL5GeWMerXdpcqhYf5VUJyncYwP/EgEG4jdPp4ETgLAo7T
	 +xhvL7PUSWikAS7O5Nx6hY6ERrzCA8PxjHUyICbvJmyFyBGlJYQfJJegQTLjxj75WV
	 HFOlSa7CNwNHBUlj4dU7OHJAQ3mHuX0u5YAxKzXz/PwqwfsNWQkes4iRMOSE/PHYvW
	 0fqofRL3bc+iyIpkZF41P8g5YhYS2CejYIah+0PJ8ZtQPUkYSvbEC/FWsqoLS8GgfQ
	 TKnzEH7Bw73oAXGcAPkUEpj2qn9ktSb7OnDF2TomS02f+Lo5pIBrBLQ8df9N/PuFcw
	 JCZ+/APUHdGfA==
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
Subject: [PATCH v5 12/18] nvmet: Introduce get/set_feature controller operations
Date: Sat, 14 Dec 2024 15:06:49 +0900
Message-ID: <20241214060655.166325-13-dlemoal@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241214060655.166325-1-dlemoal@kernel.org>
References: <20241214060655.166325-1-dlemoal@kernel.org>
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


