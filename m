Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 802DD473599
	for <lists+linux-pci@lfdr.de>; Mon, 13 Dec 2021 21:07:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242785AbhLMUHn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Dec 2021 15:07:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240824AbhLMUHn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 13 Dec 2021 15:07:43 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF582C061574;
        Mon, 13 Dec 2021 12:07:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1B2FF611E1;
        Mon, 13 Dec 2021 20:07:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33D98C34600;
        Mon, 13 Dec 2021 20:07:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639426061;
        bh=TlkT++GPiQDQi1bo65d/WeVwXL8dX35GBswu/sLieu4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=MeqMXfaaLYgS43G6iWIscvRtALp6yTNjwcQPSD3DZw8h3gsEnqXz/T3I503P2ggnb
         jTKMWELnxAByDsEVmPjytkfcPYAFzaSAibb+H/sHd1GmXxzJ7gSEDm0F8eSm/MGMyb
         AOF8tLaN52FZqBo3r3ZhTMr3oXa9sKrky2jAVOpkalXQCLAIJx1Kfz0Eql8SDigf2/
         3k7xctv/DT8S8+ph4pL+Viq2tJGq8HANXpeknU9cKitv5FA38xddamZf/lKMz+I9uL
         1JjSmjVD2HIzgoNs/T3JzdvadAnjwQnwVLkFQK2OTGm7X+BwhLgo7poYqXON8hyT/j
         UpeoPB3KU46Xg==
Date:   Mon, 13 Dec 2021 14:07:39 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Rajat Jain <rajatja@google.com>
Cc:     Jiasheng Jiang <jiasheng@iscas.ac.cn>, ruscur@russell.cc,
        oohall@gmail.com, bhelgaas@google.com,
        linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI/AER: potential dereference of null pointer
Message-ID: <20211213200739.GA542591@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACK8Z6EntHP0TWfq=JdQ7QS8vCgXoRUJOWqbGYLvD6R2Mq0paw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Dec 13, 2021 at 11:57:52AM -0800, Rajat Jain wrote:
> Hello
> 
> On Sat, Dec 11, 2021 at 9:54 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
> >
> > [+cc Rajat, author of aer_stats:
> > db89ccbe52c7 ("PCI/AER: Define aer_stats structure for AER capable devices"
> > 81aa5206f9a7 ("PCI/AER: Add sysfs attributes to provide AER stats and breakdown"]
> >
> > On Thu, Dec 09, 2021 at 05:45:56PM +0800, Jiasheng Jiang wrote:
> > > he return value of kzalloc() needs to be checked.
> > > To avoid use of null pointer in case of the failure of alloc.
> > >
> > > Fixes: db89ccbe52c7 ("PCI/AER: Define aer_stats structure for AER capable devices")
> > > Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
> > > ---
> > >  drivers/pci/pcie/aer.c | 2 ++
> > >  1 file changed, 2 insertions(+)
> > >
> > > diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> > > index ec943cee5ecc..d04303edf468 100644
> > > --- a/drivers/pci/pcie/aer.c
> > > +++ b/drivers/pci/pcie/aer.c
> > > @@ -376,6 +376,8 @@ void pci_aer_init(struct pci_dev *dev)
> > >               return;
> > >
> > >       dev->aer_stats = kzalloc(sizeof(struct aer_stats), GFP_KERNEL);
> > > +     if (!dev->aer_stats)
> > > +             return;
> >
> > Did you actually trip over a null pointer dereference, and if so,
> > where was it?
> >
> > I think the intent here was that aer_stats is a non-essential feature,
> > and if we can't allocate space to keep the statistics, we can still
> > use the device without the stats.
> 
> Ack. Yes, this was my intention.
> 
> Practically speaking though, if a system cannot allocate space for
> aer_stats (608 bytes), I would think it is under an extreme memory
> pressure so not really sure if will be able to really do anything with
> the PCI device (probe the driver which may want to allocate more
> memory etc). But that isn't anything that we can help with.
> 
> The current patch AFAICS looks like a no-op to me.

Well, it's a no-op except for the fact that we should continue on to
add a save buffer and clear the AER status, so if we applied this
patch, I think an alloc failure (unlikely though it is) would mean we
would continue using the device, but the AER init for it wouldn't be
done correctly.

I think we need to drop this patch, and if there is a null pointer
dereference elsewhere, fix that.

> > I *think* all the users of dev->aer_stats check for NULL before
> > dereferencing it, but if you found a case that doesn't do that, we
> > should definitely fix it.
> >
> > In a few cases (aer_stats_dev_attr, aer_stats_rootport_attr), the
> > check isn't obvious -- it happens in aer_stats_attrs_are_visible().
> > If aer_stats_attrs_are_visible() finds that aer_stats is NULL, those
> > sysfs attributes should not be visible, and the corresponding *_show()
> > functions should never be called.
> >
> > >       /*
> > >        * We save/restore PCI_ERR_UNCOR_MASK, PCI_ERR_UNCOR_SEVER,
> > > --
> > > 2.25.1
> > >
