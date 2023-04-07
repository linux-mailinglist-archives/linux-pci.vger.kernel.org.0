Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92B226DB75E
	for <lists+linux-pci@lfdr.de>; Sat,  8 Apr 2023 01:49:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229513AbjDGXtv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 7 Apr 2023 19:49:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbjDGXtu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 7 Apr 2023 19:49:50 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D618E1AF
        for <linux-pci@vger.kernel.org>; Fri,  7 Apr 2023 16:49:49 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id d75a77b69052e-3e392e10cc4so697941cf.0
        for <linux-pci@vger.kernel.org>; Fri, 07 Apr 2023 16:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1680911388; x=1683503388;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qqjTxx7icMTYukspTJWOyXAdc8KUgw2cKmRcRpT5B70=;
        b=LfFAt7rJUt1pUj98t+F2Quk+iZHTggmA6ET02STj58xiL96wfom24Bhd5OmXVYsW9r
         i99ls8sk7qvxcW0e1zkLKqFhmDpkZ0BboRA2FbvRREmlEw1c72OMdwWyBYdPznan12x3
         evBfPx9CvCBr2kyG+W7G5UebTVPHerxyHia8g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680911388; x=1683503388;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qqjTxx7icMTYukspTJWOyXAdc8KUgw2cKmRcRpT5B70=;
        b=NE0iPrsuYkqQMda1nBA+5X1dPBEKt5Vj3WzWrQnvw1Dts1KoAfGG7lj4NxGeqfnEW+
         SNH5L/RxfCwwOdZWzvPA0XvPbJiuL7YMI7gae/Fp3+20rZljqjgIo1Yn6QdG9bzxlK1I
         sHnCSARGEZUkdCZqYOB3aht7/9PnG4R7li150KP1mLE87NpljQYZ0H86TKthMd7EAnUb
         /EGTmHcFBsS2p+Bg3SgblqFYMpf3tTqgpyvznPO4p7VreOp3izPB7OHA/1vmT4+t9tkn
         vBw4IAfhmeIdOYgQ4ahOX5UPg4QCpbsRAVazKdBhlOWH8o+bseaTiUUqPoBYIdE1CMKo
         xwrg==
X-Gm-Message-State: AAQBX9fU8JEaBtsrlSM0fJg7/OdmGvTV+CzZ2R6XH2JZojfjtT/ezThd
        Q5Kyw2WQdEvyQXxN2w2/jwShSt8Bzq2rjuWzN/gMC1wxOhph/QXqo21Arw==
X-Google-Smtp-Source: AKy350YqUSXVlmbwDJr3UQsJTE8KS7rADBSmXy0bQ5nLTgrofx1yY7eU48cqTzdgtXifug4KW09JduqdhsqfhvTfN6I=
X-Received: by 2002:ac8:5f93:0:b0:3bf:d313:77dd with SMTP id
 j19-20020ac85f93000000b003bfd31377ddmr152060qta.14.1680911388085; Fri, 07 Apr
 2023 16:49:48 -0700 (PDT)
MIME-Version: 1.0
References: <CANEJEGvKRVGLYPmD3kujg6veq5KR7J+rAu6ni92wUz72KGtyBA@mail.gmail.com>
 <20230407194645.GA3814486@bhelgaas>
In-Reply-To: <20230407194645.GA3814486@bhelgaas>
From:   Grant Grundler <grundler@chromium.org>
Date:   Fri, 7 Apr 2023 16:49:37 -0700
Message-ID: <CANEJEGu6YMfPPbWsRCZ4tsLAo9mKUbijnd1VEKvbsk4Xe4VXhg@mail.gmail.com>
Subject: Re: [PATCHv2 pci-next 2/2] PCI/AER: Rate limit the reporting of the
 correctable errors
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Grant Grundler <grundler@chromium.org>,
        Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
        "Oliver O 'Halloran" <oohall@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rajat Jain <rajatja@chromium.org>,
        Rajat Khandelwal <rajat.khandelwal@linux.intel.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_SPF_WL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[reposting in plain text mode]

