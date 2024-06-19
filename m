Return-Path: <linux-pci+bounces-8955-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F0A9190E4B5
	for <lists+linux-pci@lfdr.de>; Wed, 19 Jun 2024 09:39:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3CA41F2182D
	for <lists+linux-pci@lfdr.de>; Wed, 19 Jun 2024 07:39:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0B22770E3;
	Wed, 19 Jun 2024 07:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MRS2Hlz6"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C68AD762D0;
	Wed, 19 Jun 2024 07:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718782782; cv=none; b=dtDzuO507JWB79wCAeQ+L7LgOXJjLDhItHxH/qO7jnuKncdTyImDVlgOrNtBr57vhm6r4Xrh5oT7HKHfsonDEBt/32vy3aaa9X57ZCcZCRreUFYIfk/M6YrZf+ly5XrgQrSapebbXbfmanzX2WQF76p84Emgznmwt40CRX8DggY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718782782; c=relaxed/simple;
	bh=yd+Qbx4nPTQvmMaz4GGDPZxPEMS3R3XkEgFtDmeS1FY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fo4SLqOgLO200VFBR3JDvfOK7H0lVyCQzH3aZpRqDHmCl/j0ad+rYjRNhrytCPLs6Z2Pwa6Q8lU7lIIT0mCw3GRcegM7s0s8uSZL3ycevJRsu7VrdoPP568yBMrJ1a3UViXoYANjzYKQ7mPDJWE0KUFUWhHTxqWQeY6sQ0uszvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MRS2Hlz6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EE15C32786;
	Wed, 19 Jun 2024 07:39:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718782782;
	bh=yd+Qbx4nPTQvmMaz4GGDPZxPEMS3R3XkEgFtDmeS1FY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MRS2Hlz6dUGUgEyGGQ9LXICgWCxYjyWYGQqiAqj+m/v5cAT93NNkFpmHiFZvnbDz7
	 3vF2/nI5TPi3+3JnNRk1/p8nOQSUwmHqgY0rc1k9Xc6vg9efN/VdpXLEYUfIOCON1z
	 4BA2SwxbrhiXw9cb65AqmaMp+C1zjzj1WqT4ni5P/vTCdw7STSVoNG2Upa0SG3NSPJ
	 iF6hcB5b8LjYYNaZGdSxJirOfxzygHAY+QhnOdAmtcE1bYLwqniWRYcY5TrdP2m9Xz
	 NIqJVSF2VPEI8p497O+j1l6Q/ChPLjjEMlNATf9L1PVbGYHd0sDRlraCtw/w84GDQa
	 j6+3VxfA+wrGw==
Date: Wed, 19 Jun 2024 13:09:29 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Shunsuke Mie <mie@igel.co.jp>, Manivannan Sadhasivam <mani@kernel.org>,
	linux-pci@vger.kernel.org, virtualization@lists.linux.dev,
	jasowang@redhat.com, xuanzhuo@linux.alibaba.com
Subject: Re: [RFC] Legacy Virtio Driver with Device Has Limited Memory Access
Message-ID: <20240619073929.GA8089@thinkpad>
References: <20240520090809-mutt-send-email-mst@kernel.org>
 <20240614095033.GA59574@thinkpad>
 <CANXvt5ojosFbt60Gcfym1DX96W7SiX4X15dMGdSCVEPhUTpk=w@mail.gmail.com>
 <20240618054115-mutt-send-email-mst@kernel.org>
 <CANXvt5psZAkEOJtxO250n6vjZTK7as-F-4qr1Rc3awZsmqWCpQ@mail.gmail.com>
 <20240618061705-mutt-send-email-mst@kernel.org>
 <CANXvt5pDjvVwFLS3p0a4hx1-MUJGsKHnpEsjejYUcmvTeKyFmg@mail.gmail.com>
 <20240618064231-mutt-send-email-mst@kernel.org>
 <CANXvt5pbdsSMc9C-nV0MiOAJPVyxXKu5otwLp2yopqBdNLS26A@mail.gmail.com>
 <20240619032703-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240619032703-mutt-send-email-mst@kernel.org>

