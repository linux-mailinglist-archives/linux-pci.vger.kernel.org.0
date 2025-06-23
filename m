Return-Path: <linux-pci+bounces-30467-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 55033AE57C8
	for <lists+linux-pci@lfdr.de>; Tue, 24 Jun 2025 01:15:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E543F4C7507
	for <lists+linux-pci@lfdr.de>; Mon, 23 Jun 2025 23:15:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B9A522A7E4;
	Mon, 23 Jun 2025 23:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EprXylQH"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07119229B16;
	Mon, 23 Jun 2025 23:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750720533; cv=none; b=VcbABdhn4VwLpb3QlOq2TG1zJlqjdjE6MarTBz6fSXryYuxyYFR6YpA/yPqnRRhNkws6Bk7Z2u+Zii3cMMU33FSPrGSqGnMn8gdSvknDCDw8ejX5OkZPAYoLmuSziOaLAxX5mH6+5aGsDPmIy9Vne7Kk464Lezh7GpK/sn8lmrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750720533; c=relaxed/simple;
	bh=TRl0+p+jrdHvCnb9FZSoYZqE5p28+PTZwicHcD6Bths=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ugdYIkXnFfKf6dXgMz1gAEODzTIto3Stj9str60Q8x4aJeY84r9FbLWmNFB3SvcxDcV/trRQ1z2X1tCmU1rywkDlnSUE32axc26qoGnv4vP2Lg+htBw/dJrbqBDpBgfgqiK3T/QmHOteB5tuIhcjYMMMlPIa35uit8ye1p08CKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EprXylQH; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-234b122f2feso6084705ad.0;
        Mon, 23 Jun 2025 16:15:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750720531; x=1751325331; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TRl0+p+jrdHvCnb9FZSoYZqE5p28+PTZwicHcD6Bths=;
        b=EprXylQHTyBd6vPhucqS5aRjLWIS51+opgymex5rQ7d/zeP3JThZXp7L2iQ4mlYrl5
         2US8Cz0wBjiFo17lTUU+z3YnYmxmwn1k9xPtrQG64Tuos5wPmDQ8Az9dCCJjJUauZjgE
         MkDMiruv0gg/t2h3lNNwmQ4wx9TWXv/71fqJN0QtS7tgCDCmUjvdzjA/9rOVuSchng6i
         mrhL86xxKcPtAHZwZ7gNhH3MaHH2tI/SWEMkovloDNz9MExypxvtGcwWrIKgYl+XOlWJ
         G+8a49dTe+RZH96pIoNRLxZCRIReqcl4bcoH09tYElnHg9XebjvVq0i4CbTcTn2/AtmB
         oizA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750720531; x=1751325331;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TRl0+p+jrdHvCnb9FZSoYZqE5p28+PTZwicHcD6Bths=;
        b=Yh3Us2wB1JYeVNKs8AgveXP4qkkDa2Tvzp9rQ3X0IGBeCUvDif7CEnWMqxVAnlf07x
         W2bf3I7QYwfcVSRf2gm1QwKEo/ANMgs0i1pYmyj0mhcQtyai675QpvYI5UBDJs02hkCe
         mYG3WMO+em5ZXRdPzWqYWfXTffnFyP9cQS9Zpl71t8Ja5SvnSz4lg7771DDevbgENA8X
         e9q0NrE5K/EOHqcnbZEdUgD9P1L+hyDVTQ7Z4x0bk6oaYIZwwAStSmJ8R5PcYkuvxg+P
         O//KBegN41NAldZQs9Ag0xZ6p2QeyjE/tfk0hajkAP9BQckLrCFqjKXkJtkvGvxayqqt
         4GGQ==
X-Forwarded-Encrypted: i=1; AJvYcCUED5iaJEZnvys5C2SDsP38OrjAd23pFB3xX4arBRfTbVUCn+2pMIH+Rxa3H0hT9cOSZf6NdyI39hXD7zxB@vger.kernel.org, AJvYcCUfH0b6u8B2Ro0DjxPzB4If06TZVGLssAi6kNgwjkrsrmJyxVWTYMllxFSxfVr0kjRE0PBxgIGJi/yXl5OW5Nc=@vger.kernel.org, AJvYcCWnk7eDDED/g14jYXIs/5/eClh2H7y8j6D1qjlWfLwYmZh3ZyspPgdKOMm8LftqbdGseLlfQgqlw29T@vger.kernel.org, AJvYcCXrJFH+MR7EGzDPtcQ7k3N2rKtPnuSDu7LfHTbNy44JIAeuouRKE9Oi5wjhC1vT15HP7cIC02mYU3bl@vger.kernel.org
X-Gm-Message-State: AOJu0YzL5vo75/rWT2yJnbZ0Q4W6u/SuB8zSTiTV67U9vc84Uo4R8juC
	pjRG3VzI8EHed7nTyfMGG1m9pg0Msh6qw5NZZh07QLDmZJOginS0Cuz2H7Vy+7k0kCkSNvcDerC
	Q25K+5D2oIadKKaSdYpl0Kls27dXf7p0=
X-Gm-Gg: ASbGnctbKYToGTr8YOCjPYsNZCPDPeeYCLaepTygALrnvTTp1Pe/m58YeUD7kGoAP+P
	R6xGUccHibgYvH/BzISx4aJU/O2iCncYkC6mJ1OKcC5kKp7z1lAhDTI+U/PVAG2j1DWx4lI/tIa
	KbwPAZ/d1PH47IwkqckrQ1V4r+qc8yAdwFLD08gu4EC88=
X-Google-Smtp-Source: AGHT+IEC7ho78SQgsaeN6q4AwKfEC47488zfkhERu+v8xcfCtxiQkAURHCdYUqFdhvEtneSoYJlGM5Vil8YO+3c5hMU=
X-Received: by 2002:a17:902:f547:b0:235:239d:2e3d with SMTP id
 d9443c01a7336-237d9a7513cmr76716975ad.9.1750720531155; Mon, 23 Jun 2025
 16:15:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250623225846.169805-1-fujita.tomonori@gmail.com>
In-Reply-To: <20250623225846.169805-1-fujita.tomonori@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 24 Jun 2025 01:15:18 +0200
X-Gm-Features: Ac12FXzhVwJQmdWGNlkk5XZjEkFRfHTuAwlYi_-pSvjUB_1-gW_-1kjZDIajmgQ
Message-ID: <CANiq72kR=yFrMUtvOVp__QSNT574f+HwwbpVAvw7D8LeBs1pmw@mail.gmail.com>
Subject: Re: [PATCH v1] rust: fix typo in #[repr(transparent)] comments
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: alex.gaynor@gmail.com, dakr@kernel.org, gregkh@linuxfoundation.org, 
	ojeda@kernel.org, rafael@kernel.org, robh@kernel.org, saravanak@google.com, 
	a.hindborg@kernel.org, aliceryhl@google.com, bhelgaas@google.com, 
	bjorn3_gh@protonmail.com, boqun.feng@gmail.com, devicetree@vger.kernel.org, 
	gary@garyguo.net, kwilczynski@kernel.org, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org, lossin@kernel.org, rust-for-linux@vger.kernel.org, 
	tmgross@umich.edu
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 24, 2025 at 12:59=E2=80=AFAM FUJITA Tomonori
<fujita.tomonori@gmail.com> wrote:
>
> Fix a typo in several comments where `#[repr(transparent)]` was
> mistakenly written as `#[repr(transparent)` (missing closing
> bracket).
>
> Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>

Thanks for fixing the typo!

Looks fine to me.

Cheers,
Miguel

