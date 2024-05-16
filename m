Return-Path: <linux-pci+bounces-7575-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A9B78C7759
	for <lists+linux-pci@lfdr.de>; Thu, 16 May 2024 15:13:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C7C6281B9E
	for <lists+linux-pci@lfdr.de>; Thu, 16 May 2024 13:13:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A620146A72;
	Thu, 16 May 2024 13:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cn+o1+DY"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B69BB146D60
	for <linux-pci@vger.kernel.org>; Thu, 16 May 2024 13:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715865209; cv=none; b=ebu3GmErMmtP9JKjdnR+kX3gwG1kDiIZNPmbbY/wywElU2r9sDO1PArbnLMBz1+hLiMGXpvVrC5FYKs0eQa8uddoo8klgAtT2MgyQ4eXJcc2mIAXJ37raKeHW536IxB0Cz/YtoD1Ld45ygCA6SOzXfZj6Vt/os1VUhxvoJ9k1DA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715865209; c=relaxed/simple;
	bh=dtd4iyliPDvaVoHet9Iu/w99q8VWU7+7Di+EZZbiPyU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JHyQWt4GCaEfBEefQUOdV/Y3leqiIV50x9JvnQIivifL/8R20WP8igIPsMnWiStZD8m3Uhe2zHd02GCwxF5sDlSdCsWQJYebP1ny1kOQczLb8b9Fnuk15yXjls7janWcUZlfZC0ltrlsxEvhK1TY6/tKpqAnh9asBr5XHxVbG70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cn+o1+DY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715865206;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OSy7yg6jMdWHxfxX09d5z7SmLjQyRKKO4cx1YTEDaNs=;
	b=cn+o1+DYYcdCOI6KUys/GO9s3zJB2HxKqV5hrMYX4IhoZgOND3KS4uN6J5HA/LkyXIt0o4
	Dnv9QNRtBZvOJaKYwt0yxVDYsKf3D+v1EMlEsrDTEFYxN33q/8H9wqyUDzTfNyu4xZlCeu
	dlgTw+jxfIACu6SHQMHtUBcKcycaVY0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-472-_Ddr6FQcNEK9sPmQQP0cSw-1; Thu, 16 May 2024 09:13:23 -0400
X-MC-Unique: _Ddr6FQcNEK9sPmQQP0cSw-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-34eb54c888cso6130432f8f.3
        for <linux-pci@vger.kernel.org>; Thu, 16 May 2024 06:13:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715865202; x=1716470002;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OSy7yg6jMdWHxfxX09d5z7SmLjQyRKKO4cx1YTEDaNs=;
        b=nFQrVnO7qmIhjLY5g97KuXVShLBvPemXYE3Jw8tKAIqRICxQhqTbiA9NmFjFnn2+re
         737ndKZ76xePGHnV3TFvyLrTcEZqBUEW7wEYevdK2T6dbbvqX0SIsCp83YvviopCozNJ
         Da1bwcs8fIUe7D9DPYiFuHqNTXGzf8T528/5w8njJBtv1FjIVXHAY36FfNscA4tKXqMz
         lChuQ6jLhVAZh+KoAlXCcBNtBWmyLoycKNvyQ3CCdB8gjkej+KDrpnOQrJeLf9piQuR2
         F1fSBvJUoh4s7cBE9DIlfoC6TKYhPq4ncUpKeR4+5ImphE1TfuH4+1XcYRaiDE3u2czZ
         1jmQ==
X-Forwarded-Encrypted: i=1; AJvYcCXEw8yTTe2QLUI312ulwbn26mMiaI2aKEcAm1CCZU80QLEhdcUQsfeVLWK0X6T/HMimeHAz+SFkFqnXMf+ficbekxEYKzvjHb85
X-Gm-Message-State: AOJu0Yz16aTLPamhnp3B29KOahLy9ZXOQ6Qy6Yw9hoDHwtZ+iOPh2NZ4
	PD89XCIb66939+7eqhbgWzCD4+3fLY/GzvHVYCplMnyIvSZ3QHDe6AKeJQ67NsQAfXcIlq5EAjo
	zcENcrn2JRA3WmcZ8E0R3BoL8B9DJ1S3DSh6MtZSYB+sL2I6KQqn6xXBb0w==
X-Received: by 2002:adf:b1de:0:b0:351:b2ff:63a8 with SMTP id ffacd0b85a97d-351b2ff64bfmr13163038f8f.16.1715865201873;
        Thu, 16 May 2024 06:13:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFA5A0Z4lKyhtRXL+abQQ48JwBKJ6OTwX20epAfBjFZPy6ZIE08R+/aOGNiGghuAu5Wsstb3g==
X-Received: by 2002:adf:b1de:0:b0:351:b2ff:63a8 with SMTP id ffacd0b85a97d-351b2ff64bfmr13163013f8f.16.1715865201301;
        Thu, 16 May 2024 06:13:21 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f0:8a3f:2db6:ab3d:a443:822c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3502b8a789asm18993930f8f.51.2024.05.16.06.13.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 May 2024 06:13:20 -0700 (PDT)
Date: Thu, 16 May 2024 09:13:17 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Shunsuke Mie <mie@igel.co.jp>, linux-pci@vger.kernel.org,
	virtualization@lists.linux.dev, jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com
Subject: Re: [RFC] Legacy Virtio Driver with Device Has Limited Memory Access
Message-ID: <20240516091053-mutt-send-email-mst@kernel.org>
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
> 

virtio 1.0 was released 10 years ago.  Just implement the modern spec.
Or if there's something wrong with the modern spec, tell us and we will
try to fix it.

> -- 
> மணிவண்ணன் சதாசிவம்


