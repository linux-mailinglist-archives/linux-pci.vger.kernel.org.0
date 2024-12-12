Return-Path: <linux-pci+bounces-18262-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AAFD9EE525
	for <lists+linux-pci@lfdr.de>; Thu, 12 Dec 2024 12:35:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40FB71885D39
	for <lists+linux-pci@lfdr.de>; Thu, 12 Dec 2024 11:35:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 420431F239D;
	Thu, 12 Dec 2024 11:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="osU0MxmA"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D66B1F0E57
	for <linux-pci@vger.kernel.org>; Thu, 12 Dec 2024 11:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734003313; cv=none; b=HlZhtSP89GbEcaqEtuTn8c6FNqgvbo8Sm5wJD9B7g4fmJWiubYshterAWb438wdj5Oewd+354zpeOsXo4q7y83gCsrpEdmW/UbGyGbRAG0+JiCrP6dKAhj9c0/T6Any290Jyvud+ZIa2Z4vUyqNruriAboxw4VWs75z2MrI+JG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734003313; c=relaxed/simple;
	bh=LCdJhbh9sa35egWXE9gEmBxg9VBjHkPXT4o+hzVpsMc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TtyBBq3UlYRxurWSCS3V7d1BXJBeDzbI2KUgbsF3R7Gx0rCkY8FAgUz/MxPZHUUIeAtbcTP0jD8h250hx82PxM2XBDheS+WPwewT3iv8Tv8c2i40yXNDfge5rCzdMLtT8ISMqBIg2kQx0ul0i6HCAGiFQdQslPTRjpDCr7Uvr9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=osU0MxmA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62BE0C4CEDD;
	Thu, 12 Dec 2024 11:35:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734003312;
	bh=LCdJhbh9sa35egWXE9gEmBxg9VBjHkPXT4o+hzVpsMc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=osU0MxmA/A9Cj5pY/+0beHzY2LlDtKD1IX6sfw1G/CtfSXQPnU8n0AaciYvqZgDMJ
	 E3oaW740wT9fztqwhFvEa4Y2ll7IudaNXyy1f2fYaQ5zFbh2lI+PAsG2XRhfHxGfl8
	 jewNugnfZrMH6VG35ELWfMi6raqKXx8050b8riE2prXj/Z/mSxDoZ78ykooqGoxsJE
	 1g92C69YCMWGqmD2E2TMBo/n8EsMhLuwNx1G3rdzAECV1bORHDHL7uu5olJ2TFjFVV
	 7ZDSzqjqWCUfeAzyLC2y9iEJfwBKwba86FhT3a282i9N5qLXEsY0o47HSbhux3iXUb
	 eMfXrFmsrFbww==
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
Subject: [PATCH v4 03/18] nvmet: Export nvmet_update_cc() and nvmet_cc_xxx() helpers
Date: Thu, 12 Dec 2024 20:34:25 +0900
Message-ID: <20241212113440.352958-4-dlemoal@kernel.org>
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


