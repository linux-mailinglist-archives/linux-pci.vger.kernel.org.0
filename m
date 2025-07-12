Return-Path: <linux-pci+bounces-32002-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B997BB02D32
	for <lists+linux-pci@lfdr.de>; Sat, 12 Jul 2025 23:24:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7AB91897FE1
	for <lists+linux-pci@lfdr.de>; Sat, 12 Jul 2025 21:24:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87EBB214A93;
	Sat, 12 Jul 2025 21:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hHvq5RoS"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BA501EEE0;
	Sat, 12 Jul 2025 21:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752355451; cv=none; b=SYdNsWEUt1vsDx0bmx29bux6BxRLj7smpFZx0bYxTXP2nAX7mtzaiaOWNy3v3Znk0nloPHQEb+W+cFaMXKzywIgX0FYrqTSPiHIZB2q6FUwFPabuSa58KlGD95GuBAcCPH8vwpQG5MwJurOjFMsuHx+b8qrgjQ+S1hgN7tYLzwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752355451; c=relaxed/simple;
	bh=+FFZWsPSmEgdRRnrgBxilYTxokA3WURGcfEufBZFPkg=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=TQozuB75a4BXhn4Im8LgvaPkxySop62Bh5Q8QF9DT+rWXd03Vc5mAbPZigk7nDcvdYtVR2vWbQYFaqnRenP7yx5uc9k8N+MrP530f52PftyFEW1HdCLGraYXukZG3CcTGbF40HxUAjJZ7pNdmxrWLCBzI1jtsc1iaqb48eJ16Ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hHvq5RoS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47564C4CEEF;
	Sat, 12 Jul 2025 21:24:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752355450;
	bh=+FFZWsPSmEgdRRnrgBxilYTxokA3WURGcfEufBZFPkg=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=hHvq5RoSpEInzgg65dLboa8uHA02mpVuh5tXtgwxV/xguCfgjqlb/BADl4f3GjoBZ
	 A9NRr6T7IVZkTHNSPMlm62qlaZ+Ymvlki4XWc83eeWBHWSe7ZQ/UmABhn3/PR6/E3Z
	 CShG3J/t3d+EyVhE0mjXhkdUzyFTQOL/ezet8E0b8vHQul39uTQKTssNlt0wJH+QYr
	 dz2hzkzFH6dhsa5Nw4RFscHrLOZi1KkRLTC48EDec/dldIzYgOgRIgyS1+QDsCgGXU
	 QXD6IPUC5sxZZJp4+RYuoMQQ5JSEoZDJEcZWRmfti1J1L3IOWZNPD15sez9B2U1oYG
	 i33Yu0BgF1M7g==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 12 Jul 2025 23:24:03 +0200
Message-Id: <DBAE5TCBT8F8.25XWHTO92R9V4@kernel.org>
Subject: Re: [PATCH v6 3/6] rust: irq: add support for non-threaded IRQs and
 handlers
Cc: "Miguel Ojeda" <ojeda@kernel.org>, "Alex Gaynor"
 <alex.gaynor@gmail.com>, "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Andreas Hindborg" <a.hindborg@kernel.org>,
 "Alice Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, "Thomas Gleixner" <tglx@linutronix.de>, "Benno Lossin"
 <lossin@kernel.org>, "Bjorn Helgaas" <bhelgaas@google.com>,
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 <linux-pci@vger.kernel.org>
To: "Daniel Almeida" <daniel.almeida@collabora.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20250703-topics-tyr-request_irq-v6-0-74103bdc7c52@collabora.com> <20250703-topics-tyr-request_irq-v6-3-74103bdc7c52@collabora.com>
In-Reply-To: <20250703-topics-tyr-request_irq-v6-3-74103bdc7c52@collabora.com>

On Thu Jul 3, 2025 at 9:30 PM CEST, Daniel Almeida wrote:
> +/// Callbacks for an IRQ handler.
> +pub trait Handler: Sync {
> +    /// The hard IRQ handler.
> +    ///
> +    /// This is executed in interrupt context, hence all corresponding
> +    /// limitations do apply.
> +    ///
> +    /// All work that does not necessarily need to be executed from
> +    /// interrupt context, should be deferred to a threaded handler.
> +    /// See also [`ThreadedRegistration`].
> +    fn handle(&self) -> IrqReturn;
> +}

One thing I forgot, the IRQ handlers should have a &Device<Bound> argument,
i.e.:

	fn handle(&self, dev: &Device<Bound>) -> IrqReturn

IRQ registrations naturally give us this guarantee, so we should take advan=
tage
of that.

- Danilo

