Return-Path: <linux-pci+bounces-8906-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D69CE90C904
	for <lists+linux-pci@lfdr.de>; Tue, 18 Jun 2024 13:21:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66F171F21458
	for <lists+linux-pci@lfdr.de>; Tue, 18 Jun 2024 11:21:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F9CB13B595;
	Tue, 18 Jun 2024 10:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q+08cY2B"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85DFB13398E
	for <linux-pci@vger.kernel.org>; Tue, 18 Jun 2024 10:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718705353; cv=none; b=Q0TLxSVgpspQ5/xqJqpIMts2IR0Vg2/Y0hCP9zM3EZ2Dp1HE1lXYNQ6I4i0PestkLW2n0zJnREI9OPlFldIjklYk0uyz2A5C1rnmc50MlKRp0uM2Ni4BvY8fgJWKeJTfA7SaJw29USAWbtKe4SHnA7oml9BRTPkTRozuvwOlZ0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718705353; c=relaxed/simple;
	bh=khuUH1bMj8Z9VH+WJa6PdJmBWinhnFOUvq23lTLU5Kc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rws+eES2GQ78471xAgVeqmLjx8qcqJLsUqRNmfHmJXxgpb7BCXDNL5+HJuZY7fD0Xens8ZHrTY7ownTRZ73scX9mnBWDc9Jn8r/i+DKnxck9SvTRg6dW+GWESE3/i4wH61Fp9UVn/69zTw6kAvdywyVZK5RryqW7qemobpx4tJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q+08cY2B; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718705350;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rEDxZc2dLW6+Xu8qI6zPlDHwS+sRNM7U/A+bgGnLIgc=;
	b=Q+08cY2Bq38EcELHqvUdT0ZmRSdzSqCB6BH5s2dw+gbt1F+JzbsdYYkijHkC+M8cletAOb
	sIYyzxb/7WGzir2MZuPdPntmVfqU/eHFX/DSGEqwJ6CVf2LfcXktPCO81vetBDJEOn1mgi
	0Pj9Jx56xq8HtkaCRjAiR7pnBtYEH7k=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-484-f5FXiF32NPGZjFaAF1Nxwg-1; Tue, 18 Jun 2024 06:09:09 -0400
X-MC-Unique: f5FXiF32NPGZjFaAF1Nxwg-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-421eed70e30so39507695e9.1
        for <linux-pci@vger.kernel.org>; Tue, 18 Jun 2024 03:09:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718705348; x=1719310148;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rEDxZc2dLW6+Xu8qI6zPlDHwS+sRNM7U/A+bgGnLIgc=;
        b=iMpe6Y3RGl25ZdBnmt/laNw4Sv3kxSYV+BXuEbDWNvlee4rynfk2dON9p4tTsVZvvL
         DTrSM5gd1HHbxKXMWv76iy/BlIk6SymhjiKvNJhNLTgteBOWJR78mF0Y8oBbWR60/KvV
         m3HEljKZYV806LsRNjZu3BBK3PDR3ouLYMrNGnET2qSdKf2Pp2RtQTifWu59cw7EsPJZ
         7UE+3uUYaO9WqVOzd6jAHNbDOz46ZZjnLICf2ufWe0Ksd8+cHf+C+LX7Of63rcC+ZZL7
         Q3KTe7Lg2n9VBRHCYX/KVfG3uyGAbu0EPDs47XjY7tz7RHiqS8o9YTG/4+6wrz+FtjFu
         tY0A==
X-Forwarded-Encrypted: i=1; AJvYcCXphHXfpPaX420GDMF4ZAQvzLUBrAfeMDGuEoTS3JFKHUtyGH8+19Aj/1vkHMPVyyrA3y1L+j+Nfsy4Sr3fhBRuNX3zXlt5tjMW
X-Gm-Message-State: AOJu0Yw1hxVVcxuBSd+ZxOgfalBIe6W3CxdKGEvvhgFtkeXn5eJk76tY
	kxMCNA2423pwhmVrNSyN5hL+Ggqp9BaYoJF+/dVR3ODDkUrTl6BVTznMCnrcm962vRdbwy2UAs3
	VXvX/qJxVb2Ri1KCm+QhBJ7OX5mqoUG5uF7u7O6PzYfKK8yNYRceMDREKaw==
X-Received: by 2002:a05:600c:4706:b0:422:384e:4365 with SMTP id 5b1f17b1804b1-42304821335mr99960225e9.2.1718705347905;
        Tue, 18 Jun 2024 03:09:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG6lEhniOXOzh+4aLd12LE9PgD8GXi7WRdQsYXcSj/HwWxOWMkkIDigLL4/zLVBCWNFYYK/jg==
