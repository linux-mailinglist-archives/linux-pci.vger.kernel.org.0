Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B5AD43182B
	for <lists+linux-pci@lfdr.de>; Mon, 18 Oct 2021 13:52:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230515AbhJRLyY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 18 Oct 2021 07:54:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbhJRLyX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 18 Oct 2021 07:54:23 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AFF8C06161C;
        Mon, 18 Oct 2021 04:52:12 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id k26so14529856pfi.5;
        Mon, 18 Oct 2021 04:52:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=uRAY4X8owdY8nPICo6sM8mmRScQ57odxEdrE5BZO3fg=;
        b=lLW/sx9seF41ns6WqHqVgRo4ZIDaXamsZ+4e3CxEEI4Zzu6ej9A6NL0VFlxASZR37P
         pFABjVc76JTsA1lvjm6YgbvdMzD4cP5s5sucJcyqlc3qSS1IM3v20f6DfShDmdaqOcON
         BdzOgG0nUGA+XmA9qY5xk8mxkybUk8w21dprzQ9acSm72Yq8LeUO2DPhgo0YhkRYRh9t
         egt8GFz0s0i47ZeUQOpD+aPgn0SL5JIOo6Mi9yMkahq1cFS2gFPt+VF1eOXkJKJcJPfV
         sSx5WymcT0ty40x83D3Z8T2OwiTzWmuSO6RfUO78MpqoCOKp1YBvzb0v/fMHFu4BHXz+
         OO/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uRAY4X8owdY8nPICo6sM8mmRScQ57odxEdrE5BZO3fg=;
        b=AK5cJZ9tAeoG7sXt0xCQyE+e9lnS9tlc6+EbLH1EZFnCfN+xd5fc0i+jl6XYLbetHa
         dJUszlIid6Gu3kB96pcPK13aWQv7117Zw6suNczj9I+Bm1/jGY/ICoFi5XWqC/5+JYZG
         bO/2K5qq+DSZZSMJzL6rfGkCJg+zN45hfOdN3rV4Mns2WjfiPV7GDAPYdy7UOrLC1+v0
         0QMRqGzMudqk036VknCQvI9FRr9Yg++1pBaqsfKOuQk5Ll9JWHUk1L6Hm9N6dkEyl/C8
         IdeHl8n/h69A1MrerhWTByGwHb/Ko57zFT/q+/FkzPXK+V2EFR57fnajpXZzsuyIaK2T
         ZJug==
X-Gm-Message-State: AOAM530tYKdRD5+Y4+YAsP3MkLA0RtE95SQLZlawHPzWgNPUzqH6BW9p
        iSszPkhA3BYNzgUm+UPdsx0=
X-Google-Smtp-Source: ABdhPJxtvO8Bq4YHHd6MoeEGykVU5WbXUmVMDCgGnwY4ZJm9lm+MyUAhrP7H1Nm5UUhNPn+8CHQX3Q==
X-Received: by 2002:a63:ed13:: with SMTP id d19mr23042349pgi.430.1634557932111;
        Mon, 18 Oct 2021 04:52:12 -0700 (PDT)
Received: from theprophet ([2406:7400:63:eae8:5466:4cd4:63af:c661])
        by smtp.gmail.com with ESMTPSA id m22sm13297924pfo.176.2021.10.18.04.52.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Oct 2021 04:52:11 -0700 (PDT)
Date:   Mon, 18 Oct 2021 17:21:48 +0530
From:   Naveen Naidu <naveennaidu479@gmail.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-pci <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        "open list:PCI DRIVER FOR RENESAS R-CAR" 
        <linux-renesas-soc@vger.kernel.org>
Subject: Re: [PATCH v2 14/24] PCI: rcar: Remove redundant error fabrication
 when device read fails
Message-ID: <20211018115148.iwhiknpd6o4okudq@theprophet>
References: <cover.1634306198.git.naveennaidu479@gmail.com>
 <2544a93bf8725eecbea510e7ddbff6b5a5593c84.1634306198.git.naveennaidu479@gmail.com>
 <CAMuHMdVh79gvAZn+nBeWWtkJqvUb3woi1rRY=BkY+bc4YXFj1Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdVh79gvAZn+nBeWWtkJqvUb3woi1rRY=BkY+bc4YXFj1Q@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 18/10, Geert Uytterhoeven wrote:
> Hi Naveen,
> 
> On Sat, Oct 16, 2021 at 5:33 PM Naveen Naidu <naveennaidu479@gmail.com> wrote:
> > An MMIO read from a PCI device that doesn't exist or doesn't respond
> > causes a PCI error. There's no real data to return to satisfy the
> > CPU read, so most hardware fabricates ~0 data.
> >
> > The host controller drivers sets the error response values (~0) and
> > returns an error when faulty hardware read occurs. But the error
> > response value (~0) is already being set in PCI_OP_READ and
> > PCI_USER_READ_CONFIG whenever a read by host controller driver fails.
> >
> > Thus, it's no longer necessary for the host controller drivers to
> > fabricate any error response.
> >
> > This helps unify PCI error response checking and make error check
> > consistent and easier to find.
> >
> > Signed-off-by: Naveen Naidu <naveennaidu479@gmail.com>
> 
> Thanks for your patch!
> 
> > --- a/drivers/pci/controller/pcie-rcar-host.c
> > +++ b/drivers/pci/controller/pcie-rcar-host.c
> > @@ -161,10 +161,8 @@ static int rcar_pcie_read_conf(struct pci_bus *bus, unsigned int devfn,
> >
> >         ret = rcar_pcie_config_access(host, RCAR_PCI_ACCESS_READ,
> >                                       bus, devfn, where, val);
> > -       if (ret != PCIBIOS_SUCCESSFUL) {
> > -               *val = 0xffffffff;
> 
> I don't see the behavior you describe in PCI_OP_READ(), so dropping
> this will lead to returning an uninitialized value?
>

Hello Geert,

Thank you for looking into the patch.

The described behaviour for PCI_OP_READ is part of the 01/24 [1] patch of
the series. 

[1]:
https://lore.kernel.org/linux-pci/b913b4966938b7cad8c049dc34093e6c4b2fae68.1634306198.git.naveennaidu479@gmail.com/T/#u

It looks like, I did not add proper receipients for that patch and hence
is leading to confusion. I really apologize for that.

I do not know what the right approach here should be, should I resend
the entire patch series, adding proper receipients OR should I reply to
each of the patches for the drivers and add the link to the patch. I did
not want to spam people with a lot of mails so I was confused as to what
the right option is.

Thanks,
Naveen

> > +       if (ret != PCIBIOS_SUCCESSFUL)
> >                 return ret;
> > -       }
> >
> >         if (size == 1)
> >                 *val = (*val >> (BITS_PER_BYTE * (where & 3))) & 0xff;
> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds
