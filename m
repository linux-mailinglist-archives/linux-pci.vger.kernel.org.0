Return-Path: <linux-pci+bounces-28033-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73A54ABCA71
	for <lists+linux-pci@lfdr.de>; Mon, 19 May 2025 23:57:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64F063ABE04
	for <lists+linux-pci@lfdr.de>; Mon, 19 May 2025 21:56:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C75AE3B280;
	Mon, 19 May 2025 21:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I+S4zATC"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A427120B1F4
	for <linux-pci@vger.kernel.org>; Mon, 19 May 2025 21:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747691764; cv=none; b=ikHaRZMTXtqq5rg2xlA3Yz51TqDxHusw0TZ25OMIJTHCoQ1wTEjTMZZgFLLt5Q0UHkYnwjgYXoaPLIc0P4KvOzsaQ0K/jFPLMrggrGmSEZzZEB4oAkt4IdgCgZA1fCr952OPs3iBB7+Xu0CNmv9sePWqgAykzr4cOwdoVgluZRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747691764; c=relaxed/simple;
	bh=W2sqkX/H9PTnbizHFiL9GZas6iw4LIyLOByROoqL2tM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=jzjht0z4u8SJM57zqlwIG/YvYyL0LHnZKt+zseqm/TZZmiUqz/QniQl5qsBhAYi8LbDXeP9Luw2A+onKh56g5xo8yiBzsjsCJrbMInYBh8Q4MV47juJf4OHcGU1zabkeSdTXMQhaw4MsdznAwl8+8z/Ee/yfZIybU+QlQQ1X8sI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I+S4zATC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7ED1C4CEE4;
	Mon, 19 May 2025 21:56:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747691764;
	bh=W2sqkX/H9PTnbizHFiL9GZas6iw4LIyLOByROoqL2tM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=I+S4zATCGmEuZ7fVQSq72Ncf8skYFxP8pMr2eD8dEkCZfsu4naSWcXU2+IQUI6+ev
	 Wt2k22KrTHSMi0Y4q4YPPGnzjiq9h9IAlGllRN9KsvA7HTJ2hAoJA8GtOBjM5Ax2Sf
	 UZLS+WmPiChnuWkbp1QKMo1g9r/hASkcnBpfJDB1Oh49BEj0zVS/SBoUkU3cPArKXZ
	 XEbWsUcJGEyPSoIEr2YgB9u7ZwjHm+/yT9X7+ltH+6SMk//e6BJ8xXDcaRxHhI0sOF
	 4J7ehgBgxvry9bXO8X7HiKLXgcZwQT7TbEoyLImNRY8xLfcZlQKFebeaaJ5u5Ybdw5
	 muwoDlGC9JPAw==
Date: Mon, 19 May 2025 16:56:01 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jim Quinlan <james.quinlan@broadcom.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	"open list:PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS" <linux-pci@vger.kernel.org>,
	'Cyril Brulebois <kibi@debian.org>,
	"maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE" <bcm-kernel-feedback-list@broadcom.com>,
	'Nicolas Saenz Julienne <nsaenz@kernel.org>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Subject: Re: POSSIBLE REGRESSION: PCI/pwrctrl: Skip scanning for the device
 further if pwrctrl device is created
Message-ID: <20250519215601.GA1258127@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+-6iNxkYumAvk5G6KhYqON9K3bwxGn+My-22KZnGF5Pg8cgfA@mail.gmail.com>

