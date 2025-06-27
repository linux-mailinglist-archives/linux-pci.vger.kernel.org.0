Return-Path: <linux-pci+bounces-30928-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 929F2AEB9A8
	for <lists+linux-pci@lfdr.de>; Fri, 27 Jun 2025 16:20:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A72F644B4A
	for <lists+linux-pci@lfdr.de>; Fri, 27 Jun 2025 14:20:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5E9A2E266F;
	Fri, 27 Jun 2025 14:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Wj5HvjzU"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16B172E2EF4
	for <linux-pci@vger.kernel.org>; Fri, 27 Jun 2025 14:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751034016; cv=none; b=O44RNVUb6NQVGOAwlPFy3/dcuXQaeRPCr3CO5YIH0pAS1mS/fL5lj+FHxaefhNexnxd2nmC2ePwzhfC4EyuxVo0sT8eoWj9w6XSdEXkGaDgbQGxyXXgdFX7xRCGWguHDXzGqdp/Ww6DF9otQ2wuE1XhR3ymrSvL1ZzuhPU7FY7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751034016; c=relaxed/simple;
	bh=jcgyQ/Wb57DmrTUIgukktQYvJFH3Ks7NSRCZ88mZKhA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mqlNWaEGbYnRLSxrv/TkRWNhJc/cBqcOOP7E4lk04LGUYe3x36F6byws0roQRNCYV5e3es+90qcMyA/dwbSI4youYJAx7A/HFrbcrYChazBGbgWP4Cu23wAyvlIYBHzpkJyC6dMANWYNatzMNNOnDA+cif8Y5v4fZRM3lr34qSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Wj5HvjzU; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4536b8c183cso13745765e9.0
        for <linux-pci@vger.kernel.org>; Fri, 27 Jun 2025 07:20:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751034013; x=1751638813; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ewNn7TbsI9nptiuY+MPrd3pQGAHs48Wda8epNcT5ov8=;
        b=Wj5HvjzUmphSjCjlc0YseYt6jUPSbqWIMrqtwWUI/5HIotpAQ5pt21iGxJbOMFyqVT
         G3Xh3aXYpGAGNiYbyFrUvGwjsHw+7EK3zpGnhpEH1/bR3rQWspqs8Ln8mGIRKoBETcWZ
         5XasAQg/R9cYqnGnuUTyCjVvtrPHjHXHDkQdV3SbsrsihDv6LLcmrzNj8hRktupShbrw
         YnM3om895qAQLG6KU4/mS+6JglDdw3cyWr12PTVLVMj3AE+Q1/+qkxMc0m0LarI2PQRa
         sKhuYMW2JqxqFOMAd+R09BNqS2hD6U/40WVJnCuFgqC4MJ0EqrPuX0N6ZhsMtP8pLEru
         ofiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751034013; x=1751638813;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ewNn7TbsI9nptiuY+MPrd3pQGAHs48Wda8epNcT5ov8=;
        b=ciFuIf74xYYIlJnqhRlTAkCe+TkHr6a/gfXYMo15MYab/XjTuXUwpRAu0Jq1MgEmrW
         38EKRBGFcggJ20c4qqScNJzYXZkk+9C6Yxf3Z3iyqTfltxcJ9uH4d9GUfxZISeNMMA9Y
         oHgEDRsrDYBE4CoY/8RDFT6gAzWToMWpUb1/8tznFxr2fqrJ28v578IOF02tS5bJ84rv
         D/N7b1VULbJ9s4qh+bNrnBXIlkQx4eLL17h9M10xLc6vBlEzrVNKmdC0C6PNMQ/tpppW
         mEg5e3fE/diIREWn/u86o5HxgqVBObhTP0uyNDlUUi12+M+L+8WRW+V316Y8lempsypV
         uehQ==
