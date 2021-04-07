Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEDB63566BB
	for <lists+linux-pci@lfdr.de>; Wed,  7 Apr 2021 10:24:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233086AbhDGIZG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 7 Apr 2021 04:25:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232650AbhDGIZG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 7 Apr 2021 04:25:06 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF387C06174A;
        Wed,  7 Apr 2021 01:24:55 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id x26so5631645pfn.0;
        Wed, 07 Apr 2021 01:24:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=QXNUwUsXQtc3oLOfnVTDYNZGH2B/RvCuyd2vJRt7U6k=;
        b=QuDve7Xbw9Zg/JwbmFdZQy8I5yAO7AI2zejTNejmEaF9vgs86CwffH3BkOqn9b1jiv
         5/BFVlXFDm34bCJVALLX7B1s2HckMWatSHCgk/YPFFJ73JBq733PN1d/vHG65LJcg2V/
         W/Em9Uc59vSyk9Tet7AjE7TGV2uuOkUzqpaFmFH6DcsEtkXNzHqqTFjdWu4KDapNdAF8
         kkQLsi2Cl0l4wxqetS1d/4JHZd6NLLH74+DtlDnz3E13Q5atiiIBfqfnl9yzKWVSI1II
         fHAyzipdokIWZ9532Ixdmvrx7lxPU9tLDSZpJgYRz7chMQu4BeM6NFurFWl8xYsj/Ozu
         gfeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QXNUwUsXQtc3oLOfnVTDYNZGH2B/RvCuyd2vJRt7U6k=;
        b=UO9byuNHF9CjQ+VCrY0W9MI1ZkpiJP+NFRMOwSGqeN699KL2OQts1I27x+qjFKtrbl
         /HGzDoHRX0cFnnCnZOzHBy60659O/t+CLo8+N4dYxDbW3HwdVzXWWm2UBhnKgiVt7uWz
         ++9jqQAGdap6N5vAusKL7Jkz+VzKuicCZCLayAOEpa8X2Cb/tZvqAFu78bCWCNfz5zG+
         1CovQbZFhepN9uQJ5kn5k1wIUJysP2O4FtjAuvSi+QNVFms080EFTByMh0zUBrKvNky9
         NmKGgZ9aeqQb7OT0modHkPNNNOUMTKmx1DgHDV3ZDfF+8BhhAeXfUA9vjw7LkgU/3FUE
         0O3Q==
X-Gm-Message-State: AOAM531zKsY+6/i3ItRMbghrHc3tSjPeEqE8DmE+Zc+sqzSgeYrE0IKA
        m60odkQvZVZcbfCWLPt9nOk=
X-Google-Smtp-Source: ABdhPJwvJTLxlEvt6oOwNtq0clEbGMOdqzD5Pr7pxUO3cWc2eu+2kkyCfTQLdB19NaZBSsx1cyBBnA==
X-Received: by 2002:aa7:91d1:0:b029:1fe:2a02:73b9 with SMTP id z17-20020aa791d10000b02901fe2a0273b9mr1846572pfa.2.1617783895551;
        Wed, 07 Apr 2021 01:24:55 -0700 (PDT)
Received: from localhost ([103.77.152.190])
        by smtp.gmail.com with ESMTPSA id i14sm20013180pgl.79.2021.04.07.01.24.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Apr 2021 01:24:55 -0700 (PDT)
Date:   Wed, 7 Apr 2021 13:53:56 +0530
From:   "ameynarkhede03@gmail.com" <ameynarkhede03@gmail.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Raphael Norwitz <raphael.norwitz@nutanix.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        "bhelgaas@google.com <bhelgaas@google.com>,linux-pci@vger.kernel.org" 
        <linux-pci@vger.kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: merge slot and bus reset implementations
Message-ID: <20210407082356.53subv4np2fx777x@archlinux>
References: <20210401053656.16065-1-raphael.norwitz@nutanix.com>
 <YGW8Oe9jn+n9sVsw@unreal>
 <20210401105616.71156d08@omen>
 <YGlzEA5HL6ZvNsB8@unreal>
 <20210406081626.31f19c0f@x1.home.shazbot.org>
 <YG1eBUY0vCTV+Za/@unreal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YG1eBUY0vCTV+Za/@unreal>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 21/04/07 10:23AM, Leon Romanovsky wrote:
