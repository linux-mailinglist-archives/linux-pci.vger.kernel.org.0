Return-Path: <linux-pci+bounces-29845-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D436ADAB6D
	for <lists+linux-pci@lfdr.de>; Mon, 16 Jun 2025 11:04:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6A3B17100A
	for <lists+linux-pci@lfdr.de>; Mon, 16 Jun 2025 09:04:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1F311A7253;
	Mon, 16 Jun 2025 09:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vCCjnVs1"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 743F81991CD;
	Mon, 16 Jun 2025 09:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750064659; cv=none; b=fgDYb+4ikKv96tocgqdNp22Q8Phe165LmOQtowcvqdJSu3O1iZRuoQM9nNwNN1YGqhX1dwiwcaYxaaxbhuQVYGL+TEBHvP9p17KVBu/A0cke/CKBR74D0XpsVrZs2Ooa0Cdf/mmglPi8TTH4LK8SNc7v3wHukg6TlNGJwH577uA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750064659; c=relaxed/simple;
	bh=0cC6uUPoW8D1ceNhr+gzB+r6cQqyjYO+BddOkail6Jg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=koNzkQachRBRoxZ0v6BDJXuuw1t16ETriLXrWOQWqht0P5kxM1nIiN4N7jhezsaBgSvEm/EeTBZxRNvRKeOJKEXf3fbVO4lpKf3+BHKBE7B2ERspsJpBFExJ4O4V8NUOXrM+z/KB4mRWX7K9fwuFF05a4pBrQHi3RAn1/zk2Zos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vCCjnVs1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7566C4CEEA;
	Mon, 16 Jun 2025 09:04:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750064655;
	bh=0cC6uUPoW8D1ceNhr+gzB+r6cQqyjYO+BddOkail6Jg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=vCCjnVs15JhLr+gkD0415uzKKH65zw2YauahA6dRUAPnpTJy+lPsBQ6ucpj7PZf0N
	 vvkhTkiUXBcywJwff0Ncy4b2zFm0yVpVGV7GiQuquOXqrE8cfvYNHeHu6FGWeHja/x
	 rfJWVhb++gX0S2D9XIaUSle/unVj5pwTs1H3JrDm2IZdLO9fPHfwRLNxEvmC6xRKl0
	 lR8bJSr2kBTAqCOF6bvWtcySDjgslavLj1rC0+8r3MbFhjezmcdlaPYgmL6J/AUDln
	 bGUrLl7+vAMzJmABMvhYZUPclEUIhdfWrZ2jA9D3eDwjPsKI+PbGyr/WDrHMIoeExR
	 bGrh9zQ+C8llA==
Message-ID: <92df9bdd-734b-461c-bf98-070e4fc59d50@kernel.org>
Date: Mon, 16 Jun 2025 11:04:08 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/6] rust: add support for port io
To: Alice Ryhl <aliceryhl@google.com>
Cc: Andrew Ballance <andrewjballance@gmail.com>, a.hindborg@kernel.org,
 airlied@gmail.com, akpm@linux-foundation.org, alex.gaynor@gmail.com,
 andriy.shevchenko@linux.intel.com, arnd@arndb.de, benno.lossin@proton.me,
 bhelgaas@google.com, bjorn3_gh@protonmail.com, boqun.feng@gmail.com,
 daniel.almeida@collabora.com, fujita.tomonori@gmail.com, gary@garyguo.net,
 gregkh@linuxfoundation.org, kwilczynski@kernel.org, me@kloenk.dev,
 ojeda@kernel.org, raag.jadav@intel.com, rafael@kernel.org, simona@ffwll.ch,
 tmgross@umich.edu, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 nouveau@lists.freedesktop.org, rust-for-linux@vger.kernel.org
References: <20250514105734.3898411-1-andrewjballance@gmail.com>
 <CAH5fLgjgtLQMaAZxufttzoVCJpAfTifn6VWwKZ7Q6vAOOvG+ug@mail.gmail.com>
From: Danilo Krummrich <dakr@kernel.org>
Content-Language: en-US
In-Reply-To: <CAH5fLgjgtLQMaAZxufttzoVCJpAfTifn6VWwKZ7Q6vAOOvG+ug@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 6/16/25 10:03 AM, Alice Ryhl wrote:
> On Wed, May 14, 2025 at 12:58 PM Andrew Ballance
> <andrewjballance@gmail.com> wrote:
>>
>> currently the rust `Io` type maps to the c read{b, w, l, q}/write{b, w, l, q}
>> functions and have no support for port io. this can be a problem for pci::Bar
>> because the pointer returned by pci_iomap can be either PIO or MMIO [0].
>>
>> this patch series splits the `Io` type into `Io`, and `MMIo`. `Io` can be
>> used to access PIO or MMIO. `MMIo` can only access memory mapped IO but
>> might, depending on the arch, be faster than `Io`. and updates pci::Bar,
>> so that it is generic over Io and, a user can optionally give a compile
>> time hint about the type of io.
>>
>> Link: https://docs.kernel.org/6.11/driver-api/pci/pci.html#c.pci_iomap [0]
> 
> This series seems to try and solve parts of the same problems as
> Daniel's patchset:
> https://lore.kernel.org/rust-for-linux/20250603-topics-tyr-platform_iomem-v9-0-a27e04157e3e@collabora.com/#r
> 
> We should probably align these two patchsets so that they do not add
> incompatible abstractions for the same thing.

AFAICS, they solve different problems, i.e.

   1) Add Port I/O support to the generic I/O abstractions.
   2) Add an abstraction for generic ioremap() used to map a struct resource
      obtained from a platform device.

The patch series will conflict though, I think it would be best to rebase this
one onto Daniel's patch series, since it is close to land.

