Return-Path: <linux-pci+bounces-37366-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 11357BB176C
	for <lists+linux-pci@lfdr.de>; Wed, 01 Oct 2025 20:16:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2FDB4A00ED
	for <lists+linux-pci@lfdr.de>; Wed,  1 Oct 2025 18:16:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 999892D46A7;
	Wed,  1 Oct 2025 18:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C3kpi5yh"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E97A9257452
	for <linux-pci@vger.kernel.org>; Wed,  1 Oct 2025 18:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759342601; cv=none; b=u3jMWrkZA9ozgdgeo4TWa5+tQCjH4ZNCl9Lz3S5GQREYchskiFAmxJ69+NQmrlQYbo/3RVheIulOrEqyH7RVoqi7+iwE3jXc93twgwW3+eQGeuUGmakxEZxhVXIWLPQQtWYNyK1FXz1d4aFW1ckA1JV0jTINFCzPEK7sKyna6F0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759342601; c=relaxed/simple;
	bh=C3elPI9v7C6y0EwKsTNJ7aKVDWwycBt2YooymvV8Ass=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=srwDNf96xrQKSn1yxGSOtkp5XVq5uGni46Gm7Tc387Lne4KiCG99OTjEuPXOTrMj18cfkXUTF3sLubKfFvPX78Nb5rKyonAdkBXZ+iiiy0UYwWfeGeyP9RM7R7dOD2uciFBqLn8rd+adHuwecLZltmPceklCCWM6veBRer4Wxuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=C3kpi5yh; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759342599;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Hl5yRJD3IkUvsBwDHH8M7CQ5CZxrZ7ikFZVETEwQEng=;
	b=C3kpi5yhR1B+p5/J2C85sM/rX8PapX53uHvdHAQ3TijzUMGxd38p4HkuWHp9u7jWYVxr3Q
	V9R3hAf8ha28LvmPqoAnVMftPrKHZqULfFuXc9CpSxM6AgO8cPLvd8j3yqVCJH2On9cPhF
	ebE3OwrZ+foFktqb43JN5VD15fPGO/8=
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com
 [209.85.166.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-493-smbJfOymO5i5KXU9pmw8LA-1; Wed, 01 Oct 2025 14:16:37 -0400
X-MC-Unique: smbJfOymO5i5KXU9pmw8LA-1
X-Mimecast-MFC-AGG-ID: smbJfOymO5i5KXU9pmw8LA_1759342595
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-4272d0bebf0so324085ab.0
        for <linux-pci@vger.kernel.org>; Wed, 01 Oct 2025 11:16:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759342595; x=1759947395;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Hl5yRJD3IkUvsBwDHH8M7CQ5CZxrZ7ikFZVETEwQEng=;
        b=BRvRy/heqv6FiIIF9gQs4zN1GsBoyvTbhpqJSR6v3ZcO0Zt+hr7/RT/QGUXYQXSpXO
         UC1vmfdkPfzlsu+bCyddX6xO9+spmeJbSAbi21mW+GjNSwTQwnLbYOuEavWCeg5v2FX8
         elDWedI63Cj2Rzqt1GZXh8Kg93I+/1abDobYq/WMDUKnRmRuLgS4eUBI/rJGtgVZJqBs
         maq82ChQc473kvHSxV+baURCHcX3JOqUWEqk0gQvAzDMKyY3Rnw9zbAVwA8hdaqfWaoW
         MsU2d8Fr1k567N+44SeZqNxK4KuI4wE+zA20U7leDjCFPknVWpHdGNPjTBaujl0rjqae
         VLxg==
X-Forwarded-Encrypted: i=1; AJvYcCVFlWu8SyQh0dF+N7XxWNNkbBsHIeQKsErbo5RVf5oBmWi8/DC8V63fKxUERjJqOPQ7wfiA3/7WAq0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWbbOGKQDthqsLwKyvHnXtVYg4tXywlN5Nh7bFc5b0Aeg8QdXW
	RPrSeWLlxQMUqKO31JTWp25NiKXbnsAGOjWK356uusTXr+aomH8G+qx+rikbmBXI660YuIFzAjT
	70AcDSsQCB3cXuMPaIY1kwKcS9MQ2Y4Eu+qiJWA994P5FymQ3OWyF4TP39qsYsw==
X-Gm-Gg: ASbGnctaMaYQFYsGNH5HZ1TyDl/OqmS9gT0Gd9GlvsaicKx26WOF8Ly2rrraz0Bsii/
	Rk91WlACCk+jPui3O4OZFz+xvCVCZN0tK9BsvQnhtwSb71rrQmLKN0JMPLApHu7jgpBlWw+vt5b
	FhCa+yt1M7tC0ppFcF2QGxTdhx9sSnUsPuSmYcqlqDLImQv8w8qOhlyDIQyMyN20LZsIV9aB/xG
	L0QBn12dKk4Jts6FpEh6zdDfgpaQGjm5ofmNKEntB87qO7mwZXGTQzowsKfKFhtTPPj6umHO7UZ
	Mp49uOMuoK9YCflwFMYK9AK8n3LI/0Te1ruj5bkjWc2Vc9Qb
X-Received: by 2002:a05:6e02:156a:b0:427:8d45:a545 with SMTP id e9e14a558f8ab-42d8167ffcbmr26826705ab.6.1759342594752;
        Wed, 01 Oct 2025 11:16:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHz1/E65PrFu+RbIoFX/NgQBsZUTxT4dfgeMXQ472VKwtzi9DsWrZBCgFVcbSRmX9luhz8ANQ==
X-Received: by 2002:a05:6e02:156a:b0:427:8d45:a545 with SMTP id e9e14a558f8ab-42d8167ffcbmr26826495ab.6.1759342594322;
        Wed, 01 Oct 2025 11:16:34 -0700 (PDT)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-57b5e9ec3afsm62945173.5.2025.10.01.11.16.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Oct 2025 11:16:33 -0700 (PDT)
Date: Wed, 1 Oct 2025 12:16:31 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: John Hubbard <jhubbard@nvidia.com>, Alexandre Courbot
 <acourbot@nvidia.com>, Danilo Krummrich <dakr@kernel.org>, Joel Fernandes
 <joelagnelf@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, Alistair Popple
 <apopple@nvidia.com>, Zhi Wang <zhiw@nvidia.com>, Surath Mitra
 <smitra@nvidia.com>, David Airlie <airlied@gmail.com>, Simona Vetter
 <simona@ffwll.ch>, Bjorn Helgaas <bhelgaas@google.com>, Krzysztof
 =?UTF-8?B?V2lsY3p5xYRza2k=?= <kwilczynski@kernel.org>, Miguel Ojeda
 <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng
 <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?UTF-8?B?QmrDtnJu?=
 Roy Baron <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>,
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl
 <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
 nouveau@lists.freedesktop.org, linux-pci@vger.kernel.org,
 rust-for-linux@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/2] rust: pci: expose is_virtfn() and reject VFs in
 nova-core
