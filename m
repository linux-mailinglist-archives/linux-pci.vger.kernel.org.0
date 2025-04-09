Return-Path: <linux-pci+bounces-25556-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 131DEA82341
	for <lists+linux-pci@lfdr.de>; Wed,  9 Apr 2025 13:14:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC7511BA544C
	for <lists+linux-pci@lfdr.de>; Wed,  9 Apr 2025 11:13:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C30A25DD0B;
	Wed,  9 Apr 2025 11:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JLAl5bix"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05A9325DD00;
	Wed,  9 Apr 2025 11:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744197161; cv=none; b=On4uO1gcSaF9gr5OmHHw7oJFesBTxzuQfitqxsccORq89+KLn4BVATMOOUfWSSU63VwJIZ2Jg/V0qk3Ysdx+532gvVeVmJYPoVtDj7//eA/UFJbdzGiSPJcunDt7mP8PBkE+dE7dRXGUqWBhyTlRrJ5KeNoRLunZMxh6yViZhhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744197161; c=relaxed/simple;
	bh=fu51QOdu0zYhDKD62Nv58+jXxwkA8j6Vk7jJgAZWlZE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gJtuEzri81VsieomUHt9e7bqn1zGsEr5rLazWxJiNaRZuNSYu2YL+BaKPqf/TDHCYxQbZb4A4ATj5WADupjdNrifFnyHYrxcr0q3ffNOLq0n6ztidHWF/fkZ+AIFLP/LyElNf8v3+osE+xF6XxENYM37h4vTmDxEUHV2aYib7SQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JLAl5bix; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37294C4CEE3;
	Wed,  9 Apr 2025 11:12:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744197160;
	bh=fu51QOdu0zYhDKD62Nv58+jXxwkA8j6Vk7jJgAZWlZE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=JLAl5bix5PnBCG9MPoDPmDDSS+9dKNLwSxnhHqiPzo3yiSbih42XhF5kBZ7FdyGxk
	 1TkGdHnjKz63EVW2+nlY93c/esFEVweREzsiJSlHRHbnOpDHghy0mII92PtNh866gh
	 HomtMZA9B1uEaDsEZN4LD4BspIMBk46pKy/epLmK80OHf0WrDMBwbXfz8opJ1tLa6r
	 gkzFIMG09u/9rBSVqMVPcFD/hJTAlDGJEV6z/RCn5gZNJIIC3gXbMoJ4+C+D0WF/wo
	 +OPUExpfgCNcfwQSBmJ5H7mo7QuVqsrABQKUxX4/AaNQmsZa71P0pRPSjdkkFccHrK
	 3rV6Ttp+4Iyiw==
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
Subject: Re: [PATCH v2 1/2] rust: retain pointer mut-ness in `container_of!`
In-Reply-To: <20250409-no-offset-v2-1-dda8e141a909@gmail.com> (Tamir
	Duberstein's message of "Wed, 09 Apr 2025 06:03:21 -0400")
References: <20250409-no-offset-v2-0-dda8e141a909@gmail.com>
	<wNTv3DUCxugtsN73Pr6pIECzSTPNWa-VY-rRpG5RjiIyLAloJxoS_AXQnHXzLZmiA-1MLPTMEP7XkdDgu8yGew==@protonmail.internalid>
	<20250409-no-offset-v2-1-dda8e141a909@gmail.com>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Wed, 09 Apr 2025 13:12:15 +0200
Message-ID: <87semhbncg.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Tamir Duberstein" <tamird@gmail.com> writes:

> Avoid casting the input pointer to `*const _`, allowing the output
> pointer to be `*mut` if the input is `*mut`. This allows a number of
> `*const` to `*mut` conversions to be removed at the cost of slightly
> worse ergonomics when the macro is used with a reference rather than a
> pointer; the only example of this was in the macro's own doctest.
>
> Reviewed-by: Benno Lossin <benno.lossin@proton.me>
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>

Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>


Best regards,
Andreas Hindborg




