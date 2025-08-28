Return-Path: <linux-pci+bounces-35018-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 98A8DB39F83
	for <lists+linux-pci@lfdr.de>; Thu, 28 Aug 2025 15:59:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4210A3637E7
	for <lists+linux-pci@lfdr.de>; Thu, 28 Aug 2025 13:59:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0525430F817;
	Thu, 28 Aug 2025 13:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hk71lSfC"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC0E830F7EA;
	Thu, 28 Aug 2025 13:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756389555; cv=none; b=IomWvVFFSFFNNgAeVtr1unIic16t1zQaV3bpQuTbT1WLchD7tilOWfa7B16iMVUGYj6WbplLJhg9pIC+BDtaYiGNdFv9uu+pKfNq3CsOY1PIP0YJRKnFJ9C1XEuVkhlKrCNmIgNSKfXu6xOT4rVmvyfgr+DrZspl4dOIzN4mE1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756389555; c=relaxed/simple;
	bh=WEtI0/FN3xpSJ6agHNJuplApkchRGtOGLb1rARd7JN4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gFCnYbwmqjTvxpeYYAYTSUVC2QAVaTeBSAbvb182dmOkG3ZyPxgCANJ005c80CFNjUtxwyyrNOTr7tWUYnylYipQltckN8pXf/MiF5dRuo4OubBvZiSTVNCa6KYhOzwGXoEsb8Mh3aMGt2N1W8bZVfhWONvVPPBWJb1QDCDhmU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hk71lSfC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBDDFC4CEED;
	Thu, 28 Aug 2025 13:59:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756389555;
	bh=WEtI0/FN3xpSJ6agHNJuplApkchRGtOGLb1rARd7JN4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Hk71lSfCh0+8Gp8mDS+rJtbB16TzpROCk59jFIJkk8xGS3HPEjWs7IyU+hvCHsDyX
	 3WXeUuz+1EJlJfLab3Hoz3YfNT7H4smxqUWZEMhb4wkPS8aQlUhYLfVxbKLFQp7Nhw
	 exXrt10hund93QkYlyiCZ6bEK++oMBaRJtZ392vGe7x9IpNoJlbYSH5GTsK4jQ5Owz
	 5GdfouP7S1kClIv/VeZv7H6WCLAa9eAudFg45QTbKm8TBPqUPZkhZpJ0waSFaxGOet
	 RijKqRrBTkbT5vOT8Mp8SDuWvwhxEdPGvthIyALhqiG1yNbtaDZlYn94J8ioQ23jW7
	 jRzI8aXCNxLYg==
Message-ID: <4b525afa-1031-4f99-a1ab-e89af77616eb@kernel.org>
Date: Thu, 28 Aug 2025 15:59:09 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 5/6] rust: pci: use pci::Vendor instead of
 bindings::PCI_VENDOR_ID_*
To: Alexandre Courbot <acourbot@nvidia.com>
Cc: John Hubbard <jhubbard@nvidia.com>, Joel Fernandes
 <joelagnelf@nvidia.com>, Timur Tabi <ttabi@nvidia.com>,
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
From: Danilo Krummrich <dakr@kernel.org>
Content-Language: en-US
In-Reply-To: <DCE3EV79EX7N.DCIT9JWFGXGG@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/28/25 3:25 PM, Alexandre Courbot wrote:
> On Wed Aug 27, 2025 at 8:12 AM JST, John Hubbard wrote:
> <snip>
>> diff --git a/rust/kernel/pci/id.rs b/rust/kernel/pci/id.rs
>> index 4b0ad8d4edc6..fd7a789e3015 100644
>> --- a/rust/kernel/pci/id.rs
>> +++ b/rust/kernel/pci/id.rs
>> @@ -118,15 +118,14 @@ fn try_from(value: u32) -> Result<Self, Self::Error> {
>>   /// ```
>>   /// # use kernel::{device::Core, pci::{self, Vendor}, prelude::*};
>>   /// fn log_device_info(pdev: &pci::Device<Core>) -> Result<()> {
>> -///     // Compare raw vendor ID with known vendor constant
>> -///     let vendor_id = pdev.vendor_id();
>> -///     if vendor_id == Vendor::NVIDIA.as_raw() {
>> -///         dev_info!(
>> -///             pdev.as_ref(),
>> -///             "Found NVIDIA device: 0x{:x}\n",
>> -///             pdev.device_id()
>> -///         );
>> -///     }
>> +///     // Get the validated PCI vendor ID
>> +///     let vendor = pdev.vendor_id();
>> +///     dev_info!(
>> +///         pdev.as_ref(),
>> +///         "Device: Vendor={}, Device=0x{:x}\n",
>> +///         vendor,
>> +///         pdev.device_id()
>> +///     );
> 
> Why not use this new example starting from patch 2, which introduced the
> previous code that this patch removes?

I think that's because in v2 vendor_id() still returns the raw value. I think it
makes a little more sense if this patch simply introduces the example as an
example for vendor_id() itself.

I think struct Vendor does not necessarily need an example by itself.

