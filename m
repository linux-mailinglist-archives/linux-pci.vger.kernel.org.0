Return-Path: <linux-pci+bounces-29320-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E9C4AAD3563
	for <lists+linux-pci@lfdr.de>; Tue, 10 Jun 2025 13:58:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFFDF3B5176
	for <lists+linux-pci@lfdr.de>; Tue, 10 Jun 2025 11:58:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8722222B8BC;
	Tue, 10 Jun 2025 11:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D8W3FB3a"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E0B822B8B8;
	Tue, 10 Jun 2025 11:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749556696; cv=none; b=dPI1j1so08sz0NTNa7IKA+6hJ6pZE5+HkF2d/5/rTLFt3dd8NoXBqrUmE6IbVDF0j6LIiHwqmq+Flr8+3MrHogSfJVcGKIwdS26pjzEvGrTDBXjNykmqffU1G0YkiZwzh9toHEMJ7W5mNWvWKQJCvKsUpS3vyMTZFeQoq8a9CIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749556696; c=relaxed/simple;
	bh=eMS2F2tvzjR9NHy0MJLKrY8BTnZRB2PUODIxvpPm3c8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mz4UCK5MC8IXwr6qosjazlI31NRWp8MKVRIn6mH/+wxir6jaBRM2x/sYd60FvP6Aj+2W/jkq1k5iVBoXAOVjXXHIVCPTnJKIEJEJ/0OFFpa8e+jpSRubYFdXWTBPSpULlcwMoRXJLA6DNW44eSOH+5W31Vki/LhQFVDqEcr/st0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D8W3FB3a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AA00C4CEED;
	Tue, 10 Jun 2025 11:58:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749556696;
	bh=eMS2F2tvzjR9NHy0MJLKrY8BTnZRB2PUODIxvpPm3c8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=D8W3FB3a90bmJyfCeS1dkwvE95gdVpuAVt+LPfzRDvBAFgoI93ijGCTGNfN2mk4bR
	 L1CvQGj4f4lgPrZ+QWn0f/tAm3yhBStFQF8S4iE3od9BZqknP7eRJFGpEqU807PBdS
	 otzCFpI5LnwF5naPm5Gno/r6M/acj2LQRyyK5puiwK9wgMWineDeCy1l7bi9gFcOCZ
	 9mUEdBmCXwDKKGjqpbMKDRBDcShmLdQiz+EBJR5NSTagecNbvW/JXgr3bI4aHdpuIA
	 M0fY5RMN9aAtDWw/KeKl9oOT/cIOyZRzG9bEe3yZnuI7yCjzQ5fvhli+P3a7HNUmHo
	 e0D/nZCHJ+5dA==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: "Miguel Ojeda" <miguel.ojeda.sandonis@gmail.com>
Cc: "Danilo Krummrich" <dakr@kernel.org>,  "Miguel Ojeda"
 <ojeda@kernel.org>,  "Alex Gaynor" <alex.gaynor@gmail.com>,  "Boqun Feng"
 <boqun.feng@gmail.com>,  "Gary Guo" <gary@garyguo.net>,  =?utf-8?Q?Bj?=
 =?utf-8?Q?=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>,  "Benno Lossin" <lossin@kernel.org>,  "Alice
 Ryhl" <aliceryhl@google.com>,  "Trevor Gross" <tmgross@umich.edu>,  "Bjorn
 Helgaas" <bhelgaas@google.com>,  Krzysztof =?utf-8?Q?Wilczy=C5=84ski?=
 <kwilczynski@kernel.org>,  "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>,  "Rafael J. Wysocki" <rafael@kernel.org>,
  "Tamir Duberstein" <tamird@gmail.com>,  "Viresh Kumar"
 <viresh.kumar@linaro.org>,  <rust-for-linux@vger.kernel.org>,
  <linux-kernel@vger.kernel.org>,  <linux-pci@vger.kernel.org>,
  =?utf-8?Q?Ma=C3=ADra?=
 Canal <mcanal@igalia.com>
Subject: Re: [PATCH v2] rust: types: add FOREIGN_ALIGN to ForeignOwnable
In-Reply-To: <CANiq72kYdtozcN1U1yGhi_orh-OVO2xp3=wQPAhwgx=wTi-neA@mail.gmail.com>
 (Miguel
	Ojeda's message of "Tue, 10 Jun 2025 13:37:02 +0200")
References: <20250610-pointed-to-v2-1-fad8f92cf1e5@kernel.org>
	<ABpacmV2zqpdR5tk6NDHTg9kbssxZOay4JLvHJWs6pS0swz_krftwuUN8k_SABP04TF1k1Z4uW4IH29D2Qb5OA==@protonmail.internalid>
	<CANiq72kYdtozcN1U1yGhi_orh-OVO2xp3=wQPAhwgx=wTi-neA@mail.gmail.com>
User-Agent: mu4e 1.12.9; emacs 30.1
Date: Tue, 10 Jun 2025 13:58:05 +0200
Message-ID: <871prr24he.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

"Miguel Ojeda" <miguel.ojeda.sandonis@gmail.com> writes:

> On Tue, Jun 10, 2025 at 1:32=E2=80=AFPM Andreas Hindborg <a.hindborg@kern=
el.org> wrote:
>>
>> - Replace qualified path with `use` for `crate::ffi::c_void`.
>
> Hmm... I think parts of the patch still use the qualified path?

Yea, sorry. I just changed the kbox file where Benno pointed this out. I
can change the rest of the places as well.


Best regards,
Andreas Hindborg




