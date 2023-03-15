Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 955966BA402
	for <lists+linux-pci@lfdr.de>; Wed, 15 Mar 2023 01:25:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229687AbjCOAZL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Mar 2023 20:25:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbjCOAZK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 14 Mar 2023 20:25:10 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28B376EBE
        for <linux-pci@vger.kernel.org>; Tue, 14 Mar 2023 17:25:03 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id az3-20020a05600c600300b003ed2920d585so97418wmb.2
        for <linux-pci@vger.kernel.org>; Tue, 14 Mar 2023 17:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1678839901;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PBNqRKvFHgPqqskaybm027VBSueaOqeOTv7uwJBWtdQ=;
        b=ZiLxIon1u+rmZiqod8EddJ1NTtYuick9y4S5J3gIzNVwzhoPs8cNYgm0UcpTqZd4GC
         WXyLUpKm39+drChF4demvnBD117++Ok1xOZEphRRiTuqZJAZGaXrEFYLbNHbNkMZefuo
         ULsB9cCkVr8xwkt81Ow4eHlVoH0pkdxniF+lc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678839901;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PBNqRKvFHgPqqskaybm027VBSueaOqeOTv7uwJBWtdQ=;
        b=F+RZO5wIew+BcO2tNHKWxwadY2JOI9CsJyRrqZaFgtLcMJyaAydW7vg+5aqc1eaTKE
         8b276I1pOM2jpMYNVzFJ3+3hxa2vMiMIviBkKqXi+XJwTfQmp/zuVCC/oIJP1fA60fJ2
         /N2DcBCfHhBE/621pNqT0kJaLG4lQg+dDOniY3is81qyMi/5CDxVBc0rnc4pr6r/rMQ5
         w4Bnd9Uh5wAepAMNSPyCeyQWAeLvcWMWAqDaT2xoG3VfdmAjOMNThRB175rD4yU0C53z
         tvjbi9bKBgNKLGXjC0DjlGIlFyU8gUEh0RcOEnWpapWZg5bynE75CZE/GndABuqJWlZT
         RQdg==
X-Gm-Message-State: AO0yUKUl7LmMh3+t0pN09dhAfoSqb4jiuvPFRGkkPJ5KnDXoAXqXLD5a
        ie7SCxS6QWG1oG58GH3vfuio3jUWwFMouvDbJaewGig/bTnjowOy7/HtYw==
X-Google-Smtp-Source: AK7set/m4nESElQsgLmaw1biuRQY8j6mcZEJlWhUB+r9v2P1fMoQCuNEmhEy6d2bWp46oRQ6Y14VPSx4Kv3vqwW2Crw=
X-Received: by 2002:a05:600c:512a:b0:3ed:26fa:6ee5 with SMTP id
 o42-20020a05600c512a00b003ed26fa6ee5mr2238902wms.4.1678839901419; Tue, 14 Mar
 2023 17:25:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230301060453.4031503-1-grundler@chromium.org> <20230314193836.GA1667748@bhelgaas>
In-Reply-To: <20230314193836.GA1667748@bhelgaas>
From:   Grant Grundler <grundler@chromium.org>
Date:   Tue, 14 Mar 2023 17:24:49 -0700
Message-ID: <CANEJEGtxn79+weGWVuF+Ytw789Smxv-2vGaM_qes1hfzg7qeYw@mail.gmail.com>
Subject: Re: [PATCH] PCI/AER: correctable error message as KERN_INFO
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Grant Grundler <grundler@chromium.org>,
        Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
        "Oliver O 'Halloran" <oohall@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rajat Khandelwal <rajat.khandelwal@linux.intel.com>,
        linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rajat Jain <rajatja@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
        USER_IN_DEF_SPF_WL autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Mar 14, 2023 at 12:38=E2=80=AFPM Bjorn Helgaas <helgaas@kernel.org>=
 wrote:
>
> On Tue, Feb 28, 2023 at 10:04:53PM -0800, Grant Grundler wrote:
> > Since correctable errors have been corrected (and counted), the dmesg o=
utput
> > should not be reported as a warning, but rather as "informational".
> >
> > Otherwise, using a certain well known vendor's PCIe parts in a USB4 doc=
king
> > station, the dmesg buffer can be spammed with correctable errors, 717 b=
ytes
> > per instance, potentially many MB per day.
> >
> > Given the "WARN" priority, these messages have already confused the typ=
ical
> > user that stumbles across them, support staff (triaging feedback report=
s),
> > and more than a few linux kernel devs. Changing to INFO will hide these
> > messages from most audiences.
> >
> > Signed-off-by: Grant Grundler <grundler@chromium.org>
> > ---
> > This patch will likely conflict with:
> >   https://lore.kernel.org/all/20230103165548.570377-1-rajat.khandelwal@=
linux.intel.com/
> >
> > which I'd also like to see upstream. Please let me know to resubmit
> > mine if Rajat's patch lands first. Or feel free to fix up this one.
>
> Yes.  I think it makes sense to separate this into two patches:
>
>   1) Log correctable errors as KERN_INFO instead of KERN_WARNING, and
>   2) Rate-limit correctable error logging.

I'm going to look into your comment below. I'll port Rajat's patch on
top of mine to follow the order you've listed above.

> >  drivers/pci/pcie/aer.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> > index f6c24ded134c..e4cf3ec40d66 100644
> > --- a/drivers/pci/pcie/aer.c
> > +++ b/drivers/pci/pcie/aer.c
> > @@ -692,7 +692,7 @@ static void __aer_print_error(struct pci_dev *dev,
> >
> >       if (info->severity =3D=3D AER_CORRECTABLE) {
> >               strings =3D aer_correctable_error_string;
> > -             level =3D KERN_WARNING;
> > +             level =3D KERN_INFO;
> >       } else {
> >               strings =3D aer_uncorrectable_error_string;
> >               level =3D KERN_ERR;
> > @@ -724,7 +724,7 @@ void aer_print_error(struct pci_dev *dev, struct ae=
r_err_info *info)
> >       layer =3D AER_GET_LAYER_ERROR(info->severity, info->status);
> >       agent =3D AER_GET_AGENT(info->severity, info->status);
> >
> > -     level =3D (info->severity =3D=3D AER_CORRECTABLE) ? KERN_WARNING =
: KERN_ERR;
> > +     level =3D (info->severity =3D=3D AER_CORRECTABLE) ? KERN_INFO : K=
ERN_ERR;
> >
> >       pci_printk(level, dev, "PCIe Bus Error: severity=3D%s, type=3D%s,=
 (%s)\n",
> >                  aer_error_severity_string[info->severity],
>
> Shouldn't we do the same in the cper_print_aer() path?  That path
> currently uses pci_err() and then calls __aer_print_error(), so the
> initial message will always be KERN_ERR, and the decoding done by
> __aer_print_error() will be KERN_INFO (for correctable) or KERN_ERR.

I was completely unaware of this since it's not causing me any
immediate problems. But I agree the message priority should be
consistent for correctable errors.

> Seems like a shame to do the same test in three places, but would
> require a little more refactoring to avoid that.

I don't mind doing the same test in multiple places. If refactoring
this isn't straight forward, I'll leave the refactoring for someone
more ambitious. :D

cheers,
grant

>
> Bjorn
