Return-Path: <linux-pci+bounces-8793-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 00D879088C7
	for <lists+linux-pci@lfdr.de>; Fri, 14 Jun 2024 11:57:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA8881F253A3
	for <lists+linux-pci@lfdr.de>; Fri, 14 Jun 2024 09:57:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 285D41974EA;
	Fri, 14 Jun 2024 09:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QOpV7I5Z"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3298192B76;
	Fri, 14 Jun 2024 09:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718358645; cv=none; b=JKmJNYfwriQT03uZ4XrB15FBbWUtWb3HpI5QxZqN1FBMHv8dxgY2PCJaPrX/2Oc5yr9vIJQvJReIgmu+ozKWUSzsT3OTT9KssX6iq7uKONIjSSoRJCJ4xofk5aUlKdIFGysokD865DBiUd4ykCr9Dp6InwbgtIrv3T13f3PJNnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718358645; c=relaxed/simple;
	bh=x9NmFD5BR5AR0igvB+EXG1z215tMp28uQNymF9ZCJEg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HE44MxFve2NOKoEozVXFrmM54OMazukPV/0ZnCDIK4ZTPTKS4xgMZrA+TeSRcWoN23oFeYvP8MOX8yf5KTSEBfS7W6v1frmB8SGEdz760KTLN0wBcaPfcgfHeDW9q1II8d1ZUgUqeXS3lNmXzEeJ2HZAoizZsHBkPLmVn4le/1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QOpV7I5Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1224DC2BD10;
	Fri, 14 Jun 2024 09:50:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718358644;
	bh=x9NmFD5BR5AR0igvB+EXG1z215tMp28uQNymF9ZCJEg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QOpV7I5Zo+huIZCjPQTbO2ya/lAE2ITFDrsYj9F342X62O0VoId/WSbjAYpSPrBQF
	 nF1e37SM+C2w6B2exnbxkiIo+rTy4p9IPH1qTV4JhM2SOQTdAtntamEvjK5D+v8l/Q
	 ngmdRqjZHlRNs1hTTBw8OCIsUhtJJR+kf64V+PprMf0S3HfkGhzucUZbeJ9sTI/sGM
	 nWRPr+tdgrY502SttoSzO57jUhvTpWYB1gjfuZnYhzHGt7DjchVvd0tgN0zeEDNYul
	 GBMjVOBAcHdKnWJjyCirMYmIwZIh0Yw/IOFeFBWkWjDlpaKKE6EH2cN/LKSfg8lkDM
	 t7TZmqd8TWW6Q==
Date: Fri, 14 Jun 2024 15:20:33 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>, Shunsuke Mie <mie@igel.co.jp>,
	linux-pci@vger.kernel.org, virtualization@lists.linux.dev,
	jasowang@redhat.com, xuanzhuo@linux.alibaba.com
Subject: Re: [RFC] Legacy Virtio Driver with Device Has Limited Memory Access
Message-ID: <20240614095033.GA59574@thinkpad>
References: <CANXvt5r00Y5VGKSFXFnwbvGF+fhh2uNvU5VBGwECA9yabK4=Uw@mail.gmail.com>
 <20240516125913.GC11261@thinkpad>
 <20240520090809-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240520090809-mutt-send-email-mst@kernel.org>

On Mon, May 20, 2024 at 09:22:54AM -0400, Michael S. Tsirkin wrote:
> On Thu, May 16, 2024 at 02:59:13PM +0200, Manivannan Sadhasivam wrote:
> > On Thu, May 16, 2024 at 01:38:40PM +0900, Shunsuke Mie wrote:
> > > Hi virtio folks,
> > > 
> > 
> > You forgot to CC the actual Virtio folks. I've CCed them now.
> > 
> > > I'm writing to discuss finding a workaround with Virtio drivers and legacy
> > > devices with limited memory access.
> > > 
> > > # Background
> > > The Virtio specification defines a feature (VIRTIO_F_ACCESS_PLATFORM) to
> > > indicate devices requiring restricted memory access or IOMMU translation. This
> > > feature bit resides at position 33 in the 64-bit Features register on modern
> > > interfaces. When the linux virtio driver finds the flag, the driver uses DMA
> > > API that handles to use of appropriate memory.
> > > 
> > > # Problem
> > > However, legacy devices only have a 32-bit register for the features bits.
> > > Consequently, these devices cannot represent the ACCESS_PLATFORM bit. As a
> > > result, legacy devices with restricted memory access cannot function
> > > properly[1]. This is a legacy spec issue, but I'd like to find a workaround.
> > > 
> > > # Proposed Solutions
> > > I know these are not ideal, but I propose the following solution.
> > > Driver-side:
> > >     - Implement special handling similar to xen_domain.
> > > In xen_domain, linux virtio driver enables to use the DMA API.
> > >     - Introduce a CONFIG option to adjust the DMA API behavior.
> > > Device-side:
> > > Due to indistinguishability from the guest's perspective, a device-side
> > > solution might be difficult.
> > > 
> > > I'm open to any comments or suggestions you may have on this issue or
> > > alternative approaches.
> > > 
> > > [1] virtio-net PCI endpoint function using PCIe Endpoint Framework,
> > > https://lore.kernel.org/lkml/54ee46c3-c845-3df3-8ba0-0ee79a2acab1@igel.co.jp/t/
> > > The Linux PCIe endpoint framework is used to implement the virtio-net device on
> > > a legacy interface. This is necessary because of the framework and hardware
> > > limitation.
> > > 
> > 
> > We can fix the endpoint framework limitation, but the problem lies with some
> > platforms where we cannot write to vendor capability registers and still have
> > IOMMU.
> > 
> > - Mani
> 
> What are vendor capability registers and what do they have to do
> with the IOMMU?
> 

Virtio spec v1.2, sec 4.1.4 says,

"Each structure can be mapped by a Base Address register (BAR) belonging to the
function, or accessed via the special VIRTIO_PCI_CAP_PCI_CFG field in the PCI
configuration space.

The location of each structure is specified using a vendor-specific PCI
capability located on the capability list in PCI configuration space of the
device."

So this means the device has to expose the virtio structures through vendor
specific capability isn't it?

And only in that case, it can expose VIRTIO_F_ACCESS_PLATFORM bit for making
use of IOMMU translation.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

