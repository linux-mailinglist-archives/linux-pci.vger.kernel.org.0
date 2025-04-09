Return-Path: <linux-pci+bounces-25557-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0201BA8233C
	for <lists+linux-pci@lfdr.de>; Wed,  9 Apr 2025 13:14:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7891A4A8289
	for <lists+linux-pci@lfdr.de>; Wed,  9 Apr 2025 11:13:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23E3325E817;
	Wed,  9 Apr 2025 11:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CqZs3ePU"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB76225DD17;
	Wed,  9 Apr 2025 11:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744197166; cv=none; b=eXj2hAhoSkf2e79PC4G3lukifleFOEv4Tm6ZaweZEFPROYAVlmPpoc9ayWrB6v8TfrUgfdhDob80eo02jSshY35kgpQXu42ntbEGNqEzVdhO8BAvjpbfa55nM0xAgPNpK/vK7CKWQmj+Feg+bH4gH8qwki2WKoRajHZtlgCVlnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744197166; c=relaxed/simple;
	bh=Qo7Clwaeg5iKOfkIm50zPxdbM4nFBPTM7d5T9QbfvNA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bcAReoCngKcrGt/CY78rYiOoyYLgKtU9bswkBGT4RqRF8olViV1xxa/8s6tcFakfwgIHCZlQBmebH9P5sJHy+ugf7WOwXYSLKeIv5imRJ4qUb0ZMxeCxCF6Fa/J5pmvMKyrXlcEaUjIiK6D/KwqFkiFgujk60laTCpBN1skQYyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CqZs3ePU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5472BC4CEE3;
	Wed,  9 Apr 2025 11:12:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744197165;
	bh=Qo7Clwaeg5iKOfkIm50zPxdbM4nFBPTM7d5T9QbfvNA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=CqZs3ePU5ks24WasvSpJF3GUt8s2zba7JiMYq/N8jllfFzOhlJWqYMFV9nE+P8BOt
	 /ZIaGZz1G5Dulw+Hpa9NwHUkyERlebjawiIbninWMskA12hi9WCK5y8hGT/aiAlitE
	 VC540Phb8Tgr3LfKm7mYH7CSZp0QHOy0Ysjjdrort9OxoOin4p7iiRCx1TXOLWRl2y
	 uVrdPYhd372FRpY7WgphPi3Nl5xkOKrHdn7rE6XaQimgEm2sV6PXzy+uT6T/hIkv/4
	 IKlKCUAdjf1JqUEvVlK1BIJ2f6wPn+wg7GMIX4c2btUL+yxYbw3dg1MDfLilI4XcjF
	 f1+DbEMCV/DkQ==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: "Tamir Duberstein" <tamird@gmail.com>
Cc: "Miguel Ojeda" <ojeda@kernel.org>,  "Alex Gaynor"
 <alex.gaynor@gmail.com>,  "Boqun Feng" <boqun.feng@gmail.com>,  "Gary Guo"
 <gary@garyguo.net>,  =?utf-8?Q?Bj=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>,  "Benno
 Lossin" <benno.lossin@proton.me>,  "Alice Ryhl" <aliceryhl@google.com>,
  "Trevor Gross" <tmgross@umich.edu>,  "Bjorn Helgaas"
 <bhelgaas@google.com>,  "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
  "Rafael J. Wysocki" <rafael@kernel.org>,  "Danilo Krummrich"
 <dakr@kernel.org>,  "Tejun Heo" <tj@kernel.org>,  "Lai Jiangshan"
 <jiangshanlai@gmail.com>,  <rust-for-linux@vger.kernel.org>,
  <linux-kernel@vger.kernel.org>,  <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] rust: workqueue: remove HasWork::OFFSET
In-Reply-To: <20250409-no-offset-v2-2-dda8e141a909@gmail.com> (Tamir
	Duberstein's message of "Wed, 09 Apr 2025 06:03:22 -0400")
References: <20250409-no-offset-v2-0-dda8e141a909@gmail.com>
	<_2lgE6Qood7rRL_gFY6gCUd_g_0AFjQ0LslIdJYRZ8vLk5TelgQNPfJfJYOA6JPJxOdGlnG8EldbpmGNRMAUUQ==@protonmail.internalid>
	<20250409-no-offset-v2-2-dda8e141a909@gmail.com>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Wed, 09 Apr 2025 13:12:26 +0200
Message-ID: <87mscpbnc5.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Tamir Duberstein" <tamird@gmail.com> writes:

> Implement `HasWork::work_container_of` in `impl_has_work!`, narrowing
> the interface of `HasWork` and replacing pointer arithmetic with
> `container_of!`. Remove the provided implementation of
> `HasWork::get_work_offset` without replacement; an implementation is
> already generated in `impl_has_work!`. Remove the `Self: Sized` bound on
> `HasWork::work_container_of` which was apparently necessary to access
> `OFFSET` as `OFFSET` no longer exists.
>
> A similar API change was discussed on the hrtimer series[1].
>
> Link: https://lore.kernel.org/all/20250224-hrtimer-v3-v6-12-rc2-v9-1-5bd3bf0ce6cc@kernel.org/ [1]
> Reviewed-by: Benno Lossin <benno.lossin@proton.me>
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> Tested-by: Alice Ryhl <aliceryhl@google.com>
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>

Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>


Best regards,
Andreas Hindborg



