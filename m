Return-Path: <linux-pci+bounces-20141-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A7787A16C97
	for <lists+linux-pci@lfdr.de>; Mon, 20 Jan 2025 13:55:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 497603A8F47
	for <lists+linux-pci@lfdr.de>; Mon, 20 Jan 2025 12:54:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E5951E0DCA;
	Mon, 20 Jan 2025 12:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KC4zcVWz"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FDE21E0DBB;
	Mon, 20 Jan 2025 12:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737377686; cv=none; b=tVUmKBBlVAe29J5es+urs9dNv8ODGEGCYcN6FQiw0V3E+en0Mh18YBxjqXNQtaZ7ctuBQFgLtH7zdovlcRNcCvMo7oodd8WjmL5ow6w4BEbsYuZFkC+bLz9jzu/nqW46e976YA9INrU8Xl+8rQf7K9lckSor+/xsOLhCWyLisB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737377686; c=relaxed/simple;
	bh=B2N1SFwVsEQYatPuKELn1U8mVUiNoyniinMvW+x3hug=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uh5iROfcEeAEu3+UEooHPOGAg8g38w1GzmlooFS3dQFHieVINZRCoXbpu3GhZxHoQ8Oyzw9OlGujDBP+iXZoLLaIhA1d+VtGbq5CsbDML7kTNrTGD97AODKuJGk6B81GaM/tJR8d0B0OeaWXHcuXLLs4oaNPJjrt1ebvZr1/50w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KC4zcVWz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BE3BC4CEDD;
	Mon, 20 Jan 2025 12:54:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737377685;
	bh=B2N1SFwVsEQYatPuKELn1U8mVUiNoyniinMvW+x3hug=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=KC4zcVWzCkcet8ukVMFl5FCSZWYhPzxuDYOySL4ini71VGGjUCBb3JbzvyLj4c4GB
	 WSnNAJ7Xjc9pW0V2EJGaHLGPdIpVMmfnO9j/fTVCf0N2pvdRwC0jkldUc5o7tS/fJb
	 TUaKeP4sX8Oa4nd5Vj/IFvpFZWDz0ZKwzjeuJG9icYV4Xa7A4wL1TmdswCMcnsJ6vI
	 F7zMx8JuJ/x3am8PqEFhFfML7Cn6yTp7IGZG0ehTr9CfOxPkJAXmGM2Muw5Smu3cYN
	 pE6QSyf8c3tqqA5Z+puQzlUKT1Ziizw3xuWSzynMe5mcSe2H8vW1UX4NzCLS5dtIBQ
	 gtuSDDBuEQiQA==
Message-ID: <1fef097c-d2d8-4d98-ab83-09ad5ae0b2e1@kernel.org>
Date: Mon, 20 Jan 2025 13:54:37 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 07/16] rust: add `io::{Io, IoRaw}` base types
To: Fiona Behrens <me@kloenk.dev>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, bhelgaas@google.com,
 ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com,
 gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me,
 tmgross@umich.edu, a.hindborg@samsung.com, aliceryhl@google.com,
 airlied@gmail.com, fujita.tomonori@gmail.com, lina@asahilina.net,
 pstanner@redhat.com, ajanulgu@redhat.com, lyude@redhat.com, robh@kernel.org,
 daniel.almeida@collabora.com, saravanak@google.com, dirk.behme@de.bosch.com,
 j@jannau.net, fabien.parent@linaro.org, chrisi.schrefl@gmail.com,
 paulmck@kernel.org, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 devicetree@vger.kernel.org, rcu@vger.kernel.org
References: <20241219170425.12036-1-dakr@kernel.org>
 <20241219170425.12036-8-dakr@kernel.org>
 <723737D3-3102-440F-99E7-6CA78692CC7F@kloenk.dev>
From: Danilo Krummrich <dakr@kernel.org>
Content-Language: en-US
In-Reply-To: <723737D3-3102-440F-99E7-6CA78692CC7F@kloenk.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 1/16/25 11:31 AM, Fiona Behrens wrote:
> On 19 Dec 2024, at 18:04, Danilo Krummrich wrote:

>> +impl<const SIZE: usize> Io<SIZE> {
>> +    /// Converts an `IoRaw` into an `Io` instance, providing the accessors to the MMIO mapping.
>> +    ///
>> +    /// # Safety
>> +    ///
>> +    /// Callers must ensure that `addr` is the start of a valid I/O mapped memory region of size
>> +    /// `maxsize`.
>> +    pub unsafe fn from_raw(raw: &IoRaw<SIZE>) -> &Self {
>> +        // SAFETY: `Io` is a transparent wrapper around `IoRaw`.
>> +        unsafe { &*core::ptr::from_ref(raw).cast() }
>> +    }
>> +
>> +    /// Returns the base address of this mapping.
>> +    #[inline]
>> +    pub fn addr(&self) -> usize {
>> +        self.0.addr()
>> +    }
>> +
>> +    /// Returns the maximum size of this mapping.
>> +    #[inline]
>> +    pub fn maxsize(&self) -> usize {
>> +        self.0.maxsize()
>> +    }
>> +
>> +    #[inline]
>> +    const fn offset_valid<U>(offset: usize, size: usize) -> bool {
>> +        let type_size = core::mem::size_of::<U>();
>> +        if let Some(end) = offset.checked_add(type_size) {
>> +            end <= size && offset % type_size == 0
>> +        } else {
>> +            false
>> +        }
>> +    }
>> +
>> +    #[inline]
>> +    fn io_addr<U>(&self, offset: usize) -> Result<usize> {
>> +        if !Self::offset_valid::<U>(offset, self.maxsize()) {
>> +            return Err(EINVAL);
>> +        }
>> +
>> +        // Probably no need to check, since the safety requirements of `Self::new` guarantee that
>> +        // this can't overflow.
>> +        self.addr().checked_add(offset).ok_or(EINVAL)
>> +    }
>> +
>> +    #[inline]
>> +    fn io_addr_assert<U>(&self, offset: usize) -> usize {
>> +        build_assert!(Self::offset_valid::<U>(offset, SIZE));
>> +
>> +        self.addr() + offset
>> +    }
> 
> Currently reworking the portmem abstractions I wrote for the LED/SE10 driver.
> Right now I’m wondering if it would make sense to move the 3 functions above (`offset_valid`, `io_addr` and `io_addr_assert` into IoRaw),
> as I’m considering reusing the IoRaw in the portmem and then just offer the outb/outw/outl functions on a wraping type around IoRaw.
> For this I would also use the same functions to check bounds.

Sure, feel free to move them. I think I should have moved those functions to
IoRaw from the get-go.

- Danilo

