Return-Path: <linux-pci+bounces-32592-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E5F69B0B1E7
	for <lists+linux-pci@lfdr.de>; Sat, 19 Jul 2025 23:09:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A645F189C2F6
	for <lists+linux-pci@lfdr.de>; Sat, 19 Jul 2025 21:10:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AACB11F5434;
	Sat, 19 Jul 2025 21:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HSuT5un8"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4560E7FD;
	Sat, 19 Jul 2025 21:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752959383; cv=none; b=Rt+7iuDRKIB2zEi2pzmBn/CZs3hKOH+T8v1Y31zY+iazKdcZW6DFc7bm9JpxccOr5D7s5+Lye0sG+6HL+8n/Vnwof6RCNLUO+mjMuOTPhbruruVG8apfnd1y9pjodqHgvQKkIaHzDcje7meayKNsQpXG5ol2QCHnmimu5amVDSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752959383; c=relaxed/simple;
	bh=dnChIfhrhkHOnL9w0Fd2w/pEB5uYL2PU8MaiXDFn9Eo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gPBRkxrY44AsF3Ovo41VJCKkG9htJvHRysmJLiVxxGRMnjfy9rBw3lE0Exl5RCsIw97Qzon7A23aJh2FN54r4RkdAdHQe6qvPE527P+HKmuG+6xxCjRP85kxoNdtWiPgfcaBewnkPdWkC5IGAO6cFflTkcJmBEN17AZMwzDbFZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HSuT5un8; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-313290ea247so603807a91.3;
        Sat, 19 Jul 2025 14:09:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752959380; x=1753564180; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dnChIfhrhkHOnL9w0Fd2w/pEB5uYL2PU8MaiXDFn9Eo=;
        b=HSuT5un8I0UX4e+Ki4jgKap6ucOvwr+CJv3ivgqGjJld77eDOSPpPl8yG9aZxtSuoP
         6Eein9YaGlgZqe0y2g7VMHfs7EKVmPFFqG0hkO/WV2fRgIm2tQ6v/oy4ylipuS+27p/m
         PEq+z4TVP6CxD+WwLzYWxZ/kPXBm5Vgz7XnLYkyR8JvOdcbWnexvmwnWp7wdtSQjm02G
         idc395VtPg/Mw8SMmVvzYx19QvCcyP2WjVfRjzAGlaxIWHU7ubRq8p0rNMTzzAdjn3Vx
         Pxmn0sLoTuZafnQfiwymsAP/CA0NBTqHZlawGkmUk4/ItWJmc1+2Zgwl+PCYoShaNcG2
         p7yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752959380; x=1753564180;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dnChIfhrhkHOnL9w0Fd2w/pEB5uYL2PU8MaiXDFn9Eo=;
        b=MANqjmmhXRDQYTjNqR09zFvwPdA3R+fh3NA1ezIe+Ny4FYjiJ2R/U0Dyw0CAAXn7x7
         impnSUKlHWEYvr0Uff12v8C5bXnVzU5B1E0CktRNCnjQnajAXIMcXgvXqIMZycZn349H
         cmRulA/2FZvcsmrBAOmASO394nCDgGNQXJEF4bGItPa4J4mI+WkTz96ReV+GC+telOCK
         F3xHTavciAm/bBFi8446oEmkEYK+iR2ghmdzOF61NrC2t83CPlCttFAJoSrVWqQa0xVQ
         ArKs7+NK2kU5L2yWa1xsG2GzmK1TXBvrnFk2F1zYio5fjTRhW365gzllOLP4NCjiftV2
         YhiQ==
X-Forwarded-Encrypted: i=1; AJvYcCUB9N7NUOjFBT57ED88X1+QMuU+cK+jFrD80QrOTGDsS5jaDKxFHhqmlDy11CyfDvgDAf8nvCxMWeGTnzMkQO8=@vger.kernel.org, AJvYcCWfXqi4sH7d9NnGdxceNr/LveZRMRyRkBhYP1CFRJ0ZL9SfLjEe3rloFbBSZUrf/5NN3UnkJnVtEWEmn1s=@vger.kernel.org, AJvYcCXNOZCntxxkD+6sdpVZOCgrudKdA5v3fWCLQ6axhRmHXZ2VAgz0qPVXvdC3a5RoYszpTHMZP9nTeyGo@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/jBTj9To2ad/7MMDjaYG8nEcHSinDiOK129WHjtc92hJtCWqn
	p5K4kxAvQr9tZ09w8FjrKXoEVbdxO0NofaXWO6Vl6Bw5BNCPlW1pZgEX/w+kV4Lb3CR5K4VPYU4
	/ysII1z+ykUwoWp6H7sIVosDrtiws3pA=
X-Gm-Gg: ASbGncvBONLOYUWhyoIGccl9rTykbeff1p4uR88ZgAEbmfxLWWnadYGcHj0pR7vAeQ+
	aegn2sPQjnRttQ5QCIIXLCcXNXJDeKmt8Jtlf9+ddW5N/nQfBxwmOHrZ+ukKnZkd1EcVmuF2Pmd
	wMpEwRfWKQwDYgWEZcA4mlr4VbNK+jhe/UCVhf84uz2B1Nc/kOlRph/eIXDbiu8Y3Ah1KTa+76G
	Ze3VWLp
X-Google-Smtp-Source: AGHT+IGpmg9BtjDqGzc5M8f83JkLT331Kqwy639s/VflPRU91b5jbw1UNTD+7Punsa8mUiG3b8HmZNmN6BqNOVV5ZgM=
X-Received: by 2002:a17:90b:2e87:b0:313:14b5:2521 with SMTP id
 98e67ed59e1d1-31c9e79557cmr9206152a91.5.1752959380470; Sat, 19 Jul 2025
 14:09:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250709-list-no-offset-v4-0-a429e75840a9@gmail.com> <20250709-list-no-offset-v4-6-a429e75840a9@gmail.com>
In-Reply-To: <20250709-list-no-offset-v4-6-a429e75840a9@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sat, 19 Jul 2025 23:09:27 +0200
X-Gm-Features: Ac12FXzFnJLsKrgrCNMO8uO_1R3w2BRfx25-QSNNK7wbz-b5stC2LPrcTB4gBW0
Message-ID: <CANiq72kvYuoSSOruDQiEo5ppSDvtxSzQ4R6rxdN9RBkucBRuew@mail.gmail.com>
Subject: Re: [PATCH v4 6/6] rust: list: remove OFFSET constants
To: Tamir Duberstein <tamird@gmail.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 9, 2025 at 9:31=E2=80=AFPM Tamir Duberstein <tamird@gmail.com> =
wrote:
>
> -/// Declares that this type has a `ListLinks<ID>` field at a fixed offse=
t.
> +/// Declares that this type has a [`ListLinks<ID>`] field.

I was applying this series the other day, and I noticed these
doc-related changes in the patch, which are appreciated (I think you
did it to make it consistent with the other lines you were adding with
intra-doc links), but I think in general it is better to clean those
separately in a patch first.

I am mentioning it because the docs do not build due to those --
please check the `rustdoc` target for patches, especially if it is a
non-trivial change.

I also did another change to make the examples (in the other patch)
build with the minimum Rust version. It is good to test that too,
since sometimes that can slip, especially as the window of versions
grow.

Anyway, the examples/series here caught another issue with a previous
patch, so that is good news :)

Thanks!

Cheers,
Miguel

