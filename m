Return-Path: <linux-pci+bounces-16054-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B97D49BD0EA
	for <lists+linux-pci@lfdr.de>; Tue,  5 Nov 2024 16:46:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72A551F23209
	for <lists+linux-pci@lfdr.de>; Tue,  5 Nov 2024 15:46:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8985471747;
	Tue,  5 Nov 2024 15:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IuGugbab"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63FFA38DD6
	for <linux-pci@vger.kernel.org>; Tue,  5 Nov 2024 15:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730821563; cv=none; b=k/bd8uemI77DzDc6GMKPr4YEJUQddkaGNNFJgCDg+K8ypFahdE5xQbBfahV1gNUAICHfL/zc41miGT90xamFZ7w7ypfxjUj7reuofBu6NvxLYx6AwyRDcfZd6EIUliPAkKLijxxLin4bbrnd9J4i16thVShohcPKikM3WHbyiPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730821563; c=relaxed/simple;
	bh=dVNV3mY3lSWMvc+miJlPWH/1SZ74PLbAIigEMIxKtKM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g8dvzidIuMj3nnUVuz1d+mkqSKal9Uia04PYtvzToXznuuf+cBod47QqdGS8cymPIWCFKVaTqBJZ9q43/xO9UX93Oq0ei1B9ACNpLxZvs8NJxpvzji+mx+de+8z8eAkEJ/0IlWmp+NU10ucOHLFlzWKY4mDVSnx+UD2Civz+AmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IuGugbab; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86AD1C4CECF;
	Tue,  5 Nov 2024 15:46:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730821563;
	bh=dVNV3mY3lSWMvc+miJlPWH/1SZ74PLbAIigEMIxKtKM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IuGugbabVqYbgzBjPj+i46u6wkPk5scbyGPJ7+4HXouxzNTJNS6EHBih/QW2+vfzc
	 IzcUmYQTqcGMndQH7PeLhuboevjEH66WFASDtzHsbgcLSfxl9y9A5tL+6CL4oY2Lp6
	 94StMMzOMBXUX8b3ZCgb8LEFcgWNADzRj+0RQkL0WyywIZd2aoI6/Ua+s2SLh3e8wY
	 K1+kwq4Wfe2P7B2XkgFZKbVkd/ftw3hBuFSimVbKz5LHBAbLo1qTC/143/Q4tU360j
	 9jHZ0N6GQAAfgy10wDP6QJ4mrmsMqlB32+e+ju1atohnSzUOcGufBp6HQ0J2YR8oAU
	 e4aZP4KBrHN5A==
Date: Tue, 5 Nov 2024 08:46:00 -0700
From: Keith Busch <kbusch@kernel.org>
To: Niklas Schnelle <schnelle@linux.ibm.com>
Cc: Keith Busch <kbusch@meta.com>, linux-pci@vger.kernel.org,
	bhelgaas@google.com, alex.williamson@redhat.com,
	ameynarkhede03@gmail.com, raphael.norwitz@nutanix.com
Subject: Re: [PATCHv2 2/2] pci: warn if a running device is unaware of reset
Message-ID: <Zyo9uD3yoe3ARrij@kbusch-mbp.dhcp.thefacebook.com>
References: <20241025222755.3756162-1-kbusch@meta.com>
 <20241025222755.3756162-2-kbusch@meta.com>
 <471500804dff90f31320a2a53a48724fffe318b6.camel@linux.ibm.com>
 <ZyUqKquBudn3hh5_@kbusch-mbp.dhcp.thefacebook.com>
 <d69d959038c80026a3f21811a126676d2b25b7c3.camel@linux.ibm.com>
 <Zyj9-1kB3VhL6iZR@kbusch-mbp>
 <d465ab2d93a9c115df18f0575ecfd1c2679d9464.camel@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d465ab2d93a9c115df18f0575ecfd1c2679d9464.camel@linux.ibm.com>

On Tue, Nov 05, 2024 at 01:28:39PM +0100, Niklas Schnelle wrote:
> On Mon, 2024-11-04 at 10:01 -0700, Keith Busch wrote:
> > On Mon, Nov 04, 2024 at 10:44:23AM +0100, Niklas Schnelle wrote:
> > > 
> > > One more question though, what would happen with this reset for a bus
> > > with an SR-IOV device with more than 256 VFs i.e. where
> > > pci_iov_virtfn_bus() returns anything other than 0. I'm guessing since
> > > VFs are physically still controlled by the bridge all VFs would be
> > > reset but at the same time virtfn_add_bus() sets the bridge device for
> > > the added bus as NULL so I think it might look odd in sysfs, sadly I
> > > don't have such a device to test with. Still, this might actually be an
> > > argument for having the attribute on the bridge.
> > 
> > I assume everything is reset at the PCI level.
> > 
> > Are you asking what the kernel does? I don't think it does anything
> > special with SR-IOV functions. Those pci_dev's aren't attached to the
> > bridge pci_dev; you have to go through the pci_bus' children instead.
> > 
> 
> I just want to make sure we're okay with the behavior with such VFs as
> it seems like the one case where a reset via the bridge affects PCI
> functions which aren't attached to the bridge pci_dev otherwise. And
> for example as I understand it these would not be covered by the
> pci_bus_save_and_disable_locked().

Well, it's no different than doing FLR to the PF while VFs are
configured, which is existing behavior, so I think it's okay. The PF's
SRIOV state still gets restored to the end of the reset. The VFs
themselves don't get saved and locked, though. But again, this new patch
is following how it already works for other reset methods.

