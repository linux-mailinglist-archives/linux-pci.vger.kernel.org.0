Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 475B5232B00
	for <lists+linux-pci@lfdr.de>; Thu, 30 Jul 2020 06:31:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728090AbgG3Eb6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 30 Jul 2020 00:31:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725765AbgG3Eb5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 30 Jul 2020 00:31:57 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71CA1C061794;
        Wed, 29 Jul 2020 21:31:57 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id c80so4515263wme.0;
        Wed, 29 Jul 2020 21:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=0RjPi2QHDN+CaGl6MBAqqXZ/X0Cghv1F5XYMZ8Gsh1w=;
        b=htBsbUACoP3Op+yOzWaVkw+7rGgTzI3a89FBoY7eSNknA4vgMnZ3aUMBjX0boe+JiH
         o++pnbaiEZtyJy2j/Z6H8LKs/+9NNp1v22f2zP6oMGbN4UtvH2/i1QW/dkUJevgFJfhR
         YyiPOREAFOS9BFdCROIGjvGP8sgHg8MnbOdGNc0k+LLrxNRf4OBFKhHN6Sd6oyCLOe5y
         6gPHlH/rOLb52Q8qUgiuLeYDXzBAqAQPFnuz4SzeFMmJqSbyBxCjfVkvAXbTbMq8TLow
         XFU+VFeq4lvH5Wj8f72/2t/rscjdK4PCcyiXMnwQAYn8ma3LMqDkzo4N7drmKLxjDuwH
         0USA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=0RjPi2QHDN+CaGl6MBAqqXZ/X0Cghv1F5XYMZ8Gsh1w=;
        b=q86eUykXmeS+J3rp81Hypuc363ZIjCgt5koDdJqUHy2SPFk/OVsgoRZG80x80Yg7x/
         PzUTWNjkgJZWAbsLEiMktwaB/wnOAqEBaKYuCKmgndrixxLhmP5BbO1iEYiaDnB6XfBC
         VI8Ebvn+bKYCAYVqlprBAUki/mPL4O97ohspQUp9vSVFuaAVZZJ7iOdYOayxmbUwbcC8
         l1gXjJkGpfUXDiQr48QDqLDoXyx65xn8cny8vczKGKUEMAt8nez2phNAMTRQNW2WeUN2
         pbgpeeg1QT5cnP/bUAJCGbAnAFhxj7hLRLlomaKaMQ2Eo8lvryjS2L3KbCsR6Bl6CAL+
         hLGg==
X-Gm-Message-State: AOAM530o/3h6CeLAICXRMupNawjtkL4x81KAC3fWTeqQ5hUIRKQgevAv
        Cd0lUbpngmuM07+eAvZArtsowKUyULCvCdfnEQE=
X-Google-Smtp-Source: ABdhPJxZEOthf3UUgAgW5HJXhdjEOsBx23XqAEk0Qlu8lzNoaQ1zMoTYiSJIcm6gkLqdtdeD2ZixQd16qmewZlQNu4M=
X-Received: by 2002:a7b:c941:: with SMTP id i1mr11390517wml.73.1596083515979;
 Wed, 29 Jul 2020 21:31:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200729231844.4653-1-logang@deltatee.com>
In-Reply-To: <20200729231844.4653-1-logang@deltatee.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 30 Jul 2020 00:31:44 -0400
Message-ID: <CADnq5_OZMiK21niDFSUgptv2vtBj4vyyxBTafWnFwWuEV6VB7w@mail.gmail.com>
Subject: Re: [PATCH v2] PCI/P2PDMA: Allow P2PDMA on all AMD CPUs newer than
 the Zen family
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Huang Rui <ray.huang@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jul 29, 2020 at 7:18 PM Logan Gunthorpe <logang@deltatee.com> wrote=
:
>
> In order to avoid needing to add every new AMD CPU host bridge to the lis=
t
> every cycle, allow P2PDMA if the CPUs vendor is AMD and family is
> greater than 0x17 (Zen).

Might want to say "greater than or equal to" to clarify that all Zen
parts (Zen1, Zen2, etc.) support p2p.  With that clarified,
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

>
> This should cut down a bunch of the churn adding to the list of allowed
> host bridges.
>
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Alex Deucher <alexdeucher@gmail.com>
> Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> Cc: Huang Rui <ray.huang@amd.com>
>
> ---
>
> Here's a reworked patch to enable P2PDMA on Zen2 (and in fact all
> subsequent Zen platforms).
>
> This should remove all the churn on the list for the AMD side. Still
> don't have a good solution for Intel.
>
>  drivers/pci/p2pdma.c | 26 ++++++++++++++++++++------
>  1 file changed, 20 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
> index e8e444eeb1cd..f1cab2c50595 100644
> --- a/drivers/pci/p2pdma.c
> +++ b/drivers/pci/p2pdma.c
> @@ -273,6 +273,24 @@ static void seq_buf_print_bus_devfn(struct seq_buf *=
buf, struct pci_dev *pdev)
>         seq_buf_printf(buf, "%s;", pci_name(pdev));
>  }
>
> +#ifdef CONFIG_X86
> +static bool cpu_supports_p2pdma(void)
> +{
> +       struct cpuinfo_x86 *c =3D &cpu_data(0);
> +
> +       /* Any AMD CPU who's family id is newer than Zen will support p2p=
dma */
> +       if (c->x86_vendor =3D=3D X86_VENDOR_AMD && c->x86 >=3D 0x17)
> +               return true;
> +
> +       return false;
> +}
> +#else
> +static bool cpu_supports_p2pdma(void)
> +{
> +       return false;
> +}
> +#endif
> +
>  static const struct pci_p2pdma_whitelist_entry {
>         unsigned short vendor;
>         unsigned short device;
> @@ -280,11 +298,6 @@ static const struct pci_p2pdma_whitelist_entry {
>                 REQ_SAME_HOST_BRIDGE    =3D 1 << 0,
>         } flags;
>  } pci_p2pdma_whitelist[] =3D {
> -       /* AMD ZEN */
> -       {PCI_VENDOR_ID_AMD,     0x1450, 0},
> -       {PCI_VENDOR_ID_AMD,     0x15d0, 0},
> -       {PCI_VENDOR_ID_AMD,     0x1630, 0},
> -
>         /* Intel Xeon E5/Core i7 */
>         {PCI_VENDOR_ID_INTEL,   0x3c00, REQ_SAME_HOST_BRIDGE},
>         {PCI_VENDOR_ID_INTEL,   0x3c01, REQ_SAME_HOST_BRIDGE},
> @@ -473,7 +486,8 @@ upstream_bridge_distance(struct pci_dev *provider, st=
ruct pci_dev *client,
>                                               acs_redirects, acs_list);
>
>         if (map_type =3D=3D PCI_P2PDMA_MAP_THRU_HOST_BRIDGE) {
> -               if (!host_bridge_whitelist(provider, client))
> +               if (!cpu_supports_p2pdma() &&
> +                   !host_bridge_whitelist(provider, client))
>                         map_type =3D PCI_P2PDMA_MAP_NOT_SUPPORTED;
>         }
>
>
> base-commit: 92ed301919932f777713b9172e525674157e983d
> --
> 2.20.1
