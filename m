Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D48A2224FF
	for <lists+linux-pci@lfdr.de>; Thu, 16 Jul 2020 16:16:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728589AbgGPOQO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 16 Jul 2020 10:16:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728521AbgGPOQN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 16 Jul 2020 10:16:13 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04937C08C5C0
        for <linux-pci@vger.kernel.org>; Thu, 16 Jul 2020 07:16:12 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id d17so7375088ljl.3
        for <linux-pci@vger.kernel.org>; Thu, 16 Jul 2020 07:16:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mXH7vVi3KBPuSpGgzBWwHA8EoTmgJyz0ffp69H08dxI=;
        b=CfjpSFsHuv9lIfuFR3u9YVTn3D2/DVD0NybAdw9y/3tyKxpu/BwdPjXQp6sU7A642P
         KkDVTZ4i+npcyyiqXOFgryTudvpB8dz+Kk0is0viOQkv3oqSMIdFfeJqAt1+cBQuRGsr
         Rl8xKml+Wakc8wSfCWakO8h09LR2AAUwyVNZMfZuXXVWP+cDLG1jGRi8UgBXfbcg/DMW
         luSc+6sy30Enj5lxct8bjqh2TxmI++ZnrtYrN427CK5Bpl1Tw+991mHGf1z+DpFkzTzx
         XGtol4/58I0ScHG2T9qPvTxZ+vJ4luQ+OBv/bfDQ0BaqcMsnwW+vuMx3kZss1wUPTgGI
         RXYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mXH7vVi3KBPuSpGgzBWwHA8EoTmgJyz0ffp69H08dxI=;
        b=YnvmnT8pjdNp0OQ70hwcZLPrIM6UqmZhBhpqV58h4khgTeIH2efZ3M00vJdRyIhawb
         BdWaVy2ZQeYTkmm/8Oc4Fu39RZlQX/c8YrH6bzohd/DfEjW5BstqLhdKG7u9Gn64xbbL
         TXTfD1MCQc3v9WLYlmHXv5GPWPURoptDw4zADg7+YljGQnvJxkSLoFX1Jti65bWSDejn
         xJL17870npuD+PwAY7DmkkWTe/3C8LN0hKGZm6YewTTy6QZr9+oEkwdrc4s0CyswH5YI
         Dq1nxjcMDdxDqwaYpGQNPUZsw7XMsfC4O3l70yRLDr5B6NdfX9zAw2vmVp25C+BYuXLz
         EG9g==
X-Gm-Message-State: AOAM531+oADVoRVnOFbzmL/LTalz+qjVr3IFMyr6MkoT3lLxbHmP7TT4
        0SS0yaw8LQo9eiIiwiYcsWX/Qw==
X-Google-Smtp-Source: ABdhPJw1htbppJl/Sb7eYbBder0jkiV1NnzJIDU6QIcD10aBY30vhSNCUz+quukA9UefrB3Zywn2lA==
X-Received: by 2002:a2e:8559:: with SMTP id u25mr2078562ljj.52.1594908971254;
        Thu, 16 Jul 2020 07:16:11 -0700 (PDT)
Received: from localhost.localdomain (h-98-128-181-7.NA.cust.bahnhof.se. [98.128.181.7])
        by smtp.gmail.com with ESMTPSA id x5sm1069418ljm.132.2020.07.16.07.16.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2020 07:16:09 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     linux-mmc@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Rui Feng <rui_feng@realsil.com.cn>
Cc:     linux-nvme@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH] mmc: core: Initial support for SD express card/host
Date:   Thu, 16 Jul 2020 16:15:34 +0200
Message-Id: <20200716141534.30241-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

In the SD specification v7.10 the SD express card has been added. This new
type of removable SD card, can be managed via a PCIe/NVMe based interface,
while also allowing backwards compatibility towards the legacy SD
interface.

To keep the backwards compatibility, it's required to start the
initialization through the legacy SD interface. If it turns out that the
mmc host and the SD card, both supports the PCIe/NVMe interface, then a
switch should be allowed.

Therefore, let's introduce some basic support for this type of SD cards to
the mmc core. The mmc host, should set MMC_CAP2_SD_EXP if it supports this
interface and MMC_CAP2_SD_EXP_1_2V, if also 1.2V is supported, as to inform
the core about it.

