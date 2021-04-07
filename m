Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7DE6356525
	for <lists+linux-pci@lfdr.de>; Wed,  7 Apr 2021 09:23:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232032AbhDGHYH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 7 Apr 2021 03:24:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:60056 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1346594AbhDGHYF (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 7 Apr 2021 03:24:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 16F0B61369;
        Wed,  7 Apr 2021 07:23:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617780233;
        bh=zr0/pQRi0wQf+wUkOOWdNkfJEyHnsU7Lgu1Fb25P4g4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eprpbL5zs1HVNKL4QAMx1V8pCWNK2yOixiXFcTgWWczy1uRJDSPeKZSIDvp4kGp+o
         MaTcv9Ohvmr/Lpa1veYoWs1MKfe3/t0ZlbM7J6z3EZjjGgrui/mlTCRyAd6iRxKYFN
         TKQt53dkTSvLePbRf5jWvLHzAdzu6JdRI+D2WcjYU1SGwemitMXUW4I8eHz3/121o8
         yYvLvC/GuAuEZGL45JyE6ZeuLQv+2UOMypPUTYxa1SQcRsJ6d1IFe/EyeQgA3jNVX+
         tDdNfyW7sryc80lQSw1t4ESgbG+tPZG9T417r1ZgPQFugKoT3/zeU0mgCw9cJSGeax
         JTEIUNI6+Tlzg==
Date:   Wed, 7 Apr 2021 10:23:49 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Alex Williamson <alex.williamson@redhat.com>
Cc:     Raphael Norwitz <raphael.norwitz@nutanix.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ameynarkhede03@gmail.com" <ameynarkhede03@gmail.com>
Subject: Re: [PATCH] PCI: merge slot and bus reset implementations
Message-ID: <YG1eBUY0vCTV+Za/@unreal>
References: <20210401053656.16065-1-raphael.norwitz@nutanix.com>
 <YGW8Oe9jn+n9sVsw@unreal>
 <20210401105616.71156d08@omen>
 <YGlzEA5HL6ZvNsB8@unreal>
 <20210406081626.31f19c0f@x1.home.shazbot.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210406081626.31f19c0f@x1.home.shazbot.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Apr 06, 2021 at 08:16:26AM -0600, Alex Williamson wrote:
> On Sun, 4 Apr 2021 11:04:32 +0300
> Leon Romanovsky <leon@kernel.org> wrote:
> 
> > On Thu, Apr 01, 2021 at 10:56:16AM -0600, Alex Williamson wrote:
> > > On Thu, 1 Apr 2021 15:27:37 +0300
> > > Leon Romanovsky <leon@kernel.org> wrote:
> > >   
> > > > On Thu, Apr 01, 2021 at 05:37:16AM +0000, Raphael Norwitz wrote:  
> > > > > Slot resets are bus resets with additional logic to prevent a device
> > > > > from being removed during the reset. Currently slot and bus resets have
> > > > > separate implementations in pci.c, complicating higher level logic. As
> > > > > discussed on the mailing list, they should be combined into a generic
> > > > > function which performs an SBR. This change adds a function,
> > > > > pci_reset_bus_function(), which first attempts a slot reset and then
> > > > > attempts a bus reset if -ENOTTY is returned, such that there is now a
> > > > > single device agnostic function to perform an SBR.
> > > > > 
> > > > > This new function is also needed to add SBR reset quirks and therefore
> > > > > is exposed in pci.h.
> > > > > 
> > > > > Link: https://lkml.org/lkml/2021/3/23/911
> > > > > 
> > > > > Suggested-by: Alex Williamson <alex.williamson@redhat.com>
> > > > > Signed-off-by: Amey Narkhede <ameynarkhede03@gmail.com>
> > > > > Signed-off-by: Raphael Norwitz <raphael.norwitz@nutanix.com>
> > > > > ---
> > > > >  drivers/pci/pci.c   | 17 +++++++++--------
> > > > >  include/linux/pci.h |  1 +
> > > > >  2 files changed, 10 insertions(+), 8 deletions(-)
> > > > > 
> > > > > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > > > > index 16a17215f633..12a91af2ade4 100644
> > > > > --- a/drivers/pci/pci.c
> > > > > +++ b/drivers/pci/pci.c
> > > > > @@ -4982,6 +4982,13 @@ static int pci_dev_reset_slot_function(struct pci_dev *dev, int probe)
> > > > >  	return pci_reset_hotplug_slot(dev->slot->hotplug, probe);
> > > > >  }
> > > > >  
> > > > > +int pci_reset_bus_function(struct pci_dev *dev, int probe)
> > > > > +{
> > > > > +	int rc = pci_dev_reset_slot_function(dev, probe);
> > > > > +
> > > > > +	return (rc == -ENOTTY) ? pci_parent_bus_reset(dev, probe) : rc;    
> > > > 
> > > > The previous coding style is preferable one in the Linux kernel.
> > > > int rc = pci_dev_reset_slot_function(dev, probe);
> > > > if (rc != -ENOTTY)
> > > >   return rc;
> > > > return pci_parent_bus_reset(dev, probe);  
> > > 
> > > 
> > > That'd be news to me, do you have a reference?  I've never seen
> > > complaints for ternaries previously.  Thanks,  
> > 
> > The complaint is not to ternaries, but to the function call as one of
> > the parameters, that makes it harder to read.
> 
> Sorry, I don't find a function call as a parameter to a ternary to be
> extraordinary, nor do I find it to be a discouraged usage model within
> the kernel.  This seems like a pretty low bar for hard to read code.

It is up to us where this bar is set.

Thanks
