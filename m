Return-Path: <linux-pci+bounces-32063-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C4C2DB03BE3
	for <lists+linux-pci@lfdr.de>; Mon, 14 Jul 2025 12:29:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D7AF164D68
	for <lists+linux-pci@lfdr.de>; Mon, 14 Jul 2025 10:29:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5667A241139;
	Mon, 14 Jul 2025 10:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="apPJWHL5"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 284ED4A1A;
	Mon, 14 Jul 2025 10:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752488970; cv=none; b=dD2KNFPKwA2rG5jRoRJIvObX+Ipkr10vequE4l3lLB8PfVwEinOHBZ+RhjZwxuWPjD7YBzlzviegHffTf9j2YNPkSlMLIj5W0baYQC+A4AvrmAXlZpUTnZz5T+hchYZ/yc8LHvvQrGQMuDtsUKY/Wirt1ZMApdTxwL88YXgK9FA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752488970; c=relaxed/simple;
	bh=lj27nlcaTDFE43k/2WvSXLWWrtHCJ8JnG+RfrSLU4Ak=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=miy5U8wEVQ78qTtfXhySmd8MCde7zLyc5Bz7q4DiaYKbK7dzinpruKUHoFOSEwQiAmr1S9L42FzHup2Fa8dNTLDIleN3LVKhWD+cizq3fcctd5FMQqGGC5zSau2YJuFQaOqh3KvOcZMmmqpmYK1yQ2PCbuCGh3j5mKGiNat6Xjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=apPJWHL5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51FE6C4CEED;
	Mon, 14 Jul 2025 10:29:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752488969;
	bh=lj27nlcaTDFE43k/2WvSXLWWrtHCJ8JnG+RfrSLU4Ak=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=apPJWHL5Wbqab+89FFaVegBHLgNtXnNPSwLqvEHWWZ1M9hQ28eKCJKkoGZz4Y8gSc
	 pZdrMzCcsFuoOuO0lT3Vte8gcvoUzKg4GxmJvkn0h1thUdbo6fQSWxrsNWEgEPwaqj
	 6k9afV10JzpUNBWJkrnFOeXl2iR9KMU9qiDfhoQTNxxibqcNUDt4GBN/1bauVdNmFw
	 iWsQUKu30A173ENNrq5dcLwIJUBqNmDXQ2CASN2/DPgn3PpeW4cQvU/CQpIDawIluJ
	 Fn481kK0h2DB4Gj4mMpvfqiuEU6+BpOYXO8yMyN37CtRBcw+V1gMSrKw69Je7THogD
	 ef4O3uG6RL9UA==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 14 Jul 2025 12:29:24 +0200
Message-Id: <DBBPHO26CPBS.2OVI1OERCB2J5@kernel.org>
Subject: Re: [PATCH v6 3/6] rust: irq: add support for non-threaded IRQs and
 handlers
Cc: "Benno Lossin" <lossin@kernel.org>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "Miguel Ojeda" <ojeda@kernel.org>, "Alex
 Gaynor" <alex.gaynor@gmail.com>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 "Thomas Gleixner" <tglx@linutronix.de>, "Bjorn Helgaas"
 <bhelgaas@google.com>, =?utf-8?q?Krzysztof_Wilczy=C2=B4nski?=
 <kwilczynski@kernel.org>, <linux-kernel@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, <linux-pci@vger.kernel.org>
To: "Boqun Feng" <boqun.feng@gmail.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20250703-topics-tyr-request_irq-v6-0-74103bdc7c52@collabora.com> <20250703-topics-tyr-request_irq-v6-3-74103bdc7c52@collabora.com> <DBAE5TCBT8F8.25XWHTO92R9V4@kernel.org> <DAD3292B-2DBF-442A-8B60-A999AE0F6511@collabora.com> <DBAURC9BEFI0.1LQCRIDT6ZBV9@kernel.org> <DBAVXQTMR38Z.2782EGR84L7OP@kernel.org> <DBAWQG1PX5TO.6I2ARFGLX88N@kernel.org> <DBAX59YKO0FV.ANLOWRHDDS92@kernel.org> <DBAXP68U809C.2G8DMB52M3UZ7@kernel.org> <aHSmxWeIy3L-AKIV@Mac.home> <DBBO3VS9NXJR.3B2DZLDIJGLPS@kernel.org>
In-Reply-To: <DBBO3VS9NXJR.3B2DZLDIJGLPS@kernel.org>

On Mon Jul 14, 2025 at 11:24 AM CEST, Danilo Krummrich wrote:
> On Mon Jul 14, 2025 at 8:42 AM CEST, Boqun Feng wrote:
>> I think you need to reorder the initialization of `inner` to be after
>> `dev` for this.
>
> Indeed, good catch!

Just to add, it's more than the order of inner and dev. For such use-cases =
we
have to ensure that Devres as a whole is properly initialized once
Devres::inner::data is initialized.

Going to send a patch for that.

