Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26627500CE5
	for <lists+linux-pci@lfdr.de>; Thu, 14 Apr 2022 14:17:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239493AbiDNMTj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 14 Apr 2022 08:19:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231996AbiDNMTj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 14 Apr 2022 08:19:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDCF95F8F0;
        Thu, 14 Apr 2022 05:17:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6B36161ED4;
        Thu, 14 Apr 2022 12:17:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDCCFC385A5;
        Thu, 14 Apr 2022 12:17:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649938633;
        bh=qmbesC0/Icw9+qiYiA7mFVyYz0+S7SQX+MroNisSWkE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uXX9tSRGzz1beJZ8yex9mmqV4YesXnyLh+DB7Jjmr1W4J/dH/ssQOoq7x5wdiNoeY
         q0/Tne4i2dibfZ7F42CXHJcLT/2hygd4qZ0g+rW8DgcvBkdLxAtvyxoAI9w9vl+TWt
         qdKV0uANJl5pivFnsr7ymEHwo6JVkrt2DpI5eggxlxVTUSDJmthOegs1WcaRP6c+56
         mDFxc5t8xKXJpFA4dRfaIvkgcf96rwB/AA5QunOuHDRonkw2iLsGwib9nK8ShJYfcV
         NqjetuYa5cBpZiLL3cjx7ox2IEcGwy8NOnTVwpb576iQTb5nzCnav1ic3YaWBKuNil
         R6IaNiPDc4B0g==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1neyPO-0006BB-Cw; Thu, 14 Apr 2022 14:17:10 +0200
Date:   Thu, 14 Apr 2022 14:17:10 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Taniya Das <quic_tdas@quicinc.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Prasad Malisetty <quic_pmaliset@quicinc.com>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 1/5] clk: qcom: regmap-mux: add pipe clk implementation
Message-ID: <YlgQxrKNOMcvy4cd@hovoldconsulting.com>
References: <20220412193839.2545814-1-dmitry.baryshkov@linaro.org>
 <20220412193839.2545814-2-dmitry.baryshkov@linaro.org>
 <YlaUtCuMZZL4bM2U@hovoldconsulting.com>
 <bbf1386f-0902-75ff-bb61-f4ebbc82f174@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bbf1386f-0902-75ff-bb61-f4ebbc82f174@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[ Please trim your replies. ]

On Wed, Apr 13, 2022 at 08:57:47PM +0300, Dmitry Baryshkov wrote:
> On 13/04/2022 12:15, Johan Hovold wrote:
> > On Tue, Apr 12, 2022 at 10:38:35PM +0300, Dmitry Baryshkov wrote:
> >> On recent Qualcomm platforms the QMP PIPE clocks feed into a set of
> >> muxes which must be parked to the "safe" source (bi_tcxo) when
> >> corresponding GDSC is turned off and on again. Currently this is
> >> handcoded in the PCIe driver by reparenting the gcc_pipe_N_clk_src
> >> clock. However the same code sequence should be applied in the
> >> pcie-qcom endpoint, USB3 and UFS drivers.
> > 
> > I'm starting to think this really belongs in the PHY driver which is the
> > provider of the pipe clock. Moving it there would also allow the code to
> > be shared between PCIe, USB, and UFS.
> > 
> > The PHY driver enables the pipe clock by starting the PHY and before
> > doing so there's no point in updating the mux. Similarly, the PHY driver
> > can restore the "safe" source after disabling the pipe clock.
> 
> I thought about this at some point. However it would still mean that the 
> driver does the dance manually: disable pipe_clock, switch parent, 
> sleep, switch the parent back, enable pipe clock. Switching parents is 
> tied to disabling pipe_clock, so enforcing this link seems like a better 
> option to me.

No, that's precisely my point. It is not tied to disabling (gating) the
pipe clock, it is tied to powering down the PHY (i.e. disabling the pipe
clock source). And that is under the control of the PHY driver.

In practise, once we've cleaned up the other users of the pipe clock,
tying it to pipe clock disabling will work, but it doesn't prevent
anyone from shooting themselves in the foot as the "safe-mux" name
suggests (i.e. it is still possibly to enable the pipe clock while its
source is disabled).

> No to mention that it would complicate already overcomplicated QMP driver.

That driver sure could use some love, but that's not a valid argument
against adding things were they belong.

And regarding complexity, I have a working prototype implementation here
which is smaller than what you're proposing and very straight forward.

> > That way there's no magic happening behind scenes, the clock framework
> > always reports the actual state of the tree, and the reason for all of
> > this can be documented in the QMP PHY driver once and for all.
> 
> We already have such 'magic' for the RCG2 (clk_rcg2_shared_ops), with 
> the very practical reason. If the clock is running from the tcxo, it is 
> as good as disabled from the practical purpose.

That implementation doesn't try to implement the caching you're
proposing and hence doesn't suffer from the associated implementation
issues.
 
> > The only change to the bindings compared to what this series proposes is
> > that the PHY driver also needs a reference to bi_tcxo.
> 
> And this looks as bad, as providing bi_tcxo to the PCI device. From the 
> schematics/silicon point of view neither of them actually uses these 
> parents. Neither of them uses the pipe_clock_src. What do they need is 
> just the pipe_clock. The rest should be in the programming API.

No, the PHY driver is both the provider of the source clock for the
pipe clock and the consumer of the latter.

That it may need to handle any muxes in between the two only makes
sense.

Hiding this away and spreading the implementation out over multiple
clock drivers (i.e. every mux definition for each platform + the
regmap-mux hack) only obscures things.

Johan
