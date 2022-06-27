Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A15C55C359
	for <lists+linux-pci@lfdr.de>; Tue, 28 Jun 2022 14:48:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240885AbiF0UDj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 27 Jun 2022 16:03:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240864AbiF0UDc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 27 Jun 2022 16:03:32 -0400
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE3591AD9E
        for <linux-pci@vger.kernel.org>; Mon, 27 Jun 2022 13:03:27 -0700 (PDT)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-fb6b4da1dfso14330684fac.4
        for <linux-pci@vger.kernel.org>; Mon, 27 Jun 2022 13:03:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pEbnakX9ReNlYrF6bJYGc9hxTauX/UTESErA+SDMYyc=;
        b=i04jimy0AGkSGYGUYaSylul1oyNIOisAHqHdBWgyENy6DzQfuPLX+v0yJKxdrKJXsN
         kdwjmElbSLGnm1+9i0UoLwHfiF0lSuKanhVsvE7K5TzOUvQlFLITOZQaPgvBvvbR81xZ
         LgpiexQ22dav57qwBKcz1N3GB1X91JULzscgkuyfJ6+nuD6yzT/gd4wJ0AhL+2YFaMSM
         CHqoa87iY6DfpCYsoXNi/1eayStvkOvX4Bkqk8e7p1FiGSDX4jJrOU7Q9Qbz625NVdQs
         v+irNr27co4IhMdXOaNOHb+owuvpwFXjoqLiZiTFZ+jWLPkVMf+hpM3aOHd4PKB9J9Wj
         3KKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pEbnakX9ReNlYrF6bJYGc9hxTauX/UTESErA+SDMYyc=;
        b=oOL/p56y43mQI5ggU1RsD4Q+nv1Q7gL3WZQ8FoDKiA64z4GGRB0XzQxQ2e/4WuMsRd
         xYn56uN7OuGxDdfm5/00J/4Y5xWKnWPc9lD70rxG+ZHwvhPcQIDs20LYsHVzYX6qK8e5
         iDg8HzekBsYvC/bH6FfAYktcHQ+GB3tythYVmSt7hRRHTFHOHvE6lNCKLN+JryDoeYec
         DcaeVv51x/1oojl64e3w9qApnOWMLnk8i/17D8SaQ2UOK5NZOudwqP/EfGfcLaUpvp2Q
         +xvx9Fv8sFRKiUphGfj8jxZEyj4F+regfVsmfhrddPcdp0f8tIz6t+CoshruXTOHlm6s
         7IxA==
X-Gm-Message-State: AJIora/SnRee3sReX27wIy2D24bXseWR0dDeuMOAacdHfcIJFdqtbu96
        z5KS4Fuahy/vWBX3ecMj45RN1g==
X-Google-Smtp-Source: AGRyM1ull+SQY4Uch41P9rkK0kfYa+mO8h2ODPedcK1cH/NcH2VtDcPLLxPEh72IQG3oI8Yfho5R4A==
X-Received: by 2002:a05:6870:c587:b0:100:fc8b:7135 with SMTP id ba7-20020a056870c58700b00100fc8b7135mr11759317oab.276.1656360206901;
        Mon, 27 Jun 2022 13:03:26 -0700 (PDT)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id m16-20020a4a9510000000b0041bdf977c6dsm6428729ooi.31.2022.06.27.13.03.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 13:03:26 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Taniya Das <quic_tdas@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <swboyd@chromium.org>
Cc:     linux-arm-msm@vger.kernel.org, Johan Hovold <johan@kernel.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        linux-pci@vger.kernel.org, linux-clk@vger.kernel.org
Subject: Re: (subset) [PATCH v11 0/5] PCI: qcom: Rework pipe_clk/pipe_clk_src handling
Date:   Mon, 27 Jun 2022 15:02:46 -0500
Message-Id: <165636016349.3080661.11515834835284657733.b4-ty@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220608105238.2973600-1-dmitry.baryshkov@linaro.org>
References: <20220608105238.2973600-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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

On Wed, 8 Jun 2022 13:52:33 +0300, Dmitry Baryshkov wrote:
> PCIe pipe clk (and some other clocks) must be parked to the "safe"
> source (bi_tcxo) when corresponding GDSC is turned off and on again.
> Currently this is handcoded in the PCIe driver by reparenting the
> gcc_pipe_N_clk_src clock.
> 
> Instead of doing it manually, follow the approach used by
> clk_rcg2_shared_ops and implement this parking in the enable() and
> disable() clock operations for respective pipe clocks.
> 
> [...]

Applied, thanks!

[1/5] clk: qcom: regmap: add PHY clock source implementation
      commit: 74e4190cdebe5a4aa099185edb4db418fc9883e3
[2/5] clk: qcom: gcc-sm8450: use new clk_regmap_phy_mux_ops for PCIe pipe clocks
      commit: 7ee9d2e8b9c9f4a829cd2d77c8cba36c514f24ba
[3/5] clk: qcom: gcc-sc7280: use new clk_regmap_phy_mux_ops for PCIe pipe clocks
      commit: 553d12b20c10953617cc195f9e447a177c776f9d

Best regards,
-- 
Bjorn Andersson <bjorn.andersson@linaro.org>
