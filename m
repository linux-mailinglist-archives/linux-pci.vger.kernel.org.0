Return-Path: <linux-pci+bounces-8910-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E90590C9C1
	for <lists+linux-pci@lfdr.de>; Tue, 18 Jun 2024 13:37:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8A25284581
	for <lists+linux-pci@lfdr.de>; Tue, 18 Jun 2024 11:37:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AD111527BA;
	Tue, 18 Jun 2024 10:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J5HZVowC"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D47113B583
	for <linux-pci@vger.kernel.org>; Tue, 18 Jun 2024 10:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718707656; cv=none; b=OCNTd1IOipAASddEcqXR9z/PX7lXA/w1FlffIYO1EgJN/Lly+qAWrcwfFvYS1PeqL35uI1DUVMN1YwqdSkQ4mExCf962RTbtNKeEG3weucjEmHq6hGBXv7stoDB2/PaaACjodNTLKIASJE+TZ/vZQiSLGpz9ezJ0jQjdAVdHs7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718707656; c=relaxed/simple;
	bh=bbFDJ9d+NeKK+CO4zNLMqES2opGAC32Y6IWmOx4SgBE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pfgzQLI0McFb0nCJCa/1P1L1PK4D7I7GRHjcZ1DBj2xM8qm99a+NU/IWy+SikKKX50EdxximIZHpii1ftx378WN+juyU6FRSzJgIFgXyF7wi+hm5nZH8ryj+1KN2Be3n3JbCQvhJEfzBxIVjDoWkBHBJ+OfOQC2hpMC5BXvv7o4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=J5HZVowC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718707653;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EOUtL3UGrQmccc3gpNc49cvfnyOLInhzKNWaCqBhVrI=;
	b=J5HZVowCAWwuJ0Ntx2TsgkCSs05L0SzQALNbhe1UMZiw3PeaYwWCLwI3T8kLtU3KTba3UE
	laxsBSG6Bk+KVGmEsyMn08YypFa95K+1UPV87iSH0EPIV9fykr5FVUavoOT4r5CWjqO1H8
	MFlCWdaWMir4bjG2omwbrwNDPq9rNcg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-441-LUaz9ghvO0ObMCaQnBOCCw-1; Tue, 18 Jun 2024 06:47:31 -0400
X-MC-Unique: LUaz9ghvO0ObMCaQnBOCCw-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-421f3b7b27eso47653795e9.1
        for <linux-pci@vger.kernel.org>; Tue, 18 Jun 2024 03:47:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718707650; x=1719312450;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EOUtL3UGrQmccc3gpNc49cvfnyOLInhzKNWaCqBhVrI=;
        b=V5DJR+wIts1T1+7LDVanyCjhMmtTLYrOcBpiSpLxBWetbQVpGtlYWoLcSCATkJEllk
         fAmCZqwvHFmVD+O4/BedxahtbF/vZJS0QbQXlpGLQyziLLiuHWT4JiOdhIIXukMuhe+1
         Di52S7C8VCJgTReaY5H6ijcvxiwJqN1aDlXXwC14O5F+MkWHP7cdG1n9Kdx2sXB9DnvT
         g/w+tFRRS2ukwMCxhNfubiEffUA/e3c9eJAeeGjej/2K3/51G7zQSNP9qKe1EPAAbrof
         tBnn7s2+va0Nmz0R+w0/qf7qj24ZnsONrm9fM49yGa0527F1p9Zn3QewIMAmnV6wS2Vz
         fpSQ==
X-Forwarded-Encrypted: i=1; AJvYcCUjene2q76fQ00fQjZ7RCAS86Nhh7aNkvfQS6ntQWo271kbfwBIYpRgdjFduMqSdTjnAABld1b3bus61Z8qAuZa2ihL6kfOGLBG
X-Gm-Message-State: AOJu0YwFHj+FfrTLJ9AY+eVWEYaAHRjvvZ05QpWeoA+jYe0Zo3vdxbAo
	a/pEZ8drc8u5VSsnABVcKyzXmESUeybHG38zvm+3KhD5/icDxHB4e5qXG70CfnWy56PhSaRnhO0
	lCB74IdeZnVb2J2XoUVe1H2ULFNYDKIhNVoVOwdvrvVBNBbcsBFUU8u/nOw==
X-Received: by 2002:a05:600c:a01:b0:422:50d7:100b with SMTP id 5b1f17b1804b1-42304820c95mr111537595e9.14.1718707650487;
        Tue, 18 Jun 2024 03:47:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF4ImD7bgDtwoo7yFTpUhWD2pMBpu08/uRi1Aski/T8Bq/xpyc9IGyMV0M6WmxVCM62NRmy4w==
