Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF36A523405
	for <lists+linux-pci@lfdr.de>; Wed, 11 May 2022 15:20:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243772AbiEKNUA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 May 2022 09:20:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243689AbiEKNTd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 11 May 2022 09:19:33 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 63631239D84;
        Wed, 11 May 2022 06:19:32 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3F7F8ED1;
        Wed, 11 May 2022 06:19:32 -0700 (PDT)
Received: from lpieralisi (unknown [10.57.1.148])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BA13E3F66F;
        Wed, 11 May 2022 06:19:29 -0700 (PDT)
Date:   Wed, 11 May 2022 14:19:24 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Taniya Das <quic_tdas@quicinc.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Prasad Malisetty <quic_pmaliset@quicinc.com>,
        Johan Hovold <johan+linaro@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH v4 0/5] PCI: qcom: Rework pipe_clk/pipe_clk_src handling
Message-ID: <Ynu33PC19JIKinC+@lpieralisi>
References: <20220501192149.4128158-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220501192149.4128158-1-dmitry.baryshkov@linaro.org>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, May 01, 2022 at 10:21:44PM +0300, Dmitry Baryshkov wrote:
> PCIe pipe clk (and some other clocks) must be parked to the "safe"
> source (bi_tcxo) when corresponding GDSC is turned off and on again.
> Currently this is handcoded in the PCIe driver by reparenting the
> gcc_pipe_N_clk_src clock.
> 
> Instead of doing it manually, follow the approach used by
> clk_rcg2_shared_ops and implement this parking in the enable() and
> disable() clock operations for respective pipe clocks.
> 
> PCIe part depends on [1].
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
> [1]: https://lore.kernel.org/all/20220401133351.10113-1-johan+linaro@kernel.org/
> 
> Dmitry Baryshkov (5):
>   PCI: qcom: Remove unnecessary pipe_clk handling
>   clk: qcom: regmap: add pipe clk implementation
>   clk: qcom: gcc-sm8450: use new clk_regmap_pipe_ops for PCIe pipe
>     clocks
>   clk: qcom: gcc-sc7280: use new clk_regmap_pipe_ops for PCIe pipe
>     clocks
>   PCI: qcom: Drop manual pipe_clk_src handling
> 
>  drivers/clk/qcom/Makefile              |  1 +
>  drivers/clk/qcom/clk-regmap-pipe.c     | 62 ++++++++++++++++++++
>  drivers/clk/qcom/clk-regmap-pipe.h     | 24 ++++++++
>  drivers/clk/qcom/gcc-sc7280.c          | 49 ++++++----------
>  drivers/clk/qcom/gcc-sm8450.c          | 51 ++++++----------
>  drivers/pci/controller/dwc/pcie-qcom.c | 81 +-------------------------
>  6 files changed, 128 insertions(+), 140 deletions(-)
>  create mode 100644 drivers/clk/qcom/clk-regmap-pipe.c
>  create mode 100644 drivers/clk/qcom/clk-regmap-pipe.h

Hi guys,

where are we with this series ? I have noticed there is an ongoing
review so if you don't disagree I'd mark it as "Changes Requested" and
wait for a v5.

Thanks,
Lorenzo
