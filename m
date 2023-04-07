Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EA716DB75B
	for <lists+linux-pci@lfdr.de>; Sat,  8 Apr 2023 01:47:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229737AbjDGXr3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 7 Apr 2023 19:47:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbjDGXr2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 7 Apr 2023 19:47:28 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8B30EF8B
        for <linux-pci@vger.kernel.org>; Fri,  7 Apr 2023 16:47:27 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id d75a77b69052e-3e673b5f558so514041cf.1
        for <linux-pci@vger.kernel.org>; Fri, 07 Apr 2023 16:47:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1680911247; x=1683503247;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zXTrg0mDV7Q1ZzUvffjDPVloLufOXWmykfXvP65A/O0=;
        b=f7kvXaQXsTi3P8WLYLsxHg6BjzOkv9BuXp18qU6yp12LEyg/bXd7Cq92+AZdbGbanD
         OhwrOh+oN4kwnppYY+1FU3+ecy/X9DdgdZ5ydpiZVxiu/WoXtSqkeW2FWcg8w/XRTDqp
         ndKPXDdNhqH+JFhO7I1LsIMxCoCcSBLEhtOQI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680911247; x=1683503247;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zXTrg0mDV7Q1ZzUvffjDPVloLufOXWmykfXvP65A/O0=;
        b=UPk9wJ0J358U31UMahW4KYVAAr3y4Delbv6asYjsR9qVwnPVpj8ZSgVPIfc+emAUpI
         zL9lHGTiDl/BOmgE+EY+bdwjN1aPoypTmWQdbr0fknLYm3YFzOioy39fzn0Cx3ZqE8uY
         NfuszWpAspqyzsT67Xp5amRth6qVGfh5HwGOlX9tkjvdTdhDYvNIEIixoE+moApBmSc5
         ydHpcdRkuW/IRdNjsNPCECQARLGqn4VOl2S72AVoS1Mnzn4CRZ82b6qP1Egr3t1FFLgQ
         +oypP5iJhIx0vpa9E6r95uKQO50DjWm/888bXe/zqS/zXC1ou9GeVzE5qNT8CsXpJ8Fe
         8P9A==
X-Gm-Message-State: AAQBX9eTQdAxxy+cp4CvUE8VGucUnkYv0WTNU8VTOL3Fxu1ENwdeIcCH
        uN/iKxYZWiTJLFaeh5MXpewObdA2bVi3MAAL7dsbdw==
X-Google-Smtp-Source: AKy350anL/S84pz5fQsDUIE/4hZz/d4BnMbaLsMWzeAb0ywkzGXmZGt34QieZAyEeqWjWiFbipyCD6eXWX0ziw214bg=
X-Received: by 2002:a05:622a:15c7:b0:3de:8cbe:47af with SMTP id
 d7-20020a05622a15c700b003de8cbe47afmr57131qty.9.1680911246702; Fri, 07 Apr
 2023 16:47:26 -0700 (PDT)
MIME-Version: 1.0
References: <CANEJEGvKRVGLYPmD3kujg6veq5KR7J+rAu6ni92wUz72KGtyBA@mail.gmail.com>
 <20230407194645.GA3814486@bhelgaas>
In-Reply-To: <20230407194645.GA3814486@bhelgaas>
From:   Grant Grundler <grundler@chromium.org>
Date:   Fri, 7 Apr 2023 16:47:15 -0700
Message-ID: <CANEJEGtZo-TSjYfoVbw5wdNbOdjwth=E51w8_MoFYyuo5+QrTw@mail.gmail.com>
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
>
> It *could* be per pci_dev, too, but I suspect it's not worth spending
> 40ish bytes per device for the ratelimit data.
>
> Bjorn
