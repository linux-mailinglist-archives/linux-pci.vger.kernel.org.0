Return-Path: <linux-pci+bounces-8954-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A98CF90E492
	for <lists+linux-pci@lfdr.de>; Wed, 19 Jun 2024 09:33:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D15B2863D7
	for <lists+linux-pci@lfdr.de>; Wed, 19 Jun 2024 07:33:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F133763FD;
	Wed, 19 Jun 2024 07:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="coCvwPGm"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90D53770E3
	for <linux-pci@vger.kernel.org>; Wed, 19 Jun 2024 07:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718782378; cv=none; b=nH+Z1x4SzcLR50Qjmrm7z8OAwFemO+clyCTO1k5rO4PmGPo78WprGNqSqH3b0DuBg/unTpitCvrgqglSMWKfGvEQxBS2KUNIBKtHTIy3ECkdiQsCoCXloEsvBG96gDmd+Eys6w0hXcbDDvXKOstezq4q6gOCnHTZiuM/Gk1dpL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718782378; c=relaxed/simple;
	bh=YnVIBVW+DucY1bvIa21vpFhPXS6nuJHaOh2ceP7KWWI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T+QwYoL3RL+nzjkRHqBGwVC8WkNXc6ZZ8jPtrupOg/9/EsKwsdydXKOO0+xbfF8KP6kgGruP9bb0SGjsxlCX/gT8tBB/mIAV/ufHOo0XNVEPCy7jaPDRsZGH6w1si/RI07VHwGi2nEKHtsAb9bry0NLYJahw64cKQS4+9hNQYGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=coCvwPGm; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718782375;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4mtDCVVnBIT0YPxVqNog2X+Um6e5a8CYkKH0uc+Y5to=;
	b=coCvwPGmAWO0ajs+bdRnU1HDM/bGVzA4hxZ7BZSbqXn5smFBDJeuGSnxU77ZH0LdwMZABG
	AKVxZKfsli52Aweb767xmc3xZTFYindF1yIlLwvhfx31Ki0uG4nHoKTpOBMMBeoCdjHNRy
	tJgJZ/FXNQw21oIHXEhWInTn8wFS2qw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-213-F3LCAobsNVKhcZvgFG5_tw-1; Wed, 19 Jun 2024 03:32:54 -0400
X-MC-Unique: F3LCAobsNVKhcZvgFG5_tw-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-35f1fcd3bbcso3020728f8f.0
        for <linux-pci@vger.kernel.org>; Wed, 19 Jun 2024 00:32:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718782372; x=1719387172;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4mtDCVVnBIT0YPxVqNog2X+Um6e5a8CYkKH0uc+Y5to=;
        b=dAAU5Tke4QrLUJV6kk2k04vKcIu1wBBBSziysDy10VgZp48gjj88msscYjemgIVq49
         zPyehoWytkM5rXDpw2CLzqt/4hHNLLrj00tlZHyP9t+XloXKa6D/causQDNA6M+ubdVQ
         3FY3T8olTQhi38rizn2zHacBGishwKlt93yOq2WtoMbULKirYmUraVwLcgzBO5rKl9MM
         7TR3MiI166YnNnQEN4EAFMQPbq0J7fBqeXBFMyig3OAkLQzJZ0sIs7asp42ZB8r7kfFR
         fC/A026jxRlaMIY9w5Tzws3uifYThOfB767rZtc2nmB8Ql0IcgBEGfWdBw98e3QZs6ve
         6dXA==
X-Forwarded-Encrypted: i=1; AJvYcCVxfcjF8qcuGhtjBZP4Oc0/51Hp61S0ahFjAQC7M1bJhQztHWf4X5LDBg7DsPJd7/ky63+ybIwJFnE9YODpUYbaYY4EjwLDZjn8
X-Gm-Message-State: AOJu0YwA91HI+QbRf52/oJaf9/wOyIQvtWTSHZu6HjsDXgY+tueqb9Xd
	vnbRibNVw5xmw9JUCUyyvJRVmSa0Q7XYvC46321kXhNwZReCop08LYfRYJ8s9YrjTnwoSYbQvhw
	8N/xvLdsYry6kEwnlD7uhZ3rPl+6V+jCSAd5wnaT/bnzC5ocmahiPlYPs1t2LHFLaZg==
X-Received: by 2002:adf:e410:0:b0:361:f6b5:c158 with SMTP id ffacd0b85a97d-363192ce375mr1196501f8f.55.1718782372355;
        Wed, 19 Jun 2024 00:32:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFWu8WQcXPnvy3BVybhXSi/i857J9YUn472E47YOCG8+sh0GllZpTAgcvjYtFfrr1zBYku75w==
X-Received: by 2002:adf:e410:0:b0:361:f6b5:c158 with SMTP id ffacd0b85a97d-363192ce375mr1196472f8f.55.1718782371635;
        Wed, 19 Jun 2024 00:32:51 -0700 (PDT)
Received: from redhat.com ([2.52.146.100])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36075093a4asm16316367f8f.21.2024.06.19.00.32.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 00:32:50 -0700 (PDT)
Date: Wed, 19 Jun 2024 03:32:41 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Shunsuke Mie <mie@igel.co.jp>
Cc: Manivannan Sadhasivam <mani@kernel.org>, linux-pci@vger.kernel.org,
	virtualization@lists.linux.dev, jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com