X-Received: by 2002:a05:600c:a01:b0:422:50d7:100b with SMTP id 5b1f17b1804b1-42304820c95mr111537265e9.14.1718707649552;
        Tue, 18 Jun 2024 03:47:29 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:441:67bf:ebbb:9f62:dc29:2bdc])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-360750935ecsm13902939f8f.3.2024.06.18.03.47.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 03:47:28 -0700 (PDT)
Date: Tue, 18 Jun 2024 06:47:25 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Shunsuke Mie <mie@igel.co.jp>
Cc: Manivannan Sadhasivam <mani@kernel.org>, linux-pci@vger.kernel.org,
	virtualization@lists.linux.dev, jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com
Subject: Re: [RFC] Legacy Virtio Driver with Device Has Limited Memory Access
Message-ID: <20240618064231-mutt-send-email-mst@kernel.org>
References: <CANXvt5r00Y5VGKSFXFnwbvGF+fhh2uNvU5VBGwECA9yabK4=Uw@mail.gmail.com>
 <20240516125913.GC11261@thinkpad>
 <20240520090809-mutt-send-email-mst@kernel.org>
 <20240614095033.GA59574@thinkpad>
 <CANXvt5ojosFbt60Gcfym1DX96W7SiX4X15dMGdSCVEPhUTpk=w@mail.gmail.com>
 <20240618054115-mutt-send-email-mst@kernel.org>
 <CANXvt5psZAkEOJtxO250n6vjZTK7as-F-4qr1Rc3awZsmqWCpQ@mail.gmail.com>
 <20240618061705-mutt-send-email-mst@kernel.org>
 <CANXvt5pDjvVwFLS3p0a4hx1-MUJGsKHnpEsjejYUcmvTeKyFmg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANXvt5pDjvVwFLS3p0a4hx1-MUJGsKHnpEsjejYUcmvTeKyFmg@mail.gmail.com>

On Tue, Jun 18, 2024 at 07:40:34PM +0900, Shunsuke Mie wrote:
> 2024年6月18日(火) 19:33 Michael S. Tsirkin <mst@redhat.com>:
> >
> > On Tue, Jun 18, 2024 at 07:15:47PM +0900, Shunsuke Mie wrote:
> > > Thank you for your response.
> > >
> > > 2024年6月18日(火) 18:47 Michael S. Tsirkin <mst@redhat.com>:
> > > >
> > > > On Tue, Jun 18, 2024 at 08:41:09AM +0900, Shunsuke Mie wrote:
> > > > > Let's clarify the situation.
> > > > >
> > > > > The Virtio device and driver are not working properly due to a
> > > > > combination of the following reasons:
> > > > >
> > > > > 1. Regarding VIRTIO_F_ACCESS_PLATFORM:
> > > > > - The modern spec includes VIRTIO_F_ACCESS_PLATFORM, which allows
> > > > > Physical DMAC to be used.
> > > > > - This feature is not available in the legacy spec.
> > > >
> > > > ... because legacy drivers don't set it
> > > >
> > > > > 2. Regarding Virtio PCIe Capability:
> > > > > - The modern spec requires Virtio PCIe Capability.
> > > >
> > > > It's a PCI capability actually. People have been asking
> > > > about option to make it a pcie extended capability,
> > > > but no one did the spec, qemu and driver work, yet.
> > > >
> > > > > - In some environments, Virtio PCIe Capability cannot be provided.
> > > >
> > > > why not?
> > > PCIe Endpoint Controller chips are available from several vendors and allow
> > > software to describe the behavior of PCIe Endpoint functions. However, they
> > > offer only limited functionality. Specifically, while PCIe bus communication is
> > > programmable, PCIe Capabilities are fixed and cannot be made to show as
> > > virtio's.
> >
> > Okay. So where could these structures live, if not in pci config?
> What does "these structures" refer to? PCIe Capabilities? virtio configs?

Virtio uses a bunch of read only structures that look like this:

struct virtio_pci_cap {

	..... [skipped, specific to pci config caps] ...

        u8 cfg_type;    /* Identifies the structure. */
        u8 bar;         /* Where to find it. */
        u8 id;          /* Multiple capabilities of the same type */
        u8 padding[2];  /* Pad to full dword. */
        le32 offset;    /* Offset within bar. */
        le32 length;    /* Length of the structure, in bytes. */
};


The driver uses that to locate parts of device interface it
later uses.


Per spec, they are currently in pci config, you are saying some devices
can't have this data in pci config - is that right? Where yes?


> > --
> > MST
> >


