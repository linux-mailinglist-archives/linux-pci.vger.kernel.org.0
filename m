Return-Path: <linux-pci+bounces-32340-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9803AB080C3
	for <lists+linux-pci@lfdr.de>; Thu, 17 Jul 2025 00:58:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 146411C25609
	for <lists+linux-pci@lfdr.de>; Wed, 16 Jul 2025 22:58:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46E792EE98B;
	Wed, 16 Jul 2025 22:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DcoD2fcN"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 178D521421E;
	Wed, 16 Jul 2025 22:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752706683; cv=none; b=s9B7kTpbUUxHVB/yxwOxFsZKH/X81ZlARiXVQw1lqMZ9xmjH+EshVad7VKPHy8HbVDBmkMS+IWH1J7cLTfFaH06aQERK2yJhwVGN9Md64ACe2akG5BGo9VINKrHh/e/Znl5TTSV9ZXV0i73cmQLb1E5DTbGvx4tgHqO3pDJrnNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752706683; c=relaxed/simple;
	bh=feyZUWnRLhI1C4HTdJ3yKYnq0VO/UBF9lovva/LkJx0=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=GUc4g01nbVmqf+I2IQcg3AJB7wyxXh+2W6Cg/zUaj9DnhL/q5d7LKVqxLy1iiU2K3ryZV9yA4sNaRMX5K15ko77oFIWbuoQFxL15UXyLJb8cvjbCfLusJIsTyMRSmjDN8/yzleb32sdzFClC5ud7E4UwVb9cmnARYajkL6w2fSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DcoD2fcN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80F6AC4CEE7;
	Wed, 16 Jul 2025 22:57:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752706683;
	bh=feyZUWnRLhI1C4HTdJ3yKYnq0VO/UBF9lovva/LkJx0=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=DcoD2fcNUtdPrjQw90CoOSe4Dwwm2GyYFGYFHUQzSlRaZ2BnYS/u6XKoe1tvumfNO
	 Ipb6Hphd6iiy4FuSrYLnaaTJQFlkLsf0JwPWmpJPATeV5L1JsI6fzJL9AJfA6I0t+k
	 6E/6apYDZWLdtyoS6Q6DdMAVjWzB0Zg30b8cmyC396IoK3eFRfibOZcNjgKhRRY+ie
	 zOU3A6QjLGZ/wtwQ1q/8iPoVaw2HqAByy+gmNq7q8CenPBLYxH3+ZGBPuptULx44qX
	 JQ4RzWYxyxTr+TUkJXita5jK6kLtdOY8mzMPYBKv9vJdwd7iBoC1mnOf3mFTZFiqE9
	 QZg4ji8xpMWLQ==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 17 Jul 2025 00:57:55 +0200
Message-Id: <DBDUNV3UWXNE.3KHTYC5BEZWYS@kernel.org>
Subject: Re: [PATCH v2 1/2] device: rust: rename Device::as_ref() to
 Device::from_raw()
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

Applied to driver-core-testing, thanks!

