Return-Path: <linux-pci+bounces-43980-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B106CF23B6
	for <lists+linux-pci@lfdr.de>; Mon, 05 Jan 2026 08:36:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 407893009964
	for <lists+linux-pci@lfdr.de>; Mon,  5 Jan 2026 07:36:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FE801D0DEE;
	Mon,  5 Jan 2026 07:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HHct82e0"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A783D12B143
	for <linux-pci@vger.kernel.org>; Mon,  5 Jan 2026 07:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767598565; cv=none; b=uxyzlfER0B8TI98PNA9N2pFC0RjbXRIB7S9BRfSjHx/OMHa/8gwbHz8On8I0c1EpRiQhcyoghLASEXWjlzLBVVKsStpEX9GUTAhLL5Fzk0adNbFgS5dYxLXzr1TZAqPZeW8nZ2rzzDod1cDDpAeOWJAo2zn8McdNACJpe9j6huc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767598565; c=relaxed/simple;
	bh=RXXt8awwSFKvIYuULPDTP5ly+vfpPmoW/YiHxyCGXU8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZOgdSYrTBlODZjISMgij7ngonK3tGLEMNv5vrLB4oZR56RuzZSXBZtNjrwj/7aouAKR9yicZBNaOCcK+O+MQstT8JQW1M6HHO8h3YgzBqV2ppybBlWPKDTDjScuY37389oIV5pvMnErGQMfwTXanMCVCjC0W3cqt1+rxgQQQVDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HHct82e0; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4ed861eb98cso165951311cf.3
        for <linux-pci@vger.kernel.org>; Sun, 04 Jan 2026 23:36:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767598562; x=1768203362; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Or/cXZmh9MtTld9m1B9ORzue6F9gk9B51XzjBDT3vHo=;
        b=HHct82e0NijqXOMDkMOOz0iH0Q9x/4I117lP6vxzMx9iRm6MPPHboN3mlpCujmxyZL
         +ExSH5e/kzQDPbcwW3yJNwIbWDAwhhdf20E6rHUPHoFjAZAi2XvMyjIzyQyQmNqzgI3w
         nv/MuSlV7ijBhD6Zx0kIu3wyDn61/5dcKyVIWthBIkNNEijW0DmfLgIl5EntHGY3DNU0
         E04WVRLYKiNSW4UyPkDL4rbdola8ak5Rky4AYJMVwoeeVI1HjYG4r9U+kFCzVhqxMMCa
         8xcjKy76imGLrOVv+CJGGmE+9869W4CyN9H2r2UQmzzhbq6kqs53KSZ+Lhmv0LIxaF4w
         J9Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767598562; x=1768203362;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Or/cXZmh9MtTld9m1B9ORzue6F9gk9B51XzjBDT3vHo=;
        b=AD8s/xicytgkISQuWAMk5aYxvibauV0h9wQKDlsR4mc1H+y6Qb+rAeR3QROYEejZrp
         A4bPs7AWLCHVSdS5gxRDZKVAG4uWDt0H4zSAoiPDEBOn2haBxAMeDbsEdjjcyhmEKu5G
         XiQ+Ep4se6wosiclLZxCsNjQDQEgkAm6u3/sOd7xPCM9TRdQlGtsUUsaUTULYOZ6ZHyi
         bumaGM0J/NmoFBLwrVHm+9cEp/nrSznbvnqIwQl7C0A9NMBha1Mks1TTCFncuwPz9DeV
         PVe2eRsOnd8cYbD9jBHnh9/luhnWq9aoEjitXLKNYS2UwtCYJvM/Ph9O4KVdfSzizcvW
         HRCw==
X-Forwarded-Encrypted: i=1; AJvYcCWrZDKw/8TvD6rOwgOVl+Ehi1lhxzO+8U489N3IIcy3iUmfdptDfMp8ZUAC8choQv4ILJ3auuqBTXY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIL79/xAm6Qt49eVlrOS0NbZzLzN/DVEaCQco3bVm7kdQS4e+L
	Wurez0NnEW6w06ciasF1NYNzwa2iJ1S0upjMD+KbLoQ8vB1N0s0/XDE4hRd8Iajb
