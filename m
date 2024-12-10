Return-Path: <linux-pci+bounces-18009-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9333B9EAC72
	for <lists+linux-pci@lfdr.de>; Tue, 10 Dec 2024 10:37:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF00C28BD3D
	for <lists+linux-pci@lfdr.de>; Tue, 10 Dec 2024 09:37:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1A8D223330;
	Tue, 10 Dec 2024 09:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qCM7L3Eb"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD5F922332E
	for <linux-pci@vger.kernel.org>; Tue, 10 Dec 2024 09:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733823301; cv=none; b=d+8lOtoWuw7Y0naj9JY63f5etD0BnJ6RQcMwZtWDV+x9/BKvZcx6NJIMhNSG/EdmqZOYZtN1mbWRV7SQBoclTvzpaym1F4ja4cgW5er+0yxNCvec0ivxGfmxQUs8NUfSwB0c9Fu66i1cheAD9+hIZOsGmPFaxfr9In5KLjrbhus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733823301; c=relaxed/simple;
	bh=NgeDYVmKLnPnEgYMTm8Gcflj4/a9LtgCkbnjnyI2o18=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d8CnvkbPxKASZaqFJljM7MYBSMJMqXcFfvOXSzt6fHWvroJnp1hbZBWw3T5jWZYfCCWJhRHnrm3NpwMTqMxusRAXUyvgLAAZlmZ8nu5LG2sE4PLHJjlSkRJIhmCNbWkCgz84eQ1c1YH0ih8A0WFasLerUVFJ5PjgQb2z8s0fA6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qCM7L3Eb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA5B8C4CEE1;
	Tue, 10 Dec 2024 09:34:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733823301;
	bh=NgeDYVmKLnPnEgYMTm8Gcflj4/a9LtgCkbnjnyI2o18=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qCM7L3EbQOWM4GitPXZBbCfMY4O1th/a3lqPnIR0RCeZ8oHvmyypM50v52BsE5TuX
	 0s1TVntRzAezPY0fNEt/IRVxgYVtFD/XauCYkAlWlzUCrSwd3ZYzq9kMa+XBN75P5H
	 /ByPDxc7zjQZNWNSOruEenTgt6kl8S95F+JLC3C3Lkd0BNhFqVYeC1Ips4KBUgMbZv
	 vv9AIpxUs86443bcPgiBJYJ1yf9fmdphwcd84w5rQzNEKVBe+b7LdIVLXS/Nxmcz4r
	 HoShfXiCa6qF7Ev8r5J5YcxYS4R3M0MUG0I3efpNIwm8yuCt6liBPrd7NCQksSUcGo
	 6Bs0ewqlaQS3g==
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
Subject: [PATCH v3 11/17] nvmet: Introduce get/set_feature controller operations
Date: Tue, 10 Dec 2024 18:34:02 +0900
Message-ID: <20241210093408.105867-12-dlemoal@kernel.org>
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

The implementation of some features cannot always be done generically by
the target core code. Arbitraion and IRQ coalescing features are
examples of such features: their implementation must be provided (at
least partially) by the target controller driver.

Introduce the set_feature() and get_feature() controller fabrics
operations (in struct nvmet_fabrics_ops) to allow supporting such
features.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
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


