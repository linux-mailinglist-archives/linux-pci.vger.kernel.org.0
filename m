Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8581035564B
	for <lists+linux-pci@lfdr.de>; Tue,  6 Apr 2021 16:16:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344996AbhDFOQl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 6 Apr 2021 10:16:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:44020 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1344977AbhDFOQl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 6 Apr 2021 10:16:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617718593;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TXQG7GfvF1Ng7FzSKt4ktIki+yjQeoa1qkYOKApty+c=;
        b=JwiraQIcesN3lKZKzFLi/IqWLBYbZlQrwLEVLmxmd59SBb6HmOzi5EJ6diktEvz37uK//B
        F6BFW5/bm0IOAbmIVE4WkZSAdGvjrg/fGjFkiqkuOkKQZXXJo4UhRnlTCMGdLfPgEbfYZQ
        HsQKz29z6jKHdHlP3lIcY/aWd7DWRUw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-199-VprOzs9nMXKakP89jFEt9w-1; Tue, 06 Apr 2021 10:16:29 -0400
X-MC-Unique: VprOzs9nMXKakP89jFEt9w-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 01CEE108BD0F;
        Tue,  6 Apr 2021 14:16:28 +0000 (UTC)
Received: from x1.home.shazbot.org (ovpn-112-85.phx2.redhat.com [10.3.112.85])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 708FB19D61;
        Tue,  6 Apr 2021 14:16:27 +0000 (UTC)
Date:   Tue, 6 Apr 2021 08:16:26 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Raphael Norwitz <raphael.norwitz@nutanix.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ameynarkhede03@gmail.com" <ameynarkhede03@gmail.com>
Subject: Re: [PATCH] PCI: merge slot and bus reset implementations
Message-ID: <20210406081626.31f19c0f@x1.home.shazbot.org>
In-Reply-To: <YGlzEA5HL6ZvNsB8@unreal>
References: <20210401053656.16065-1-raphael.norwitz@nutanix.com>
        <YGW8Oe9jn+n9sVsw@unreal>
        <20210401105616.71156d08@omen>
        <YGlzEA5HL6ZvNsB8@unreal>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, 4 Apr 2021 11:04:32 +0300
Leon Romanovsky <leon@kernel.org> wrote:

> On Thu, Apr 01, 2021 at 10:56:16AM -0600, Alex Williamson wrote:
> > On Thu, 1 Apr 2021 15:27:37 +0300
> > Leon Romanovsky <leon@kernel.org> wrote:
> >   
> > > On Thu, Apr 01, 2021 at 05:37:16AM +0000, Raphael Norwitz wrote:  
> > > > Slot resets are bus resets with additional logic to prevent a device
> > > > from being removed during the reset. Currently slot and bus resets have
> > > > separate implementations in pci.c, complicating higher level logic. As
> > > > discussed on the mailing list, they should be combined into a generic
> > > > function which performs an SBR. This change adds a function,
> > > > pci_reset_bus_function(), which first attempts a slot reset and then
> > > > attempts a bus reset if -ENOTTY is returned, such that there is now a
> > > > single device agnostic function to perform an SBR.
> > > > 
> > > > This new function is also needed to add SBR reset quirks and therefore
> > > > is exposed in pci.h.
> > > > 
> > > > Link: https://lkml.org/lkml/2021/3/23/911
> > > > 
> > > > Suggested-by: Alex Williamson <alex.williamson@redhat.com>
> > > > Signed-off-by: Amey Narkhede <ameynarkhede03@gmail.com>
> > > > Signed-off-by: Raphael Norwitz <raphael.norwitz@nutanix.com>
> > > > ---
> > > >  drivers/pci/pci.c   | 17 +++++++++--------
> > > >  include/linux/pci.h |  1 +
> > > >  2 files changed, 10 insertions(+), 8 deletions(-)
> > > > 
> > > > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > > > index 16a17215f633..12a91af2ade4 100644
> > > > --- a/drivers/pci/pci.c
> > > > +++ b/drivers/pci/pci.c
> > > > @@ -4982,6 +4982,13 @@ static int pci_dev_reset_slot_function(struct pci_dev *dev, int probe)
> > > >  	return pci_reset_hotplug_slot(dev->slot->hotplug, probe);
> > > >  }
> > > >  
> > > > +int pci_reset_bus_function(struct pci_dev *dev, int probe)
> > > > +{
> > > > +	int rc = pci_dev_reset_slot_function(dev, probe);
> > > > +
> > > > +	return (rc == -ENOTTY) ? pci_parent_bus_reset(dev, probe) : rc;    
> > > 
> > > The previous coding style is preferable one in the Linux kernel.
> > > int rc = pci_dev_reset_slot_function(dev, probe);
> > > if (rc != -ENOTTY)
> > >   return rc;
> > > return pci_parent_bus_reset(dev, probe);  
> > 
> > 
> > That'd be news to me, do you have a reference?  I've never seen
> > complaints for ternaries previously.  Thanks,  
> 
> The complaint is not to ternaries, but to the function call as one of
> the parameters, that makes it harder to read.

Sorry, I don't find a function call as a parameter to a ternary to be
extraordinary, nor do I find it to be a discouraged usage model within
the kernel.  This seems like a pretty low bar for hard to read code.

