Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ABA2FDAAD3
	for <lists+linux-pci@lfdr.de>; Thu, 17 Oct 2019 13:06:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393881AbfJQLGr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 17 Oct 2019 07:06:47 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:46786 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393490AbfJQLGr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 17 Oct 2019 07:06:47 -0400
Received: by mail-oi1-f193.google.com with SMTP id k25so1741318oiw.13;
        Thu, 17 Oct 2019 04:06:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xq264avdxFHk508cQem+mTXa9WclaBEHw7v8NarZq3Q=;
        b=Gc7lH4G83H7kITQOUn1I78qIOgloP8jA41Q2/h79pBcjw1VUx/0vq9KB7upMkd8rgz
         VYJE3AaAEFTQpBquc7VRpdGiSG33JHZSBTMA1Jc1kfv+5HPnoHd8MFGDKufbobnkTHc9
         JRdFEn/FthBPQxdgy7JNxSK+kq4HpyytOD+P00uJb0mWYWKZGLFHaB9bulifGddcuThf
         ltW2mG9UmbRmtq2nLNoNXXSMyFxh9dn8OzJdzsrTSHULG1Mk8SMercygAGhhRBFQKaf9
         is+Z+ui1TJnE+ukcKJP9MWZchVp+9G73AUf5e5ni1dG1rHELjduYaE7YXqvHNseGcj9M
         SBVA==
X-Gm-Message-State: APjAAAXg+MLMLoPeohteMx/ywjTsY9vy8xODlRWCGEymQ+/unDmLyC4W
        BeRF39FaHDG9eCJ2+sj+6NqkuQI63LfL6R1ykBI=
X-Google-Smtp-Source: APXvYqz8y41KYtwlkdo9YrxBXVwP9aJ3YeZEdb8/duG6c89kECObquyBVAr/FSo6o/8tUyTB7O0AYf5Yc8ymFWCtqfA=
X-Received: by 2002:aca:882:: with SMTP id 124mr2730019oii.54.1571310406345;
 Thu, 17 Oct 2019 04:06:46 -0700 (PDT)
MIME-Version: 1.0
References: <20191016120249.16776-1-horms@verge.net.au> <20191017104616.GD9589@e121166-lin.cambridge.arm.com>
In-Reply-To: <20191017104616.GD9589@e121166-lin.cambridge.arm.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 17 Oct 2019 13:06:34 +0200
Message-ID: <CAMuHMdUxGpfQi3mfxqr5s6vCRaL3qzrRtEVDMz0v7Cm6nmUDHg@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Add Marek and Shimoda-san as R-Car PCIE co-maintainers
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Simon Horman <horms@verge.net.au>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Lorenzo,

On Thu, Oct 17, 2019 at 12:46 PM Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
> On Wed, Oct 16, 2019 at 02:02:49PM +0200, Simon Horman wrote:
> > At the end of the v5.3 upstream development cycle I stepped down
> > from my role at Renesas.
> >
> > Pass maintainership of the R-Car PCIE to Marek and Shimoda-san.
> >
> > Signed-off-by: Simon Horman <horms@verge.net.au>
> > ---
> >  MAINTAINERS | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
>
> Hi Geert,
>
> are you picking this up or I should pick it up ?
>
> Either way is fine by me.

Please pick it up, as you are a drivers/pci/controller/ maintainer.

Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
