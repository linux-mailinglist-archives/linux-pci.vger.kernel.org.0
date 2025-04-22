Return-Path: <linux-pci+bounces-26371-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B75AA9605E
	for <lists+linux-pci@lfdr.de>; Tue, 22 Apr 2025 10:03:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0AAF188AD33
	for <lists+linux-pci@lfdr.de>; Tue, 22 Apr 2025 08:03:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 142D11EB5F0;
	Tue, 22 Apr 2025 08:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D9HgzIVZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAEBD33F7;
	Tue, 22 Apr 2025 08:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745308891; cv=none; b=BW+M/lBJZLPJN0ZnBikWuKobSSK6pRL/AOrnsq61OIgkZ/OHui9ihOVJZKyBhi1l42YPan3NNBmxycTuPGrLb2PPiXEzlw5NQVwkET8xnoZ3TPFLzWEC8FlCepcGczw+0FXLCxQfqAOKa4mAWl1q7knMabhirKujuGyDElGHnkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745308891; c=relaxed/simple;
	bh=V/82unvtAxABgycm+y7kaJ+iuM4jIynRbg8g2O3qJX0=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=e9BAQn5y2oDkABFQDzXJOMwxe31u4qZfhpcNThVQl4Cg31HaHIwKBnHcyUnIqAne0O6qyFz8GiEcIIohN+mznpG2EOf2j12MKG7ZYf1Q3VeNv3045azZBvK1WTFQm/NIXXJyhSFx1PKLbNEQgJFvDJGhkZlu7rNi/1FO3VzeCOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D9HgzIVZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C437C4CEE9;
	Tue, 22 Apr 2025 08:01:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745308890;
	bh=V/82unvtAxABgycm+y7kaJ+iuM4jIynRbg8g2O3qJX0=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=D9HgzIVZFMRMC5jYYSGuBhwGezKPcaubMYQmrbAhxuMQT15dwqEXTT+D2cgZ4dwxi
	 g3+YvqW+ErRynrnL9CaEwXNdkpA/0oNxywvcrqQaGCoM3pyOsTeRy/vzMZLhU/A5xJ
	 rxi3Rs8uWTq7kKaNO3V4n9Vc5y6ae2ydf2xPVJs34mdpLvNNBCRlL8g+sK14Yjc+LP
	 z3fCw7XrdwU+IEpsL0WMcpeZc2EhEa0C24/VYq79WRW7QeAeruCAwjGiMqPzc55kRx
	 +A5WJak/9hLd/KRuZfkKQH4d2V/ulHofAQ0+6wQZfwrFVBDfxhRiXlIZ9h+/vlXFVX
	 KeoHpYR5xYXUg==
Message-ID: <aee8924a-d533-4d19-8064-9831e3616013@kernel.org>
Date: Tue, 22 Apr 2025 10:01:24 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/2] rust/revocable: add try_access_with() convenience
 method
From: Danilo Krummrich <dakr@kernel.org>
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Alexandre Courbot <acourbot@nvidia.com>,
 Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>,
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>, Bjorn Helgaas <bhelgaas@google.com>,
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org
References: <20250411-try_with-v4-0-f470ac79e2e2@nvidia.com>
 <Z_kV7U0IcebUfGps@cassiopeiae>
Content-Language: en-US
In-Reply-To: <Z_kV7U0IcebUfGps@cassiopeiae>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/11/25 3:15 PM, Danilo Krummrich wrote:
> On Fri, Apr 11, 2025 at 09:09:37PM +0900, Alexandre Courbot wrote:
>> This is a feature I found useful to have while writing Nova driver code
>> that accessed registers alongside other operations. I would find myself
>> quite confused about whether the guard was held or dropped at a given
>> point of the code, and it felt like walking through a minefield; this
>> pattern makes things safer and easier to read according to my experience
>> writing nova-core code.
> 
> Any concerns taking this through the nova tree?

@Miguel: Can I get an ACK for taking it through the nova tree?

