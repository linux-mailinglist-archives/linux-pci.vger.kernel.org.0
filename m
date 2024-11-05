Return-Path: <linux-pci+bounces-16018-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B71CE9BC1D5
	for <lists+linux-pci@lfdr.de>; Tue,  5 Nov 2024 01:10:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9E641C210CD
	for <lists+linux-pci@lfdr.de>; Tue,  5 Nov 2024 00:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9858C383;
	Tue,  5 Nov 2024 00:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TLjgk9AL"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 707AAAD51;
	Tue,  5 Nov 2024 00:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730765430; cv=none; b=glCPKLVrskwLUtSVHu3L8sDnJtyYj7Inl8MUii71JguuBthKjWXKWiMqINCZ24oG19GFuIrLBBV6Ky0NVrPjPMhLIECx2KPNkDGcseTGrAJYHrdh8SYVL8xgHCao677pgLJWtbvuDnbnRdD8uPu0tPYBhhN5xy6qrIv8821V0UM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730765430; c=relaxed/simple;
	bh=1PZtNyhB5M5weBUBBQDdgStBwqsY04q1zWaOCxm7ULs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=kVWcPKQk7yMLEZ/+p8n1fLaV1F5YlCW7QZEf8Hf1U+TGlXjNZYyheDKAzzQmDIjDHxayzWA8Gls0C5VGtseEsahevEZwd2s26IFIpppdAR7bGS7Q/3dPDcxa5tJ7/iiL2EuAzeHabNwM5w8uUCCTNmqswl6fbSIqq5wbTskltlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TLjgk9AL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4BCBC4CECE;
	Tue,  5 Nov 2024 00:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730765430;
	bh=1PZtNyhB5M5weBUBBQDdgStBwqsY04q1zWaOCxm7ULs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=TLjgk9ALqIbJNb0yCC2QkLYWeyQXRMZB3nHoLJTVQCJLPjb3JSAZSLdzRdnV4s1kt
	 7rLq1kcUSWSvIh+3rPeN2ZBbHcidp2ZI3xKEaGkJ5Rkll9w/UfYquqOjKwxLQ+zwMx
	 n5wXZD2seaDufQb5OQOrodgnMWnMZoi3jt3WXvQSy11y2fpqXZrzmMDI5cnfkb3tyg
	 K8wM7z0DqezAp5WHmKg0622Le83MlSzsRw03D5ZF0mMXFlMi9PH8z4Rlp5cgfhyUaf
	 fgZl39+tF7XwmH0L5+BwYwap9uCBEZGhrlWbMDLCR8BnLDDXHpVECIUQW5ggjgMFum
	 M15KfcYyH6iDQ==
Date: Mon, 4 Nov 2024 18:10:27 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Leon Romanovsky <leon@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	linux-pci@vger.kernel.org, Ariel Almog <ariela@nvidia.com>,
	Aditya Prabhune <aprabhune@nvidia.com>,
	Hannes Reinecke <hare@suse.de>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Arun Easi <aeasi@marvell.com>, Jonathan Chocron <jonnyc@amazon.com>,
	Bert Kenward <bkenward@solarflare.com>,
	Matt Carlson <mcarlson@broadcom.com>,
	Kai-Heng Feng <kai.heng.feng@canonical.com>,
	Jean Delvare <jdelvare@suse.de>,
	Alex Williamson <alex.williamson@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI/sysfs: Fix read permissions for VPD attributes
Message-ID: <20241105001027.GA1447341@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241103123344.GA42867@unreal>

