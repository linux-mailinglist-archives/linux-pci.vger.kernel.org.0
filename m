Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2B3E53C692
	for <lists+linux-pci@lfdr.de>; Fri,  3 Jun 2022 09:59:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237453AbiFCH7T (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 3 Jun 2022 03:59:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242668AbiFCH7S (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 3 Jun 2022 03:59:18 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD21A35DCE
        for <linux-pci@vger.kernel.org>; Fri,  3 Jun 2022 00:59:15 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id h23so11401684lfe.4
        for <linux-pci@vger.kernel.org>; Fri, 03 Jun 2022 00:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=trapM3KIYQ0IQi6DX47BuIAgKDllMEKOabAF1mkHxFs=;
        b=Z/79kozT2/6g1BV/WFgdxXwt8knEgJUn1YHloYgrMGePc0XddwMPOwqRLGo2ewgkcN
         8h/Y+y2zcCn3+UfG+fjFEReDAvwSqljc3u5zbXemK+yUEnsTHAFqjREhe1W5JWtJQ2oY
         RzWopWZdCRJtBNF7ogpLJo/lcuN3fXc/ghImVfr1xM03VGRMIkk0PIxGhajj5QQHDr16
         pBg0XAcQ1jARl0WQoMXGnGmP+RQLGnct6ZmWlTDuNBLdjyyRY7YW/PpkJubg+8MVDg6A
         h4lf+NiCUr8cbs3NrcXqbD9yc2UGEE81MW8SU+dUmfVlB/qpA+mMDWPfkPv0fFAXG5DU
         cmCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=trapM3KIYQ0IQi6DX47BuIAgKDllMEKOabAF1mkHxFs=;
        b=0yb9d7ysgOHHtEKtn5VCWpxgaItU+ECrkkQ+Sxzopp6n1tlXdDljYWwV9s9IlD/zHO
         HJHPoE1hicE41Z0+sCGPpXcMNbtHtkl8kPDM+30NcD9gpjrmb+szVjmcy6GrJTJeEzu6
         tqvRa65qn1K2A83qHeL/zRG5bywC1fznitD3MdvPhz1UTK7mS8t+V521xwutADQggZgM
         i7tzY4XE9FSukk2Xbvtn148kzLk0mou3yiq8Z8iJXkGsZdCXmR9QoC1vS5aj2MKxTHri
         DA0Q18PJgGC0G7/UU6w7DmF+xaHNyWWaulf+BnFCl7MNAvKpxYP6ft3GUZlgOPtSYu/i
         ehZw==
X-Gm-Message-State: AOAM531O10kFpgPASlmZKQWJ1N9UxGOHFmqPEhsiyhJsW5/WEJPPXYXs
        RK5/l7pnp8lioEXzhZcTkfhP6ZhO6YLq+QGY
X-Google-Smtp-Source: ABdhPJwhi04aaFzgO2Njb02gkEU/pJws3GqS/mwstjhtP7iGSfZ+ggStYY5XcLU99jn0WTBZFAQv0Q==
X-Received: by 2002:a05:6512:1041:b0:478:afc6:5846 with SMTP id c1-20020a056512104100b00478afc65846mr5927012lfb.132.1654243154045;
        Fri, 03 Jun 2022 00:59:14 -0700 (PDT)
Received: from eriador.lan ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id bp2-20020a056512158200b00477c5940bbasm1438428lfb.265.2022.06.03.00.59.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jun 2022 00:59:13 -0700 (PDT)
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
Subject: [PATCH v9 0/5] PCI: qcom: Rework pipe_clk/pipe_clk_src handling
Date:   Fri,  3 Jun 2022 10:59:03 +0300
Message-Id: <20220603075908.1853011-1-dmitry.baryshkov@linaro.org>
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

