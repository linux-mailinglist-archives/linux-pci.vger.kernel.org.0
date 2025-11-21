Return-Path: <linux-pci+bounces-41897-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B27DC7BF09
	for <lists+linux-pci@lfdr.de>; Sat, 22 Nov 2025 00:26:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 460763592C9
	for <lists+linux-pci@lfdr.de>; Fri, 21 Nov 2025 23:26:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D747B30FF31;
	Fri, 21 Nov 2025 23:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="eEdF+tth"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12B6430C34A
	for <linux-pci@vger.kernel.org>; Fri, 21 Nov 2025 23:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763767612; cv=none; b=NQuejZBEOay8KdGqY2YZQ2D5ErunPw2hqzQUNCzIqJ08yYa2xieeA8FM1LIXsKQ6z31a85ay9gMpzCtomt95tYE9byqQv0mZqKnLFrhkGHMbVYarD+KiMqPOhIbJ6h8baYUmaJSi08cwWQhxfYEXIoNAnEwxr/hdHMrRxVxKEO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763767612; c=relaxed/simple;
	bh=dkzSuWHp15c23lNS7aZJijZKSIKGzqZHYrTdBoTsqTU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X3U234OxPgSFgG2ZfUbZWXoEDt6iPYLYF8K0MIzgFKLXanovSXdTUWR85c1o25IEl8wes3R7bStkwpQjrloZrDg/I7zrfRia+nsMUUuDu+/5AJWucVESCjagpbmBGYLq5obEPvxvTHK3XeSc1o1ZwKKS4b+BuEicq5StRJRujuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=eEdF+tth; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4ee0084fd98so20750401cf.3
        for <linux-pci@vger.kernel.org>; Fri, 21 Nov 2025 15:26:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1763767604; x=1764372404; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MNnBy71IqEFL4I7Cf2sjCK+m56XgwY3bFvivIuJmmCs=;
        b=eEdF+tth7aIGG0IwToEIlqmY4mmOiTfCRlcbGXFAat35pVaQl4DI1ss+OiLeP1Ks7Q
         MALmb6b3ndvXm3eU/UbJYaWwVuSCwsah1zPXsoYrBMMuUSf9+d5PCw8awQVAZq4o/PNX
         SYrqudaRFgoWpa8p99M95Hpren9rHkVF3VvYsqtkcbyqSY4EOK5LiSisSVkSxX8P3OEI
         9eABOkEdPlC+27YTPQS4Zb+OLMp8vDLF3M6FkpboohkssxGrmuc9R6XfC7TtQh2PwVdB
         FIbzCSejZ+GNiCqPsWJ0nxdSyVuB6KAZu7n1aHFvnsXb3Y41ydymVepESLYk6rNeNJVG
         FM8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763767604; x=1764372404;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MNnBy71IqEFL4I7Cf2sjCK+m56XgwY3bFvivIuJmmCs=;
        b=KD21pTvqYpQ1D0IOyNNTcumet6xcmx0SarF96q/iTuvw5WPGeTwmk0/Hw/pAUdc67V
         Q8iKHUUEtupG8V15P1vradXqLGO/R1kMIhb8ypLO5Yty6fGjOVGXlf6qpZ/CW3eItU83
         jJ4XJKQJg9V0Zo6OLQbKWAaHhBsJwHAeZkblu5FyOjawZNfWU30eZUqYOcYHqiSScxWU
         QjqimpxTuubYJ7/xtsg+fhSHqtah6b+fhVxOMEUhYH2Xe8K4eQ2T5QFIuY1xSgy6v2Py
         q+O7IzgjVBtuClxO+BFTqWCKEe3dpte8PawJcCxDwLgp9qheN8Z3JSnHZMTbmLo+PKmu
         bEpA==
X-Forwarded-Encrypted: i=1; AJvYcCVmkxYS3oQb9/Vr/zOf/xgR3RVcQj2/pwepI0ZmPhqQbwRuvb67s+QclJ4cmdqICNB7dNziVBi30zI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKTV/E97cGLpnq0n1sY8BHWfwolbKcz2+ptyOcgALJIczel7IF
	IxkIRmiKAeLYsZbOCxXHU4XmYbscb6/pfP9CytMjegj4V5TcSQqxO52J0OuqtLob/U0=
