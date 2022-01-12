Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E503648C73D
	for <lists+linux-pci@lfdr.de>; Wed, 12 Jan 2022 16:32:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245740AbiALPcq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 12 Jan 2022 10:32:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240181AbiALPcp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 12 Jan 2022 10:32:45 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B879C06173F;
        Wed, 12 Jan 2022 07:32:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F0A4461932;
        Wed, 12 Jan 2022 15:32:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08895C36AE5;
        Wed, 12 Jan 2022 15:32:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642001562;
        bh=TmVoPyrYCTfNSodHZ3UduskHBWm/lkWLvgSm8FdlN7M=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=OOcmWvbFWt0+bDrg1D6Bu2Ep5/ae0/OMi1woG2R9lLudTKIevYAeEQIUKgGh/trhD
         zZUC7IuwPAAqpCZTnPAq/ZQ4zhUjS/3SgoOeZ/QpThJlwZZH6jXgk1SfCgtZWbvh0q
         K3RbifkUmhQXdM4GDFoV4B9l1p/poQoeKndCAMP2zazWnJc4BhRuguSm6N66nipAO7
         wjZ4/VecDAF+iuzHXNxg7ksnCukSGEUbPp3nPfJ3qALcZl+SSCqIdfc8yl7oV+9hcV
         BcozVK5KBI+lWfa7rDihqlQjCZ/D3C94+RA+KQJj2hkPWjUjiA4N4sdyYDzXS1hW2w
         wPBMlbRnFmZWg==
Date:   Wed, 12 Jan 2022 09:32:40 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        PCI <linux-pci@vger.kernel.org>,
        linux-tegra <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH 19/19] PCI: Set bridge map_irq and swizzle_irq to default
 functions
Message-ID: <20220112153240.GA258585@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_JsqKoK6Vewwn4X0L+TKAz-UdK4n7CQ+OKpiEwGe2HqR5L8g@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jan 12, 2022 at 09:09:31AM -0600, Rob Herring wrote:
> On Tue, Jan 11, 2022 at 3:46 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > On Tue, Jul 21, 2020 at 08:25:14PM -0600, Rob Herring wrote:
> > > The majority of DT based host drivers use the default .map_irq() and
> > > .swizzle_irq() functions, so let's initialize the function pointers to
> > > the default and drop setting them in the host drivers.
> > >
> > > Drivers like iProc which don't support legacy interrupts need to set
> > > .map_irq() back to NULL.
> >
> > Probably a dumb question...
> >
> > This patch removed all the ->swizzle_irq users in drivers/pci/, which
> > is great -- IIUC swizzling is specified by the PCI-to-PCI Bridge Spec,
> > r1.2, sec 9.1, and should not be device-specific.  I assume the few
> > remaining arch/ users (arm and alpha) are either bugs or workarounds
> > for broken devices.
> >
> > My question is why we still have a few users of ->map_irq: loongson,
> > tegra, iproc.  Shouldn't this mapping be described somehow via DT?
> 
> Tegra could perhaps be written another way. The mapping is standard,
> but it's disabling an idle state when PCI interrupts are used. It just
> needs some way to know if legacy interrupts are being used.
>
> iproc looks pretty special with its bcma bus.
> 
> Adding something to DT doesn't really help because we'd still have to
> support the old way.

I guess my underlying question is whether new drivers should ever use
->swizzle_irq() and ->map_irq().  I'm hoping the answer is "no".

If we need them for pre-DT systems or things with incomplete DTs in
the field, I guess we have to live with that.

All ACPI really gives you is the _PRT, and I'm not sure that's
expressive enough to describe platforms that need these things, so
maybe this will eventually solve itself.

Bjorn
