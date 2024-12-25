Return-Path: <linux-pci+bounces-19041-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D73459FC42F
	for <lists+linux-pci@lfdr.de>; Wed, 25 Dec 2024 09:31:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B07861883EA3
	for <lists+linux-pci@lfdr.de>; Wed, 25 Dec 2024 08:31:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BCCF1534FB;
	Wed, 25 Dec 2024 08:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q7vfeWxq"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6762D14D29B
	for <linux-pci@vger.kernel.org>; Wed, 25 Dec 2024 08:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735115455; cv=none; b=lbMOgjgvKSpJ6zI0VIx+7l2AHBWvwyePQ2dMHwIyJDgBrxyf2562w+jKdmAbVoZWsW6YsFwTOSDmclSkNuOEoQDXVTRqdgBzSqSnh1T1qlFEsm6v1A+1D2iJ5I52jkdWiKxJ/4Z356BU3yfkT4NPOb9+ud4X3Ccz9uDXcjkOYlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735115455; c=relaxed/simple;
	bh=p1XyrBL8a77sSRG6UZmdKw8GtdrJgme1YzapYAfDP6Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bjoNks3DnCDKD40qo8kpr0fXmD96ct7Fv1aVzdq/+G0MKRF91d4OBjo7GzAXmEQxbTMF7s8C1IdJv0ZVZPEKg1UYKj+VT0m9vWIzf/zMrDaxAVW8vAXd5RZkI1nU4tco0ootN1km5X89VSHCitxLSUT5eahVq5ikbTcGxzZBwG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q7vfeWxq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3A64C4CED6;
	Wed, 25 Dec 2024 08:30:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735115455;
	bh=p1XyrBL8a77sSRG6UZmdKw8GtdrJgme1YzapYAfDP6Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=q7vfeWxqkYOtz5d8ehoaX7FsfY44Z0D/C+1/gRF3Wufn2WiPISFzjSPSQ1VpmK6y8
	 ynwEn6Kwh6bS7/rTGqILJIBbcW9azr32/l9d5OP/BJejp02LO9EJGmCI8epA31nbyh
	 AVJT0bDqa6ghOycSCr+GfJYNIpbE9G6PtJ9QzCvK7C1RoSrwCfjv7NgzXRe2XqEf9W
	 GKXRwcp3OrRZ1PydOhuQBoS7rumI4keu1am2XIHnMAORivWQolcf2X9UFIEqmOlUzQ
	 phYNZ9/C7vl7A3z8XSM6gj34Fh0/pbnsbfB9NQDh2kSb7Ql/twpzZP8d8H2MX7KoKe
	 KR8ejnrBnYbNA==
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
Subject: [PATCH v8 12/18] nvmet: Introduce get/set_feature controller operations
Date: Wed, 25 Dec 2024 17:29:49 +0900
Message-ID: <20241225082956.96650-13-dlemoal@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241225082956.96650-1-dlemoal@kernel.org>
References: <20241225082956.96650-1-dlemoal@kernel.org>
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


