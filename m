Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19E93290DD3
	for <lists+linux-pci@lfdr.de>; Sat, 17 Oct 2020 00:41:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731906AbgJPWle (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 16 Oct 2020 18:41:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728616AbgJPWld (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 16 Oct 2020 18:41:33 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AF86C061755
        for <linux-pci@vger.kernel.org>; Fri, 16 Oct 2020 15:41:33 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id q26so2571150qtb.5
        for <linux-pci@vger.kernel.org>; Fri, 16 Oct 2020 15:41:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZqxRcER9BR6H13pTOkmT704wn1jrz4C1jfjWUr6qbWA=;
        b=BdoZ0/2xhksW+OoiR8M8hhsOoDMlP6rUC7HYfE6a3bMSm+LOy9+//bJq3EYOJGPvMo
         tcSLX+OlvpKL3r3nTOAPMTWWO8857eUHSeMUpXEvk6a0T/fZFITszi5AlOdnArh5iSVn
         5LfoTR1/za08NdLlmaU/rebW4LIehdZMrnTH8QWq2GOybWn75SVI26ke/jAtEVHoI1pO
         N1hGSM6hXd5RREItJ4DK+PxEXzryHW1dF3WGyuZuN8U2tsr0Vivf4PVMzervBepV3cEn
         pSjifARMGpfaU3gmZfmtmukOT1Ad+Xmk0vW4T3v7XeXV1GENmSjYc9iKR/VbQ3rhV+/6
         xOng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZqxRcER9BR6H13pTOkmT704wn1jrz4C1jfjWUr6qbWA=;
        b=Ck0D2cuYihkC799UgEJzzRQ0ATJT3hmfdB31cIngwgwHm7MNzJox0r6AoyV3zJWpV8
         +VRIbWUq9mmN6JhTzL/qbHm3mDTcRSZ2nu2yBkxyoDJTxx/BJtezIlyQA2ZlL0q1ZKKH
         qoYjjtHdpXTjMTWf92K1XxrBdKhwUNwZAOTVjqakTiv1gcbHtx65u036OjXWR6niZOWC
         RoRKT9TXgcY923CPy+87Rml5IIGq4K/aN8qdX1WddISOfkgnBVOVV+Cy9mGjm/W1Tsra
         aYN6ggRQKWoHMQpfH3ahPLNKrE6PCDZ+b6xPtX8qVeEn98SxwVchhjNBW7RD4fqbgRtQ
         bpsQ==
X-Gm-Message-State: AOAM531/YsJzYPufru9chODzov9GzRwEOIWt6JCy1HWccC+zbziE8weL
        mGgJlMuym2vhAQZxH9k1Vapsnj87xDwk8dkKF6E=
X-Google-Smtp-Source: ABdhPJyBtQ0B7uJlH5vKERZuKoJPUDfPwYeFyp/0bpZ1N/iT9jgxL7hkJMEBjXhUZzyHX+nXWa9HThKUDdDZBnHxjJU=
X-Received: by 2002:ac8:3ac4:: with SMTP id x62mr5478549qte.347.1602888092584;
 Fri, 16 Oct 2020 15:41:32 -0700 (PDT)
MIME-Version: 1.0
References: <CAA85sZsnMd3SdnH2bchxfkR7_Ka1wDvu9Z592uaK3FFm4rszTw@mail.gmail.com>
 <20201016212846.GA109479@bjorn-Precision-5520>
In-Reply-To: <20201016212846.GA109479@bjorn-Precision-5520>
From:   Ian Kumlien <ian.kumlien@gmail.com>
Date:   Sat, 17 Oct 2020 00:41:21 +0200
Message-ID: <CAA85sZuOh8ZtnWj8svxK_9er7hLskTjc0ASUVkvAkv9Rc=Bh_g@mail.gmail.com>
Subject: Re: [PATCH] Use maximum latency when determining L1 ASPM
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Alexander Duyck <alexander.duyck@gmail.com>,
        "Saheed O. Bolarinwa" <refactormyself@gmail.com>,
        Puranjay Mohan <puranjay12@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Oct 16, 2020 at 11:28 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Wed, Oct 14, 2020 at 03:33:17PM +0200, Ian Kumlien wrote:
> > On Wed, Oct 14, 2020 at 10:34 AM Kai-Heng Feng
> > <kai.heng.feng@canonical.com> wrote:
> > > > On Oct 12, 2020, at 18:20, Ian Kumlien <ian.kumlien@gmail.com> wrote:
> > > > On Thu, Oct 8, 2020 at 6:13 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> > > >> OK, now we're getting close.  We just need to flesh out the
> > > >> justification.  We need:
> > > >>
> > > >>  - Tidy subject line.  Use "git log --oneline drivers/pci/pcie/aspm.c"
> > > >>    and follow the example.
> > > >
> > > > Will do
> > > >
> > > >>  - Description of the problem.  I think it's poor bandwidth on your
> > > >>    Intel I211 device, but we don't have the complete picture because
> > > >>    that NIC is 03:00.0, which doesn't appear above at all.
> > > >
> > > > I think we'll use Kai-Hengs issue, since it's actually more related to
> > > > the change itself...
> > > >
> > > > Mine is a side effect while Kai-Heng is actually hitting an issue
> > > > caused by the bug.
> > >
> > > I filed a bug here:
> > > https://bugzilla.kernel.org/show_bug.cgi?id=209671
> >
> > Thanks!
>
> Sigh.  I feel like I'm just not getting anywhere here.  I still do not
> have a "before" and "after" set of lspci output.
>
> Kai-Heng's bugzilla has two sets of output, but one is a working
> config with CONFIG_PCIEASPM_DEFAULT=y and the other is a working
> config with Ian's patch applied and CONFIG_PCIEASPM_POWERSAVE=y.
>
> Comparing them doesn't show the effect of Ian's patch; it shows the
> combined effect of Ian's patch and the CONFIG_PCIEASPM_POWERSAVE=y
> change.  I'm not really interested in spending a few hours trying to
> reverse-engineer the important changes.
>
> Can you please, please, collect these on your system, Ian?  I assume
> that you can easily collect it once without your patch, when you see
> poor I211 NIC performance but the system is otherwise working.  And
> you can collect it again *with* your patch.  Same Kconfig, same
> *everything* except adding your patch.

Yeah I can do that, but I would like the changes output from the
latest patch suggestion
running on Kai-Heng's system so we can actually see what it does...

> Bjorn
