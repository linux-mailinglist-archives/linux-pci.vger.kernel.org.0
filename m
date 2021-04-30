Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F03B3700E9
	for <lists+linux-pci@lfdr.de>; Fri, 30 Apr 2021 21:01:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230462AbhD3TBs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 30 Apr 2021 15:01:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:58978 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229954AbhD3TBr (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 30 Apr 2021 15:01:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E4A0360233;
        Fri, 30 Apr 2021 19:00:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619809259;
        bh=GomY+VA9Zo0qzLPG8f5I91ICZfCFf0gtQ9159W7zh5Q=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=r8jtD6kDjRb2S77djj7lWxbGV86RX2287hEMDb9ffSE5waymajQqJHSetbDnht4EI
         +ZAI+FWF9exaM856rTVQ7n/qXjpdtJQj4PoBrccwi0TGeT52Mf8FH0B+htayJrp91Z
         sug0zDDJsiNFggV52Z1chRXSRRW1jEne992MUrEOr53gCSNRAnlQZSh7T7+gHmJ84M
         BrmzYcDHVre8y/CoK7r5Ms+N0tANCd07axs0NWKVPauC6cNzqBGeaMlqPbEOWLlItO
         iDQoHkY967KdS8CQ/aWql7NgyoTaVcchOYAbRQOOGmVYZ5Ap9n2D+NJR4siRMzsPsx
         38yZC7+tMXn1A==
Date:   Fri, 30 Apr 2021 14:00:57 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Arnd Bergmann <arnd@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Prike Liang <Prike.Liang@amd.com>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Rajat Jain <rajatja@google.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] nvme: fix unused variable warning
Message-ID: <20210430190057.GA671619@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75Vchfem1OmR=2Mawiebw-zisU57BEcF64PUKcOODeiLS-g@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Apr 30, 2021 at 09:34:55PM +0300, Andy Shevchenko wrote:
> On Fri, Apr 30, 2021 at 8:57 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > On Wed, Apr 21, 2021 at 04:04:20PM +0200, Arnd Bergmann wrote:
> > > From: Arnd Bergmann <arnd@arndb.de>
> > >
> > > The function was introduced with a variable that is never referenced:
> > >
> > > drivers/pci/quirks.c: In function 'quirk_amd_nvme_fixup':
> > > drivers/pci/quirks.c:312:25: warning: unused variable 'rdev' [-Wunused-variable]
> > >
> > > Fixes: 9597624ef606 ("nvme: put some AMD PCIE downstream NVME device to simple suspend/resume path")
> >
> > I guess this refers to https://lore.kernel.org/linux-nvme/1618458725-17164-1-git-send-email-Prike.Liang@amd.com/
> >
> > But I don't know what the SHA1 means; I can't find it in linux-next or
> > my tree.
> 
> $ git tag --contains 9597624ef606
> next-20210416
> next-20210419
> next-20210420
> 
> Something is wrong with your tree.

I think what's wrong is that it doesn't appear in the *current*
linux-next (next-20210430) and I don't have all the old linux-next
objects.

It was in next-20210420, but seems to have been dropped since then:

https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/include/linux/pci.h?h=next-20210420&id=9597624ef6067bab1500d0273a43d4f90e62e929
