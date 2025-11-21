Return-Path: <linux-pci+bounces-41893-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E5A34C7B536
	for <lists+linux-pci@lfdr.de>; Fri, 21 Nov 2025 19:28:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6AF7A35D8EC
	for <lists+linux-pci@lfdr.de>; Fri, 21 Nov 2025 18:28:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5699721E082;
	Fri, 21 Nov 2025 18:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ixfW7LEH";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Rj+AptQP"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A87BC185B48
	for <linux-pci@vger.kernel.org>; Fri, 21 Nov 2025 18:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763749682; cv=none; b=AT+3WSq3lmiVB61Th932kzG9QalysQbvRY+D7ircmu1WY9zFFzkfxVGak9CrZUD5E4VBXrQL2Zb6D9RrpWvTvKBLv5p/q6IrfwJxtDVGrvzlE9LT/jk6td006ClINYXBtbzi0tDT7ULVKRVAM/mbEaYpq7orp2uV7xZEAjcrrJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763749682; c=relaxed/simple;
	bh=eiNvpKMX+RHgtZkQ1+h3XWmFyZEgmHdrngHRg+aKUCk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VBPfKbsMBhPSesdlCi2IfUkdH+/XYMJFxQKPBhwiJzTYnnpy19VQOX41P1G1pYLhTOy7ZFmrluEhYN6bsibwRVhQQQSXyCci3ZEPXOxBZxUrp+CtYGR8GFCD66UlNo34H5LmbSTzxlfAXyunB2olu2zXg0NiZ1zfg6ZgqBRp0VE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ixfW7LEH; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Rj+AptQP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763749679;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9F1gVEfkmOU4VbBNqbz6au89HcS75XiMRWvgttvUABM=;
	b=ixfW7LEHmaOV+ePy7IbM2owLZ4KC0mVFbjZ1dgS6FTFZaJYPrTjM0cEQf+CxzaGXmKNQaH
	AkiWGKzNmTZmxCi4+qX+FxUHTynRykr2AfaBeOnosshZfDBhM7LuavtHIxcIaOaQJVmXCz
	52Pqme4i3TJvkcSkomNATQXcNKs0hds=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-306-d6f0Kv3kMaeJHkExSXTLLA-1; Fri, 21 Nov 2025 13:27:58 -0500
X-MC-Unique: d6f0Kv3kMaeJHkExSXTLLA-1
X-Mimecast-MFC-AGG-ID: d6f0Kv3kMaeJHkExSXTLLA_1763749678
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4ee42d99125so64401591cf.3
        for <linux-pci@vger.kernel.org>; Fri, 21 Nov 2025 10:27:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1763749678; x=1764354478; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9F1gVEfkmOU4VbBNqbz6au89HcS75XiMRWvgttvUABM=;
        b=Rj+AptQP1Kek8Lnm2EqEULRXP8sHAjjuPn5WmdYwlsxqhMon8zfSbQIMqZxx9zkF92
         nppHz+XVw2OOro+eonbt2GI/pWx8Wi87PLE2Xe/OKv/Nm/lbF5xA9B0me3nOFi+IdLXt
         6282bABEOEJ6IRNgffMVPJW+eyqvuAM+WS3GkRGq9E18682rLhX5KorPxhGvwnnYYP/l
         QRvr6fWVcthAHBAzeaN333wOVtdxI+1sc7uuOUIbzAOA9EsANZcKfz77D5Fa70YYCZlr
         QTbbZOMKAVg28q3M4h12JM+tIA8l3uL8rlC2muLOgq8tuUykUDLh4mOMdadH6++UysrZ
         k1Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763749678; x=1764354478;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9F1gVEfkmOU4VbBNqbz6au89HcS75XiMRWvgttvUABM=;
        b=ARL/fdNjD93WKQSSEZJOYorwX1vso06N3QzWbIhZo2CL9xYRN045+Rq5UKQJyH82vc
         DfZq7o59GgUNOH8AwCb4PI1TLkKFGE8l56/QWcFoPkrbeQwY/BEHTsGHC/GYxbfFVRYF
         cvCPiE6Is8YGgXBpBb8S91As694GF9HoUmT9xQkz8xjD7rtumaN3VcPMce9a2jKa9RAH
         E9jj8SkA5vEkJt/lEn5hDTwaZnUeqUsvTUO49iECS1HaSDvY2vM/kwJ0EVn21UdKcZD1
         MBhkaFHSl3WLDx8jC3Bn3EMudvoG4tHqt+O8z+/yf9is3GwXXr2gPvEd3Vn+DnheK7ky
         xbAg==
X-Forwarded-Encrypted: i=1; AJvYcCX9QfqSq4hub1RWsMQojzXc1iQJRksD5jAWiTuVhLZcuCpcynptUDUxD1mf5BVp+kNnpeYoaERr+0U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNygDaEo20gqeUmNRE+cbkTqB9Np1VYlINFHUMN5FO1dQcSUuR
	+Ak8T6DidzNBz6RLr+/daddl4aT3YU6XTgiTF8lanmT/5LUFZvWEeQANQb1metEybXuDdVyGeXn
	TB+AFVXn8LRyoU4JkpGXIYyVLap4HyEtf7robvl9aJiqp3G51pM+27Qh88hh4oQ==
