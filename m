Return-Path: <linux-pci+bounces-7658-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C9668C9E11
	for <lists+linux-pci@lfdr.de>; Mon, 20 May 2024 15:23:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9D304B21276
	for <lists+linux-pci@lfdr.de>; Mon, 20 May 2024 13:23:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30135134407;
	Mon, 20 May 2024 13:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GaDaAFm2"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7E3613398E
	for <linux-pci@vger.kernel.org>; Mon, 20 May 2024 13:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716211385; cv=none; b=U5GhuybxEUSD9jUsJjplc8+0Tmfxo4H1KS/Mt9SUHi6NQpPqd4klqdulQqzXlC8xmJxBuGxw5GTA6fJ1ooZE4SvBuwEULPQ/P6omVVllXWVUztndCTAqpJhEz3gc277t4aUq0Cf2zhOhdFoacf7wqS5MgSHduWfiE96nQXkrNNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716211385; c=relaxed/simple;
	bh=VtzriDnmPJgFVcPERMtIx+lichjMLk1jaHjkRVNmgr0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UOVBvGEa2LDrTNzOc+MWi4G2Xp8yKMdzUbxQg3S6zGitEwNzxh1v+vQwjLJ7rMqn6o9F/azX/kfCTL7E5+mVlypxFgI8vF4CX/pSAs4q8UVh8VBEuUnjyOFN92Nga3YFV1jI9l9n8yOMOJxRgH6fdHpW+zKb0UVJmVp4IVTPzRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GaDaAFm2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716211382;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M8c4UCZlVP1N9HFMkZD0c7EJUI94ZrVHCqdtZ52aP+0=;
	b=GaDaAFm2DmmMgqZwfODhw0msXJ3FCcHWL//mB/yzHAa23OkfEpuELdiEvuluT0Cun/tXGA
	P23a2cyQPeeGo2zTcwPQLf7+Worf8qlVgz8JsqcAOGb3f7Gz0G6sfuYJ54Exe5WOWhfoIq
	VkAzYOGqRnUPb4FA9CngSZwGkHzTrnE=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-646-uBHpAHKuPoSZAm6LqCGGmg-1; Mon, 20 May 2024 09:23:01 -0400
X-MC-Unique: uBHpAHKuPoSZAm6LqCGGmg-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-354c964f74aso487680f8f.0
        for <linux-pci@vger.kernel.org>; Mon, 20 May 2024 06:23:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716211379; x=1716816179;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M8c4UCZlVP1N9HFMkZD0c7EJUI94ZrVHCqdtZ52aP+0=;
        b=M/vGLiu5zHjGxV+buTPDUhZIccWl1WBlbWnj6NxanjOR0qadV4KXIRy09FsRWaeBT9
         /A8cIl3uHvOxhNRu6jN1BbkAuGg+FUJs5RI2VzeCSRNO7l9dF6n2e8aJCYZa/RcvEYd8
         GD1U/Knh4pOSLnAFuF1zDzlocsUzREMapTMaa7ryAWz4/PXnlYNsF4FtOti0qEfJXVbh
         NsI8ZNsNBl8wC6aIQBltw1nWQhU25JKom78EqmNtZy8uJcPpQSbSowLqxp5pSAf23ekr
         lZ3i7lEmvW/C603zThFCP6Nu5hakhJl2SIF6J0JrrocCZVNg3w7y9QpsCzsnCVAW7rdC
         lITQ==
X-Forwarded-Encrypted: i=1; AJvYcCWOzU01uQjY8k9rH6BKGvfBkNtDuBKMETb2IotXpmUFU2rPtfYMHhZO2MNYjcgD5tf6Ozbiv3Yb4NXpeDDxLxWeiBZ/+v4uujOH
X-Gm-Message-State: AOJu0YwAgt15DxWvlG2KaslW0tWFua5UZ9Jn18bpfne2U8xRSSyMWnnT
	1xoIMDr6+c8g9ugJLvlkADVzFLCHf0DkiKXNxTt4YWkaMa1MqXq+XeOv0bw4S1vhb4jCELKiF2g
	wkvDrl9jRRggnsKuoUftOwpZBdTk5t9HYTLx6vvyTci9+8gG3i6S5G8i6pDm0rMSX0g==