Message-ID: <20251001121631.7f2e68f5.alex.williamson@redhat.com>
In-Reply-To: <20251001144629.GA3024065@nvidia.com>
References: <20250930220759.288528-1-jhubbard@nvidia.com>
	<DD6K5GQ143FZ.KGWUVMLB3Z26@nvidia.com>
	<fb5c2be5-b104-4314-a1f5-728317d0ca53@nvidia.com>
	<20251001144629.GA3024065@nvidia.com>
Organization: Red Hat
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 1 Oct 2025 11:46:29 -0300
Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Tue, Sep 30, 2025 at 06:26:23PM -0700, John Hubbard wrote:
> > On 9/30/25 5:26 PM, Alexandre Courbot wrote:  
> > > On Wed Oct 1, 2025 at 7:07 AM JST, John Hubbard wrote:  
> > >> Post-Kangrejos, the approach for NovaCore + VFIO has changed a bit: the
> > >> idea now is that VFIO drivers, for NVIDIA GPUs that are supported by
> > >> NovaCore, should bind directly to the GPU's VFs. (An earlier idea was to
> > >> let NovaCore bind to the VFs, and then have NovaCore call into the upper
> > >> (VFIO) module via Aux Bus, but this turns out to be awkward and is no
> > >> longer in favor.) So, in order to support that:
> > >>
> > >> Nova-core must only bind to Physical Functions (PFs) and regular PCI
> > >> devices, not to Virtual Functions (VFs) created through SR-IOV.  
> > > 
> > > Naive question: will guests also see the passed-through VF as a VF? If
> > > so, wouldn't this change also prevents guests from using Nova?  
> > 
> > I'm also new to this area. I would expect that guests *must* see
> > these as PFs, otherwise...nothing makes any sense.

To answer this specific question, a VF essentially appears as a PF to
the VM.  The relationship between a PF and VF is established when
SR-IOV is configured and in part requires understanding the offset and
stride of the VF enumeration, none of which is visible to the VM.  The
gaps in VF devices (ex. device ID register) are also emulated in the
hypervisor stack.

> > Maybe Alex Williamson or Jason Gunthorpe (+CC) can chime in.  
> 
> Driver should never do something like this.
> 
> Novacore should work on a VF pretending to be a PF in a VM, and it
> should work directly on that same VF outside a VM.
> 
> It is not the job of driver to make binding decisions like 'oh VFs of
> this devices are usually VFIO so I will fail probe'.
> 
> VFIO users should use the disable driver autobinding sysfs before
> creating SRIOV instance to prevent this auto binding and then bind
> VFIO manually.
> 
> Or userspace can manually unbind novacore from the VF and rebind VFIO.

But this is also true, unbinding "native" host drivers is a fact of
life for vfio and we do have the sriov_drivers_autoprobe sysfs
attributes if a user wants to set a policy for automatically probing VF
drivers for a PF.

I think the question would be whether a "bare" VF really provides a
useful device for nova-core to bind to or if we're just picking it up
because the ID table matches.  It's my impression that we require a
fair bit of software emulation/virtualization in the host vGPU driver to
turn the VF into something that can work like a PF in the VM and I
don't know that we can require nova-core to make use of a VF without
that emulation/virtualization layer.  For example, aren't VRAM
allocations for a VF done as part of profiling the VF through the vGPU
host driver?  Thanks,

Alex


