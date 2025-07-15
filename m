Return-Path: <linux-pci+bounces-32174-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C6BC5B06307
	for <lists+linux-pci@lfdr.de>; Tue, 15 Jul 2025 17:33:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49A275657AB
	for <lists+linux-pci@lfdr.de>; Tue, 15 Jul 2025 15:33:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EA372512FF;
	Tue, 15 Jul 2025 15:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EdmZKQuO"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5FA124E4C3;
	Tue, 15 Jul 2025 15:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752593576; cv=none; b=YrEGMptK3VppEiCsoiMXW10kI/dTjMIWeE/ucqHYZFlEB7edRxCOLoxR4Kb3NEAMOpMZz56SfUpZvEq/3XldUmfAa8kbcZJV+Xui8dFZAGxrdePfTYsDB0nGXfcSKW1Q4WoMse+e8p/iXYN40pzTvM8DMoF/RZ0PI62osxxgaZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752593576; c=relaxed/simple;
	bh=32I7tnE+Uw3PWlSmbWar4pOlDB7Z9GNHzzfr9Z4D6Ss=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:Subject:Cc:To:
	 References:In-Reply-To; b=iqEGK/mnh8Fv2nUtzail7kNTLtG2x104kwZDSdJh2ow868yOP3dEmuhGEAbN4UXaRXVfIcY7mPK0C7pGwhA7MomdLpMVRP9HhJvWsvWWtbFNVFlMTgZbmICxWXuzibzsOHYxk+3NKuTqrTxlOcA+dgOv6iBahlnqDUteRd9GIjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EdmZKQuO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B57ADC4CEE3;
	Tue, 15 Jul 2025 15:32:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752593576;
	bh=32I7tnE+Uw3PWlSmbWar4pOlDB7Z9GNHzzfr9Z4D6Ss=;
	h=Date:From:Subject:Cc:To:References:In-Reply-To:From;
	b=EdmZKQuOpN7GjSENUy6Q+gNMKYOjP+LnWERg4OrDwl7PtJxHYkHhVhzkwo2uM8MF0
	 NJaDccg0itWhn5ax+1A3DVYEv0EHUHMMblYEUqCdosrMb0vZZmdCMKaYfn+lgKo5gy
	 N5V1nD7k8JEyeWgdVRZMfVeLZAMgQVkXh+EcHGKI7wj6GftMHfSNw743Qc/WvW3O7U
	 iZan/9pJLMNxbFVKSKXPGznTWsG95sVaMbKnpZZ1l9dthrddB34Flcdd9UUkt8/CuJ
	 vLXDVG9FoMCY3fXuZbW+TWZ5WfevDtdjmyqETo+Wj8MvhXbaxzNF7XZhVNdN3gk9ya
	 0rDl+nWMrtdEA==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 15 Jul 2025 17:32:50 +0200
Message-Id: <DBCQKJIBVGGM.1R0QNKO3TE4N0@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH v7 0/6] rust: add support for request_irq
Cc: "Miguel Ojeda" <ojeda@kernel.org>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "Alex Gaynor" <alex.gaynor@gmail.com>,
 "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 "Bjorn Helgaas" <bhelgaas@google.com>,
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, "Benno
 Lossin" <lossin@kernel.org>, <linux-kernel@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, <linux-pci@vger.kernel.org>
To: "Thomas Gleixner" <tglx@linutronix.de>
References: <20250715-topics-tyr-request_irq2-v7-0-d469c0f37c07@collabora.com>
In-Reply-To: <20250715-topics-tyr-request_irq2-v7-0-d469c0f37c07@collabora.com>

On Tue Jul 15, 2025 at 5:16 PM CEST, Daniel Almeida wrote:
> Daniel Almeida (6):
>       rust: irq: add irq module
>       rust: irq: add flags module
>       rust: irq: add support for non-threaded IRQs and handlers
>       rust: irq: add support for threaded IRQs and handlers
>       rust: platform: add irq accessors
>       rust: pci: add irq accessors

(Mostly copy-paste from v6 [1].)

What's the intended merge path for this series? Should I take it through
driver-core, in case we make it for the upcoming merge window? I'd assume s=
o,
given that, besides the series also containing platform and PCI patches, it
depends on patches that are in driver-core-next.

@Thomas: Is there any agreement on how the IRQ Rust code should be maintain=
ed?
What's your preference?

- Danilo

[1] https://lore.kernel.org/lkml/aGbkfa57bDa1mzI7@pollux/