On Mon, May 19, 2025 at 03:59:10PM -0400, Jim Quinlan wrote:
> On Mon, May 19, 2025 at 2:25 PM Jim Quinlan <james.quinlan@broadcom.com> wrote:
> > On Mon, May 19, 2025 at 1:28 PM Manivannan Sadhasivam
> > <manivannan.sadhasivam@linaro.org> wrote:
> > > On Mon, May 19, 2025 at 09:05:57AM -0500, Bjorn Helgaas wrote:
> > > > On Mon, May 05, 2025 at 01:39:39PM -0400, Jim Quinlan wrote:
> > > > > Hello,
> > > > >
> > > > > I recently rebased to the latest Linux master
> > > > >
> > > > > ebd297a2affa Linus.Torvalds Merge tag 'net-6.15-rc5' of
> > > > > git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net
> > > > >
> > > > > and noticed that PCI is broken for
> > > > > "drivers/pci/controller/pcie-brcmstb.c"  I've bisected this
> > > > > to the following commit
> > > > >
> > > > > 2489eeb777af PCI/pwrctrl: Skip scanning for the device further if pwrctrl device is created
> > > > >
> > > > > which is part of the series [1].  The driver in
> > > > > pcie-brcmstb.c is expecting the add_bus() method to be
> > > > > invoked twice per boot-up, but the second call does not
> > > > > happen.  Not only does this code in brcm_pcie_add_bus() turn
> > > > > on regulators, it also subsequently initiates PCIe linkup.
> > > > >
> > > > > If I revert the aforementioned commit, all is well.
> > > > >
> > > > > FWIW, I have included the relevant sections of the PCIe DT
> > > > > we use at [2].
> > > >
> > > > Mani, Bartosz, where are we at with this?  The 2489eeb777af
> > > > commit log doesn't mention a problem fixed by that commit; it
> > > > sounds more like an optimization -- just avoiding an
> > > > unnecessary scan.
> > > >
> > > > 2489eeb777af appeared in v6.15-rc1, so there's still time to
> > > > revert it before v6.15 if that's the right way to fix this
> > > > regression.
> > >
> > > We need to find out what is happening in the pcie-brcmstb driver
> > > first. From Jim's report, it looks like the driver expects
> > > add_bus() callback to be invoked twice, which seems weird.
> >
> > The pci_ops add_bus() method is invoked once for bus 0 and once
> > for bus 1. Note that our controller only has one port.  If I do
> > "lspci" I get (our controller is on pci domain==1):
> >
> > 0001:00:00.0 PCI bridge: Broadcom Inc. and subsidiaries Device 7712 (rev 20)
> > 0001:01:00.0 Ethernet controller: Broadcom Inc. ...
> >
> > It is the second invocation of add_bus() that has the brcmstb
> > driver turning on the regulators and the subsequent link-up, and
> > this call never happens with the 2489eeb777aff9 commit.
> 
> Actually, I don't think it is sufficient to just revert that one
> commit.  If I checkout 6.14-rc1 and just bring in
> 
> 06bf05d7349c PCI/pwrctrl: Move creation of pwrctrl devices to pci_scan_device()

06bf05d7349c doesn't exist upstream; I assume it is 957f40d039a9
("PCI/pwrctrl: Move creation of pwrctrl devices to pci_scan_device()")

> I get the following after getting the Linux prompt:
> 
> pci 0001:00:00.0: deferred probe pending: pci: supplier
> 1000110000.pcie:pci@0,0 not ready
> pci 0001:00:00.0: deferred probe pending: pci: supplier
> 1000110000.pcie:pci@0,0 not ready
> 
> Basically, brcmstb already picks up and controls the regulator nodes
> under the port driver node.  You folks are adding a new generic
> system and we are stepping on one another's toes.  The problem here
> is that I cannot seem to turn your system off using CONFIG_PWR*
> settings.
> 
> We would certainly be open to adopting your system when it meets our
> requirements; such as turning off/on on regulators @suspend/resume,
> and the ability to not do that if the downstream device has
> device_may_wakeup(dev)==true.  But until then we need a way to
> disable your system or allow brcmstb to "opt out".
> 
> AFAICT this regression does not affect the RaspberryPi SoCs, so it
> is not a big deal for us if we take our time to fix this.   But if
> so, it is incumbent on you folks to help me get past this
> regression.  Is that reasonable?

What systems does the regression affect?

I'm not keen on adding any kind of regression in v6.15 if we can avoid
it.  Given that v6.15 will likely be released next weekend, I want to
revert whatever is necessary tomorrow unless there's a clear path to a
fix very soon.

You first thought reverting 2489eeb777af ("PCI/pwrctrl: Skip scanning
for the device further if pwrctrl device is created") would be enough
to avoid the regression.

But it sounds like something is broken even if you include only the
first patch of the branch (957f40d039a9 ("PCI/pwrctrl: Move creation
of pwrctrl devices to pci_scan_device()")).

Maybe this means we need to revert the entire branch:

  55d25a101d47 ("Merge branch 'pci/pwrctrl'")
  75996c92f4de ("PCI/pwrctrl: Add pwrctrl driver for PCI slots")
  2a95c1f3468b ("dt-bindings: vendor-prefixes: Document the 'pciclass' prefix")
  2489eeb777af ("PCI/pwrctrl: Skip scanning for the device further if pwrctrl device is created")
  2d923930f2e3 ("PCI/pwrctrl: Move pci_pwrctrl_unregister() to pci_destroy_dev()")
  957f40d039a9 ("PCI/pwrctrl: Move creation of pwrctrl devices to pci_scan_device()")

The only patch there that sounds like it might fix a defect is
2d923930f2e3 ("PCI/pwrctrl: Move pci_pwrctrl_unregister() to
pci_destroy_dev()").  I guess if this *does* fix a defect, the defect
only happens when removing a device, and dropping a defect fix is
better than adding a regression.

Guidance please.

> > > If the fix takes time, then we can revert 2489eeb777af in the meantime.
> > >
> > > - Mani
> > >
> > > --
> > > மணிவண்ணன் சதாசிவம்