X-Gm-Gg: AY/fxX4f+D1NrHH1X7KI1P1MPzl/VerdwT72hgO2R2Maij9S6i16mD6D4fU5TCaK8IF
	BGh9dszeMd0H12C38EPAPGgpNuPBo0569gb00L3AtCuhbNpS5Sstm5pHtX9aznPCoMCUUODwYPD
	WE45CLLADcLkapZJr2YlSiT2hJ6hP/Y9ZpxB1cGN4lzHpIfNyK/UoW/RxAqIlHFgK+J0L1CKYqT
	HLLssii2jmTW5nCC9rX3hRI+leIKe44sgiW8yBTDFNF++Gk7RAT+DAKE2zOaNJpXKat7aWMQrZY
	cKT7ww4nfA7QSB81imd7V1JODvCRkZVcIRKqwP6rXuBbCakTDVj6UCsmNXNNPP+HLa3yAX/doLM
	+5IvLr+otGDzVXZjElQGM321VgCFzsaj2ILphqDbDr3R4Jr/xcIGU2gduU5vEJWNvKhMeS+WkFN
	5YEFbfqMBGpvRf/Gz2G/5fF4b2cIyYWAc5Yj9/abUTSwlWfY2c0LIrolc2hRdMi+Fw5FrIEsXD3
	Gyp+URojbjdZRs=
X-Google-Smtp-Source: AGHT+IH63V4Hl1SMFCag9vqcyDXRo5X2DiiJ481/ikMEIRWKKkSDpXpdiCe7BpbB3ci2m1RmWSd1eQ==
X-Received: by 2002:a05:620a:1a0c:b0:8b1:d2f7:9586 with SMTP id af79cd13be357-8c08fd041c2mr7415266985a.64.1767593341154;
        Sun, 04 Jan 2026 22:09:01 -0800 (PST)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c0970f5fe5sm3707510885a.26.2026.01.04.22.09.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Jan 2026 22:09:00 -0800 (PST)
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfauth.phl.internal (Postfix) with ESMTP id 06A14F40068;
	Mon,  5 Jan 2026 01:09:00 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Mon, 05 Jan 2026 01:09:00 -0500
X-ME-Sender: <xms:e1VbaZwzYlsCzXtNRr5nSpB7CQ5boRjumQFQQQrsFUIsXXPyeOe-Kw>
    <xme:e1VbaeL4z3uiJfcBBuxEu-GeRzBQEp-z7YxtC01T5GuI_AqF6RjK8ZtzQKJlVVVFX
    DyVRMlWYRA0xmDkVumHojWnQb34NjPAMOvWoCK3T0Scz4MSkn0UqEk>
X-ME-Received: <xmr:e1Vbab5MzDCJuzEFwr9pKg-h0MFJmveUXP74ztkxaR6WPprxpIEF4Gmo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdelieehgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhnucfh
    vghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrthhtvg
    hrnhephfetvdfgtdeukedvkeeiteeiteejieehvdetheduudejvdektdekfeegvddvhedt
    necuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghr
    shhonhgrlhhithihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvg
    hngheppehgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvgdpnhgspghrtghpthhtohep
    vddtpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegurghkrheskhgvrhhnvghlrd
    horhhgpdhrtghpthhtohepsghhvghlghgrrghssehgohhoghhlvgdrtghomhdprhgtphht
    thhopehojhgvuggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehgrghrhiesghgrrh
    ihghhuohdrnhgvthdprhgtphhtthhopegsjhhorhhnfegpghhhsehprhhothhonhhmrghi
    lhdrtghomhdprhgtphhtthhopehlohhsshhinheskhgvrhhnvghlrdhorhhgpdhrtghpth
    htoheprgdrhhhinhgusghorhhgsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrlhhi
    tggvrhihhhhlsehgohhoghhlvgdrtghomhdprhgtphhtthhopehtmhhgrhhoshhssehumh
    hitghhrdgvughu
