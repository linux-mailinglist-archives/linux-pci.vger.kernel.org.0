Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95AEB707379
	for <lists+linux-pci@lfdr.de>; Wed, 17 May 2023 23:02:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbjEQVC6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 17 May 2023 17:02:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjEQVC6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 17 May 2023 17:02:58 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA41440E6
        for <linux-pci@vger.kernel.org>; Wed, 17 May 2023 14:02:56 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id e9e14a558f8ab-33164ec77ccso49255ab.0
        for <linux-pci@vger.kernel.org>; Wed, 17 May 2023 14:02:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1684357376; x=1686949376;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EcYeLGK9CKTywc7ALkojexG3Ujj8hio2Irffds26ng8=;
        b=l0Vn+PJfSyVTO2gHeH3x4fH2JjOQEcj0rIJbOythNeDP8VOHqOEMK1yeOgpSD/YgQa
         24ZpUrWjEzUM4pXro/9E4sUOxgdYWLDCMJNlprEjlntbOk8dUDiqJAImOM/WP7fr+J7h
         ygKzUkbYhDr2QsQzMuthz/735hJm9iFqHkQm8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684357376; x=1686949376;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EcYeLGK9CKTywc7ALkojexG3Ujj8hio2Irffds26ng8=;
        b=ZW0MaRWrFMoZwFjx2zd25Grc8DEutgqIRlt0/WQuoKE+Fv7x5pB07XCno2oXjcOS38
         pX0LOKFYaak60tEU5OgdgxoJ72Be52F1vgVDjxY3Qf0zd6lE9p0DvVSwIfWx6MIp7QpR
         QzZkrR/GpLKimGvJuro8QRzFCRttUfZ/SmPw1xUEg8tUyQLOMUsQQZOhI5rJjpdw1vOR
         V3cRQ9EbwV3iULtbVHEu4tDdGMS2gliYqtADNlggwvr5MroNzPRSt04madKvsDUEhQVG
         nuzvABOJwniymZOr8Sz6ziTXupXi7OeEJdneOXFRU8N4Nc826k7veMQBFeCN6gYiPPGK
         UKdQ==
X-Gm-Message-State: AC+VfDx01aeibJB9llRk2R96AHFvoLTOzPkridqnylHUjNZ0S4b9QVFw
        KNvyPKRwuyIzE1RXCHNIZWkfyBlwAaYdYv6VmZtFYA==
X-Google-Smtp-Source: ACHHUZ4vFPBYoUxskd6+n2+JnBS0dUlSvPK2Mtatq/nB93/9CwNwWWAutpY/dJgCD8yIQwmHurziU/bYwTQXP8SuS7I=
X-Received: by 2002:a92:c24e:0:b0:331:948c:86f3 with SMTP id
 k14-20020a92c24e000000b00331948c86f3mr19472ilo.19.1684357375830; Wed, 17 May
 2023 14:02:55 -0700 (PDT)
MIME-Version: 1.0
References: <CANEJEGsE6KS484iSLkKV8hx2nNThZGfaaz+u+R-A3X5nRev6Gg@mail.gmail.com>
 <ZGT6sTOtk+WY3aYt@bhelgaas>
In-Reply-To: <ZGT6sTOtk+WY3aYt@bhelgaas>
From:   Grant Grundler <grundler@chromium.org>
Date:   Wed, 17 May 2023 14:02:43 -0700
Message-ID: <CANEJEGv8yxcYmrn4dsc0GCrcMGSFJNoJ=-VUvTjPLCVug+X29w@mail.gmail.com>
Subject: Re: [PATCHv2 pci-next 2/2] PCI/AER: Rate limit the reporting of the
 correctable errors
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Grant Grundler <grundler@chromium.org>,
        Rajat Jain <rajatja@chromium.org>,
        Rajat Khandelwal <rajat.khandelwal@linux.intel.com>,
        linux-pci@vger.kernel.org,
        Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
        linux-kernel@vger.kernel.org,
        "Oliver O 'Halloran" <oohall@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED,USER_IN_DEF_SPF_WL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, May 17, 2023 at 9:03=E2=80=AFAM Bjorn Helgaas <helgaas@kernel.org> =
