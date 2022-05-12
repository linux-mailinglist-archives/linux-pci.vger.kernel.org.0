Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46344525393
	for <lists+linux-pci@lfdr.de>; Thu, 12 May 2022 19:29:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357043AbiELR3O (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 12 May 2022 13:29:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357033AbiELR3N (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 12 May 2022 13:29:13 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F61D26BC8D
        for <linux-pci@vger.kernel.org>; Thu, 12 May 2022 10:29:12 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id bu29so10409903lfb.0
        for <linux-pci@vger.kernel.org>; Thu, 12 May 2022 10:29:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QqEWL1rH8iN3CN8FjFBg00CzRjn0uL3tiylPGVgUxSg=;
        b=dejG/JnVNSiY9rsh1DU5CWw+y/+ZhEMSPM2QSTbTb0HyogACJN6fa2is3MYNAKK8oX
         +630Lzr/DvdXYyWNaKxkr/antVFOS/4pXR0IWrV1tpTVuBjLwg3kwuILCpPT+d/k0GDJ
         aJVBDP7RZyyWFirT4cjYxCMHQEv3JFcKlDB3oZQH1XO2zQlENoJVx1eUSpOPay7/wM4i
         ibM9V0Ikpmrms4Jrk7jElyZzcwtOErr+4x68NVNqJifIPKn7OI3tfTngHhZtqGFzbQxE
         aPq6QRkR1Sd6w112+lyynMGniSK0AYQkUZPUWzQShkvDyJd1+caSg8o+j5N9jNJK6rzV
         QBkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QqEWL1rH8iN3CN8FjFBg00CzRjn0uL3tiylPGVgUxSg=;
        b=RYo7X+9pJsf8WQeHFhIUdemqFvEWXHccjtnl79mUVdcYDKXnOFHuYMtFtxeTzFsZ+K
         0pnElsIzA6cE0leNmDCeN2zoBCTQAB0FrfndUORpkGXoOsnZelkYfuVLesTMS0JWncYa
         TXKAl90LbU9hT9ljStpCtyr+GV171SOdutkEO9S4YUc8D8PssWCVEJ8owWQK9qbcJKdF
         zzo3yqgUE/G9xE6ZSK+4O10CCRAhbnQia0dLOHQCwYwUuIYXnFzNW9/vs8qAIr6IkVWD
         WU2H7UI35F0zFsEu0hzz5H6g5B53tmpB1VPHo7oeaxcZmyeKiL0vs71scozCVyeR0A6z
         lH5w==
X-Gm-Message-State: AOAM533itdf2WvuFhHh/9d3bb3frylAy8zjuD/PhNa3Qg1iZmlFUS3fu
        5si8r/2fUIijopuVY/0mke0EfQ==
X-Google-Smtp-Source: ABdhPJzP0OrsbfQ/xocauFIbWB3Rw/r+vru1in60QV8VW0hoRp9jGm5e0Ok1NesuZB/YmYHAX6hoLg==
X-Received: by 2002:a05:6512:128f:b0:473:a2ec:5df6 with SMTP id u15-20020a056512128f00b00473a2ec5df6mr590837lfs.196.1652376550570;
        Thu, 12 May 2022 10:29:10 -0700 (PDT)
Received: from eriador.lan ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id y10-20020a2e95ca000000b0024f3d1dae9asm11520ljh.34.2022.05.12.10.29.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 May 2022 10:29:10 -0700 (PDT)
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
Cc:     Prasad Malisetty <pmaliset@codeaurora.org>,
        Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-clk@vger.kernel.org
Subject: [PATCH v5 0/5]  PCI: qcom: Rework pipe_clk/pipe_clk_src handling
Date:   Thu, 12 May 2022 20:29:04 +0300
Message-Id: <20220512172909.2436302-1-dmitry.baryshkov@linaro.org>
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

[1]: https://lore.kernel.org/all/20220401133351.10113-1-johan+linaro@kernel.org/

Dmitry Baryshkov (5):
  PCI: qcom: Remove unnecessary pipe_clk handling
  clk: qcom: regmap: add PHY clock source implementation
  clk: qcom: gcc-sm8450: use new clk_regmap_pipe_src_ops for PCIe pipe
    clocks
  clk: qcom: gcc-sc7280: use new clk_regmap_pipe_src_ops for PCIe pipe
    clocks
  PCI: qcom: Drop manual pipe_clk_src handling

 drivers/clk/qcom/Makefile              |  1 +
 drivers/clk/qcom/clk-regmap-pipe-src.c | 62 ++++++++++++++++++++
 drivers/clk/qcom/clk-regmap-pipe-src.h | 24 ++++++++
 drivers/clk/qcom/gcc-sc7280.c          | 49 ++++++----------
 drivers/clk/qcom/gcc-sm8450.c          | 51 ++++++----------
 drivers/pci/controller/dwc/pcie-qcom.c | 81 +-------------------------
 6 files changed, 128 insertions(+), 140 deletions(-)
 create mode 100644 drivers/clk/qcom/clk-regmap-pipe-src.c
 create mode 100644 drivers/clk/qcom/clk-regmap-pipe-src.h


base-commit: 3123109284176b1532874591f7c81f3837bbdc17
prerequisite-patch-id: 71e4b5b7ff5d87f2407735cc6a3074812cde3697
-- 
2.35.1

