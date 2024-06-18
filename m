Return-Path: <linux-pci+bounces-8899-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AAE7490C43A
	for <lists+linux-pci@lfdr.de>; Tue, 18 Jun 2024 09:19:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91AC11C20FE4
	for <lists+linux-pci@lfdr.de>; Tue, 18 Jun 2024 07:19:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3C0A13AD06;
	Tue, 18 Jun 2024 06:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qSfN8njx"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79E5D13AD05;
	Tue, 18 Jun 2024 06:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718693708; cv=none; b=L+JgwCxQBQVRhcHO4Oytv19a5tP1aks/C67TH8jApngKNIyTAIc0cIa3t3JMmS16AGaN0NvgJH4rMinJ48TGYkjxW+e3qcx/AHJRzqJ0U5tfUF/VxIhAUlKPVqimS8+VdTXutapaMk/w+6ShnXhm7IJD1Gjj13pmFxe/OribsiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718693708; c=relaxed/simple;
	bh=BEa2B+TH/CvjjfcsXbgnjJkN3ogctMFgaz1/QbYTplw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SHvBsag+tuKvIYU19UgnZyDPoEh2BXkytQiV92YD0dfYH965l49wBHMFdUEHkf2am4T9uBlnCqA8uHxbwRqffngoZh0XW9HSaClD9cNNzxrrrHPTOT3+GXAITC9kD3MQY9LPGnCeDcZ7sBEgOUUFwEr4gNoqa644EKBxeVyOOVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qSfN8njx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5772C3277B;
	Tue, 18 Jun 2024 06:55:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718693708;
	bh=BEa2B+TH/CvjjfcsXbgnjJkN3ogctMFgaz1/QbYTplw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qSfN8njxfR0BYAVMLhx3dzs04nA6AZGEIlSJzhkW/yyMUyWoG1XJ21OjTQNdiTQuw
	 ie+64LEwsOX9P2kbqOsj3u5U5g2VYy85ZAkN7ScXNo4pt3aKc5zrie2obDPmPhxUdV
	 7xNKpk87RbNdfENbUPSFo9RZES9Y2o6hmGOBo4ivMZNUc/9I8xFHba0A4n0aGNHRYQ
	 3c+SNtHaRWgsDT0JKUEQJYJI+1cdN0urSiY4hwIAhf5bFAKfIbSzWLw0tHQP3mIwxs
	 7SKtAg5+sFLkfV5DvO6tBmk4w25Lq08CHowOeLedK0nyPKXNDZn51/C+7C41QSArnR
	 j3UjXmNYDbzBw==
Date: Tue, 18 Jun 2024 12:24:57 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Shunsuke Mie <mie@igel.co.jp>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
	"Michael S. Tsirkin" <mst@redhat.com>, linux-pci@vger.kernel.org,
	virtualization@lists.linux.dev, jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com
Subject: Re: [RFC] Legacy Virtio Driver with Device Has Limited Memory Access
Message-ID: <20240618065457.GA5485@thinkpad>
References: <CANXvt5r00Y5VGKSFXFnwbvGF+fhh2uNvU5VBGwECA9yabK4=Uw@mail.gmail.com>
 <20240516125913.GC11261@thinkpad>
 <20240520090809-mutt-send-email-mst@kernel.org>
 <20240614095033.GA59574@thinkpad>
 <CANXvt5ojosFbt60Gcfym1DX96W7SiX4X15dMGdSCVEPhUTpk=w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANXvt5ojosFbt60Gcfym1DX96W7SiX4X15dMGdSCVEPhUTpk=w@mail.gmail.com>

On Tue, Jun 18, 2024 at 08:41:09AM +0900, Shunsuke Mie wrote:
> Let's clarify the situation.
> 
> The Virtio device and driver are not working properly due to a
> combination of the following reasons:
> 
> 1. Regarding VIRTIO_F_ACCESS_PLATFORM:
> - The modern spec includes VIRTIO_F_ACCESS_PLATFORM, which allows
> Physical DMAC to be used.
> - This feature is not available in the legacy spec.
> 
> 2. Regarding Virtio PCIe Capability:
> - The modern spec requires Virtio PCIe Capability.
> - In some environments, Virtio PCIe Capability cannot be provided.
> 
> Ideas to solve this problem:
> 1. Introduce an ACCESS_PLATFORM-like flag in the legacy spec:
> There are some unused bits, but it may be difficult to make changes to
> the legacy spec at this stage.
> 

