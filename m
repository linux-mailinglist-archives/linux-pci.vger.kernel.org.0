Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7638B56AC71
	for <lists+linux-pci@lfdr.de>; Thu,  7 Jul 2022 22:05:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236430AbiGGUEK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 7 Jul 2022 16:04:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232340AbiGGUEJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 7 Jul 2022 16:04:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C61D21804;
        Thu,  7 Jul 2022 13:04:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 28F44623E4;
        Thu,  7 Jul 2022 20:04:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DBBFC3411E;
        Thu,  7 Jul 2022 20:04:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657224247;
        bh=YPa3BIkZtqvlLnXa9XSQS4ByKHBS3emeXJsmuOZ6STk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=EIrTUJr/srlG7CuhYxq2iVHRDxlSmOVa8iOanyptaS5RBKIXsAz5CFuJPosKN8sBa
         wbzVRXNIHnDvQurlp9Nbl2bJd6khvp5Q24i/n26KUyFaUaAVbR0yyDbGBntaZ1J34v
         HQpWDcwO9MIYV07oQIHAefPsX3xRv8UWgQ+BZzV94QtO88aFDSDc5Dv9EMW/1hQqfa
         M1qD8zBYWZOnWMIxbxeCOB6hKm2GcRL70I/63rJGhX3YG+fBDIUYVQowCHqoGujDwP
         LcSIbBG6tusvttDjxDmcxLaV7IfNZwCCDHfqIxD2FKCnN32oj/nrQPXy0Kia7bstzs
         4gf8e6BSyGYCA==
Date:   Thu, 7 Jul 2022 15:04:04 -0500
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
        linux-pci@vger.kernel.org, Johan Hovold <johan@kernel.org>,
        Selvam Sathappan Periakaruppan <quic_speriaka@quicinc.com>,
        Baruch Siach <baruch.siach@siklu.com>,
        Robert Marko <robimarko@gmail.com>,
        Krishna chaitanya chundru <quic_krichai@quicinc.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v11 0/5] PCI: qcom: Rework pipe_clk/pipe_clk_src handling
Message-ID: <20220707200404.GA330065@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220707154020.GA305104@bhelgaas>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Selvam, Baruch, Robert, Krishna, Krzysztof (other contributors to
qcom)]

On Thu, Jul 07, 2022 at 10:40:23AM -0500, Bjorn Helgaas wrote:
> On Thu, Jul 07, 2022 at 05:03:48PM +0300, Dmitry Baryshkov wrote:
> > On 16/06/2022 21:21, Bjorn Helgaas wrote:
> > > On Wed, Jun 08, 2022 at 01:52:33PM +0300, Dmitry Baryshkov wrote:
> > > > PCIe pipe clk (and some other clocks) must be parked to the "safe"
> > > > source (bi_tcxo) when corresponding GDSC is turned off and on again.
> > > > Currently this is handcoded in the PCIe driver by reparenting the
> > > > gcc_pipe_N_clk_src clock.

> > > > Dmitry Baryshkov (5):
> > > >    clk: qcom: regmap: add PHY clock source implementation
> > > >    clk: qcom: gcc-sm8450: use new clk_regmap_phy_mux_ops for PCIe pipe
> > > >      clocks
> > > >    clk: qcom: gcc-sc7280: use new clk_regmap_phy_mux_ops for PCIe pipe
> > > >      clocks
> > > >    PCI: qcom: Remove unnecessary pipe_clk handling
> > > >    PCI: qcom: Drop manual pipe_clk_src handling

> > > I applied this to pci/ctrl/qcom for v5.20, thanks!
> > > 
> > > Clock folks (Bjorn A, Andy, Michael, Stephen), I assume you're OK with
> > > these being merged via the PCI tree.  Let me know if you prefer
> > > anything different.
> > 
> > I noticed that this patchset is not a part of linux-next. Is it still
> > pending to be merged in 5.20?
> 
> It's still pending.  I currently have three separate qcom-related
> branches that need to be reconciled before I put them in -next.

The first three patches are on an immutable branch from the clock
tree:

  74e4190cdebe ("clk: qcom: regmap: add PHY clock source implementation")
  7ee9d2e8b9c9 ("clk: qcom: gcc-sm8450: use new clk_regmap_phy_mux_ops for PCIe pipe clocks")
  553d12b20c10 ("clk: qcom: gcc-sc7280: use new clk_regmap_phy_mux_ops for PCIe pipe clocks")

I added the rest on top of that:

  cbd27d5c2ccf ("PCI: qcom: Move IPQ8074 DBI register accesses after phy_power_on()")
  633c1fa00ab9 ("PCI: qcom: Move all DBI register accesses after phy_power_on()")
  e835e9859548 ("dt-bindings: PCI: qcom: Fix description typo")
  55e8a13ec92f ("PCI: qcom: Remove unnecessary pipe_clk handling")
  1690864ec3c8 ("PCI: dwc: tegra: move GEN3_RELATED DBI register to common header")
  39e0a12b484b ("PCI: qcom: Define slot capabilities using PCI_EXP_SLTCAP_*")
  44d07e984b93 ("PCI: qcom: Add IPQ60xx support")

and pushed it to a pci/ctrl/qcom-pending branch so you can check it
out.  It's "pending" for now because I really want an ack and some
testing for 633c1fa00ab9 ("PCI: qcom: Move all DBI register accesses
after phy_power_on()").

There's a LOT of stuff going on in qcom-land this cycle, and it's
coming from a lot of different people.  We can deal with that, but it
does complicate things and slow them down.  I think it would be easier
and speed things up if we could figure out how to coordinate things on
the qcom side.

Bjorn
