Return-Path: <linux-pci+bounces-32068-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E39BB03FC3
	for <lists+linux-pci@lfdr.de>; Mon, 14 Jul 2025 15:26:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E46E41A6615E
	for <lists+linux-pci@lfdr.de>; Mon, 14 Jul 2025 13:24:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2254B25332E;
	Mon, 14 Jul 2025 13:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eB6jqWJr"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDE0A24C07F;
	Mon, 14 Jul 2025 13:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752499266; cv=none; b=npv0rKSGO6aHGim4yNrXAwZcNfTTY7BYaht5iX45VHga9LXTxEBU2dh6kNPJgdg05DMj1uGNGUqaO5/isQ4zk87oiICf1tUUMjyyfzfC4XsWGJ/WFqef6LbiWsCc2JKzg6kkHbztLvhQ75mQIBfER1D4k7aYYv2DtQ5/ASVSLWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752499266; c=relaxed/simple;
	bh=e7cqCMIVwiyT8RzReLiQL/MIid2RLe+DaHtAHYAcb2o=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=sDPC8IM+o3k/RQv0bG1OCJ6oHO/VFaWXwz+2jisg5l0SKKk5oJumEHFKD2BwhqyXrj4Kvlb9E4t2/WsFbjX79bOkgsXTEfJaseTOESF++Id8rRWiD0/A23VH8c/SU/2f6HwDIWcszVFo364l4QTyeZ2452a8ud/l4QaI/9y8bGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eB6jqWJr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AA92C4CEED;
	Mon, 14 Jul 2025 13:20:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752499265;
	bh=e7cqCMIVwiyT8RzReLiQL/MIid2RLe+DaHtAHYAcb2o=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=eB6jqWJr8t2Q9Jb220i5BDpkArwX6oTF2Mk56a9D7QpZVUDiPi/UM4Lu8aIUqqtqI
	 ggfF7nseoLaP9ckNVAc0hCBcynBG5ryhu1l21ilE6a7Ij7dzlctm6ByzKDPfnBQz+9
	 2IUtQdmkgmP6eVQOb4HsxssFA4V9Vj8LtLBVLHsP9HXZxd0vE1l3yWS4NmSjo0yLkd
	 1+B7piqJKFBSvAWvFkITGF3vwGhF9jUkepPaKWpuc4+jgxG8LOJXsRm+S3QIIj7p+k
	 IHvfxcZAeNyo/avWCHy9d6PwUan3wcy9ckGo4eKXVe+6x66jT86R1XIm4+xLbnzE9k
	 V4ra4+sOp1b2Q==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 14 Jul 2025 15:20:58 +0200
Message-Id: <DBBT50VYG8EJ.1Y54CR9X8SQ80@kernel.org>
Subject: Re: [PATCH v2 1/2] device: rust: rename Device::as_ref() to
 Device::from_raw()
Cc: "Alice Ryhl" <aliceryhl@google.com>, "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>, "Dave Ertman" <david.m.ertman@intel.com>,
 "Ira Weiny" <ira.weiny@intel.com>, "Leon Romanovsky" <leon@kernel.org>,
 "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng" <boqun.feng@gmail.com>,
 "Gary Guo" <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Trevor Gross" <tmgross@umich.edu>,
 "Rafael J. Wysocki" <rafael@kernel.org>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Maarten Lankhorst"
 <maarten.lankhorst@linux.intel.com>, "Maxime Ripard" <mripard@kernel.org>,
 "Thomas Zimmermann" <tzimmermann@suse.de>, "Bjorn Helgaas"
 <bhelgaas@google.com>, =?utf-8?q?Krzysztof_Wilczy=C5=84ski?=
 <kwilczynski@kernel.org>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
 <netdev@vger.kernel.org>, <linux-pci@vger.kernel.org>
To: "Thomas Gleixner" <tglx@linutronix.de>, "Peter Zijlstra"
 <peterz@infradead.org>, "FUJITA Tomonori" <fujita.tomonori@gmail.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20250711-device-as-ref-v2-0-1b16ab6402d7@google.com>
 <20250711-device-as-ref-v2-1-1b16ab6402d7@google.com>
In-Reply-To: <20250711-device-as-ref-v2-1-1b16ab6402d7@google.com>

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

FUJITA, Thomas, Peter: Unless there are any concerns, I'll pick this one up
soon.

