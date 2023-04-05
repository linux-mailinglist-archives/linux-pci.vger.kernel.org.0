Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 994336D85F9
	for <lists+linux-pci@lfdr.de>; Wed,  5 Apr 2023 20:28:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233880AbjDES17 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 5 Apr 2023 14:27:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234154AbjDES16 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 5 Apr 2023 14:27:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A12361A2;
        Wed,  5 Apr 2023 11:27:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3569C64083;
        Wed,  5 Apr 2023 18:27:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60FDBC433D2;
        Wed,  5 Apr 2023 18:27:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680719275;
        bh=S45JL7p28MzbNIkK/R/Rxee7+W/06GYb1Miri9LtNes=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=pSYqHsSrKTYeLipOE4a9ZP6avOxOgVZqmcWjoiGzeqAOx/sI/cjao7rIPo/01zM/D
         lhu2OAZPIb8qrmmUx16Aj2cPQYjBJ2Gj2o2eFulUB64Ys346lQ62uhO6r0ytNsPEhp
         x8UTVuwkjdoA8GmgWn/3IFcJg9jOie3vlbUyCcVnjyr//fgh9TVFmwKw9B8E/Xd9zd
         GldJk1xpXv80Y/1Y1k0959vxdsqhru9u2kcgGCD5yCEqZV3+jZ+Me5DW6VtfawPzhg
         bVTkQLmHILjnQHygnRNqzF7Tlw/ZRsBjDoKnHnxaLIP5vEtAhuJxHVNGZeW+OeFBgO
         jcOxVYBzBSDoA==
Date:   Wed, 5 Apr 2023 13:27:53 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc:     Sajid Dalvi <sdalvi@google.com>, Han Jingoo <jingoohan1@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>, kernel-team@android.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v2] PCI: dwc: Wait for link up only if link is started
Message-ID: <20230405182753.GA3626483@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZC12lN9Cs0QlPhVh@lpieralisi>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Apr 05, 2023 at 03:24:36PM +0200, Lorenzo Pieralisi wrote:
> On Thu, Mar 16, 2023 at 06:05:02PM -0500, Sajid Dalvi wrote:
> > On Tue, Feb 28, 2023 at 10:36 PM Sajid Dalvi <sdalvi@google.com> wrote:
> > >
> > > Thanks for your review Jingoo.
> > > Sajid
> > >
> > > On Tue, Feb 28, 2023 at 4:04 PM Han Jingoo <jingoohan1@gmail.com> wrote:
> > > >
> > > > On Mon, Feb 27, 2023, Sajid Dalvi <sdalvi@google.com> wrote:
> > > > >
> > > > > In dw_pcie_host_init() regardless of whether the link has been started
> > > > > or not, the code waits for the link to come up. Even in cases where
> > > > > start_link() is not defined the code ends up spinning in a loop for 1
> > > > > second. Since in some systems dw_pcie_host_init() gets called during
> > > > > probe, this one second loop for each pcie interface instance ends up
> > > > > extending the boot time.
> > > > >
> > > > > Call trace when start_link() is not defined:
> > > > > dw_pcie_wait_for_link << spins in a loop for 1 second
> > > > > dw_pcie_host_init
> > > > >
> > > > > Signed-off-by: Sajid Dalvi <sdalvi@google.com>
> > > >
> > > > (CC'ed Krzysztof Kozlowski)
> > > >
> > > > Acked-by: Jingoo Han <jingoohan1@gmail.com>
> > > >
> > > > It looks good to me. I also checked the previous thread.
> > > > I agree with Krzysztof's opinion that we should include
> > > > only hardware-related features into DT.
> > > > Thank you.
> > > >
> > > > Best regards,
> > > > Jingoo Han
> > > >
> > > > > ---
> > > > >  drivers/pci/controller/dwc/pcie-designware-host.c | 6 +++---
> > > > >  1 file changed, 3 insertions(+), 3 deletions(-)
> > > > >
> > > > > diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> > > > > index 9952057c8819..9709f69f173e 100644
> > > > > --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> > > > > +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> > > > > @@ -489,10 +489,10 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
> > > > >                 ret = dw_pcie_start_link(pci);
> > > > >                 if (ret)
> > > > >                         goto err_remove_edma;
> > > > > -       }
> > > > >
> > > > > -       /* Ignore errors, the link may come up later */
> > > > > -       dw_pcie_wait_for_link(pci);
> > > > > +               /* Ignore errors, the link may come up later */
> > > > > +               dw_pcie_wait_for_link(pci);
> > > > > +       }
> > > > >
> > > > >         bridge->sysdata = pp;
> > > > >
> > > > > --
> > > > > 2.39.2.722.g9855ee24e9-goog
> > > > >
> > 
> > @bhelgaas Can this be picked up in your tree:
> >  https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git/
> 
> This patch seems fine to me. The question I have though is why the
> *current* code is written the way it is. Perhaps it is just the way
> it is, I wonder whether this change can trigger a regression though.

The new code will look basically like this:

  if (!dw_pcie_link_up(pci)) {
    dw_pcie_start_link(pci);
    dw_pcie_wait_for_link(pci);
  }

If the link is already up by the time we get here, this change means
we won't get this message emitted by dw_pcie_wait_for_link():

  dev_info(pci->dev, "PCIe Gen.%u x%u link up\n", ...)

I don't know how important that is, but I bet somebody cares about it.

From the commit log, I expected the patch to do something based on
whether ->start_link() was defined, but there really isn't a direct
connection, so maybe the log could be refined.

Bjorn
