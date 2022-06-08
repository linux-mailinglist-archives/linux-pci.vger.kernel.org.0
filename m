Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E19B542C58
	for <lists+linux-pci@lfdr.de>; Wed,  8 Jun 2022 12:00:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235906AbiFHKAZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Jun 2022 06:00:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235787AbiFHJ7q (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 8 Jun 2022 05:59:46 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DE50D91
        for <linux-pci@vger.kernel.org>; Wed,  8 Jun 2022 02:34:34 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id a2so26187665lfg.5
        for <linux-pci@vger.kernel.org>; Wed, 08 Jun 2022 02:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=q5ETAdWf6QPFWjMgIXJwBxJQE1JQIFmmzZn0BSVKRIM=;
        b=WtkbIs6AikbpbG6Xu2Y5YUwGudBtgt7lgIu/WampS1/nMTbzPKeVPvykWVE/XOrdyK
         /58BeXUb+7Fzxy/IjhADh+4ng4C2yL22GNno2S0hH4UJyVJ/tgEfnTHuiSg3BkOJqbko
         WCjFEdJ959P0Yqe8a+25qtiwBlYqn7mL6tRAi0nH//nO8Br+r28fYUu8tR4Zd97YZzaj
         mNOWJiw63AH64yQCIQoRuJSpIE+LuaRWVe8NlS83U7nEdsmmezTkE9LzhsouO3vHRO6i
         NWeUaQX16fADUdtCy+rFNR820jPvqWuGmyEhdzM/W88rcnrypPn9SaT1LbtgFZdiMOFu
         l3UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=q5ETAdWf6QPFWjMgIXJwBxJQE1JQIFmmzZn0BSVKRIM=;
        b=YTQvuEQZejoKcq43qrGHgvhRR7iAFnYas+EgV2qy/6ctEtityJaVUauW4Dcp1DdamE
         XOl00CxbGPL1jC1X+5pVGkLLte+94tBRMmytY/5RDKergxBV/QsruTDOVnCJq7HLicLw
         fb4O/fAxUQAVcjAy2rc9q9jTYg2fbxowNhGq42bI5IpmcXDlms3NopfE9vhZ2cGEJfcO
         S+755T+Cq7PpzywTLkUn4senMWBxIcrD8v19GQbWSPsi5I9QE+7d7CDPXP/eBHJLbxKF
         1NSydkRjvdS2Cex8eyDetF/mB4WG1KXXb43Q4H1kSMV48B/plM/kWGRNbQNLZvgeCd/Y
         l+Tw==
X-Gm-Message-State: AOAM531mHn0Zqh7CpQO79+EBvZlziTkLnbzYTV+KDTf55uVWAZyukl0W
        2DsBZ9zG0D2S/X/xFQAcyJasYKdREqaI18LiD6Hf0Jf8/ekmTg==
X-Google-Smtp-Source: ABdhPJwjIVYllyVYV8dgRA1CqSfm9uOsfwOsG6ajnn19/ZaUMTNkwnE309t3j2VLptpfFbby34ecXos9CTfI51MuXIg=
X-Received: by 2002:a05:6512:e9c:b0:479:1fd9:1b94 with SMTP id
 bi28-20020a0565120e9c00b004791fd91b94mr13995362lfb.591.1654680872363; Wed, 08
 Jun 2022 02:34:32 -0700 (PDT)
MIME-Version: 1.0
References: <CAAhV-H49bwGf8=qs3GSLv-7wZHv_mW05kY4OktgvDviuscgVrg@mail.gmail.com>
 <20220602162935.GA21834@bhelgaas>
In-Reply-To: <20220602162935.GA21834@bhelgaas>
From:   Huacai Chen <chenhuacai@gmail.com>
Date:   Wed, 8 Jun 2022 17:34:21 +0800
Message-ID: <CAAhV-H6CpeEWw2VNv5eaMwbyvGTxzvuJzXzjJ8Wg3iggOM=DcQ@mail.gmail.com>
Subject: Re: [PATCH V13 5/6] PCI: Add quirk for LS7A to avoid reboot failure
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Huacai Chen <chenhuacai@loongson.cn>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi, Bjorn,

On Fri, Jun 3, 2022 at 12:29 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Thu, Jun 02, 2022 at 08:48:20PM +0800, Huacai Chen wrote:
> > Hi, Bjorn,
> >
> > On Wed, Jun 1, 2022 at 7:35 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > >
> > > On Sat, Apr 30, 2022 at 04:48:45PM +0800, Huacai Chen wrote:
> > > > Commit cc27b735ad3a75574a ("PCI/portdrv: Turn off PCIe services
> > > > during shutdown") causes poweroff/reboot failure on systems with
> > > > LS7A chipset.  We found that if we remove "pci_command &=
> > > > ~PCI_COMMAND_MASTER;" in do_pci_disable_device(), it can work
> > > > well. The hardware engineer says that the root cause is that CPU
> > > > is still accessing PCIe devices while poweroff/reboot, and if we
> > > > disable the Bus Master Bit at this time, the PCIe controller
> > > > doesn't forward requests to downstream devices, and also doesn't
> > > > send TIMEOUT to CPU, which causes CPU wait forever (hardware
> > > > deadlock). This behavior is a PCIe protocol violation (Bus
> > > > Master should not be involved in CPU MMIO transactions), and it
> > > > will be fixed in new revisions of hardware (add timeout
> > > > mechanism for CPU read request, whether or not Bus Master bit is
> > > > cleared).
> > >
> > > LS7A might have bugs in that clearing Bus Master Enable prevents the
> > > root port from forwarding Memory or I/O requests in the downstream
> > > direction.
> > >
> > > But this feels like a bit of a band-aid because we don't know exactly
> > > what those requests are.  If we're removing the Root Port, I assume we
> > > think we no longer need any devices *below* the Root Port.
> > >
> > > If that's not the case, e.g., if we still need to produce console
> > > output or save state to a device, we probably should not be removing
> > > the Root Port at all.
> >
> > Do you mean it is better to skip the whole pcie_port_device_remove()
> > instead of just removing the "clear bus master" operation for the
> > buggy hardware?
>
> No, that's not what I want at all.  That's just another band-aid to
> avoid a problem without understanding what the problem is.
>
> My point is that apparently we remove a Root Port (which means we've
> already removed any devices under it), and then we try to use a device
> below the Root Port.  That seems broken.  I want to understand why we
> try to use a device after we've removed it.
I agree, and I think "why we try to use a device after remove it" is
because the userspace programs don't know whether a device is
"usable", so they just use it, at any time. Then it seems it is the
responsibility of the device drivers to avoid the problem.

Take radeon/amdgpu driver as an example, the .shutdown() of the
callback can call suspend() to fix.

But..., another problem is: There are many drivers "broken", not just
radeon/amdgpu drivers (at least, the ahci driver is also "broken").
Implementing the driver's .shutdown() correctly is nearly impossible
for us, because we don't know the hardware details of so many devices.
On the other hand, those drivers "just works" on most platforms, so
the driver authors don't think they are "broken".

So, very sadly, we can only use a band-aid now. :(

Huacai

>
> If the scenario ends up being legitimate and unavoidable, fine -- we
> can figure out a quirk to work around the fact the LS7A doesn't allow
> that access after we clear Bus Master Enable.  But right now the
> scenario smells like a latent bug, and leaving bus mastering enabled
> just avoids it without fixing it.
>
> Bjorn
