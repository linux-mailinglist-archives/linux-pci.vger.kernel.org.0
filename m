Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47AE3553E0C
	for <lists+linux-pci@lfdr.de>; Tue, 21 Jun 2022 23:44:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356242AbiFUVnu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 21 Jun 2022 17:43:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345358AbiFUVnr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 21 Jun 2022 17:43:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82D7517585;
        Tue, 21 Jun 2022 14:43:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 126D36159B;
        Tue, 21 Jun 2022 21:43:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 303B4C3411C;
        Tue, 21 Jun 2022 21:43:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655847825;
        bh=vrMa9DlL0Gtn/NRPsxBoWIuls9uIFmuXvxlJ7YOzZ+o=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=MZeYhSs++wYDAHtTC1/hhERtHYB+j8OmAKQie3RU7h7LjTQwGTEkyThD8XDvq5kdZ
         yoPQ9/7lNX+EVkaBPhJukr96nGgedT5z54/m5EEPreqR1Bhh2PSmnZHo4RRJv/DWlj
         E1y+DOqr+NgB2mNMhohKufFfD3RoLv4GCMMXdj103gbgbmd7Iz/DaGRPEJ6xoX8jyF
         gkT5Rwvlstm5TKDgO83TtBN0wIYIjM8gEjiRnhYsfsPIYq8sTP85m974o4se5FA5gO
         BgQdEGq/9DrfqH4SE9udvxaabkzcvFVA4iNFc+RwzFrBUryZDG/iSmgqitnUY6SdOI
         WRZC80wGzYLeg==
Date:   Tue, 21 Jun 2022 16:43:43 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Robert Marko <robimarko@gmail.com>
Cc:     Stanimir Varbanov <svarbanov@mm-sol.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        lpieralisi@kernel.org, Rob Herring <robh@kernel.org>, kw@linux.com,
        Bjorn Helgaas <bhelgaas@google.com>, p.zabel@pengutronix.de,
        jingoohan1@gmail.com, linux-pci@vger.kernel.org,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        johan+linaro@kernel.org
Subject: Re: [PATCH v2] PCI: qcom: fix IPQ8074 Gen2 support
Message-ID: <20220621214343.GA1335071@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOX2RU7idTVcW6ivqs3V_Ep33RoHZs1zt0jav-_z2D7xpKJstw@mail.gmail.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jun 21, 2022 at 11:05:17PM +0200, Robert Marko wrote:
> On Tue, 21 Jun 2022 at 22:32, Bjorn Helgaas <helgaas@kernel.org> wrote:
> > On Tue, Jun 21, 2022 at 01:23:30PM +0200, Robert Marko wrote:
> > > IPQ8074 has one Gen2 and one Gen3 port, currently the Gen2 port will
> > > cause the system to hang as its using DBI registers in the .init
> > > and those are only accesible after phy_power_on().
> >
> > Is the fact that IPQ8074 has both a Gen2 and a Gen3 port relevant to
> > this patch?  I don't see the connection.
> 
> Not really, I can remove it from the description as this only affects the Gen2
> port, Gen3 support is dependant on the IPQ6018 support getting merged as
> it uses the same controller.

Great, I think unrelated details confuse things.

> > I see that qcom_pcie_host_init() does:
> >
> >   qcom_pcie_host_init
> >     pcie->cfg->ops->init(pcie)
> >     phy_power_on(pcie->phy)
> >     pcie->cfg->ops->post_init(pcie)
> >
> > and that you're moving DBI register accesses from
> > qcom_pcie_init_2_3_3() to qcom_pcie_post_init_2_3_3().
> >
> > But I also see DBI register accesses in other .init() functions:
> >
> >   qcom_pcie_init_2_1_0
> >   qcom_pcie_init_1_0_0      (oddly out of order)
> >   qcom_pcie_init_2_3_2
> >   qcom_pcie_init_2_4_0
> >
> > Why do these accesses not need to be moved?  I assume it's because
> > pcie->phy is an optional PHY and phy_power_on() does nothing on those
> > controllers?
> 
> As far as I could figure out from QCA-s 5.4 kernel, various commits,
> and QCA-s attempts to solve this already upstream the Gen2
> controller in IPQ8074 is a bit special and requires the PHY to be
> powered on before DBI could be accessed or else the board will hang
> as it does for me.
> 
> I can only assume that this is an IPQ8074-specific quirk and other
> IP-s are not affected like this, so they were not broken.

> > Whatever the reason, I think the DBI accesses should be done
> > consistently in .post_init().  I see that Dmitry's previous patches
> > removed all those .post_init() functions, but I think the consistency
> > is worth having.
> >
> > Perhaps we could reorder the patches so this patch comes first, moves
> > the DBI accesses into .post_init(), then Dmitry's patches could be
> > rebased on top to drop the clock handling?
> >
> > > So solve this by splitting the DBI read/writes to .post_init.
> 
> I am open to anything to get this fixed properly, you are gonna need
> to point me in the right direction as I am really new to PCI.

Unless there's a reason *not* to move the DBI accesses for other
variants, I think we should move them all to .post_init().  Otherwise
it's just magic -- there's no indication in the code about why IPQ8074
needs to be different from all the rest.

a0fd361db8e5 appeared in v5.11, so presumably IPQ8074 has been broken
since then?  Are there any problem report URLs or references to the
attempts you mentioned above that we could include here?

Since folks may want to backport the fix to v5.11, I'd probably do
this patch by itself to make the backport easier, then add a second
patch to move the DBI accesses for all the other variants.

My personal opinion is that you should do this based on v5.19-rc1, and
then we can rebase Dmitry's patches on top.  That would make all the
patches simpler and it would make yours easier to backport.  But
that's the sort of thing Dmitry, Stanimir, Andy, and Bjorn A. could
weigh in on.

Bjorn H.