On Sun, Nov 03, 2024 at 02:33:44PM +0200, Leon Romanovsky wrote:
> On Fri, Nov 01, 2024 at 11:47:37AM -0500, Bjorn Helgaas wrote:
> > On Fri, Nov 01, 2024 at 04:33:00PM +0200, Leon Romanovsky wrote:
> > > On Thu, Oct 31, 2024 at 06:22:52PM -0500, Bjorn Helgaas wrote:
> > > > On Tue, Oct 29, 2024 at 07:04:50PM -0500, Bjorn Helgaas wrote:
> > > > > On Mon, Oct 28, 2024 at 10:05:33AM +0200, Leon Romanovsky wrote:
> > > > > > From: Leon Romanovsky <leonro@nvidia.com>
> > > > > > 
> > > > > > The Virtual Product Data (VPD) attribute is not readable by regular
> > > > > > user without root permissions. Such restriction is not really needed,
> > > > > > as data presented in that VPD is not sensitive at all.
> > > > > > 
> > > > > > This change aligns the permissions of the VPD attribute to be accessible
> > > > > > for read by all users, while write being restricted to root only.
> > > > > > 
> > > > > > Cc: stable@vger.kernel.org
> > > > > > Fixes: d93f8399053d ("PCI/sysfs: Convert "vpd" to static attribute")
> > > > > > Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> > > > > 
> > > > > Applied to pci/vpd for v6.13, thanks!
> > > > 
> > > > I think this deserves a little more consideration than I gave it
> > > > initially.
> > > > 
> > > > Obviously somebody is interested in using this; can we include some
> > > > examples so we know there's an actual user?
> > > 
> > > I'll provide it after the weekend.
> 
> As it is seen through lspci, nothing criminal here.
> 08:00.0 Ethernet controller: Mellanox Technologies MT2910 Family [ConnectX-7]
> ...
>         Capabilities: [48] Vital Product Data
>                 Product Name: NVIDIA ConnectX-7 HHHL adapter Card, 200GbE / NDR200 IB, Dual-port QSFP112, PCIe 5.0 x16 with x16 PCIe extension option, Crypto, Secure Boot Capable
>                 Read-only fields:
>                         [PN] Part number: MCX713106AEHEA_QP1
>                         [EC] Engineering changes: A5
>                         [V2] Vendor specific: MCX713106AEHEA_QP1
>                         [SN] Serial number: MT2314XZ0JUZ
>                         [V3] Vendor specific: 0a5efb8958deed118000946dae7db798
>                         [VA] Vendor specific: MLX:MN=MLNX:CSKU=V2:UUID=V3:PCI=V0:MODL=CX713106A
>                         [V0] Vendor specific: PCIeGen5 x16
>                         [VU] Vendor specific: MT2314XZ0JUZMLNXS0D0F0
>                         [RV] Reserved: checksum good, 1 byte(s) reserved
>                 End
> 
> > > > Are we confident that VPD never contains anything sensitive?
> > > > It may contain arbitrary vendor-specific information, so we
> > > > can't know what might be in that part.
> > > 
> > > It depends on the vendor, but I'm pretty confident that any sane
> > > vendor who read the PCI spec will not put sensitive information
> > > in the VPD. The spec is very clear that this open to everyone.
> > 
> > I don't think the spec really defines "everyone" in this context,
> > does it?  The concept of privileged vs unprivileged users is an OS
> > construct, not really something the PCIe spec covers.
> 
> Agree that it OS specific, but for me, the fields like manufacturer
> ID, serial number e.t.c shows that the VPD doesn't contain sensitive
> information.

I don't follow the reasoning that because these fields don't seem
sensitive, other fields won't be :)

> > > > Reading VPD is fairly complicated and we've had problems in
> > > > the past (we have quirk_blacklist_vpd() for devices that
> > > > behave "unpredictably"), so it's worth considering whether
> > > > allowing non-root to do this could be exploited or could allow
> > > > DOS attacks.
> > > 
> > > It is not different from any other PCI field. If you are afraid
> > > of DOS, you should limit to read all other fields too.
> > 
> > Reading VPD is much different than reading things from config space.
> > 
> > To read VPD, software needs to:
> > 
> >   - Mutex with any other read/write path
> > 
> >   - Write the VPD address to read to the VPD Address register, with F
> >     bit clear
> > 
> >   - Wait (with timeout) for hardware to set the F bit of VPD Address
> >     register
> > 
> >   - Read VPD information from the VPD Data register
> > 
> >   - Repeat as necessary
> > 
> > The address is 15 bits wide, so there may be up to 32KB of VPD data.
> > The only way to determine the actual length is to read the data and
> > parse the data items, which is vulnerable to corrupted EEPROMs and
> > hardware issues if we read beyond the implemented size.
> > 
> > The PCI core currently doesn't touch VPD until a driver or userspace
> > (via sysfs) reads or writes it, so this path is not tested on most
> > devices.
> 
> The patch yes, but the flow is tested very well. It is hard to imagine
> situation where "lspci -vv" or corresponding library, never used to read
> data from device. Maybe it is not used daily on all computers, but all
> devices at least once in their lifetime were accessed.

Well, true, but I think "lspci -vv" requires root privilege to read
the VPD data, doesn't it?

> > > I'm enabling it for modern device which is compliant to PCI spec
> > > v6.0.  Do you want me to add quirk_allow_vpd() to allow only
> > > specific devices to read that field? It is doable but not
> > > scalable.
> > 
> > None of these questions really has to do with old vs new devices.
> > An "allow-list" quirk is possible, but I agree it would be a
> > maintenance headache.  To me it feels like VPD is kind of in the
> > same category as dmesg logs.  We try to avoid putting secret stuff
> > in dmesg, but generally distros still don't make it completely
> > public.
> 
> They hide it as dmesg already exposes a lot of sensitive data. For
> example, the kernel panic reveals a lot of such data. It is
> definitely not the case for VPD, and VPD vs. dmesg comparison is not
> correct one.

dmidecode is another similar case, which is also not public.

What's the use case?  How does an unprivileged user use the VPD
information?

I can certainly imagine using VPD for bug reporting, but that would
typically involve dmesg, dmidecode, lspci -vv, etc, all of which
already require privilege, so it's not clear to me how public VPD info
would help in that scenario.

Bjorn

