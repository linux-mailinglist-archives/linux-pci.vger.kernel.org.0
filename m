Return-Path: <linux-pci+bounces-8908-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1328090C97E
	for <lists+linux-pci@lfdr.de>; Tue, 18 Jun 2024 13:31:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 109DA1C210E0
	for <lists+linux-pci@lfdr.de>; Tue, 18 Jun 2024 11:31:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 523B914A08E;
	Tue, 18 Jun 2024 10:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K+1a7fWW"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1D2B14A63D
	for <linux-pci@vger.kernel.org>; Tue, 18 Jun 2024 10:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718706810; cv=none; b=pW7F0sxL3u3tl99JtKdR0eVT3br0qY75ACFM/KWWa1yN6rXHvMFzcWZVWz5LWpA+2NGEtxC+RQxc5GoHDIaBCxbhqEdyPTtkfBjwTnDJH8AYbbFrdpjLheB19Oo90M3f98t3MemuZnzvP8rUHyco3DkZuuaWgQzJ1Ud4KuIvdYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718706810; c=relaxed/simple;
	bh=3R4ZmGYRCOnDC4CMT6od2Me4vHZyyR45godSVXHsnik=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bvllU5KFBvwFu4aFIuwYSrAF/6FFwyu7oPVBrUpYA86vM0xyRCJRblbhRubbkuxgIxok0kQLJAgAm2+AVCXJtXFxOQxrUhPWAK6eD9KThnUYPG/e2BcqRdlk8ZDwSIEBbVqFIl+bVJY9jwAgfkkF39con7akJMi15CtMC6Sx9Ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=K+1a7fWW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718706807;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f2CpynTXKAlpaIQ4wYDBqhxXchA8ClbLULqxJerRJ5E=;
	b=K+1a7fWW8rKsfAt9FGFAZwklyWb7FNYy4LPHvOrvSKZhZctQOXl1HLJ+ysH7fUDmeWq8Sm
	EWO1sVAv3ndBiKaBioW4VXlybi8QDkcM1gIFYhr7y5S0InDSl/vxQxXdq6+GZmn+Rqwsn3
	l68I/ZfVwzS/dH+xZbz6snZTQxp7fRk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-547-xKkb6fm_MICKDe9FlsMjhA-1; Tue, 18 Jun 2024 06:33:26 -0400
X-MC-Unique: xKkb6fm_MICKDe9FlsMjhA-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4215b0b1c11so40314775e9.3
        for <linux-pci@vger.kernel.org>; Tue, 18 Jun 2024 03:33:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718706805; x=1719311605;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f2CpynTXKAlpaIQ4wYDBqhxXchA8ClbLULqxJerRJ5E=;
        b=RYZ224quixzt2WS2w3yqCv9iPw8iggwFT128fZVVHDN9yLMmSvAYiDTQGQEnBsvLi/
         2x3fMAJLFq/1uJbybeRDUD5Aqssfk0+3NnBb5dIEcqhEZdJskeT5zk17Rvb4CHUQn6OA
         CT3ixfhzdLZyWppmyVB/IW4O88bogKTWpbRCvWxl8JtX39G92LQTWz8eoJ5+itM7efgY
         00u/qKgfUpMXtHDA5azE+gvjVJ4xxpQWcHw/8oB51HaOCIR1Ed7QXFxVW9+eIxjvomuj
         pxmTl0ONxj8mifZH7mOVV0HQidbd5X+/aRPn8wrFVk9LHnwl/NwxHZgGWH00RtTILMxh
         97xA==
X-Forwarded-Encrypted: i=1; AJvYcCVWR0MIp1AGDNsmy+1V9jLKVcODvfvB12m6levty0Xm/dfPfgvoajXjjP4UmtiK0ZRTy+pu+TXoQlB3lS5gM2VTGG2qegHB+wXh
X-Gm-Message-State: AOJu0YyxDB0JDvoaU0RQ49dGvxd+8lM6+MahjHO9eRMFU6Y53+c8W2KD
	KYqp5QErbBjs+S6dWnx9bLuiRrMdbJ5bBXrDiJHHEU8klKgya5MTRhq1NRGo+1Ie16W744g+Hmu
	2Qeg2T7ZsSY3sB6n09FOqGtrqNj/UkLlJlYCHsjg2naLM/ae4DEzHiYaeBw==
