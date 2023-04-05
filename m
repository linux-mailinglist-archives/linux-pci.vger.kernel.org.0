Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A817C6D7DA7
	for <lists+linux-pci@lfdr.de>; Wed,  5 Apr 2023 15:24:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237960AbjDENYv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 5 Apr 2023 09:24:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232985AbjDENYt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 5 Apr 2023 09:24:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D33930F3;
        Wed,  5 Apr 2023 06:24:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 14DDE62695;
        Wed,  5 Apr 2023 13:24:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DCB9C433D2;
        Wed,  5 Apr 2023 13:24:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680701082;
        bh=jtcd9ZB5krLgqcL77oY/CMSaEmk3F5UFxlt0SGZNQ/E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PFHzBCADFWK+r8zmoArr2Aj2K//wurCSJolMrSuE37mvMYT/FVAMIaeOLMx8Q522g
         S3/sMuoDi9OCM3KXx8JC+GXl5zi4bZ3vic2xTTCt1nSY0iER9srMJWtcFR8wWWXwfv
         TRvK2+2+UMM+ygKtQk6cQaXg1IIBUh612nf6gExyEBqGgg91+pBMyYKLn9MIyX1GzM
         aGUSnLXtS+mEtQTH4AoMPWBys6kerEpXpmpG7NaA+D/6fJIVQpqotZxh8ngpc46iTf
         YwFtCibuzP8gXG9hPpQsEJjBKwQkVXXrfbGyE+3Tfid+QEiXZCm+xL7qKTTCW+KfMa
         oqencRrsNtbIQ==
Date:   Wed, 5 Apr 2023 15:24:36 +0200
From:   Lorenzo Pieralisi <lpieralisi@kernel.org>
To:     Sajid Dalvi <sdalvi@google.com>
Cc:     Han Jingoo <jingoohan1@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>, kernel-team@android.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v2] PCI: dwc: Wait for link up only if link is started
Message-ID: <ZC12lN9Cs0QlPhVh@lpieralisi>
References: <20230227201340.2087605-1-sdalvi@google.com>
 <CAPOBaE4U4rCJ+4CcSoj597LsP-0ESBhiKKHz00bk+SvNHrOzKQ@mail.gmail.com>
 <CAEbtx1mhMqZjJeU0L99xpwY9W5caJmpv69aRZG+b-hLfstK-Ww@mail.gmail.com>
 <CAEbtx1kNMY5xH435=Rw0QoDebyRL=RYi+dfkqs4WRG7DS5f3dA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEbtx1kNMY5xH435=Rw0QoDebyRL=RYi+dfkqs4WRG7DS5f3dA@mail.gmail.com>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Mar 16, 2023 at 06:05:02PM -0500, Sajid Dalvi wrote:
> On Tue, Feb 28, 2023 at 10:36 PM Sajid Dalvi <sdalvi@google.com> wrote:
> >
> > Thanks for your review Jingoo.
> > Sajid
> >
> > On Tue, Feb 28, 2023 at 4:04 PM Han Jingoo <jingoohan1@gmail.com> wrote:
> > >
> > > On Mon, Feb 27, 2023, Sajid Dalvi <sdalvi@google.com> wrote:
> > > >
> > > > In dw_pcie_host_init() regardless of whether the link has been started
> > > > or not, the code waits for the link to come up. Even in cases where
> > > > start_link() is not defined the code ends up spinning in a loop for 1
> > > > second. Since in some systems dw_pcie_host_init() gets called during
> > > > probe, this one second loop for each pcie interface instance ends up
> > > > extending the boot time.
> > > >
> > > > Call trace when start_link() is not defined:
> > > > dw_pcie_wait_for_link << spins in a loop for 1 second
> > > > dw_pcie_host_init
> > > >
> > > > Signed-off-by: Sajid Dalvi <sdalvi@google.com>
> > >
> > > (CC'ed Krzysztof Kozlowski)
> > >
> > > Acked-by: Jingoo Han <jingoohan1@gmail.com>
> > >
> > > It looks good to me. I also checked the previous thread.
> > > I agree with Krzysztof's opinion that we should include
> > > only hardware-related features into DT.
> > > Thank you.
> > >
> > > Best regards,
> > > Jingoo Han
> > >
> > > > ---
> > > >  drivers/pci/controller/dwc/pcie-designware-host.c | 6 +++---
> > > >  1 file changed, 3 insertions(+), 3 deletions(-)
> > > >
> > > > diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> > > > index 9952057c8819..9709f69f173e 100644
> > > > --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> > > > +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> > > > @@ -489,10 +489,10 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
> > > >                 ret = dw_pcie_start_link(pci);
> > > >                 if (ret)
> > > >                         goto err_remove_edma;
> > > > -       }
> > > >
> > > > -       /* Ignore errors, the link may come up later */
> > > > -       dw_pcie_wait_for_link(pci);
> > > > +               /* Ignore errors, the link may come up later */
> > > > +               dw_pcie_wait_for_link(pci);
> > > > +       }
> > > >
> > > >         bridge->sysdata = pp;
> > > >
> > > > --
> > > > 2.39.2.722.g9855ee24e9-goog
> > > >
> 
> @bhelgaas Can this be picked up in your tree:
>  https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git/

This patch seems fine to me. The question I have though is why the
*current* code is written the way it is. Perhaps it is just the way
it is, I wonder whether this change can trigger a regression though.

I guess the only way to know is merging this path and check the
fallout.

Lorenzo
