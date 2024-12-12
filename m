Return-Path: <linux-pci+bounces-18271-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F307E9EE530
	for <lists+linux-pci@lfdr.de>; Thu, 12 Dec 2024 12:35:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3A26166E0A
	for <lists+linux-pci@lfdr.de>; Thu, 12 Dec 2024 11:35:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97E0C21129D;
	Thu, 12 Dec 2024 11:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EfVVAi26"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 735C820B807
	for <linux-pci@vger.kernel.org>; Thu, 12 Dec 2024 11:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734003328; cv=none; b=GmP8W+dOYh63ne5nHIuWQNt21vT/AOvc1CjKQSyBfGj2gQhg5/huEZvvZ+Gv1dP1U0kE5HmS5corFOABirmRoOLEPa+CJVdO1GaldShzVpnhXX9BmF8vxhbspIgGxW2pYFxPxiXH/qJL3jchkX3x4dNIBbEQSqn5U9OhkNzLvDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734003328; c=relaxed/simple;
	bh=Tq5lne9E79bYedkcTiQtblQgzJZr02APslo5sZaYcwM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CoQAW7QaKULtqJ91n3oTjewyS2i3n7w1mwSuLMMGj3G/5Z2knubGlINGXdmfsmNX0F6R7tW64ct/vcmcjCzC7nNzocmTISDunbGF2pUFz0UAz9aKHPcBMJG3KW/KcdK/Eiw7eXU2mP3reDTXvGqOCnfkIWo6uvMeJGDxeSlYn+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EfVVAi26; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B43CC4CED4;
	Thu, 12 Dec 2024 11:35:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734003327;
	bh=Tq5lne9E79bYedkcTiQtblQgzJZr02APslo5sZaYcwM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EfVVAi26H+UG5aLrQsmNkHLK2/lyRCN6GZrJFYmZB7dxrri+Gm/4Dw0AcesMQAm+k
	 Sb2bxVD0Piw878BBGhWQXw32lb7NsDmQMDCeNksZwUNrX91peiz4ra+raha4bInbjd
	 Apb8KHR4wmqMW8P2XJjtKAoFMx+LNgN5QwjVk+JAmWsBNMavsjqjvC8ShuLff5tJVM
	 qClF65v2+xugZlOSnhuUwHK7rszf5UE0xuPS2wCeuZbaij+0ST8+eofg9QYXGC6gEN
	 U4qAlJtMCFaHLP77YyB3ahRQT+d2b3ZL8vkGhLq2nJ5idvtNltRbKo6fZqIm0hVaAV
	 W8JamVuUJXtew==
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
Subject: [PATCH v4 12/18] nvmet: Introduce get/set_feature controller operations
Date: Thu, 12 Dec 2024 20:34:34 +0900
Message-ID: <20241212113440.352958-13-dlemoal@kernel.org>
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


