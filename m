Return-Path: <linux-pci+bounces-20644-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 84169A2505D
	for <lists+linux-pci@lfdr.de>; Sun,  2 Feb 2025 23:42:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BF673A3AC5
	for <lists+linux-pci@lfdr.de>; Sun,  2 Feb 2025 22:42:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B4C72147F1;
	Sun,  2 Feb 2025 22:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asahilina.net header.i=@asahilina.net header.b="WQ3Ic9mU"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60E8E1F55EB;
	Sun,  2 Feb 2025 22:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.63.210.85
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738536151; cv=none; b=f+xpg4mId60NVJl+z9XBMoRC9BONBHf55ZyK8lkxXMa0QdcOz9le/gOmXFTBwBOoCmHINoZLbwFvJtX57R1KbAbgPsVtxqi4yVP2S7G04M9WTYxM9A/3kE7LctBBUIIzs49O3UFjRKTpQaveC/4LiPFycf4dW4BM81MCHbpUb0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738536151; c=relaxed/simple;
	bh=qSNoil9KM8+5HeFGOJ9HYPvfydxNnPOxjUHmJ65r2fY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a6HN/RK346qrYGmugDT25d4Jnj2/yRwLBkGucaClzVZPXyN0v8mt7TTTZBLlLIFjdIomzD9pF3KABv4XqAX8m6x6i2O8jskPlRZnxC9BYaZmk/rCVuzkIPOuYDVVigOZes+9fNJ1TpI24+mbZEgX4MZrhns00qfPRp6eqKfzfv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=asahilina.net; spf=pass smtp.mailfrom=asahilina.net; dkim=pass (2048-bit key) header.d=asahilina.net header.i=@asahilina.net header.b=WQ3Ic9mU; arc=none smtp.client-ip=212.63.210.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=asahilina.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asahilina.net
Received: from [127.0.0.1] (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: lina@asahilina.net)
	by mail.marcansoft.com (Postfix) with ESMTPSA id 42AE842657;
	Sun,  2 Feb 2025 22:42:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=asahilina.net;
	s=default; t=1738536144;
	bh=qSNoil9KM8+5HeFGOJ9HYPvfydxNnPOxjUHmJ65r2fY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=WQ3Ic9mURPvoG/AaMLD4RQFLDALdZS6SmEi8tZsq7afD8QWjRbVsHhy16voA/pgcJ
	 UpCtZ1Ylf/u1RBjNVp2lBrZnof0QQLwrSYasU/HZGVWnhf89kMtHcyGghaI8PK9Pb3
	 L2fxM+EFZ+Kqwo+d9apSDjkSSP9aret6Adr94Pve4pj8vNqBMGTNLZtn/1u46EZVAw
	 TUr2GKM9N4X1/eq0FBfrnYmCpaii1RO5S0vgkqDNCzlsetw4/vYGic/XWb4YOW8pWu
	 S/YnPf3Nop1drymu6x3HoE0gXippHt1N6T5sdw3iujG95+Zy29SQtY7S7Jt08Lsx1J
	 YxImPiSOaPmTw==
Message-ID: <e271d8a1-493d-40b4-8328-2146eef26d0d@asahilina.net>
Date: Mon, 3 Feb 2025 07:42:19 +0900
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 07/16] rust: add `io::{Io, IoRaw}` base types
To: Danilo Krummrich <dakr@kernel.org>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, bhelgaas@google.com,
 ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com,
 gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me,
 tmgross@umich.edu, a.hindborg@samsung.com, aliceryhl@google.com,
 airlied@gmail.com, fujita.tomonori@gmail.com, pstanner@redhat.com,
 ajanulgu@redhat.com, lyude@redhat.com, robh@kernel.org,
 daniel.almeida@collabora.com, saravanak@google.com, dirk.behme@de.bosch.com,
 j@jannau.net, fabien.parent@linaro.org, chrisi.schrefl@gmail.com,
 paulmck@kernel.org, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 devicetree@vger.kernel.org, rcu@vger.kernel.org
References: <20241212163357.35934-1-dakr@kernel.org>
 <20241212163357.35934-8-dakr@kernel.org> <Z2BTSbOjWa8R29i5@cassiopeiae>
 <e8da15f0-5b97-4569-842c-891cdf886978@asahilina.net>
 <Z5_vlx1BZuJGOvK7@pollux>
