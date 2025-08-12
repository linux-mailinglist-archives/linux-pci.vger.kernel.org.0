Return-Path: <linux-pci+bounces-33880-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 855D8B23730
	for <lists+linux-pci@lfdr.de>; Tue, 12 Aug 2025 21:09:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E684B6859EE
	for <lists+linux-pci@lfdr.de>; Tue, 12 Aug 2025 19:08:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0587D2FF155;
	Tue, 12 Aug 2025 19:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IvFzqnoG"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBEE12FF143;
	Tue, 12 Aug 2025 19:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755025678; cv=none; b=gmlmJFV88o4ri2jGNvtzrFXGWC+W4s/5U9g0zm/teCp0yF7gMR8UTVrq3F8eiwkifkzx+blHG3RVWRuFdkJuf4x2qDx5H4WJQRNr13/NvRLxac8jNxKJXQVO5VIs+0iLVJbMyFcA9lsRENQREEwjxe34wmqZevWxvmYFxyWJ47g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755025678; c=relaxed/simple;
	bh=nBRYwhhq+ZYeExRYEmk3RlKXUCsmlo/lbUoHgZxxOdA=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=tDfZz282xu0Edcua9nkpjlalirT7ZBZt9SlPbkZ8Dmco/4vCuO6wAojljNP+zYR3wpWVrsELTgmJMdp71NLXWS+INgLp/JP2DRhZK7sSjG7ZpkY51lOcokMtMpSNb4sPmVRaTO3cTXLRmUlwPeKqXAKGBUYi1sgAvIbCg2qp5hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IvFzqnoG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2468C4CEF0;
	Tue, 12 Aug 2025 19:07:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755025678;
	bh=nBRYwhhq+ZYeExRYEmk3RlKXUCsmlo/lbUoHgZxxOdA=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=IvFzqnoGSlrROXg8dTZMYa4XRM6/OemnA9zEz7qcppD7siLpRjDGt/50wuwOcDY3t
	 j+gvdXrVKCgVHbe8t/GJtSN9Cq2Y/ryqlxoIl0cOKjGKr206mlca8PIUvLIVpjWXkk
	 941rqpNZ3bFRq8Y9eTMdhHXLuDi/yVcx0pJoh8LPvqZlqKqTMHYj/zQv/I8fnS18+E
	 O9GiHWgc06Qcf+kQdPx4e4sd7C5DN1R+RewsyQB7hk8ESOJgq+QxnQ++NL24bMtM7y
	 SL5t6gYhQoUm/0DAgP+2FodcwWjf1a9CcrsbzSqepsT1SIYZFHqVcH9D9FpidbHY4t
	 wsA1/KXazAcLQ==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 12 Aug 2025 21:07:53 +0200
Message-Id: <DC0OOFT2RTO7.2PCAP981HCCN3@kernel.org>
Subject: Re: [PATCH v9 0/7] rust: add support for request_irq
Cc: "Miguel Ojeda" <ojeda@kernel.org>, "Alex Gaynor"
 <alex.gaynor@gmail.com>, "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Andreas Hindborg" <a.hindborg@kernel.org>,
 "Alice Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, "Thomas Gleixner" <tglx@linutronix.de>, "Bjorn
 Helgaas" <bhelgaas@google.com>, =?utf-8?q?Krzysztof_Wilczy=C5=84ski?=
 <kwilczynski@kernel.org>, "Benno Lossin" <lossin@kernel.org>,
 <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, "Joel Fernandes" <joelagnelf@nvidia.com>,
 "Dirk Behme" <dirk.behme@de.bosch.com>
To: "Daniel Almeida" <daniel.almeida@collabora.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20250811-topics-tyr-request_irq2-v9-0-0485dcd9bcbf@collabora.com>
In-Reply-To: <20250811-topics-tyr-request_irq2-v9-0-0485dcd9bcbf@collabora.com>

On Mon Aug 11, 2025 at 6:03 PM CEST, Daniel Almeida wrote:

Applied to driver-core-testing, thanks!

> Alice Ryhl (1):
>       rust: irq: add &Device<Bound> argument to irq callbacks
>
> Daniel Almeida (6):
>       rust: irq: add irq module
>       rust: irq: add flags module

    [ Use expect(dead_code) for into_inner(), fix broken intra-doc link and
      typo. - Danilo ]

>       rust: irq: add support for non-threaded IRQs and handlers

    [ Remove expect(dead_code) from Flags::into_inner(), add
      expect(dead_code) to IrqRequest::new(), fix intra-doc links. - Danilo=
 ]

>       rust: irq: add support for threaded IRQs and handlers

    [ Add now available intra-doc links back in. - Danilo ]

>       rust: platform: add irq accessors

    [ Remove expect(dead_code) from IrqRequest::new(), re-format macros and
      macro invocations to not exceed 100 characters line length. - Danilo =
]

>       rust: pci: add irq accessors

