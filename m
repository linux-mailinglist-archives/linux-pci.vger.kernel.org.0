Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D60D4340BFD
	for <lists+linux-pci@lfdr.de>; Thu, 18 Mar 2021 18:40:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229469AbhCRRjh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 18 Mar 2021 13:39:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230353AbhCRRj0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 18 Mar 2021 13:39:26 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75A85C06174A;
        Thu, 18 Mar 2021 10:39:26 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id x7-20020a17090a2b07b02900c0ea793940so5392485pjc.2;
        Thu, 18 Mar 2021 10:39:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=IhkVeMNa3z3bkyHG/n5Yqbdya8Y6YodntxafL1/t7os=;
        b=TUFkNuBaFMnmhcxPTzC3mXhgrGfceRtzFYxcJTaxVYT752Oyoo53IQ8Ng3/IwDgApB
         HPOn2KcroJmLA4uG0h7bOw7ivjvQ8RHrQVoG9VyZelQQFo37hCwr+EXtjqJWrOD3mTk/
         cjS+qoW2oKLsCJ6aGNHl74LZpZFJiyDMY9Gv5tnWcJBh9Guz6mSkNz49RFU+Al6iaqQ6
         x3AY3VWXOzO6ngjf6t8MkT43QJ0fbyEwFBYbNzxmwhd3B/6xVJLKrY+DnYV4mXLasm4e
         EGKTgcohDeFq5aTcRHWts4P5dB6GUT/dPRTgR483RTU8AtSjd8Qe+25L+36avyQm4CqL
         xzPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IhkVeMNa3z3bkyHG/n5Yqbdya8Y6YodntxafL1/t7os=;
        b=R48uxOeSiJkrc+PeMNkxFDnA+iMkVl46ei11xGrRkpmOKp+PdiSdl8zCl3A0jKqAiq
         U+WY172VauI26Eu0lLDJj/heGw//Jw8GMBTyPRhvqx2aI0rp3ytwawsZKeSBREdQ0+PG
         +YgQwtqE0RfiGk+2QDAn23GalJMTTxvXthrL6V3cz1a7htzci0/H1sIRY6Py7UWD90Sq
         PWDFJVCDbxk+KdBrAX/mtJtXVHOxixkPkbK59k/js4PeM0m8B2gnmFp6Xf0xM3hm52dW
         2075ggn/axWM9zNw4tzqR7xIX1CNxv2wcuSU3UTfNDkOYGM4ClKRalSvfgLdQDGg6tcz
         N70Q==
X-Gm-Message-State: AOAM530A+NDeSYr6JflMRfn2NYaRQyTAyIp2UMuFwFhPZCJqWfaEOfWY
        ashmahlxeYb2ofrptjhK9C0=
X-Google-Smtp-Source: ABdhPJxVwHQRKzU04F2U0YURnHC92aRGsGlcRpzFJaOTeySHUSos3U8YOpMuJLdJmhUg/IWslXztpg==
X-Received: by 2002:a17:90a:2c4b:: with SMTP id p11mr5758297pjm.75.1616089166011;
        Thu, 18 Mar 2021 10:39:26 -0700 (PDT)
Received: from localhost ([103.248.31.158])
        by smtp.gmail.com with ESMTPSA id s3sm3133362pfs.185.2021.03.18.10.39.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Mar 2021 10:39:25 -0700 (PDT)
Date:   Thu, 18 Mar 2021 23:08:42 +0530
From:   Amey Narkhede <ameynarkhede03@gmail.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     alex.williamson@redhat.com, raphael.norwitz@nutanix.com,
        linux-pci@vger.kernel.org, bhelgaas@google.com,
        linux-kernel@vger.kernel.org, alay.shah@nutanix.com,
        suresh.gumpula@nutanix.com, shyam.rajendran@nutanix.com,
        felipe@nutanix.com
Subject: Re: [PATCH 4/4] PCI/sysfs: Allow userspace to query and set device
 reset mechanism
Message-ID: <20210318173842.scxuvm2p7ub35wvk@archlinux>
References: <20210317102447.73no7mhox75xetlf@archlinux>
 <YFHh3bopQo/CRepV@unreal>
 <20210317112309.nborigwfd26px2mj@archlinux>
 <YFHsW/1MF6ZSm8I2@unreal>
 <20210317131718.3uz7zxnvoofpunng@archlinux>
 <YFILEOQBOLgOy3cy@unreal>
 <20210317113140.3de56d6c@omen.home.shazbot.org>
 <YFMYzkg101isRXIM@unreal>
 <20210318103935.2ec32302@omen.home.shazbot.org>
 <YFOMShJAm4j/3vRl@unreal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YFOMShJAm4j/3vRl@unreal>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 21/03/18 07:22PM, Leon Romanovsky wrote:
> On Thu, Mar 18, 2021 at 10:39:35AM -0600, Alex Williamson wrote:
> > On Thu, 18 Mar 2021 11:09:34 +0200
> > Leon Romanovsky <leon@kernel.org> wrote:
>
> <...>
>
> > > I'm lost here, does vfio-pci use sysfs interface or internal to the kernel API?
> > >
> > > If it is latter then we don't really need sysfs, if not, we still need
> > > some sort of DB to create second policy, because "supported != working".
> > > What am I missing?
> >
> > vfio-pci uses the internal kernel API, ie. the variants of
> > pci_reset_function(), which is the same interface used by the existing
> > sysfs reset mechanism.  This proposed configuration of the reset method
> > would affect any driver using that same core infrastructure and from my
> > perspective that's really the goal.  In the case where a supported
> > reset mechanism fails for a device, continuing to quirk those out for
> > the best default behavior makes sense, I'd be disappointed for a vendor
> > to not pursue improving the default behavior where it clearly makes
> > sense.  However, there's also a policy decision, the kernel imposes a
> > preferential ordering of reset mechanism.  Is that ordering the best
> > case for all users?  I've presented above a case where a userspace may
> > prefer a policy of preferring a bus reset to a PM reset.  So I think
> > the question is not only are there supported mechanisms that don't
> > work, where this interface allows userspace to more readily identify
> > and work around those sorts of issues, but it also enables user
> > preference and easier evaluation whether all of the supported reset
> > mechanisms work rather than just the first one we encounter in the
> > ordering we've decided to impose today.  Thanks,
>
>
[...]
> And regarding vendors, see Amey response below about his touchpad troubles.
> The cheap electronics vendors don't care about their users.
>
> Thanks
>
On the side note that vendor probably doesn't care about
Linux users because even that reverted patch was submitted
by community member.
Many vendors are satisfied with windows only drivers.
They don't have any reason to support Linux. That doesn't
mean we should also abandon those users.

Thanks,
Amey