On Wed, Jun 19, 2024 at 03:32:41AM -0400, Michael S. Tsirkin wrote:
> On Tue, Jun 18, 2024 at 09:51:41PM +0900, Shunsuke Mie wrote:
> > 2024年6月18日(火) 19:47 Michael S. Tsirkin <mst@redhat.com>:
> > >
> > > On Tue, Jun 18, 2024 at 07:40:34PM +0900, Shunsuke Mie wrote:
> > > > 2024年6月18日(火) 19:33 Michael S. Tsirkin <mst@redhat.com>:
> > > > >
> > > > > On Tue, Jun 18, 2024 at 07:15:47PM +0900, Shunsuke Mie wrote:
> > > > > > Thank you for your response.
> > > > > >
> > > > > > 2024年6月18日(火) 18:47 Michael S. Tsirkin <mst@redhat.com>:
> > > > > > >
> > > > > > > On Tue, Jun 18, 2024 at 08:41:09AM +0900, Shunsuke Mie wrote:
> > > > > > > > Let's clarify the situation.
> > > > > > > >
> > > > > > > > The Virtio device and driver are not working properly due to a
> > > > > > > > combination of the following reasons:
> > > > > > > >
> > > > > > > > 1. Regarding VIRTIO_F_ACCESS_PLATFORM:
> > > > > > > > - The modern spec includes VIRTIO_F_ACCESS_PLATFORM, which allows
> > > > > > > > Physical DMAC to be used.
> > > > > > > > - This feature is not available in the legacy spec.
> > > > > > >
> > > > > > > ... because legacy drivers don't set it
> > > > > > >
> > > > > > > > 2. Regarding Virtio PCIe Capability:
> > > > > > > > - The modern spec requires Virtio PCIe Capability.
> > > > > > >
> > > > > > > It's a PCI capability actually. People have been asking
> > > > > > > about option to make it a pcie extended capability,
> > > > > > > but no one did the spec, qemu and driver work, yet.
> > > > > > >
> > > > > > > > - In some environments, Virtio PCIe Capability cannot be provided.
> > > > > > >
> > > > > > > why not?
> > > > > > PCIe Endpoint Controller chips are available from several vendors and allow
> > > > > > software to describe the behavior of PCIe Endpoint functions. However, they
> > > > > > offer only limited functionality. Specifically, while PCIe bus communication is
> > > > > > programmable, PCIe Capabilities are fixed and cannot be made to show as
> > > > > > virtio's.
> > > > >
> > > > > Okay. So where could these structures live, if not in pci config?
> > > > What does "these structures" refer to? PCIe Capabilities? virtio configs?
> > >
> > > Virtio uses a bunch of read only structures that look like this:
> > >
> > > struct virtio_pci_cap {
> > >
> > >         ..... [skipped, specific to pci config caps] ...
> > >
> > >         u8 cfg_type;    /* Identifies the structure. */
> > >         u8 bar;         /* Where to find it. */
> > >         u8 id;          /* Multiple capabilities of the same type */
> > >         u8 padding[2];  /* Pad to full dword. */
> > >         le32 offset;    /* Offset within bar. */
> > >         le32 length;    /* Length of the structure, in bytes. */
> > > };
> > >
> > >
> > > The driver uses that to locate parts of device interface it
> > > later uses.
> > >
> > >
> > > Per spec, they are currently in pci config, you are saying some devices
> > > can't have this data in pci config - is that right? Where yes?
> > I understood. The configuration structure is in the space that is
> > indicated by BAR0.
> > Follows the instructions in the spec:
> > ```
> > 4.1.4.10 Legacy Interfaces: A Note on PCI Device Layout
> > Transitional devices MUST present part of configuration registers in a
> > legacy configuration structure in BAR0 in the first I/O region of the
> > PCI device, as documented below.
> > ...
> > ```
> 
> No, and it's best everyone stopped talking about legacy like we
> are going to add new features to it.
> 
> The configuration structure is in the space that is
> indicated by the vendor specific structure, which is currently
> in pci config space.
> 
> If use of a vendor specific structure in pci config space is
> problematic, we can try to fix that by extending the virtio spec.
> 

It is indeed problematic as the device vendors usually use those capability
registers themselves and wouldn't allow users to configure them.

So if the spec is ammended to support other way of finding the virtio config
structures, then it would really unblock us from supporting modern virtio
devices.

- Mani

> 
> > >
> > > > > --
> > > > > MST
> > > > >
> > >
> 

-- 
மணிவண்ணன் சதாசிவம்

