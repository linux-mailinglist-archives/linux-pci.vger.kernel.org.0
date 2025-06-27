Return-Path: <linux-pci+bounces-30967-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 164ECAEBFF9
	for <lists+linux-pci@lfdr.de>; Fri, 27 Jun 2025 21:33:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F06EB1C46875
	for <lists+linux-pci@lfdr.de>; Fri, 27 Jun 2025 19:33:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4B092EAB6C;
	Fri, 27 Jun 2025 19:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EJ6JYnBz"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 885532E9743;
	Fri, 27 Jun 2025 19:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751052701; cv=none; b=ZKccxwItlZpQ9qXdAaFBCt9Plyutr4rpgJOg4Tdx72cXFYx6ABdOgRquMFcnM1eACpSEJqdq7Bs7pSLgC/kS8vsyA0X+eRAv6IFxVcxs563DfKrIluFUkiGDu/r4XLdxOl6NboJ1PhRGknQo0GyzhyzGV8HX/FEUv5yaKPtAo2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751052701; c=relaxed/simple;
	bh=7qJt+JZrMa7ENp/lVXjk8y8PZgvTiFRz9BX8bJrZ4Dc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D8qLpa4EhRMnXv4cafPCFiw2y+2FVoo1EFh3ivVEn/QtVIIhmJij+OL0iM25joh2HcwlhIaZ0+HoUuiItU6ZcZtxTs3xcrDZ7ZhwdZc3PewVcSng/zQ9LbhAhtzj9Y34PMYOKjnbZRpETIWU50edVIaorVUPjfYxbQE+YE7G7nI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EJ6JYnBz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7577BC4CEE3;
	Fri, 27 Jun 2025 19:31:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751052701;
	bh=7qJt+JZrMa7ENp/lVXjk8y8PZgvTiFRz9BX8bJrZ4Dc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EJ6JYnBzP5xDUEux438qdxDuNACuYgYIF9OmRH+NiuVhMLI7YKevewJLF+PpswSm7
	 ahkXL8PRgfHqvyh7pWw3PgZ9P+xllqrO/igMdCveW88bSkHX3lT2ys3octO9ciq0ZV
	 fE/agIWxep8+U7OpcT3Jbv1XbHAv/LtRejpGoQUu8pLfwBBaGP8pqLGCH64RfuYbgU
	 MPPtbtnGjYjtyEDGdwLb0PC5st5P0yj50KlbgC8gBnIA/c/UpvBt6IBSYVWZf/lu8x
	 JBoq3in10UIQnqwFrOwWtHAZmjVDe+PC820xkAizjSVGGtNNp0Vs7pBdgaHIhVIHQN
	 YyESVguNxO8RA==
Date: Fri, 27 Jun 2025 21:31:34 +0200
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
Subject: Re: [PATCH v5 4/6] rust: irq: add support for threaded IRQs and
 handlers
Message-ID: <aF7xlhJeb-t_blHf@pollux>
References: <20250627-topics-tyr-request_irq-v5-0-0545ee4dadf6@collabora.com>
 <20250627-topics-tyr-request_irq-v5-4-0545ee4dadf6@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250627-topics-tyr-request_irq-v5-4-0545ee4dadf6@collabora.com>

On Fri, Jun 27, 2025 at 01:21:06PM -0300, Daniel Almeida wrote:
> +/// Callbacks for a threaded IRQ handler.
> +pub trait ThreadedHandler: Sync {
> +    /// The actual handler function. As usual, sleeps are not allowed in IRQ
> +    /// context.

I'd rather say:

	/// The hard IRQ handler.
	///
	/// This is executed in interrupt context, hence all corresponding
	/// limitations do apply. All work that does not necessarily need to be
	/// executed from interrupt context, should be deferred to the threaded
	/// handler, i.e. [`ThreadedHandler::handle_on_thread`].

> +    fn handle(&self) -> ThreadedIrqReturn;
> +
> +    /// The threaded handler function. This function is called from the irq
> +    /// handler thread, which is automatically created by the system.

	/// The threaded IRQ handler.
	///
	/// This is executed in process context. The kernel creates a dedicated
	/// kthread for this purpose.

> +    fn handle_on_thread(&self) -> IrqReturn;

Personally, I'd prefer `handle_threaded()`.

