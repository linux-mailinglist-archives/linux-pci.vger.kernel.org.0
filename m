Return-Path: <linux-pci+bounces-8905-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 833E590C862
	for <lists+linux-pci@lfdr.de>; Tue, 18 Jun 2024 13:07:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89FC21C22513
	for <lists+linux-pci@lfdr.de>; Tue, 18 Jun 2024 11:07:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 182EB204EE5;
	Tue, 18 Jun 2024 09:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ctDIAE5G"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54245204EE2
	for <linux-pci@vger.kernel.org>; Tue, 18 Jun 2024 09:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718704032; cv=none; b=muzRJ3/CSgt1/QcxSIlEiXmyB2jnFawe8RiyX22MAg2ZlyzINlKM64dkbBScaOlYAr10F93WTyignMPe7e8Hu8QK2BLyofJAk82GEhp+0oS6PL0MWA4p9e70r34hO4i+iumlx+TIMcigyJGSt0vQLZQT22QsRbNx+m6Jtk53Fqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718704032; c=relaxed/simple;
	bh=NKSlcV6xqhaUW4Q4ODXZrLaX1p1+K5g53ZOZx12Fpng=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N4JYh8ubROQLnm7a9DLtyrePpe7HiGODZqoNiK5CmSI/8zHBR8wvFz6bx6gBeitmGLhkCGFsntIizldfjYz1ticci8lGt9LAHCTge5U77WFvGSenCm68qygaTS5mwiZAmI1CouaRlXDhrkfwpzZ65EHV0oa5MIX9mfieso5H838=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ctDIAE5G; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718704029;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uTZKtkr79Lfim0p7IaBCWbQs6mQHbjzmBshnARYHwbE=;
	b=ctDIAE5GztAq11LRlXzFtPPP8D5NmgmNQVIsYGYOmKM4G9C8nfzHCAdxv3BbuWpfl3RI/Y
	g7hDNXRwuRKuKtcMaYZjAfBtpFfX/8UvCgUWB/PTHnOsWehkComjfI3OVhexqYuuihJrCQ
	8cGkZIfsr+bpo/RQSoNKCH/lvTL1pCE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-551-Dc7KK4ZjPJiF-lFNPKfpvw-1; Tue, 18 Jun 2024 05:47:07 -0400
X-MC-Unique: Dc7KK4ZjPJiF-lFNPKfpvw-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4215b0b1c11so40117895e9.3
        for <linux-pci@vger.kernel.org>; Tue, 18 Jun 2024 02:47:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718704026; x=1719308826;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uTZKtkr79Lfim0p7IaBCWbQs6mQHbjzmBshnARYHwbE=;
        b=JCpE/Zirs9WHN9ik6pW9SpR350UXLQRdK7EsXuFmNJs6JWjMg9jFnbkEF19pADmJPm
         EIEZ2LB0gNG0kZVMga4jrMhxxcwZKJQMV3opxRB1EcqLfmcyOA6JresaC960L3pTh+G5
         5aGOJ6INchDh/oKTZghtx6kN+MUizOs5yTA95rA3kp6TPnAwKFO1VjUpjBZtwNmBAFOM
         hFZPsRzHsbIojbxLhLaD26AZzBKG6o8ggM274ZNk4QxhT0cYL3l114moIqcVNI2Fje7w
         ET/Ws1hqSqXAvubj1sSaCuwvkWn4xv2gps0EqBv/k7cHsWkUwnc3TX5RS0zpC355uiv/
         uKpA==
X-Forwarded-Encrypted: i=1; AJvYcCUWsVaxYa6vUXUfnLzcrqjfZmiguo1dwTvH2RCjXtgtBdZIqglUcApfq73lq9TKTW6U4kGRs5nzw6HDMOsMhtAzV4NO0V8yVqEV
X-Gm-Message-State: AOJu0YwovOsnNjifbMn6j18wkX2sUqiIX5ck+73/eJRpASQSM91mTQTz
	4zttsRWgzDn76STXeperMBLgOtSFemmXakHiv7xFI7uWyqIqYPkAvvIzzsxx2IduMIZPxFdYcRG
	uWX1kKTZIo0ts4X3yoe9XRV40DdhbFiFzRinxTto/aQxbGHrPrIOzuYiHYMta08nUMg==
X-Received: by 2002:a05:600c:3d13:b0:423:2ea:fdb3 with SMTP id 5b1f17b1804b1-42304827b93mr88708235e9.14.1718704025899;
        Tue, 18 Jun 2024 02:47:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGyM5RIkf//FNiHL4bIrMmJ3JCefSUPWbznYkp3sETl7EEyGVlkt+Me+HnWNc6Z7w/Cq+HL2g==
X-Received: by 2002:a05:600c:3d13:b0:423:2ea:fdb3 with SMTP id 5b1f17b1804b1-42304827b93mr88708045e9.14.1718704025298;
        Tue, 18 Jun 2024 02:47:05 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:441:67bf:ebbb:9f62:dc29:2bdc])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42301a7c850sm177265855e9.6.2024.06.18.02.47.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 02:47:04 -0700 (PDT)
Date: Tue, 18 Jun 2024 05:47:00 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Shunsuke Mie <mie@igel.co.jp>
Cc: Manivannan Sadhasivam <mani@kernel.org>, linux-pci@vger.kernel.org,
	virtualization@lists.linux.dev, jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com
Subject: Re: [RFC] Legacy Virtio Driver with Device Has Limited Memory Access
Message-ID: <20240618054115-mutt-send-email-mst@kernel.org>
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

... because legacy drivers don't set it

> 2. Regarding Virtio PCIe Capability:
> - The modern spec requires Virtio PCIe Capability.

It's a PCI capability actually. People have been asking
about option to make it a pcie extended capability,
but no one did the spec, qemu and driver work, yet.

> - In some environments, Virtio PCIe Capability cannot be provided.

why not?


> Ideas to solve this problem:
> 1. Introduce an ACCESS_PLATFORM-like flag in the legacy spec:
> There are some unused bits, but it may be difficult to make changes to
> the legacy spec at this stage.

seems pointless - if you can not change the driver then it won't
negotiate ACCESS_PLATFORM. if you can change the driver then
use 1.0 interface, please.

> 2. Mani's Idea:
> I think it is best to add support for modern virtio PCI device to make
> use of IOMMU. Legacy devices can continue to use physical address.
> 
> The meaning of "Legacy devices can continue to use physical address"
> is not fully understood. @mani Could you explain more?

I don't know how this is different from 3.

> 3. Wait until the HW supports the modern spec:
> This depends on the chip vendor.

Adding ACCESS_PLATFORM hacks would also depend on the chip vendor.

> Option 3 is essentially doing nothing, so it would be preferable to
> consider other ideas.

Why because you have to do something, anything?

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


