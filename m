Return-Path: <linux-pci+bounces-31456-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52E79AF81CC
	for <lists+linux-pci@lfdr.de>; Thu,  3 Jul 2025 22:14:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11A9554546E
	for <lists+linux-pci@lfdr.de>; Thu,  3 Jul 2025 20:13:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7823629B793;
	Thu,  3 Jul 2025 20:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uE72JgV2"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48E6A29B20D;
	Thu,  3 Jul 2025 20:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751573636; cv=none; b=Dxnubyi/JftVo+TR5I7tuBLb1TklMKS8zlAI80Z+fjBv7fyByBUdd63qlY1IiYdCRarisPXFFovJAjFxIgQYitITE4J61J+RJpvyF1lPK4FSaHi8Rc1DFijHugOKmrX92ZRjAbJHNr6wd/bC4aPnHtd0zhB5C79aWZyCuhGe6NM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751573636; c=relaxed/simple;
	bh=xGaRycledJGdlf425UdwgEj3N4v7BtyR+liW0smD3T8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BFXHDvh6Gb7OqeoZ1RcVZHLZh05j1p0QPAtQQu96aMg+7zqWIbNPDB7GF57oLGjRQI6P59isswA1L5rgXUwaxbxP+BGcqvmvy0JGhEMz4vviqkO/0dujq/cABNkbq4/Krf4+/tMqDRzWyC0KZeWDJtqljteteNzmsqdzIwZFwIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uE72JgV2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19031C4CEE3;
	Thu,  3 Jul 2025 20:13:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751573635;
	bh=xGaRycledJGdlf425UdwgEj3N4v7BtyR+liW0smD3T8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uE72JgV2ZLDqVGWtzkm233V2Jqe8pMPTgWSGgSBhooO/vlhoJcyDv/IQARsmoNQj3
	 3Zi9tVXgdpMDb3J+HvEnk2pYZrDjOmpT2FzeR//FSkv9th/RN3Ag1o4E+o4QONNS0u
	 CGyDO2cBszAxnTjBtYNLOn9fpZP5UZAPD20fJtHMrZRvTHes+IHYUEKBqv8wmCqUuM
	 xxNccoaBhX1Gks2Cd926ZVPLa6a6zNF0Pce9fE5ju5rkXf5HEJEPjxIBEgdgJ4ZN8l
	 qtfqyY78YGCAcWPwW9U3+1FD6B4932jY3esdXcmVZRu0vOEdi7D0vsMLxex6fCVnl9
	 +G7pI3spJ6qKA==
Date: Thu, 3 Jul 2025 22:13:49 +0200
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
Subject: Re: [PATCH v6 0/6] rust: add support for request_irq
Message-ID: <aGbkfa57bDa1mzI7@pollux>
References: <20250703-topics-tyr-request_irq-v6-0-74103bdc7c52@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250703-topics-tyr-request_irq-v6-0-74103bdc7c52@collabora.com>

On Thu, Jul 03, 2025 at 04:29:58PM -0300, Daniel Almeida wrote:
> Daniel Almeida (6):
>       rust: irq: add irq module
>       rust: irq: add flags module
>       rust: irq: add support for non-threaded IRQs and handlers
>       rust: irq: add support for threaded IRQs and handlers
>       rust: platform: add irq accessors
>       rust: pci: add irq accessors

What's the intended merge path for this series? Should I take it through
driver-core? I'd assume so, given that, besides the series also containing
platform and PCI patches, it depends on patches that are in driver-core-next.

@Thomas: Is there any agreement on how the IRQ Rust code should be maintained?
What's your preference?

- Danilo