> On Tue, Apr 06, 2021 at 08:16:26AM -0600, Alex Williamson wrote:
> > On Sun, 4 Apr 2021 11:04:32 +0300
> > Leon Romanovsky <leon@kernel.org> wrote:
> >
> > > On Thu, Apr 01, 2021 at 10:56:16AM -0600, Alex Williamson wrote:
> > > > On Thu, 1 Apr 2021 15:27:37 +0300
> > > > Leon Romanovsky <leon@kernel.org> wrote:
> > > >
> > > > > On Thu, Apr 01, 2021 at 05:37:16AM +0000, Raphael Norwitz wrote:
> > > > > > Slot resets are bus resets with additional logic to prevent a device
> > > > > > from being removed during the reset. Currently slot and bus resets have
> > > > > > separate implementations in pci.c, complicating higher level logic. As
> > > > > > discussed on the mailing list, they should be combined into a generic
> > > > > > function which performs an SBR. This change adds a function,
> > > > > > pci_reset_bus_function(), which first attempts a slot reset and then
> > > > > > attempts a bus reset if -ENOTTY is returned, such that there is now a
> > > > > > single device agnostic function to perform an SBR.
> > > > > >
> > > > > > This new function is also needed to add SBR reset quirks and therefore
> > > > > > is exposed in pci.h.
> > > > > >
> > > > > > Link: https://lkml.org/lkml/2021/3/23/911
> > > > > >
> > > > > > Suggested-by: Alex Williamson <alex.williamson@redhat.com>
> > > > > > Signed-off-by: Amey Narkhede <ameynarkhede03@gmail.com>
> > > > > > Signed-off-by: Raphael Norwitz <raphael.norwitz@nutanix.com>
> > > > > > ---
> > > > > >  drivers/pci/pci.c   | 17 +++++++++--------
> > > > > >  include/linux/pci.h |  1 +
> > > > > >  2 files changed, 10 insertions(+), 8 deletions(-)
> > > > > >
> > > > > > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > > > > > index 16a17215f633..12a91af2ade4 100644
> > > > > > --- a/drivers/pci/pci.c
> > > > > > +++ b/drivers/pci/pci.c
> > > > > > @@ -4982,6 +4982,13 @@ static int pci_dev_reset_slot_function(struct pci_dev *dev, int probe)
> > > > > >  	return pci_reset_hotplug_slot(dev->slot->hotplug, probe);
> > > > > >  }
> > > > > >
> > > > > > +int pci_reset_bus_function(struct pci_dev *dev, int probe)
> > > > > > +{
> > > > > > +	int rc = pci_dev_reset_slot_function(dev, probe);
> > > > > > +
> > > > > > +	return (rc == -ENOTTY) ? pci_parent_bus_reset(dev, probe) : rc;
> > > > >
> > > > > The previous coding style is preferable one in the Linux kernel.
> > > > > int rc = pci_dev_reset_slot_function(dev, probe);
> > > > > if (rc != -ENOTTY)
> > > > >   return rc;
> > > > > return pci_parent_bus_reset(dev, probe);
> > > >
> > > >
> > > > That'd be news to me, do you have a reference?  I've never seen
> > > > complaints for ternaries previously.  Thanks,
> > >
> > > The complaint is not to ternaries, but to the function call as one of
> > > the parameters, that makes it harder to read.
> >
> > Sorry, I don't find a function call as a parameter to a ternary to be
> > extraordinary, nor do I find it to be a discouraged usage model within
> > the kernel.  This seems like a pretty low bar for hard to read code.
>
> It is up to us where this bar is set.
>
> Thanks
On the side note there are plenty of places where this pattern is used
though
for example -
kernel/time/clockevents.c:328:
return force ? clockevents_program_min_delta(dev) : -ETIME;

kernel/trace/trace_kprobe.c:233:
return tk ? within_error_injection_list(trace_kprobe_address(tk)) :
       false;

kernel/signal.c:3104:
return oset ? put_compat_sigset(oset, &old_set, sizeof(*oset)) : 0;
etc

Thanks,
Amey
