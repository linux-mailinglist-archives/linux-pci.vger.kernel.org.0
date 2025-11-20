Return-Path: <linux-pci+bounces-41806-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EDB7DC7529D
	for <lists+linux-pci@lfdr.de>; Thu, 20 Nov 2025 16:56:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6A8FE3640D8
	for <lists+linux-pci@lfdr.de>; Thu, 20 Nov 2025 15:50:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4806B376BC8;
	Thu, 20 Nov 2025 15:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aQSSgymC";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ovElWv/n"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28870376BEB
	for <linux-pci@vger.kernel.org>; Thu, 20 Nov 2025 15:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763653780; cv=none; b=LNzPqGjaQMltinWuhjZLlQ6rWPxCFy/tQUDEk7bNZF/PpPgMQdV6meWB2bVy0G+FJ4PDg82MUO/WrCR7lqoONEsRSvSiffvxtDde/8nROnU7V5DsTYvRMl08QTHDxrI5SwJfMX+ECSETytJxjrUecIFrSb82J+sPxnjaHa4JY2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763653780; c=relaxed/simple;
	bh=Z7khxCy0juQFD7sc2XVpGJcgIRewBFI8alTprYiEvgk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t8sVzXPf/GCC9g6ffddyKZw+TA+76lCNqqGD5DU3oqZ+FNNaQtyks75Y0i+e2zF6JHGDe6nRIHUFkcv+AMIe102fX7V2QM+7qo2ReJqn7RYeHKEM4fh2Blfz4mA6sMtUnpDAQrdLnq3RMfjdTXlDc3r7xgiu16S7x9Z5rHIM3Rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aQSSgymC; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ovElWv/n; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763653776;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=91ugE35V8USHsTpLgO4hUdjEiFkkZFTQ1do7SDOhLck=;
	b=aQSSgymCnqqz/DY/QMXDcHrLoxY0AkUSvIFmAKHmkE+wI+7h96ngPEu+zCctjvl3h9z6xM
	6JBkedloNP8RwfP7B/gYkYTJEDPLiRd/4/yd8wDJrbwETZDbc423NYoK705B0dkC8CmBQ3
	hy8wNcpr8W8LGXD2bBRzAkMR20n583o=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-520-ySoLOcCKOZeFmbmnuYlDCQ-1; Thu, 20 Nov 2025 10:49:35 -0500
X-MC-Unique: ySoLOcCKOZeFmbmnuYlDCQ-1
X-Mimecast-MFC-AGG-ID: ySoLOcCKOZeFmbmnuYlDCQ_1763653774
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-8805c2acd64so29786146d6.3
        for <linux-pci@vger.kernel.org>; Thu, 20 Nov 2025 07:49:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1763653774; x=1764258574; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=91ugE35V8USHsTpLgO4hUdjEiFkkZFTQ1do7SDOhLck=;
        b=ovElWv/n8dnhczOqizRX4esUtAJiuOqGukPFGw96GFA5HTajt/uuIIvkNISom4jA2G
         9eDnwOXNsHkL8FDJeAc4oZ7d11fwMGm7vn9Yfiyj2eCweLEy8/Z4MaH/1GqruIyDiAU+
         BBc16guepRcZVx2QAhy+qAEQZrG5fU/6kMn+54AZPfaInMKz87wWJtH6M5eT9j5338t7
         q+OiSVGacEoH3ELPaNCeFrokQgaxkD0h7D5Z54ciaH+Anxi2kXnwm7854TUK9JI/IaHu
         NQDKt9nzDYjiSz/tP3DIHXnKVvbYGVOEXLG6uRSDFjD3QTGtFMIfSxharQz/2y6EPpi+
         YiLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763653774; x=1764258574;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=91ugE35V8USHsTpLgO4hUdjEiFkkZFTQ1do7SDOhLck=;
        b=IqEXLkheJiN2UyVlPB0zqc6XnxfiqLfSCwiRYpnwLogoGzSP+L+wOJ7QUxpb56xBrt
         hjiZXucnIBj9UeaPBKN+W4LYVdGXLISBN2RrrD8PbliaQOuVeQouLm02JtvsPQIwtZJJ
         82SpASDTPhe1kMGS9cxyem5Dzz7Nx4Z/03En/SWh/mBgj6bW4RY6WvyfckODDke/CHu7
         bw4EsgCFaso3/wL+zukYPBaZbLEeVbrEFs4nFRxpshNyIW6Obo6rLL0WDCLQbFDcQCvO
         AtuAy+/o+Bm20ONjBiwkA1dkCLLN/09iTrxSQnivDbA9Q+7q+uIRoJNFKGsG5OlJzQPy
         RzXw==
