Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66EE42830E2
	for <lists+linux-pci@lfdr.de>; Mon,  5 Oct 2020 09:32:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725873AbgJEHcH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 5 Oct 2020 03:32:07 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:43694 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725870AbgJEHcG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 5 Oct 2020 03:32:06 -0400
Received: by mail-ot1-f66.google.com with SMTP id n61so7677137ota.10;
        Mon, 05 Oct 2020 00:32:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MaU2ZX/ajt++VmCUpBC5H+VU47dkPeXnhuE9jFmL5V4=;
        b=kB64USU1MlGCwMODHs6g5+w0Z8Iw8pRWUH3QMP/OxNxqOT5dnaC8Ci9AtyR7AW2vc4
         Fh4YDvSCxvAj08KBWIqAKGwBKjXDaBJLngkgLRIgLI98FA1v17tCyWorb/lJempyxWGo
         YUieajUPtwFyVtSxH97rDOXSNXYJJ3Lq+6Ts8EGX4aJN2PGRqDZJKiZ2J1goznBxYx5I
         ju+IfVoptvz7VvVzotj0Eyp/KLJ4042Gi+oHiijdougUS4kVLB/I4CgjPdwNOyfSV0bz
         8aUyxz6jEKC5J/YMmiWP/k2CYHvd5Gv4yQgeJF+UsZ1xwVX4h9CxvChfLGYAdBeftZ+r
         Ux/Q==
X-Gm-Message-State: AOAM530rJNhGlbtQ/oU2yCS1yQxoH77fuFyatJ28Ut4U0vgT5ovCnCuF
        TFio+scDq7I4oY0C9uzH6HLc1sed8YnHP5tbLnc=
X-Google-Smtp-Source: ABdhPJxC2zyGtmbS9o9N9MD5jzjDHOANV2CcE7HKk/bBLdd02gO4cQ83JSgp9nBpe7wnB6Pq/e6JL/lZ52xnVuGTirU=
X-Received: by 2002:a05:6830:1008:: with SMTP id a8mr10030680otp.107.1601883125603;
 Mon, 05 Oct 2020 00:32:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200926160934.136182-1-marek.vasut@gmail.com>
 <CAMuHMdURuSsYRwi10FT+s-rVjok0f-FgS6G8rmpg46u98scMkQ@mail.gmail.com> <1431d12a-0e19-6795-b2e0-fb652f8a95c1@gmail.com>
In-Reply-To: <1431d12a-0e19-6795-b2e0-fb652f8a95c1@gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 5 Oct 2020 09:31:54 +0200
Message-ID: <CAMuHMdWtj=c=y7a2+W10HgYNj3rh2P6nSDd-j4RKKuUiztCxjA@mail.gmail.com>
Subject: Re: [PATCH V2] PCI: rcar: Add L1 link state fix into data abort hook
To:     Marek Vasut <marek.vasut@gmail.com>
Cc:     linux-pci <linux-pci@vger.kernel.org>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Marek,

On Sun, Oct 4, 2020 at 4:16 PM Marek Vasut <marek.vasut@gmail.com> wrote:
> On 9/28/20 11:35 AM, Geert Uytterhoeven wrote:
> [...]
> >> +static int __init rcar_pcie_init(void)
> >> +{
> >> +#ifdef CONFIG_ARM_LPAE
> >> +       hook_fault_code(17, rcar_pcie_aarch32_abort_handler, SIGBUS, 0,
> >> +                       "asynchronous external abort");
> >> +#else
> >> +       hook_fault_code(22, rcar_pcie_aarch32_abort_handler, SIGBUS, 0,
> >> +                       "imprecise external abort");
> >> +#endif
> >
> > As there can be only a single handler, this may interfere with a handler
> > for another platform in a multi-platform kernel.
> > Hence I think this should not be done unconditionally, but be moved to
> > the driver's .probe() callback.
>
> Why is nobody doing this in the probe code then ? It seems all the other

drivers/pci/controller/dwc/pci-keystone.c is:

  ks_pcie_probe()
    ks_pcie_add_pcie_port()
      dw_pcie_host_init()
        pp->ops->host_init(pp) = ks_pcie_host_init()
          hook_fault_code()

> drivers which hook fault code do it in init as well. I can imagine that

Probably nobody bothered exercising the external abort handler on
multi-platform kernels?

> something might trip the fault handler even before probe is called, e.g.
> some PM handling or simply user accessing that PCIe area using setpci.

If that is the case, it must indeed by done earlier, but still
conditional on the presence of the actual PCIe controller.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
