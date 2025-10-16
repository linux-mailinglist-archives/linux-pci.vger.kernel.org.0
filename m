Return-Path: <linux-pci+bounces-38380-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 49C45BE4C76
	for <lists+linux-pci@lfdr.de>; Thu, 16 Oct 2025 19:05:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0224189CEDA
	for <lists+linux-pci@lfdr.de>; Thu, 16 Oct 2025 17:06:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4CB621CA13;
	Thu, 16 Oct 2025 17:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="atP3U8RF"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DD621922FB;
	Thu, 16 Oct 2025 17:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760634271; cv=none; b=B5zEsyhjG9hx42orAhuGIYrgbB3CXW8Z9b6vVEpvWT0yt4L9WVUY8gCaLXsOlgGwCUq7lV9EphZioOU7HiSjTW/BibDrIi0Xij2mxD7n3I27Zy8baWF29W/KoIUfy8KtfjO/hXckxPNYWJZa1BKpyxQBtDTo28wwLd73VPUx/jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760634271; c=relaxed/simple;
	bh=EkbCja++TGh/RGY7U9MFZ/ewmSQrL6PS5DCx6Y9h25M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rSQ8XPPGDX/2RN4UsrYvUhAmdylQ7mtAEpvb7rmax+4T7RVl8nxOEp8cb6FAkiySw9akggS6nBlgcFCYgVRXlhs8g499BnFxiKb/52uELp8H+Lk2iWbLy2+l4SwqwYd/iyFsg41tKi+YlmR/yS8lB8qsModQFZPQCoW8Hn3Etyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=atP3U8RF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 480C1C4CEF1;
	Thu, 16 Oct 2025 17:04:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760634271;
	bh=EkbCja++TGh/RGY7U9MFZ/ewmSQrL6PS5DCx6Y9h25M=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=atP3U8RFs0gv5Nu/Lk0Uy3QZQWRJUM/j3qjhzQzQLgj+iR2CVdwizyNaB79sNdgjd
	 FGjpe9ZS5279632kgRWXMW1n9P016Q0DPHb2V87WoQCgK94WSKaeUBqynNOLGssB17
	 xMiTG7ph6Jw1Uy5vnoL8BO+nfZZUajoDpFGrFbGFD1v4HBPRcPfXYoW0sKOPkl2lEB
	 823K0Onk86B9+S/Xe4a+bwTvNoaduM+F5hgq5c/jz9Hg8ASQCrT6bUkr4Dj8HiwAOt
	 fLJDLpO6gGsm3As5rJi89YuGuPkim0GjPyhv0vA9IJGh2gTyBMWll48lPgvYn+Vy3Y
	 ra2da+otRLGLQ==
Message-ID: <16bec003-ca45-4576-9a18-35bfe133c5e3@kernel.org>
Date: Thu, 16 Oct 2025 19:04:26 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] rust: pci: implement TryInto<IrqRequest<'a>> for
 IrqVector<'a>
To: Alice Ryhl <aliceryhl@google.com>
Cc: bhelgaas@google.com, kwilczynski@kernel.org, ojeda@kernel.org,
 alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net,
 bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org,
 tmgross@umich.edu, rust-for-linux@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251015182118.106604-1-dakr@kernel.org>
 <20251015182118.106604-2-dakr@kernel.org> <aPEIxYlh98exA2vn@google.com>
From: Danilo Krummrich <dakr@kernel.org>
Content-Language: en-US
In-Reply-To: <aPEIxYlh98exA2vn@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/16/25 5:01 PM, Alice Ryhl wrote:
> On Wed, Oct 15, 2025 at 08:14:29PM +0200, Danilo Krummrich wrote:
>> @@ -707,12 +705,12 @@ pub fn request_irq<'a, T: crate::irq::Handler + 'static>(
>>      /// Returns a [`kernel::irq::ThreadedRegistration`] for the given IRQ vector.
>>      pub fn request_threaded_irq<'a, T: crate::irq::ThreadedHandler + 'static>(
>>          &'a self,
>> -        vector: IrqVector<'_>,
>> +        vector: IrqVector<'a>,
>>          flags: irq::Flags,
>>          name: &'static CStr,
>>          handler: impl PinInit<T, Error> + 'a,
>>      ) -> Result<impl PinInit<irq::ThreadedRegistration<T>, Error> + 'a> {
>> -        let request = self.irq_vector(vector)?;
>> +        let request = vector.try_into()?;
> 
> The resulting change to the lifetime semantics is curious, but seems
> right.

Yes, IrqVector has to have the same lifetime as &self, but I was surprised that
with this change the compiler does require an explicit lifetime (even though I
think the explicit one is better anyways).
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>


