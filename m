Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9254453955
	for <lists+linux-pci@lfdr.de>; Tue, 16 Nov 2021 19:20:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238924AbhKPSXe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 16 Nov 2021 13:23:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:37236 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236659AbhKPSXd (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 16 Nov 2021 13:23:33 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 994CC63231;
        Tue, 16 Nov 2021 18:20:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637086836;
        bh=zQ23lBUVqtQtYQ5TID6YCdJ8tlFXhml1gZkaxzR+gvc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=o04ZzvwRCLZoSDgGGOfWQNXo0akTSCu8K4C4Y9NVIxqlZi2uFEhvIA/T9J2M1HAYt
         FRuj7wosu6Obiv4Yas7GmhZWZ4FjJPPewu9lGx6a9vk+9uug4YbbHEA/590ne0PozT
         SXh2P+3ML2h7SY1pMs1x0aU90Cvq6kd/qeaWqWIQoZIzy+6Fx4Q2Gn0ppbaQr52ETa
         wTS8Fn69qGaqNUQzNnR83DXkM4bzasQ/9dm/TMjGQVpGJKhEo7tQtfMDlE7ik75jsD
         s/GIYzWw+xAjg5sGDwazcVHrU8M9B26qIHA9w+/Y+AeflPIY3T9BZnPXx5nyn+lALx
         RKepEQirfDMwg==
Received: by mail-ed1-f50.google.com with SMTP id z5so31943437edd.3;
        Tue, 16 Nov 2021 10:20:36 -0800 (PST)
X-Gm-Message-State: AOAM530NNBuAUcVQhniKv8PJhisLCV9kJ7k1JbFsftTR0TFknAMLFdRx
        ja8PsiDua2YHKdyLpXTxcthRJRetjdSrnnhUHQ==
X-Google-Smtp-Source: ABdhPJwwDyer0PToNILufn0VRX0SlTOAApNbRDmf1a5oEpMFwAza7UOpzYSwetb2VCFA/vZX/ZYDpHNDiDRUK/48Y5Y=
X-Received: by 2002:a17:906:bccc:: with SMTP id lw12mr12270768ejb.128.1637086834835;
 Tue, 16 Nov 2021 10:20:34 -0800 (PST)
MIME-Version: 1.0
References: <20211115112000.23693-1-andriy.shevchenko@linux.intel.com>
 <94d3f4e5-a698-134c-8264-55d31d3eafa6@arm.com> <CAHp75VeJ8ZiD=qQVfeahUjGZduFRJJ5683hn8f4810JYEzsCyw@mail.gmail.com>
 <YZJxG7JFAfIqr1/f@smile.fi.intel.com>
In-Reply-To: <YZJxG7JFAfIqr1/f@smile.fi.intel.com>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 16 Nov 2021 12:20:22 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJndi-gmenSpPtMVfsb3SrA=w+YBsSh3GigfgXC3rYDeQ@mail.gmail.com>
Message-ID: <CAL_JsqJndi-gmenSpPtMVfsb3SrA=w+YBsSh3GigfgXC3rYDeQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] PCI: brcmstb: Use BIT() as __GENMASK() is for
 internal use only
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Marc Zyngier <maz@kernel.org>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        linux-rpi-kernel <linux-rpi-kernel@lists.infradead.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jim Quinlan <jim2101024@gmail.com>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

+Marc Z

On Mon, Nov 15, 2021 at 8:39 AM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Mon, Nov 15, 2021 at 04:14:21PM +0200, Andy Shevchenko wrote:
> > On Mon, Nov 15, 2021 at 4:01 PM Robin Murphy <robin.murphy@arm.com> wrote:
> > > On 2021-11-15 11:20, Andy Shevchenko wrote:
> > > > Use BIT() as __GENMASK() is for internal use only. The rationale
> > > > of switching to BIT() is to provide better generated code. The
> > > > GENMASK() against non-constant numbers may produce an ugly assembler
> > > > code. On contrary the BIT() is simply converted to corresponding shift
> > > > operation.
> > >
> > > FWIW, If you care about code quality and want the compiler to do the
> > > obvious thing, why not specify it as the obvious thing:
> > >
> > >         u32 val = ~0 << msi->legacy_shift;
> >
> > Obvious and buggy (from the C standard point of view)? :-)
>
> Forgot to mention that BIT() is also makes it easy to avoid such mistake.
>
> > > Personally I don't think that abusing BIT() in the context of setting
> > > multiple bits is any better than abusing __GENMASK()...
> >
> > No, BIT() is not abused here, but __GENMASK().
> >
> > After all it's up to you, folks, consider that as a bug report.

Couldn't we get rid of legacy_shift entirely if the legacy case sets
up 'hwirq' as 24-31 rather than 0-7? Though the data for the MSI msg
uses the hwirq.

Rob
