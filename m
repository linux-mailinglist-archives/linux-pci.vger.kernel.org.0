Return-Path: <linux-pci+bounces-38784-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B45E7BF29C0
	for <lists+linux-pci@lfdr.de>; Mon, 20 Oct 2025 19:08:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B2FE1893DCE
	for <lists+linux-pci@lfdr.de>; Mon, 20 Oct 2025 17:08:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D22E731329A;
	Mon, 20 Oct 2025 17:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QCTzRP/P"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 547DD330D23
	for <linux-pci@vger.kernel.org>; Mon, 20 Oct 2025 17:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760980092; cv=none; b=ZmXhQKZw7Ay4NKbbcJAcDWKRtixe8hYtzt8awr2HOvY54AdOG8UlSHsO25MuI24Nc5ejX8H05iJACME3RTPQNW/MGST2+YOrD1CYYHTLetn9UhjVzP/5VxTahZUvH49F0wC7WYMlVRO880+tlY1m+Z7FnsNvrw7leiAIMJ8S3Xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760980092; c=relaxed/simple;
	bh=++JBAp2xm1Bl/YkWLfXigpQePNZ412++Qg25OLfZJHE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FwF5uVgTBeS60QU9DOzbZnMixOXansCrNXLFP4PYc4ghW4u4wgH6R2W5/uRzJWyMr8Nwm1yeLj98SyW8qAS2/C9c7rmK6qdpy7imFWB0JAdikdr8NrNi1qZB6BAmitQoXFBdqyxYCnbrVT8PgsGRbn+RBrFOabUq1tOn2OVJXo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QCTzRP/P; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760980090;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pux7rQuDYhVQLMQRoejdWlthCyHXYYQvPav2QQo4Hto=;
	b=QCTzRP/PZO5cExc6xTYcFMUCFfhi34DkfmItFm6FvkOg1L0lyx3cFqc6PHw3HdVIwIUoWL
	68Pbc7voD38wAP/MBJEGWVdeqSxoxpMOc5fDI9aejLXA9gtf7luT78f+l13gEUNMOS+zKT
	hcfEormdqVZQQjtLjDZ1ckSeyeZIgsM=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-263-NyojBR1jN5eYKBo267_wIA-1; Mon, 20 Oct 2025 13:08:08 -0400
X-MC-Unique: NyojBR1jN5eYKBo267_wIA-1
X-Mimecast-MFC-AGG-ID: NyojBR1jN5eYKBo267_wIA_1760980088
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-818bf399f8aso232433016d6.2
        for <linux-pci@vger.kernel.org>; Mon, 20 Oct 2025 10:08:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760980088; x=1761584888;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pux7rQuDYhVQLMQRoejdWlthCyHXYYQvPav2QQo4Hto=;
        b=aqzfjmWbRaKaqLKpGGeSN2X2jpdmw+fw5Am/E1f8nYykZB4lkMm0vOzM9k0WpYvGzf
         CPO06BX6L5iYVBMM8LkBCcDpHbuFpelvgnuwpjTul5pv9PON52CVX4/kX7wT98AXDn2s
         iggmhogBLkVH0ZoyBiuReCYWsac7NdqTL+TN1/ZhMYaeBQNb23142mIZix1KG0fFa0zp
         2JheSFse3Z2u9wXjFujG4rdbSQvAVGUvEiCUsvrqQqCDgofqMq6rEpo+k6JoEwoqX3sU
         LwGbnCMbDt1FI+wHRDBXfl2hZgYyQfF+OZ8Va9lPaFqHyX0XP3PdSaJEhrOvzKGFz0va
         PU0Q==
X-Forwarded-Encrypted: i=1; AJvYcCWakcJPj1uNhGEa0rl7z2HWubbVgBRa8aDqbyBQ5EfxTaV01XQMfBU3Kr+42LsliKyNGTFpB3eyOz0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjjXYM2zFTmPqeQ7bvVSwtMZDlo3abF21fqecyQ3EqWnh9xcqr
	V0Ij7DyEyf7T1O+qDo5NZi0Mw7wlh1orXg4NOy2881CvytPeHqImXI/xE0QjPdMP94hU7HYjpyM
	xLVbTPzo/Fueh/rbrOgW+4AlwBRNK1a8Cwv9+vdubWpNoT3dqd6YYckDmaM1krQ==
X-Gm-Gg: ASbGncuctxuoj+NpTY9UuDhQamP0zmOMmbZenSYFQnm3Oueyf7+QOnuppfhJm/G0BvH
	f0N4/B0TCISjXbncqG7KteQCfnnDBV9e1lYzVnx3hMrSlJEd2hfZo/T3V9Z/JITmAyVmMGj7xke
	GTfE/MZKqCrgBvn6mBo+VKUYfSlz8N450Ns3YcEDnbFAiHfNtM6ubNIjDhaaoYo02ucqvjTsqD2
	uptgL1E+8Q3gJm9n57Z/KqkE+PV20S5ewykd3RIHE42sWQGe62up0COFibr7BWxIdGmWPUSx6Sr
	2QRDrHXNQry9l0/vghjocFRw0p1Fan6lHBUif0mKg98PV0rZFMA0/LP7SinEtVNTP5eDoo1cQK4
	=
X-Received: by 2002:a05:6214:629:b0:7ee:aaf0:b759 with SMTP id 6a1803df08f44-87c20545ce6mr186916606d6.7.1760980088278;
        Mon, 20 Oct 2025 10:08:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE2dJ1otsnjO4gPqjD5cms9cnStOkEvPQXBCTaBj9kaoCae+He0cJx4lWam6Mw/3/Lz8ib0iw==
X-Received: by 2002:a05:6214:629:b0:7ee:aaf0:b759 with SMTP id 6a1803df08f44-87c20545ce6mr186916106d6.7.1760980087735;
        Mon, 20 Oct 2025 10:08:07 -0700 (PDT)
Received: from localhost ([2607:f2c0:b0fc:be00:98f9:e204:8ae3:6483])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-87d02d90b05sm54655476d6.63.2025.10.20.10.08.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 10:08:07 -0700 (PDT)
Date: Mon, 20 Oct 2025 13:08:06 -0400
From: Peter Colberg <pcolberg@redhat.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	linux-pci@vger.kernel.org, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] rust: pci: consistently use INTx and PCI BAR in
 comments
Message-ID: <aPZsdplimqnRheb1@earendel>
Mail-Followup-To: Danilo Krummrich <dakr@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	linux-pci@vger.kernel.org, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
References: <20251019045620.2080-1-pcolberg@redhat.com>
 <DDN4FLSD09W9.30I0BJXFAU5YB@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DDN4FLSD09W9.30I0BJXFAU5YB@kernel.org>

On Mon, Oct 20, 2025 at 01:43:16PM +0200, Danilo Krummrich wrote:
> On Sun Oct 19, 2025 at 6:56 AM CEST, Peter Colberg wrote:
> > This patch series normalises the comments of the Rust PCI abstractions
> > to consistently refer to legacy as INTx interrupts and use the spelling
> > PCI BAR, as a way to familiarise myself with the Rust for Linux project.
> 
> That's great to hear! :)
> 
> Can you please rebase the two patches on driver-core-testing [1]?
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/driver-core/driver-core.git/log/?h=driver-core-testing

Thanks Danilo, I have sent a v2 [2] rebased onto your "Rust PCI
housekeeping" patch series in driver-core-testing.

[2] https://lore.kernel.org/rust-for-linux/20251020170223.573769-1-pcolberg@redhat.com/

Peter


