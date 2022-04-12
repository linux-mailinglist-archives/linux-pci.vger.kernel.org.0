Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 938B34FE8BE
	for <lists+linux-pci@lfdr.de>; Tue, 12 Apr 2022 21:38:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242521AbiDLTlJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 12 Apr 2022 15:41:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244404AbiDLTlC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 12 Apr 2022 15:41:02 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D06E231909
        for <linux-pci@vger.kernel.org>; Tue, 12 Apr 2022 12:38:42 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id c15so25355939ljr.9
        for <linux-pci@vger.kernel.org>; Tue, 12 Apr 2022 12:38:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hqu6eAZOv/0nY4/2E8PkxtI6T+4ystHMKkpUp7lC3C0=;
        b=XHsCN+I4AgLmBeL2xDoqMBiTUGmY3NQjUuhHerNGty+o7UMhH3XGZ5Iz6EO2NcRheM
         MvsnEpFFVZ0x4lvwKCOH6oUPQVKPYHTVvMMlnns4W10iGD+lmNZX2w6cQ5bBbBs3HmyH
         BNIei8URxwktpA5DY1cCSPNuYoSuoTTb0RIfkysDu9zTsyAQoSW6X86VtJUUgtvTLRa4
         olxT/+ogLvCtxcr/O7maKHTuLLZF+oqnpluLLwcqIVS6LEJakQzW8AtUEURX2lN5nDDQ
         Zb2E155nY8/0ua5w05jId5TzldA8kQbl+TPfVr2UVe0n/CmGHBDiKgvzQ6cRVf6qrpM0
         5ZfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hqu6eAZOv/0nY4/2E8PkxtI6T+4ystHMKkpUp7lC3C0=;
        b=VK+M+SSyiSjt+n0QEbuu0N4DRtl2gsxrPLObZZlF3oX2FWcccm714jSDqfpxa+Apkt
         6MKjvcPyxw3SCTgu7wdaVBLf5I0JQvjgZbZRzff3YqJiAcbimB7f93a1MBhTGtIVw1Sv
         zORu4jY7Sp3mtHReths1zb6ttDbk7dGw5FjslVZMKtY2QmTUVzlrm+dSrrMmTeKhs2Va
         zth7nVWFNNT0YVHr2EIOD93Bzneb9lwyJ0qduGaBCoyniKKhqH+EiZ0CMO3fnmu76Ro8
         filUoatj2JclFYfVVNxWHqbVSsndyPJ2qxyx4+AdcFFN8lu6zIgQWKMCFVs4WN59487a
         7mKQ==
X-Gm-Message-State: AOAM532kS+inSwqa+ZWGncHKf/eySXSfSCkKqDjIFiEapJXJTrNh4SiM
        iGLQDNHphofGH/9FeODshwz9yA==
X-Google-Smtp-Source: ABdhPJx9AKnMLIscdowX0J4qLobuLHtqvJqroM938IbGqWulHbWHf9hTd0+Calb1jJyzMksKhev2Jw==
X-Received: by 2002:a05:651c:10a5:b0:24b:4c15:2741 with SMTP id k5-20020a05651c10a500b0024b4c152741mr15475965ljn.510.1649792321135;
        Tue, 12 Apr 2022 12:38:41 -0700 (PDT)
Received: from eriador.lan ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id m4-20020a0565120a8400b00450abeb42b3sm2731641lfu.235.2022.04.12.12.38.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Apr 2022 12:38:40 -0700 (PDT)
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
Subject: [PATCH v2 0/5] PCI: qcom: rework pipe_clk/pipe_clk_src handling
Date:   Tue, 12 Apr 2022 22:38:34 +0300
Message-Id: <20220412193839.2545814-1-dmitry.baryshkov@linaro.org>
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

Changes since v1:
 - Rebased on top of [1].
 - Removed erroneous Fixes tag from the patch 4.

Changes since RFC:
 - Rework clk-regmap-mux fields. Specify safe parent as P_* value rather
   than specifying the register value directly
 - Expand commit message to the first patch to specially mention that
   it is required only on newer generations of Qualcomm chipsets.

Dmitry Baryshkov (5):
  clk: qcom: regmap-mux: add pipe clk implementation
  clk: qcom: gcc-sm8450: use new clk_regmap_mux_safe_ops for PCIe pipe
    clocks
  clk: qcom: gcc-sc7280: use new clk_regmap_mux_safe_ops for PCIe pipe
    clocks
  PCI: qcom: Remove unnecessary pipe_clk handling
  PCI: qcom: Drop manual pipe_clk_src handling

 drivers/clk/qcom/clk-regmap-mux.c      | 78 +++++++++++++++++++++++++
 drivers/clk/qcom/clk-regmap-mux.h      |  3 +
 drivers/clk/qcom/gcc-sc7280.c          |  6 +-
 drivers/clk/qcom/gcc-sm8450.c          |  6 +-
 drivers/pci/controller/dwc/pcie-qcom.c | 81 +-------------------------
 5 files changed, 92 insertions(+), 82 deletions(-)

base-commit: 3123109284176b1532874591f7c81f3837bbdc17
prerequisite-patch-id: 71e4b5b7ff5d87f2407735cc6a3074812cde3697
-- 
2.35.1

