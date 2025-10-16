Return-Path: <linux-pci+bounces-38406-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F3D66BE5BD6
	for <lists+linux-pci@lfdr.de>; Fri, 17 Oct 2025 00:57:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 750B319C00FF
	for <lists+linux-pci@lfdr.de>; Thu, 16 Oct 2025 22:58:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF6222E1F0D;
	Thu, 16 Oct 2025 22:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b5cd1znO"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2ECB49659;
	Thu, 16 Oct 2025 22:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760655467; cv=none; b=h5BEAmo9IVs2p7SLPeV6m6PdD0JiLM3+2aQvQ/9AQDQbsTx095NSthVi9FZ3K1Zao2OM7mrMZ3bt/FvfULQ/s8m57WJX07eUmz2EZ75OGq1RyNBpas45/lrJwRN5nxXFloNuvqbLMXxEf9daBSyyyDO2+QripUXv5NNnHDHZmM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760655467; c=relaxed/simple;
	bh=qxYdrK046z63gbrSUliCKLEJBOxAeeHOt0UZNNP8L20=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=BGr2kr6kSEpd7UBXLWOamdSyOoiBpfik8I7F7Uj1M+WBC7w6eJzUdEFw0M9kmyuKLACKR/a6QTqGXNQisKTNhIC0jzsrND0zpSxbgnZALbYPHIEGKchf4yE3ocJOf8sAQUF1JPu4xpQcNtnYI+xzOOpTzfv9XDu41hbOF69kH3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b5cd1znO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CE19C4CEF1;
	Thu, 16 Oct 2025 22:57:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760655467;
	bh=qxYdrK046z63gbrSUliCKLEJBOxAeeHOt0UZNNP8L20=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=b5cd1znOVvrQpkIa99s4hOtwnkTdIBI+AVI+dHmfg4Tj9wXSlcpP4EK06XX0byBdp
	 THTDEGYN77/ky6tpzFUYwcmTN2VFwtQNi8QXUMpx4c06wzt84cN9JQxBT5SwCmnubd
	 lMhopoJRhXG/V2bW3HtWzpv2Ii0t/h6sFuDUn5XSeHncdwhohL3OJNFo8DAMVTrtue
	 RE92YAVcc3yGBPi/eQzTEDU88DexiifQWQWJ+DrKDutp0h8B+UiJQtqpfkSXpQsKHU
	 g8g9MD7TLCvsCA9yCB7QdP+zBo64ojjJ8WrNCy/XynEFwe6UrKmn00FvMUiZHLMVNQ
	 1F04FrIVMImjQ==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 17 Oct 2025 00:57:42 +0200
Message-Id: <DDK49THLLA3Y.242R8EP6IDZJ3@kernel.org>
Subject: Re: [PATCH 1/3] rust: pci: implement TryInto<IrqRequest<'a>> for
 IrqVector<'a>
Cc: <bhelgaas@google.com>, <kwilczynski@kernel.org>, <ojeda@kernel.org>,
 <alex.gaynor@gmail.com>, <boqun.feng@gmail.com>, <gary@garyguo.net>,
 <bjorn3_gh@protonmail.com>, <lossin@kernel.org>, <a.hindborg@kernel.org>,
 <aliceryhl@google.com>, <tmgross@umich.edu>,
 <rust-for-linux@vger.kernel.org>, <linux-pci@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
To: "Joel Fernandes" <joelagnelf@nvidia.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20251015182118.106604-1-dakr@kernel.org>
 <20251015182118.106604-2-dakr@kernel.org>
 <20251016222420.GA1480061@joelbox2>
In-Reply-To: <20251016222420.GA1480061@joelbox2>

On Fri Oct 17, 2025 at 12:24 AM CEST, Joel Fernandes wrote:
> On Wed, Oct 15, 2025 at 08:14:29PM +0200, Danilo Krummrich wrote:
>> Implement TryInto<IrqRequest<'a>> for IrqVector<'a> to directly convert
>> a pci::IrqVector into a generic IrqRequest, instead of taking the
>> indirection via an unrelated pci::Device method.
>>=20
>> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
>> ---
>>  rust/kernel/pci.rs | 38 ++++++++++++++++++--------------------
>>  1 file changed, 18 insertions(+), 20 deletions(-)
>>=20
>> diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
>> index d91ec9f008ae..c6b750047b2e 100644
>> --- a/rust/kernel/pci.rs
>> +++ b/rust/kernel/pci.rs
>> @@ -596,6 +596,20 @@ fn index(&self) -> u32 {
>>      }
>>  }
>> =20
>> +impl<'a> TryInto<IrqRequest<'a>> for IrqVector<'a> {
>> +    type Error =3D Error;
>> +
>> +    fn try_into(self) -> Result<IrqRequest<'a>> {
>> +        // SAFETY: `self.as_raw` returns a valid pointer to a `struct p=
ci_dev`.
>> +        let irq =3D unsafe { bindings::pci_irq_vector(self.dev.as_raw()=
, self.index()) };
>> +        if irq < 0 {
>> +            return Err(crate::error::Error::from_errno(irq));
>> +        }
>> +        // SAFETY: `irq` is guaranteed to be a valid IRQ number for `&s=
elf`.
>> +        Ok(unsafe { IrqRequest::new(self.dev.as_ref(), irq as u32) })
>> +    }
>> +}A
>
>
> Nice change, looks good to me but I do feel it is odd to 'convert' an
> IrqVector directly into a IrqRequest using TryInto (one is a device-relat=
ive
> vector index and the other holds the notion of an IRQ request).
>
> Instead, we should convert IrqVector into something like LinuxIrqNumber
> (using TryInto) because we're converting one number to another, and then =
pass
> that to a separate function to create the IrqRequest.

Well, IrqRequest is exactly that, a representation of an IRQ number. So, th=
is is
already doing exactly that, converting one number to another:

	pub struct IrqRequest<'a> {
	    dev: &'a Device<Bound>,
	    irq: u32,
	}

(The reason this is called IrqRequest instead of IrqNumber is that the numb=
er is
an irrelevant implementation detail of how an IRQ is requested.)

	pub struct IrqVector<'a> {
	    dev: &'a Device<Bound>,
	    index: u32,
	}

So, what happens here is that we convert the vector index from IrqVector in=
to
the irq number in IrqRequest.

> Or we can do both in a
> vector.make_request() function (which is basically this patch but not usi=
ng
> TryInto).

See above, there is no "both", it's the same thing. :)

Regarding make_request() vs. TryInto, I think TryInto is the idiomatic thin=
g to
do here: Both structures have the same layout, as in they both carry the
&Device<Bound> reference the corresponding number belongs to, plus the numb=
er
itself; the device reference is taken over, the number is converted.

> Actually even my original code had this oddity:
> The function irq_vector should have been called irq_request or something =
but
> instead was:
> pub fn irq_vector(&self, vector: IrqVector<'_>) -> Result<IrqRequest<'_>>
>
> I think we can incrementally improve this though, so LGTM.
>
> Reviewed-by: Joel Fernandes <joelagnelf@nvidia.com>