For sure this is a no-go based on the response from Michael. But if Linux Virtio
maintainers were willing to add some flexibility for legacy devices to use DMA
APIs as like xen-domain (I haven't checked in detail) you previously mentioned,
then it can be helpful.

> 2. Mani's Idea:
> I think it is best to add support for modern virtio PCI device to make
> use of IOMMU. Legacy devices can continue to use physical address.
> 

It is same as option 3. Legacy devices will continue to use physical address and
once we add support for modern virtio device, it can use IOMMU translation.

So the conclusion is, if the platform has IOMMU and doesn't allow configuring
the vendor specific capability, then it cannot be supported as is in upstream
Linux Endpoint framework (unless some changes happens in the Linux virtio
stack).

- Mani

> The meaning of "Legacy devices can continue to use physical address"
> is not fully understood. @mani Could you explain more?
> 
> 3. Wait until the HW supports the modern spec:
> This depends on the chip vendor.
> 
> Option 3 is essentially doing nothing, so it would be preferable to
> consider other ideas.
> 
> Best,
> Shunsuke
> 
> 2024年6月14日(金) 18:50 Manivannan Sadhasivam <mani@kernel.org>:
> >
> > On Mon, May 20, 2024 at 09:22:54AM -0400, Michael S. Tsirkin wrote:
> > > On Thu, May 16, 2024 at 02:59:13PM +0200, Manivannan Sadhasivam wrote:
> > > > On Thu, May 16, 2024 at 01:38:40PM +0900, Shunsuke Mie wrote:
> > > > > Hi virtio folks,
> > > > >
> > > >
> > > > You forgot to CC the actual Virtio folks. I've CCed them now.
> > > >
> > > > > I'm writing to discuss finding a workaround with Virtio drivers and legacy
> > > > > devices with limited memory access.
> > > > >
> > > > > # Background
> > > > > The Virtio specification defines a feature (VIRTIO_F_ACCESS_PLATFORM) to
> > > > > indicate devices requiring restricted memory access or IOMMU translation. This
> > > > > feature bit resides at position 33 in the 64-bit Features register on modern
> > > > > interfaces. When the linux virtio driver finds the flag, the driver uses DMA
> > > > > API that handles to use of appropriate memory.
> > > > >
> > > > > # Problem
> > > > > However, legacy devices only have a 32-bit register for the features bits.
> > > > > Consequently, these devices cannot represent the ACCESS_PLATFORM bit. As a
> > > > > result, legacy devices with restricted memory access cannot function
> > > > > properly[1]. This is a legacy spec issue, but I'd like to find a workaround.
> > > > >
> > > > > # Proposed Solutions
> > > > > I know these are not ideal, but I propose the following solution.
> > > > > Driver-side:
> > > > >     - Implement special handling similar to xen_domain.
> > > > > In xen_domain, linux virtio driver enables to use the DMA API.
> > > > >     - Introduce a CONFIG option to adjust the DMA API behavior.
> > > > > Device-side:
> > > > > Due to indistinguishability from the guest's perspective, a device-side
> > > > > solution might be difficult.
> > > > >
> > > > > I'm open to any comments or suggestions you may have on this issue or
> > > > > alternative approaches.
> > > > >
> > > > > [1] virtio-net PCI endpoint function using PCIe Endpoint Framework,
> > > > > https://lore.kernel.org/lkml/54ee46c3-c845-3df3-8ba0-0ee79a2acab1@igel.co.jp/t/
> > > > > The Linux PCIe endpoint framework is used to implement the virtio-net device on
> > > > > a legacy interface. This is necessary because of the framework and hardware
> > > > > limitation.
> > > > >
> > > >
> > > > We can fix the endpoint framework limitation, but the problem lies with some
> > > > platforms where we cannot write to vendor capability registers and still have
> > > > IOMMU.
> > > >
> > > > - Mani
> > >
> > > What are vendor capability registers and what do they have to do
> > > with the IOMMU?
> > >
> >
> > Virtio spec v1.2, sec 4.1.4 says,
> >
> > "Each structure can be mapped by a Base Address register (BAR) belonging to the
> > function, or accessed via the special VIRTIO_PCI_CAP_PCI_CFG field in the PCI
> > configuration space.
> >
> > The location of each structure is specified using a vendor-specific PCI
> > capability located on the capability list in PCI configuration space of the
> > device."
> >
> > So this means the device has to expose the virtio structures through vendor
> > specific capability isn't it?
> >
> > And only in that case, it can expose VIRTIO_F_ACCESS_PLATFORM bit for making
> > use of IOMMU translation.
> >
> > - Mani
> >
> > --
> > மணிவண்ணன் சதாசிவம்

-- 
மணிவண்ணன் சதாசிவம்