X-Forwarded-Encrypted: i=1; AJvYcCU9CzPHAZcyo5IvXhMewSgEzWTbV0ipBE+8iZR65T1NYl9SYPGETehX0zvn2OtlGS0z7K7P7qdHD5U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZrttuMFq76wpWI1XfswjL7GEZeSYDfrre1EtOCmxY6ipszgl4
	xfJWRFENjtyQS28SJBQl5Q1DD1G6NfxN3jfsaYXbiSjj7FFzYDsk4/LUd2Otbv1Pp75fZWJzTQ9
	7epqJlKGZpKVLAoW+xQ/q15aW5EJ43w1d33W8SrCOa1tihlXwdka9EM3kvQC99w==
X-Gm-Gg: ASbGncuZ+n1UaohFEhwuCBS6j1zD5QcY3ewPe6CxRhegDFyf3T3gE2odiu1a6bdnLhC
	NoFWXCICwtQbSQ29CaJ+44cFeLGNjt6AZAVVqaPiTqHhM035XnF4csbEhi3B1xH9/+lblpZWmp7
	xO3AVfr3BzW3CrcTX/CJPSQF9YXEVl0N0S39s2PUltVaFfDmq1mt8pRjN0l6yd1e+iS/fRO1t+4
	NeaEmYHbsSf/Uy20aVclFzw/XfzG5ksBxifStobmakkvUj+pOFm1cZ1lsnHlg2s/u+XdZj37VZY
	YzecFyvE7t707i58PV1qnwsIvggT2OpRxvNRK4yIayQG+8aYfeHax6w9p/Qv9zGWvFqpzrdDFWn
	N8xde7Fvc
X-Received: by 2002:a05:6214:3283:b0:87c:1fd9:da52 with SMTP id 6a1803df08f44-8847a3d973dmr12006d6.9.1763653774132;
        Thu, 20 Nov 2025 07:49:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHZDZecDuAU2AHXM6Uqgl8MchJS3ZXsbLZQMQHbbLh7Q6dI9fcKtwuWdhAIK4pa19g+Q9VupA==
X-Received: by 2002:a05:6214:3283:b0:87c:1fd9:da52 with SMTP id 6a1803df08f44-8847a3d973dmr11206d6.9.1763653773470;
        Thu, 20 Nov 2025 07:49:33 -0800 (PST)
Received: from localhost ([2607:f2c0:b141:ac00:5cae:3da9:9913:ff7])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-8846e573909sm19710936d6.39.2025.11.20.07.49.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Nov 2025 07:49:33 -0800 (PST)
Date: Thu, 20 Nov 2025 10:49:32 -0500
From: Peter Colberg <pcolberg@redhat.com>
To: Zhi Wang <zhiw@nvidia.com>
Cc: Danilo Krummrich <dakr@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Abdiel Janulgue <abdiel.janulgue@gmail.com>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Dave Ertman <david.m.ertman@intel.com>,
	Ira Weiny <ira.weiny@intel.com>, Leon Romanovsky <leon@kernel.org>,
	linux-pci@vger.kernel.org, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alexandre Courbot <acourbot@nvidia.com>,
	Alistair Popple <apopple@nvidia.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	John Hubbard <jhubbard@nvidia.com>, Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH 8/8] samples: rust: add SR-IOV driver sample
