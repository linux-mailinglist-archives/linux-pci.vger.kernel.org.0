Return-Path: <linux-pci+bounces-32254-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A7065B072B7
	for <lists+linux-pci@lfdr.de>; Wed, 16 Jul 2025 12:09:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31B5FA40244
	for <lists+linux-pci@lfdr.de>; Wed, 16 Jul 2025 10:08:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93C8D2F2737;
	Wed, 16 Jul 2025 10:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uFVyG3Tv"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 636BC2F2708;
	Wed, 16 Jul 2025 10:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752660520; cv=none; b=ERctnpMF+/n9TLLWw+Sg+Cu93zaV2b8fgXrLA5W6RNDyLr+J3iojobjg1vVpGqKg0Y8DrY2LcMzkge28CeKhov2PrzK1/817+ZCPy/KJiJnbmk4o95kB0HUjkrQMEviqcGjd0v0foKqpkFWjDxhGhY+776loU37I1ahl760121E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752660520; c=relaxed/simple;
	bh=ygRdgWBky8NpY2ERRzAFKmGtSKpHj58BdrOI5Bf4iUk=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=dwRXUrZm8t0C7LFpHuUMblBRYiYcpiYsE6PbWQdyoyyEQ3SFR6sMfoXuHVAVknACQuI3lR9cTjA18F7lo9BW60LKXJkCUHcEghDOUuXgSgYNbPxSCDR7/9JYDlwbs0lE3e0YP9BGN8dPm9VDVruf3p5B97beRdd/jcSlV5HsQtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uFVyG3Tv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 282B1C4CEF0;
	Wed, 16 Jul 2025 10:08:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752660517;
	bh=ygRdgWBky8NpY2ERRzAFKmGtSKpHj58BdrOI5Bf4iUk=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=uFVyG3TvCB03QVldUaVg5CCpKIhNAn84Wmt45Uz68lM7CAe7Iz+PN8G9lf2FvQVue
	 x0zDy5XH+adwlxqkvwuQ1TUg+8EkyDqOLxjm5lq5HQ0ai71ce/TtyUGicQnmSXvlQU
	 5W/oQV8/IQs740+swphfWgxq5jrmUJKPleg/u4L34tnwi+Ivzz2xP+J6qATfW5H3H+
	 i3r2QVzRyh5dkxn6zH+I91hBeTlbrPZBi3c5BcVg1NcIPkW3HRjdTLCo3aYjxkWpP4
	 1QBIO+2tp3x1nUMP91YPqF4Mm6rvcS8Yj8U0+NcRwuPwXR1jKBEgRjARybreGHjeij
	 FRI8ZlWxN4nKA==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 16 Jul 2025 12:08:32 +0200
Message-Id: <DBDEARWBQERF.WCGQ708G934O@kernel.org>
Subject: Re: [PATCH 2/5] rust: dma: add DMA addressing capabilities
Cc: <abdiel.janulgue@gmail.com>, <daniel.almeida@collabora.com>,
 <robin.murphy@arm.com>, <a.hindborg@kernel.org>, <ojeda@kernel.org>,
 <alex.gaynor@gmail.com>, <boqun.feng@gmail.com>, <gary@garyguo.net>,
 <bjorn3_gh@protonmail.com>, <lossin@kernel.org>, <aliceryhl@google.com>,
 <tmgross@umich.edu>, <bhelgaas@google.com>, <kwilczynski@kernel.org>,
 <rafael@kernel.org>, <rust-for-linux@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
To: "Greg KH" <gregkh@linuxfoundation.org>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20250710194556.62605-1-dakr@kernel.org>
 <20250710194556.62605-3-dakr@kernel.org>
 <2025071627-outlet-slacker-9382@gregkh>
In-Reply-To: <2025071627-outlet-slacker-9382@gregkh>

On Wed Jul 16, 2025 at 11:15 AM CEST, Greg KH wrote:
> On Thu, Jul 10, 2025 at 09:45:44PM +0200, Danilo Krummrich wrote:
>> +/// Returns a bitmask with the lowest `n` bits set to `1`.
>> +///
>> +/// For `n` in `0..=3D64`, returns a mask with the lowest `n` bits set.
>> +/// For `n > 64`, returns `u64::MAX` (all bits set).
>> +///
>> +/// # Examples
>> +///
>> +/// ```
>> +/// use kernel::dma::dma_bit_mask;
>> +///
>> +/// assert_eq!(dma_bit_mask(0), 0);
>> +/// assert_eq!(dma_bit_mask(1), 0b1);
>> +/// assert_eq!(dma_bit_mask(64), u64::MAX);
>> +/// assert_eq!(dma_bit_mask(100), u64::MAX); // Saturates at all bits s=
et.
>> +/// ```
>> +pub const fn dma_bit_mask(n: usize) -> u64 {
>> +    match n {
>> +        0 =3D> 0,
>> +        1..=3D64 =3D> u64::MAX >> (64 - n),
>> +        _ =3D> u64::MAX,
>> +    }
>> +}
>
> This is just the C macro DMA_BIT_MASK(), right?  If so, can that be said
> here somewhere?

Yes, I think that'd be good.

> Or, how about turning DMA_BIT_MASK() into an inline
> function which could then be just called by the rust code directly
> instead?

Unfortunately, bindgen doesn't pick up either, so converting to an inline
function wouldn't help.

We could use it through a Rust helper though, but I considered this to be
unnecessary overhead. Whether that's relevant in this case is of course
questionable though. :)

Given that we also concluded that we want to return a new type (i.e. DmaMas=
k)
rather than a u64, I feel like it's a bit cleaner to keep it self-contained=
.

