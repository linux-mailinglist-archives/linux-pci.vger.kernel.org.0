Return-Path: <linux-pci+bounces-34181-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1322BB29C31
	for <lists+linux-pci@lfdr.de>; Mon, 18 Aug 2025 10:28:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5BC371960C4D
	for <lists+linux-pci@lfdr.de>; Mon, 18 Aug 2025 08:28:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64BBF3002BA;
	Mon, 18 Aug 2025 08:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T9zCWdrW"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 396E622F01;
	Mon, 18 Aug 2025 08:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755505663; cv=none; b=SMmFdQ7n8ZghsAfdIQdOMa9Z/pkmvMUXfeZbYIFoF3anaMdskuHYbtrMUeRcTwNYdnsRI7JB+SwYwiJDSbU0S4RfhNAtaP1fKrtN5codKy2N3F+0PXc3oEAsDfKXgYR7CBwdKEaHyflU7jlY/EMYEoa7nN0aGQAV6+IJ7Xia2y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755505663; c=relaxed/simple;
	bh=N2pcGJDlaVAHPjtQHEf5+u5E65fLYXwtOnNdcrLUNuQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KsT6lQk5WE74+o05NxTszy7HGO/k9Jhy1X4oeWLcTg1eOr76yx6fOvaZ6PR1LR+7iBb4Mksm3LFdndadEOCaVCdjQnAWjQaH5TthK2pzmqNQ1oOPIFSBOPOuT7iQXmk4RAlGE2YYtjHBIozqUntQh5yONc/yeFfbOYveyzUlmz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T9zCWdrW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FA20C4CEF1;
	Mon, 18 Aug 2025 08:27:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755505663;
	bh=N2pcGJDlaVAHPjtQHEf5+u5E65fLYXwtOnNdcrLUNuQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=T9zCWdrWhwFfJQyduXgFMW3JlM2UoUArKsxKuSEFiRnXPpR+IDGztqIiRSuDPFbsk
	 m3Mo3XHtCSVlGCdkjS5Xp3HP+Rthtq8c2DuRllYdDP72phopbG3RhDHS6S9Ul5uKbI
	 75YqSbalpfAhrCmzolwLkgU+P8+wog7Y3pqrOHEV7ZbjnJXMibiwcUpmSRAtPIsRWD
	 iItQpVs4/Lo1a/PP+GELQOsUKUx3Rj0X0r3IdNdZ69/1ipD3Kfz4EJpy07Zyx1p7bX
	 alfr05fOv3lgqI7dYiCQdDmrr5W0tJprjlZbOh37PAwIT+zHAJAUAw3E81YXgCATm+
	 S0eXXmF4dIvbg==
Message-ID: <187657ee-f258-4477-b53e-4761aad84f3d@kernel.org>
Date: Mon, 18 Aug 2025 10:27:38 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 0/7] rust: add support for request_irq
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Daniel Almeida <daniel.almeida@collabora.com>,
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Thomas Gleixner
 <tglx@linutronix.de>, Bjorn Helgaas <bhelgaas@google.com>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Benno Lossin <lossin@kernel.org>, linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org, linux-pci@vger.kernel.org,
 Joel Fernandes <joelagnelf@nvidia.com>, Dirk Behme <dirk.behme@de.bosch.com>
References: <20250811-topics-tyr-request_irq2-v9-0-0485dcd9bcbf@collabora.com>
 <bL5l0lXohHy-SbvhHpQTRfWPqfZWJg3DiOfkBU7ehVCq3rC6yzFvYQN6d9rSU_ELZr8zh-lKNKPEeUfbgeu2Mw==@protonmail.internalid>
 <DC0OOFT2RTO7.2PCAP981HCCN3@kernel.org>
 <87tt25ca2u.fsf@t14s.mail-host-address-is-not-set>
From: Danilo Krummrich <dakr@kernel.org>
Content-Language: en-US
In-Reply-To: <87tt25ca2u.fsf@t14s.mail-host-address-is-not-set>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/18/25 10:23 AM, Andreas Hindborg wrote:
> "Danilo Krummrich" <dakr@kernel.org> writes:
> 
>> On Mon Aug 11, 2025 at 6:03 PM CEST, Daniel Almeida wrote:
>>
>> Applied to driver-core-testing, thanks!
>>
>>> Alice Ryhl (1):
>>>        rust: irq: add &Device<Bound> argument to irq callbacks
>>>
>>> Daniel Almeida (6):
>>>        rust: irq: add irq module
>>>        rust: irq: add flags module
>>
>>      [ Use expect(dead_code) for into_inner(), fix broken intra-doc link and
>>        typo. - Danilo ]
>>
>>>        rust: irq: add support for non-threaded IRQs and handlers
>>
>>      [ Remove expect(dead_code) from Flags::into_inner(), add
>>        expect(dead_code) to IrqRequest::new(), fix intra-doc links. - Danilo ]
>>
>>>        rust: irq: add support for threaded IRQs and handlers
>>
>>      [ Add now available intra-doc links back in. - Danilo ]
>>
>>>        rust: platform: add irq accessors
>>
>>      [ Remove expect(dead_code) from IrqRequest::new(), re-format macros and
>>        macro invocations to not exceed 100 characters line length. - Danilo ]
>>
>>>        rust: pci: add irq accessors
> 
> I somehow missed that you already applied this, so I just sent comments
> for patch 3. I think there are some issues. If you want my comments for
> the rest of the series, let me know. Otherwise I'll just skip that.

Sure, please do -- I'm sure Daniel is willing to send patches for any
improvements that may arise.