To deal with the switch to the PCIe/NVMe interface, the mmc host is
required to implement a new host ops, ->init_sd_express(). Based on the
initial communication between the host and the card, host->ios.timing is
set to either MMC_TIMING_SD_EXP or MMC_TIMING_SD_EXP_1_2V, depending on if
1.2V is supported or not. In this way, the mmc host can check these values
in its ->init_sd_express() ops, to know how to proceed with the handover.

Note that, to manage card insert/removal, the mmc core sticks with using
the ->get_cd() callback, which means it's the host's responsibility to make
sure it provides valid data, even if the card may be managed by PCIe/NVMe
at the moment. As long as the card seems to be present, the mmc core keeps
the card powered on.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Rui Feng <rui_feng@realsil.com.cn>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/core/core.c   | 15 ++++++++++--
 drivers/mmc/core/host.h   |  6 +++++
 drivers/mmc/core/sd_ops.c | 49 +++++++++++++++++++++++++++++++++++++--
 drivers/mmc/core/sd_ops.h |  1 +
 include/linux/mmc/host.h  |  7 ++++++
 5 files changed, 74 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 8ccae6452b9c..6673c0f33cc7 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -2137,8 +2137,12 @@ static int mmc_rescan_try_freq(struct mmc_host *host, unsigned freq)
 
 	mmc_go_idle(host);
 
-	if (!(host->caps2 & MMC_CAP2_NO_SD))
-		mmc_send_if_cond(host, host->ocr_avail);
+	if (!(host->caps2 & MMC_CAP2_NO_SD)) {
+		if (mmc_send_if_cond_pcie(host, host->ocr_avail))
+			goto out;
+		if (mmc_card_sd_express(host))
+			return 0;
+	}
 
 	/* Order's important: probe SDIO, then SD, then MMC */
 	if (!(host->caps2 & MMC_CAP2_NO_SDIO))
@@ -2153,6 +2157,7 @@ static int mmc_rescan_try_freq(struct mmc_host *host, unsigned freq)
 		if (!mmc_attach_mmc(host))
 			return 0;
 
+out:
 	mmc_power_off(host);
 	return -EIO;
 }
@@ -2280,6 +2285,12 @@ void mmc_rescan(struct work_struct *work)
 		goto out;
 	}
 
+	/* If an SD express card is present, then leave it as is. */
+	if (mmc_card_sd_express(host)) {
+		mmc_release_host(host);
+		goto out;
+	}
+
 	for (i = 0; i < ARRAY_SIZE(freqs); i++) {
 		unsigned int freq = freqs[i];
 		if (freq > host->f_max) {
diff --git a/drivers/mmc/core/host.h b/drivers/mmc/core/host.h
index 5e3b9534ffb2..ba407617ed23 100644
--- a/drivers/mmc/core/host.h
+++ b/drivers/mmc/core/host.h
@@ -77,5 +77,11 @@ static inline bool mmc_card_hs400es(struct mmc_card *card)
 	return card->host->ios.enhanced_strobe;
 }
 
+static inline bool mmc_card_sd_express(struct mmc_host *host)
+{
+	return host->ios.timing == MMC_TIMING_SD_EXP ||
+		host->ios.timing == MMC_TIMING_SD_EXP_1_2V;
+}
+
 #endif
 
diff --git a/drivers/mmc/core/sd_ops.c b/drivers/mmc/core/sd_ops.c
index 22bf528294b9..d61ff811218c 100644
--- a/drivers/mmc/core/sd_ops.c
+++ b/drivers/mmc/core/sd_ops.c
@@ -158,7 +158,8 @@ int mmc_send_app_op_cond(struct mmc_host *host, u32 ocr, u32 *rocr)
 	return err;
 }
 