X-Received: by 2002:a05:600c:4706:b0:422:384e:4365 with SMTP id 5b1f17b1804b1-42304821335mr99959925e9.2.1718705347111;
        Tue, 18 Jun 2024 03:09:07 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:441:67bf:ebbb:9f62:dc29:2bdc])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3609a892324sm3189067f8f.6.2024.06.18.03.09.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 03:09:06 -0700 (PDT)
Date: Tue, 18 Jun 2024 06:09:02 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Shunsuke Mie <mie@igel.co.jp>, linux-pci@vger.kernel.org,
	virtualization@lists.linux.dev, jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com
Subject: Re: [RFC] Legacy Virtio Driver with Device Has Limited Memory Access
Message-ID: <20240618060649-mutt-send-email-mst@kernel.org>
References: <CANXvt5r00Y5VGKSFXFnwbvGF+fhh2uNvU5VBGwECA9yabK4=Uw@mail.gmail.com>
 <20240516125913.GC11261@thinkpad>
 <20240520090809-mutt-send-email-mst@kernel.org>
 <20240614095033.GA59574@thinkpad>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240614095033.GA59574@thinkpad>

On Fri, Jun 14, 2024 at 03:20:33PM +0530, Manivannan Sadhasivam wrote:
> On Mon, May 20, 2024 at 09:22:54AM -0400, Michael S. Tsirkin wrote:
> > On Thu, May 16, 2024 at 02:59:13PM +0200, Manivannan Sadhasivam wrote:
> > > On Thu, May 16, 2024 at 01:38:40PM +0900, Shunsuke Mie wrote:
> > > > Hi virtio folks,
> > > > 
> > > 
> > > You forgot to CC the actual Virtio folks. I've CCed them now.
> > > 
> > > > I'm writing to discuss finding a workaround with Virtio drivers and legacy
> > > > devices with limited memory access.
> > > > 
> > > > # Background
> > > > The Virtio specification defines a feature (VIRTIO_F_ACCESS_PLATFORM) to
> > > > indicate devices requiring restricted memory access or IOMMU translation. This
> > > > feature bit resides at position 33 in the 64-bit Features register on modern
> > > > interfaces. When the linux virtio driver finds the flag, the driver uses DMA
> > > > API that handles to use of appropriate memory.
> > > > 
> > > > # Problem
> > > > However, legacy devices only have a 32-bit register for the features bits.
> > > > Consequently, these devices cannot represent the ACCESS_PLATFORM bit. As a
> > > > result, legacy devices with restricted memory access cannot function
> > > > properly[1]. This is a legacy spec issue, but I'd like to find a workaround.
> > > > 
> > > > # Proposed Solutions
> > > > I know these are not ideal, but I propose the following solution.
> > > > Driver-side:
> > > >     - Implement special handling similar to xen_domain.
> > > > In xen_domain, linux virtio driver enables to use the DMA API.
> > > >     - Introduce a CONFIG option to adjust the DMA API behavior.
> > > > Device-side:
> > > > Due to indistinguishability from the guest's perspective, a device-side
> > > > solution might be difficult.
> > > > 
> > > > I'm open to any comments or suggestions you may have on this issue or
> > > > alternative approaches.
> > > > 
> > > > [1] virtio-net PCI endpoint function using PCIe Endpoint Framework,
> > > > https://lore.kernel.org/lkml/54ee46c3-c845-3df3-8ba0-0ee79a2acab1@igel.co.jp/t/
> > > > The Linux PCIe endpoint framework is used to implement the virtio-net device on
> > > > a legacy interface. This is necessary because of the framework and hardware
> > > > limitation.
> > > > 
> > > 
> > > We can fix the endpoint framework limitation, but the problem lies with some
> > > platforms where we cannot write to vendor capability registers and still have
> > > IOMMU.
> > > 
> > > - Mani
> > 
> > What are vendor capability registers and what do they have to do
> > with the IOMMU?
> > 
> 
> Virtio spec v1.2, sec 4.1.4 says,
> 
> "Each structure can be mapped by a Base Address register (BAR) belonging to the
> function, or accessed via the special VIRTIO_PCI_CAP_PCI_CFG field in the PCI
> configuration space.
> 
> The location of each structure is specified using a vendor-specific PCI
> capability located on the capability list in PCI configuration space of the
> device."
> 
> So this means the device has to expose the virtio structures through vendor
> specific capability isn't it?

The location of the structures within BAR is specified through
a vendor specific PCI capability, yes.

Why is that a problem?

People have been asking for alternative ways to do that,
so if you can point out what your issue is specifically,
it can be fixable.

> And only in that case, it can expose VIRTIO_F_ACCESS_PLATFORM bit for making
> use of IOMMU translation.
> 
> - Mani

virtio drivers won't even know where to access the features
without the capability.


> -- 
> மணிவண்ணன் சதாசிவம்


