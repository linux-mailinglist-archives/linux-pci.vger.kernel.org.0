Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 764256B12FC
	for <lists+linux-pci@lfdr.de>; Wed,  8 Mar 2023 21:23:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbjCHUXs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Mar 2023 15:23:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbjCHUXq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 8 Mar 2023 15:23:46 -0500
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com [IPv6:2607:f8b0:4864:20::e32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 777E062FF0
        for <linux-pci@vger.kernel.org>; Wed,  8 Mar 2023 12:23:24 -0800 (PST)
Received: by mail-vs1-xe32.google.com with SMTP id by13so16527831vsb.3
        for <linux-pci@vger.kernel.org>; Wed, 08 Mar 2023 12:23:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1678307003;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+RPaT5MrHSvj4O9LtIvda00nyyIYBJhBMMQAbW0pyRs=;
        b=F9JkXcVoblDoQmKlLDOVuticNu5VhGherOTRVqdN12OzIO5B0v1TVWd406EsRrlLIs
         db+cOdWorzKZyRoNnq8sLXcGkQm56hKnDE1J4Q3NMwU/kh/rek0T2Y31POsARkcCwc9g
         rbkZPzwZTdMLA7RyOtumdEoEL+ma5XpwLbpU4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678307003;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+RPaT5MrHSvj4O9LtIvda00nyyIYBJhBMMQAbW0pyRs=;
        b=wXk+dZZ7h28XrC2w32YBDFY0yQ1r681oZ/uFx9TXLc7x3A4vBp7VaK7qgrR0Nv0z76
         JVPzFc32R/iV0DOnWMxPxToGy5SH3qFp0UTofcm7R3Vv0+CbcD5Q+ryWC9cDnlbKo3Y2
         EGb8hCVyqS1oujlpm3wn3pwbWL7GROMUMQjZNvktdd8uWWrd020S6PDdUgyo+nnpJroI
         Ddh1xlrwcVJBuBy1E7FVA+VBaATDCgGOHBAJsYMD/pmEeCcVTAxMIarjdTl+STSSmn+l
         rWH1ZB/KKBIq7LF5OqMDlYKbDHatlPqVlFCW8gUI1aMRS6BVw1xl/iJayO4VFilhXIFG
         rdeA==
X-Gm-Message-State: AO0yUKV4mwFuThRjpOz/pW3Tg0qAhmnd/HFJeG8DRRrcOHCUkfVWiwE2
        RWXTP2CH1HmPE1u7N9h/ayKgauMxFaV35HrJ6XDcFg==
X-Google-Smtp-Source: AK7set819vxr9EQa/2YNU/n4kHNJ5k7TG52gGkvDn+JASTWTeZxSkmZibh/gpAVYxJG81DMZiVDj2IX8Hf+16OcA3NU=
X-Received: by 2002:a05:6102:1261:b0:412:11d2:bd97 with SMTP id
 q1-20020a056102126100b0041211d2bd97mr12491049vsg.2.1678307003370; Wed, 08 Mar
 2023 12:23:23 -0800 (PST)
MIME-Version: 1.0
References: <CANEJEGvB0+XTgUwJi80BRFpNYWrbtiz17baSoxcR_OpSdnzahg@mail.gmail.com>
 <20230308201827.GA1039517@bhelgaas>
In-Reply-To: <20230308201827.GA1039517@bhelgaas>
From:   Grant Grundler <grundler@chromium.org>
Date:   Wed, 8 Mar 2023 12:23:12 -0800
Message-ID: <CANEJEGuQhPHG6517=Os_9cgzhx7r0Rivg8BRAnKdENPMvNFxKQ@mail.gmail.com>
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

On Wed, Mar 8, 2023 at 12:18=E2=80=AFPM Bjorn Helgaas <helgaas@kernel.org> =
wrote:
>
> On Wed, Mar 08, 2023 at 12:00:48PM -0800, Grant Grundler wrote:
> > Ping? Did I miss an email or other work that this patch collides with?
>
> Nope, we typically make topic branches based on -rc1, so not much
> happens during the merge window.  -rc1 was tagged Sunday, so things
> will start appearing in -next soon.

Ah ok! Thanks for clarifying Bjorn!

cheers,
grant

>
> Bjorn
>
> > On Tue, Feb 28, 2023 at 10:05=E2=80=AFPM Grant Grundler <grundler@chrom=
ium.org> wrote:
> > >
> > > Since correctable errors have been corrected (and counted), the dmesg=
 output
> > > should not be reported as a warning, but rather as "informational".
> > >
> > > Otherwise, using a certain well known vendor's PCIe parts in a USB4 d=
ocking
> > > station, the dmesg buffer can be spammed with correctable errors, 717=
 bytes
> > > per instance, potentially many MB per day.
> > >
> > > Given the "WARN" priority, these messages have already confused the t=
ypical
> > > user that stumbles across them, support staff (triaging feedback repo=
rts),
> > > and more than a few linux kernel devs. Changing to INFO will hide the=
se
> > > messages from most audiences.
> > >
> > > Signed-off-by: Grant Grundler <grundler@chromium.org>
> > > ---
> > > This patch will likely conflict with:
> > >   https://lore.kernel.org/all/20230103165548.570377-1-rajat.khandelwa=
l@linux.intel.com/
> > >
> > > which I'd also like to see upstream. Please let me know to resubmit m=
ine if Rajat's patch lands first. Or feel free to fix up this one.
> > >
> > >  drivers/pci/pcie/aer.c | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> > > index f6c24ded134c..e4cf3ec40d66 100644
> > > --- a/drivers/pci/pcie/aer.c
> > > +++ b/drivers/pci/pcie/aer.c
> > > @@ -692,7 +692,7 @@ static void __aer_print_error(struct pci_dev *dev=
,
> > >
> > >         if (info->severity =3D=3D AER_CORRECTABLE) {
> > >                 strings =3D aer_correctable_error_string;
> > > -               level =3D KERN_WARNING;
> > > +               level =3D KERN_INFO;
> > >         } else {
> > >                 strings =3D aer_uncorrectable_error_string;
> > >                 level =3D KERN_ERR;
> > > @@ -724,7 +724,7 @@ void aer_print_error(struct pci_dev *dev, struct =
aer_err_info *info)
> > >         layer =3D AER_GET_LAYER_ERROR(info->severity, info->status);
> > >         agent =3D AER_GET_AGENT(info->severity, info->status);
> > >
> > > -       level =3D (info->severity =3D=3D AER_CORRECTABLE) ? KERN_WARN=
ING : KERN_ERR;
> > > +       level =3D (info->severity =3D=3D AER_CORRECTABLE) ? KERN_INFO=
 : KERN_ERR;
> > >
> > >         pci_printk(level, dev, "PCIe Bus Error: severity=3D%s, type=
=3D%s, (%s)\n",
> > >                    aer_error_severity_string[info->severity],
> > > --
> > > 2.39.2.722.g9855ee24e9-goog
> > >