-int mmc_send_if_cond(struct mmc_host *host, u32 ocr)
+static int __mmc_send_if_cond(struct mmc_host *host, u32 ocr, u8 pcie_bits,
+			      u32 *resp)
 {
 	struct mmc_command cmd = {};
 	int err;
@@ -171,7 +172,7 @@ int mmc_send_if_cond(struct mmc_host *host, u32 ocr)
 	 * SD 1.0 cards.
 	 */
 	cmd.opcode = SD_SEND_IF_COND;
-	cmd.arg = ((ocr & 0xFF8000) != 0) << 8 | test_pattern;
+	cmd.arg = ((ocr & 0xFF8000) != 0) << 8 | pcie_bits << 8 | test_pattern;
 	cmd.flags = MMC_RSP_SPI_R7 | MMC_RSP_R7 | MMC_CMD_BCR;
 
 	err = mmc_wait_for_cmd(host, &cmd, 0);
@@ -186,6 +187,50 @@ int mmc_send_if_cond(struct mmc_host *host, u32 ocr)
 	if (result_pattern != test_pattern)
 		return -EIO;
 
+	if (resp)
+		*resp = cmd.resp[0];
+
+	return 0;
+}
+
+int mmc_send_if_cond(struct mmc_host *host, u32 ocr)
+{
+	return __mmc_send_if_cond(host, ocr, 0, NULL);
+}
+
+int mmc_send_if_cond_pcie(struct mmc_host *host, u32 ocr)
+{
+	u32 resp = 0;
+	u8 pcie_bits = 0;
+	int ret;
+
+	if (host->caps2 & MMC_CAP2_SD_EXP) {
+		/* Probe card for SD express support via PCIe. */
+		pcie_bits = 0x10;
+		if (host->caps2 & MMC_CAP2_SD_EXP_1_2V)
+			/* Probe also for 1.2V support. */
+			pcie_bits = 0x30;
+	}
+
+	ret = __mmc_send_if_cond(host, ocr, pcie_bits, &resp);
+	if (ret)
+		return 0;
+
+	/* Continue with the SD express init, if the card supports it. */
+	resp &= 0x3000;
+	if (pcie_bits && resp) {
+		if (resp == 0x3000)
+			host->ios.timing = MMC_TIMING_SD_EXP_1_2V;
+		else
+			host->ios.timing = MMC_TIMING_SD_EXP;
+
+		/*
+		 * According to the spec the clock shall also be gated, but
+		 * let's leave this to the host driver for more flexibility.
+		 */
+		return host->ops->init_sd_express(host, &host->ios);
+	}
+
 	return 0;
 }
 
diff --git a/drivers/mmc/core/sd_ops.h b/drivers/mmc/core/sd_ops.h
index 2194cabfcfc5..3ba7b3cf4652 100644
--- a/drivers/mmc/core/sd_ops.h
+++ b/drivers/mmc/core/sd_ops.h
@@ -16,6 +16,7 @@ struct mmc_host;
 int mmc_app_set_bus_width(struct mmc_card *card, int width);
 int mmc_send_app_op_cond(struct mmc_host *host, u32 ocr, u32 *rocr);
 int mmc_send_if_cond(struct mmc_host *host, u32 ocr);
+int mmc_send_if_cond_pcie(struct mmc_host *host, u32 ocr);
 int mmc_send_relative_addr(struct mmc_host *host, unsigned int *rca);
 int mmc_app_send_scr(struct mmc_card *card);
 int mmc_sd_switch(struct mmc_card *card, int mode, int group,
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index c5b6e97cb21a..905cddc5e6f3 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -60,6 +60,8 @@ struct mmc_ios {
 #define MMC_TIMING_MMC_DDR52	8
 #define MMC_TIMING_MMC_HS200	9
 #define MMC_TIMING_MMC_HS400	10
+#define MMC_TIMING_SD_EXP	11
+#define MMC_TIMING_SD_EXP_1_2V	12
 
 	unsigned char	signal_voltage;		/* signalling voltage (1.8V or 3.3V) */
 
@@ -172,6 +174,9 @@ struct mmc_host_ops {
 	 */
 	int	(*multi_io_quirk)(struct mmc_card *card,
 				  unsigned int direction, int blk_size);
+
+	/* Initialize an SD express card, mandatory for MMC_CAP2_SD_EXP. */
+	int	(*init_sd_express)(struct mmc_host *host, struct mmc_ios *ios);
 };
 
 struct mmc_cqe_ops {
@@ -357,6 +362,8 @@ struct mmc_host {
 #define MMC_CAP2_HS200_1_2V_SDR	(1 << 6)        /* can support */
 #define MMC_CAP2_HS200		(MMC_CAP2_HS200_1_8V_SDR | \
 				 MMC_CAP2_HS200_1_2V_SDR)
+#define MMC_CAP2_SD_EXP		(1 << 7)	/* SD express via PCIe */
+#define MMC_CAP2_SD_EXP_1_2V	(1 << 8)	/* SD express 1.2V */
 #define MMC_CAP2_CD_ACTIVE_HIGH	(1 << 10)	/* Card-detect signal active high */
 #define MMC_CAP2_RO_ACTIVE_HIGH	(1 << 11)	/* Write-protect signal active high */
 #define MMC_CAP2_NO_PRESCAN_POWERUP (1 << 14)	/* Don't power up before scan */
-- 
2.20.1

