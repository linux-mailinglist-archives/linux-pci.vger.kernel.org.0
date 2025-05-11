Return-Path: <linux-pci+bounces-27558-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5C2AAB2A41
	for <lists+linux-pci@lfdr.de>; Sun, 11 May 2025 20:29:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52B5F3A1F65
	for <lists+linux-pci@lfdr.de>; Sun, 11 May 2025 18:29:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE90225E478;
	Sun, 11 May 2025 18:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NLqoiMip"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48FD543169;
	Sun, 11 May 2025 18:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746988174; cv=none; b=fZUelYYcTD90IU7Isz4y3Ya3OC2trtaIe0FZC7ChXMnHlFW03ZrBnxNsjB90utHJr2FV3vnhpYO/S5CWcHLq2dir1FgSmHJG8H7cqxKMglgdIIitdELGUoccxmLKfkpp1OipE+jtciN455rC8xsenUEZbVoQ7NJRcDZFy8F7ukw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746988174; c=relaxed/simple;
	bh=rICF+iiakKUN/IpgaRD2u2wYA00+d5GkGQ6xuLiHXmY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jfIJKkhG47g3xNGeF2JwhI+oOt3EC2S9AXVGYBbqaLB1s0olxr8OaWbJtVODyhLLrJ707Db4qT0HMr33ASnrA0oC6CjaWvArTrAcDnwMnu5g/qWXf9UGAi7HwWyDq8lnaZC21IvK+1rIVp3BkHiMPckR6ZARzKjGg1Do67OfNLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NLqoiMip; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3087a70557bso587295a91.2;
        Sun, 11 May 2025 11:29:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746988172; x=1747592972; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wz6bm1GgVl6/KNAsi2e5kntzR66VhsqLNXmVVaeeM7Y=;
        b=NLqoiMip0N9LOTF1zSvXY6sOEkNSWg16KK63m1+mYLhSEAIF3h4MZ1dv1qcWCk702s
         RgZ69D//nbtv+2OP9BSC7kSdlqa2p2ivS5Lq3CD9zIage2MPq71EmqSXdgHTGJhHic29
         Nr9Ds5l5QghgeF0SjiIv1oUH1I8WUkWQsW6RMzWSyIWPdQD0MQGwaC9KxA/O5u1+S/W7
         FRzXW/pHGWMjwCykVxVpYL3VCS7zX89MqIyk7+JGZgLURYrZlVCSsFCQZ4Lp7uEYWNu0
         GDwNugTZF3vMplYBFOpHRl+4R4A8T/dDQHhofOJnelT+KSlUVRUk+kMDkMFCaXbBLm2V
         lxzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746988172; x=1747592972;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wz6bm1GgVl6/KNAsi2e5kntzR66VhsqLNXmVVaeeM7Y=;
        b=rXKH3mOR/UQvSp58WmdK2z5bsEuVkDDQA9F8mF6wz8pe1HTk+nKINKtYRHiNPjCoTE
         rDMZtYNlO4a3JgW0cvWHMsvERN0uZMuAEN/XyUzYzrbnHwuKNe/ZKOef9oOOw6sYFgft
         3YAEU/vO9QE1zNoupxW/QcD837Z+0Pfi/tE2kbu4O/H37BaMElGe5C9G1ayawbHYJ1ks
         uZms0g8Y9nVb9KykVKppojCsUNxeSR0mS3Lqdas9gBt8gASjX9dVFFIXMLKDlUMF2OAW
         zYcrI6r38MTkPrca1yCwJJjcyJp17lW/8Qu1L24K+oU2PDlYhCy3EUD8AWAP68VEhlUw
         8sNA==
X-Forwarded-Encrypted: i=1; AJvYcCVnMLMGjq6DcVemAZs0YdG16OCWlzQfSsFneeZTr+MT6DcDmwrawi0t/6K/ImKZ14TNDLYd0Qd+qfVjNY4GeZA=@vger.kernel.org, AJvYcCW020sC6+05BiXMvQvc83Du/DcY+mxjmnMLY8LZskRMB5AMivCRmfH+3uZQG1/D2UcYlF4F5vmXNZndwqc=@vger.kernel.org, AJvYcCX7Iqn4aZT2Ngo06KI/71Yx4R8Ha++80YkaTlCe21bRxoH6tN30t3qk4Fw6QxKLZB9GXFXqcrGdwoi0@vger.kernel.org
X-Gm-Message-State: AOJu0Ywmsq3aXl4ooyqQVRlxDka8wXcYZd9sOwHdvSG1mqHBVyS21YdC
	1jBGChZpclWws8ay+f+TMnqkyEBtraVp88imAEK4zPwRgi0tF6shnC6+slgYgyLjeeHT4qTmrEB
	nCtuPpgc8M509CAXzK++XkyXY/dX0lsZztLo=
X-Gm-Gg: ASbGncvzb0Zi+0YLN8HXqx+X/0fFMTwNjtxUypslfpRxQEyRP2svDfXT1QcP9dkZcnu
	nkvC6GPTjZpn9sX3S2BbP5v1yQYsdoemkjSwVQkImJi46n8WIfSMT/M5lQad85AAr/GtkuxW9qj
	2eP53KuufWEU2wsjyxDXKcJy5lMofq4CLU
X-Google-Smtp-Source: AGHT+IHWOSR9A/JCAuFZu+UDzjOsvysFAKfQBFPIHSdBGX3X/A9hDX0aKl6lTriTlc2MIvPho/zaV3roTJvmt050Wsg=
X-Received: by 2002:a17:903:244c:b0:21f:356:758f with SMTP id
 d9443c01a7336-22fc8b0b6aamr62602245ad.3.1746988172460; Sun, 11 May 2025
 11:29:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250428140137.468709-1-dakr@kernel.org> <20250428140137.468709-3-dakr@kernel.org>
In-Reply-To: <20250428140137.468709-3-dakr@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sun, 11 May 2025 20:29:19 +0200
X-Gm-Features: AX0GCFtQoKnmnCFXJJmm2XcCSBjKVOOREoms9iBsFozi3_2Nk3F0sPXg7CaXj8o
Message-ID: <CANiq72=x6a8aAko52=Un2u=1u09+cBF14xH6=DXOD8o+0JH=QA@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] rust: devres: implement Devres::access_with()
To: Danilo Krummrich <dakr@kernel.org>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, bhelgaas@google.com, 
	kwilczynski@kernel.org, zhiw@nvidia.com, cjia@nvidia.com, jhubbard@nvidia.com, 
	bskeggs@nvidia.com, acurrid@nvidia.com, joelagnelf@nvidia.com, 
	ttabi@nvidia.com, acourbot@nvidia.com, ojeda@kernel.org, 
	alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, 
	bjorn3_gh@protonmail.com, benno.lossin@proton.me, a.hindborg@kernel.org, 
	aliceryhl@google.com, tmgross@umich.edu, linux-pci@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Christian Schrefl <chrisi.schrefl@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 28, 2025 at 4:01=E2=80=AFPM Danilo Krummrich <dakr@kernel.org> =
wrote:
>
> +    /// # use kernel::{device::Core, devres::Devres, pci};
> +    ///
> +    /// fn from_core(dev: &pci::Device<Core>, devres: Devres<pci::Bar<0x=
4>>) -> Result<()> {

We need to skip this one when `!PCI` -- quick patch at:
https://lore.kernel.org/rust-for-linux/20250511182533.1016163-1-ojeda@kerne=
l.org/

Cheers,
Miguel