X-Forwarded-Encrypted: i=1; AJvYcCWTb1094PJWjL6PraT/C1v7RFmdtre1QzwYrQhAwJVh9r8TlibfYFdyWKa09s7PF5bVIgz28VThXfs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAZMPBLKuN2cddHcwGXlWMQalMH+p/J4dcZaq4h+sbU+ajWEA2
	OUThKeiwsRWbc/BMnQUXsKxPbZ6hxVPKGUcOmXkmo4F8l3i+g2Q9JzngJK+Vl/WhalyfIlOnf+h
	vKKvPwPxTcOnrNav0ghRoIrVLnPtzCHKaXpX5d9ip
X-Gm-Gg: ASbGnctItrWarwqnoXynkykMuDEYmhIi0oe5thrPC5xfdgS5eI7wbzzBnqM+j1CFhdm
	XSZfZBh6t1CH95CetUzY/prDJPJ+4oRhVLJ59SB9jJAVrvV0bm0Y1PPb0z6wm6yWqwFCpjMGBuV
	QiemiaOAMAQrhi4pcfl4PQVtM7YPxE1fHU7rhuguov0NV+
X-Google-Smtp-Source: AGHT+IGGHWkxWyyUt6W5NvWAowE9TgOpr1q1dTjlOVA298j2/3hVnCN4kkLIkapxhylrsGEkNu9XQ0BMWNlolyX/fns=
X-Received: by 2002:a05:600c:8b35:b0:453:79e8:e92d with SMTP id
 5b1f17b1804b1-4538897ac42mr78218735e9.5.1751034013197; Fri, 27 Jun 2025
 07:20:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250612-pointed-to-v3-0-b009006d86a1@kernel.org>
In-Reply-To: <20250612-pointed-to-v3-0-b009006d86a1@kernel.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Fri, 27 Jun 2025 16:20:00 +0200
X-Gm-Features: Ac12FXyulcsSB1OX5HOWOJW9F1TKemz6x-0C4Ue0kt788UFAeHm37sy4APARLhw
Message-ID: <CAH5fLghdgP7aBBv3aMrvWP3sfRjM_cc72Wsp=CZczh9dfem3Ow@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] rust: improve `ForeignOwnable`
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Danilo Krummrich <dakr@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Bjorn Helgaas <bhelgaas@google.com>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Tamir Duberstein <tamird@gmail.com>, Viresh Kumar <viresh.kumar@linaro.org>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org, =?UTF-8?B?TWHDrXJhIENhbmFs?= <mcanal@igalia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 12, 2025 at 3:11=E2=80=AFPM Andreas Hindborg <a.hindborg@kernel=
.org> wrote:
>
> This series improves `ForeignOwnable` by:
>
>  - changing the way we assert pointer allignment,
>  - improving the safety requirements of the trait.
>
> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
> ---
> Changes in v3:
> - Remove more instances of absolute paths to `ffi` types.
> - Reword safety requirements in terms of function guarantees.
> - Add a patch to restrict use of null pointers with `ForeignOwnable`.
> - Link to v2: https://lore.kernel.org/r/20250610-pointed-to-v2-1-fad8f92c=
f1e5@kernel.org
>
> Changes in v2:
> - Replace qualified path with `use` for `crate::ffi::c_void`.
> - Fix a typo and rephrase docs for `ForeignOwnable`.
> - Reorganize docs for `ForeignOwnable::into_foreign`.
> - Link to v1: https://lore.kernel.org/r/20250605-pointed-to-v1-1-ee1e2629=
12cc@kernel.org
>
> ---
> Andreas Hindborg (2):
>       rust: types: add FOREIGN_ALIGN to ForeignOwnable
>       rust: types: require `ForeignOwnable::into_foreign` return non-null
>
>  rust/kernel/alloc/kbox.rs | 41 +++++++++++++++++++++++------------------
>  rust/kernel/miscdevice.rs | 10 +++++-----
>  rust/kernel/pci.rs        |  2 +-
>  rust/kernel/platform.rs   |  2 +-
>  rust/kernel/sync/arc.rs   | 24 +++++++++++++-----------
>  rust/kernel/types.rs      | 46 +++++++++++++++++++++++------------------=
-----
>  rust/kernel/xarray.rs     |  9 +++++----
>  7 files changed, 71 insertions(+), 63 deletions(-)

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