Content-Language: en-US
From: Asahi Lina <lina@asahilina.net>
In-Reply-To: <Z5_vlx1BZuJGOvK7@pollux>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/3/25 7:20 AM, Danilo Krummrich wrote:
> Hi Lina,
> 
> On Mon, Feb 03, 2025 at 06:19:57AM +0900, Asahi Lina wrote:
> 
>>
>>
>> On 12/17/24 1:20 AM, Danilo Krummrich wrote:
>>> On Thu, Dec 12, 2024 at 05:33:38PM +0100, Danilo Krummrich wrote:
>>>> +/// IO-mapped memory, starting at the base address @addr and spanning @maxlen bytes.
>>>> +///
>>>> +/// The creator (usually a subsystem / bus such as PCI) is responsible for creating the
>>>> +/// mapping, performing an additional region request etc.
>>>> +///
>>>> +/// # Invariant
>>>> +///
>>>> +/// `addr` is the start and `maxsize` the length of valid I/O mapped memory region of size
>>>> +/// `maxsize`.
>>>> +///
>>>> +/// # Examples
>>>> +///
>>>> +/// ```no_run
>>>> +/// # use kernel::{bindings, io::{Io, IoRaw}};
>>>> +/// # use core::ops::Deref;
>>>> +///
>>>> +/// // See also [`pci::Bar`] for a real example.
>>>> +/// struct IoMem<const SIZE: usize>(IoRaw<SIZE>);
>>>> +///
>>>> +/// impl<const SIZE: usize> IoMem<SIZE> {
>>>> +///     /// # Safety
>>>> +///     ///
>>>> +///     /// [`paddr`, `paddr` + `SIZE`) must be a valid MMIO region that is mappable into the CPUs
>>>> +///     /// virtual address space.
>>>> +///     unsafe fn new(paddr: usize) -> Result<Self>{
>>>> +///         // SAFETY: By the safety requirements of this function [`paddr`, `paddr` + `SIZE`) is
>>>> +///         // valid for `ioremap`.
>>>> +///         let addr = unsafe { bindings::ioremap(paddr as _, SIZE.try_into().unwrap()) };
>>
>> This is a problematic API. ioremap() does not work on some platforms
>> like Apple Silicon. Instead, you have to use ioremap_np() for most devices.
>>
>> Please add a bindings::resource abstraction and use that to construct
>> IoMem. Then, you can check the flags for
>> bindings::IORESOURCE_MEM_NONPOSTED and use the appropriate function,
>> like this:
> 
> This is just a very simplified example of how to use `IoRaw` and `Io` base
> types in the scope of an example section within a doc-comment.
> 
> There is an actual `IoMem` implementation including a struct resource
> abstraction [1] from Daniel though. Maybe you want to have a look at this
> instead.
> 
> [1] https://lore.kernel.org/rust-for-linux/20250130220529.665896-1-daniel.almeida@collabora.com/
> 

That's what I get for skimming too much... I thought this had the actual
implementation. Sorry!

>>
>> https://github.com/AsahiLinux/linux/blob/fce34c83f1dca5b10cc2c866fd8832a362de7974/rust/kernel/io_mem.rs#L152
>>
>>
>>>> +///         if addr.is_null() {
>>>> +///             return Err(ENOMEM);
>>>> +///         }
>>>> +///
>>>> +///         Ok(IoMem(IoRaw::new(addr as _, SIZE)?))
>>>> +///     }
>>>> +/// }
>>>> +///
>>>> +/// impl<const SIZE: usize> Drop for IoMem<SIZE> {
>>>> +///     fn drop(&mut self) {
>>>> +///         // SAFETY: `self.0.addr()` is guaranteed to be properly mapped by `Self::new`.
>>>> +///         unsafe { bindings::iounmap(self.0.addr() as _); };
>>>> +///     }
>>>> +/// }
>>>> +///
>>>> +/// impl<const SIZE: usize> Deref for IoMem<SIZE> {
>>>> +///    type Target = Io<SIZE>;
>>>> +///
>>>> +///    fn deref(&self) -> &Self::Target {
>>>> +///         // SAFETY: The memory range stored in `self` has been properly mapped in `Self::new`.
>>>> +///         unsafe { Io::from_raw(&self.0) }
>>>> +///    }
>>>> +/// }
>>>> +///
>>>> +///# fn no_run() -> Result<(), Error> {
>>>> +/// // SAFETY: Invalid usage for example purposes.
>>>> +/// let iomem = unsafe { IoMem::<{ core::mem::size_of::<u32>() }>::new(0xBAAAAAAD)? };
>>>> +/// iomem.writel(0x42, 0x0);
>>>> +/// assert!(iomem.try_writel(0x42, 0x0).is_ok());
>>>> +/// assert!(iomem.try_writel(0x42, 0x4).is_err());
>>>> +/// # Ok(())
>>>> +/// # }
>>>> +/// ```
>>>> +#[repr(transparent)]
>>>> +pub struct Io<const SIZE: usize = 0>(IoRaw<SIZE>);
> 

~~ Lina