X-Gm-Gg: ASbGncsSJyrdRbSMcj+ag4TyD92rqLAzT8tR/Yf86U3iDwx9tEbQ0PrqAY9mvQybLuz
	LwnICUFJJyxObx6QSWJipAwKFv2W0zP+r4NnH/0yolP64O+gBW1qNDwARajWVEpgUkhIOw7OreA
	zEQorKJxlddo9RmFn8FCm0svip8pSR9TH59EOVX7oQ1BvzTzWgbhGRUC3yaTu2pBPGzjLNVl1R+
	dX4lOJcuw67tbxpy8PiSaa+kJF5swtAMZaLePdzlv8vVn12iYZMLqlaYDDUtbSNf8bjrulY21uh
	cVG+ySrwJM9wMZpRSJlpfb66jzE9jwoHUAc8FCeOGBvsZIuxWwJf4j90ZXXH0474U09Ek/KyFuR
	uEpDmOvILzCV0OZB7VBF/Outkbyq+ugw/Gqm1O6fmnRMcmM+k/9i972yxPD+/K2M+tS7/roth3x
	hd/42qL6q963dJftlIVxCN3hWG1SW1Tm/YOtw3+RWzw3Kpku6JOq9H10vC
X-Google-Smtp-Source: AGHT+IFjEleDYxww7zzdvBQdwe8PidrLr18zan1i0bYdCXFl2tvvNG6hLd40H4FO0sVjJlEv/KopjA==
X-Received: by 2002:ac8:7fce:0:b0:4ee:62e:c1eb with SMTP id d75a77b69052e-4ee58aaa08amr51321841cf.26.1763767604320;
        Fri, 21 Nov 2025 15:26:44 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4ee48e69dfbsm43448061cf.24.2025.11.21.15.26.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 15:26:43 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vMaWY-00000001bZ4-0ogb;
	Fri, 21 Nov 2025 19:26:42 -0400
Date: Fri, 21 Nov 2025 19:26:42 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Peter Colberg <pcolberg@redhat.com>
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
	John Hubbard <jhubbard@nvidia.com>, Zhi Wang <zhiw@nvidia.com>
Subject: Re: [PATCH 7/8] rust: pci: add physfn(), to return PF device for VF
 device
Message-ID: <20251121232642.GG233636@ziepe.ca>
References: <20251119-rust-pci-sriov-v1-0-883a94599a97@redhat.com>
 <20251119-rust-pci-sriov-v1-7-883a94599a97@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251119-rust-pci-sriov-v1-7-883a94599a97@redhat.com>

On Wed, Nov 19, 2025 at 05:19:11PM -0500, Peter Colberg wrote:
> Add a method to return the Physical Function (PF) device for a Virtual
> Function (VF) device in the bound device context.
> 
> Unlike for a PCI driver written in C, guarantee that when a VF device is
> bound to a driver, the underlying PF device is bound to a driver, too.

You can't do this as an absolutely statement from rust code alone,
this statement is confused.

> When a device with enabled VFs is unbound from a driver, invoke the
> sriov_configure() callback to disable SR-IOV before the unbind()
> callback. To ensure the guarantee is upheld, call disable_sriov()
> to remove all VF devices if the driver has not done so already.

This doesn't seem like it should be in this patch.

Good drivers using the PCI APIs should be calling pci_disable_sriov()
during their unbind. 

The prior patch #3 should not have added "safe" bindings for
enable_sriov that allow this lifetime rule to be violated.

> +    #[cfg(CONFIG_PCI_IOV)]
> +    pub fn physfn(&self) -> Result<&Device<device::Bound>> {
> +        if !self.is_virtfn() {
> +            return Err(EINVAL);
> +        }
> +        // SAFETY:
> +        // `self.as_raw` returns a valid pointer to a `struct pci_dev`.
> +        //
> +        // `physfn` is a valid pointer to a `struct pci_dev` since self.is_virtfn() is `true`.
> +        //
> +        // `physfn` may be cast to a `Device<device::Bound>` since `pci::Driver::remove()` calls
> +        // `disable_sriov()` to remove all VF devices, which guarantees that the underlying
> +        // PF device is always bound to a driver when the VF device is bound to a driver.

Wrong safety statement. There are drivers that don't call
disable_sriov(). You need to also check that the driver attached to
the PF is actually working properly.

I do not like to see this attempt to open code the tricky login of
pci_iov_get_pf_drvdata() in rust without understanding the issues :(

Jason

