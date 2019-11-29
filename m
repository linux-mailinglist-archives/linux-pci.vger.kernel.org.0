Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C3BF510D9AE
	for <lists+linux-pci@lfdr.de>; Fri, 29 Nov 2019 19:38:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727010AbfK2Sik (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 29 Nov 2019 13:38:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:32802 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726980AbfK2Sik (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 29 Nov 2019 13:38:40 -0500
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D6210216F4;
        Fri, 29 Nov 2019 18:38:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575052719;
        bh=gtbgHaOOBB1c8+tIHz9nuUEYYK1Ty393tWDF/Ws4fUk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=qdpojgPH681j1CxoYtDjXAFj6qmwgrPx8yCOIanqqc/PXV9nfqemTBzloREw1W5Kc
         QgVELZ2YHDHbSMoniDj0WAYOlR8+o1m3yYEJoU+7IVwC28owisHEI+88KE0sgos7/O
         iFy7wqtE8eK8wWp2BZatrjN/XyoyQipUzDLg18Tk=
Date:   Fri, 29 Nov 2019 12:38:36 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Ranran <ranshalit@gmail.com>
Cc:     bjorn@helgaas.com, linux-pci@vger.kernel.org
Subject: Re: [Bug 205701] New: Can't access RAM from PCIe
Message-ID: <20191129183836.GA20312@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJ2oMhJ10FTcNH5wqWT2nfNz4jwG0BYr1DcVYTUPOcsSwpkMYg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Nov 29, 2019 at 06:10:51PM +0200, Ranran wrote:
> On Fri, Nov 29, 2019 at 4:58 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > On Fri, Nov 29, 2019 at 06:59:48AM +0000, bugzilla-daemon@bugzilla.kernel.org wrote:
> > > https://bugzilla.kernel.org/show_bug.cgi?id=205701
> > > ...
> > >
> > > Using Intel Xeon computer with linux kernel 4.18.0 centos8.
> > > Trying to access RAM (with DMA) using FPGA  fails in this computer.
> > >
> > > 1. I tried to add intel_iommu=off - it did not help.
> > >
> > > 2. Installing windows on same PC - FPGA can access RAM using DMA without
> > > issues.
> > >
> > > 3. using another PC (Intel Duo) with same linux and OS - FPGA access works.
> > >
> > > FPGA access the RAM using a physical address provided by a kernel module which
> > > allocates physical continuous memory in PC. (the module works perfectly with
> > > Intel Duo on exactly same OS and kernel).
> >
> > Hi, thanks for the report!  Can you please attach the complete dmesg
> > and "sudo lspci -vv" output for the working and non-working v4.18
> > kernels to the bugzilla?
> >
> > Then please try to reproduce the problem on the current v5.4 kernel
> > and attach the v5.4 dmesg log.  If v5.4 fails, we'll have to debug it.
> > If v5.4 works, figure out what fixed it (by comparing dmesg logs or by
> > bisection) and backport it to v4.18.
> >
> > Bjorn
> 
> Hi,
> I've attached 2 files:
> 1. dmesg.log - is the dmesg you've requested.
> 2. dmesg_intel_iommu_off.log - dmesg when I added intel_iommu=off
> kernel parameter.

Thanks, I attached these to the bugzilla.  I think the linux-pci
mailing list rejected your mail since it wasn't plain-text.

Please also attach the "sudo lspci -vv" output to the bugzilla and
indicate which device is your FPGA.  I guess it might be 0000:20:00.0,
since it looks like it's being claimed by an out-of-tree module in
your dmesg_intel_iommu_off.log (but not dmesg.log).

Please also attach the driver source so we can see how it is obtaining
and using the DMA buffer address.

> I might try the new kernel, yet since we are required to use the
> installation of centos8  (centos8 was just published about 2 month ago
> and it comes with kernel 4.18.0), updating kernel might be
> problematic.

Even if you can't use the v5.4 kernel for your project, if you can
establish that it works, then you have a clear path to finding the
fix.  If v5.4 still *doesn't* work, then we'll be much more interested
in helping to fix that.

> I would please like to ask if there is some workaround you can think of ?
> For example, might it help if I disable iommu (VT-d) in BIOS ?

Usually when an IOMMU blocks a DMA, it seems like there's a note in
dmesg.  I don't see that in either of your logs, but I'm not an IOMMU
expert, so it does seem reasonable to try disabling the IOMMU.

Bjorn
