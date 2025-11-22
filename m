Return-Path: <linux-pci+bounces-41912-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A0D09C7D3C0
	for <lists+linux-pci@lfdr.de>; Sat, 22 Nov 2025 17:16:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 69D9B4E1478
	for <lists+linux-pci@lfdr.de>; Sat, 22 Nov 2025 16:16:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B163B1A9F82;
	Sat, 22 Nov 2025 16:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="VAO9RDsc"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3D871494DB
	for <linux-pci@vger.kernel.org>; Sat, 22 Nov 2025 16:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763828179; cv=none; b=aZLMMMhQkGAQJfCCEXkz/DKCq3KSTDC0MKEoGUvctpG+j9osn9rYSfkK4Xyp8xfuh4Nc5drCEHr8TQNF0MWcT5i33LboFVnZ2lt7hi+JoH06yWw27M2Jm8pngY2ne4hrQUD7Oev+0AuuY9fOkezQ+C9hSTXGTmwkdw8YuDy8WyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763828179; c=relaxed/simple;
	bh=pX1YA89IFaBfU73d2M7GD+pvLG2iw0jG0aNV0L0Rb1M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZlnMXYjYZFiv05Xg/IhD1hcgigFmso59GVStKbEsvjErLExffk3D4xwyBvySe0pCpgpwUvT+Dv7fQOyZG2km47yoqpQlXVjUXMu/i7TXnvqoEsp8oT1Ay+/2oZwLEMcAsFwLwaeHJo2xoDX9sMBWZQQevYgvd0McW3ABq6t+JNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=VAO9RDsc; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-8b25ed53fcbso432370285a.0
        for <linux-pci@vger.kernel.org>; Sat, 22 Nov 2025 08:16:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1763828177; x=1764432977; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Sliu87rcQ4v9m7OKQVz8oJsdxUbx8a1OkxUrYzQlGV8=;
        b=VAO9RDsc8+WmkHc8uVX7Jv/DckBEBB6EAN+lJDwkitwFRCe4zShHFcHgYQve88qLoG
         2jO3ZvYqXRAj+NwtiPfpi9lPFagb/Io13NiRofn2G/Hn7AYz8Sxs/Q/K3jRsb/L/HqUa
         UkaiS71usW/WwFCkQaywnv4EluNYK9g/xwtVYfw4aa1kswWj72vISRhWjOi6ieUUqAUi
         B7tSIVQqeeN50W0YhniCf7R1eM8dRJ0XB84rCTCCvyjFfwBTgZ7jiYyO/t6kccYpw0kb
         FScZpVRGo1FwyqOVcbDCEkGMLb0BeW14AXZoQ34UEp2KNojcPuUqGUaQS6IosnOtZ019
         aIpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763828177; x=1764432977;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Sliu87rcQ4v9m7OKQVz8oJsdxUbx8a1OkxUrYzQlGV8=;
        b=UE9h/0C0mVxLO/DHfGu15tuP9mwIxrq5BDhrySjFqTXBAkAsCmwIBsJaB0N7ma4fJi
         BfCoI8QPqGm9Dg0i/OdmuGD6JRSZHjRFHG3PNXk2wV/ykN7BCVd3ScPQHTjOh9abNmnq
         Oynomjs1jOwvo/+lKsTBEn15hRzJtwGTlaEgi/L2GPnVHCrlJF/8YvOJO6bn1Yl2eBG3
         TMGX6tZA6Hcw8x68G4qdot+Jiv1cMVv8CE2LbKVBo18bHldVjWE2XGLcUUzK13aLaFnW
         zK5NhYXUZC8SDC0GZWwbKKLLjEBKBB4E3pkP478SwIP0rxGQjxwVA8ghNx05FsJRh3ld
         rzXQ==
X-Forwarded-Encrypted: i=1; AJvYcCWLAGKUgskBRNM/lF31F0n9x+IAwzi7r+yfTKHbKoQxhC/fq4ngbmc4o06k0hdNL1UJ5cRWpEmttho=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTNuem+jjbtLahWHtjCqHwtKZHpwZD9aKsqfdR2Jy1RitV1rKU
	WpqqTfL9GzJ7erm3VyKUg9UvVW/jNVmfZFmlrI8xIaG97exyHxWjRmXZu/MwnYJxnuE=
