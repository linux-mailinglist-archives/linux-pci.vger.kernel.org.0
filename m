Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B34922207E7
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jul 2020 10:56:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729661AbgGOI4D (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 15 Jul 2020 04:56:03 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:39629 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727930AbgGOI4D (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 15 Jul 2020 04:56:03 -0400
Received: by mail-ot1-f66.google.com with SMTP id 18so884962otv.6;
        Wed, 15 Jul 2020 01:56:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pUzyHQ0QkLs25JZWLaLC5T7qg8r9CRBwSMhggfLS03U=;
        b=F0msI4DhiaesSq06+XqI5Cd3K+Gmr/JG2kAIYof0Hjh0ztlhRZAZ8ZlS3nkFDDv+11
         jaS0Dk1PeOZULDs0JuZdpw0UsD2H3aC9TdyPfCs+3OGjXAbyUz9SJjfG1yf3vLdVN7FD
         uUvMxoMfmK93K88WCwcfifaECYdiNcwPc6EjitbCQdr2clB6BSh3vZ2ErLEtmqRWx8Iz
         GRwkox34AKt8IxBzHMDvVh7w19JhvTyxZlRgdfPoB39DtpbL5G/ldAejRVN/cXOieQjH
         cEmSokI3L8tyBvtB+QgoYDyZCZDJyJulh2nWr4WcBhUPUG03187jRi/fQv13Cw/yGjBl
         /dkw==
X-Gm-Message-State: AOAM533YcLu39KJiTJuDIcO+6+BFSg7Nv2Mt9aSck1cBKo6Y2yP9JMpl
        JHSRIab8fhVCfjZyixweldDvxx4ybFt8rhhQ9vg=
X-Google-Smtp-Source: ABdhPJw5bZ7qOaFwu5zExmR40PIX8CrhARWaK01y6ERKzbRsz+v0atbN2sIAtwmhmlbN3+liuSgfpIlAQr7C3GELSZA=
X-Received: by 2002:a05:6830:1451:: with SMTP id w17mr7835345otp.250.1594803362475;
 Wed, 15 Jul 2020 01:56:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200714185622.GA408711@bjorn-Precision-5520> <a18d4e1e-2ecb-21dc-2547-fa7529e76edd@solarflare.com>
In-Reply-To: <a18d4e1e-2ecb-21dc-2547-fa7529e76edd@solarflare.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 15 Jul 2020 10:55:51 +0200
Message-ID: <CAMuHMdVDha=xAAHjKma4pm1bgNt=go0HgUMyCrc3H87cF0f5SA@mail.gmail.com>
Subject: Re: [renesas-drivers:master 69/80] drivers/net/ethernet/sfc/efx_common.c:1232:19:
 sparse: sparse: incompatible types for operation (==):
To:     Edward Cree <ecree@solarflare.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, kbuild-all@lists.01.org,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        linux-pci <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Edward.

On Wed, Jul 15, 2020 at 10:48 AM Edward Cree <ecree@solarflare.com> wrote:
> On 14/07/2020 19:56, Bjorn Helgaas wrote:
> > [+cc Luc, linux-pci]
> >
> > I think what's necessary here is to replace "enum pci_channel_state
> > state" with "pci_channel_state_t state", as in 16d79cd4e23b ("PCI: Use
> > 'pci_channel_state_t' instead of 'enum pci_channel_state'"):
> >
> > https://git.kernel.org/cgit/linux/kernel/git/helgaas/pci.git/commit/?id=16d79cd4e23b
> >
> > This change should be safe even without 16d79cd4e23b, so there won't
> > be a revlock if you make it in the renesas-drivers tree.
> This is presumably goingto happen in any tree that pulls both net-next
>  and pci/next.  So shouldn't we make the change in net-next, rather than
>  in a renesas tree that really has little to do with it other than being
>  the first place the problem showed up?

Indeed, it should be fixed at the core, not in an integration testing tree.
BTW, did it show up in linux-next, too, or have I done a bad merge conflict
resolution?

Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
