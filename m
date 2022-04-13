Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD9274FF198
	for <lists+linux-pci@lfdr.de>; Wed, 13 Apr 2022 10:17:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233153AbiDMISe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 13 Apr 2022 04:18:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233717AbiDMISd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 13 Apr 2022 04:18:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 958E14D638;
        Wed, 13 Apr 2022 01:16:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 30AA0616E9;
        Wed, 13 Apr 2022 08:16:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 916F3C385A4;
        Wed, 13 Apr 2022 08:16:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649837771;
        bh=GhcEljhJaIb/OxxUFW2Jzk8YnvwDp3+oEU/cfGhkCrI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GpiM1ipI3ArXH6FtHRsnv8TZhjzuYegG2Sgnh7avQ8h07s1O/+Rk2SNxD4xXdJwVP
         T9pr49kfrZUeKtXmmyHD1XOSENGzYEamufE91g6I/lHuHaWXl7nIB2R7LdWRUQ7Olq
         8Up6Z+3TMYFO0qXE/mYDhciznf+gmj8MNyR68WeWyY6rMkvwRw8OkEcPuIjtZ4vwq/
         UNR6tDYVLGy9KBfepHxW5wxkyvF7Ns0sOmRSxAEfOPRo5oIImNtaK5EYcVtTactE4X
         5zHoPWWS7JpV2Fri3vghn65OBOqyLi0hH/RVy7RDe+fi2d/ohXfMXryO053jlHkLVe
         5OJC0LNkC0i8A==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1neYAX-0004ym-7y; Wed, 13 Apr 2022 10:16:05 +0200
Date:   Wed, 13 Apr 2022 10:16:05 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Taniya Das <tdas@codeaurora.org>,
        Krzysztof Wilczy??ski <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Prasad Malisetty <quic_pmaliset@quicinc.com>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH v1 1/5] clk: qcom: regmap-mux: add pipe clk implementation
Message-ID: <YlaGxQLeXKIZjXy+@hovoldconsulting.com>
References: <20220323085010.1753493-1-dmitry.baryshkov@linaro.org>
 <20220323085010.1753493-2-dmitry.baryshkov@linaro.org>
 <YlAZVrDXwdIItyTy@lpieralisi>
 <YlXI0fg21XZPXwf4@builder.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YlXI0fg21XZPXwf4@builder.lan>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Apr 12, 2022 at 01:45:37PM -0500, Bjorn Andersson wrote:
> On Fri 08 Apr 06:15 CDT 2022, Lorenzo Pieralisi wrote:
> 
> > On Wed, Mar 23, 2022 at 11:50:06AM +0300, Dmitry Baryshkov wrote:
> > > On recent Qualcomm platforms the QMP PIPE clocks feed into a set of
> > > muxes which must be parked to the "safe" source (bi_tcxo) when
> > > corresponding GDSC is turned off and on again. Currently this is
> > > handcoded in the PCIe driver by reparenting the gcc_pipe_N_clk_src
> > > clock. However the same code sequence should be applied in the
> > > pcie-qcom endpoint, USB3 and UFS drivers.
> > > 
> > > Rather than copying this sequence over and over again, follow the
> > > example of clk_rcg2_shared_ops and implement this parking in the
> > > enable() and disable() clock operations. As we are changing the parent
> > > behind the back of the clock framework, also implement custom
> > > set_parent() and get_parent() operations behaving accroding to the clock
> > > framework expectations (cache the new parent if the clock is in disabled
> > > state, return cached parent).
> > > 
> > > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > > ---
> > >  drivers/clk/qcom/clk-regmap-mux.c | 78 +++++++++++++++++++++++++++++++
> > >  drivers/clk/qcom/clk-regmap-mux.h |  3 ++
> > >  2 files changed, 81 insertions(+)
> > 
> > Need BjornA's ACK on this patch and I can pull the series then.
> > 
> 
> It seems I have a few more clock patches in the queue which depends on
> top of this, so I picked up the three clock branches and pushed a tag
> for you to pick up, Lorenzo.

I've found a few issues with these clock patches and I'm starting to
think we should consider handling the muxing in the PHY driver instead.

Dmitry just posted a v2, which I'll comment on:

	https://lore.kernel.org/all/20220412193839.2545814-1-dmitry.baryshkov@linaro.org/

Please take a look at that before merging the clock changes.

Johan
