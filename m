Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F3291123ACA
	for <lists+linux-pci@lfdr.de>; Wed, 18 Dec 2019 00:29:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725886AbfLQX3p (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 17 Dec 2019 18:29:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:47346 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725805AbfLQX3o (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 17 Dec 2019 18:29:44 -0500
Received: from localhost (mobile-166-170-223-177.mycingular.net [166.170.223.177])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9F2A020716;
        Tue, 17 Dec 2019 23:29:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576625384;
        bh=RDmd44o6oMpaId45QHHBF5kKqBGAGIO13OmjcBMHt9k=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=Ri0yHsWtev8qy5i4TBu/PI73ECu6kHgw4sRf4ZpN0V8syq2MrpeD5/NFyMN+IK3hU
         4i+0JO/gXnpOozP0I8L8E38JAHA+orLVd34q6xPDkfnxUcljnTa/6KJ8CMX9iIx6TU
         IcBoTm+aVCYCMCpkCEiA18OE7K3bEkCo1r+r5CJ0=
Date:   Tue, 17 Dec 2019 17:29:41 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Ranran <ranshalit@gmail.com>
Cc:     linux-pci@vger.kernel.org
Subject: Re: [Bug 205701] New: Can't access RAM from PCIe
Message-ID: <20191217232941.GA1617@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJ2oMhJBY_i-s6kBOMPxSdhCAudbR4up-dy3=RxJpBiF707NKQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Dec 15, 2019 at 07:29:58PM +0200, Ranran wrote:
> On Fri, Dec 6, 2019 at 7:57 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > On Fri, Dec 06, 2019 at 06:48:24PM +0200, Ranran wrote:
> > > On Fri, Dec 6, 2019 at 5:08 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > > On Fri, Dec 06, 2019 at 08:09:48AM +0200, Ranran wrote:
> > > > > On Fri, Nov 29, 2019 at 8:38 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > > > > On Fri, Nov 29, 2019 at 06:10:51PM +0200, Ranran wrote:
> > > > > > > On Fri, Nov 29, 2019 at 4:58 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > > > > > > On Fri, Nov 29, 2019 at 06:59:48AM +0000, bugzilla-daemon@bugzilla.kernel.org wrote:
> > > > > > > > > https://bugzilla.kernel.org/show_bug.cgi?id=205701
> > > >
> > > > > I have tried to upgrade to latest kernel 5.4 (elrepo in centos), but
> > > > > with this processor/board (system x3650, Xeon), it get hang during
> > > > > kernel boot, without any error in dmesg, just keeps waiting for
> > > > > nothing for couple of minutes and than drops to dracut.
> > > >
> > > > - I don't think you ever said exactly what the original failure mode
> > > >   was.  You said DMA from an FPGA failed.  What is the specific
> > > >   device?  How do you know the DMA fails?
> > >
> > > FPGA is Intel's Arria 10 device.
> >
> > I really meant which bus/device/function it is so we can correlate it
> > with the dmesg log and lspci output.
> >
> > > We know that DMA fails because on using signaltap/probing the DMA
> > > transaction from FPGA to CPU's RAM we see that it stall, i.e. keep
> > > waiting for the access to finish.
> > > We don't observe any error in dmesg.
> >
> > ... So I assume that:
> >
> >   - On the working system (Intel DUO?) Signal Tap shows the PCIe
> >     Memory Read TLP from the FPGA and the matching Completion.
> >
> >   - On the non-working system Signal Tap shows the PCIe Memory Read
> >     TLP from the FPGA but the Completion never arrives.  I assume the
> >     FPGA eventually logs a Completion Timeout error?
> >
> > My guess would be something's wrong with the address the FPGA is
> > generating.  So please collect the complete dmesg log and /proc/iomem
> > contents and the address used in the FPGA DMA TLP from both the
> > working and non-working systems.  There should be some clue if we
> > look at the differences between the systems.

> I've installed ubuntu 19.10 with kernel 5.3, and I still see same
> issue with Xeon.
> I've attached result of lspci -vv

Sorry, all this information is incomplete and inconsistent, so I can't
give you any useful help.  The dmesg log contains output not produced
by the module you supplied, the lspci doesn't match the dmesg output,
the lspci was not collected as root ("sudo lspci -vv", as I requested
twice), you haven't supplied the user-space code, etc.

Bjorn