X-Gm-Gg: ASbGncsWw6F4fJQMWuyks7n370RSjy9VGDj+v7WwO1rotUFMj2a4NHejwHb/UHA5Ph5
	yDwgEqyaZLIOmy3ep4T139H20ka/9lfNQgIyhaltgk9Q0lM0zbeJh1ToRoBBMG1P/slwhtMo0ZX
	/0+a576q7bCqbYUkPjfK5bqPqsgCuXDfjaElmFoqIhIW+cwMUt/tS29/TdDT24PSIP+1rNot3Z2
	gYGKh04PBt+y+Bq1ilHxdfrB3dv5tUkyudwNRZ/2qwK2kZcJ6je/BF6N5gdAHdIUFHy3STNwMyF
	nIdshbbIWw1UajGlrjWAqKnT3Y8fdMyfUs8uZpnWiUamYDONu5T7w9ycSacijLFojUOB0G8Llgz
	AxyCCPItx1Z+8Xz4FvOf7ZtXfNdqsyUKJDdKUQkCI6KlDBUCFcQHF0bYLk+Nte4FxqqXJYnrCpq
	yejyNeMA5fUnBJAIGf8662ZtsTwe8Phyo4CHmIKZCWu7TpCl0Gr0CZU1aZ
X-Google-Smtp-Source: AGHT+IF1xQ2aXOZRSJ1Y/AkYKw1MLVQYnPBGBGfU9G3n2kPz5F4Qyqm9lRjPssHmLTF/RCQSZSeLVA==
X-Received: by 2002:a05:620a:1905:b0:89f:66a7:3385 with SMTP id af79cd13be357-8b33d203a9emr723597885a.7.1763828176658;
        Sat, 22 Nov 2025 08:16:16 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b3295db8b1sm586245985a.40.2025.11.22.08.16.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Nov 2025 08:16:15 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vMqHX-00000001hDw-0FJm;
	Sat, 22 Nov 2025 12:16:15 -0400
Date: Sat, 22 Nov 2025 12:16:15 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Danilo Krummrich <dakr@kernel.org>
Cc: Peter Colberg <pcolberg@redhat.com>,
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
	John Hubbard <jhubbard@nvidia.com>, Zhi Wang <zhiw@nvidia.com>
Subject: Re: [PATCH 7/8] rust: pci: add physfn(), to return PF device for VF
 device
Message-ID: <20251122161615.GN233636@ziepe.ca>
References: <20251119-rust-pci-sriov-v1-0-883a94599a97@redhat.com>
 <20251119-rust-pci-sriov-v1-7-883a94599a97@redhat.com>
 <20251121232642.GG233636@ziepe.ca>
 <DEF5EC79OOT4.2MT1ET4IKXS5Y@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DEF5EC79OOT4.2MT1ET4IKXS5Y@kernel.org>

On Sat, Nov 22, 2025 at 11:23:16PM +1300, Danilo Krummrich wrote:
> So far I haven't heard a convincing reason for not providing this guarantee. The
> only reason not to guarantee this I have heard is that some PF drivers only
> enable SR-IOV and hence could be unloaded afterwards. However, I think there is
> no strong reason to do so.

I know some people have work flows around this. I think they are
wrong. When we "fixed" mlx5 a while back there was some pushback and
some weird things did stop working.

So while I support this goal, I don't know if enough people will
agree..

> With this, the above code will be correct and a driver can use the generic
> infrastructure to:
> 
>   1) Call pci::Device<Bound>::physfn() returning a Result<pci::Device<Bound>>
>   2) Grab the driver's device private data from the returned Device<Bound>
> 
> Note that 2) (i.e. accessing the driver's device private data with
> Device::drvdata() [1]) ensures that the device is actually bound (drvdata() is
> only implemented for Device<Bound>) and that the returned type actually matches
> the type of the object that has been stored.

This is what the core helper does, with the twist that it "validates"
the PF driver is working right by checking its driver binding..

> I suggest to have a look at [2] for an example with how this turns out with the
> auxiliary bus [2][3], since in the end it's the same problem, i.e. an auxiliary
> driver calling into its parent, except that the auxiliary bus already guarantees
> that the parent is bound when the child is bound.

Aux bus is a little different because it should be used in a way where
there are stronger guarantees about what the parent is. Ie the aux bus
names should be unique and limited to the type of parent.

> So, if we'd provide a Rust accessor for the PF's device driver data, we'd
> implement it like above, because Device::drvdata() is already safe. If we want
> pci::Device::pf_drvdata() to be safe, we'd otherwise need to do all the checks
> Device::drvdata() already does again before we call into
> pci_iov_get_pf_drvdata().

I think to make progress along this line you need to still somehow
validate that the PF driver is working right, either by checking that
the driver is bound to a rust driver somehow or using the same
approach as the core helper.

I'm not sure the idea to force all drivers to do disable sriov is
going to be easy, and I'd rather see rust bindings progress without
opening such a topic..

Jason

