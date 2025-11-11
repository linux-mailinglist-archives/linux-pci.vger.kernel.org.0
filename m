Return-Path: <linux-pci+bounces-40943-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 11533C50108
	for <lists+linux-pci@lfdr.de>; Wed, 12 Nov 2025 00:33:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EE0914E03F4
	for <lists+linux-pci@lfdr.de>; Tue, 11 Nov 2025 23:33:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6CF2299AA9;
	Tue, 11 Nov 2025 23:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eBF6kHV6"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A4F235CBC6;
	Tue, 11 Nov 2025 23:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762903996; cv=none; b=R2OlhO37f//GTOH5LR+ivzkHfbCNJx+/5qCZsHk2MM2g4obMPLME5N9r2SmGqYz+ELJ7BJFXmzk72Zw9QuQvIvGuajhr+oyP8ywdWQISUqlkWbS/RdNlb+mryaFWur7bPAT6m2ONTWLHE3iw08oLL5FOCqCXpqhVPzQL2DyoTYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762903996; c=relaxed/simple;
	bh=kyGXbFppsuatrJ4z10Sk9MGs8htgMnO1+sVT0p1rUEg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=NJFT4kaq5SGzKOp5eUx/Mer7Fmxbg/fr8zTcHRt0Lx19P4QTyUZnYYfzGVnnCusTkk66okbg3jIvUmd1v1cmxlS5zsB4S4+CptOz3OcDagk0AWnGpj5j44RgPwgv/h23zMkqI9DFM0ZOV4fmsYGH3vbJIuCToF4InfUVwxgaFnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eBF6kHV6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8819C4CEF5;
	Tue, 11 Nov 2025 23:33:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762903995;
	bh=kyGXbFppsuatrJ4z10Sk9MGs8htgMnO1+sVT0p1rUEg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=eBF6kHV6z6UtYQKKNTOYpwJibPQqiJTQefbU0dIsV/41HRRLQ0OYnBm33qf7NbZcM
	 Zbh46gUKu+DHwwHwUnlZDBLCxqnsbuV33WO8wbnwJ2nY7O+svkB8mOVusHJ6gLymYD
	 tsMahpaAZu4Dxi8Wdg+r5nJ4VmMd2vIN4z8WymyZuGyxKzqivxeT+MdTP35wX2CYrY
	 9J0wqqVPEp7rRoQrsOhi4oe0TcIdryivsSz2QB7TAf5p74fQA0G/eUYbM3EO+4AoSQ
	 WHApAkv1JGrtVKb8Cgm/bxq19P0FzGWRwOtqdZ6klwNyzRsJMuSbnBQSsIg5JZJe44
	 PJ7q7IkQ9YrOg==
Date: Tue, 11 Nov 2025 17:33:13 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Val Packett <val@packett.cool>
Cc: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	manivannan.sadhasivam@oss.qualcomm.com,
	Rob Clark <robin.clark@oss.qualcomm.com>,
	Vignesh Raman <vignesh.raman@collabora.com>,
	Valentine Burley <valentine.burley@collabora.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	"David E. Box" <david.e.box@linux.intel.com>,
	Kai-Heng Feng <kai.heng.feng@canonical.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Chia-Lin Kao <acelan.kao@canonical.com>
Subject: Re: [PATCH v2 0/2] PCI/ASPM: Enable ASPM and Clock PM by default on
 devicetree platforms
Message-ID: <20251111233313.GA2211570@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <36f05566-8c7a-485b-96e7-9792ab355374@packett.cool>

On Tue, Nov 11, 2025 at 03:51:03AM -0300, Val Packett wrote:
> On 11/8/25 1:18 PM, Dmitry Baryshkov wrote:
> > On Mon, Sep 22, 2025 at 09:46:43PM +0530, Manivannan Sadhasivam via B4 Relay wrote:
> > > Hi,
> > > 
> > > This series is one of the 'let's bite the bullet' kind, where we have decided to
> > > enable all ASPM and Clock PM states by default on devicetree platforms [1]. The
> > > reason why devicetree platforms were chosen because, it will be of minimal
> > > impact compared to the ACPI platforms. So seemed ideal to test the waters.
> > > 
> > > This series is tested on Lenovo Thinkpad T14s based on Snapdragon X1 SoC. All
> > > supported ASPM states are getting enabled for both the NVMe and WLAN devices by
> > > default.
> > > [..]
> > The series breaks the DRM CI on DB820C board (apq8096, PCIe network
> > card, NFS root). The board resets randomly after some time ([1]).
>
> Is that reset.. due to the watchdog resetting a hard-frozen system?
> 
> Me and a bunch of other people in the #aarch64-laptops irc/matrix room have
> been experiencing these random hard freezes with ASPM enabled for the NVMe
> SSD, on Hamoa (and Purwa too I think) devices.

I don't know what controllers are in Hamoa and Purwa or what the IDs
of the root ports and endpoints are.  Can you collect the Vendor and
Device IDs (from dmesg log or "lspci -n")?  If we figure out that some
are broken, we might be able to add quirks to avoid any broken ASPM
states.

> I have confirmed with a modified (to accept args) enable-aspm.sh script[1]
> that disabling ASPM *only* for the SSD, while keeping it *on* for the WiFi
> adapter, is enough to keep the system stable (got to about a month of uptime
> in that state).
> 
> If you have reproduced the same issue on an entirely different SoC, it's
> probably a general driver issue.
> 
> Please, please help us debug this using your internal secret debug equipment
> :)
> 
> 
> [1]: https://gist.github.com/valpackett/8a6207b44364de6b32652f4041fe680f

Can you use "echo 1 > /sys/bus/pci/devices/.../link/l0s_aspm" and
similar (see Documentation/ABI/testing/sysfs-bus-pci) to do this
tuning instead of poking with setpci?  If so, it might be easier.
There are ordering requirements that aspm.c tries to observe via the
sysfs interface.

enable-aspm.sh might observe them also (I didn't look that carefully),
but if aspm.c gets them wrong, they're wrong for everybody, so we'd
like to know about that.

Bjorn

