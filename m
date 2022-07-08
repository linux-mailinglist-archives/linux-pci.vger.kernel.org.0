Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89DAC56C1D9
	for <lists+linux-pci@lfdr.de>; Sat,  9 Jul 2022 01:12:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239058AbiGHULb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 8 Jul 2022 16:11:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238794AbiGHULb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 8 Jul 2022 16:11:31 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DED41BEA0;
        Fri,  8 Jul 2022 13:11:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C1A0BB82953;
        Fri,  8 Jul 2022 20:11:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31E4BC341C0;
        Fri,  8 Jul 2022 20:11:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657311087;
        bh=dSuZEii2kPeJ5k08UvvanEJ35KgMk4ZNaDHgAgpT+JY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=f4xCtLZaM1SXzL8phG9I0RtcgPWeZQ6SqT41LIjkYrifHkklWm96Qcc1hAJ8Ax1HL
         Y946fYtWQyodl0FwDnpWsV41o4Oo8XkXPOqvZGzQ/T5SF2yhd+uUvG9iiDrsm2Lhfd
         QCPh6VlPn4BCTlao7wAnI5ejw+dcBVNjjptp/JyBVYN7sjKSK5w5hSZovdsDzX7XwV
         1JGRogN5k+6HUL+9hVfy8zEwpVKEcsrPBF48OheRkOGi1SD6sIs54fbc/AbHSH5BoQ
         L3TH9e8vKhRg+d9sA5mmrDid042KVtYLKdIkHxGD0D8/ByaLfZP3wXKlfrUVmXZzwQ
         6cw8m14ifSNvA==
Date:   Fri, 8 Jul 2022 15:11:25 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Christian Marangi <ansuelsmth@gmail.com>
Cc:     Robert Marko <robimarko@gmail.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        lpieralisi@kernel.org, Rob Herring <robh@kernel.org>, kw@linux.com,
        Bjorn Helgaas <bhelgaas@google.com>, p.zabel@pengutronix.de,
        jingoohan1@gmail.com, linux-pci@vger.kernel.org,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        johan+linaro@kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: Re: [PATCH v4 2/2] PCI: qcom: Move all DBI register accesses after
 phy_power_on()
Message-ID: <20220708201125.GA371162@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <62c883e3.1c69fb81.45d3d.7d2a@mx.google.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jul 08, 2022 at 09:22:09PM +0200, Christian Marangi wrote:
> On Fri, Jul 08, 2022 at 02:17:09PM -0500, Bjorn Helgaas wrote:
> > On Fri, Jul 08, 2022 at 07:02:48PM +0200, Christian Marangi wrote:
> > > On Fri, Jul 08, 2022 at 06:47:57PM +0200, Christian Marangi wrote:
> > > > On Fri, Jul 08, 2022 at 06:39:37PM +0200, Robert Marko wrote:
> > > > > On Thu, 7 Jul 2022 at 21:41, Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > > > > On Fri, Jun 24, 2022 at 12:44:20PM +0200, Robert Marko wrote:
> > > > > > > IPQ8074 requires the PHY to be powered on before accessing DBI registers.
> > > > > > > It's not clear whether other variants have the same dependency, but there
> > > > > > > seems to be no reason for them to be different, so move all the DBI
> > > > > > > accesses from .init() to .post_init() so they are all after phy_power_on().
> > > > > > >
> > > > > > > Signed-off-by: Robert Marko <robimarko@gmail.com>
> > > > > >
> > > > > > Would any of the qcom driver folks care to review and ack this?
> > > > > > Stanimir, Andy, Bjorn A (from get_maintainer.pl)?
> > > > 
> > > > Hi Bjorn,
> > > > I tested this on ipq806x and the current patch cause regression as pci
> > > > doesn't work anymore...
> > > > This is a before the patch [1] and this is an after [2].
> > > > 
> > > > As you notice the main problem here is
> > > > [    2.559962] qcom-pcie 1b700000.pci: Phy link never came up
> > > > 
> > > > The cause of this has already been bisected and actually it was a fixup
> > > > pushed some time ago for 2_1_0.
> > > > 
> > > > Uboot can leave the pci in an underfined state and this
> > > > writel(1, pcie->parf + PCIE20_PARF_PHY_CTRL);
> > > > is never called.
> > > > 
> > > > This is mandatory to a correct init and MUST be called before regulator
> > > > enable and reset deassert or the "Phy link never came up" problem is
> > > > triggered.
> > > > 
> > > > So to fix this we just have to have
> > > > writel(1, pcie->parf + PCIE20_PARF_PHY_CTRL);
> > > > in qcom_pcie_init_2_1_0 right after the reset_contro_assert.
> > > > 
> > > > This command is also present in qcom_pcie_init_2_3_2 where the same
> > > > exact reg is written so I assume 2_3_2 have the same regression and the
> > > > write must be placed in init and can't be moved to post_init.
> > > > 
> > > > Feel free to tell me how to proceed if I should post an additional patch
> > > > or you prefer Robi to respin this with the few lines reverted.
> > > > 
> > > > [1] https://gist.github.com/Ansuel/ec827319e585630356fc586273db6f0d
> > > > [2] https://gist.github.com/Ansuel/63fbcab2681cd28a61ec52d7874fa30d
> > > 
> > > While testing this I notice something odd...
> > > 
> > > 2_4_2 prepare the pipe clock only AFTER PCIe clocks and reset are
> > > enabled while in 2_1_0... That made me think there could be a problem
> > > with the current code of 2_1_0... A quick change made me discover that
> > > the problem is actually that we enable prepare_enable clock BEFORE the
> > > value is written in PCIE20_PARF_PHY_CTRL.
> > > 
> > > By moving the clk_bulk_prepare_enable after the "enable PCIe clocks and
> > > resets" make the pci work with the current change...
> > > 
> > > So it could be that the current changes are correct and it's really just
> > > a bug in 2_1_0 enabling clock before writing the correct value...
> > > 
> > > Tell me how to proceed... think at this point a good idea would be to
> > > create a separate patch and fix this for good.
> > 
> > Hmm, I think I made a mistake when I put this patch in the middle and
> > applied other stuff on top of it.  I'd like to just postpone this
> > patch while we work out these issues, but I think it's not completely
> > trivial since it's in the middle.  I'll try to straighten this out
> > next week.
> 
> From my discoveries it really seems just a bug in 2_1_0 with enabling
> the phy clk BEFORE setting the require bit...
> 
> Moving the bulk_prepare_enable after the bit is set makes everything
> works as it should... If you want I can send a patch as that is clearly
> a bug and currenty we have a workaround in place...

That'd be great!  Since it's an actual bug fix, I think it would be
good if it were a separate patch instead of doing in the middle of a
patch that also does other things.

Bjorn
