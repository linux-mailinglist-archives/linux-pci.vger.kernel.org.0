Return-Path: <linux-pci+bounces-33154-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC70FB15A0D
	for <lists+linux-pci@lfdr.de>; Wed, 30 Jul 2025 09:57:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6CDF3A5AD1
	for <lists+linux-pci@lfdr.de>; Wed, 30 Jul 2025 07:56:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50257290092;
	Wed, 30 Jul 2025 07:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EJjjYj2u"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C807291C3D
	for <linux-pci@vger.kernel.org>; Wed, 30 Jul 2025 07:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753862214; cv=none; b=pdc5yB6xTFGtibXcK8jdbMfVRgOGRFcXEDAhOw6S5+nxEM/xXG+ZSOnNZyyog5hIfR2lftUkOpkdNTnVOS6jaNW+PWeUHXLNnr4eWI7WVgG899P20BCrr+xkxlrHRmmirp5nk/dNno0Ea4x+3vsca4AOXPvUYSzhPQjO+hY1iHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753862214; c=relaxed/simple;
	bh=GLaeAIqc00e+USukSnbAVMe5TgFLMlpYRPa2jWKuX/g=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=f+M+ub72Yw3esG0H9VBfFbkGR6WWsXYXy/2CVIQUmR/NFqWS9A3kE943fuOkO6nDV475ZWvwToAdbhvTZioklgm5eq/E6O7n4zgOiuhbABsTOrYDnRnXuYmOcI4wZ1oF7qkq4dJzMOco8ic3hWCZaDllr93wOTxevGA6B1b6QG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EJjjYj2u; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-451d3f03b74so32463935e9.3
        for <linux-pci@vger.kernel.org>; Wed, 30 Jul 2025 00:56:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753862211; x=1754467011; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GLaeAIqc00e+USukSnbAVMe5TgFLMlpYRPa2jWKuX/g=;
        b=EJjjYj2u10QgmPAXA/Al+RTNAf9Au5dPvN1pG/QbHUjPAuiHejzV+XDfYSxlFi+kUU
         8SdLROlzM4rBZnCm4oIHeJeWR9neEqA+QhFIk5CjiKAS2Iy3j52QaGdp9M3jjODLU7H0
         8mxdPDEKCgMyp0cUfGOewwfidJQaqe968tsEcL10zA9k9bhPgpTmmGj3HYj7UapUmGQw
         WYUnFjd9bxRV3neQdcSy2EfHDlkCaXz1RlnNRZxrknYQxh32biIjLItVkxQDQEU8/Wav
         5A5+LLFzb17JuU8yWQC1YPI2nURj+XLMW7zhoQsYbDnqTpSWbH2A8TnKZTzNpFxU+xCl
         mwVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753862211; x=1754467011;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GLaeAIqc00e+USukSnbAVMe5TgFLMlpYRPa2jWKuX/g=;
        b=esZddfVebAivqeuuOajdgugWOH+3Gu/Jgif9iYX46fF4/itySoOkR0zVlnerjN6bjo
         7WJlYsIaho8B4anXbHaUN8xNqPD3B0FpgKQ/uPjOAf+o0IGWfqABqS4iOnt0VxgZ9z3H
         eUcYMjmroXS2kN1YdJhD+Anv875p0RiHl+DrxsN7t+NgqQkydyLPFEk6BjDdGWmt+Q5Y
         G/+iqZQilD50X22dXeZ6gjeABBUlU2VROeuQq3xvtef6zpSiujRCd12u4Nqo7DKj+I8O
         bZ3KpVsU7M2e6nq/QpsUGtf8qsptm+IOFg49QZz+qWECKg5FkoVatRIojfI8l6mLUJAi
         CCEA==
X-Forwarded-Encrypted: i=1; AJvYcCXHAYAmcm+cRvn3RBJTAgZ6kykzo5u0ovGzQIhd4fR3je+zB16coh3IZ9Q776FdBKPSoIbz1QUjRMU=@vger.kernel.org
X-Gm-Message-State: AOJu0YylrP24oBmRGLpkxZRj6ThsR3Lv9w0Z2gu4MlFqGGKYoAIgbAHr
	2/qwTGYQN0hEDh0IYBDBq3PBd2+Zz9PfMA4zOYY3ipyow0nKjGoo9PcCD1OrzFEksduNXXfLUP/
	J3kfIJEOpw+JbdWmxgg==
X-Google-Smtp-Source: AGHT+IGDvFaMLBXu0klWBt4C95avW2dNPswDP4VOmyuf+KsNi7Hgiwedn0E92QWyR5XhNzUkZu0QiLLjbVDSw60=
X-Received: from wmrn20.prod.google.com ([2002:a05:600c:5014:b0:458:709b:28a0])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:8706:b0:456:1e4a:bb5b with SMTP id 5b1f17b1804b1-45892cea07fmr18028965e9.32.1753862210888;
 Wed, 30 Jul 2025 00:56:50 -0700 (PDT)
Date: Wed, 30 Jul 2025 07:56:50 +0000
In-Reply-To: <DBOMC68QGS76.2MYEXRE1I34VV@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250729102953.141412-1-abhinav.ogl@gmail.com>
 <CANiq72kRu5Wd-3Tk7px=2Y5kU5Tq2fQch=+f3ExYSrJa2+tSSg@mail.gmail.com> <DBOMC68QGS76.2MYEXRE1I34VV@kernel.org>
Message-ID: <aInQQqmDUZy40t3E@google.com>
Subject: Re: [PATCH v2] rust: pci: Use explicit types in FFI callbacks
From: Alice Ryhl <aliceryhl@google.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, herculoxz <abhinav.ogl@gmail.com>, 
	linux-pci@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bhelgaas@google.com, kwilczynski@kernel.org, 
	ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com, 
	gary@garyguo.net, bjorn3_gh@protonmail.com, lossin@kernel.org, 
	a.hindborg@kernel.org, tmgross@umich.edu
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 29, 2025 at 04:45:50PM +0200, Danilo Krummrich wrote:
> On Tue Jul 29, 2025 at 12:52 PM CEST, Miguel Ojeda wrote:
> > On Tue, Jul 29, 2025 at 12:30=E2=80=AFPM herculoxz <abhinav.ogl@gmail.c=
om> wrote:
> >>
> >> and improves ABI
> >> correctness when interfacing with C code.
> >
> > I think this still sounds like it is fixing an ABI issue -- I would
> > probably just remove that second sentence.
>=20
> I agree, the types exported via prelude are the ones from kernel::ffi.
>=20
> > (But no need for a v3 -- I think it can be fixed on apply unless
> > Danilo wants it).
>=20
> Yeah, I can fix it up when applying the patch.
>=20
> I also think the subject from v1, i.e. "use c_* types via kernel prelude"=
, was
> better. This one is a bit misleading, the types in the FFI callbacks are =
already
> explicit.
>=20
> Unless I hear otherwise, I will also revert the subject to the one of v1 =
when I
> apply the patch.

With the above changes:

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

