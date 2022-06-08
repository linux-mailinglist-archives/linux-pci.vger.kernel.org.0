Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C38F542E66
	for <lists+linux-pci@lfdr.de>; Wed,  8 Jun 2022 12:53:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236902AbiFHKwm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Jun 2022 06:52:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236884AbiFHKwm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 8 Jun 2022 06:52:42 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B23710C4
        for <linux-pci@vger.kernel.org>; Wed,  8 Jun 2022 03:52:41 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id h23so32610523lfe.4
        for <linux-pci@vger.kernel.org>; Wed, 08 Jun 2022 03:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rjxOWDbnjXJwXRYjTjw8NFylgTwUZUCHO1VAHBE52mA=;
        b=SWB1jZ+XzmiEJPsn3oOf3vnRom47K+70FRVgXXImIWIQy+PZriKNS5rX097yeB0cn3
         6WcAy8/2ydXst/qWBF7/kEOyVShosjWKtjTOt9Gu3jzHYH5HC33LtiqHMt9ChTezdPph
         /yac9C4iFJIKy5P0Qy3fmj/R/14MCEOOA1lTrX4GVWovLXy6C8/8LbY4OgLKNxB0boAA
         wdeuFdkDPRvcSpiIr3aZk2q2jvOwdOA83ifH7b1LTPgDpHNno86R823ZiMxyWiVqAT6X
         204pyz21jeS8d9F9VIVZAwFDkczioFKmUkIQdWLLsmUv3aikzXh+De06yNXaxy8p/csX
         R87w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rjxOWDbnjXJwXRYjTjw8NFylgTwUZUCHO1VAHBE52mA=;
        b=Vhf4jvRbSq3k47O+AxChW+mllpyD5T9MrLT+zjlQAU8M7ZacGllY0Ysq9H/lJY1lR6
         1AtKSqbtSY9MtrErFWPwLWwn0mzdBB9omOgGcfoyV8TdinqhgUa87uo8Z6qviDV1mJWe
         zGKOr4yMFSDXL1dKXBAomh0d7YkPeYXhZSVr8Yeo+MFQwY3TajpODEMdoAVB7/SyUoFE
         mEIyA0CVFVtZf35MzPuCfZjTk9dfcYwoNPRZsybWCw5Ut1UwqJrQegpCAN9eMQ+9IFYP
         155C6brc5Oyk20cLR9W+bAkb2vb/+2ib2GP4hii/NqhGYpZYsqABfxK19KJd65VuqFgG
         JWzQ==
X-Gm-Message-State: AOAM531yCP/m41yC37HKcgMoZkiA4bvh5dWK+4C4t62eiY+YPded1ai+
        DD+KBcCa+YXpS00uHULleNw1QA==
X-Google-Smtp-Source: ABdhPJzXBXqorFUHGelibFJeDFx/pqcVhJKI328ScMnvmjlicEsCu2Ispak4JoIGvpaFA4YgGMnVCA==
X-Received: by 2002:a05:6512:3c84:b0:478:ee3b:1cc4 with SMTP id h4-20020a0565123c8400b00478ee3b1cc4mr22157917lfv.179.1654685559312;
        Wed, 08 Jun 2022 03:52:39 -0700 (PDT)
Received: from eriador.lan ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id e9-20020a2e5009000000b002556b0cd5acsm3232337ljb.56.2022.06.08.03.52.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jun 2022 03:52:38 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Taniya Das <quic_tdas@quicinc.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-pci@vger.kernel.org, Johan Hovold <johan@kernel.org>
Subject: [PATCH v11 0/5] PCI: qcom: Rework pipe_clk/pipe_clk_src handling
Date:   Wed,  8 Jun 2022 13:52:33 +0300
Message-Id: <20220608105238.2973600-1-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PCIe pipe clk (and some other clocks) must be parked to the "safe"
source (bi_tcxo) when corresponding GDSC is turned off and on again.
Currently this is handcoded in the PCIe driver by reparenting the
gcc_pipe_N_clk_src clock.

