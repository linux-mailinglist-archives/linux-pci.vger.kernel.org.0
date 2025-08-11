Return-Path: <linux-pci+bounces-33734-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E3FAFB20994
	for <lists+linux-pci@lfdr.de>; Mon, 11 Aug 2025 15:05:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E477420494
	for <lists+linux-pci@lfdr.de>; Mon, 11 Aug 2025 13:05:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 382632D3EC3;
	Mon, 11 Aug 2025 13:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TPnxD+kh"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C0222D29B7;
	Mon, 11 Aug 2025 13:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754917499; cv=none; b=DtbBF1FD8JNrw4s0jc6G/jbzecVQfvOiT/4HHpayZ9DfvzQgJC6b57ZaMRTQq1hKs3FG11wHSQrAjBfYqSChRj7XhEZpwR10yFWvOTMxFoiZEZW39TlV6VOhKaQKWfTgm1QvFDiq+ptoycVgqlYcjCqpkN9CFn13W4KjIKDIpnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754917499; c=relaxed/simple;
	bh=75jaia6obJquOA8s7iQYq1ncmpTeyvD5w/eZo/UlIns=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jKR0DRwk1CDf8FZHmWMoRKqSSzrXh9bCzGMRMd1ixkqSNou7khHjRP8BpZI2C57o7iYnVbqchF/ilfPrGiaL+/8ziJGUI6U8X1P7gofXBKKHASqcaAiqqP2A+vmEQmIb02JLiGXkIi2uQd+dqwOUqHWX12sMXzwBszgBvKodVgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TPnxD+kh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E3D9C4CEED;
	Mon, 11 Aug 2025 13:04:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754917498;
	bh=75jaia6obJquOA8s7iQYq1ncmpTeyvD5w/eZo/UlIns=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=TPnxD+khz49HBBiCPa3nlfbBqxn0OxdBzjf+fQr0JHvlMABNQjLLWv5zC/MmuxSLW
	 ECF6Tkwbg/R7unIrwx1NPmjXGCBj73DtuhMacLxHUWIesXiZJVYYBWJymCME0jcy5K
	 N4KSd3tfc4eaJMpv01vSkfUVE8drTwe5m1fYhQiXV8wwjkQuHwh6dNRO2d+xfNwY05
	 pnrMBi4vLRRUhcUD/uFnNaTwMP6G4kAxE2zcH642PuiWzTjLEhfgg3SnkaQJrPbRKV
	 aQq8bOkIyC8tNksnxh0P4k4Tb7MTYK0gFiBrInVmwmeWdGHs8dyfAH1JAUYC5xHRpb
	 +GQ5IDHMgoXYg==
Message-ID: <ff4e21d1-9271-45ab-850c-976f063e613e@kernel.org>
Date: Mon, 11 Aug 2025 15:04:53 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 3/6] rust: irq: add support for non-threaded IRQs and
 handlers
To: Daniel Almeida <daniel.almeida@collabora.com>
Cc: Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>,
 Trevor Gross <tmgross@umich.edu>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Thomas Gleixner
 <tglx@linutronix.de>, Bjorn Helgaas <bhelgaas@google.com>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Benno Lossin <lossin@kernel.org>, linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org, linux-pci@vger.kernel.org,
 Joel Fernandes <joelagnelf@nvidia.com>, Dirk Behme <dirk.behme@de.bosch.com>
References: <20250810-topics-tyr-request_irq2-v8-0-8163f4c4c3a6@collabora.com>
 <20250810-topics-tyr-request_irq2-v8-3-8163f4c4c3a6@collabora.com>
 <aJnM1LgUYjTloVwV@google.com>
 <4EE6F260-5AC9-47AD-9F34-0D6C224A8559@collabora.com>
 <CAH5fLghV0aVZBBEmjf9CF9gFyG08dH7nFzKHnHM6RiANuSZaMw@mail.gmail.com>
 <AF48133C-BD57-4EEF-8E4A-ABEECB8A5C49@collabora.com>
 <CAH5fLggOqsrob-h2v8c5hsnMquJZhXJ2euAub2ia2fjj=NY8Vg@mail.gmail.com>
 <77FB27DB-ACE0-4AC4-A3D9-CCF1EB4A34D2@collabora.com>
From: Danilo Krummrich <dakr@kernel.org>
Content-Language: en-US
In-Reply-To: <77FB27DB-ACE0-4AC4-A3D9-CCF1EB4A34D2@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/11/25 2:55 PM, Daniel Almeida wrote:
> Fine, let me try this again.

This sounds like you're going to send a v9. In this case, please make sure to
also use pin-init for the Completion in the IRQ example.

