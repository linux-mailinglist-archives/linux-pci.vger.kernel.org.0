Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2E48EF8D21
	for <lists+linux-pci@lfdr.de>; Tue, 12 Nov 2019 11:46:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725985AbfKLKqy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 12 Nov 2019 05:46:54 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:37301 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725919AbfKLKqy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 12 Nov 2019 05:46:54 -0500
Received: by mail-ot1-f66.google.com with SMTP id d5so13909871otp.4;
        Tue, 12 Nov 2019 02:46:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BBiHDfiJB71UjKKzdHPnlJfeyDu5lw8T/M/KozzrsHo=;
        b=ck46N+g2B7wnQVxCaZo2GVJzCnojAPgjALCxHimf0j/767RYwgp/OPMiZSQVrRCDTO
         rU31lO7vW3aC9rrQfgSXM9CBeP4nvEJ7Ca0ehRmuycYx2juel9gFLun7DtATrWzVAHLS
         DAVMwo3aNL35CL4gfJWOoU47tDMjT3+QrR/d/i726vpVaJNl58QSLzVccFSM28fEQZZw
         uw79ViqM2+dF7WJ/F77ewrm0TeXlGcSqI8/qNsH6UUcMoiF7CMKUwTC9PpgNW4gg9mNh
         OUAXzv4DYw21Uj1b95WusUwOWWLnbpWyWHx5rXhjC1EXD0kUwojwJ/nay3Pvpw3k7Y2r
         y8lA==
X-Gm-Message-State: APjAAAUS6Pc3IId90tm5oE1f/IeAoSKS/VYleqChoBUzhy4Q9kJ/VwVZ
        r/ZFd+SVpVDOBkExcS7qNz+oDMkOEwLnf8Jf3ChLFiiS
X-Google-Smtp-Source: APXvYqxAkRsZekTWZpsa/lqKw7mUpp+j4Jp+QTEOKhYDdkjltlUA/5WfK8Q7erMOYfib4QmGgF+leXDvj9e2NlGPFHg=
X-Received: by 2002:a05:6830:2363:: with SMTP id r3mr25637169oth.39.1573555613186;
 Tue, 12 Nov 2019 02:46:53 -0800 (PST)
MIME-Version: 1.0
References: <1572951089-19956-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <1572951089-19956-3-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <20191111144236.GB9653@e121166-lin.cambridge.arm.com> <TYAPR01MB4544F0F0BCAC5116731D15A9D8770@TYAPR01MB4544.jpnprd01.prod.outlook.com>
 <20191112102706.GA12685@e121166-lin.cambridge.arm.com>
In-Reply-To: <20191112102706.GA12685@e121166-lin.cambridge.arm.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 12 Nov 2019 11:46:42 +0100
Message-ID: <CAMuHMdXBJaL=c+9_kb70jHMqzvfxxYezLEX-Evh-FRyY-FYPyQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] PCI: rcar: Fix missing MACCTLR register setting in
 initialize sequence
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        "marek.vasut+renesas@gmail.com" <marek.vasut+renesas@gmail.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Lorenzo,

On Tue, Nov 12, 2019 at 11:27 AM Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
> On Tue, Nov 12, 2019 at 01:48:03AM +0000, Yoshihiro Shimoda wrote:
> > I'm sorry. I think I should not drop a sentence "because the bit 0 is
> > set to 1 on reset" which has the reverted patch from this version. Also,
> > the note seems to be difficult to understand. So, I'll rewrite this log
> > like below. Is it acceptable?
> >
> > ---
> > According to the R-Car Gen2/3 manual,
>
> Is this a publicly available manual ? If yes we provide a link, if
> not I will reword the sentence below.

The same hardware block is present in the RZ/G series, and documented
in RZ/G Series User's Manual: Hardware
https://www.renesas.com/eu/en/products/microcontrollers-microprocessors/rz/rzg/rzg1m.html#documents
Chapter 39 ("PCIEC").
Section 39.28.98 ("MAC Control Register (MACCTLR)")
Section 39.3.1 ("Initialization"), Paragraph 3 ("Initial Setting of
PCI Express").

Thanks, and happy digesting ;-)

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
