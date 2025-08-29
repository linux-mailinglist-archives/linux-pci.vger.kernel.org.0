Return-Path: <linux-pci+bounces-35148-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AD9FDB3C44C
	for <lists+linux-pci@lfdr.de>; Fri, 29 Aug 2025 23:46:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 001DC1CC14B3
	for <lists+linux-pci@lfdr.de>; Fri, 29 Aug 2025 21:47:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41502258CE2;
	Fri, 29 Aug 2025 21:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RjlXGPXv"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 115EC18EFD1;
	Fri, 29 Aug 2025 21:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756503997; cv=none; b=HWhdYc7LDJNCcFwquJnVDW8s1i4o9L3PjwRA9ik4y2vxaASM+FoV0s04Mb9pzOCO1VBXANZJmr1E7NHIBoQvOyWszsE3xv4yi1/z9RPiZJBKrZ45tX6bue5SRZSXnWKqEFAyyxlrNOsph1tthdlWB9reJ1FCInkbCuXiQ/bQ37s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756503997; c=relaxed/simple;
	bh=3rY67k6MnCyDXpesTvug9/O8iMMcv+FgZYCMGYyMrQA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bKOktFDoNQ+mnPLef0pWK4VILdV4kq/+wFOmePFDOIT2ocgGG4CtzzuZP8hqptmH35e3ldGSFjnZEJ1T7lWYghqnomEDvbPRJBOb+cQ7Id4T7X56ga5Gq6v9PesFSGHuuzLJF8gBbyq+rIWATNrGfY0S68JgcY1RNM/zwsiCkM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RjlXGPXv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08CF4C4CEF1;
	Fri, 29 Aug 2025 21:46:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756503996;
	bh=3rY67k6MnCyDXpesTvug9/O8iMMcv+FgZYCMGYyMrQA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=RjlXGPXvqrjY9ZCVJNXCCoFXt59IucY4djtBKq+54ySfDXybevK08We6nk0BKIA72
	 zwWKavbHbJGFR4/pqJjS6YrznXgmg7Zj4DsK0L88gbcAPjVLNsOi0WiUulfjbieCzu
	 pSF1DH4C7yqShH/OTu3BXUJo9zCssUlCNeCdu5td6ZIxopM6a8qk5pw2xYtYW225Ms
	 sYoIyji05uqYODiNqmO1PanlsvhuVR2EXJaWu/AxY0a0bpubFL7pCzWGCX7Akpsj7l
	 +jrCPQCXgupoGN1Ao7N4klmRN6grmkJ42r9YWXNk8+vBNmV+F8viMyTqfepQdDRMgc
	 1lI+ygBLQxYeg==
Message-ID: <5fa42689-4f7b-4770-bc44-a4c17d9de79f@kernel.org>
Date: Fri, 29 Aug 2025 23:46:29 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 5/6] rust: pci: use pci::Vendor instead of
 bindings::PCI_VENDOR_ID_*
To: John Hubbard <jhubbard@nvidia.com>
Cc: Alexandre Courbot <acourbot@nvidia.com>,
 Joel Fernandes <joelagnelf@nvidia.com>, Timur Tabi <ttabi@nvidia.com>,
 Alistair Popple <apopple@nvidia.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Bjorn Helgaas <bhelgaas@google.com>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
 nouveau@lists.freedesktop.org, linux-pci@vger.kernel.org,
 rust-for-linux@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 Elle Rhumsaa <elle@weathered-steel.dev>
References: <20250826231224.1241349-1-jhubbard@nvidia.com>
 <20250826231224.1241349-6-jhubbard@nvidia.com>
 <DCE3EV79EX7N.DCIT9JWFGXGG@nvidia.com>
 <4b525afa-1031-4f99-a1ab-e89af77616eb@kernel.org>
 <cd20f283-bd92-47c9-a336-fe9ff46d82ed@nvidia.com>
From: Danilo Krummrich <dakr@kernel.org>
Content-Language: en-US
In-Reply-To: <cd20f283-bd92-47c9-a336-fe9ff46d82ed@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/29/25 11:38 PM, John Hubbard wrote:
> On 8/28/25 6:59 AM, Danilo Krummrich wrote:
>> On 8/28/25 3:25 PM, Alexandre Courbot wrote:
>>> On Wed Aug 27, 2025 at 8:12 AM JST, John Hubbard wrote:
>>> <snip>
>>>> diff --git a/rust/kernel/pci/id.rs b/rust/kernel/pci/id.rs
>>>> index 4b0ad8d4edc6..fd7a789e3015 100644
>>>> --- a/rust/kernel/pci/id.rs
>>>> +++ b/rust/kernel/pci/id.rs
>>>> @@ -118,15 +118,14 @@ fn try_from(value: u32) -> Result<Self, Self::Error> {
>>>>    /// ```
>>>>    /// # use kernel::{device::Core, pci::{self, Vendor}, prelude::*};
>>>>    /// fn log_device_info(pdev: &pci::Device<Core>) -> Result<()> {
>>>> -///     // Compare raw vendor ID with known vendor constant
>>>> -///     let vendor_id = pdev.vendor_id();
>>>> -///     if vendor_id == Vendor::NVIDIA.as_raw() {
>>>> -///         dev_info!(
>>>> -///             pdev.as_ref(),
>>>> -///             "Found NVIDIA device: 0x{:x}\n",
>>>> -///             pdev.device_id()
>>>> -///         );
>>>> -///     }
>>>> +///     // Get the validated PCI vendor ID
>>>> +///     let vendor = pdev.vendor_id();
>>>> +///     dev_info!(
>>>> +///         pdev.as_ref(),
>>>> +///         "Device: Vendor={}, Device=0x{:x}\n",
>>>> +///         vendor,
>>>> +///         pdev.device_id()
>>>> +///     );
>>>
>>> Why not use this new example starting from patch 2, which introduced the
>>> previous code that this patch removes?
>>
>> I think that's because in v2 vendor_id() still returns the raw value. I think it
> 
> That is correct.
> 
>> makes a little more sense if this patch simply introduces the example as an
>> example for vendor_id() itself.
>>
>> I think struct Vendor does not necessarily need an example by itself.
> 
> I'm not quite sure if you are asking for a change to this patch? The
> example already exercises .vendor_id(), so...?

Yes, I think the example above should be on the vendor_id() method rather than
on the Vendor struct and should be introduced by this patch.

