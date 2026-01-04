Return-Path: <linux-pci+bounces-43971-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EFBDCF0F66
	for <lists+linux-pci@lfdr.de>; Sun, 04 Jan 2026 14:09:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 008F9300E7A7
	for <lists+linux-pci@lfdr.de>; Sun,  4 Jan 2026 13:09:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 388842FA0EF;
	Sun,  4 Jan 2026 13:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fb1nuK4w"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11E0F2FA0C6
	for <linux-pci@vger.kernel.org>; Sun,  4 Jan 2026 13:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767532157; cv=none; b=IXT27KRvT+nVDIenZ5gqCNSIzLYH0ruJCjJSdBY6SZs5PxaMHhi/p++++whukg47aRdj17Jo9+2faLtNJmACYu9OsG5kYOLlqF+pAQU/uvpnPT7ZvXXLsdDHl1vgakntquKbMCN8ElgSnBC8VoZMxaaFtl8Th0S1t53h+xu3Ttg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767532157; c=relaxed/simple;
	bh=xhbBpZPjeFau9TEO0yHrCoV89RWRT3dACYB9ZeecuX8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aV02oyXiDGz07ADMHYl+rW/3D6j8ZBJhhh3e/l9F0VJy+Fs2KInGxKsKhMpe6b0ahGapUGeggH/SFt6hmej40lvp8f4Qjai+AUnjB2mkyEoAKawBa7E9c2Tpd0Ur/zV5Ab1BBVgYjPGnDobAtfwJnmTj+J6rg/lDu0KlduY3DKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fb1nuK4w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC7A8C2BC86
	for <linux-pci@vger.kernel.org>; Sun,  4 Jan 2026 13:09:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767532156;
	bh=xhbBpZPjeFau9TEO0yHrCoV89RWRT3dACYB9ZeecuX8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Fb1nuK4wKOB4Zvj7Emeltybcths6AjP3kHZ1Mtbso+hI3XI+m6bhJWRP3OPe9CH4a
	 SB0vcex//y5dounwSuAGCTqT/BYfmEA6Bdu0qwVLIAbXLr58p6DlXjIH8V7mRYBLb3
	 p12W2UqfIk4UVic2W/UZXH/EWqFK2VyuJ8SHD2ZxEV8+uNyiNAFpVCQP0hsMqFodtp
	 P/d8/pvayEZjiTtSklyoLteU00Ij3RK0EPgH2we4TOyINQIFai+Djd1EgIGkQhxUjv
	 F2Eq+tzbH7sTwbIRAZ3EPwJks83eXFdx3eFjRLTqUoRfVsFfDoUvFhvk761ddcRlMY
	 XTcuQ6br98iYw==
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-64b7318f1b0so15791095a12.2
        for <linux-pci@vger.kernel.org>; Sun, 04 Jan 2026 05:09:16 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVGo8wt+FW4neBPZEJPJQem0rhAxKcJp5ms93R0FLKgG7RucDU6cwM/XXTXLkZ1dhTv4wv0NGoN95M=@vger.kernel.org
X-Gm-Message-State: AOJu0YysxaGe4Uy0HjIJTua9F+gjSeQ6I0jw1AmGO00mTCT+3o5Q2E8r
	pUfzQYO+mJ+nfX88F6MptBQEd7OwzHW//MJoQZ3MmqmGWxh7eZR8fGsU2zRUO7ISy6HdtzN3KmS
	bCvD0oARUymdJi74qGoHiGItH16uYNBI=
X-Google-Smtp-Source: AGHT+IHTd7+rkGWj+5amevkc7uqoJRZS0EY40dfZqALuYmRhehRsVVSUnLbKz8VkocRwjK1iryHSKjtruaQIC8y9D/Y=
X-Received: by 2002:a17:907:724e:b0:b6d:5bc3:e158 with SMTP id
 a640c23a62f3a-b8036f2ac34mr5020185266b.17.1767532155199; Sun, 04 Jan 2026
 05:09:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260104-loongson-pci1-v2-1-d151e57b6ef8@uniontech.com> <9ddf7822-eda7-4c6c-9240-31ab1c4708c3@aosc.io>
In-Reply-To: <9ddf7822-eda7-4c6c-9240-31ab1c4708c3@aosc.io>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Sun, 4 Jan 2026 21:09:11 +0800
X-Gmail-Original-Message-ID: <CAAhV-H5xfqXQA600YPAB43H9phOyUAnTiPsOH7Qxztu=D+-9Fw@mail.gmail.com>
X-Gm-Features: AQt7F2qLjPUqyx4dpaY_lZeOY3JtwPHfi0peRTrmFWBxFvPwpqtwUyeT2MtSjw0
Message-ID: <CAAhV-H5xfqXQA600YPAB43H9phOyUAnTiPsOH7Qxztu=D+-9Fw@mail.gmail.com>
Subject: Re: [PATCH v2] PCI: loongson: Override PCIe bridge supported speeds
 for older Loongson 3C6000 series steppings
To: Mingcong Bai <jeffbai@aosc.io>
Cc: liziyao@uniontech.com, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	niecheng1@uniontech.com, zhanjun@uniontech.com, guanwentao@uniontech.com, 
	Kexy Biscuit <kexybiscuit@aosc.io>, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Lain Fearyncess Yang <fsf@live.com>, 
	Ayden Meng <aydenmeng@yeah.net>, Xi Ruoyao <xry111@xry111.site>, loongarch@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 4, 2026 at 7:03=E2=80=AFPM Mingcong Bai <jeffbai@aosc.io> wrote=
:
>
> Hi Ziyao Li,
>
> =E5=9C=A8 2026/1/4 18:00, Ziyao Li via B4 Relay =E5=86=99=E9=81=93:
> > From: Ziyao Li <liziyao@uniontech.com>
> >
> > Older steppings of the Loongson 3C6000 series incorrectly report the
> > supported link speeds on their PCIe bridges (device IDs 3c19, 3c29) as
> > only 2.5 GT/s, despite the upstream bus supporting speeds from 2.5 GT/s
> > up to 16 GT/s.
> >
> > As a result, certain PCIe devices would be incorrectly probed as a Gen1=
-
> > only, even if higher link speeds are supported, harming performance and
> > prevents dynamic link speed functionality from being enabled in drivers
> > such as amdgpu.
> >
> > Manually override the `supported_speeds` field for affected PCIe bridge=
s
> > with those found on the upstream bus to correctly reflect the supported
> > link speeds.
> >
> > This patch was originally found from AOSC OS[1].
>
> Thanks for the patch. Looping loongarch.
I prefer naming consistency, which means loongson_pci_bridge_speed_quirk().

Huacai
>
> Best Regards,
> Mingcong Bai
>

