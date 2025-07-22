Return-Path: <linux-pci+bounces-32714-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41AB0B0D7A4
	for <lists+linux-pci@lfdr.de>; Tue, 22 Jul 2025 13:02:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 772F7547138
	for <lists+linux-pci@lfdr.de>; Tue, 22 Jul 2025 11:02:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 545C5288CA2;
	Tue, 22 Jul 2025 11:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H9Ks5c2R"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ECB1242914;
	Tue, 22 Jul 2025 11:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753182174; cv=none; b=NNeElrQSEGjDJKb/tviRh9ocOIbt6dGGc78O8os8b1YKch4QpXeJ3SD1r9c0E20krRsK74x1+dizTg6nDv4+wi+WnBLfEX4dggseOxKsib0/6FEsjvYKIOLAJMfhYCgOpU7SaoY3+uchOv6OjMHAomU/Dh/0bwYnciBPmlZP3Fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753182174; c=relaxed/simple;
	bh=g77nOjhF39d0hWS6dcCWWmDVOPoN5zX71R8a89P/bzo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VplzdMYCEhbjddYA7WsJlHdWx2JYnBg6XzEgr9yTCT56T89+RA4wp2rBetRq7ZFMNRpt55BFt9PaEaU+2U8qLsOhN7m31SKIxumTvrCivfHgQuo3F1UAxtTH73EuQtZAMPUFQPDeFPBqk1GQHxR+Vf+D2MKQ09Hlv3eWsAy6IB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H9Ks5c2R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01152C4CEEB;
	Tue, 22 Jul 2025 11:02:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753182173;
	bh=g77nOjhF39d0hWS6dcCWWmDVOPoN5zX71R8a89P/bzo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=H9Ks5c2RKRdF1/bhzF/09U8r8HMi+aurj4hC8rOkHhRpj/3fPiM1uCMKBA/ESV8ro
	 oeNoXb1HBDINTxrERWhzE+w+hDqD+N/f5A3HFKkr/S7uzejCRUJ/oHtNh73uwkFS98
	 L2H01fli/nW8oJLu0RrTQSO/0kWOl2iw5AjLV6rjnLY51jMEJgKJY43cJEaI73v3m5
	 LDWV6laV371RLCpRagFZ0MiQ3R3JbUrbJWN0J1W8hNbxfNhhdgws3asgEZn40/mEOs
	 8e2R+eE5ClYVpA1KAhhxG4gYeGd4lX87ba18GrohFLHDeR+lEzug9dd8LNrSJC/pWX
	 H9sFnuvjgcPHA==
Message-ID: <be42295e-63e1-4e2f-986f-aef962f531bd@kernel.org>
Date: Tue, 22 Jul 2025 13:02:48 +0200
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
From: Danilo Krummrich <dakr@kernel.org>
Content-Language: en-US
In-Reply-To: <DBIJ3POBANNM.KSO1I5557PFV@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/22/25 12:57 PM, Benno Lossin wrote:
> On Tue Jul 22, 2025 at 11:51 AM CEST, Danilo Krummrich wrote:
>> I think they're good, but we're pretty late in the cycle now. That should be
>> fine though, we can probably take them through the nova tree, or in the worst
>> case share a tag, if needed.
>>
>> Given that, it would probably be good to add the Guarantee section on as_raw(),
>> as proposed by Benno, right away.
>>
>> @Benno: Any proposal on what this section should say?
> 
> At a minimum I'd say "The returned pointer is valid.", but that doesn't
> really say for what it's valid... AFAIK you're mostly using this pointer
> to pass it to the C side, in that case, how about:

It is used for for FFI calls and to access fields of the underlying
struct pci_dev.

>      /// # Guarantees
>      ///
>      /// The returned pointer is valid for reads and writes from the C side for as long as `self` exists.
> 
> Maybe we need to change it a bit more, but let's just start with this.

