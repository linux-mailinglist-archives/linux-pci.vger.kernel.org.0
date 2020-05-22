Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CFE21DED97
	for <lists+linux-pci@lfdr.de>; Fri, 22 May 2020 18:45:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730419AbgEVQpe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 22 May 2020 12:45:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:57702 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730306AbgEVQpe (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 22 May 2020 12:45:34 -0400
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BFD09206B6;
        Fri, 22 May 2020 16:45:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590165933;
        bh=gWcAx6dytA0EAxqcY3HTX1YnP6kIv4ty1exXdCROqww=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=tGki03yjNbya2Lh/bCN9h0iri/nzH+Vq4KqH3d9PtZz1S0Agw4aarziU175F+WuYY
         gI+uyvvHJRZg/Yw410lxNK6x004ZGodzg1huJUcmElYKAaTxMIy+T6DRQANn0wZluY
         LqHXKHCeIKAn7ZWwsLaqgyF096FGeQWKEXA9fu9Y=
Received: by mail-oi1-f169.google.com with SMTP id j145so9857345oib.5;
        Fri, 22 May 2020 09:45:33 -0700 (PDT)
X-Gm-Message-State: AOAM531FQQtpE+G40OhFVWJ5pJsZi/rIKToLXpTlcnI4xUBgB2RUqUvY
        2yA89eQQzyRtEdQKnIdD83ijaT7ENAW/ysJHlg==
X-Google-Smtp-Source: ABdhPJyOIimoTTwn+DzTuswuMPzoMXeeAcfiCDmfEtU2Ls/bR0MREniW3isAwKRLWPh6rvnW8cASk2bhta+/P+05dzU=
X-Received: by 2002:aca:f084:: with SMTP id o126mr3346182oih.106.1590165933079;
 Fri, 22 May 2020 09:45:33 -0700 (PDT)
MIME-Version: 1.0
References: <20200506151429.12255-1-kishon@ti.com> <20200506151429.12255-8-kishon@ti.com>
 <20200520213434.GA583923@bogus> <3f9cf6e5-94f8-4c54-aaee-c181b0e79f1f@ti.com>
In-Reply-To: <3f9cf6e5-94f8-4c54-aaee-c181b0e79f1f@ti.com>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 22 May 2020 10:45:21 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+qcgKvauJ-GjsnmmpmRusyEJ6pRDpBOQKOadig4XfsxQ@mail.gmail.com>
Message-ID: <CAL_Jsq+qcgKvauJ-GjsnmmpmRusyEJ6pRDpBOQKOadig4XfsxQ@mail.gmail.com>
Subject: Re: [PATCH v4 07/14] PCI: cadence: Add new *ops* for CPU addr fixup
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Tom Joseph <tjoseph@cadence.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        PCI <linux-pci@vger.kernel.org>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-omap <linux-omap@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, May 21, 2020 at 5:35 AM Kishon Vijay Abraham I <kishon@ti.com> wrote:
>
> Hi Rob,
>
> On 5/21/2020 3:04 AM, Rob Herring wrote:
> > On Wed, May 06, 2020 at 08:44:22PM +0530, Kishon Vijay Abraham I wrote:
> >> Cadence driver uses "mem" memory resource to obtain the offset of
> >> configuration space address region, memory space address region and
> >> message space address region. The obtained offset is used to program
> >> the Address Translation Unit (ATU). However certain platforms like TI's
> >> J721E SoC require the absolute address to be programmed in the ATU and not
> >> just the offset.
> >
> > Once again, Cadence host binding is broken (or at least the example is).
> > The 'mem' region shouldn't even exist. It is overlapping the config
> > space and 'ranges':
> >
> >             reg = <0x0 0xfb000000  0x0 0x01000000>,
> >                   <0x0 0x41000000  0x0 0x00001000>,
> >                   <0x0 0x40000000  0x0 0x04000000>;
> >             reg-names = "reg", "cfg", "mem";
> >
> >             ranges = <0x02000000 0x0 0x42000000  0x0 0x42000000  0x0 0x1000000>,
> >                      <0x01000000 0x0 0x43000000  0x0 0x43000000  0x0 0x0010000>;
> >
> >
> > 16M of registers looks a bit odd. I guess it doesn't matter
> > unless you have a 32-bit platform and care about your virtual
> > space. Probably should have been 3 regions for LM, RP, and AT looking
> > at the driver.
>
> The "mem" region in never ioremapped. However $patch removes requiring to add
> "mem" memory resource.

I was referring to ioremapping 'reg' region.

> >
> > Whatever outbound address translation you need should be based on
> > 'ranges'.
>
> You mean we don't need to add "new *ops* for CPU addr fixup"?. The issue is
> ranges provides CPU address and PCI address. The CPU will access whatever is
> populated in ranges to access the PCI bus. However while programming the ATU,
> we cannot use the CPU address provided in ranges directly (in some platforms)
> because the controller does not see the full address and only the lower 28bits.

Okay, that is clearer as to what the difference is. I think this
should be 2 patches. One dropping 'mem' usage and using a mask and the
2nd making the mask per platform.

Really, the parent node of the PCI controller should probably have
'ranges' and you could extract a mask from that. Looks like that is
what you had for DRA7... I'm not sure if ABI stability is important
for the Cadence platform. I'd assume that's just some IP eval system
and probably not?

Why do you need an ops here? All you need is a mask value.

> This similar restriction was there with Designware (mostly an integration
> issue) and we used *ops* to fixup the address that has to be programmed in ATU.
> The Designware initially used a wrapper so that ranges property can be directly
> used [1]. However this approach was later removed in [2]
>
> [1] -> https://lore.kernel.org/patchwork/patch/468523/
> [2] -> https://lkml.org/lkml/2015/10/16/232

So while you had the data for a mask in DT, the driver now hardcodes it?

Rob
