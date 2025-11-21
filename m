Return-Path: <linux-pci+bounces-41898-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2284FC7BF21
	for <lists+linux-pci@lfdr.de>; Sat, 22 Nov 2025 00:28:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CB233A1CB9
	for <lists+linux-pci@lfdr.de>; Fri, 21 Nov 2025 23:28:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BF98311C33;
	Fri, 21 Nov 2025 23:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="I3y4qwRT"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C454A2D3221
	for <linux-pci@vger.kernel.org>; Fri, 21 Nov 2025 23:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763767721; cv=none; b=DWg+12RJNsB0UciIgzd48HvfnBjavvhd2Qvl/9SrEN650hUtvjYufJkhMpRwSf/L+xlFlsd8CpUY0lPlfb8C+jzZSlBsQa/Dud0Sddxj+QzmZ7wo+l1TTzFYHutLTYR02LeSHcPkC6eVVpP6rIcne8UnRtN6Ff+MqEJE6fSwB9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763767721; c=relaxed/simple;
	bh=mauH3JtypClNExnFnUryKjVThxBomgYf7WHHEjpqgb8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IF3YquiGV0NeM1V4HGES2g4XeWcPlRACjmMnvBOmb49P7bu1o9eW2AlUYD6Z8LCrnnq2ULRJ52cgFysAGIQrT1Fj2Suf24y1xjAXQamNKHUoy5BdVU0GImJbmV/2RViL2NgMenQ592THEYSCKpXAmsM1QSg2f9WV/LmR0RWRuBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=I3y4qwRT; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-8b2dcdde698so362806985a.3
        for <linux-pci@vger.kernel.org>; Fri, 21 Nov 2025 15:28:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1763767715; x=1764372515; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mPkLUeocYZ9OHUjt6MdsqZZIbrBB8fliyjymBJQ8m2U=;
        b=I3y4qwRTvUh9rlS5syKtf1HlC+Nyuq3zqu8WG7f8i0y+hrnFDZs6JR0puvf//dG6q9
         ykpB6ZtpGK7RL9alVdrq4fNBPGIA0TVjkAhrCLG8M5hJOZA196ZtCgig4Iu6Uajf1COu
         zr8i79g9rXT2fjYnywpy8uqC9WrnI+SZ9iWr4i6O2jfVbgy4hyvHJPxY0ENrxbVZluhw
         +oynvrAaNiIqKox6J2oyslLtVnYGCS1Q05IfXzAQyzJa63bwv5Smrlh19VHnc8NowrTS
         PTa+rn2vh10uHiPLE9vPIPorxy36tDcvDaKF5F+NSQ18un/j8/RGSFFIK5vHcRLP44aD
         mekQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763767715; x=1764372515;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mPkLUeocYZ9OHUjt6MdsqZZIbrBB8fliyjymBJQ8m2U=;
        b=ZcQ4oBotjdYrUliQwBWdFotgOa4k2RTvQ2jcudPCp+rUIdSpJGerdcUX/KRrFcm55a
         5TSIh+eDHCta3DLXW10WHNPTksrMgITZfp/XJLb8uftCb4DE4cLEm+00baKvFqO+ljav
         Mu9fOPx1C4a93AG6tHpinCZpj/5SElouolH4HDY209oWHPBRie2/RDKePa3cnyvCH2tw
         I2m/8C1Jq3cF7MTMYSuY79xhwMlfkVEHWPHl0jksIypNZCPmmRO8llmUstMU5ZivxLF5
         ODXFvLbfpMf3q0NSKdK3aqB6bduRRIpE5ssZuc4HFGsQU1cE5S1ABgN7jBa+yaLwLZHZ
         UiCA==
X-Forwarded-Encrypted: i=1; AJvYcCUCx7vXMSQm4qZBd9LWxC+QTVcpJWArd9zipqUL2XmX708+9Y+Ue3imavWcSABoEmkcuNqQIxb244g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEv2JnKa3LMzemQyLHYBSN7cMnJD8AiPJtQHgyH3QqfpezA+GV
	8GPHfytjIp3d0hMygAUijApLt5BHyDg92N/J7kIGw3vcARODtUoIRLo4BPTtosmbhOA=
