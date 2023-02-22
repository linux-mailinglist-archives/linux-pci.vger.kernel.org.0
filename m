Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA1FD69F824
	for <lists+linux-pci@lfdr.de>; Wed, 22 Feb 2023 16:34:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232630AbjBVPek (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 22 Feb 2023 10:34:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232633AbjBVPe3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 22 Feb 2023 10:34:29 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EAA73A0B9
        for <linux-pci@vger.kernel.org>; Wed, 22 Feb 2023 07:33:57 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id h14so9293375plf.10
        for <linux-pci@vger.kernel.org>; Wed, 22 Feb 2023 07:33:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RqG9xtTBiKFFqs7nudeShHVEmZgSa7/qeDhwUVoJ0gI=;
        b=YqOgmH/92BWDJ43zxxahEmhM/3mAYmnI6cdgrfMWf1SiZQTRPDDUICuSv6JmVCLpQX
         Ir8CDKGTQVmpXPpkDbiHRIfDzAbqpMpC7zXnXkA5l6ZdK9xfyLs3+K5bT6CZpUl/cEch
         t6E1mi4Hk+YMi5iSXO9ZNe89qIasGKTPMJDMQbd6/kf1JKHK2LBNWfQDYb+yRPgeSs+Q
         D6lgcTrFSbIeTkgS/qs0QHAbg6gqEUu7g0+yBKA3JrOyhmBXKRo7YVS/3EvW55RAbDsB
         vdWIA80MYx6v65gNv60uTlWk8CUMzkW/gAWIMishs2opVJZmlu1T4zfKM+7NN2/7EsTv
         3bEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RqG9xtTBiKFFqs7nudeShHVEmZgSa7/qeDhwUVoJ0gI=;
        b=EMFHHxLup59dM3dTGY2BuOqVN7lLfsJR9LbgCsS0yqbEXnFm+iXryEcYM7gGJ7clLr
         E0aBMMDypSszhdGwXxgBE+/ayMMrC+ZKurGY8r8KBgfKXi2TakeoRYO4VFZxBZMriDwA
         l+7QWjbwjzNmy8yAq9LFsz27LyQ5RWSGsaE9Qg7e7JcSuq8d1gN8oVEl3bLbBK0iPpZT
         xJK8JUxwcvwrvfuzpufZtYPu7w5obcPws2DNVEBegrPZsCqvs7Ybbz1Wp+kXhFPwfxbt
         PJLmyXJPD7TDEYbTOWIdRUd2imEas2yCJJKeKM5ePm5BCP60Ich7svUGuncOSLh5CKMm
         aAjQ==
X-Gm-Message-State: AO0yUKVIAe/LobCqzMWjTTQVlXHdVww1q1EaLrVIt0cmT3fB8IpA4qhi
        0R5yIGtZhvwLhWrDsAqcM0Kxzn1jDLNBFEw=
X-Google-Smtp-Source: AK7set9XYmm8vI9O37l/Qf9lKiFrBKryqh30IwYRA6xiWoa1/0bmOU10jLnFsZLm+bfb2alXxkR2cA==
X-Received: by 2002:a05:6a20:429d:b0:b9:6932:7d71 with SMTP id o29-20020a056a20429d00b000b969327d71mr11445271pzj.26.1677080034856;
        Wed, 22 Feb 2023 07:33:54 -0800 (PST)
Received: from localhost.localdomain ([117.216.123.15])
        by smtp.gmail.com with ESMTPSA id f15-20020aa78b0f000000b005ac419804d3sm5222482pfd.186.2023.02.22.07.33.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Feb 2023 07:33:54 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     andersson@kernel.org, lpieralisi@kernel.org, robh@kernel.org,
        kw@linux.com, krzysztof.kozlowski+dt@linaro.org, vkoul@kernel.org
Cc:     konrad.dybcio@linaro.org, bhelgaas@google.com, kishon@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 10/11] phy: qcom-qmp-pcie: Add RC init sequence for SDX55
Date:   Wed, 22 Feb 2023 21:02:50 +0530
Message-Id: <20230222153251.254492-11-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230222153251.254492-1-manivannan.sadhasivam@linaro.org>
References: <20230222153251.254492-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add PCIe RC init sequence making use of the common init sequence. The RC
mode additionally requires REFCLK_DRV_DSBL bit to set during powerup and
powerdown.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/phy/qualcomm/phy-qcom-qmp-pcie.c      | 49 ++++++++++++++++++-
 .../qualcomm/phy-qcom-qmp-pcs-pcie-v4_20.h    |  2 +
 2 files changed, 50 insertions(+), 1 deletion(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
index f526f73f76ef..9d92facd47a6 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
@@ -1138,6 +1138,41 @@ static const struct qmp_phy_init_tbl sdx55_qmp_pcie_serdes_tbl[] = {
 	QMP_PHY_INIT_CFG(QSERDES_V4_COM_BIN_VCOCAL_HSCLK_SEL, 0x22),
 };
 
+static const struct qmp_phy_init_tbl sdx55_qmp_pcie_rc_serdes_tbl[] = {
+	QMP_PHY_INIT_CFG(QSERDES_V4_COM_SSC_EN_CENTER, 0x01),
+	QMP_PHY_INIT_CFG(QSERDES_V4_COM_SSC_PER1, 0x31),
+	QMP_PHY_INIT_CFG(QSERDES_V4_COM_SSC_PER2, 0x01),
+	QMP_PHY_INIT_CFG(QSERDES_V4_COM_SSC_STEP_SIZE1_MODE0, 0xce),
+	QMP_PHY_INIT_CFG(QSERDES_V4_COM_SSC_STEP_SIZE2_MODE0, 0x0b),
+	QMP_PHY_INIT_CFG(QSERDES_V4_COM_SSC_STEP_SIZE1_MODE1, 0x97),
+	QMP_PHY_INIT_CFG(QSERDES_V4_COM_SSC_STEP_SIZE2_MODE1, 0x0c),
+	QMP_PHY_INIT_CFG(QSERDES_V4_COM_CLK_ENABLE1, 0x90),
+	QMP_PHY_INIT_CFG(QSERDES_V4_COM_CLK_EP_DIV_MODE0, 0x0a),
+	QMP_PHY_INIT_CFG(QSERDES_V4_COM_CLK_EP_DIV_MODE1, 0x10),
+	QMP_PHY_INIT_CFG(QSERDES_V4_COM_CP_CTRL_MODE0, 0x06),
+	QMP_PHY_INIT_CFG(QSERDES_V4_COM_CP_CTRL_MODE1, 0x06),
+	QMP_PHY_INIT_CFG(QSERDES_V4_COM_PLL_RCTRL_MODE0, 0x16),
+	QMP_PHY_INIT_CFG(QSERDES_V4_COM_PLL_RCTRL_MODE1, 0x16),
+	QMP_PHY_INIT_CFG(QSERDES_V4_COM_PLL_CCTRL_MODE0, 0x36),
+	QMP_PHY_INIT_CFG(QSERDES_V4_COM_PLL_CCTRL_MODE1, 0x36),
+	QMP_PHY_INIT_CFG(QSERDES_V4_COM_SYSCLK_EN_SEL, 0x08),
+	QMP_PHY_INIT_CFG(QSERDES_V4_COM_LOCK_CMP1_MODE0, 0x04),
+	QMP_PHY_INIT_CFG(QSERDES_V4_COM_LOCK_CMP2_MODE0, 0x0d),
+	QMP_PHY_INIT_CFG(QSERDES_V4_COM_LOCK_CMP1_MODE1, 0x0a),
+	QMP_PHY_INIT_CFG(QSERDES_V4_COM_LOCK_CMP2_MODE1, 0x1a),
+	QMP_PHY_INIT_CFG(QSERDES_V4_COM_DEC_START_MODE0, 0xc3),
+	QMP_PHY_INIT_CFG(QSERDES_V4_COM_DEC_START_MODE1, 0xd0),
+	QMP_PHY_INIT_CFG(QSERDES_V4_COM_DIV_FRAC_START3_MODE0, 0x05),
+	QMP_PHY_INIT_CFG(QSERDES_V4_COM_DIV_FRAC_START1_MODE1, 0x55),
+	QMP_PHY_INIT_CFG(QSERDES_V4_COM_DIV_FRAC_START2_MODE1, 0x55),
+	QMP_PHY_INIT_CFG(QSERDES_V4_COM_DIV_FRAC_START3_MODE1, 0x05),
+	QMP_PHY_INIT_CFG(QSERDES_V4_COM_CLK_SELECT, 0x34),
+	QMP_PHY_INIT_CFG(QSERDES_V4_COM_BIN_VCOCAL_CMP_CODE1_MODE0, 0xca),
+	QMP_PHY_INIT_CFG(QSERDES_V4_COM_BIN_VCOCAL_CMP_CODE2_MODE0, 0x1e),
+	QMP_PHY_INIT_CFG(QSERDES_V4_COM_BIN_VCOCAL_CMP_CODE1_MODE1, 0xd8),
+	QMP_PHY_INIT_CFG(QSERDES_V4_COM_BIN_VCOCAL_CMP_CODE2_MODE1, 0x20),
+};
+
 static const struct qmp_phy_init_tbl sdx55_qmp_pcie_ep_serdes_tbl[] = {
 	QMP_PHY_INIT_CFG(QSERDES_V4_COM_BG_TIMER, 0x02),
 	QMP_PHY_INIT_CFG(QSERDES_V4_COM_SYS_CLK_CTRL, 0x07),
@@ -1217,6 +1252,11 @@ static const struct qmp_phy_init_tbl sdx55_qmp_pcie_pcs_misc_tbl[] = {
 	QMP_PHY_INIT_CFG(QPHY_V4_20_PCS_PCIE_G4_EQ_CONFIG5, 0x02),
 };
 
+static const struct qmp_phy_init_tbl sdx55_qmp_pcie_rc_pcs_misc_tbl[] = {
+	QMP_PHY_INIT_CFG(QPHY_V4_20_PCS_PCIE_ENDPOINT_REFCLK_DRIVE, 0xc1),
+	QMP_PHY_INIT_CFG(QPHY_V4_20_PCS_PCIE_OSC_DTCT_ACTIONS, 0x00),
+};
+
 static const struct qmp_phy_init_tbl sdx55_qmp_pcie_ep_pcs_misc_tbl[] = {
 	QMP_PHY_INIT_CFG(QPHY_V4_20_PCS_LANE1_INSIG_SW_CTRL2, 0x00),
 	QMP_PHY_INIT_CFG(QPHY_V4_20_PCS_LANE1_INSIG_MX_CTRL2, 0x00),
@@ -2010,6 +2050,13 @@ static const struct qmp_phy_cfg sdx55_qmp_pciephy_cfg = {
 		.pcs_misc_num	= ARRAY_SIZE(sdx55_qmp_pcie_pcs_misc_tbl),
 	},
 
+	.tbls_rc = &(const struct qmp_phy_cfg_tbls) {
+		.serdes		= sdx55_qmp_pcie_rc_serdes_tbl,
+		.serdes_num	= ARRAY_SIZE(sdx55_qmp_pcie_rc_serdes_tbl),
+		.pcs_misc	= sdx55_qmp_pcie_rc_pcs_misc_tbl,
+		.pcs_misc_num	= ARRAY_SIZE(sdx55_qmp_pcie_rc_pcs_misc_tbl),
+	},
+
 	.tbls_ep = &(const struct qmp_phy_cfg_tbls) {
 		.serdes		= sdx55_qmp_pcie_ep_serdes_tbl,
 		.serdes_num	= ARRAY_SIZE(sdx55_qmp_pcie_ep_serdes_tbl),
@@ -2025,7 +2072,7 @@ static const struct qmp_phy_cfg sdx55_qmp_pciephy_cfg = {
 	.num_vregs		= ARRAY_SIZE(qmp_phy_vreg_l),
 	.regs			= sm8250_pcie_regs_layout,
 
-	.pwrdn_ctrl		= SW_PWRDN,
+	.pwrdn_ctrl		= SW_PWRDN | REFCLK_DRV_DSBL,
 	.phy_status		= PHYSTATUS_4_20,
 };
 
diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcs-pcie-v4_20.h b/drivers/phy/qualcomm/phy-qcom-qmp-pcs-pcie-v4_20.h
index af273602998e..ac872a9eff9a 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-pcs-pcie-v4_20.h
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcs-pcie-v4_20.h
@@ -6,6 +6,8 @@
 #ifndef QCOM_PHY_QMP_PCS_PCIE_V4_20_H_
 #define QCOM_PHY_QMP_PCS_PCIE_V4_20_H_
 
+#define QPHY_V4_20_PCS_PCIE_ENDPOINT_REFCLK_DRIVE	0x01c
+#define QPHY_V4_20_PCS_PCIE_OSC_DTCT_ACTIONS		0x090
 #define QPHY_V4_20_PCS_PCIE_EQ_CONFIG1			0x0a0
 #define QPHY_V4_20_PCS_PCIE_G3_RXEQEVAL_TIME		0x0f0
 #define QPHY_V4_20_PCS_PCIE_G4_RXEQEVAL_TIME		0x0f4
-- 
2.25.1