X-ME-Proxy: <xmx:e1VbacyvGrPjpYGdYkEyk2jrAEGwxbBj1JZOCKJT6tmM0xqxdsK0JQ>
    <xmx:e1Vbad8Icj3Uuk5frwROWI1x-Y0mPUhGAlQiTo3Gu36QmjoiL7KMRw>
    <xmx:e1VbaQELjYCBxqt_wfKZOf5uleDsZEdI50RaOwQYhAt3dD-mVcj3sA>
    <xmx:e1VbaXBOSPKWL0hD92chaUqOZcZwW81KfuYUrgLUQrGoxobTq3bi-A>
    <xmx:fFVbaUmc3U78m7SdT1pqM6EjnBZ5Ghc6BgI5DeUr4VGZDlviuN1L_x8v>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 5 Jan 2026 01:08:59 -0500 (EST)
Date: Mon, 5 Jan 2026 14:08:57 +0800
From: Boqun Feng <boqun.feng@gmail.com>
To: Danilo Krummrich <dakr@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Miguel Ojeda <ojeda@kernel.org>
Cc: Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Joel Fernandes <joelagnelf@nvidia.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	Dirk Behme <dirk.behme@gmail.com>,
	FUJITA Tomonori <fujita.tomonori@gmail.com>,
	kernel test robot <lkp@intel.com>, Liang Jie <liangjie@lixiang.com>,
	Drew Fustini <fustini@kernel.org>, David Gow <davidgow@google.com>
Subject: Re: [PATCH v2] PCI: Provide pci_free_irq_vectors() for CONFIG_PCI=n
Message-ID: <aVtVed-vN1ESHHHK@tardis-2.local>
References: <20251226113938.52145-1-boqun.feng@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251226113938.52145-1-boqun.feng@gmail.com>

On Fri, Dec 26, 2025 at 07:39:38PM +0800, Boqun Feng wrote:
> Commit 473b9f331718 ("rust: pci: fix build failure when CONFIG_PCI_MSI
> is disabled") fixed a build error by providing rust helpers when
> CONFIG_PCI_MSI=n. However the rust helpers rely on the
> pci_alloc_irq_vectors() function is defined, which is not true when
> CONFIG_PCI=n. There are multiple ways to fix this, e.g. a possible fix
> could be just remove the calling of pci_alloc_irq_vectors() since it's
> empty when CONFIG_PCI_MSI=n anyway. However, since PCI irq APIs, such as
> pci_alloc_irq_vectors(), are already defined even when CONFIG_PCI=n, the
> more reasonable fix is to define pci_alloc_irq_vectors() when
> CONFIG_PCI=n and this aligns with the situations of other primitives as
> well.
> 

Ping ;-) Bjorn, would it be possible to take via pci tree? Thanks!

Regards,
Boqun

> Reported-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
> Closes: https://lore.kernel.org/rust-for-linux/20251209014312.575940-1-fujita.tomonori@gmail.com/
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202512220740.4Kexm4dW-lkp@intel.com/
> Reported-by: Liang Jie <liangjie@lixiang.com>
> Closes: https://lore.kernel.org/rust-for-linux/20251222034415.1384223-1-buaajxlj@163.com/
> Fixes: 473b9f331718 ("rust: pci: fix build failure when CONFIG_PCI_MSI is disabled")
> Reviewed-by: Drew Fustini <fustini@kernel.org>
> Reviewed-by: David Gow <davidgow@google.com>
> Reviewed-by: Joel Fernandes <joelagnelf@nvidia.com>
> Reviewed-by: Danilo Krummrich <dakr@kernel.org>
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> ---
> v1 --> v2:
> 
> * Add Reported-by from FUJITA Tomonori, kernel test robot and Liang Jie.
> * Add Reviewed-by tags.
> 
> Thanks!
> 
> Liang Jie, I added you as Reported-by because of [1], if you prefer not
> to have that tag, feel free to let me know, thanks!
> 
> [1]: https://lore.kernel.org/rust-for-linux/20251222034415.1384223-1-buaajxlj@163.com/
> 
>  include/linux/pci.h | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 864775651c6f..b5cc0c2b9906 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -2210,6 +2210,10 @@ pci_alloc_irq_vectors(struct pci_dev *dev, unsigned int min_vecs,
>  {
>  	return -ENOSPC;
>  }
> +
> +static inline void pci_free_irq_vectors(struct pci_dev *dev)
> +{
> +}
>  #endif /* CONFIG_PCI */
>  
>  /* Include architecture-dependent settings and functions */
> -- 
> 2.51.0
> 