X-Received: by 2002:a05:600c:1d29:b0:421:79dc:56e4 with SMTP id 5b1f17b1804b1-42304862690mr89911125e9.41.1718706804950;
        Tue, 18 Jun 2024 03:33:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGLRfy7oQumt6boNaSCbATqsBOpWpSCLkxQ2tSrk9aiZf1c10yHgUWugziswJPSySUZAewIvA==
X-Received: by 2002:a05:600c:1d29:b0:421:79dc:56e4 with SMTP id 5b1f17b1804b1-42304862690mr89910975e9.41.1718706804436;
        Tue, 18 Jun 2024 03:33:24 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:441:67bf:ebbb:9f62:dc29:2bdc])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42286eef70csm224360215e9.3.2024.06.18.03.33.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 03:33:23 -0700 (PDT)
Date: Tue, 18 Jun 2024 06:33:19 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Shunsuke Mie <mie@igel.co.jp>
Cc: Manivannan Sadhasivam <mani@kernel.org>, linux-pci@vger.kernel.org,
	virtualization@lists.linux.dev, jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com
Subject: Re: [RFC] Legacy Virtio Driver with Device Has Limited Memory Access
Message-ID: <20240618061705-mutt-send-email-mst@kernel.org>
References: <CANXvt5r00Y5VGKSFXFnwbvGF+fhh2uNvU5VBGwECA9yabK4=Uw@mail.gmail.com>
 <20240516125913.GC11261@thinkpad>
 <20240520090809-mutt-send-email-mst@kernel.org>
 <20240614095033.GA59574@thinkpad>
 <CANXvt5ojosFbt60Gcfym1DX96W7SiX4X15dMGdSCVEPhUTpk=w@mail.gmail.com>
 <20240618054115-mutt-send-email-mst@kernel.org>
 <CANXvt5psZAkEOJtxO250n6vjZTK7as-F-4qr1Rc3awZsmqWCpQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANXvt5psZAkEOJtxO250n6vjZTK7as-F-4qr1Rc3awZsmqWCpQ@mail.gmail.com>

On Tue, Jun 18, 2024 at 07:15:47PM +0900, Shunsuke Mie wrote:
> Thank you for your response.
> 
> 2024年6月18日(火) 18:47 Michael S. Tsirkin <mst@redhat.com>:
> >
> > On Tue, Jun 18, 2024 at 08:41:09AM +0900, Shunsuke Mie wrote:
> > > Let's clarify the situation.
> > >
> > > The Virtio device and driver are not working properly due to a
> > > combination of the following reasons:
> > >
> > > 1. Regarding VIRTIO_F_ACCESS_PLATFORM:
> > > - The modern spec includes VIRTIO_F_ACCESS_PLATFORM, which allows
> > > Physical DMAC to be used.
> > > - This feature is not available in the legacy spec.
> >
> > ... because legacy drivers don't set it
> >
> > > 2. Regarding Virtio PCIe Capability:
> > > - The modern spec requires Virtio PCIe Capability.
> >
> > It's a PCI capability actually. People have been asking
> > about option to make it a pcie extended capability,
> > but no one did the spec, qemu and driver work, yet.
> >
> > > - In some environments, Virtio PCIe Capability cannot be provided.
> >
> > why not?
> PCIe Endpoint Controller chips are available from several vendors and allow
> software to describe the behavior of PCIe Endpoint functions. However, they
> offer only limited functionality. Specifically, while PCIe bus communication is
> programmable, PCIe Capabilities are fixed and cannot be made to show as
> virtio's.

Okay. So where could these structures live, if not in pci config?

-- 
MST


