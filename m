Return-Path: <linux-pci+bounces-31807-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B4C4AFF2F0
	for <lists+linux-pci@lfdr.de>; Wed,  9 Jul 2025 22:26:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E30F4E425C
	for <lists+linux-pci@lfdr.de>; Wed,  9 Jul 2025 20:26:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E91B2242D8E;
	Wed,  9 Jul 2025 20:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PNSrPjem"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF7B51FF5F9;
	Wed,  9 Jul 2025 20:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752092784; cv=none; b=jY7WG7qMdFJalBeOnqduP6bGJVqx14FzsICrCgLsR+TsoW5pEQfIBCJPT7bY8hq1Ad3yBN1xI5s7iYucvu0sSG02tfakk3mKwyUW3SnuSr6U0iEiaQzoJz7coBUEI8v6xUrRcv0z5cq4QRMz7gMxiXLdAWeUB4SgGeYa4haLt9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752092784; c=relaxed/simple;
	bh=bQNwEAhweMYICewYFBrSb4iT3iREmwhVhLODYftXieE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=rq+2qKTGPeQmfqfUTMFuBeafrJccTdKNlB2Y85GsOXDyzu7dSG55auSQClo7vyS0w6oMuZLbc8p882oFv3xAmSJxJr8cdZKzau4Z3eJ2nDp5l92lCdM1CUmt2xWbZ8TW3IgXa/sfb1Ov7d0U3lOiHCRqxsOH1QbAUSwxnShswiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PNSrPjem; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32D34C4CEEF;
	Wed,  9 Jul 2025 20:26:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752092784;
	bh=bQNwEAhweMYICewYFBrSb4iT3iREmwhVhLODYftXieE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=PNSrPjemNmqhvpwmzgy6nx4B4VTCC+toNXpRJUmDZsaKgg2BzuxwggCCth6MoSda0
	 RCK23XDaqRvE503RV/W3S/SiTKQL7zM4zjjrO4YnRHTjihJyMcXCltwQingacv3XmB
	 +lRc+HJgdL/iR8oXLajeNIG4y7WDGkCHWZSWpMkciX8CexrewxfyzzZUPKNVbp6BIE
	 11gk2rd238anzodUaiqvpSUsMzYlviyG+alCRHnYm5v1lAC7nSKQNIuxRy4xWKB1lu
	 jhi9t0Ifk+wXGSrm1kfMWYBXjNjdZARiPjzs4qUCmAcL2U86hclGWLXGGW+Ki45oyd
	 AxW7PgRNzU82g==
Date: Wed, 9 Jul 2025 15:26:22 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ammar Qadri <ammarq@google.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: Reduce verbosity of device enable messages
Message-ID: <20250709202622.GA2207975@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFbbpazQU6S4MDAGcHDKG79T2GOaxz9Ezg2Ls6hhPDCTVLrdEA@mail.gmail.com>

On Wed, Jul 09, 2025 at 11:25:54AM -0700, Ammar Qadri wrote:
> This is the only message I can see being consistently printed as a
> result of the open/close of the devices.
> 
> I am not opposed to carrying this out of tree at all, but for the sake
> of exhausting options people would be comfortable with, would you
> be okay with moving this to dev_dbg, or would you have the same
> hesitations, Mani (et al)? Or is there some alternative flag-controlled
> behavior you'd recommend?

pci_dbg() (as you proposed) is just syntactic sugar for dev_dbg(), so
they're functionally the same.

Personally I think "enabling device (0000 -> 0002)" is probably not
interesting enough to be an 'info' message.  Every driver is going to
call pci_enable_device() (unless it only uses config space).  If it
wants to emit a message in its .probe() function it can, and it can
include more useful information than whether we're setting the Memory
or I/O decoding enable bits.

We already have a similar "enabling bus mastering" message in
__pci_set_master() that is already pci_dbg().  So I propose:

  - Demoting it to pci_dbg()

  - Decoding the bits, e.g., "enabling MEM decoding"

  - Adding hints about how to enable pci_dbg() messages to
    Documentation/admin-guide/kernel-parameters.txt

