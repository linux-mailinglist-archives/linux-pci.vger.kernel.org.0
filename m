Return-Path: <linux-pci+bounces-31932-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3CD2B01F3B
	for <lists+linux-pci@lfdr.de>; Fri, 11 Jul 2025 16:35:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9513C76688D
	for <lists+linux-pci@lfdr.de>; Fri, 11 Jul 2025 14:34:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F1E9167DB7;
	Fri, 11 Jul 2025 14:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p2GyEklh"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 692E5537F8;
	Fri, 11 Jul 2025 14:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752244499; cv=none; b=U7YqVcG08WchaRtzrRTxxOnPVYpmYNfYvqRYJ0GXYj5rBdkPinYTG3fnhq4cTmmpdgTOCnxyriMTlOC+rkze6NaKG7YrSBY6bIDIfLWPoFgiwrxQLziPQiD5Mq5UHPK5XXFGYKWJUPy2hnWr5TlSl0HKG7b20uDiiF10kBYNjtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752244499; c=relaxed/simple;
	bh=T8y2b9IaX/szFDc7U8VGYNuylQX+m4cMuRZFNmQClcA=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:To:From:Subject:
	 References:In-Reply-To; b=pbgkWNdr1yLVvbfJRNRg8TzOYgq1P4cMUZXYIA6A6I79PvEFJEDprA65IkKtWksR3911TenqsaSyh6UxDZinuEyakdST4bB9N+C4rmXCgkFme3uN8rRbCC7RYTFKKYE8gJdixMRZgpmXzb77SvXAxT8yRxg7aiEEfdNpmXyvPIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p2GyEklh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8C4FC4CEED;
	Fri, 11 Jul 2025 14:34:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752244499;
	bh=T8y2b9IaX/szFDc7U8VGYNuylQX+m4cMuRZFNmQClcA=;
	h=Date:Cc:To:From:Subject:References:In-Reply-To:From;
	b=p2GyEklhw0aFnRY1GRyyLG3UqzgB6VhFNxeIAO+2TOa9WyKUN5QS5+nD2cdHI2pCg
	 GUm4jWO0DKIACnLXjXPAp+gSlzjklpPd1dbHE9zUYgCYDxycTMYPwJHgFUW7ilDs3E
	 9IMiq9dUgwC0On4IVCzhJYzHaNkQYjyLyGDnOCz9F1EacCKCycUPJ/eDAxYnim2I0d
	 mItEv8Fv+Xa9x+GQ76DcO4cAGdH5enmRq+KXrir+YP0BPHzn+q7hKUL53Sjqp2bDy2
	 ZMNC1w9hHZiQ2+rrv6wInb2nnWZBSs1akK5dXtElNesAesDyh5ZCnoe0H5F+j+bqH1
	 b+ziXBOsiVHlA==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 11 Jul 2025 16:34:52 +0200
Message-Id: <DB9ATYWI7KLT.SKAUN4HBQBVF@kernel.org>
Cc: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, "Dave Ertman"
 <david.m.ertman@intel.com>, "Ira Weiny" <ira.weiny@intel.com>, "Leon
 Romanovsky" <leon@kernel.org>, "Miguel Ojeda" <ojeda@kernel.org>, "Boqun
 Feng" <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Trevor
 Gross" <tmgross@umich.edu>, "Thomas Gleixner" <tglx@linutronix.de>, "Peter
 Zijlstra" <peterz@infradead.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 "David Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>,
 "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>, "Maxime Ripard"
 <mripard@kernel.org>, "Thomas Zimmermann" <tzimmermann@suse.de>, "FUJITA
 Tomonori" <fujita.tomonori@gmail.com>, "Bjorn Helgaas"
 <bhelgaas@google.com>, =?utf-8?q?Krzysztof_Wilczy=C5=84ski?=
 <kwilczynski@kernel.org>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
 <netdev@vger.kernel.org>, <linux-pci@vger.kernel.org>
To: "Alice Ryhl" <aliceryhl@google.com>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH v2 2/2] drm: rust: rename as_ref() to from_raw() for drm
 constructors
References: <20250711-device-as-ref-v2-0-1b16ab6402d7@google.com>
 <20250711-device-as-ref-v2-2-1b16ab6402d7@google.com>
In-Reply-To: <20250711-device-as-ref-v2-2-1b16ab6402d7@google.com>

On Fri Jul 11, 2025 at 10:04 AM CEST, Alice Ryhl wrote:
> The prefix as_* should not be used for a constructor. Constructors
> usually use the prefix from_* instead.
>
> Some prior art in the stdlib: Box::from_raw, CString::from_raw,
> Rc::from_raw, Arc::from_raw, Waker::from_raw, File::from_raw_fd.
>
> There is also prior art in the kernel crate: cpufreq::Policy::from_raw,
> fs::File::from_raw_file, Kuid::from_raw, ARef::from_raw,
> SeqFile::from_raw, VmaNew::from_raw, Io::from_raw.
>
> Link: https://lore.kernel.org/r/aCd8D5IA0RXZvtcv@pollux
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>

Applied to drm-misc-next, thanks!