X-Received: by 2002:adf:e586:0:b0:34c:b2df:6f01 with SMTP id ffacd0b85a97d-3504a737f13mr20902220f8f.21.1716211379552;
        Mon, 20 May 2024 06:22:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHvYYkoaNDOEOiv6UGBH49UdkV0uZVjDLOJ6mISaM0QTUkwRoAiGrdAfBIOdnKoXAedrbzI6Q==
X-Received: by 2002:adf:e586:0:b0:34c:b2df:6f01 with SMTP id ffacd0b85a97d-3504a737f13mr20902203f8f.21.1716211378979;
        Mon, 20 May 2024 06:22:58 -0700 (PDT)
Received: from redhat.com ([2a02:14f:177:b718:2429:1dc5:dc6b:7d42])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3502b8a7748sm29370373f8f.49.2024.05.20.06.22.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 May 2024 06:22:58 -0700 (PDT)
Date: Mon, 20 May 2024 09:22:54 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Shunsuke Mie <mie@igel.co.jp>, linux-pci@vger.kernel.org,
	virtualization@lists.linux.dev, jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com
Subject: Re: [RFC] Legacy Virtio Driver with Device Has Limited Memory Access
Message-ID: <20240520090809-mutt-send-email-mst@kernel.org>
References: <CANXvt5r00Y5VGKSFXFnwbvGF+fhh2uNvU5VBGwECA9yabK4=Uw@mail.gmail.com>
 <20240516125913.GC11261@thinkpad>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240516125913.GC11261@thinkpad>

On Thu, May 16, 2024 at 02:59:13PM +0200, Manivannan Sadhasivam wrote:
> On Thu, May 16, 2024 at 01:38:40PM +0900, Shunsuke Mie wrote:
> > Hi virtio folks,
> > 
> 
> You forgot to CC the actual Virtio folks. I've CCed them now.
> 
> > I'm writing to discuss finding a workaround with Virtio drivers and legacy
> > devices with limited memory access.
> > 
> > # Background
> > The Virtio specification defines a feature (VIRTIO_F_ACCESS_PLATFORM) to
> > indicate devices requiring restricted memory access or IOMMU translation. This
> > feature bit resides at position 33 in the 64-bit Features register on modern
> > interfaces. When the linux virtio driver finds the flag, the driver uses DMA
> > API that handles to use of appropriate memory.
> > 
> > # Problem
> > However, legacy devices only have a 32-bit register for the features bits.
> > Consequently, these devices cannot represent the ACCESS_PLATFORM bit. As a
> > result, legacy devices with restricted memory access cannot function
> > properly[1]. This is a legacy spec issue, but I'd like to find a workaround.
> > 
> > # Proposed Solutions
> > I know these are not ideal, but I propose the following solution.
> > Driver-side:
> >     - Implement special handling similar to xen_domain.
> > In xen_domain, linux virtio driver enables to use the DMA API.
> >     - Introduce a CONFIG option to adjust the DMA API behavior.
> > Device-side:
> > Due to indistinguishability from the guest's perspective, a device-side
> > solution might be difficult.
> > 
> > I'm open to any comments or suggestions you may have on this issue or
> > alternative approaches.
> > 
> > [1] virtio-net PCI endpoint function using PCIe Endpoint Framework,
> > https://lore.kernel.org/lkml/54ee46c3-c845-3df3-8ba0-0ee79a2acab1@igel.co.jp/t/
> > The Linux PCIe endpoint framework is used to implement the virtio-net device on
> > a legacy interface. This is necessary because of the framework and hardware
> > limitation.
> > 
> 
> We can fix the endpoint framework limitation, but the problem lies with some
> platforms where we cannot write to vendor capability registers and still have
> IOMMU.
> 
> - Mani

What are vendor capability registers and what do they have to do
with the IOMMU?


> -- 
> மணிவண்ணன் சதாசிவம்


