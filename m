Return-Path: <linux-pci+bounces-42584-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 14C6DCA15C7
	for <lists+linux-pci@lfdr.de>; Wed, 03 Dec 2025 20:25:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BC5CB306A522
	for <lists+linux-pci@lfdr.de>; Wed,  3 Dec 2025 19:02:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0E8B311C0C;
	Wed,  3 Dec 2025 19:02:10 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA41230276C;
	Wed,  3 Dec 2025 19:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764788530; cv=none; b=dFsUNAF2Q6Rb1nn9NJ53XjwlwVwUezd4ys2HpkUZeM11h/YlLAfLAf21w3ENWFTdW4tnGyJA9dgnMYLasFISN1FTM0kXXS1HL1RlAJqKTZAHqeRR6/Ls39gDXzVDpHT3b/HRyQ0hZCz1Bf1yz2/olKBFe0KsgejdazynsyFJEjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764788530; c=relaxed/simple;
	bh=go3957KV9/2wa+Ez/UqBIDGHcNXCQlNNb4ypCcMVKIA=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=JufVWv1PRBed2MzbNamVF5cwXo56eygq0vAXjstJLMQRCBHFG5iccvplOKC/CQJ4Y5OzR0/ChtFZrZ55IKGtQ1rpDjLdPJRvzWHUw3f/VHtATWKI3jciFGsY4SEmEzpNjaofZzh1Qn+UcqVIN6OE44O2zMC6TiSwcK6m8nXWCaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id 8CDB092009C; Wed,  3 Dec 2025 20:01:57 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id 86A5A92009B;
	Wed,  3 Dec 2025 19:01:57 +0000 (GMT)
Date: Wed, 3 Dec 2025 19:01:57 +0000 (GMT)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
cc: ALOK TIWARI <alok.a.tiwari@oracle.com>, 
    Bjorn Helgaas <bhelgaas@google.com>, 
    Matthew W Carlis <mattc@purestorage.com>, ashishk@purestorage.com, 
    msaggi@purestorage.com, sconnor@purestorage.com, 
    Lukas Wunner <lukas@wunner.de>, Jiwei <jiwei.sun.bj@qq.com>, 
    guojinhui.liam@bytedance.com, ahuang12@lenovo.com, sunjw10@lenovo.com, 
    linux-pci@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [External] : [PATCH] PCI: Always lift 2.5GT/s restriction in
 PCIe failed link retraining
In-Reply-To: <b92ab615-75f6-8606-cb3b-75fe03a1d9a9@linux.intel.com>
Message-ID: <alpine.DEB.2.21.2512031836150.49654@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2511290245460.36486@angie.orcam.me.uk> <3be03057-2a83-46e5-b120-bb041208c694@oracle.com> <b92ab615-75f6-8606-cb3b-75fe03a1d9a9@linux.intel.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Tue, 2 Dec 2025, Ilpo Järvinen wrote:

> > > linux-pcie-failed-link-retrain-unclamp-always.diff
> > > Index: linux-macro/drivers/pci/quirks.c
> > > ===================================================================
> > > --- linux-macro.orig/drivers/pci/quirks.c
> > > +++ linux-macro/drivers/pci/quirks.c
> > 
> > Thanks a lot for your patch.
> > The patch works, and the issue has been resolved in our testing.

 Great, thanks for running the verification!

> > However, this patch does not cleanly apply to the 6.12 LTS kernel.
> > To apply the fix cleanly, a series of patches is required.
> > 
> > PCI: Always lift 2.5GT/s restriction in PCIe failed link retraining
> > 2389d8dc38fee PCI/bwctrl: Replace lbms_count with PCI_LINK_LBMS_SEEN flag
> > 15b8968dcb90f PCI/bwctrl: Fix NULL pointer deref on unbind and bind
> > e3f30d563a388 PCI: Make pci_destroy_dev() concurrent safe
> > 667f053b05f00 PCI/bwctrl: Fix NULL pointer dereference on bus number
> > exhaustion
> > e93d9fcfd7dc6 PCI: Refactor pcie_update_link_speed()
> > 9989e0ca7462c PCI: Fix link speed calculation on retrain failure
> > b85af48de3ece PCI: Adjust the position of reading the Link Control 2 register
> > 026e4bffb0af9 PCI/bwctrl: Fix pcie_bwctrl_select_speed() return type
> > d278b098282d1 thermal: Add PCIe cooling driver
> > de9a6c8d5dbfe PCI/bwctrl: Add pcie_set_target_speed() to set PCIe Link Speed
> > 665745f274870 PCI/bwctrl: Re-add BW notification portdrv as PCIe BW controller
> > 3491f50966686 PCI: Abstract LBMS seen check into pcie_lbms_seen()

 Thank you for identifying the dependencies.  Clearly the majority of the 
changes is not functionally related to this fix at all and any need for 
them is purely mechanical.

> As the change has a Fixes tag, stable maintainers will eventually get to 
> it (after the change has progressed into Linus' tree).
> 
> As per usual, if the patch won't apply to some old kernel version cleanly, 
> stable maintainers will decide themselves whether they end up taking some
> extra changes or ask for a backport from the submitter of the original 
> change.

 Dependencies can be listed if need be along with a backport request.  
However in this case there have been lots of syntactic updates to this 
function, which do not necessarily qualify for backporting, as that is 
supposed to include critical fixes only.  Certainly changes to prevent 
systems from breaking do qualify, but helper macros and functions, or code 
restructuring do not.

 Since I'm going to wait for further feedback and respin anyway, I will 
check if there are critical dependencies required that are missing on the 
stable branches and list any along with the backport request.  Then any 
remaining syntactic sugar can, as you say, be handled on a case by case 
basis in the backport process.

  Maciej