On Fri, Apr 7, 2023 at 12:46=E2=80=AFPM Bjorn Helgaas <helgaas@kernel.org> =
wrote:
>
> On Fri, Apr 07, 2023 at 11:53:27AM -0700, Grant Grundler wrote:
> > On Thu, Apr 6, 2023 at 12:50=E2=80=AFPM Bjorn Helgaas <helgaas@kernel.o=
rg> wrote:
> > > On Fri, Mar 17, 2023 at 10:51:09AM -0700, Grant Grundler wrote:
> > > > From: Rajat Khandelwal <rajat.khandelwal@linux.intel.com>
> > > >
> > > > There are many instances where correctable errors tend to inundate
> > > > the message buffer. We observe such instances during thunderbolt PC=
Ie
> > > > tunneling.
> > ...
>
> > > >               if (info->severity =3D=3D AER_CORRECTABLE)
> > > > -                     pci_info(dev, "   [%2d] %-22s%s\n", i, errmsg=
,
> > > > -                             info->first_error =3D=3D i ? " (First=
)" : "");
> > > > +                     pci_info_ratelimited(dev, "   [%2d] %-22s%s\n=
", i, errmsg,
> > > > +                                          info->first_error =3D=3D=
 i ? " (First)" : "");
> > >
> > > I don't think this is going to reliably work the way we want.  We hav=
e
> > > a bunch of pci_info_ratelimited() calls, and each caller has its own
> > > ratelimit_state data.  Unless we call pci_info_ratelimited() exactly
> > > the same number of times for each error, the ratelimit counters will
> > > get out of sync and we'll end up printing fragments from error A mixe=
d
> > > with fragments from error B.
> >
> > Ok - what I'm reading between the lines here is the output should be
> > emitted in one step, not multiple pci_info_ratelimited() calls. if the
> > code built an output string (using sprintnf()), and then called
> > pci_info_ratelimited() exactly once at the bottom, would that be
> > sufficient?
> >
> > > I think we need to explicitly manage the ratelimiting ourselves,
> > > similar to print_hmi_event_info() or print_extlog_rcd().  Then we can
> > > have a *single* ratelimit_state, and we can check it once to determin=
e
> > > whether to log this correctable error.
> >
> > Is the rate limiting per call location or per device? From above, I
> > understood rate limiting is "per call location".  If the code only
> > has one call location, it should achieve the same goal, right?
>
> Rate-limiting is per call location, so yes, if we only have one call
> location, that would solve it.  It would also have the nice property
> that all the output would be atomic so it wouldn't get mixed with
> other stuff, and it might encourage us to be a little less wordy in
> the output.

+1 to all of those reasons. Especially reducing the number of lines output.

I'm going to be out for the next week. If someone else (Rajat
Kendalwal maybe?) wants to rework this to use one call location it
should be fairly straight forward. If not, I'll tackle this when I'm
back (in 2 weeks essentially).

>
> But I don't think we need output in a single step; we just need a
> single instance of ratelimit_state (or one for CPER path and another
> for native AER path), and that can control all the output for a single
> error.  E.g., print_hmi_event_info() looks like this:
>
>   static void print_hmi_event_info(...)
>   {
>     static DEFINE_RATELIMIT_STATE(rs, ...);
>
>     if (__ratelimit(&rs)) {
>       printk("%s%s Hypervisor Maintenance interrupt ...");
>       printk("%s Error detail: %s\n", ...);
>       printk("%s      HMER: %016llx\n", ...);
>     }
>   }
>
> I think it's nice that the struct ratelimit_state is explicit and
> there's no danger of breaking it when adding another printk later.

True. But a single call to a "well documented" API is my preference
(assuming this is my choice).

> It *could* be per pci_dev, too, but I suspect it's not worth spending
> 40ish bytes per device for the ratelimit data.

Good - I don't think we need to make this per device - I had assumed
it was but also currently don't see a need for this.

cheers,
grant
