Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DA8B61156D9
	for <lists+linux-pci@lfdr.de>; Fri,  6 Dec 2019 18:57:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726312AbfLFR5g (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 6 Dec 2019 12:57:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:40202 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726400AbfLFR5g (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 6 Dec 2019 12:57:36 -0500
Received: from localhost (odyssey.drury.edu [64.22.249.253])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3021D2467F;
        Fri,  6 Dec 2019 17:57:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575655055;
        bh=MWq7HNMVPQC47h9Cy+gkr6dVakhiCle1jmAlCclLUIg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=IdYffC67lwciT0V2lfBfp/eeMoTv4z43l+yxIWi/ZM19382YbK2Vhr2C/Y+yjDyYi
         qCrv6xxtlEme0Zf6fJ8YTtn9Q97N7RrGGgjqvRrMmzHtUnIsjan6C3VZaEQh+NDXAv
         coJD/r45pr20dRZdWqWtA2Y30IZKKEgYK7xq7xrY=
Date:   Fri, 6 Dec 2019 11:57:33 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Ranran <ranshalit@gmail.com>
Cc:     linux-pci@vger.kernel.org
Subject: Re: [Bug 205701] New: Can't access RAM from PCIe
Message-ID: <20191206175733.GA108238@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJ2oMhJqsSftJtSDt2fsjqhLT0qQDZkdgQUc4pusuy6TvCnSVA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Dec 06, 2019 at 06:48:24PM +0200, Ranran wrote:
> On Fri, Dec 6, 2019 at 5:08 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > On Fri, Dec 06, 2019 at 08:09:48AM +0200, Ranran wrote:
> > > On Fri, Nov 29, 2019 at 8:38 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > > On Fri, Nov 29, 2019 at 06:10:51PM +0200, Ranran wrote:
> > > > > On Fri, Nov 29, 2019 at 4:58 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > > > > On Fri, Nov 29, 2019 at 06:59:48AM +0000, bugzilla-daemon@bugzilla.kernel.org wrote:
> > > > > > > https://bugzilla.kernel.org/show_bug.cgi?id=205701
> >
> > > I have tried to upgrade to latest kernel 5.4 (elrepo in centos), but
> > > with this processor/board (system x3650, Xeon), it get hang during
> > > kernel boot, without any error in dmesg, just keeps waiting for
> > > nothing for couple of minutes and than drops to dracut.
> >
> > - I don't think you ever said exactly what the original failure mode
> >   was.  You said DMA from an FPGA failed.  What is the specific
> >   device?  How do you know the DMA fails?
> 
> FPGA is Intel's Arria 10 device.

I really meant which bus/device/function it is so we can correlate it
with the dmesg log and lspci output.

> We know that DMA fails because on using signaltap/probing the DMA
> transaction from FPGA to CPU's RAM we see that it stall, i.e. keep
> waiting for the access to finish.
> We don't observe any error in dmesg.

I'm not familiar with Signal Tap, but Google suggests that it's
basically an embedded logic analyzer on the FPGA itself.  So I assume
that:

  - On the working system (Intel DUO?) Signal Tap shows the PCIe
    Memory Read TLP from the FPGA and the matching Completion.

  - On the non-working system Signal Tap shows the PCIe Memory Read
    TLP from the FPGA but the Completion never arrives.  I assume the
    FPGA eventually logs a Completion Timeout error?

My guess would be something's wrong with the address the FPGA is
generating.  So please collect the complete dmesg log and /proc/iomem
contents and the address used in the FPGA DMA TLP from both the
working and non-working systems.  There should be some clue if we
look at the differences between the systems.

> >   You may also be able to just drop a v5.4 kernel on your v4.18
> >   system, at least for testing purposes.
> >
> What does it mean to drop 5.4 kernel on 4.18 kernel ?

Not on a v4.18 *kernel*; on the CentOS *file system* that was
installed along with your v4.18-based kernel.  If you take a v5.4
kernel built with the right config options/modules/etc, it should work
on the same root filesystem as the v4.18 kernel.

Bjorn