wrote:
>
> On Fri, Apr 07, 2023 at 04:46:03PM -0700, Grant Grundler wrote:
> > On Fri, Apr 7, 2023 at 12:46=E2=80=AFPM Bjorn Helgaas <helgaas@kernel.o=
rg> wrote:
> > > On Fri, Apr 07, 2023 at 11:53:27AM -0700, Grant Grundler wrote:
> > > > On Thu, Apr 6, 2023 at 12:50=E2=80=AFPM Bjorn Helgaas <helgaas@kern=
el.org>
> > > wrote:
> > > > > On Fri, Mar 17, 2023 at 10:51:09AM -0700, Grant Grundler wrote:
> > > > > > From: Rajat Khandelwal <rajat.khandelwal@linux.intel.com>
> > > > > >
> > > > > > There are many instances where correctable errors tend to inund=
ate
> > > > > > the message buffer. We observe such instances during thunderbol=
t PCIe
> > > > > > tunneling.
> > > > ...
> > >
> > > > > >               if (info->severity =3D=3D AER_CORRECTABLE)
> > > > > > -                     pci_info(dev, "   [%2d] %-22s%s\n", i, er=
rmsg,
> > > > > > -                             info->first_error =3D=3D i ? " (F=
irst)" :
> > > "");
> > > > > > +                     pci_info_ratelimited(dev, "   [%2d]
> > > %-22s%s\n", i, errmsg,
> > > > > > +                                          info->first_error =
=3D=3D i ?
> > > " (First)" : "");
> > > > >
> > > > > I don't think this is going to reliably work the way we want.  We=
 have
> > > > > a bunch of pci_info_ratelimited() calls, and each caller has its =
own
> > > > > ratelimit_state data.  Unless we call pci_info_ratelimited() exac=
tly
> > > > > the same number of times for each error, the ratelimit counters w=
ill
> > > > > get out of sync and we'll end up printing fragments from error A =
mixed
> > > > > with fragments from error B.
> > > >
> > > > Ok - what I'm reading between the lines here is the output should b=
e
> > > > emitted in one step, not multiple pci_info_ratelimited() calls. if =
the
> > > > code built an output string (using sprintnf()), and then called
> > > > pci_info_ratelimited() exactly once at the bottom, would that be
> > > > sufficient?
> > > >
> > > > > I think we need to explicitly manage the ratelimiting ourselves,
> > > > > similar to print_hmi_event_info() or print_extlog_rcd().  Then we=
 can
> > > > > have a *single* ratelimit_state, and we can check it once to dete=
rmine
> > > > > whether to log this correctable error.
> > > >
> > > > Is the rate limiting per call location or per device? From above, I
> > > > understood rate limiting is "per call location".  If the code only
> > > > has one call location, it should achieve the same goal, right?
> > >
> > > Rate-limiting is per call location, so yes, if we only have one call
> > > location, that would solve it.  It would also have the nice property
> > > that all the output would be atomic so it wouldn't get mixed with
> > > other stuff, and it might encourage us to be a little less wordy in
> > > the output.
> > >
> >
> > +1 to all of those reasons. Especially reducing the number of lines out=
put.
> >
> > I'm going to be out for the next week. If someone else (Rajat Kendalwal
> > maybe?) wants to rework this to use one call location it should be fair=
ly
> > straight forward. If not, I'll tackle this when I'm back (in 2 weeks
> > essentially).
>
> Ping?  Really hoping to merge this for v6.5.

Sorry - I forgot about this... I'll take a shot at it. Should have
something by this evening.

cheers,
grant

>
> Bjorn