X-Gm-Gg: ASbGnctrJek8xdPtdC74lMfhg9yJbx7AaExIKL66Mol8SixCHUzu5mZOOAwxz3WHRPh
	qF1Vikzby148mUhq/f42rlFIDRH97mNI38nRyYSt72C9zKfq1HvaKo47ijpRN5VzxVLmLsXsCfZ
	c50wDVM5zoT0MHox5uwxa3lyAO29Q3rDSSnPfKVrFyXYPW4qeZhKv4jubRDksXeGM4/tyvWKZwZ
	FSGIfTr1vBZEMEZG6QWqRqu+MlaVkC/+1sH3+jdTsAYI8UBlRX6rKThgGf6PHsAVLnecaE/XcOf
	cM2UMHHvXtt3TbLmT0sFVgFJDPQNHvOLQhKkGjfcyBCDeo2U4An8vatXoFsgQmQRjq0fWktxSL+
	LjAdmThWiYaHpZ/twkB57tZLrJO/RNCOvMpNg8zShKSQLOQ3SZWux/dM4t/TIcgCx7pRuo8JbAb
	eRG5Y9POtWMX+3+cQs1OV2ojv6KFTsWx4RxS2lnmPuakhgvmsHw4v6rZl+
X-Google-Smtp-Source: AGHT+IGLeMtP253GHas4M+LvKhyXDfO6U6IBU1zq+lA7A93sFOfzBPQ38o7t96QuMPLUVNh7bM9LEQ==
X-Received: by 2002:a05:620a:4714:b0:8b2:769b:74cd with SMTP id af79cd13be357-8b33d4846f2mr511750485a.71.1763767714795;
        Fri, 21 Nov 2025 15:28:34 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b3295c1328sm451262285a.27.2025.11.21.15.28.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 15:28:34 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vMaYL-00000001bZj-1HN0;
	Fri, 21 Nov 2025 19:28:33 -0400
Date: Fri, 21 Nov 2025 19:28:33 -0400
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
Subject: Re: [PATCH 3/8] rust: pci: add {enable,disable}_sriov(), to control
 SR-IOV capability
Message-ID: <20251121232833.GH233636@ziepe.ca>
References: <20251119-rust-pci-sriov-v1-0-883a94599a97@redhat.com>
 <20251119-rust-pci-sriov-v1-3-883a94599a97@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251119-rust-pci-sriov-v1-3-883a94599a97@redhat.com>

On Wed, Nov 19, 2025 at 05:19:07PM -0500, Peter Colberg wrote:
> Add methods to enable and disable the Single Root I/O Virtualization
> (SR-IOV) capability for a PCI device. The wrapped C methods take care
> of validating whether the device is a Physical Function (PF), whether
> SR-IOV is currently disabled (or enabled), and whether the number of
> requested VFs does not exceed the total number of supported VFs.
> 
> Suggested-by: Danilo Krummrich <dakr@kernel.org>
> Signed-off-by: Peter Colberg <pcolberg@redhat.com>
> ---
>  rust/kernel/pci.rs | 30 ++++++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
> 
> diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
> index 814990d386708fe2ac652ccaa674c10a6cf390cb..556a01ed9bc3b1300a3340a3d2383e08ceacbfe5 100644
> --- a/rust/kernel/pci.rs
> +++ b/rust/kernel/pci.rs
> @@ -454,6 +454,36 @@ pub fn set_master(&self) {
>          // SAFETY: `self.as_raw` is guaranteed to be a pointer to a valid `struct pci_dev`.
>          unsafe { bindings::pci_set_master(self.as_raw()) };
>      }
> +
> +    /// Enable the Single Root I/O Virtualization (SR-IOV) capability for this device,
> +    /// where `nr_virtfn` is number of Virtual Functions (VF) to enable.
> +    #[cfg(CONFIG_PCI_IOV)]
> +    pub fn enable_sriov(&self, nr_virtfn: i32) -> Result {
> +        // SAFETY:
> +        // `self.as_raw` returns a valid pointer to a `struct pci_dev`.
> +        //
> +        // `pci_enable_sriov()` checks that the enable operation is valid:
> +        // - the device is a Physical Function (PF),
> +        // - SR-IOV is currently disabled, and
> +        // - `nr_virtfn` does not exceed the total number of supported VFs.
> +        let ret = unsafe { bindings::pci_enable_sriov(self.as_raw(), nr_virtfn) };
> +        if ret != 0 {
> +            return Err(crate::error::Error::from_errno(ret));
> +        }
> +        Ok(())
> +    }
> +
> +    /// Disable the Single Root I/O Virtualization (SR-IOV) capability for this device.
> +    #[cfg(CONFIG_PCI_IOV)]
> +    pub fn disable_sriov(&self) {
> +        // SAFETY:
> +        // `self.as_raw` returns a valid pointer to a `struct pci_dev`.
> +        //
> +        // `pci_disable_sriov()` checks that the disable operation is valid:
> +        // - the device is a Physical Function (PF), and
> +        // - SR-IOV is currently enabled.
> +        unsafe { bindings::pci_disable_sriov(self.as_raw()) };
> +    }

Both these functions should only be called on bound devices - the
safety statement should call it out, does the code require it?

Also per my other email SRIOV should be disabled before a driver can
be unbound, this patch should take care of it to not introduce an
dangerous enable_sriov().

Jason

