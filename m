Return-Path: <linux-pci+bounces-32719-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E245EB0D84F
	for <lists+linux-pci@lfdr.de>; Tue, 22 Jul 2025 13:36:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2D51560DEB
	for <lists+linux-pci@lfdr.de>; Tue, 22 Jul 2025 11:36:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C375E2E2F1C;
	Tue, 22 Jul 2025 11:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="StWvaIKB"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96B302E2EFF;
	Tue, 22 Jul 2025 11:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753184175; cv=none; b=bNZDAVezy98RwH96rDIsUHrZl6S6bx1Q4BVpl18pUIAWhqLEI/MhMI174FxiLRJWdm14BBkC+z+VuV14bua8SpQsjRIbtdI+hI1ECUjxdhUYq4mrAsuV9aOf+eTrJTT72iy3nyTnZTqdHwG+kuZmaLfMU3IgNAxHqYr334NO+E0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753184175; c=relaxed/simple;
	bh=6jt5GTK+6dNViwg0jv8XmC2xhjI3baxH4ZvaFc5mP4s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b3eoOocaYrcY8QeJciIk86ngYn7YHX+oFF2lX8dnjlIixhuycg96lmjDAsCNqFFmCNode8krBPPJXOaiAo2z68X9B3qA3Jkx0zGNpY95xX0HpiZPY0/i352BmcofvyBJiYmZF0GvMuDxCpGLybTfEebdf4ics4eeEofafN2SRaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=StWvaIKB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79D10C4CEEB;
	Tue, 22 Jul 2025 11:36:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753184175;
	bh=6jt5GTK+6dNViwg0jv8XmC2xhjI3baxH4ZvaFc5mP4s=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=StWvaIKBx7VqaynVbI/AZYu1cCXsyFJRkejL4J2AtdBwwEPMzat9W0QAvS+9Mh0ei
	 /3BwOJ+McrGyto0rwKt8CG72NBFVbZLVQYFqTSvXoWfHETVXJ+D00MGkN7FHxefHkn
	 7DheYPT3W5Jy4AKGs9gekdZlz4LTxboWrqKS8a2KVx6I9HR/XFvSDv/gZ5NcZ12Vp0
	 jEHB/cfAN/0moVw5FGPsOlsTQh9YsEpY9uk8pJl2BXPgNX2XWwnzmyzcpfrEIvXeiW
	 eR1UdYPwjd8VmOiDJ8ALnaDXoqpKNt+dvjlp/heCDnyKK/lqcFY44fLaTruWHQFcKv
	 Mhf5hzPoS/Ltw==
Message-ID: <c5ba329d-ea62-4a8c-97df-594eb8c6b3af@kernel.org>
Date: Tue, 22 Jul 2025 13:36:09 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] rust: Update PCI binding safety comments and add
 inline compiler hint
To: Benno Lossin <lossin@kernel.org>
Cc: Alistair Popple <apopple@nvidia.com>, rust-for-linux@vger.kernel.org,
 Bjorn Helgaas <bhelgaas@google.com>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, John Hubbard <jhubbard@nvidia.com>,
 Alexandre Courbot <acourbot@nvidia.com>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250710022415.923972-1-apopple@nvidia.com>
 <DB87TX9Y5018.N1WDM8XRN74K@kernel.org>
 <DB9BF6WK8KMH.1RQOOMYBL6UAO@kernel.org>
 <DB9FUEJUOH3L.14CYPZ8YQT52E@kernel.org>
 <DB9H6HEF9CKG.2SAPXM8F9KOO3@kernel.org>
 <DB9IQAU4WPSP.XZL4ZDPT59KU@kernel.org>
 <bwbern2t7k5fcj6zxze6bjpasu3t26n6dmfptlmhbhd7qmligs@3fgwifsw7qai>
 <DBIHP8IP3OHA.8Y1S9ZV1Y1SZ@kernel.org> <DBIJ3POBANNM.KSO1I5557PFV@kernel.org>
 <be42295e-63e1-4e2f-986f-aef962f531bd@kernel.org>
 <DBIJM4PTRHAS.3KXPG1MHNS8K0@kernel.org>
From: Danilo Krummrich <dakr@kernel.org>
Content-Language: en-US
In-Reply-To: <DBIJM4PTRHAS.3KXPG1MHNS8K0@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/22/25 1:21 PM, Benno Lossin wrote:
> On Tue Jul 22, 2025 at 1:02 PM CEST, Danilo Krummrich wrote:
>> On 7/22/25 12:57 PM, Benno Lossin wrote:
>>> On Tue Jul 22, 2025 at 11:51 AM CEST, Danilo Krummrich wrote:
>>>> I think they're good, but we're pretty late in the cycle now. That should be
>>>> fine though, we can probably take them through the nova tree, or in the worst
>>>> case share a tag, if needed.
>>>>
>>>> Given that, it would probably be good to add the Guarantee section on as_raw(),
>>>> as proposed by Benno, right away.
>>>>
>>>> @Benno: Any proposal on what this section should say?
>>>
>>> At a minimum I'd say "The returned pointer is valid.", but that doesn't
>>> really say for what it's valid... AFAIK you're mostly using this pointer
>>> to pass it to the C side, in that case, how about:
>>
>> It is used for for FFI calls and to access fields of the underlying
>> struct pci_dev.
> 
> By "access fields" you mean read-only?

We might also write them, but currently we only write them through FFI calls on
the C side.