> On Fri, Jun 13, 2025 at 3:09 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> >
> > On Fri, Jun 13, 2025 at 02:40:40PM -0700, Ammar Qadri wrote:
> > > Hi Mani,
> > >
> > > The issue we are experiencing is not caused from
> > > removing/reattaching the device driver, so the other messages have
> > > not been problematic.
> > >
> > > The vfio-pci driver is attached to each VF once. Clients in our
> > > system call open and close on the vfio-pci driver, respectively, at
> > > the start and end of their use, with fairly short-term tenancy,
> > > which ends up triggering these enable messages.  This message is
> > > proving challenging not only because they are not particularly
> > > useful,  but because they are causing log files to rotate once every
> > > 30 minutes or so, and we lose a lot of other more valuable logging
> > > as a consequence.  I'm open to other solutions, but in my opinion
> > > this preserves the message, without over-engineering and introducing
> > > throttling or other behaviour.
> >
> > Are there any other messages associated with the open/close?  I assume
> > probably not, or you would want to demote those as well.
> >
> > I did happen to find some value in this particular message just the
> > other day because it showed that a config read was successful after
> > previous ones had failed.
> >
> > But I agree in general that it's fairly low value and at least the
> > uninterpreted "%04x -> %04x" part is not really user-friendly.
> >
> > If people think there's enough value in retaining it at KERN_INFO, I
> > suppose there's always the option of carrying an out-of-tree patch to
> > demote it?
> >
> > > On Thu, Jun 12, 2025 at 11:12 PM Manivannan Sadhasivam <mani@kernel.org> wrote:
> > > >
> > > > On Wed, May 07, 2025 at 11:29:19PM +0000, Ammar Qadri wrote:
> > > > > Excessive logging of PCIe device enable operations can create significant
> > > > > noise in system logs, especially in environments with a high number of
> > > > > such devices, especially VFs.
> > > > >
> > > > > High-rate logging can cause log files to rotate too quickly, losing
> > > > > valuable information from other system components.This commit addresses
> > > > > this issue by downgrading the logging level of "enabling device" messages
> > > > > from `info` to `dbg`.
> > > > >
> > > >
> > > > While I generally prefer reduced verbosity of the device drivers, demoting an
> > > > existing log to debug might surprise users. Especially in this case, the message
> > > > is widely used to identify the enablement of a PCI device. So I don't think it
> > > > is a good idea to demote it to a debug log.
> > > >
> > > > But I'm surprised that this single message is creating much overhead in the
> > > > logging. I understand that you might have 100s of VFs in cloud environments, but
> > > > when a VF is added, a bunch of other messages would also get printed (resource,
> > > > IRQ, device driver etc...). Or you considered that this message is not that
> > > > important compared to the rest?
> > > >
> > > > - Mani
> > > >
> > > > > Signed-off-by: Ammar Qadri <ammarq@google.com>
> > > > > ---
> > > > >  drivers/pci/setup-res.c | 2 +-
> > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > >
> > > > > diff --git a/drivers/pci/setup-res.c b/drivers/pci/setup-res.c
> > > > > index c6657cdd06f67..be669ff6ca240 100644
> > > > > --- a/drivers/pci/setup-res.c
> > > > > +++ b/drivers/pci/setup-res.c
> > > > > @@ -516,7 +516,7 @@ int pci_enable_resources(struct pci_dev *dev, int mask)
> > > > >       }
> > > > >
> > > > >       if (cmd != old_cmd) {
> > > > > -             pci_info(dev, "enabling device (%04x -> %04x)\n", old_cmd, cmd);
> > > > > +             pci_dbg(dev, "enabling device (%04x -> %04x)\n", old_cmd, cmd);
> > > > >               pci_write_config_word(dev, PCI_COMMAND, cmd);
> > > > >       }
> > > > >       return 0;
> > > > > --
> > > > > 2.49.0.987.g0cc8ee98dc-goog
> > > > >
> > > >
> > > > --
> > > > மணிவண்ணன் சதாசிவம்