Instead of doing it manually, follow the approach used by
clk_rcg2_shared_ops and implement this parking in the enable() and
disable() clock operations for respective pipe clocks.

Changes since v10:
 - Added linux/bitfield.h include (lkp)
 - Split fw_name/name lines in the gcc-sm8450.c (Johan)

Changes since v9:
 - Respin fixing Tested-by tags, no code changes

Changes since v8:
 - Readded .name to changed entries in gcc-sc7280 driver to restore
   compatibility with older DTS,
 - Rebased on top of linux-next, dropping reverts,
 - Verified to include all R-b tags (excuse me, Johan, I missed them
   in the previous iteration).

Changes since v7:
 - Brought back the struct clk_regmap_phy_mux (Johan)
 - Fixed includes (Stephen)
 - Dropped CLK_SET_RATE_PARENT flags from changed pipe clocks, they are
   not set in the current code and they are useless as the PHY's clock
   has fixed rate.

Changes since v6:
 - Switched the ops to use GENMASK/FIELD_GET/FIELD_PUT (Stephen),
 - As all pipe/symbol clock source clocks have the same register (and
   parents) layout, hardcode all the values. If the need arises, this
   can be changed later (Stephen),
 - Fixed commit messages and comments (suggested by Johan),
 - Added revert for the clk_regmap_mux_safe that have been already
   picked up by Bjorn.

Changes since v5:
 - Rename the clock to clk-regmap-phy-mux and the enable/disable values
   to phy_src_val and ref_src_val respectively (as recommended by
   Johan).

Changes since v4:
 - Renamed the clock to clk-regmap-pipe-src,
 - Added mention of PCIe2 PHY to the commit message,
 - Expanded commit messages to mention additional pipe clock details.

Changes since v3:
 - Replaced the clock multiplexer implementation with branch-like clock.

Changes since v2:
 - Added is_enabled() callback
 - Added default parent to the pipe clock configuration

Changes since v1:
 - Rebased on top of [1].
 - Removed erroneous Fixes tag from the patch 4.

Changes since RFC:
 - Rework clk-regmap-mux fields. Specify safe parent as P_* value rather
   than specifying the register value directly
 - Expand commit message to the first patch to specially mention that
   it is required only on newer generations of Qualcomm chipsets.

Dmitry Baryshkov (5):
  clk: qcom: regmap: add PHY clock source implementation
  clk: qcom: gcc-sm8450: use new clk_regmap_phy_mux_ops for PCIe pipe
    clocks
  clk: qcom: gcc-sc7280: use new clk_regmap_phy_mux_ops for PCIe pipe
    clocks
  PCI: qcom: Remove unnecessary pipe_clk handling
  PCI: qcom: Drop manual pipe_clk_src handling


Dmitry Baryshkov (5):
  clk: qcom: regmap: add PHY clock source implementation
  clk: qcom: gcc-sm8450: use new clk_regmap_phy_mux_ops for PCIe pipe
    clocks
  clk: qcom: gcc-sc7280: use new clk_regmap_phy_mux_ops for PCIe pipe
    clocks
  PCI: qcom: Remove unnecessary pipe_clk handling
  PCI: qcom: Drop manual pipe_clk_src handling

 drivers/clk/qcom/Makefile              |  1 +
 drivers/clk/qcom/clk-regmap-phy-mux.c  | 62 ++++++++++++++++++++
 drivers/clk/qcom/clk-regmap-phy-mux.h  | 33 +++++++++++
 drivers/clk/qcom/gcc-sc7280.c          | 49 +++++-----------
 drivers/clk/qcom/gcc-sm8450.c          | 49 +++++-----------
 drivers/pci/controller/dwc/pcie-qcom.c | 81 +-------------------------
 6 files changed, 127 insertions(+), 148 deletions(-)
 create mode 100644 drivers/clk/qcom/clk-regmap-phy-mux.c
 create mode 100644 drivers/clk/qcom/clk-regmap-phy-mux.h

-- 
2.35.1

