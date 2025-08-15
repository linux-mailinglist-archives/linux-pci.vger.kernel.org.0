Return-Path: <linux-pci+bounces-34107-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 855D9B27FB9
	for <lists+linux-pci@lfdr.de>; Fri, 15 Aug 2025 14:08:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 159B4624777
	for <lists+linux-pci@lfdr.de>; Fri, 15 Aug 2025 12:08:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BC573009EF;
	Fri, 15 Aug 2025 12:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CE5lmPqr"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E73928C2D1;
	Fri, 15 Aug 2025 12:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755259672; cv=none; b=ORF2QoDaEcNoAXxalGKObeZ79y6mY3vX2zLreOSaMPkssi66od42nNy3MiOjgMsLiQpo4UMtb8Il+4CpCuw3oCM2arj4l5GYSOTf40cpfcQfVaMTWrURBjVmld5liD5XieDmPiy58qItEdSQmdEF202uNdK3U0ujpGdp0EkrLSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755259672; c=relaxed/simple;
	bh=w/1NYHzKPiJ6Ykf5EvlcG+mpnVFELfM3RBiTz54s/e8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jJSjkK0L3DSq8PBeMGMdc4L/xXGxcglLipLEcnTpUehddUq7a05I9fqX23UFimbH5crPUf/kR7z9Mp2uiJlv1SvPdsMhwuYSoE73t6xLBjaeTGnE5/IiYDGV3sqF8g495HCNeMz1+mqGVTP/YQtz9CGZ1PwqKRh6j1hzynrfcx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CE5lmPqr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFA2DC4CEF0;
	Fri, 15 Aug 2025 12:07:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755259671;
	bh=w/1NYHzKPiJ6Ykf5EvlcG+mpnVFELfM3RBiTz54s/e8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=CE5lmPqrxR2QIrfHBRxSo9NSBNdvUMl0OMa9web5NQIQkWAaeeQqCt48qeP+6AZj7
	 ST8kMoiKh19DJTqsPLw5Hf4YvcuStRUTuKnYqeBMsyg2rSLtDzNSn4cnChn2g/4+LZ
	 ZthBGzBwkTa6czF2fG+S0Rw++kypK7qeZg/LCobX7LAYltMOUKFzRdWYDYCNMAPNYb
	 UfqWQjRx88ucyZnqWDZnKn/hFeK6/CK5O7wkpDJ+EfXgwbE5ijR80PPnKxhbvfmRLa
	 fa3WM9Gf9OiLFpasJ2faamJGgpm9TcZTsHpTnNPPWgxwF3uECm5VdKf046MXYr3xim
	 vJscr9fUfWEvw==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: Daniel Almeida <daniel.almeida@collabora.com>, Miguel Ojeda
 <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng
 <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn?=
 Roy Baron
 <bjorn3_gh@protonmail.com>, Alice Ryhl <aliceryhl@google.com>, Trevor
 Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Bjorn Helgaas
 <bhelgaas@google.com>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?=
 <kwilczynski@kernel.org>,
 Benno Lossin <lossin@kernel.org>
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
 linux-pci@vger.kernel.org, Joel Fernandes <joelagnelf@nvidia.com>, Dirk
 Behme <dirk.behme@de.bosch.com>, Daniel Almeida
 <daniel.almeida@collabora.com>
Subject: Re: [PATCH v9 1/7] rust: irq: add irq module
In-Reply-To: <20250811-topics-tyr-request_irq2-v9-1-0485dcd9bcbf@collabora.com>
References: <20250811-topics-tyr-request_irq2-v9-0-0485dcd9bcbf@collabora.com>
 <5J2HACgtf13EIyol1Y7WVkA9WmIkndC_1Zjuu1itq_KQjmc8xdbDGxR0_8YVeYXVtfqwbkbDllcXSSAPQ073cw==@protonmail.internalid>
 <20250811-topics-tyr-request_irq2-v9-1-0485dcd9bcbf@collabora.com>
Date: Fri, 15 Aug 2025 14:02:55 +0200
Message-ID: <87zfc0dc7k.fsf@t14s.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Daniel Almeida" <daniel.almeida@collabora.com> writes:

> Add the IRQ module. Future patches will then introduce support for IRQ
> registrations and handlers.
>
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> Tested-by: Joel Fernandes <joelagnelf@nvidia.com>
> Tested-by: Dirk Behme <dirk.behme@de.bosch.com>
> Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>

Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>


Best regards,
Andreas Hindborg




