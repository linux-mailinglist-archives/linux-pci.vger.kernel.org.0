Return-Path: <linux-pci+bounces-18423-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3707B9F1CE8
	for <lists+linux-pci@lfdr.de>; Sat, 14 Dec 2024 07:07:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8651C188E217
	for <lists+linux-pci@lfdr.de>; Sat, 14 Dec 2024 06:07:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8455713774B;
	Sat, 14 Dec 2024 06:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bZDyh5+j"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DA2685931
	for <linux-pci@vger.kernel.org>; Sat, 14 Dec 2024 06:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734156443; cv=none; b=hnfZ0rmqvKYbdSXJV3/ts2E8YgvNlxfwmr+iXV7Gg3OYZGnwNMu9lNplD27e/kbOGkviWWLHfCFOSK76kcQrFwwL31BZPVoWoWUfnNDKWY76GdCz+5izOlRxoqUB3YDHOqo73QcSiA+g96hoT8whKYEdLMv6v1DIJsmu9fL6Jpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734156443; c=relaxed/simple;
	bh=LCdJhbh9sa35egWXE9gEmBxg9VBjHkPXT4o+hzVpsMc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CWUsJz+upDEonE/w9O32QO/e3n5iA4ECLcEKomrzz2QX03EtkMecSym8Uq/2iN38Ifez/kXgIj/bLFv+aOutequtc3Q4/Ro+s+Q9vLTzL07bOctScIAZBfdstpq5rBpwLtPwgdVRP9GziUWFB7dVTmXI1sWyqTrh4R5bPXBBdAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bZDyh5+j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30D33C4CEDD;
	Sat, 14 Dec 2024 06:07:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734156443;
	bh=LCdJhbh9sa35egWXE9gEmBxg9VBjHkPXT4o+hzVpsMc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bZDyh5+jV4Om1LSYtLACuOc9NA8s8aNdh6GGGRo+LOy8fAoJi0+PeR2YwWWrnaPMd
	 fL3cTDAhMZRcNu/1mTk/LdCWHcpgp4c/f1PMq5bgDaULOzgZwwZf4UxdEIzEuXcCTS
	 1pZKJPWRcZ7VUkAHrVZEoOjc/pJCCDK0TZbz+ftw8ZSSvQp8AqCUdXLXdvYyM2ik3G
	 dwcbB9csokz1WwsCVHO4vvClNsmaxQW8O2g9O3MzVRVnaxNGYG10+jyAJXja/udR+/
	 4R8Wn5aU2EtYMTVSfNaiBEnu3m+agVKUy8yxDSvzLAXhUh4ItaRwFDlKOZRrqlC8WU
	 ADD52t58Iju/Q==
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
Subject: [PATCH v5 03/18] nvmet: Export nvmet_update_cc() and nvmet_cc_xxx() helpers
Date: Sat, 14 Dec 2024 15:06:40 +0900
Message-ID: <20241214060655.166325-4-dlemoal@kernel.org>
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

Make the function nvmet_update_cc() available to target drivers by
exporting it. To also facilitate the manipulation of the cc register
bits, move the inline helper functions nvmet_cc_en(), nvmet_cc_css(),
nvmet_cc_mps(), nvmet_cc_ams(), nvmet_cc_shn(), nvmet_cc_iosqes(), and
nvmet_cc_iocqes() from core.c to nvmet.h so that these functions can be
reused in target controller drivers.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Tested-by: Rick Wertenbroek <rick.wertenbroek@gmail.com>
---
 drivers/nvme/target/core.c  | 36 +-----------------------------------
 drivers/nvme/target/nvmet.h | 35 +++++++++++++++++++++++++++++++++++
 2 files changed, 36 insertions(+), 35 deletions(-)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 1f4e9989663b..4b5594549ae6 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -1166,41 +1166,6 @@ void nvmet_req_free_sgls(struct nvmet_req *req)
 }
 EXPORT_SYMBOL_GPL(nvmet_req_free_sgls);
 
-static inline bool nvmet_cc_en(u32 cc)
-{
-	return (cc >> NVME_CC_EN_SHIFT) & 0x1;
-}
-
-static inline u8 nvmet_cc_css(u32 cc)
-{
-	return (cc >> NVME_CC_CSS_SHIFT) & 0x7;
-}
-
-static inline u8 nvmet_cc_mps(u32 cc)
-{
-	return (cc >> NVME_CC_MPS_SHIFT) & 0xf;
-}
-
-static inline u8 nvmet_cc_ams(u32 cc)
-{
-	return (cc >> NVME_CC_AMS_SHIFT) & 0x7;
-}
-
-static inline u8 nvmet_cc_shn(u32 cc)
-{
-	return (cc >> NVME_CC_SHN_SHIFT) & 0x3;
-}
-
-static inline u8 nvmet_cc_iosqes(u32 cc)
-{
-	return (cc >> NVME_CC_IOSQES_SHIFT) & 0xf;
-}
-
-static inline u8 nvmet_cc_iocqes(u32 cc)
-{
-	return (cc >> NVME_CC_IOCQES_SHIFT) & 0xf;
-}
-
 static inline bool nvmet_css_supported(u8 cc_css)
 {
 	switch (cc_css << NVME_CC_CSS_SHIFT) {
@@ -1277,6 +1242,7 @@ void nvmet_update_cc(struct nvmet_ctrl *ctrl, u32 new)
 		ctrl->csts &= ~NVME_CSTS_SHST_CMPLT;
 	mutex_unlock(&ctrl->lock);
 }
+EXPORT_SYMBOL_GPL(nvmet_update_cc);
 
 static void nvmet_init_cap(struct nvmet_ctrl *ctrl)
 {
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index e4a31a37c14b..e68f1927339c 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -732,6 +732,41 @@ void nvmet_passthrough_override_cap(struct nvmet_ctrl *ctrl);
 u16 errno_to_nvme_status(struct nvmet_req *req, int errno);
 u16 nvmet_report_invalid_opcode(struct nvmet_req *req);
 
+static inline bool nvmet_cc_en(u32 cc)
+{
+	return (cc >> NVME_CC_EN_SHIFT) & 0x1;
+}
+
+static inline u8 nvmet_cc_css(u32 cc)
+{
+	return (cc >> NVME_CC_CSS_SHIFT) & 0x7;
+}
+
+static inline u8 nvmet_cc_mps(u32 cc)
+{
+	return (cc >> NVME_CC_MPS_SHIFT) & 0xf;
+}
+
+static inline u8 nvmet_cc_ams(u32 cc)
+{
+	return (cc >> NVME_CC_AMS_SHIFT) & 0x7;
+}
+
+static inline u8 nvmet_cc_shn(u32 cc)
+{
+	return (cc >> NVME_CC_SHN_SHIFT) & 0x3;
+}
+
+static inline u8 nvmet_cc_iosqes(u32 cc)
+{
+	return (cc >> NVME_CC_IOSQES_SHIFT) & 0xf;
+}
+
+static inline u8 nvmet_cc_iocqes(u32 cc)
+{
+	return (cc >> NVME_CC_IOCQES_SHIFT) & 0xf;
+}
+
 /* Convert a 32-bit number to a 16-bit 0's based number */
 static inline __le16 to0based(u32 a)
 {
-- 
2.47.1