X-Gm-Gg: ASbGncsLJacQh3bSokoKOWrwanZrQU+NFj59/gS5kLi72HK8pt2Q6cjFMMF8P9STzc7
	I16C+21EUMit5PWc2gq+5dlB+KL7PS8Tpp9wJDxQW93xwzpx0ztWLjkzu6Cr79mc3RA4hcenCqI
	395OIDEP53Ln9q7WhbwkqOTG5VVVGvt4ysUbUJlF66GNtWqHqRTG2MJ2dGG2dWF2DGzGYpOvwnC
	d+yyVqPUD7kMXE/YE03+GtSSreYh5THPFF0Zh5VbCyoVJYl7q1K4D9Xe7FaXkrFDYzxC6B/WDEB
	v0jn2/Ykn1zjXmcP/vq1h1UcYV8ahmUgZ5c4KCkLROnU+Ogox1JFqgFrHTePJWmyPWtieF5gJkn
	wnvRWX3LLsg==
X-Received: by 2002:a05:622a:155:b0:4ed:da56:7a96 with SMTP id d75a77b69052e-4ee58af100cmr45387701cf.60.1763749677527;
        Fri, 21 Nov 2025 10:27:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFkOzQWoZuQdAiXMy2SX7/W3kkLRTcNrhy9ckhF61k6Ze2u2Lmzw86pdU9Kf7yewixDrfgpEg==
X-Received: by 2002:a05:622a:155:b0:4ed:da56:7a96 with SMTP id d75a77b69052e-4ee58af100cmr45387001cf.60.1763749676867;
        Fri, 21 Nov 2025 10:27:56 -0800 (PST)
Received: from localhost ([2607:f2c0:b141:ac00:2fb1:d1df:b122:3b2c])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-4ee48d571d0sm41831021cf.12.2025.11.21.10.27.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 10:27:56 -0800 (PST)
Date: Fri, 21 Nov 2025 13:27:55 -0500
From: Peter Colberg <pcolberg@redhat.com>
To: kernel test robot <lkp@intel.com>
Cc: Danilo Krummrich <dakr@kernel.org>, Bjorn Helgaas <helgaas@kernel.org>,
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
	llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-pci@vger.kernel.org, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alexandre Courbot <acourbot@nvidia.com>,
	Alistair Popple <apopple@nvidia.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	John Hubbard <jhubbard@nvidia.com>, Zhi Wang <zhiw@nvidia.com>,
	Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH 1/8] rust: pci: add is_virtfn(), to check for VFs
Message-ID: <aSCvKy64s-LBrM85@earendel>
Mail-Followup-To: kernel test robot <lkp@intel.com>,
	Danilo Krummrich <dakr@kernel.org>,
	Bjorn Helgaas <helgaas@kernel.org>,
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
	llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-pci@vger.kernel.org, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alexandre Courbot <acourbot@nvidia.com>,
	Alistair Popple <apopple@nvidia.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	John Hubbard <jhubbard@nvidia.com>, Zhi Wang <zhiw@nvidia.com>,
	Jason Gunthorpe <jgg@ziepe.ca>
References: <20251119-rust-pci-sriov-v1-1-883a94599a97@redhat.com>
 <202511211008.jgLuTcrQ-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202511211008.jgLuTcrQ-lkp@intel.com>

On Fri, Nov 21, 2025 at 11:00:32AM +0800, kernel test robot wrote:
> Hi Peter,
> 
> kernel test robot noticed the following build errors:

This appears to be a generic issue with UML, unrelated to this series.

https://rust-for-linux.zulipchat.com/#narrow/channel/288089-General/topic/CONFIG_UML.20maybe.20broken.3F/with/558611169

Thanks,
Peter

> 
> [auto build test ERROR on e4addc7cc2dfcc19f1c8c8e47f3834b22cb21559]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Peter-Colberg/rust-pci-add-is_virtfn-to-check-for-VFs/20251120-062302
> base:   e4addc7cc2dfcc19f1c8c8e47f3834b22cb21559
> patch link:    https://lore.kernel.org/r/20251119-rust-pci-sriov-v1-1-883a94599a97%40redhat.com
> patch subject: [PATCH 1/8] rust: pci: add is_virtfn(), to check for VFs
> config: um-randconfig-001-20251121 (https://download.01.org/0day-ci/archive/20251121/202511211008.jgLuTcrQ-lkp@intel.com/config)
> compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project 9e9fe08b16ea2c4d9867fb4974edf2a3776d6ece)
> rustc: rustc 1.88.0 (6b00bc388 2025-06-23)
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251121/202511211008.jgLuTcrQ-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202511211008.jgLuTcrQ-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
> 
> >> error[E0599]: no method named `is_virtfn` found for struct `bindings::pci_dev` in the current scope
>    --> rust/kernel/pci.rs:415:35
>    |
>    415 |         unsafe { (*self.as_raw()).is_virtfn() != 0 }
>    |                                   ^^^^^^^^^ method not found in `pci_dev`
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
> 


