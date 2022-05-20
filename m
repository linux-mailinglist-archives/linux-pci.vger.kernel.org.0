Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5142E52E241
	for <lists+linux-pci@lfdr.de>; Fri, 20 May 2022 04:00:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344586AbiETB6w (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 19 May 2022 21:58:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344621AbiETB6u (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 19 May 2022 21:58:50 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1BFFEBEBA
        for <linux-pci@vger.kernel.org>; Thu, 19 May 2022 18:58:48 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id u7so7438709ljd.11
        for <linux-pci@vger.kernel.org>; Thu, 19 May 2022 18:58:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rI7Y4P9SCkMcqvtK5Rv4N2uvGcPonNFOcit2B7JJbwg=;
        b=bCrGTseHMnu40q7z4FTSUPlil5+yLztnKlgGkTZTRiNTQGRiOogYiZhAGBDhIwyN+u
         I2Aw71dgFZ/v32Mak0VE48W0XB07yf6yDzzCkhXlunndeSqX0bU7p6Y/pUros4PpBAgW
         NVeOokZUHXUkjqoKfUzGBnsHx/CQ4TsamPwKhX9o7GDPypXF2CJyEqgfCMHw11LIW429
         v1TS3WU6LDBPqjmpGLUzA427+sVpNPJ0MiMXV3gBGEFq4ZKXrj+W5DkL64WEZHodbjnv
         /j9l8rh5+oq/BWq7ibeCKkUB0emFqsm/kBUlhL+Nvio3XI44ajuE11bhPTKL3USOSMrB
         qT3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rI7Y4P9SCkMcqvtK5Rv4N2uvGcPonNFOcit2B7JJbwg=;
        b=rhUEkEnAJ7u0BRpihLhNxGxVlYpAEziHRfITmMBKNSfraS8YkjiHTOOT9BwcwfuoVS
         7IhSvEpfF7d4JFl2R1c9MirCsadxVPKgZsEbTsSj0KlndrjyYKdLXlxxXTfeKQgjYB3Y
         czpWmSKj4TB0qZDFsa1PV3MASIIUbK67UQ+8pmKX119uROYuVySVJ/tmkHAQOmhI5fuc
         e6yxnrjkIJ45tCM+DHffFCaokTNvqAVyfA6i/T5LBRh6OueSQ8uMQEePAOaBBOFD9I48
         Ptxy78HisD28FpkOO1h8K5ZtwH5f51yGV8JW+VpCcqxgxklCJPr6ao+Qn53WAQLQywpu
         z8fw==
X-Gm-Message-State: AOAM533L0Dq7lokZ/52LmffnqBXpmWl8yitRIkf9hvZuDE/JWWwIcUSS
        B7o/BPxLdho+bTPp/W87pRWGKg==
X-Google-Smtp-Source: ABdhPJwz10pUK4fM57T//QKpNJQzy9Obh6zw03R3lVoB6SGuKxxbmYxwHQi/xkle2R0Ioda8PrGqxA==
X-Received: by 2002:a2e:9159:0:b0:253:a141:4cd1 with SMTP id q25-20020a2e9159000000b00253a1414cd1mr4313093ljg.145.1653011927067;
        Thu, 19 May 2022 18:58:47 -0700 (PDT)
Received: from eriador.lan ([2001:470:dd84:abc0::8a5])
        by smtp.gmail.com with ESMTPSA id u28-20020ac24c3c000000b0047255d21192sm467370lfq.193.2022.05.19.18.58.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 May 2022 18:58:46 -0700 (PDT)
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
        linux-pci@vger.kernel.org
Subject: [PATCH v7 0/6] PCI: qcom: Rework pipe_clk/pipe_clk_src handling
Date:   Fri, 20 May 2022 04:58:38 +0300
Message-Id: <20220520015844.1190511-1-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
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

Dmitry Baryshkov (6):
  PCI: qcom: Remove unnecessary pipe_clk handling
  clk: qcom: regmap: add PHY clock source implementation
  clk: qcom: gcc-sm8450: use new clk_regmap_phy_mux_ops for PCIe pipe
    clocks
  clk: qcom: gcc-sc7280: use new clk_regmap_phy_mux_ops for PCIe pipe
    clocks
  Revert "clk: qcom: regmap-mux: add pipe clk implementation"
  PCI: qcom: Drop manual pipe_clk_src handling

 drivers/clk/qcom/Makefile              |  1 +
 drivers/clk/qcom/clk-regmap-mux.c      | 78 -------------------------
 drivers/clk/qcom/clk-regmap-mux.h      |  3 -
 drivers/clk/qcom/clk-regmap-phy-mux.c  | 53 +++++++++++++++++
 drivers/clk/qcom/clk-regmap.h          | 17 ++++++
 drivers/clk/qcom/gcc-sc7280.c          | 70 +++++++---------------
 drivers/clk/qcom/gcc-sm8450.c          | 72 +++++++----------------
 drivers/pci/controller/dwc/pcie-qcom.c | 81 +-------------------------
 8 files changed, 118 insertions(+), 257 deletions(-)
 create mode 100644 drivers/clk/qcom/clk-regmap-phy-mux.c

-- 
2.35.1

