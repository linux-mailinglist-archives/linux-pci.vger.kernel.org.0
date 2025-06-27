Return-Path: <linux-pci+bounces-30953-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A4FCAEBF72
	for <lists+linux-pci@lfdr.de>; Fri, 27 Jun 2025 21:10:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A97F21719C8
	for <lists+linux-pci@lfdr.de>; Fri, 27 Jun 2025 19:10:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64BE91FF7B4;
	Fri, 27 Jun 2025 19:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X2UBa0m7"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 392A31B423C;
	Fri, 27 Jun 2025 19:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751051423; cv=none; b=MT8z1Jv8XK7Dtrs8VXG5Wu6UmPGV6YFicLKVsatV7cj7AmgnSctiihQeou9Rqrd+tnJ/+S8X0PmC12aM4/mvhcBoxhdNXaTBcRoSYNg6iqWC6qI066WWXxAFskrHBBZialFWP4bfPlN2JdDk37bZpODS7PxL5gpBQDg1Nj7VYIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751051423; c=relaxed/simple;
	bh=zX3NmrA+sBHyFFa22AKtA6yA3y98WyDwudTRj5xeJKE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iO025SyUvhTL4qyQ+u6EOyjq3cmseThgPfoC3GorebA7FdP1YRrtnNJD1Kgqwo2au3HKZ3ooF4n3mmpKuCEoLEnn0wIiEg34HFDzYyfnvQo+wfuse21w5Hs/oVIeyhLcby5becLPkO5OMSxvqlWV3eKjLdpHeNKFvYgETNkDKGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X2UBa0m7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99647C4CEEB;
	Fri, 27 Jun 2025 19:10:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751051422;
	bh=zX3NmrA+sBHyFFa22AKtA6yA3y98WyDwudTRj5xeJKE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=X2UBa0m716Nxz46zUZMMU6MzN7Z18nE2RCdmEtbKFJ9PTgigoYsIWRjX4ngDpvCll
	 F45snIb6EOBjAMXfXtrxDeAlK25ijB87lMq63g8SXrGvaldQM9uzLlR0Yj0MTYsIl5
	 mbMOpsFphlWy+AUOQpLVXRGqXyCVk3ZD2D2cZsw64AQLetjWHdlHoRmYsYP8o/IXS+
	 fe0NcVvGGDDFonlPoHHOGabX7iBblz9HB0/ILHlnxL1HhO040Hd4wIntxxj9Pfg8W2
	 jDbtGmx0QMtwOaGvcYTHNOp0+nto6MBI58mh4qC2FfTJGNdZ1ylr+KmPwL9vblw6QT
	 gd5AvyGd5d4lA==
Date: Fri, 27 Jun 2025 21:10:14 +0200
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
Message-ID: <aF7slhheVOXaGB9T@pollux>
References: <20250627-topics-tyr-request_irq-v5-0-0545ee4dadf6@collabora.com>
 <20250627-topics-tyr-request_irq-v5-5-0545ee4dadf6@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250627-topics-tyr-request_irq-v5-5-0545ee4dadf6@collabora.com>

On Fri, Jun 27, 2025 at 01:21:07PM -0300, Daniel Almeida wrote:
> +macro_rules! define_irq_accessor_by_index {
> +    ($(#[$meta:meta])* $fn_name:ident, $request_fn:ident, $reg_type:ident, $handler_trait:ident) => {
> +        $(#[$meta])*
> +        pub fn $fn_name<T: irq::$handler_trait + 'static>(
> +            &self,
> +            index: u32,
> +            flags: irq::flags::Flags,
> +            name: &'static CStr,
> +            handler: T,
> +        ) -> Result<impl PinInit<irq::$reg_type<T>, Error> + '_> {
> +            let request = self.$request_fn(index)?;
> +
> +            Ok(irq::$reg_type::<T>::new(
> +                request,
> +                flags,
> +                name,
> +                handler,
> +            ))
> +        }
> +    };
> +}
> +
> +macro_rules! define_irq_accessor_by_name {
> +    ($(#[$meta:meta])* $fn_name:ident, $request_fn:ident, $reg_type:ident, $handler_trait:ident) => {
> +        $(#[$meta])*
> +        pub fn $fn_name<T: irq::$handler_trait + 'static>(
> +            &self,
> +            irq_name: &'static CStr,
> +            name: &'static CStr,
> +            flags: irq::flags::Flags,
> +            handler: T,
> +        ) -> Result<impl PinInit<irq::$reg_type<T>, Error> + '_> {
> +            let request = self.$request_fn(irq_name)?;
> +
> +            Ok(irq::$reg_type::<T>::new(
> +                request,
> +                flags,
> +                name,
> +                handler,
> +            ))
> +        }
> +    };
> +}

NIT: Please make the order of name and flags the same for both macros.

