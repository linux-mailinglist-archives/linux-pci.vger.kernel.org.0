Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CF345268BF
	for <lists+linux-pci@lfdr.de>; Fri, 13 May 2022 19:53:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382746AbiEMRxp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 13 May 2022 13:53:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357601AbiEMRxo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 13 May 2022 13:53:44 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7507945047
        for <linux-pci@vger.kernel.org>; Fri, 13 May 2022 10:53:42 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id f4so2946346lfu.12
        for <linux-pci@vger.kernel.org>; Fri, 13 May 2022 10:53:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EywLNplJdhTOSjIrHEUbtkgjSZSVIH3B6l+DwWXu1aM=;
        b=t93IW+xsm+igKQJ+Tt3mX6kLOZYQXbTUPG9S0er4q92iJDT5dcfCtLMdhpbm1EpIgd
         GHhEJCMDodOIjFA/OcM6mzxfS9JhTcJXZWTwrF165y9sAdJAmwjmnT32UXuN5jey+dHL
         A4VKkh9PgLRFPfwe2rpIYXZxS7w7nOHSJgkHWiwJ6f2XK6O/sujszjtFMKaVzpzbvwUx
         blWGCPcvCOEtagWh9InsfcP/cxT7A1pDjxlsX0QU229SQ8oSSJwY5D4WlIROpiMfiCP9
         zKsX/CgdpA+bey3h28/xykFwYaFHQxuak7cpPT32OmY2LBTReReOiZwn/PNQEMe/KMin
         gM/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EywLNplJdhTOSjIrHEUbtkgjSZSVIH3B6l+DwWXu1aM=;
        b=mw33+s9CgyxXHZxDHaJfhgBJOuXXgdFDLlXcf/f0JLjy8bYHGTlKY9ROTK4An+zGst
         lNm1dfd6q+H+NcxC9jKmWHD/6JUTPHme5yYncRr8qe52xY1udNDV4yDNa2jE9nIjXuIy
         KMInvOAqpWMgJBXfMR5uyHw9bnxT37dDfAdT0O4hqWHddM6ydmJRSF5QD2qmMaa/37qJ
         Y5/a0/EJK9ZjWj10d9eQBmBSCvtD87RQn2x4J9q74bJuIYcKW2eg0PCLhJUT2rP4ycq4
         00GBSooT0qfquWPDndMPpfxHhkXN9ivuX8CM7vIgazfJcLqUyeyfYq6Jt6Kv+1LBpO9+
         PuWg==
X-Gm-Message-State: AOAM532O27+rGeG8kvh/2LyscaXBJhTNsAnUDgf25iZ3liznj9A9DUoh
        FCuUvFn4gs2yN7J2wWWR7AHZRg==
X-Google-Smtp-Source: ABdhPJxl8CVYhd4bafVoMCRPgIhQg6yHs3CiF7ixBVMn3g6QrszZ9qd96nLEefR3oGkPlJQ7xtkT+w==
X-Received: by 2002:a05:6512:3b26:b0:473:a671:eff2 with SMTP id f38-20020a0565123b2600b00473a671eff2mr4447090lfv.500.1652464420840;
        Fri, 13 May 2022 10:53:40 -0700 (PDT)
Received: from eriador.lan ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id n2-20020a195502000000b0047255d21164sm448614lfe.147.2022.05.13.10.53.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 May 2022 10:53:40 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Prasad Malisetty <quic_pmaliset@quicinc.com>,
        Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-clk@vger.kernel.org
Subject: [PATCH v6 0/5] PCI: qcom: Rework pipe_clk/pipe_clk_src handling
Date:   Fri, 13 May 2022 20:53:34 +0300
Message-Id: <20220513175339.2981959-1-dmitry.baryshkov@linaro.org>
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
  PCI: qcom: Remove unnecessary pipe_clk handling
  clk: qcom: regmap: add PHY clock source implementation
  clk: qcom: gcc-sm8450: use new clk_regmap_pipe_src_ops for PCIe pipe
    clocks
  clk: qcom: gcc-sc7280: use new clk_regmap_pipe_src_ops for PCIe pipe
    clocks
  PCI: qcom: Drop manual pipe_clk_src handling

 drivers/clk/qcom/Makefile              |  1 +
 drivers/clk/qcom/clk-regmap-phy-mux.c  | 62 ++++++++++++++++++++
 drivers/clk/qcom/clk-regmap-phy-mux.h  | 37 ++++++++++++
 drivers/clk/qcom/gcc-sc7280.c          | 49 ++++++----------
 drivers/clk/qcom/gcc-sm8450.c          | 51 ++++++----------
 drivers/pci/controller/dwc/pcie-qcom.c | 81 +-------------------------
 6 files changed, 141 insertions(+), 140 deletions(-)
 create mode 100644 drivers/clk/qcom/clk-regmap-phy-mux.c
 create mode 100644 drivers/clk/qcom/clk-regmap-phy-mux.h


base-commit: 3123109284176b1532874591f7c81f3837bbdc17
prerequisite-patch-id: 71e4b5b7ff5d87f2407735cc6a3074812cde3697
-- 
2.35.1

