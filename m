Return-Path: <linux-pci+bounces-30955-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23F9CAEBF85
	for <lists+linux-pci@lfdr.de>; Fri, 27 Jun 2025 21:14:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64F8756579D
	for <lists+linux-pci@lfdr.de>; Fri, 27 Jun 2025 19:14:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8903207A22;
	Fri, 27 Jun 2025 19:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BTrBi/jm"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACB2D20A5C4;
	Fri, 27 Jun 2025 19:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751051673; cv=none; b=kBRXZRnj3VqN0yxG32+4IF6G6LXFivHar9p7T2QrG4wv4sKgSROVhsjhTcbTJp69s6W4+SKRXfNkAYrDn+b/YgGavlVjna1lCWwW3FjQQCt6Zk7HZNI7RZe2I78xdZVBMcJps1mPeBTfy0xYYNZ4rX6Yse3GVUVDCKRXnQ2w7TE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751051673; c=relaxed/simple;
	bh=7y1ZsRmXi5fixd3yGounAXlhvtOObOS1/eW6qryxfFc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CBxL5EDd7yIhtDhzq57cX7EiE0PI1x8+O40wTVc3Y1UC0HQI/LlBxwUUfCWPlCZBe+cRV+jwrBrmqdQOuXRAo0y8lCNNlAYZN0Bl9Q6rwWtxCo+8eCkwBYjkVzoJlWI8VzliqCuwG2+DtaHir1kCurnzrTvdDLRahP5FNc7aPxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BTrBi/jm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 490B6C4CEEB;
	Fri, 27 Jun 2025 19:14:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751051673;
	bh=7y1ZsRmXi5fixd3yGounAXlhvtOObOS1/eW6qryxfFc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BTrBi/jmYNPasQFvmjw61npscaZxr3dckWRLmO9NM8hhIEwWDKBhUKXsi13Xs9yvx
	 SgwEazEzPozrouuUP0TCbZSTJJWqNQ6kAHqX8XmYlu5F0yPlxf0dhwDTZdIOM6AHTk
	 IpJuAgefP5L8EyZAP7bamFTWc5A81hKKO5NDPxk0Ka4+pucTdGHp++XVNUU+ljQUai
	 YZgnKyGyEw6BVX2TWT+XutWKV7hVd4YxtH67AZPGW9oJ+qVaBnT3X+TJQM7ibBm5MO
	 Yb+EKF7cT0nAN7XVs1kUqJEgpSuoZZdkbZTxhKMrZyetgKdnpIuT2kH9IiDGYM/aVR
	 TwID+nxa+rmLQ==
Date: Fri, 27 Jun 2025 21:14:26 +0200
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
Subject: Re: [PATCH v5 5/6] rust: platform: add irq accessors
Message-ID: <aF7tknVzLbdN71kw@pollux>
References: <20250627-topics-tyr-request_irq-v5-0-0545ee4dadf6@collabora.com>
 <20250627-topics-tyr-request_irq-v5-5-0545ee4dadf6@collabora.com>
 <aF7slhheVOXaGB9T@pollux>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aF7slhheVOXaGB9T@pollux>

On Fri, Jun 27, 2025 at 09:10:22PM +0200, Danilo Krummrich wrote:
> On Fri, Jun 27, 2025 at 01:21:07PM -0300, Daniel Almeida wrote:
> > +macro_rules! define_irq_accessor_by_index {
> > +    ($(#[$meta:meta])* $fn_name:ident, $request_fn:ident, $reg_type:ident, $handler_trait:ident) => {
> > +        $(#[$meta])*
> > +        pub fn $fn_name<T: irq::$handler_trait + 'static>(
> > +            &self,
> > +            index: u32,
> > +            flags: irq::flags::Flags,
> > +            name: &'static CStr,
> > +            handler: T,
> > +        ) -> Result<impl PinInit<irq::$reg_type<T>, Error> + '_> {
> > +            let request = self.$request_fn(index)?;
> > +
> > +            Ok(irq::$reg_type::<T>::new(
> > +                request,
> > +                flags,
> > +                name,
> > +                handler,
> > +            ))
> > +        }
> > +    };
> > +}
> > +
> > +macro_rules! define_irq_accessor_by_name {
> > +    ($(#[$meta:meta])* $fn_name:ident, $request_fn:ident, $reg_type:ident, $handler_trait:ident) => {
> > +        $(#[$meta])*
> > +        pub fn $fn_name<T: irq::$handler_trait + 'static>(
> > +            &self,
> > +            irq_name: &'static CStr,
> > +            name: &'static CStr,
> > +            flags: irq::flags::Flags,
> > +            handler: T,
> > +        ) -> Result<impl PinInit<irq::$reg_type<T>, Error> + '_> {
> > +            let request = self.$request_fn(irq_name)?;
> > +
> > +            Ok(irq::$reg_type::<T>::new(
> > +                request,
> > +                flags,
> > +                name,
> > +                handler,
> > +            ))
> > +        }
> > +    };
> > +}
> 
> NIT: Please make the order of name and flags the same for both macros.

Ideally, first flags, then name, since this is the order used everywhere else.

