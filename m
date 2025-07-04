Return-Path: <linux-pci+bounces-31550-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3E1BAF9AC2
	for <lists+linux-pci@lfdr.de>; Fri,  4 Jul 2025 20:29:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2EF82170D75
	for <lists+linux-pci@lfdr.de>; Fri,  4 Jul 2025 18:29:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3BC521767A;
	Fri,  4 Jul 2025 18:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UQmdzP/T"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9671A214A97;
	Fri,  4 Jul 2025 18:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751653761; cv=none; b=qOzgEyj3yxWwang7gWFCbw0AO5fGjGrrqRa120u8R5qhdyRFUxcAFsUN+1/Gs2UchCP8P7TWBtYf+VCUkThJZGXXv4NMW0oM7Tp2VnD6oVVXlFQJVZqZDk8VEbnhFpyflkPxCbBU6i9nP7lznUNdaCgRhmmdp78a2DD5d2ryJDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751653761; c=relaxed/simple;
	bh=YsOYzWfpMlFNmeW5T4HRP9/evn09Fwc1nOBFeBZwXpg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U1THDVgskcK+/o5M+/Y0UVxf++Xz6HCqQJH0wECn1S60UeqXSI6OUAr4KEpsdTocBS2VqN0IX2JF9JjsZVv8vw+8xUFp1qXTlEGmCWDNWs2JpJfXshK9VZfJD8ud+0zUoBZotyCTil7j7L/d0n4YKitJOo+d66B+TUr/4e1TdfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UQmdzP/T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5802DC4CEE3;
	Fri,  4 Jul 2025 18:29:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751653761;
	bh=YsOYzWfpMlFNmeW5T4HRP9/evn09Fwc1nOBFeBZwXpg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UQmdzP/TeLv3WachNY39sVX3AcVcyAupKoiKwscDrN07pMkztgq6UJXM55A7f+fcP
	 uyZU3qU1FDwMb70csPstfxqNG2t6fClAOht1Hy7G8kQQMKN7MKJG4rIIeiez1m/Ig9
	 /SlasFIF/L2MxOzTf0T+pkaud28o5/m4krcohvXwAGu4YNRiqd/41VXRnXgpgKIztk
	 uBqRRG/XfQW8KyeV8Z8uzAhxXvMMfY7iAns7gx62z5EZi6RDWRW5xXAKBLAujl47xs
	 MGBhA9DJUbc6h5vZHYOlPaDW9JjqIcNs7H6LFspnDYkgZw+XMuPRohD4p6O2M3n6Ne
	 sBhInDEtxtPfw==
Date: Fri, 4 Jul 2025 20:29:14 +0200
From: Danilo Krummrich <dakr@kernel.org>
To: Daniel Almeida <daniel.almeida@collabora.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Benno Lossin <lossin@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v6 6/6] rust: pci: add irq accessors
Message-ID: <aGgdelD0srH8twNN@cassiopeiae>
References: <20250703-topics-tyr-request_irq-v6-0-74103bdc7c52@collabora.com>
 <20250703-topics-tyr-request_irq-v6-6-74103bdc7c52@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250703-topics-tyr-request_irq-v6-6-74103bdc7c52@collabora.com>

On Thu, Jul 03, 2025 at 04:30:04PM -0300, Daniel Almeida wrote:
> +    /// Returns an [`IrqRequest`] for the IRQ vector at the given index, if any.
> +    pub fn request_irq_by_index(&self, index: u32) -> Result<IrqRequest<'_>> {

Same comment as for platform:

Please name the functions returning an IrqRequest without the 'request' prefix.
And instead put the 'request' prefix in front of the methods that return a
actual irq::Registration.

Besides that, I think we shouldn't name this method 'by_index'. Please align it
with the C function, i.e. Device::irq_vector().

> +    pub fn irq_by_index<T: crate::irq::Handler + 'static>(

I'd go with just request_irq() for this one and

> +    pub fn threaded_irq_by_index<T: crate::irq::ThreadedHandler + 'static>(

request_threaded_irq() for this one.

