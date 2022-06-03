Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7478B53C70F
	for <lists+linux-pci@lfdr.de>; Fri,  3 Jun 2022 10:45:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242868AbiFCIpA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 3 Jun 2022 04:45:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241085AbiFCIo7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 3 Jun 2022 04:44:59 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A5C336E1B
        for <linux-pci@vger.kernel.org>; Fri,  3 Jun 2022 01:44:57 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id s13so7749581ljd.4
        for <linux-pci@vger.kernel.org>; Fri, 03 Jun 2022 01:44:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=a+HYZ6wNGjvVFAgTXuBY3J//uFg94IwMuMuRq/z2MUI=;
        b=nzXn7k7YiBnr4rH3EnHC5fbo64Co15fQK9FYXiLvofFrPrTM5Ja3dvhEzYc0WiZhAn
         skxVJ8UdVLh7uK7AdjWOArMBlNMO0QrJ1lb+BjMzLG6JAOVUBgkMRXEOrRqdJPC0KXIN
         WQnmma4LvVhPCj6yY7RBobkFzPojOWsXO1qsjjifiyrTQjRGscJyACWExtQ2TLiRtCZg
         Bstu7eFSxLDfKzOfrJy7l3s5UiOfaUKQL8VM+YxKWI/t+gnp9RbHaz9iePb9xOLa8nvT
         O3HTZfuWmatNdh69udB8u1yyiFkefov1LvuCyDX17c7TEqnNS9PbgnF4ymInNfkcZsHG
         AmSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=a+HYZ6wNGjvVFAgTXuBY3J//uFg94IwMuMuRq/z2MUI=;
        b=I4hszTtGoluK6BQY5rBVk5QIKg6Stnt1bMP6/+pZUSCD3qBRKCiWlSb5868AV2mnaO
         B0GopetHV/GKBga56pP+7obfX3oY0r46EPal9Mv4QU645JSIvOPSsRoy+/aggHZgBBDf
         1Em4bKjvMTiFDRHPwjPx7GZbNBjShpg8z1qFM/wmn69g4Q3gwNj51rt4OU/xmk0dH4y7
         wcVQN8GAks6pcrtYn4Kp3T0/rzbotxlIFS09BRMZr1hH9dbzukuux62QgKchz2txxk+j
         B8XbineCXb/Wl8nYb5Y4/tafUQe3obXFnz29A0z4b1zXohE302y1NsdFJ0i8575vXgzl
         523A==
X-Gm-Message-State: AOAM531JCxFUW/yFPuQZKUGK1dFnKWVvXY52PIaRLYSpV6Nj3I5kpr77
        gcENY3F2yzMek2LhcFhP7+kAsA==
X-Google-Smtp-Source: ABdhPJyPmf10weD2hh5n0tQYHrcZPlhdzUecROHhMHoKm5dMXyu1nwHke7PNYI9grUUorZxzQ32E7Q==
X-Received: by 2002:a2e:9995:0:b0:255:676e:a38d with SMTP id w21-20020a2e9995000000b00255676ea38dmr8545022lji.106.1654245895787;
        Fri, 03 Jun 2022 01:44:55 -0700 (PDT)
Received: from eriador.lan ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id b7-20020a0565120b8700b00478f8c9d402sm1474817lfv.20.2022.06.03.01.44.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jun 2022 01:44:55 -0700 (PDT)
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
Subject: [PATCH v10 0/5] PCI: qcom: Rework pipe_clk/pipe_clk_src handling
Date:   Fri,  3 Jun 2022 11:44:49 +0300
Message-Id: <20220603084454.1861142-1-dmitry.baryshkov@linaro.org>
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
 drivers/clk/qcom/gcc-sc7280.c          | 47 +++++----------
 drivers/clk/qcom/gcc-sm8450.c          | 49 +++++-----------
 drivers/pci/controller/dwc/pcie-qcom.c | 81 +-------------------------
 6 files changed, 125 insertions(+), 148 deletions(-)
 create mode 100644 drivers/clk/qcom/clk-regmap-phy-mux.c
 create mode 100644 drivers/clk/qcom/clk-regmap-phy-mux.h

-- 
2.35.1

