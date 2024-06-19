Return-Path: <linux-pci+bounces-8958-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C98B90E57A
	for <lists+linux-pci@lfdr.de>; Wed, 19 Jun 2024 10:28:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7D6E1F228A8
	for <lists+linux-pci@lfdr.de>; Wed, 19 Jun 2024 08:28:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85C2A77F2C;
	Wed, 19 Jun 2024 08:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EVyvkOSk"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B37479DC5;
	Wed, 19 Jun 2024 08:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718785702; cv=none; b=BD/yC+8/ZOfbDnIXkHSMLmn8PFQaaCovIYJLjylrotfK/t4fzlYnCuwymk6BtfSH2JoUipAILjL1jPzfwv9ifQ1xu2uH+M3diKW8OtuZ0SiDa79PsFXnuP6mR2B2kBVaQP6KwpIYphNm+saFNwafSMSqgmgrhkm0G/Ut6XxYeoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718785702; c=relaxed/simple;
	bh=3hEqTK+IEuFqv6+1xNOUjD5haWhaoWQwkY7fmu09xkw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lwoAGWfC7/mHEmmippxwnz5YUo6PAB34NSk1FPKCAJ17xv+Mn/aymXzvK3ML8fXsdbJTH0g2N/+YgEFSDpo8x3E5m17vMN6+77Zrwwzih+DFKHDX1xvGe7aTEUGs5DNta9wmzhGslNuYPSSc+qRps2Bh2mpa5FME6211bjhRNa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EVyvkOSk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43D7EC2BBFC;
	Wed, 19 Jun 2024 08:28:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718785702;
	bh=3hEqTK+IEuFqv6+1xNOUjD5haWhaoWQwkY7fmu09xkw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EVyvkOSkgaUtCioIn3NZ6WZEQa33F/0CT04L02wtdnuBhQ8LdDepouw9AlNfiSe6q
	 5huO/KvfEOuaT3rA6OuZKKA/kXLJegaRFspYjQPqwWKaCkwHgZLz76mExmwEXOl7ok
	 hKKGJm+2ikuV1etO1dLPB8CsU8Q6d/T2lPYaBfuCFTtNKnB7Dhx0Z3w1EkSnZanjwG
	 xxZe0s+bu9ZDVlUJf1ITJZ88OuygDwoMN94XFCPSrM0l9WY6Ak5/l0b4ObkSOYJ92R
	 +eviI0m0e6tR/7ki3Uvy0YKz2R2r0JzUGWKOl74UckOAmbwTIzito1bWQCPXVdibRu
	 0KWU2FQcq7VcQ==
Date: Wed, 19 Jun 2024 13:58:13 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>, Shunsuke Mie <mie@igel.co.jp>,
	linux-pci@vger.kernel.org, virtualization@lists.linux.dev,
	jasowang@redhat.com, xuanzhuo@linux.alibaba.com
Subject: Re: [RFC] Legacy Virtio Driver with Device Has Limited Memory Access
Message-ID: <20240619082813.GA3898@thinkpad>
References: <CANXvt5ojosFbt60Gcfym1DX96W7SiX4X15dMGdSCVEPhUTpk=w@mail.gmail.com>
 <20240618054115-mutt-send-email-mst@kernel.org>
 <CANXvt5psZAkEOJtxO250n6vjZTK7as-F-4qr1Rc3awZsmqWCpQ@mail.gmail.com>
 <20240618061705-mutt-send-email-mst@kernel.org>
 <CANXvt5pDjvVwFLS3p0a4hx1-MUJGsKHnpEsjejYUcmvTeKyFmg@mail.gmail.com>
 <20240618064231-mutt-send-email-mst@kernel.org>
 <CANXvt5pbdsSMc9C-nV0MiOAJPVyxXKu5otwLp2yopqBdNLS26A@mail.gmail.com>
 <20240619032703-mutt-send-email-mst@kernel.org>
 <20240619073929.GA8089@thinkpad>
 <20240619035655-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240619035655-mutt-send-email-mst@kernel.org>

On Wed, Jun 19, 2024 at 03:58:15AM -0400, Michael S. Tsirkin wrote:
> On Wed, Jun 19, 2024 at 01:09:29PM +0530, Manivannan Sadhasivam wrote:
> > On Wed, Jun 19, 2024 at 03:32:41AM -0400, Michael S. Tsirkin wrote:
> > > On Tue, Jun 18, 2024 at 09:51:41PM +0900, Shunsuke Mie wrote:
> > > > 2024年6月18日(火) 19:47 Michael S. Tsirkin <mst@redhat.com>:
> > > > >
> > > > > On Tue, Jun 18, 2024 at 07:40:34PM +0900, Shunsuke Mie wrote:
> > > > > > 2024年6月18日(火) 19:33 Michael S. Tsirkin <mst@redhat.com>:
> > > > > > >
> > > > > > > On Tue, Jun 18, 2024 at 07:15:47PM +0900, Shunsuke Mie wrote:
> > > > > > > > Thank you for your response.
> > > > > > > >
> > > > > > > > 2024年6月18日(火) 18:47 Michael S. Tsirkin <mst@redhat.com>:
> > > > > > > > >
> > > > > > > > > On Tue, Jun 18, 2024 at 08:41:09AM +0900, Shunsuke Mie wrote:
> > > > > > > > > > Let's clarify the situation.
> > > > > > > > > >
> > > > > > > > > > The Virtio device and driver are not working properly due to a
> > > > > > > > > > combination of the following reasons:
> > > > > > > > > >
> > > > > > > > > > 1. Regarding VIRTIO_F_ACCESS_PLATFORM:
> > > > > > > > > > - The modern spec includes VIRTIO_F_ACCESS_PLATFORM, which allows
> > > > > > > > > > Physical DMAC to be used.
> > > > > > > > > > - This feature is not available in the legacy spec.
> > > > > > > > >
> > > > > > > > > ... because legacy drivers don't set it
> > > > > > > > >
> > > > > > > > > > 2. Regarding Virtio PCIe Capability:
> > > > > > > > > > - The modern spec requires Virtio PCIe Capability.
> > > > > > > > >
> > > > > > > > > It's a PCI capability actually. People have been asking
> > > > > > > > > about option to make it a pcie extended capability,
> > > > > > > > > but no one did the spec, qemu and driver work, yet.
> > > > > > > > >
> > > > > > > > > > - In some environments, Virtio PCIe Capability cannot be provided.
> > > > > > > > >
> > > > > > > > > why not?
> > > > > > > > PCIe Endpoint Controller chips are available from several vendors and allow
> > > > > > > > software to describe the behavior of PCIe Endpoint functions. However, they
> > > > > > > > offer only limited functionality. Specifically, while PCIe bus communication is
> > > > > > > > programmable, PCIe Capabilities are fixed and cannot be made to show as
> > > > > > > > virtio's.
> > > > > > >
> > > > > > > Okay. So where could these structures live, if not in pci config?
> > > > > > What does "these structures" refer to? PCIe Capabilities? virtio configs?
> > > > >
> > > > > Virtio uses a bunch of read only structures that look like this:
> > > > >
> > > > > struct virtio_pci_cap {
> > > > >
> > > > >         ..... [skipped, specific to pci config caps] ...
> > > > >
> > > > >         u8 cfg_type;    /* Identifies the structure. */
> > > > >         u8 bar;         /* Where to find it. */
> > > > >         u8 id;          /* Multiple capabilities of the same type */
> > > > >         u8 padding[2];  /* Pad to full dword. */
> > > > >         le32 offset;    /* Offset within bar. */
> > > > >         le32 length;    /* Length of the structure, in bytes. */
> > > > > };
> > > > >
> > > > >
> > > > > The driver uses that to locate parts of device interface it
> > > > > later uses.
> > > > >
> > > > >
> > > > > Per spec, they are currently in pci config, you are saying some devices
> > > > > can't have this data in pci config - is that right? Where yes?
> > > > I understood. The configuration structure is in the space that is
> > > > indicated by BAR0.
> > > > Follows the instructions in the spec:
> > > > ```
> > > > 4.1.4.10 Legacy Interfaces: A Note on PCI Device Layout
> > > > Transitional devices MUST present part of configuration registers in a
> > > > legacy configuration structure in BAR0 in the first I/O region of the
> > > > PCI device, as documented below.
> > > > ...
> > > > ```
> > > 
> > > No, and it's best everyone stopped talking about legacy like we
> > > are going to add new features to it.
> > > 
> > > The configuration structure is in the space that is
> > > indicated by the vendor specific structure, which is currently
> > > in pci config space.
> > > 
> > > If use of a vendor specific structure in pci config space is
> > > problematic, we can try to fix that by extending the virtio spec.
> > > 
> > 
> > It is indeed problematic as the device vendors usually use those capability
> > registers themselves and wouldn't allow users to configure them.
> > 
> > So if the spec is ammended to support other way of finding the virtio config
> > structures, then it would really unblock us from supporting modern virtio
> > devices.
> > 
> > - Mani
> 
> Okay.
> Anyone from your side can join the virtio TC to champion this?
> We don't have anyone knowledgeable about this protocol ATM AFAIK.
> 

Sure. Myself/Shunsuke can join and help with this.

Shunsuke did the Virtio bringup for PCI Endpoint subsystem and I'm the
maintainer for it.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

