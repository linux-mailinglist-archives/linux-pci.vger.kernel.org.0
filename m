Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03A3356A723
	for <lists+linux-pci@lfdr.de>; Thu,  7 Jul 2022 17:40:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235625AbiGGPkZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 7 Jul 2022 11:40:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235470AbiGGPkZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 7 Jul 2022 11:40:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BAE2E9A;
        Thu,  7 Jul 2022 08:40:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A01246239B;
        Thu,  7 Jul 2022 15:40:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75E04C341C0;
        Thu,  7 Jul 2022 15:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657208423;
        bh=KRAqPIGa6RCSu0JjXWHDhbJsoglo3H9ioTvcj879if8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=KdWsEJtcBSgVVTjX4nc+e2dLbvMXdGLo1F2jebQFfn7uCzpkkCWQQn9LgWzXNA4T3
         BMmpZFK/l6J5K4Jwywl7yvaw52+wBcjIxNWktAa29stJviqq/lfbeB5TLb04WuZojh
         VRh/BuevVjqR3Cvly3e3T0cZBs3c5BdcP4ZGbQUlvXeopOUq/Lc9VgnxPW9O9l96yK
         hg5dRpgymPwt/ynq36iUpx1ADXe9qL2hmXBHpAxKhMe7/xpuZhaGYudhq2Hq4warQI
         aVQFtCaMGYxfOBzaM/rb2J29pK0P47IlgaK+6giJ3U/6+TXaujgs3zRa9MI5wiJH5U
         Ru44Fx1OmOj6A==
Date:   Thu, 7 Jul 2022 10:40:20 -0500
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
Message-ID: <20220707154020.GA305104@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e00b1317-9c2e-0b11-8c0b-1fa4a17e4761@linaro.org>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jul 07, 2022 at 05:03:48PM +0300, Dmitry Baryshkov wrote:
> On 16/06/2022 21:21, Bjorn Helgaas wrote:
> > On Wed, Jun 08, 2022 at 01:52:33PM +0300, Dmitry Baryshkov wrote:
> > > PCIe pipe clk (and some other clocks) must be parked to the "safe"
> > > source (bi_tcxo) when corresponding GDSC is turned off and on again.
> > > Currently this is handcoded in the PCIe driver by reparenting the
> > > gcc_pipe_N_clk_src clock.

> > > Dmitry Baryshkov (5):
> > >    clk: qcom: regmap: add PHY clock source implementation
> > >    clk: qcom: gcc-sm8450: use new clk_regmap_phy_mux_ops for PCIe pipe
> > >      clocks
> > >    clk: qcom: gcc-sc7280: use new clk_regmap_phy_mux_ops for PCIe pipe
> > >      clocks
> > >    PCI: qcom: Remove unnecessary pipe_clk handling
> > >    PCI: qcom: Drop manual pipe_clk_src handling
> > > 
> > > 
> > > Dmitry Baryshkov (5):
> > >    clk: qcom: regmap: add PHY clock source implementation
> > >    clk: qcom: gcc-sm8450: use new clk_regmap_phy_mux_ops for PCIe pipe
> > >      clocks
> > >    clk: qcom: gcc-sc7280: use new clk_regmap_phy_mux_ops for PCIe pipe
> > >      clocks
> > >    PCI: qcom: Remove unnecessary pipe_clk handling
> > >    PCI: qcom: Drop manual pipe_clk_src handling
> > > 
> > >   drivers/clk/qcom/Makefile              |  1 +
> > >   drivers/clk/qcom/clk-regmap-phy-mux.c  | 62 ++++++++++++++++++++
> > >   drivers/clk/qcom/clk-regmap-phy-mux.h  | 33 +++++++++++
> > >   drivers/clk/qcom/gcc-sc7280.c          | 49 +++++-----------
> > >   drivers/clk/qcom/gcc-sm8450.c          | 49 +++++-----------
> > >   drivers/pci/controller/dwc/pcie-qcom.c | 81 +-------------------------
> > >   6 files changed, 127 insertions(+), 148 deletions(-)
> > >   create mode 100644 drivers/clk/qcom/clk-regmap-phy-mux.c
> > >   create mode 100644 drivers/clk/qcom/clk-regmap-phy-mux.h
> > 
> > I applied this to pci/ctrl/qcom for v5.20, thanks!
> > 
> > Clock folks (Bjorn A, Andy, Michael, Stephen), I assume you're OK with
> > these being merged via the PCI tree.  Let me know if you prefer
> > anything different.
> 
> I noticed that this patchset is not a part of linux-next. Is it still
> pending to be merged in 5.20?

It's still pending.  I currently have three separate qcom-related
branches that need to be reconciled before I put them in -next.

Bjorn