Message-ID: <aR84jHNj0rhNRbaK@earendel>
Mail-Followup-To: Zhi Wang <zhiw@nvidia.com>,
	Danilo Krummrich <dakr@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Abdiel Janulgue <abdiel.janulgue@gmail.com>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Dave Ertman <david.m.ertman@intel.com>,
	Ira Weiny <ira.weiny@intel.com>, Leon Romanovsky <leon@kernel.org>,
	linux-pci@vger.kernel.org, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alexandre Courbot <acourbot@nvidia.com>,
	Alistair Popple <apopple@nvidia.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	John Hubbard <jhubbard@nvidia.com>, Jason Gunthorpe <jgg@ziepe.ca>
References: <20251119-rust-pci-sriov-v1-0-883a94599a97@redhat.com>
 <20251119-rust-pci-sriov-v1-8-883a94599a97@redhat.com>
 <20251120084132.40f72ba4.zhiw@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251120084132.40f72ba4.zhiw@nvidia.com>

On Thu, Nov 20, 2025 at 08:41:32AM +0200, Zhi Wang wrote:
> On Wed, 19 Nov 2025 17:19:12 -0500
> Peter Colberg <pcolberg@redhat.com> wrote:
> 
> > Add a new SR-IOV driver sample that demonstrates how to enable and
> > disable the Single Root I/O Virtualization capability for a PCI
> > device.
> > 
> > The sample may be exercised using QEMU's 82576 (igb) emulation.
> > 
> 
> snip
> 
> > +
> > +    fn sriov_configure(pdev: &pci::Device<Core>, nr_virtfn: i32) ->
> > Result<i32> {
> > +        assert!(pdev.is_physfn());
> > +
> > +        if nr_virtfn == 0 {
> > +            dev_info!(
> > +                pdev.as_ref(),
> > +                "Disable SR-IOV (PCI ID: {}, 0x{:x}).\n",
> > +                pdev.vendor_id(),
> > +                pdev.device_id()
> > +            );
> > +            pdev.disable_sriov();
> > +        } else {
> > +            dev_info!(
> > +                pdev.as_ref(),
> > +                "Enable SR-IOV (PCI ID: {}, 0x{:x}).\n",
> > +                pdev.vendor_id(),
> > +                pdev.device_id()
> > +            );
> > +            pdev.enable_sriov(nr_virtfn)?;
> > +        }
> > +
> 
> IMO, it would be nice to simply demostrate how to reach the driver data
> structure (struct SampleDriver) and its members (I think accessing one
> dummy member in the SampleDriver is good enough, not something fancy),
> which I believe quite many of the drivers need to do so and they can
> take this as the kernel recommended approach instead of inventing
> something new differently. :)

Thanks for the suggestion. I added a `private` member to SampleDriver,
similar to the rust_driver_auxiliary sample, and extended the VF-only
path of probe() to demonstrate how to reach the driver data of the PF
device from a VF device.

Peter

> 
> Z.
> 
> > +        assert_eq!(pdev.num_vf(), nr_virtfn);
> > +        Ok(nr_virtfn)
> > +    }
> > +}
> > +
> > +#[pinned_drop]
> > +impl PinnedDrop for SampleDriver {
> > +    fn drop(self: Pin<&mut Self>) {
> > +        dev_info!(self.pdev.as_ref(), "Remove Rust SR-IOV driver
> > sample.\n");
> > +    }
> > +}
> > +
> > +kernel::module_pci_driver! {
> > +    type: SampleDriver,
> > +    name: "rust_driver_sriov",
> > +    authors: ["Peter Colberg"],
> > +    description: "Rust SR-IOV driver",
> > +    license: "GPL v2",
> > +}
> > 
> 


