Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63AAE5A19F8
	for <lists+linux-pci@lfdr.de>; Thu, 25 Aug 2022 22:03:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232338AbiHYUDP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 25 Aug 2022 16:03:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbiHYUDO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 25 Aug 2022 16:03:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8692F19C3F
        for <linux-pci@vger.kernel.org>; Thu, 25 Aug 2022 13:03:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 25E7B6125C
        for <linux-pci@vger.kernel.org>; Thu, 25 Aug 2022 20:03:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A40EC433C1;
        Thu, 25 Aug 2022 20:03:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661457792;
        bh=/9TkzmLfQn5M4n7XTfIrTb8KtnGk+NpgN8KOueh3Pmc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=FjiIGHFPr0K0C9NVpecYZNRM8Lm+WQ6OkQ91WYvlL20FKNczqlHVhUm0XpP5gEVTM
         c18p7b0zC3xP6U+F70tKNpYPKx5gc1LDUjof7pvPhl8tON6AMoKURoOMnfYSg0rmEJ
         xeEJcd0ZLK4bnxLo7EcOx8lLGM+9nvAS/1i315YakjsoppxiM7O7qkwD6euyY1bftZ
         hvVy2OubI+nQnm9Ieao3D3T+wgCz4T/LM+EofXuw7VmqoivkBJw2bWnJf/HiepfYIq
         0E++cDJUibw/NKWUI6av+8OTwBrVoeZWr0XUnPzmPS8hOIXwik0jBfwMtUh8WTNNxq
         vX1Oy+Bs7gQgg==
Date:   Thu, 25 Aug 2022 15:03:10 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Russell Currey <ruscur@russell.cc>, oohall@gmail.com,
        linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: Remove myself as EEH maintainer
Message-ID: <20220825200310.GA2869783@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8735drn4yi.fsf@mpe.ellerman.id.au>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Aug 20, 2022 at 10:17:41AM +1000, Michael Ellerman wrote:
> Bjorn Helgaas <helgaas@kernel.org> writes:
> > On Sat, Aug 06, 2022 at 06:53:01PM +1000, Russell Currey wrote:
> >> I haven't touched EEH in a long time I don't have much knowledge of the
> >> subsystem at this point either, so it's misleading to have me as a
> >> maintainer.
> >> 
> >> I remain grateful to Oliver for picking up my slack over the years.
> >> 
> >> Signed-off-by: Russell Currey <ruscur@russell.cc>
> >> ---
> >>  MAINTAINERS | 1 -
> >>  1 file changed, 1 deletion(-)
> >> 
> >> diff --git a/MAINTAINERS b/MAINTAINERS
> >> index a9f77648c107..dfe6081fa0b3 100644
> >> --- a/MAINTAINERS
> >> +++ b/MAINTAINERS
> >> @@ -15639,7 +15639,6 @@ F:	drivers/pci/endpoint/
> >>  F:	tools/pci/
> >>  
> >>  PCI ENHANCED ERROR HANDLING (EEH) FOR POWERPC
> >> -M:	Russell Currey <ruscur@russell.cc>
> >>  M:	Oliver O'Halloran <oohall@gmail.com>
> >>  L:	linuxppc-dev@lists.ozlabs.org
> >>  S:	Supported
> >
> > I was thinking along these lines, but if you want to take this,
> > Michael, I'll drop it:
> 
> Hi Bjorn,
> 
> I was hoping one of the protagonists would send a patch :), but that
> looks perfect.

Waiting for that patch would have been the *smart* thing to do, but I
added your ack and put it on for-linus for v6.0.  Thanks!

> Acked-by: Michael Ellerman <mpe@ellerman.id.au>
> 
> cheers
> 
> > commit 92ea781689d1 ("MAINTAINERS: Add Mahesh J Salgaonkar as EEH maintainer")
> > Author: Russell Currey <ruscur@russell.cc>
> > Date:   Sat Aug 6 18:53:01 2022 +1000
> >
> >     MAINTAINERS: Add Mahesh J Salgaonkar as EEH maintainer
> >     
> >     Update EEH entry:
> >     
> >       - Russell: lacks time to maintain EEH.
> >     
> >       - Oliver: lacks time & hardware to do actual maintenance, but happy to
> >         field questions and review things.
> >     
> >       - Mahesh: glad to take over EEH maintenance.
> >     
> >     [bhelgaas: commit log, add Mahesh, make Oliver reviewer]
> >     Link: https://lore.kernel.org/r/20220806085301.25142-1-ruscur@russell.cc
> >     Signed-off-by: Russell Currey <ruscur@russell.cc>
> >     Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index f60dfac7661c..51def5ac9462 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -15696,8 +15696,8 @@ F:	drivers/pci/endpoint/
> >  F:	tools/pci/
> >  
> >  PCI ENHANCED ERROR HANDLING (EEH) FOR POWERPC
> > -M:	Russell Currey <ruscur@russell.cc>
> > -M:	Oliver O'Halloran <oohall@gmail.com>
> > +M:	Mahesh J Salgaonkar <mahesh@linux.ibm.com>
> > +R:	Oliver O'Halloran <oohall@gmail.com>
> >  L:	linuxppc-dev@lists.ozlabs.org
> >  S:	Supported
> >  F:	Documentation/PCI/pci-error-recovery.rst
