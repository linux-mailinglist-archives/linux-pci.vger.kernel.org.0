Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D887457CEF3
	for <lists+linux-pci@lfdr.de>; Thu, 21 Jul 2022 17:31:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229906AbiGUPbM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 21 Jul 2022 11:31:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiGUPa7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 21 Jul 2022 11:30:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 124613C159;
        Thu, 21 Jul 2022 08:30:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A317D61556;
        Thu, 21 Jul 2022 15:30:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3F49C3411E;
        Thu, 21 Jul 2022 15:30:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658417458;
        bh=SFQYE0AeaGBUYobr5N4rROr0PBzJIl15RlLFl1zNU10=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=hkdMC6qos8rvuDHwtt8B8We9f2jaxYnu6kqHtRhDgGx+1sgo9q+IJpNHjmbE1vTJj
         HaeQNtl1BMtCMtyeCgCbN1MJ+qV5XIAErdxdsWDdmgha9svRQjY4tlroGDjqD9OyIh
         OxWl7sbr+7zSUqyJHMFUlD4pBSQcWVLq/YfEeRcJ9ga8iK9C4h1oa4vuQmdyFZ/0pk
         rti//nI7JnTg6H7uNVRFy0Xz/LXSqto+bVnmSngmL1GwoYgU0fXD6a7M2xY5APVfCm
         IwQ7QgOEyaj/9sHcw5VHWnz+C/eSnDZTCAFI8W6kFe0TT6h4SdgK27cHM69z6r+Yh2
         ox4uTOHY9N6yw==
Date:   Thu, 21 Jul 2022 10:30:55 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     kishon@ti.com, bhelgaas@google.com, robh@kernel.org,
        lorenzo.pieralisi@arm.com, kw@linux.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Om Prakash Singh <omp@nvidia.com>,
        Vidya Sagar <vidyas@nvidia.com>
Subject: Re: [PATCH] PCI: designware-ep: Move DBI access to init_complete if
 notifier is used
Message-ID: <20220721153055.GA1720178@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220721083845.GA36189@thinkpad>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jul 21, 2022 at 02:08:45PM +0530, Manivannan Sadhasivam wrote:
> On Tue, Jul 19, 2022 at 05:38:14PM -0500, Bjorn Helgaas wrote:
> > On Tue, Jul 19, 2022 at 09:13:58AM +0530, Manivannan Sadhasivam wrote:
> > > On Fri, Jul 15, 2022 at 04:39:58PM -0500, Bjorn Helgaas wrote:
> > > > On Wed, Mar 30, 2022 at 11:35:15AM +0530, Manivannan Sadhasivam wrote:
> > > > > For controllers supporting the CORE_INIT notifier, the resources are
> > > > > supposed to be enabled in the init_complete function. Currently,
> > > > > these controllers are enabling the resources during probe time due to
> > > > > the DBI access happens in dw_pcie_ep_init().
> > > > > 
> > > > > This creates the dependency with the host PCIe controller since the
> > > > > resource enablement like PHY depends on host PCIe to be up. For the
> > > > > standalone endpoint usecase, this would never work. So let's move all DBI
> > > > > access to init_complete function if CORE_INIT notifier is used. For the
> > > > > controllers those doesn't support this notifier, this change is a NO-OP.
> > > > > 
> > > > > Cc: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> > > > > Cc: Om Prakash Singh <omp@nvidia.com>
> > > > > Cc: Vidya Sagar <vidyas@nvidia.com>
> > > > > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > > > > ---
> > > > >  .../pci/controller/dwc/pcie-designware-ep.c   | 138 ++++++++++++------
> > > > >  drivers/pci/controller/dwc/pcie-designware.h  |   1 +
> > > > >  2 files changed, 94 insertions(+), 45 deletions(-)
> > > > 
> > > > Sorry this got missed.  Seems like there are two patches to solve the
> > > > same problem:
> > > > 
> > > >   1) This patch, and
> > > >   2) Vidya's patch (https://lore.kernel.org/linux-pci/20220622040133.31058-1-vidyas@nvidia.com/)
> > > > 
> > > > I don't know much about dwc or this issue, but if these patches are
> > > > functionally equivalent, I think Vidya's is a little more attractive
> > > > because:
> > > > 
> > > >   - It's smaller (49 insertions(+), 39 deletions(-)).
> > > > 
> > > >   - "core_init_notifier" looks like sort of a corner-case feature and
> > > >     Vidya's patch doesn't depend on it so it seems more maintainable.
> > > > 
> > > >   - It's more straightforward to read -- it basically just moves
> > > >     things from dw_pcie_ep_init() to dw_pcie_ep_init_complete(), which
> > > >     is exactly the sort of thing I expect if we're doing something out
> > > >     of order.
> > > 
> > > I agree that Vidya's patch is simple but as per the feedback from
> > > Kishon on my previous patch, I had to add some extra logic to make
> > > sure the move of DBI access doesn't affect the non
> > > core_init_notifier platforms.
> > > 
> > > So with my patch, the logic added is essentailly a NO-OP on those.
> > 
> > Can you include the lore URL for Kishon's feedback?  I can't find it.
> 
> https://patchwork.kernel.org/project/linux-pci/patch/1630473361-27198-3-git-send-email-hayashi.kunihiko@socionext.com/#24633629

Thanks!  (Or the canonical permanent URL:
https://lore.kernel.org/r/576457dd-3e66-a3b9-f51c-ea94bc267fdb@ti.com)

> > If we think moving the DBI access is safe on non-core_init_notifier
> > platforms, I'd like to do it everywhere so they're all the same.  I
> > don't want different behavior just to avoid the risk of theoretical
> > problems that we think should not happen.
> 
> One more issue Kishon pointed out was that, in the patch the
> endpoint controller is configured after pci_epc_create(). So he
> raised a concern that if ecp_ops is invoked before the controller
> gets configured fully, it could result in aborts.
> 
> While the concern may be true for non-core_init_notifier platforms
> (I'm not sure though) but I'm certain not for the core_init_notifier
> ones as the EFP drivers only access EPC ops after
> dw_pcie_ep_init_complete().

I really don't understand what "core_init_notifier" does, but it seems
incidental to this issue.  Is there really a connection?  It sounds
like the only reason to check for it is to limit the scope of the
change, not because DBI access is inherently related to
core_init_notifier.

Maybe Vidya's patch needs some enhancement to cover other paths where
DBI may be accessed before we're ready?

Bjorn
