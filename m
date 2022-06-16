Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1836854E93F
	for <lists+linux-pci@lfdr.de>; Thu, 16 Jun 2022 20:21:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235683AbiFPSV0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 16 Jun 2022 14:21:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbiFPSVZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 16 Jun 2022 14:21:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 202E4506C4;
        Thu, 16 Jun 2022 11:21:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A8F0861BA2;
        Thu, 16 Jun 2022 18:21:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C53F8C34114;
        Thu, 16 Jun 2022 18:21:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655403683;
        bh=cmRfg7X//eVIPrSvjI8seaNeifUe7vwALs4NzXS6qmg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=OIlpiPrVQUlhy6+TSS6fJYhCo/WvFB/R6IZzUy5dLiTZsrErDG+UTVf7UeNu1mkMj
         OBG6AlE5WbgDrf8C/QwTQGQpFptTkMseP5bu3IzYoPs0fMGaZNboXuMSewLsPOGWD2
         awAt/ERxe9QEPpBLH7UsnhMG2RMruGx4axjbZ9fZEVvHUs0nNBHq935hsA25cA5zqY
         fyKZ0kwJt6SIZLb/gxgOI6zXMgS0ESdGkO6XjV/oAUvXvRnskgwmOk/Qgb3lvfv3C+
         sXuZpbmW/tDX+77d9ZBtxs3AQIUic+CZTz4l/xMyANUyO74E1VjIJapLVt5ctgz4T4
         WgOI7S6on3PDQ==
Date:   Thu, 16 Jun 2022 13:21:20 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Taniya Das <quic_tdas@quicinc.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Johan Hovold <johan+linaro@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-pci@vger.kernel.org, Johan Hovold <johan@kernel.org>
Subject: Re: [PATCH v11 0/5] PCI: qcom: Rework pipe_clk/pipe_clk_src handling
Message-ID: <20220616182120.GA1099986@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220608105238.2973600-1-dmitry.baryshkov@linaro.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jun 08, 2022 at 01:52:33PM +0300, Dmitry Baryshkov wrote:
> PCIe pipe clk (and some other clocks) must be parked to the "safe"
> source (bi_tcxo) when corresponding GDSC is turned off and on again.
> Currently this is handcoded in the PCIe driver by reparenting the
> gcc_pipe_N_clk_src clock.
> 
> Instead of doing it manually, follow the approach used by
> clk_rcg2_shared_ops and implement this parking in the enable() and
> disable() clock operations for respective pipe clocks.
> 
> Changes since v10:
>  - Added linux/bitfield.h include (lkp)
>  - Split fw_name/name lines in the gcc-sm8450.c (Johan)
> 
> Changes since v9:
>  - Respin fixing Tested-by tags, no code changes
> 
> Changes since v8:
>  - Readded .name to changed entries in gcc-sc7280 driver to restore
>    compatibility with older DTS,
>  - Rebased on top of linux-next, dropping reverts,
>  - Verified to include all R-b tags (excuse me, Johan, I missed them
>    in the previous iteration).
> 
> Changes since v7:
>  - Brought back the struct clk_regmap_phy_mux (Johan)
>  - Fixed includes (Stephen)
>  - Dropped CLK_SET_RATE_PARENT flags from changed pipe clocks, they are
>    not set in the current code and they are useless as the PHY's clock
>    has fixed rate.
> 
> Changes since v6:
>  - Switched the ops to use GENMASK/FIELD_GET/FIELD_PUT (Stephen),
>  - As all pipe/symbol clock source clocks have the same register (and
>    parents) layout, hardcode all the values. If the need arises, this
>    can be changed later (Stephen),
>  - Fixed commit messages and comments (suggested by Johan),
>  - Added revert for the clk_regmap_mux_safe that have been already
>    picked up by Bjorn.
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
> Dmitry Baryshkov (5):
>   clk: qcom: regmap: add PHY clock source implementation
>   clk: qcom: gcc-sm8450: use new clk_regmap_phy_mux_ops for PCIe pipe
>     clocks
>   clk: qcom: gcc-sc7280: use new clk_regmap_phy_mux_ops for PCIe pipe
>     clocks
>   PCI: qcom: Remove unnecessary pipe_clk handling
>   PCI: qcom: Drop manual pipe_clk_src handling
> 
> 
> Dmitry Baryshkov (5):
>   clk: qcom: regmap: add PHY clock source implementation
>   clk: qcom: gcc-sm8450: use new clk_regmap_phy_mux_ops for PCIe pipe
>     clocks
>   clk: qcom: gcc-sc7280: use new clk_regmap_phy_mux_ops for PCIe pipe
>     clocks
>   PCI: qcom: Remove unnecessary pipe_clk handling
>   PCI: qcom: Drop manual pipe_clk_src handling
> 
>  drivers/clk/qcom/Makefile              |  1 +
>  drivers/clk/qcom/clk-regmap-phy-mux.c  | 62 ++++++++++++++++++++
>  drivers/clk/qcom/clk-regmap-phy-mux.h  | 33 +++++++++++
>  drivers/clk/qcom/gcc-sc7280.c          | 49 +++++-----------
>  drivers/clk/qcom/gcc-sm8450.c          | 49 +++++-----------
>  drivers/pci/controller/dwc/pcie-qcom.c | 81 +-------------------------
>  6 files changed, 127 insertions(+), 148 deletions(-)
>  create mode 100644 drivers/clk/qcom/clk-regmap-phy-mux.c
>  create mode 100644 drivers/clk/qcom/clk-regmap-phy-mux.h

I applied this to pci/ctrl/qcom for v5.20, thanks!

Clock folks (Bjorn A, Andy, Michael, Stephen), I assume you're OK with
these being merged via the PCI tree.  Let me know if you prefer
anything different.
