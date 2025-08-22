Return-Path: <linux-pci+bounces-34499-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE58CB30A98
	for <lists+linux-pci@lfdr.de>; Fri, 22 Aug 2025 03:04:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A05585C2CA5
	for <lists+linux-pci@lfdr.de>; Fri, 22 Aug 2025 01:04:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB09415539A;
	Fri, 22 Aug 2025 01:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cFir6WWG"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E25820EB;
	Fri, 22 Aug 2025 01:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755824650; cv=none; b=Dor/2PSqVBOScnJNIJC4yHk1JHqMZ4W6Ze5wUtbFneqm3s1LMjgqvcpCOS6joCfkS0PMK1lOmPIUQc4IK7aL/dtyfI2DAHpCfjcQMAJH3V6V0lrkEMKoatjx1MaMj+n/ms3Otj/Ggc2yIhjWT1Miu5InZlUGdZ0HPvT1UAZvUnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755824650; c=relaxed/simple;
	bh=m/oT083UvBsRBS6hZ73RCoP0PWmJw7QiMgbEgQofiOc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sahgk7+XTDbHyfKFi3MuXpGOW91uFtPz+rw9jgM0CO0fwsZAoRiAtS15ZM4qMrZlo5fZChJa6Ysgh75ZTn29eIn8na4X2ZOYbPrZ0u2gPmDm+SZLbv4+6XOCLCFh61Ddq6CriwNzX3sKckhArWZpIoiq6LuDzO1k9XH3hd2ca/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cFir6WWG; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-24641067be2so227505ad.3;
        Thu, 21 Aug 2025 18:04:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755824648; x=1756429448; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m/oT083UvBsRBS6hZ73RCoP0PWmJw7QiMgbEgQofiOc=;
        b=cFir6WWGnpwqI8AO7S4LMM5tXDz6Yhk9qcV41Ikv1iR8J2zHkV3Np6nKmJYrSMBPzj
         4e9/Uzon+mOIXq1M2AUZMPReZ3jzu+paCxqxVo1ymgmvBFJN1Ekr1aU0CQdIHpYFIAld
         cT3cVqKjIe8kc9xumkSFtCEXtkBz0db7C8/aJarQr2MquEJCm8sx5aArHvk/I06exGkD
         74o8CYV0wjrbujv2nETuobuViL70uRcG/NpQ5pD9TsgLWvaEOPeqhwsxrwQrG+vEd81c
         jV4fdEJQq3KwIwSNDQtBVUTyqX4WJbZnDmhdGtHrPJ+YyMwsn5R5hGJjYGi8MGFzOSCf
         j4kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755824648; x=1756429448;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m/oT083UvBsRBS6hZ73RCoP0PWmJw7QiMgbEgQofiOc=;
        b=Fjz3GXBs0DVgom/zC7DAhKywRPxvqJ83ny4K5GCFBh371PL1bhcCBtr9oGy2X6/9ED
         tqIC6rwBjPq1GG5xVDCzT4eO97d6nr3QxDgizn9dhtNCjXx2kLQEhPbMiDyqCTUP6Sin
         ly5gVB8KHhyu445VhUbk6F5d6hqFH+1x/SOlETnLRfn/dLcYeQgHuwWu9QdNue1dSa9H
         yTdYWgv5VFOCMaHXw6saAhJuPPtlvuaGC2iMTRBQCTOaLEb2PeO3aGjrByjLR10Aq2GS
         +p41SI4JdKpWAhWL/kj/QWsgzWic++6W9kUfZM+Yulx8Rln4nze2xGEJCxHn0L0B6oEu
         6JuA==
X-Forwarded-Encrypted: i=1; AJvYcCVjarvW9TndB2krrPWya240KCqAmJtp97C4u6Ds1N5n3MV+FF2Ko8Vg7GVrKMKytpHkt/ba+axBDCWT@vger.kernel.org, AJvYcCW78gRPSsmjsz4s8BtlYisxQYYLhPR4aeUBOT1M06M2ff8dnO1MYtYZXm7jvYH2A+h/Hj0MplHBoH8sGMw=@vger.kernel.org, AJvYcCX6lWUPjrGYXclnJKpl0nAuKU5dxg7OUrd0PAttHsXf5n+ZBqrbzszl27uDab/wQO8dLkSg55byFAz8XQJkPNw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9AZffC3sC3uq4UJRGX3w+IbE5ujiD22JkQRDilVS4QZXlAMBo
	4hPQuJyRoC5QPIl63b2tUUf1ctLgibabVtQviPupV7LJxyrEREtNpTt4UPN9J6g45ZJhQaFrv5w
	nJTetFQ1F7Jepn+SG7VhFnJmpbz6U+srXjzfg
X-Gm-Gg: ASbGnctb7N4l4gzMh9CWFklOeZ3BhzcGJn1FziWY5Gazx7m0XSiKLsZwvffliqDsxAR
	71C9Pi/cJOyyeeClUxabYX1Ick5kf44+wPLg/9vdC7bCPvcwykZ3EyR9zdPGQ65z8TUUtP4Wnwi
	FvLOOAdxoPAPtQ8H+/5eB/bo+qfkAumUNhduCdYQ+OmSVFFt00vQy2HD0i66Hwcpuhe8Tiiaf26
	ofUVJWG6ukntutw52I3RU0G61LpD6hZJR5xAIuLMaDBhNVJFkMouAytDJkLnPsG8MLNTj2nVlii
	nUneo74qmcR3av3RCxHayC+6Ag==
X-Google-Smtp-Source: AGHT+IG1pfrx0CDcHH5YIWUaVT3XeEYgLK2FE/WIstqerPC4ya0XceUMKWOuBRJ00fvYKDFqfW4XYx3/m37svKscg8Q=
X-Received: by 2002:a17:902:ecc6:b0:240:3e72:ef98 with SMTP id
 d9443c01a7336-24630149490mr8902805ad.10.1755824648271; Thu, 21 Aug 2025
 18:04:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250818013305.1089446-1-jhubbard@nvidia.com> <20250818013305.1089446-2-jhubbard@nvidia.com>
 <aKVFVO3wbzClcLwg@archiso>
In-Reply-To: <aKVFVO3wbzClcLwg@archiso>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 22 Aug 2025 03:03:56 +0200
X-Gm-Features: Ac12FXwhH15AUsgGlwJRqyMw3OprDu14FpxrTqbVSws_CTfUXO2lf2JLddNl5wo
Message-ID: <CANiq72=aavHWOSxnLh3L8kR3BcbznZPFJWDJJJxEm9cssYe-=w@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] rust: pci: provide access to PCI Class, subclass,
 implementation values
To: Elle Rhumsaa <elle@weathered-steel.dev>
Cc: John Hubbard <jhubbard@nvidia.com>, Danilo Krummrich <dakr@kernel.org>, 
	Alexandre Courbot <acourbot@nvidia.com>, Joel Fernandes <joelagnelf@nvidia.com>, 
	Timur Tabi <ttabi@nvidia.com>, Alistair Popple <apopple@nvidia.com>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Bjorn Helgaas <bhelgaas@google.com>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, nouveau@lists.freedesktop.org, 
	linux-pci@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 20, 2025 at 5:48=E2=80=AFAM Elle Rhumsaa <elle@weathered-steel.=
dev> wrote:
>
> All of the functions could probably be `#[inline]`ed, though I'm not
> sure how much it affects the `const` functions, since they're already
> evaluated at compile-time.

I don't think that is guaranteed unless called from a const context.

Cheers,
Miguel

