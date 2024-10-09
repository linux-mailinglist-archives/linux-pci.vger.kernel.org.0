Return-Path: <linux-pci+bounces-14113-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FD11997879
	for <lists+linux-pci@lfdr.de>; Thu, 10 Oct 2024 00:24:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6092E1C21580
	for <lists+linux-pci@lfdr.de>; Wed,  9 Oct 2024 22:24:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E76C21E32C2;
	Wed,  9 Oct 2024 22:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ciayY5H6"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC5EA19923C;
	Wed,  9 Oct 2024 22:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728512646; cv=none; b=GM/njAk5nij07jeH3fpwZKcRKInT8ch3QWZLwptdLX7XqXijO4BA0gWnDAEuQs+HHywpcK9bBWAm21FWgtzsD5E0MB2yxEO0W50+ORQRaaWFFQd/8llA3giewnh5RyE8ilbRchM8k3ZcY7q6hWmQahQEVF3N/Zo4H9XhCcgt4+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728512646; c=relaxed/simple;
	bh=Q1IRoaSIpPaBToI0HSWzg6kfGu2RhTlvkYSuzXw7Tc0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=fSqDTO1sqaI8wUtMMIqArHQ2w25ucQh4vC0F5bw1UsrMqu9FnfYc1zxvAb9Ys38Mz/0sXspv7FBtGQ/xV4xfQZWR6M0JG1mauct6RBJb9rgEtLfk1J86uxIg1EcletJnKbRaw5g6MkTNQtt/ifh8UBIzOFNgrgUkmD1YkUxzqgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ciayY5H6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4189AC4CECC;
	Wed,  9 Oct 2024 22:24:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728512645;
	bh=Q1IRoaSIpPaBToI0HSWzg6kfGu2RhTlvkYSuzXw7Tc0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=ciayY5H63RROmQEDj/ybuztTAOuK2JyjBZwr1S6BCB+ABhoNGcr32/uVlrV68Eh33
	 K0u51+jxwUGn9ETCjcJ7vF7oP+mIA5H/QpFyzbLk4l6rmxw7haIyYMCWMj7r81N60X
	 hHwP6cSPUC2c5FMH0GHtpJryayTtxc1f31A66PJYbl8fyTsWcbTXv8/EMkW8qEKAK0
	 PqhdRfkm1lal8eY8G+mtkAvL9Jm4uHhuI/pD0jKsO+B6Ho59FxXng0OQyuYjjQgKfB
	 maEyLQ8Rg/XYlUScqBjxaUMrLJUwTfeqkd0DJjBKqTzKk3a7vZS2bGrxD9rDXIX95j
	 S9t7sNnQmTxZA==
Date: Wed, 9 Oct 2024 17:24:03 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Kai-Heng Feng <kaihengfeng@gmail.com>, bhelgaas@google.com,
	mario.limonciello@amd.com, linux-pci@vger.kernel.org,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] PCI/PM: Put devices to low power state on shutdown
Message-ID: <20241009222403.GA507767@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240913080123.GP275077@black.fi.intel.com>

On Fri, Sep 13, 2024 at 11:01:23AM +0300, Mika Westerberg wrote:
> On Fri, Sep 13, 2024 at 02:00:58PM +0800, Kai-Heng Feng wrote:
> > On Fri, Sep 13, 2024 at 12:57 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > On Thu, Sep 12, 2024 at 11:00:43AM +0800, Kai-Heng Feng wrote:
> > > > On Thu, Sep 12, 2024 at 3:05 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > > > On Fri, Jul 12, 2024 at 02:24:11PM +0800, Kai-Heng Feng wrote:
> > > > > > Some laptops wake up after poweroff when HP Thunderbolt
> > > > > > Dock G4 is connected.
> > > > > >
> > > > > > The following error message can be found during shutdown:
> > > > > > pcieport 0000:00:1d.0: AER: Correctable error message received from 0000:09:04.0
> > > > > > pcieport 0000:09:04.0: PCIe Bus Error: severity=Correctable, type=Data Link Layer, (Receiver ID)
> > > > > > pcieport 0000:09:04.0:   device [8086:0b26] error status/mask=00000080/00002000
> > > > > > pcieport 0000:09:04.0:    [ 7] BadDLLP
> > > > > >
> > > > > > Calling aer_remove() during shutdown can quiesce the error
> > > > > > message, however the spurious wakeup still happens.
> > > > > >
> > > > > > The issue won't happen if the device is in D3 before
> > > > > > system shutdown, so putting device to low power state
> > > > > > before shutdown to solve the issue.
> > > > > >
> > > > > > I don't have a sniffer so this is purely guesswork,
> > > > > > however I believe putting device to low power state it's
> > > > > > the right thing to do.
> > > > >
> > > > > My objection here is that we don't have an explanation of
> > > > > why this should matter or a pointer to any spec language
> > > > > about this situation, so it feels a little bit random.
> ...

> I don't mean to confuse you guys but with this one too, I wonder if you
> tried to "disable" the device instead of putting it into D3? On another
> thread (Mario at least is aware of this) I mentioned that our PCIe SV
> folks identified a couple issues in Linux implementation around power
> management and one thing that we are missing is to disable I/O and MMIO
> upon entering D3.
> ...

This is really interesting -- did they discover a functional problem,
or did they just notice that we don't follow the PCI PM spec?

> +++ b/drivers/pci/pci.c
> @@ -2218,6 +2218,13 @@ static void do_pci_disable_device(struct pci_dev *dev)
>  		pci_command &= ~PCI_COMMAND_MASTER;
>  		pci_write_config_word(dev, PCI_COMMAND, pci_command);
>  	}
> +	/*
> +	 * PCI PM 1.2 sec 8.2.2 says that when a function is put into D3
> +	 * the OS needs to disable I/O and MMIO space in addition to bus
> +	 * mastering so do that here.
> +	 */
> +	pci_command &= ~(PCI_COMMAND_IO | PCI_COMMAND_MEMORY);
> +	pci_write_config_word(dev, PCI_COMMAND, pci_command);
>  
>  	pcibios_disable_device(dev);
>  }

This do_pci_disable_device() proposal is interesting.

pci_enable_device() turns on PCI_COMMAND_MEMORY and PCI_COMMAND_IO,
which enables the device to respond to MMIO and I/O port accesses to
its BARs from the driver.  It also makes sure the device is in D0,
because BAR access only works in D0.

pci_set_master() turns on PCI_COMMAND_MASTER, which enables the device
to perform DMA (including generating MSIs).

pci_disable_device() *sounds* like it should be the opposite of
pci_enable_device(), but it's currently basically the same as
pci_clear_master(), which clears PCI_COMMAND_MASTER to prevent DMA.
I didn't know about this text in 8.2.2, and I wish I knew why we
don't currently clear PCI_COMMAND_MEMORY and PCI_COMMAND_IO.

If we want to pursue this, I think it should be split to its own patch
and moved out of pci_disable_device() because I don't think this path
necessary implies putting the device in D3, so I think it would fit
better with the spec if we cleared PCI_COMMAND_MEMORY and
PCI_COMMAND_IO in a path that explicitly does put it in D3.

I think there's a significant chance of breaking something because
drivers are currently able to access BARs after pci_disable_device(),
and there are a LOT of callers.  But if there's a problem it would
fix, we should definitely explore it.

Bjorn