Subject: Re: [RFC] Legacy Virtio Driver with Device Has Limited Memory Access
Message-ID: <20240619032703-mutt-send-email-mst@kernel.org>
References: <20240516125913.GC11261@thinkpad>
 <20240520090809-mutt-send-email-mst@kernel.org>
 <20240614095033.GA59574@thinkpad>
 <CANXvt5ojosFbt60Gcfym1DX96W7SiX4X15dMGdSCVEPhUTpk=w@mail.gmail.com>
 <20240618054115-mutt-send-email-mst@kernel.org>
 <CANXvt5psZAkEOJtxO250n6vjZTK7as-F-4qr1Rc3awZsmqWCpQ@mail.gmail.com>
 <20240618061705-mutt-send-email-mst@kernel.org>
 <CANXvt5pDjvVwFLS3p0a4hx1-MUJGsKHnpEsjejYUcmvTeKyFmg@mail.gmail.com>
 <20240618064231-mutt-send-email-mst@kernel.org>
 <CANXvt5pbdsSMc9C-nV0MiOAJPVyxXKu5otwLp2yopqBdNLS26A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANXvt5pbdsSMc9C-nV0MiOAJPVyxXKu5otwLp2yopqBdNLS26A@mail.gmail.com>

On Tue, Jun 18, 2024 at 09:51:41PM +0900, Shunsuke Mie wrote:
> 2024年6月18日(火) 19:47 Michael S. Tsirkin <mst@redhat.com>:
> >
> > On Tue, Jun 18, 2024 at 07:40:34PM +0900, Shunsuke Mie wrote:
> > > 2024年6月18日(火) 19:33 Michael S. Tsirkin <mst@redhat.com>:
> > > >
> > > > On Tue, Jun 18, 2024 at 07:15:47PM +0900, Shunsuke Mie wrote:
> > > > > Thank you for your response.
> > > > >
> > > > > 2024年6月18日(火) 18:47 Michael S. Tsirkin <mst@redhat.com>:
> > > > > >
> > > > > > On Tue, Jun 18, 2024 at 08:41:09AM +0900, Shunsuke Mie wrote:
> > > > > > > Let's clarify the situation.
> > > > > > >
> > > > > > > The Virtio device and driver are not working properly due to a
> > > > > > > combination of the following reasons:
> > > > > > >
> > > > > > > 1. Regarding VIRTIO_F_ACCESS_PLATFORM:
> > > > > > > - The modern spec includes VIRTIO_F_ACCESS_PLATFORM, which allows
> > > > > > > Physical DMAC to be used.
> > > > > > > - This feature is not available in the legacy spec.
> > > > > >
> > > > > > ... because legacy drivers don't set it
> > > > > >
> > > > > > > 2. Regarding Virtio PCIe Capability:
> > > > > > > - The modern spec requires Virtio PCIe Capability.
> > > > > >
> > > > > > It's a PCI capability actually. People have been asking
> > > > > > about option to make it a pcie extended capability,
> > > > > > but no one did the spec, qemu and driver work, yet.
> > > > > >
> > > > > > > - In some environments, Virtio PCIe Capability cannot be provided.
> > > > > >
> > > > > > why not?
> > > > > PCIe Endpoint Controller chips are available from several vendors and allow
> > > > > software to describe the behavior of PCIe Endpoint functions. However, they
> > > > > offer only limited functionality. Specifically, while PCIe bus communication is
> > > > > programmable, PCIe Capabilities are fixed and cannot be made to show as
> > > > > virtio's.
> > > >
> > > > Okay. So where could these structures live, if not in pci config?
> > > What does "these structures" refer to? PCIe Capabilities? virtio configs?
> >
> > Virtio uses a bunch of read only structures that look like this:
> >
> > struct virtio_pci_cap {
> >
> >         ..... [skipped, specific to pci config caps] ...
> >
> >         u8 cfg_type;    /* Identifies the structure. */
> >         u8 bar;         /* Where to find it. */
> >         u8 id;          /* Multiple capabilities of the same type */
> >         u8 padding[2];  /* Pad to full dword. */
> >         le32 offset;    /* Offset within bar. */
> >         le32 length;    /* Length of the structure, in bytes. */
> > };
> >
> >
> > The driver uses that to locate parts of device interface it
> > later uses.
> >
> >
> > Per spec, they are currently in pci config, you are saying some devices
> > can't have this data in pci config - is that right? Where yes?
> I understood. The configuration structure is in the space that is
> indicated by BAR0.
> Follows the instructions in the spec:
> ```
> 4.1.4.10 Legacy Interfaces: A Note on PCI Device Layout
> Transitional devices MUST present part of configuration registers in a
> legacy configuration structure in BAR0 in the first I/O region of the
> PCI device, as documented below.
> ...
> ```

No, and it's best everyone stopped talking about legacy like we
are going to add new features to it.

The configuration structure is in the space that is
indicated by the vendor specific structure, which is currently
in pci config space.

If use of a vendor specific structure in pci config space is
problematic, we can try to fix that by extending the virtio spec.


> >
> > > > --
> > > > MST
> > > >
> >


