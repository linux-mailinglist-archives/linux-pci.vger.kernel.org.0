Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8690942712B
	for <lists+linux-pci@lfdr.de>; Fri,  8 Oct 2021 21:06:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240055AbhJHTIs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 8 Oct 2021 15:08:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231316AbhJHTIo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 8 Oct 2021 15:08:44 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE363C061570
        for <linux-pci@vger.kernel.org>; Fri,  8 Oct 2021 12:06:48 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id a3so14988396oid.6
        for <linux-pci@vger.kernel.org>; Fri, 08 Oct 2021 12:06:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=LrmfX34GObvirBK4Iq8eQUnGcvQ0wY+TvxWBiA97kls=;
        b=G2GT+K3lGKazwMmL6lbYFr4VtJsTOMVA2fV1wnnPCedS+C2rSUmMi2e9P4z6yfPUXq
         yis176soBf1pdDcxpoxRWMVEX/DLMNc+xbFAR9iDk2s73MxinxOaU/yLP+jHYAISts4Q
         n2TziaGC7+ybL47H/l9BWf9zrgKMUOGHWQ7MBMoLRddiKBGmgdeBHDkQ9vXxnwgq6uAF
         iOWseFM4mIk/IL+rNRVZPqEpMF3u590Syw/vkaP4dZFeU1Y8DnnCwXKSBBHzsQX5+iIE
         YJx+RKzKNgJvDT6mMqvPd8Aw6OKcDUJ/VqnxXOamDBr6oKy0saOhZmnHTBFgEZwv6xra
         T8gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LrmfX34GObvirBK4Iq8eQUnGcvQ0wY+TvxWBiA97kls=;
        b=I4af+t1m+94BvzcAx0p4OCTBac9VzhEQRMjnTbJKVe3qU1CJ0Jxd7SC4SQJnPYsuJs
         RRUZiyvS6bVlOACuEHHKD2kpoUvx5p7bDLGt1BAMXN+CZkq8akA9n5+4N8nW0SgbP1uU
         TqqD2hZavdIkeCAjogPHatPgXLq13+s0BNqMcJt3QucrelgySN3wmbxHcKufW5YLFhr1
         7JMEC4aa+gzC18tp213khjJsOFiIWrV1kEMGf0ek9/arp4sthr7jGKZAmGIOmxTC04eb
         N0Sqys5sWeY1CwFHEwdE2nEJcDz0wLuHAyOfbsQw5dm1gOMaJFBmP782GROdZnaVKEcJ
         Ut6A==
X-Gm-Message-State: AOAM533vrwoaT+0XXomSlxDTCehhyArBmoMpt2AnoCIB4j8WXc4Xr6PO
        jAIBKeSKNjzK+v3jSrDzNuS1pg==
X-Google-Smtp-Source: ABdhPJzVSQg8dziDkJydMZ6Kb5vkX9g4Lyp0OAZsBdvJIKINGRiNPzQHWR7UWwOiY1gowTV1UakbjA==
X-Received: by 2002:aca:e009:: with SMTP id x9mr18290787oig.156.1633720007878;
        Fri, 08 Oct 2021 12:06:47 -0700 (PDT)
Received: from ripper ([2600:1700:a0:3dc8:205:1bff:fec0:b9b3])
        by smtp.gmail.com with ESMTPSA id i127sm52577oia.43.2021.10.08.12.06.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Oct 2021 12:06:47 -0700 (PDT)
Date:   Fri, 8 Oct 2021 12:08:25 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Krzysztof Wilczy??ski <kw@linux.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        vidyas@nvidia.com
Subject: Re: [PATCH v2 1/2] PCI: dwc: Perform host_init() before registering
 msi
Message-ID: <YWCXKevPYiSkqapt@ripper>
References: <YSVTdedrDSgSYgwm@ripper>
 <20210824202925.GA3491441@bjorn-Precision-5520>
 <YSVjQgDmatkkCxtn@ripper>
 <20211008174803.GA32277@lpieralisi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211008174803.GA32277@lpieralisi>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri 08 Oct 10:48 PDT 2021, Lorenzo Pieralisi wrote:

> [+Vidya]
> 
> On Tue, Aug 24, 2021 at 02:23:14PM -0700, Bjorn Andersson wrote:
> > On Tue 24 Aug 13:29 PDT 2021, Bjorn Helgaas wrote:
> > 
> > > On Tue, Aug 24, 2021 at 01:15:49PM -0700, Bjorn Andersson wrote:
> > > > On Tue 24 Aug 12:05 PDT 2021, Bjorn Helgaas wrote:
> > > > 
> > > > > On Mon, Aug 23, 2021 at 08:49:57AM -0700, Bjorn Andersson wrote:
> > > > > > On the Qualcomm sc8180x platform the bootloader does something related
> > > > > > to PCI that leaves a pending "msi" interrupt, which with the current
> > > > > > ordering often fires before init has a chance to enable the clocks that
> > > > > > are necessary for the interrupt handler to access the hardware.
> > > > > > 
> > > > > > Move the host_init() call before the registration of the "msi" interrupt
> > > > > > handler to ensure the host driver has a chance to enable the clocks.
> > > > > 
> > > > > Did you audit other drivers for similar issues?  If they do, we should
> > > > > fix them all at once.
> > > > 
> > > > I only looked at the DesignWware drivers, in an attempt to find any
> > > > issues the proposed reordering.
> > > > 
> > > > The set of bugs causes by drivers registering interrupts before critical
> > > > resources tends to be rather visible and I don't know if there's much
> > > > value in speculatively "fixing" drivers.
> > > > 
> > > > E.g. a quick look through the drivers I see a similar pattern in
> > > > pci-tegra.c, but it's unlikely that they have the similar problem in
> > > > practice and I have no way to validate that a change to the order would
> > > > have a positive effect - or any side effects.
> > > > 
> > > > Or am I misunderstanding your request?
> > > 
> > > That is exactly my request.
> > 
> > Okay.
> > 
> > > I'm not sure if the potential issue you
> > > noticed in pci-tegra.c is similar to the one I mentioned here:
> > > 
> > >   https://lore.kernel.org/linux-pci/20210624224040.GA3567297@bjorn-Precision-5520/
> > > 
> > 
> > As I still have the tegra driver open, I share your concern about the
> > use of potentially uninitialized variables.
> > 
> > The problem I was concerned about was however the same as in my patch
> > and the rockchip one, that if the tegra hardware isn't clocked the
> > pm_runtime_get_sync() (which would turn on power and clock) happens
> > after setting up the msi chain handler...
> > 
> > > but I am actually in favor of speculatively fixing drivers even though
> > > they're hard to test.  Code like this tends to get copied to other
> > > places, and fixing several drivers sometimes exposes opportunities for
> > > refactoring and sharing code.
> > > 
> > 
> > Looking through the other cases mentioned in your reply above certainly
> > gives a feeling that this problem has been inherited from driver to
> > driver...
> > 
> > I've added a ticket to my backlog to take a deeper look at this.
> 
> Vidya, can you look into this please ? In the meantime I would merge
> this series.
> 

I would greatly appreciate that, as it unlocks 5G connectivity and NVME
support on my laptop. I still intend to review the items Bjorn pointed
out, but I haven't gotten there yet.

Thanks,
Bjorn

> Thanks,
> Lorenzo
> 
> > 
> > Regards,
> > Bjorn
