Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8B313AF1FB
	for <lists+linux-pci@lfdr.de>; Mon, 21 Jun 2021 19:28:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230343AbhFURbM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Jun 2021 13:31:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230205AbhFURbM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 21 Jun 2021 13:31:12 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0044BC061574;
        Mon, 21 Jun 2021 10:28:57 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id g24so10384200pji.4;
        Mon, 21 Jun 2021 10:28:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=hsPgIATFhcH0s8/nQxedaZItqhlGccYFqrCe5SZycCI=;
        b=F5NXZMuVLc+XFmS/iuBcEEws46xtf4JvA6gskDZxdEW+vd0kRjJjE6bwDStG/3tXJT
         BrISEflsKXPYKwe2FAPKEodHaI+XPRJ5lZhS3vg/VsJfgrUQ6WLfR9lKYFzlRUQM5ZNB
         i0Vp5KV89OkSdgdIM3N2X9i3cuAua3pFBa0xmFM4sB5rAWF23MMBJeumgwIWcfbi2yA6
         6/lv+pLUf88IwjixM2zR7/APfCzm+N3UvL7N3OOf3Tq2cLzZuHncaw4az2/t2M4RVeeN
         GUfCCNVvcGq7PnDGmLOowE464MmOYojZcc7MHhocfFuTTZpk2uwM7LbAWysbXLQfbyav
         IOew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hsPgIATFhcH0s8/nQxedaZItqhlGccYFqrCe5SZycCI=;
        b=tdtHbL2VRrc3QskeCDBYj5bbb0k224fcvQxHOzcQscsAdPgeung/utv4iOQOXBSZX5
         WApdNZ0rCwc9bR8Out2IhozQFDdZHKGD14MDie2R81Wfu1FpnJNDglKDAuM5AUkOtmzv
         YYHI3SFhloMt9zqdWRGmr412kauZzk3mPV0XPCsERzHKB14SN4H90dx1iYmwvEXnaqRp
         +WdkHQGw0/3TYE1lwliIuJ4GA8Gi8krxWm7HfoFJEtDb6rYR1zT5CnfkTOXxGN70GGbT
         GKgaH2A9iMtfc7yGK8bpkG7dImD76dlLrGM21+T99Bdg2UXToKTZYfPrpJNuXD/3uB5H
         i5ew==
X-Gm-Message-State: AOAM532xKO19KAGi4qg02LovL1tZd9PviqYMyJzpAEinN8geYUpNEMDY
        iti/dTdFbh4ijj7jatNpFRY=
X-Google-Smtp-Source: ABdhPJy4wND+PP/yaAKMrJbSmBXkC2/3oOpFW3arlGwOrIAEEn0kw7egiHXLSs0Nyvekc9ulirITuQ==
X-Received: by 2002:a17:902:aa86:b029:116:3e3a:2051 with SMTP id d6-20020a170902aa86b02901163e3a2051mr18922772plr.38.1624296537450;
        Mon, 21 Jun 2021 10:28:57 -0700 (PDT)
Received: from localhost ([103.248.31.165])
        by smtp.gmail.com with ESMTPSA id v15sm15975003pfm.216.2021.06.21.10.28.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jun 2021 10:28:56 -0700 (PDT)
Date:   Mon, 21 Jun 2021 22:58:54 +0530
From:   Amey Narkhede <ameynarkhede03@gmail.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     alex.williamson@redhat.com,
        Raphael Norwitz <raphael.norwitz@nutanix.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kw@linux.com, Shanker Donthineni <sdonthineni@nvidia.com>,
        Sinan Kaya <okaya@kernel.org>, Len Brown <lenb@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v7 4/8] PCI/sysfs: Allow userspace to query and set
 device reset mechanism
Message-ID: <20210621172854.3ycsprg2wwx45xgm@archlinux>
References: <20210619135920.h42gp5ie5c2eutfq@archlinux>
 <20210621130135.GA3288360@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210621130135.GA3288360@bjorn-Precision-5520>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 21/06/21 08:01AM, Bjorn Helgaas wrote:
> On Sat, Jun 19, 2021 at 07:29:20PM +0530, Amey Narkhede wrote:
> > On 21/06/18 03:00PM, Bjorn Helgaas wrote:
> > > On Tue, Jun 08, 2021 at 11:18:53AM +0530, Amey Narkhede wrote:
> > > > Add reset_method sysfs attribute to enable user to
> > > > query and set user preferred device reset methods and
> > > > their ordering.
>
> > > > +	if (sysfs_streq(options, "default")) {
> > > > +		for (i = 0; i < PCI_RESET_METHODS_NUM; i++)
> > > > +			reset_methods[i] = reset_methods[i] ? prio-- : 0;
> > > > +		goto set_reset_methods;
> > > > +	}
> > >
> > > If you use pci_init_reset_methods() here, you can also get this case
> > > out of the way early.
> > >
> > The problem with alternate encoding is we won't be able to know if
> > one of the reset methods was disabled previously. For example,
> >
> > # cat reset_methods
> > flr,bus 			# dev->reset_methods = [3, 5, 0, ...]
> > # echo bus > reset_methods 	# dev->reset_methods = [5, 0, 0, ...]
> > # cat reset_methods
> > bus
> >
> > Now if an user wants to enable flr
> >
> > # echo flr > reset_methods 	# dev->reset_methods = [3, 0, 0, ...]
> > OR
> > # echo bus,flr > reset_methods 	# dev->reset_methods = [5, 3, 0, ...]
> >
> > either they need to write "default" first then flr or we will need to
> > reprobe reset methods each time when user writes to reset_method attribute.
>
> Not sure I completely understand the problem here.  I think relying on
> previous state that is invisible to the user is a little problematic
> because it's hard for the user to predict what will happen.
>
> If the user enables a method that was previously "disabled" because
> the probe failed, won't the reset method itself just fail with
> -ENOTTY?  Is that a problem?
>
I think I didn't explain this correctly. With current implementation
its not necessary to explicitly set *order of availabe* reset methods.
User can directly write a single supported reset method only and then perform
the reset. Side effect of that is other methods are disabled if user
writes single or less than available number of supported reset method.
Current implementation is able to handle this case but with new encoding
we'll need to reprobe reset methods everytime because we have no way
of distingushing supported and currently enabled reset method.

Alternate way of doing this is using 2 bitmaps as outlined here by
Shanker https://marc.info/?l=linux-kernel&m=162428773101702&w=2
> > > > +	while ((name = strsep(&options, ",")) != NULL) {
> > > > +		if (sysfs_streq(name, ""))
> > > > +			continue;
> > > > +
> > > > +		name = strim(name);
> > > > +
> > > > +		for (i = 0; i < PCI_RESET_METHODS_NUM; i++) {
> > > > +			if (reset_methods[i] &&
> > > > +			    sysfs_streq(name, pci_reset_fn_methods[i].name)) {
> > > > +				reset_methods[i] = prio--;
> > > > +				break;
> > > > +			}
> > > > +		}
> > > > +
> > > > +		if (i == PCI_RESET_METHODS_NUM) {
> > > > +			kfree(options);
> > > > +			return -EINVAL;
> > > > +		}
> > > > +	}
> > > > +
> > > > +	if (reset_methods[0] &&
> > > > +	    reset_methods[0] != PCI_RESET_METHODS_NUM)
> > > > +		pci_warn(pdev, "Device specific reset disabled/de-prioritized by user");
> > >
> > > Is there a specific reason for this warning?  Is it just telling the
> > > user that he might have shot himself in the foot?  Not sure that's
> > > necessary.
> > >
> > I think generally presence of device specific reset method means other
> > methods are potentially broken. Is it okay to skip this?
>
> We might want a warning at reset-time if all the methods failed,
> because that means we may leak state between users.  Maybe we also
> want one here, if *all* reset methods are disabled.  I don't really
> like special treatment of device-specific methods here because it
> depends on the assumption that "device-specific means all other resets
> are broken."  That's hard to maintain.
>
> Bjorn
Makes sense. I'll update this.

Thanks,
Amey
