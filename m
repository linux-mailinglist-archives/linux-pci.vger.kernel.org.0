Return-Path: <linux-pci+bounces-29799-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83B31AD9815
	for <lists+linux-pci@lfdr.de>; Sat, 14 Jun 2025 00:09:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E17CB3BE701
	for <lists+linux-pci@lfdr.de>; Fri, 13 Jun 2025 22:09:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16DC028D83C;
	Fri, 13 Jun 2025 22:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K4GYnoBu"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF82D2853E0;
	Fri, 13 Jun 2025 22:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749852593; cv=none; b=Ez7lG5yooQUeCovDZgfLbLj+qWl9vWn3SQePcCuefUv6D25vQhkZYiL9ch/rmUWTUzR1iKMxN23wVwkgtholkAV//Reu0owVre6DxSOWJ1OxTkTxgBezN/EzDJ+LVORRaJgWgGptWHdEGzCOegm1ZNduYTqykxwondRgpWjLB6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749852593; c=relaxed/simple;
	bh=+lWOBO1C6Ko1Y9qFO+NUe+Lqz7c5PErCb0ymzfE96bU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=kx1DbUy4zJWmikQey89/o+klvnsOig1VRPJg3CefA9xhAA1VntK2F+kg1Z38FakNelwNnDidT6Wn+E0uKTfv4UqIo0FOHGIgbPWfuT7LLjtYtlr6VAuA0ci4ajuPYbdW/hG2K++HVntnJ3M+z+FDiYujetTCdfDxhSOvU3EnsN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K4GYnoBu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 343C8C4CEE3;
	Fri, 13 Jun 2025 22:09:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749852592;
	bh=+lWOBO1C6Ko1Y9qFO+NUe+Lqz7c5PErCb0ymzfE96bU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=K4GYnoBuUU7GRDMarwe1/9S8m5ynn8y2ddttEsbhgGPWw/1qgZBi+EDVzH34hmSvg
	 o2dBA7ZUrn66g1aKUGxCsktUwPmdItLyhG7uxGHn4IR/jXKB7GBdTTEEmtSycOu/HQ
	 UwpSlFrXPCyBL7KFa819HIVnFxTfIPlimCX7TGKdFtvVkV0JCh8pq7dgmTezSM5pkZ
	 cuXM6s71cV99ASx7Kc8h2VHLIADDYQRKkoA0TNCYqBoT99Opc0zgt4IIMvIi/54Yhe
	 XWuWTUA4sUo5xwamWnQGGWagq6VImg+wA6VpCAI6RFcHa02B1mYrabOo3em82vsC6q
	 S9iO9ZBgYR4mQ==
Date: Fri, 13 Jun 2025 17:09:50 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ammar Qadri <ammarq@google.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: Reduce verbosity of device enable messages
Message-ID: <20250613220950.GA986935@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFbbpayW+y8s3i4qxzHcoY0Yz5qeAhb7ziey=FayDiZbC_mm7w@mail.gmail.com>

On Fri, Jun 13, 2025 at 02:40:40PM -0700, Ammar Qadri wrote:
> Hi Mani,
> 
> The issue we are experiencing is not caused from
> removing/reattaching the device driver, so the other messages have
> not been problematic.
> 
> The vfio-pci driver is attached to each VF once. Clients in our
> system call open and close on the vfio-pci driver, respectively, at
> the start and end of their use, with fairly short-term tenancy,
> which ends up triggering these enable messages.  This message is
> proving challenging not only because they are not particularly
> useful,  but because they are causing log files to rotate once every
> 30 minutes or so, and we lose a lot of other more valuable logging
> as a consequence.  I'm open to other solutions, but in my opinion
> this preserves the message, without over-engineering and introducing
> throttling or other behaviour.

Are there any other messages associated with the open/close?  I assume
probably not, or you would want to demote those as well.

I did happen to find some value in this particular message just the
other day because it showed that a config read was successful after
previous ones had failed.

But I agree in general that it's fairly low value and at least the
uninterpreted "%04x -> %04x" part is not really user-friendly.

If people think there's enough value in retaining it at KERN_INFO, I
suppose there's always the option of carrying an out-of-tree patch to
demote it?

> On Thu, Jun 12, 2025 at 11:12 PM Manivannan Sadhasivam <mani@kernel.org> wrote:
> >
> > On Wed, May 07, 2025 at 11:29:19PM +0000, Ammar Qadri wrote:
> > > Excessive logging of PCIe device enable operations can create significant
> > > noise in system logs, especially in environments with a high number of
> > > such devices, especially VFs.
> > >
> > > High-rate logging can cause log files to rotate too quickly, losing
> > > valuable information from other system components.This commit addresses
> > > this issue by downgrading the logging level of "enabling device" messages
> > > from `info` to `dbg`.
> > >
> >
> > While I generally prefer reduced verbosity of the device drivers, demoting an
> > existing log to debug might surprise users. Especially in this case, the message
> > is widely used to identify the enablement of a PCI device. So I don't think it
> > is a good idea to demote it to a debug log.
> >
> > But I'm surprised that this single message is creating much overhead in the
> > logging. I understand that you might have 100s of VFs in cloud environments, but
> > when a VF is added, a bunch of other messages would also get printed (resource,
> > IRQ, device driver etc...). Or you considered that this message is not that
> > important compared to the rest?
> >
> > - Mani
> >
> > > Signed-off-by: Ammar Qadri <ammarq@google.com>
> > > ---
> > >  drivers/pci/setup-res.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/pci/setup-res.c b/drivers/pci/setup-res.c
> > > index c6657cdd06f67..be669ff6ca240 100644
> > > --- a/drivers/pci/setup-res.c
> > > +++ b/drivers/pci/setup-res.c
> > > @@ -516,7 +516,7 @@ int pci_enable_resources(struct pci_dev *dev, int mask)
> > >       }
> > >
> > >       if (cmd != old_cmd) {
> > > -             pci_info(dev, "enabling device (%04x -> %04x)\n", old_cmd, cmd);
> > > +             pci_dbg(dev, "enabling device (%04x -> %04x)\n", old_cmd, cmd);
> > >               pci_write_config_word(dev, PCI_COMMAND, cmd);
> > >       }
> > >       return 0;
> > > --
> > > 2.49.0.987.g0cc8ee98dc-goog
> > >
> >
> > --
> > மணிவண்ணன் சதாசிவம்

