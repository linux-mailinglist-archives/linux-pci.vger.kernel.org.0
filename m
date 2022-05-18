Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E2CF52B44F
	for <lists+linux-pci@lfdr.de>; Wed, 18 May 2022 10:06:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232689AbiERHxz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 18 May 2022 03:53:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232735AbiERHxk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 18 May 2022 03:53:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E2591269AE;
        Wed, 18 May 2022 00:53:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 881F66152B;
        Wed, 18 May 2022 07:53:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE036C385A5;
        Wed, 18 May 2022 07:53:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652860419;
        bh=wsoY9EWuWhPSh9lDx/BL+ibLvGhG0eiDuJqXMKQi7rI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AIUwU5TK0W7tKafD+3h68/R8ckUifjuohELwNCvGuPobg/1AnTGDDe+/Xr/hfz3Un
         YsVYSAXXvWcwjYorrBhu/4eumMbAuNjSA8LuCaDIJFjm2RDBCXoSqDI7G84Fq9P5cC
         BoU9zkgFhNJEaVgOo3KzxVtJElatI8OOZKrgTbZKh9IcMLx/bciKj8if0b715hGpYr
         RdnGrcxEgdeUUsAGALvRpntCnJvfjLSWDHuoyLKIaKqzXPbxyTMIAHdL2nQwB1zpKg
         1EDFF7l0qwuqK/7VL76dGS6GBqMgvwng1Khgein0H44aWE8frtg0cHrRFSfvLO7yGU
         YjVNfxXqY0+jQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1nrEV1-0004NV-K8; Wed, 18 May 2022 09:53:39 +0200
Date:   Wed, 18 May 2022 09:53:39 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Prasad Malisetty <quic_pmaliset@quicinc.com>,
        Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH v6 0/5] PCI: qcom: Rework pipe_clk/pipe_clk_src handling
Message-ID: <YoSmA1QpSexF1kkV@hovoldconsulting.com>
References: <20220513175339.2981959-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220513175339.2981959-1-dmitry.baryshkov@linaro.org>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, May 13, 2022 at 08:53:34PM +0300, Dmitry Baryshkov wrote:
> PCIe pipe clk (and some other clocks) must be parked to the "safe"
> source (bi_tcxo) when corresponding GDSC is turned off and on again.
> Currently this is handcoded in the PCIe driver by reparenting the
> gcc_pipe_N_clk_src clock.
> 
> Instead of doing it manually, follow the approach used by
> clk_rcg2_shared_ops and implement this parking in the enable() and
> disable() clock operations for respective pipe clocks.
> 
> Changes since v5:
>  - Rename the clock to clk-regmap-phy-mux and the enable/disable values
>    to phy_src_val and ref_src_val respectively (as recommended by
>    Johan).
> 
> Changes since v4:
>  - Renamed the clock to clk-regmap-pipe-src,
>  - Added mention of PCIe2 PHY to the commit message,
>  - Expanded commit messages to mention additional pipe clock details.
> 
> Changes since v3:
>  - Replaced the clock multiplexer implementation with branch-like clock.
> 
> Changes since v2:
>  - Added is_enabled() callback
>  - Added default parent to the pipe clock configuration
> 
> Changes since v1:
>  - Rebased on top of [1].
>  - Removed erroneous Fixes tag from the patch 4.
> 
> Changes since RFC:
>  - Rework clk-regmap-mux fields. Specify safe parent as P_* value rather
>    than specifying the register value directly
>  - Expand commit message to the first patch to specially mention that
>    it is required only on newer generations of Qualcomm chipsets.
> 
> 
> Dmitry Baryshkov (5):
>   PCI: qcom: Remove unnecessary pipe_clk handling
>   clk: qcom: regmap: add PHY clock source implementation
>   clk: qcom: gcc-sm8450: use new clk_regmap_pipe_src_ops for PCIe pipe
>     clocks
>   clk: qcom: gcc-sc7280: use new clk_regmap_pipe_src_ops for PCIe pipe
>     clocks
>   PCI: qcom: Drop manual pipe_clk_src handling

So Bjorn A has already applied v2 of the three clock patches this series
to his tree. I guess dropping or reverting does is the best way to
handle this since trying to fix things up incrementally would just be
messy.

Johan
