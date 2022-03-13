Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51C854D71AF
	for <lists+linux-pci@lfdr.de>; Sun, 13 Mar 2022 01:08:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229579AbiCMAJk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 12 Mar 2022 19:09:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231493AbiCMAJj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 12 Mar 2022 19:09:39 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D544E27CE7
        for <linux-pci@vger.kernel.org>; Sat, 12 Mar 2022 16:08:32 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id g17so21213351lfh.2
        for <linux-pci@vger.kernel.org>; Sat, 12 Mar 2022 16:08:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KYzgaSIoD3CUDpG7/nAndp/gB6PTBNti3DSpjbFfIOU=;
        b=uS6KjdJ8aOypqEzEfQ/AUctalWXZJNVdzy5NBmgsNY3b5WQSGn/Z3fDcNlucyXegbs
         avaSqz1VSBYk29BSOYJKomVrteK530SbpH/LgLY5WDTyCYCngvSsIpBNrXwLJrqFhP+M
         /HtbRSgT4ctiK9MZPDZWB4Eu1oLNBNZDWZ0GJtUVcbIqSv2Y3VkC5W8Yx9s3KArFIcAd
         H9lqQI12A7JYy3p159bIy6MFBeOL28sJrgHuJqsjvbJ2ZfDN0gzEH2vYGhW5foBRsbQv
         mdlnMv2Rp2HTXK0b5GkT1dDrQI+2ZsCZQALX0ZIRWHFwebUTzL+P8lNG1smtsSOUICiE
         5BAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KYzgaSIoD3CUDpG7/nAndp/gB6PTBNti3DSpjbFfIOU=;
        b=RelX7zL9ikRSduX+0V2BhiwLOUqcaO7JLAj7nPRf+e28pth7QUVX7FAICgr9X6Ojff
         SzSXWHaZ4Xg5/En5DLder1RpW36aVJPgBo1XmF3fDBMGtkMzNmmSvGbRAqpLIHuzD7Mk
         g5tIpDm2LeZAow8IFQ/akIGuLqZzmecYiuOki5FlFZQcoWP+KQPPRo0VdeDR302msqKD
         9PyTVfMe6IWFv0cNg523ZToI7qOnJ0zlg7fVnBX+6Y3Hi3YpNSqkVgQkYsqx2DVj3DkC
         eyy4ulYiNQIq4JBRM18HPTb5DQJCpWfuytFHmFcjSlfqCmB7c/8CmbQ7QiV2Vhq2taKa
         5Adw==
X-Gm-Message-State: AOAM533N8gtDqk7XaWkBmmbDTq9vVwplDoZRx80oDD7QbgP7yicycela
        9cCwssXtpAevjdfjTmdTC5NhpA==
X-Google-Smtp-Source: ABdhPJyEqY8FQ26jVkLFocORkLVHSUfWLKV9UPaQ5ffDHO7SCxdBz1sCz7U/0j6Hxd8w4u2rKpUK7A==
X-Received: by 2002:a05:6512:3c9a:b0:448:5ba2:3184 with SMTP id h26-20020a0565123c9a00b004485ba23184mr9645900lfv.219.1647130111018;
        Sat, 12 Mar 2022 16:08:31 -0800 (PST)
Received: from eriador.lumag.spb.ru (pppoe.178-66-158-48.dynamic.avangarddsl.ru. [178.66.158.48])
        by smtp.gmail.com with ESMTPSA id e7-20020a05651c038700b00247dbb3e476sm2776017ljp.40.2022.03.12.16.08.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Mar 2022 16:08:30 -0800 (PST)
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
Subject: [RFC PATCH 0/5] PCI: qcom: rework pipe_clk/pipe_clk_src handling
Date:   Sun, 13 Mar 2022 03:08:19 +0300
Message-Id: <20220313000824.229405-1-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.34.1
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

Dmitry Baryshkov (5):
  clk: qcom: regmap-mux: add pipe clk implementation
  clk: qcom: gcc-sm8450: use new clk_regmap_mux_safe_ops for PCIe pipe
    clocks
  clk: qcom: gcc-sc7280: use new clk_regmap_mux_safe_ops for PCIe pipe
    clocks
  PCI: qcom: Remove unnecessary pipe_clk handling
  PCI: qcom: Drop manual pipe_clk_src handling

 drivers/clk/qcom/clk-regmap-mux.c      | 70 +++++++++++++++++++++
 drivers/clk/qcom/clk-regmap-mux.h      |  3 +
 drivers/clk/qcom/gcc-sc7280.c          |  6 +-
 drivers/clk/qcom/gcc-sm8450.c          |  6 +-
 drivers/pci/controller/dwc/pcie-qcom.c | 87 +-------------------------
 5 files changed, 84 insertions(+), 88 deletions(-)

-- 
2.34.1

