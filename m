Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E72C711D7FE
	for <lists+linux-pci@lfdr.de>; Thu, 12 Dec 2019 21:41:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730707AbfLLUlR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 12 Dec 2019 15:41:17 -0500
Received: from foss.arm.com ([217.140.110.172]:60180 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726814AbfLLUlR (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 12 Dec 2019 15:41:17 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C8B7B328;
        Thu, 12 Dec 2019 12:41:16 -0800 (PST)
Received: from localhost (unknown [10.37.6.20])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3EF093F718;
        Thu, 12 Dec 2019 12:41:16 -0800 (PST)
Date:   Thu, 12 Dec 2019 20:41:14 +0000
From:   Andrew Murray <andrew.murray@arm.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Olof Johansson <olof@lixom.net>, soc@kernel.org,
        devicetree@vger.kernel.org, PCI <linux-pci@vger.kernel.org>
Subject: Re: [GIT PULL] PCI: dt: Remove magic numbers for legacy PCI IRQ
 interrupts
Message-ID: <20191212204113.GI24359@e119886-lin.cambridge.arm.com>
References: <20191211161808.7566-1-andrew.murray@arm.com>
 <20191211165855.kfoz2x63kw3gnlmm@localhost>
 <CAL_JsqJnLF9A9GoqNgwBebb8gWbCUo7txiAX2Q56cfyYvMjhVQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_JsqJnLF9A9GoqNgwBebb8gWbCUo7txiAX2Q56cfyYvMjhVQ@mail.gmail.com>
User-Agent: Mutt/1.10.1+81 (426a6c1) (2018-08-26)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Dec 11, 2019 at 01:33:37PM -0600, Rob Herring wrote:
> On Wed, Dec 11, 2019 at 10:59 AM Olof Johansson <olof@lixom.net> wrote:
> >
> > On Wed, Dec 11, 2019 at 04:18:08PM +0000, Andrew Murray wrote:
> > > Hi Arnd,
> > >
> > > Please consider this pull request.
> > >
> > > The following changes since commit e42617b825f8073569da76dc4510bfa019b1c35a:
> > >
> > >   Linux 5.5-rc1 (2019-12-08 14:57:55 -0800)
> > >
> > > are available in the Git repository at:
> > >
> > >   git://linux-arm.org/linux-am.git tags/pci-dt-intx-defines-5.5-rc1
> > >
> > > for you to fetch changes up to d50e85b9ad3d4287ab3c5108b7b36ad4fd50e5b4:
> > >
> > >   dt-bindings: PCI: Use IRQ flags for legacy PCI IRQ interrupts (2019-12-11 16:05:55 +0000)
> > >
> > > ----------------------------------------------------------------
> > > PCI: dt: Remove magic numbers for legacy PCI IRQ interrupts
> > >
> > > PCI devices can trigger interrupts via 4 physical/virtual lines known
> > > as INTA, INTB, INTC or INTD. Due to interrupt swizzling it is often
> > > required to describe the interrupt mapping in the device tree. Let's
> > > avoid the existing magic numbers and replace them with a #define to
> > > improve clarity.
> > >
> > > This is based on v5.5-rc1. As this series covers multiple architectures
> > > and updates include/dt-bindings it was felt that it may be more
> > > convenient to merge in one go.
> >
> > That's a pretty high-effort way of doing this, with potential for messy
> > conflicts.
> >
> > The standard way of making sweeping changes across the tree is usually to
> > get the new interface/definition added in one release, and then moving
> > usage over through the various maintainers in the release after since
> > the define is then in the base tree for everybody. Would you mind using

OK, thanks for this - noted for next time.


> > the same approach here, please? Especially since this is mostly a cleanup.
> 
> Yeah, it's already going to conflict with some PCI controller schema
> conversions pending.
> 
> I'm happy to apply the header for 5.5-rc2. Then send the dts changes
> to Arnd/Olof and the binding changes to Lorenzo.

Much appreciated.

I'll rebase the dts and doc in a subsequent release.

Thanks,

Andrew Murray

> 
> Rob
