Return-Path: <linux-pci+bounces-36681-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4170B91BD2
	for <lists+linux-pci@lfdr.de>; Mon, 22 Sep 2025 16:33:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D280176DD0
	for <lists+linux-pci@lfdr.de>; Mon, 22 Sep 2025 14:32:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16F0E1DF970;
	Mon, 22 Sep 2025 14:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GU/1gWvE"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 447C863CF
	for <linux-pci@vger.kernel.org>; Mon, 22 Sep 2025 14:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758551553; cv=none; b=CoaMmaS7OpfqY6UMsjjAS+0V8a9gJXYlPsxlnJEE7HRzDQFsivm1RSRE4ezjiePU18hgQZcn7Hn6vCm7xp0Y7hFgN9WSrivzxOSxkw3r2cqTqMOym7Tywy3YIukqpai05hGzGDTbOS6pHLSwXmDmTD8IZ+3vlzl8FLU5dYOWmXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758551553; c=relaxed/simple;
	bh=Pz/d1AKtxiiydfZ2IL6Qr72ON6S3upVNRtsNpnhvunk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V3AiR8Uf+HS9M70KvcLIrC2POeegKzn+VAWkc+mLVMZNeYn6LOHzWCzIv6JUV6d1CChc0AYPK/GgBJOeI1BprSIGgrJ1uamWuN2sT2T2z16Gbu17AU/DJj1qKAKjuwhO+sBED3ea8q2VHhJA/XAhvVwV8gacAStZDvZeD6d2Gdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GU/1gWvE; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758551550;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h0mdXlW2PdWw/Qy9V5LGiEj48F/fReTXjEf+9IJupZk=;
	b=GU/1gWvEQNl98vBohI9aSjb4Lk3bVwHbsAMU+RWggWCYzjHtM/DDFvnRxLDHA68j4Bji9q
	wmZNuZAOsw3ygzsibGuDDEqVWVwW+izZ9WN1Qr6lwzSpKOZFFGm1X07FiB22DydZV3H+lY
	pRlWB9MK6TQU3Ibb1pQZ3MWYI9ZPd1g=
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com
 [209.85.160.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-549-BHRFz7xiP5ysAH7CAbWr1A-1; Mon, 22 Sep 2025 10:32:28 -0400
X-MC-Unique: BHRFz7xiP5ysAH7CAbWr1A-1
X-Mimecast-MFC-AGG-ID: BHRFz7xiP5ysAH7CAbWr1A_1758551548
Received: by mail-oa1-f72.google.com with SMTP id 586e51a60fabf-336ee188712so1373923fac.0
        for <linux-pci@vger.kernel.org>; Mon, 22 Sep 2025 07:32:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758551547; x=1759156347;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h0mdXlW2PdWw/Qy9V5LGiEj48F/fReTXjEf+9IJupZk=;
        b=nB0OCCzvP/EMS4O9bOrhzJnIY1iX07ewrKxMBA/LqCWgafVA7mVpLBK52C4Y1zQhTi
         WFxjyLo/JNmfql96IvjwW8Wv9MHtbIywjF2QjnY13kxjA4cyMmJjqR6uOmSp2vqfmRW1
         4/z1AGUUAUSuehRqGhgA1AFMPuxcT3O8SbW6uzzUhSa2mZJNuqoV/vgUs66AeS01aPru
         7X6kM1dHOU33cc/XsfbIxBX7Dp5W90A6tyh/87BQo5zbBaCNa1VXkY5dcOYhYXeiEJtE
         CLUE7jPVVBPBCh9N3IqyDwOzYQ+L3HK0tDDhH9M6NPDOBRg9mReFvqVHFVKCz+VUUZMZ
         R2vg==
X-Forwarded-Encrypted: i=1; AJvYcCWUN1py9BZwqu0cRlr8vxPB/+FTudM4O6YJeEb/D4TD3ie4qwtgxbSw6nBwtanWlhbu0D5INtUKvE0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLYRTjm7C4uCwiQviaLo10OiUs2SMFuvTwu2gMxRysQv5aRCJ6
	iMbAbj6ucpcIgyxXfUExaUhj+gsjwZ5Py+6WzIs51ZMOF0c/8Ak8owYCqQ8LUD90plB0D5RHllf
	bph+tAHnOe9neun5fou2z3LPqqvW7JgN9EjAvYpBIbn2Qe2LULVYLqb1FjdCxi/bxhk7RcQ==
X-Gm-Gg: ASbGncvYNwa+hUS+pdNkvrYXQSZ5qtZGGBYWuWU492qkw+WrtWCBSW/svLFyKH5gWhK
	jQJVGCREjItRDnkzEhtoHmBmkWHtWe9UtmwGtkfBrhu72zb+j4BJYtvZJ2X6vuKg/XctC/AQ7Cb
	6cr7TUxX9kk2wllzA9fSMwIR/KZB4ZwUmuvs1nE/3muvir+d8oOCBDz4sckp1NJJJMn815sdV14
	gVdCfADO8bHK8hQEbCagfViFY2F8LMWhqhHPeDsKtxyUW/rptBJkXOqGM2i/fxm8FRFI36qPWin
	E3RGyUXhKF5+DRj9Osp4afFCfGLSFJv0lPMlfxltoIc=
X-Received: by 2002:a05:6830:264a:b0:782:1cd6:64bc with SMTP id 46e09a7af769-7821cd665e2mr1416054a34.7.1758551547433;
        Mon, 22 Sep 2025 07:32:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFjly970k6GwwNFiNBlI+O+7SRtEFDU8sv3PASleb5pfQi/tEEztPimdT8lHEJXTI5/LbwF/g==
X-Received: by 2002:a05:6830:264a:b0:782:1cd6:64bc with SMTP id 46e09a7af769-7821cd665e2mr1416044a34.7.1758551547010;
        Mon, 22 Sep 2025 07:32:27 -0700 (PDT)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7692c725368sm5811989a34.41.2025.09.22.07.32.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 07:32:26 -0700 (PDT)
Date: Mon, 22 Sep 2025 08:32:21 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Ajay Garg <ajaygargnsit@gmail.com>
Cc: iommu@lists.linux-foundation.org, linux-pci@vger.kernel.org, Linux
 Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: How are iommu-mappings set up in guest-OS for
 dma_alloc_coherent
Message-ID: <20250922083221.5c6a68c0.alex.williamson@redhat.com>
In-Reply-To: <CAHP4M8WOkDvEf6DYe6w+V9PVHkqcu2-8YrKa7jwLBYRAqLVS+g@mail.gmail.com>
References: <CAHP4M8W+uMHkzcx-fHJ0NxYf4hrkdFBQTGWwax5wHLa0Qf37Nw@mail.gmail.com>
	<20250919104123.7c6ba069.alex.williamson@redhat.com>
	<CAHP4M8XQw5_2LX4OpYeO+8bbAEEaRmjQ39+nPzk0qXzwG7uaUQ@mail.gmail.com>
	<20250920083441.306d58d0.alex.williamson@redhat.com>
	<CAHP4M8WOkDvEf6DYe6w+V9PVHkqcu2-8YrKa7jwLBYRAqLVS+g@mail.gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 20 Sep 2025 20:27:54 +0530
Ajay Garg <ajaygargnsit@gmail.com> wrote:

> Thanks Alex for the clarification; really grateful.
> 
> When I had last tried attaching PCI-device to a VM (spawned via VFIO), the
> PCI-device vanished from host-device :)
> 
> So, as of today, if the PCIe device is PASID-capable, can it be :
> 
> a)
> Shared/visible both across a host-os and guest-os?
> 
> b)
> Shared/visible across more than one guest-os?

VFIO doesn't make PCI devices disappear from the host.  Maybe you're
referring to unbinding the host function driver, which might make your
NIC/HBA/GPU device disappear from the host as the PCI device is bound
to vfio-pci instead.

There are ways to multiplex devices between host and guest, SR-IOV is
currently the most common way to do this.  Here you'd have a physical
function (PF) with a host function driver, which can create multiple
virtual functions (VFs), each of which have a unique requester ID and
therefore a unique set of page tables allowing them to operate in
independent IOVA spaces for VMs.  You can imagine here that your PF
remains bound to the host function driver and continues to provide host
services, while the VFs can be assigned to VMs.

PASID is another way to do this and is often described in an SIOV
(Scalable IOV) framework, where we rely more on software to expose an
assignable entity which makes use of the combination of the physical
requester ID along with PASID to create a unique IOVA space through two
levels of IOMMU page tables.

In either case, having an SR-IOV or PASID capability on the device
doesn't automatically enable device multiplexing, there's software
required to enable these features, more so in the direction of SIOV
support as the scalability trade-off is to push more of the basic
device emulation into software.  Thanks,

Alex


