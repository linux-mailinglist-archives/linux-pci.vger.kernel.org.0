Return-Path: <linux-pci+bounces-33120-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD651B14F7E
	for <lists+linux-pci@lfdr.de>; Tue, 29 Jul 2025 16:46:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F23944E291E
	for <lists+linux-pci@lfdr.de>; Tue, 29 Jul 2025 14:45:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CF7E1E9B1C;
	Tue, 29 Jul 2025 14:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hHP7pPCa"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 717B21E885A;
	Tue, 29 Jul 2025 14:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753800355; cv=none; b=c+Bwn1Gg5rLcKeFv7qQXWf8aE2K7UkBdS2rbpKlZ2k2MsutFt7oqyaB0YUYD6K7YSWR+BP2MPRPoZhCEiTMvBh9i1oLsVBJ8Y/VcRQ0Cf0zsD3uKgBsfP/0VFmUHAfZto18qvTxKaSzaMNWFrMO+nWPIMDBah88T9ND8PTZ2BR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753800355; c=relaxed/simple;
	bh=VRe02SlbUxzFL+D1eWiHYgvNlUzOCAiZ1RiAPc6Icps=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:To:From:Subject:
	 References:In-Reply-To; b=LxmEs2N9mn1O8YfmuAmHZfpvTg9WSQ5v+830qnUW2S/UGSUDs3tU6G/tO0iwPiKNXeDT5wqOK57zfwakMoYE1ocSygpz+bb9uS2njBcQBmR/N/DRMzgqEdSj+dFki3eGFt9JMPkIPGNnJxchOe2t0UEaQMHmG1J7T45C8uH6q14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hHP7pPCa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB0E9C4CEF4;
	Tue, 29 Jul 2025 14:45:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753800355;
	bh=VRe02SlbUxzFL+D1eWiHYgvNlUzOCAiZ1RiAPc6Icps=;
	h=Date:Cc:To:From:Subject:References:In-Reply-To:From;
	b=hHP7pPCa5zggfP/Ea+wRT/ozNG1fGgcXeXqLCs4RDCT9ktEORmHOSKgGE4PiH6KZ5
	 gd036sU/rM8UF60RTuQS/L1Qvd3v7rFBxFPoodU30xbsVicWZo/6O1rBrKddGsOHv3
	 sd4X2MpA5ePhVyO93Pncnz1aZ1cJH8CUfOcJFKrePwbdWG/mAbTFuvyWGtciiABF9w
	 TL6B4XG85XbZw+vjYlj2ln07rtDxMJXP3oC6nTtDDvIVtCghSwxkfMd+0EaefDMCO3
	 r6rWJ2Lsl0Gzk07YrTKdnCsWFrSl7MMfBJOUvX6r21MbH95uY67XCYSw26uEwdirxi
	 NM1lAQFU9hq+A==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 29 Jul 2025 16:45:50 +0200
Message-Id: <DBOMC68QGS76.2MYEXRE1I34VV@kernel.org>
Cc: "herculoxz" <abhinav.ogl@gmail.com>, <linux-pci@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <bhelgaas@google.com>, <kwilczynski@kernel.org>, <ojeda@kernel.org>,
 <alex.gaynor@gmail.com>, <boqun.feng@gmail.com>, <gary@garyguo.net>,
 <bjorn3_gh@protonmail.com>, <lossin@kernel.org>, <a.hindborg@kernel.org>,
 <aliceryhl@google.com>, <tmgross@umich.edu>
To: "Miguel Ojeda" <miguel.ojeda.sandonis@gmail.com>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH v2] rust: pci: Use explicit types in FFI callbacks
References: <20250729102953.141412-1-abhinav.ogl@gmail.com>
 <CANiq72kRu5Wd-3Tk7px=2Y5kU5Tq2fQch=+f3ExYSrJa2+tSSg@mail.gmail.com>
In-Reply-To: <CANiq72kRu5Wd-3Tk7px=2Y5kU5Tq2fQch=+f3ExYSrJa2+tSSg@mail.gmail.com>

On Tue Jul 29, 2025 at 12:52 PM CEST, Miguel Ojeda wrote:
> On Tue, Jul 29, 2025 at 12:30=E2=80=AFPM herculoxz <abhinav.ogl@gmail.com=
> wrote:
>>
>> and improves ABI
>> correctness when interfacing with C code.
>
> I think this still sounds like it is fixing an ABI issue -- I would
> probably just remove that second sentence.

I agree, the types exported via prelude are the ones from kernel::ffi.

> (But no need for a v3 -- I think it can be fixed on apply unless
> Danilo wants it).

Yeah, I can fix it up when applying the patch.

I also think the subject from v1, i.e. "use c_* types via kernel prelude", =
was
better. This one is a bit misleading, the types in the FFI callbacks are al=
ready
explicit.

Unless I hear otherwise, I will also revert the subject to the one of v1 wh=
en I
apply the patch.

Thanks,
Danilo

