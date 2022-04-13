Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BA705002A0
	for <lists+linux-pci@lfdr.de>; Thu, 14 Apr 2022 01:31:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238915AbiDMXeM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 13 Apr 2022 19:34:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236369AbiDMXeL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 13 Apr 2022 19:34:11 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB712255BA
        for <linux-pci@vger.kernel.org>; Wed, 13 Apr 2022 16:31:47 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id x33so6263419lfu.1
        for <linux-pci@vger.kernel.org>; Wed, 13 Apr 2022 16:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=L23++vG+rcVhWm2DvHDsv7vneuGVFqt8W5bShIuNdO4=;
        b=BkN81DvvpADc+u0KXCmkdCf0As8a6LM5TVzvfmpayDRrntSVCqu1sFdiQtvDrspCrQ
         o0GYfEW5Xumb3MLafdUcybe4aMeCI+JBvv6waBTuNwqktBQ+uctYMY6ulop8Te41KnIA
         YDB6zk0kt4IoJ3CXEciWLAIyRAh1QrG74Z+5kCACdVegaB1gXmVg+4OB+kA5koyec+eD
         u4WUcs8QpJwBkQFT1gVw9R/l1kuBso7ehIq4AaxRNRsrlr+ENmnv7rClUC4TxpnDP920
         ihm7xbubGlgdhhEenCZrM+vXJFmE2Lilf7Xblv5WeNMmiddk1zEDgBDv+uWTTcbnF8Do
         riXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=L23++vG+rcVhWm2DvHDsv7vneuGVFqt8W5bShIuNdO4=;
        b=Y1dfpoiYgEzQZ5vWWi73nG5DJsnjaAge6ekcrHJcSMrifHZ3ZP+VfUgBDvhctvY8Dh
         nBnTbH1fC676gF7shSfTvgG3PtdOfn13xo3i/uHDKYdrEd98om390VhgDM7+tkxfrHND
         MFR/4JVclh84cun/QIW0HpeC+ncozoontwZWgXLiFEoelKWX7keqerzRC7a37JlUouSy
         Qin34JtC8m9hYr7XtLGbuTzu7M9gxrzrC99yuRuf+/++eUj7YqyeP7Td5Kl/7N9/R0og
         I9AD3O/TaSUAyOJfOSy0SVmsREi+LKsWalvfPig2aUe469CO1qa5pdL+QmqEOUof5eB8
         jsXg==
X-Gm-Message-State: AOAM531hupHg4gUHti3AmuJ/4SvVDkMYH0mJoH+Kkq2Arpw5ysyLC5n9
        ANmgK4qWUxIc4e2kTM9KCd/NIA==
X-Google-Smtp-Source: ABdhPJzzKjsh79Vh4ujKGCNq8FsGo1Sa8ZdUerH/pZULrTAtCF0DT7DJYtS/mU9QBE6p7xG+7yfZVw==
X-Received: by 2002:a19:f518:0:b0:46d:58b:160c with SMTP id j24-20020a19f518000000b0046d058b160cmr34037lfb.533.1649892706092;
        Wed, 13 Apr 2022 16:31:46 -0700 (PDT)
Received: from eriador.lan ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id m5-20020a0565120a8500b0044a2963700fsm40982lfu.70.2022.04.13.16.31.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 16:31:45 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Taniya Das <tdas@codeaurora.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Prasad Malisetty <quic_pmaliset@quicinc.com>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: [PATCH v3 0/6] PCI: qcom: rework pipe_clk/pipe_clk_src handling
Date:   Thu, 14 Apr 2022 02:31:38 +0300
Message-Id: <20220413233144.275926-1-dmitry.baryshkov@linaro.org>
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

PCIe part depends on [1].

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

[1]: https://lore.kernel.org/all/20220401133351.10113-1-johan+linaro@kernel.org/

Dmitry Baryshkov (6):
  clk: qcom: add two parent_map helpers
  clk: qcom: regmap-mux: add pipe clk implementation
  clk: qcom: gcc-sm8450: use new clk_regmap_mux_safe_ops for PCIe pipe
    clocks
  clk: qcom: gcc-sc7280: use new clk_regmap_mux_safe_ops for PCIe pipe
    clocks
  PCI: qcom: Remove unnecessary pipe_clk handling
  PCI: qcom: Drop manual pipe_clk_src handling

 drivers/clk/qcom/clk-regmap-mux.c      | 121 +++++++++++++++++++++++++
 drivers/clk/qcom/clk-regmap-mux.h      |   3 +
 drivers/clk/qcom/common.c              |  24 +++++
 drivers/clk/qcom/common.h              |   5 +
 drivers/clk/qcom/gcc-sc7280.c          |   8 +-
 drivers/clk/qcom/gcc-sm8450.c          |   8 +-
 drivers/pci/controller/dwc/pcie-qcom.c |  81 +----------------
 7 files changed, 168 insertions(+), 82 deletions(-)


base-commit: 3123109284176b1532874591f7c81f3837bbdc17
prerequisite-patch-id: 71e4b5b7ff5d87f2407735cc6a3074812cde3697
-- 
2.35.1

