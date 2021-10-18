Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75FB1431860
	for <lists+linux-pci@lfdr.de>; Mon, 18 Oct 2021 14:00:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231408AbhJRMDH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 18 Oct 2021 08:03:07 -0400
Received: from mail-ua1-f48.google.com ([209.85.222.48]:38667 "EHLO
        mail-ua1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229781AbhJRMDG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 18 Oct 2021 08:03:06 -0400
Received: by mail-ua1-f48.google.com with SMTP id h19so1338642uax.5;
        Mon, 18 Oct 2021 05:00:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ugxvHlyhTx50acGfMe/mBaSIaa61RPwcWtMFE4GIscE=;
        b=bfRrL+TT5fmZo9pkcjzKK5yBNCMErvsBKVqz0FXGHZ0SOtAmzudb5ULoBYQEw4fooA
         vlTOAB0N1N+g41t309WUBYirwVwDzj1MRGJqD8MH/HdspmhQ2W2bcGahL7JIfUS9pwk4
         pUSDKcUKK5NjZMUKiP2XNYSEodrfFd43IS+ARlYahXgrkV9RUVwOsI8QrKZHS2HB9ybc
         GIY4Ck429aB28LQ+NvtDKignebNT4+lUharV60OdgdF5CMRVE6xObJ6zyFRB8JNDr/x4
         YUTApWrvBxZuPaAdNV6QQ341AYIWMRxeJw1uVwPThoaUMEpOS6BRqXTju9fmXjmq06ZR
         WJ6Q==
X-Gm-Message-State: AOAM533j6U0KCLuDUndoLfnyagUB2ZDVeFRZd/utnRJ89S6b7Uu65KHv
        HJDJCXVB9kYeYLdeKvreWL4gcgM1c9JHzA==
X-Google-Smtp-Source: ABdhPJxZj6oTviogUpxy2XG9HDxo278AeoyYwykpTNMh31ZNZHC3751eCp97gONrTSh8lMpEy/BRVA==
X-Received: by 2002:a67:f70a:: with SMTP id m10mr26722758vso.40.1634558454897;
        Mon, 18 Oct 2021 05:00:54 -0700 (PDT)
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com. [209.85.222.49])
        by smtp.gmail.com with ESMTPSA id o40sm7954384vkf.3.2021.10.18.05.00.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Oct 2021 05:00:54 -0700 (PDT)
Received: by mail-ua1-f49.google.com with SMTP id q13so3137848uaq.2;
        Mon, 18 Oct 2021 05:00:54 -0700 (PDT)
X-Received: by 2002:ab0:3d9a:: with SMTP id l26mr893052uac.114.1634558453426;
 Mon, 18 Oct 2021 05:00:53 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1634306198.git.naveennaidu479@gmail.com>
 <2544a93bf8725eecbea510e7ddbff6b5a5593c84.1634306198.git.naveennaidu479@gmail.com>
 <CAMuHMdVh79gvAZn+nBeWWtkJqvUb3woi1rRY=BkY+bc4YXFj1Q@mail.gmail.com> <20211018115148.iwhiknpd6o4okudq@theprophet>
In-Reply-To: <20211018115148.iwhiknpd6o4okudq@theprophet>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 18 Oct 2021 14:00:41 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXYhUThELrmTTwFyJbLEqcJE3sQyYmWZhb=5T-rYmQ+=w@mail.gmail.com>
Message-ID: <CAMuHMdXYhUThELrmTTwFyJbLEqcJE3sQyYmWZhb=5T-rYmQ+=w@mail.gmail.com>
Subject: Re: [PATCH v2 14/24] PCI: rcar: Remove redundant error fabrication
 when device read fails
To:     Naveen Naidu <naveennaidu479@gmail.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-pci <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        "open list:PCI DRIVER FOR RENESAS R-CAR" 
        <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Naveen,

On Mon, Oct 18, 2021 at 1:52 PM Naveen Naidu <naveennaidu479@gmail.com> wrote:
> On 18/10, Geert Uytterhoeven wrote:
> > On Sat, Oct 16, 2021 at 5:33 PM Naveen Naidu <naveennaidu479@gmail.com> wrote:
> > > An MMIO read from a PCI device that doesn't exist or doesn't respond
> > > causes a PCI error. There's no real data to return to satisfy the
> > > CPU read, so most hardware fabricates ~0 data.
> > >
> > > The host controller drivers sets the error response values (~0) and
> > > returns an error when faulty hardware read occurs. But the error
> > > response value (~0) is already being set in PCI_OP_READ and
> > > PCI_USER_READ_CONFIG whenever a read by host controller driver fails.
> > >
> > > Thus, it's no longer necessary for the host controller drivers to
> > > fabricate any error response.
> > >
> > > This helps unify PCI error response checking and make error check
> > > consistent and easier to find.
> > >
> > > Signed-off-by: Naveen Naidu <naveennaidu479@gmail.com>
> >
> > Thanks for your patch!
> >
> > > --- a/drivers/pci/controller/pcie-rcar-host.c
> > > +++ b/drivers/pci/controller/pcie-rcar-host.c
> > > @@ -161,10 +161,8 @@ static int rcar_pcie_read_conf(struct pci_bus *bus, unsigned int devfn,
> > >
> > >         ret = rcar_pcie_config_access(host, RCAR_PCI_ACCESS_READ,
> > >                                       bus, devfn, where, val);
> > > -       if (ret != PCIBIOS_SUCCESSFUL) {
> > > -               *val = 0xffffffff;
> >
> > I don't see the behavior you describe in PCI_OP_READ(), so dropping
> > this will lead to returning an uninitialized value?
> >
>
> Hello Geert,
>
> Thank you for looking into the patch.
>
> The described behaviour for PCI_OP_READ is part of the 01/24 [1] patch of
> the series.
>
> [1]:
> https://lore.kernel.org/linux-pci/b913b4966938b7cad8c049dc34093e6c4b2fae68.1634306198.git.naveennaidu479@gmail.com/T/#u

OK, in that case:
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

> It looks like, I did not add proper receipients for that patch and hence
> is leading to confusion. I really apologize for that.

Indeed. If there are dependencies, all recipients should receive all
dependencies.

> I do not know what the right approach here should be, should I resend
> the entire patch series, adding proper receipients OR should I reply to
> each of the patches for the drivers and add the link to the patch. I did
> not want to spam people with a lot of mails so I was confused as to what
> the right option is.

Probably a resend would be best.
Thanks!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
