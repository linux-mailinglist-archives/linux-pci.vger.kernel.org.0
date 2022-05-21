Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7FA052F70C
	for <lists+linux-pci@lfdr.de>; Sat, 21 May 2022 02:53:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354234AbiEUAxt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 20 May 2022 20:53:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354075AbiEUAxt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 20 May 2022 20:53:49 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4FAE1AEC54
        for <linux-pci@vger.kernel.org>; Fri, 20 May 2022 17:53:47 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id u30so16924348lfm.9
        for <linux-pci@vger.kernel.org>; Fri, 20 May 2022 17:53:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eiE3saeN56PNZ4QQslHGAdxhWgCAIye4cgjJAc2aLT4=;
        b=THB0qo38VsHybEhBI9MFGMAJMWh+5uBh+zwOEZjlZd5gVdwxKfmSr4mKBVpHS7UGiK
         OCVPySTS/pA1pdesFGlWrKHiy/uIgSowYGGhHCEKf1spsun6s1E/y7xa5pKV9eAoXmd5
         G8of9LVrhc9PJyATghrOagRFLDEazibCdD83J9t5ZS7Z9/NYMfjdz9VtpJKHGTLgi+lO
         oeCTfW3x2zgFnIwVEpZwNUXzX+nOL8VZqx1cnyfXTIYJymnQtg56AUVIVFNI8+BbLcCc
         GI34tmakNGCEB5K80nu2njyICs5Ps7SvRwqmIkiTCL/1iaKhN4AMuKBa7yt3rXrya6Zt
         h5UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eiE3saeN56PNZ4QQslHGAdxhWgCAIye4cgjJAc2aLT4=;
        b=LGy5RMxqjP60EXjPUTvc27f0C+ekyuJiSCHCHO2NHZ/Jftaazozcj5TIhDHNR5uQ0f
         dhnY42lX3/kSk0j7wRzVWgUfCo9LOXKLq74WgxSwFlpgkx5Z1XmvzeXuIXUTIthShjkM
         i5AvMJGcq/rpKZM8gTQ+Ve25pHipohIiQ1Dfj08sDQ+jhCdBTr3ZEmP+qgse3nP9oVfs
         ZfrUuayynwshnZGrZ9SnEZUvcJyHdqcJK2BsANNk07I5UGKFeChJukf8AMJqoHY1NiPp
         zXSzhONV0iiv6Mq/5UamqRfcEZxHn7oDHS+OFmEq6bTC3U5osoQBnDNqb5/Fpz2RI7Dj
         y8rQ==
X-Gm-Message-State: AOAM533R5f5iRfU0S+A4F1QR8zjsH/wzVrcqO6BfpbrMjj2gMXOAmzdC
        0x1KX3U+kaY1zy6jnOcBWpBsJQ==
X-Google-Smtp-Source: ABdhPJyplEAAeQMRTXLKq67dSETvc5izogTOWci3idP9MNoEwPSR4lU62Ruf6ElFkJIJEangXItvsw==
X-Received: by 2002:a19:c20b:0:b0:477:bec9:4f99 with SMTP id l11-20020a19c20b000000b00477bec94f99mr8750897lfc.274.1653094426188;
        Fri, 20 May 2022 17:53:46 -0700 (PDT)
Received: from eriador.lan ([2001:470:dd84:abc0::8a5])
        by smtp.gmail.com with ESMTPSA id u14-20020a056512094e00b0047255d21187sm844559lft.182.2022.05.20.17.53.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 May 2022 17:53:45 -0700 (PDT)
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
Subject: [PATCH v7 0/8] PCI: qcom: Rework pipe_clk/pipe_clk_src handling
Date:   Sat, 21 May 2022 03:53:35 +0300
Message-Id: <20220521005343.1429642-1-dmitry.baryshkov@linaro.org>
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

Changes since v7:
 - Brought back the struct clk_regmap_phy_mux (Johan)
 - Fixed includes (Stephen)

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

Dmitry Baryshkov (8):
  Revert "clk: qcom: gcc-sm8450: use new clk_regmap_mux_safe_ops for
    PCIe pipe clocks"
  Revert "clk: qcom: gcc-sc7280: use new clk_regmap_mux_safe_ops for
    PCIe pipe clocks"
  Revert "clk: qcom: regmap-mux: add pipe clk implementation"
  clk: qcom: regmap: add PHY clock source implementation
  clk: qcom: gcc-sm8450: use new clk_regmap_phy_mux_ops for PCIe pipe
    clocks
  clk: qcom: gcc-sc7280: use new clk_regmap_phy_mux_ops for PCIe pipe
    clocks
  PCI: qcom: Remove unnecessary pipe_clk handling
  PCI: qcom: Drop manual pipe_clk_src handling

 drivers/clk/qcom/Makefile              |  1 +
 drivers/clk/qcom/clk-regmap-mux.c      | 78 -------------------------
 drivers/clk/qcom/clk-regmap-mux.h      |  3 -
 drivers/clk/qcom/clk-regmap-phy-mux.c  | 62 ++++++++++++++++++++
 drivers/clk/qcom/clk-regmap-phy-mux.h  | 33 +++++++++++
 drivers/clk/qcom/gcc-sc7280.c          | 49 +++++-----------
 drivers/clk/qcom/gcc-sm8450.c          | 51 +++++-----------
 drivers/pci/controller/dwc/pcie-qcom.c | 81 +-------------------------
 8 files changed, 125 insertions(+), 233 deletions(-)
 create mode 100644 drivers/clk/qcom/clk-regmap-phy-mux.c
 create mode 100644 drivers/clk/qcom/clk-regmap-phy-mux.h

-- 
2.35.1

