Return-Path: <linux-pci+bounces-32821-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B3ADB0F573
	for <lists+linux-pci@lfdr.de>; Wed, 23 Jul 2025 16:36:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACF9C1CC2DA6
	for <lists+linux-pci@lfdr.de>; Wed, 23 Jul 2025 14:35:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE2B72EF9BD;
	Wed, 23 Jul 2025 14:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aojR7DZ7"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8330F1E1DFC;
	Wed, 23 Jul 2025 14:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753281315; cv=none; b=tsq37vAA3r3rqhCMXAOIWLHUr7SkzHbiuPAc3WuB6t0YdbVkrk4+etH87BuKDo31NRCdlTYbU19rIz6ygH6RTvhm4Hvmj+53Kxcz3ZGsn+vzMzbjPqfH2pRS8M/JGPKxZ5jt0TS3WB4ck89Xy9/Nyn+ViSUz0CdOgI7f2Q+0wi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753281315; c=relaxed/simple;
	bh=xJym56oTvMq1mcxKBIzonpnQCj70oitN1cD+aRK/ddo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qbdkNrMfB+RsTPXIbkWf3u6SxEzEMAhiCVx3Lr1ydYfXzE8iP1fAd+ZMyNtRjnw1G5FamyYGzk23DRnKh9RjObulS+Kb8hlu70SgwqEnU082H6VRAXyXbWG4u+aGxwTABmm5I45FsG1Ns2CBJNPLq1MwH+HhaUnNpr1gYONVsPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aojR7DZ7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 964D9C4CEE7;
	Wed, 23 Jul 2025 14:35:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753281314;
	bh=xJym56oTvMq1mcxKBIzonpnQCj70oitN1cD+aRK/ddo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=aojR7DZ7bxyLE+5/qTN4yPDLC/oMLEyGSELJ8w+VK0jQTydCGNhC8bFeke4koFF6h
	 vi1HxiYIpSEKfsMmpS3G4HqEor2C6j9My4E47C1dnwj6+PLRaZMyEw/gD7KjZtLjk0
	 5q96WMVTKzzSPUmYNrM4tl4Ib5rejQGvgh9ldqISo3pGOGTOPp2vomjJ3CYmc8kvIi
	 4uu54P1gv/kYF91gAntBZNMOIFDSrpylo024kf0bE5RlniQ6qURP2lc3h+x2nqa4P5
	 crTCwcpOgDybWTVFmfFr3KAW2uwQVHPZv4YSnH1kOmZnHgOM4I5jTYkyrbp/iEg4C9
	 k72ctk5TVOhHw==
Message-ID: <7fa90026-d2ac-4d39-bbd8-4e6c9c935b34@kernel.org>
Date: Wed, 23 Jul 2025 16:35:08 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 3/6] rust: irq: add support for non-threaded IRQs and
 handlers
To: Boqun Feng <boqun.feng@gmail.com>
Cc: Daniel Almeida <daniel.almeida@collabora.com>,
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
 Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Thomas Gleixner
 <tglx@linutronix.de>, Bjorn Helgaas <bhelgaas@google.com>,
 =?UTF-8?Q?Krzysztof_Wilczy=C2=B4nski?= <kwilczynski@kernel.org>,
 Benno Lossin <lossin@kernel.org>, linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org, linux-pci@vger.kernel.org
References: <20250715-topics-tyr-request_irq2-v7-0-d469c0f37c07@collabora.com>
 <20250715-topics-tyr-request_irq2-v7-3-d469c0f37c07@collabora.com>
 <aIBl6JPh4MQq-0gu@tardis-2.local>
 <ED19060D-265A-4DEF-A12B-3F5901BBF4F3@collabora.com>
 <aIDxFoQV_fRLjt3h@tardis-2.local>
From: Danilo Krummrich <dakr@kernel.org>
Content-Language: en-US
In-Reply-To: <aIDxFoQV_fRLjt3h@tardis-2.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/23/25 4:26 PM, Boqun Feng wrote:
> On Wed, Jul 23, 2025 at 10:55:20AM -0300, Daniel Almeida wrote:
> But sure, this and the handler pinned initializer thing is not a blocker
> issue. However, I would like to see them resolved as soon as possible
> once merged.

I think it would be trivial to make the T an impl PinInit<T, E> and use a
completion as example instead of an atomic. So, we should do it right away.

- Danilo

