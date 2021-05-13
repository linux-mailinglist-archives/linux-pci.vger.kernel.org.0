Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3345537FA5E
	for <lists+linux-pci@lfdr.de>; Thu, 13 May 2021 17:13:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234720AbhEMPOz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 13 May 2021 11:14:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234690AbhEMPOz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 13 May 2021 11:14:55 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B8E2C061574
        for <linux-pci@vger.kernel.org>; Thu, 13 May 2021 08:13:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=N0c5RJ43/6eXtMgXe2FRn+gUWZwOzsKwDK9QOxnFniE=; b=BWjciQ4EjJPJ5vU6IB92XJcJo
        wTeDVlqRV/CivbzrjUN66GzMg2O9b2VQ2CjdlmRAmDPaS7NZSsRACCZb/c/Bdn/LAYLtI6yI0qUlB
        N93HoSt/iIvd3czG9pCHsC3iasLITDM3B23MC9c1Rs4C0eXmw5JPQAZst7J+ohbbRpW1o9Ox1rgFT
        SUl7YqPujjmWU9TrMUqNBgYQiYcljS+faDv74Z5AssAtTOYa9Xm1bL4NTPts2AzCWeafhX9dUCuzI
        QAjd2UVUByGgxleKwvuz2qWMN2za4CUtu8ZWSC0CtWmdVtdkNjQbyZkbqHgvLL03w/ymSbn7Bn4/y
        KbhOhcUtg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:43934)
        by pandora.armlinux.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <linux@armlinux.org.uk>)
        id 1lhD1x-0006NQ-Mz; Thu, 13 May 2021 16:13:41 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1lhD1x-00036S-9k; Thu, 13 May 2021 16:13:41 +0100
Date:   Thu, 13 May 2021 16:13:41 +0100
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-pci <linux-pci@vger.kernel.org>
Subject: Re: [PATCH] PCI: dynamically map ECAM regions
Message-ID: <20210513151341.GZ1336@shell.armlinux.org.uk>
References: <E1lhCAV-0002yb-50@rmk-PC.armlinux.org.uk>
 <CAK8P3a0TxtWn7Ua05=XsG5QK853C9SMDLdTOV_6rLB8cE49qXg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a0TxtWn7Ua05=XsG5QK853C9SMDLdTOV_6rLB8cE49qXg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: Russell King - ARM Linux admin <linux@armlinux.org.uk>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, May 13, 2021 at 05:02:32PM +0200, Arnd Bergmann wrote:
> On Thu, May 13, 2021 at 4:18 PM Russell King <rmk+kernel@armlinux.org.uk> wrote:
> >
> > Attempting to boot 32-bit ARM kernels under QEMU's 3.x virt models
> > fails when we have more than 512M of RAM in the model as we run out
> > of vmalloc space for the PCI ECAM regions. This failure will be
> > silent when running libvirt, as the console in that situation is a
> > PCI device.
> >
> > In this configuration, the kernel maps the whole ECAM, which QEMU
> > sets up for 256 buses, even when maybe only seven buses are in use.
> > Each bus uses 1M of ECAM space, and ioremap() adds an additional
> > guard page between allocations. The kernel vmap allocator will
> > align these regions to 512K, resulting in each mapping eating 1.5M
> > of vmalloc space. This means we need 384M of vmalloc space just to
> > map all of these, which is very wasteful of resources.
> >
> > Fix this by only mapping the ECAM for buses we are going to be using.
> > In my setups, this is around seven buses in most guests, which is
> > 10.5M of vmalloc space - way smaller than the 384M that would
> > otherwise be required. This also means that the kernel can boot
> > without forcing extra RAM into highmem with the vmalloc= argument,
> > or decreasing the virtual RAM available to the guest.
> >
> > Suggested-by: Arnd Bergmann <arnd@arndb.de>
> > Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
> 
> Looks good to me. I wonder if we should actually mark this for stable
> backports. It is a somewhat invasive change, so there is a regression
> risk, but it's also likely that others will run into this problem on distro
> kernels.

Maybe merge it first, wait a release cycle, and then request it for
stable if we think it's of benefit?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
