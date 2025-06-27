Return-Path: <linux-pci+bounces-30968-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35625AEC007
	for <lists+linux-pci@lfdr.de>; Fri, 27 Jun 2025 21:35:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 930C93A98FC
	for <lists+linux-pci@lfdr.de>; Fri, 27 Jun 2025 19:34:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB0D7205E3E;
	Fri, 27 Jun 2025 19:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aykXgHCH"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C015F20A5C4;
	Fri, 27 Jun 2025 19:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751052911; cv=none; b=mgvK8T/mZW8RpON6I+rrVnfqq/SPZ72GZw8ja9ntsuuL+ZTlG5lYNZDVExpUbXr0r0lX97hO28paVNf4DpbK9WGoAayUfhPWllLkOj4GvJdq6Wm9JyjW8ypuJF/oPdAz2SRBivs57R3PAYnNfYEZMr2z6DEgtb5ysRPx4Q98Bd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751052911; c=relaxed/simple;
	bh=KaGGXelm7CxuRTdflOr0Te0HdQDqVfIaKK0kiCSCgFg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V2foMYpu83xGh00uE1WGt2Me7H3jYl8v48pKcuAMz8AiO54QpqeGcM1lpBWdVN9OcAtWe1J899in+LMW2roRZ3W7jJZck6wO0YoJ9DRewJdhq1N31zJFCB/t9j9U0J1RN2EC+/bWltYsnEQr/Go532+NS2QCra43w7ECNkG8oWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aykXgHCH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9BD9C4CEE3;
	Fri, 27 Jun 2025 19:35:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751052911;
	bh=KaGGXelm7CxuRTdflOr0Te0HdQDqVfIaKK0kiCSCgFg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aykXgHCHt6ckjvgTXd4MUO0oQ989jBketGAkoTdyFQcRaXXtvEMQt93B4iAKEGrC/
	 sadxFkEXW6frjvhCfOPM2FxYDuesYEz70VnPmTP6pSX8Q9XHepSubm1a3FbVcrV+ku
	 N3Xd1pQ6Y1gBDtFb7aIbncDD0UIjPHw7YO1e8pWUQcnRvE6YBEV2j3ltwpuX+a/KTa
	 7Hb1b/0fAUehSe1vAJ74sIWuS/9k9viYbrWApMj6lOivJ/GtSW5xTbfL4JzUhZh2Hy
	 bCk4T1oxsCmTdmGhOgR1mRSY7QPrLOR1sZDvpZPM08+r6DI8R9/B1Wv+CPg5OdESSo
	 HzRUfnEs8MwSQ==
Date: Fri, 27 Jun 2025 21:35:04 +0200
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
Subject: Re: [PATCH v5 3/6] rust: irq: add support for non-threaded IRQs and
 handlers
Message-ID: <aF7yaGPIxTDhAtlj@pollux>
References: <20250627-topics-tyr-request_irq-v5-0-0545ee4dadf6@collabora.com>
 <20250627-topics-tyr-request_irq-v5-3-0545ee4dadf6@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250627-topics-tyr-request_irq-v5-3-0545ee4dadf6@collabora.com>

On Fri, Jun 27, 2025 at 01:21:05PM -0300, Daniel Almeida wrote:
> +/// Callbacks for an IRQ handler.
> +pub trait Handler: Sync {
> +    /// The actual handler function. As usual, sleeps are not allowed in IRQ
> +    /// context.

What about:

	/// The hard IRQ handler.
	///
	/// This is executed in interrupt context, hence all corresponding
	/// limitations do apply.
	///
	/// All work that does not necessarily need to be executed from
	/// interrupt context, should be deferred to a threaded handler.
	/// See also [`ThreadedRegistration`].

> +    fn handle(&self) -> IrqReturn;
> +}

