Return-Path: <linux-pci+bounces-15949-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 65EB99BB559
	for <lists+linux-pci@lfdr.de>; Mon,  4 Nov 2024 14:04:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 97AF31C21ADA
	for <lists+linux-pci@lfdr.de>; Mon,  4 Nov 2024 13:04:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 303921B85FD;
	Mon,  4 Nov 2024 13:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ch2XakdP"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02FB91B6CFB;
	Mon,  4 Nov 2024 13:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730725486; cv=none; b=UDYSYHvGZboCMqVW9CAxlXInFLZQt1Jtll6hpB90ji1Ah2hn2FgveiwyJPxgdeJtLE7hXW8fE4BgMdZiamKaUpPR1Kl3nGhG60NJJInxwjyQvpboSCXqeEnVJmdPpJR4vDJ9ad342+745Tbf0PoFqi/u8m4rZ+i/I55painMZd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730725486; c=relaxed/simple;
	bh=nefS9y62W+X91RKHUNkgHd12LtP4HJ+GhKwwmgnAOgE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WG+Aw4Ex4zyu8Nzk1ewb9b20Q0k66f4qwaUJCFJIkzaYo+IxtP8Udvn63xXKh6L0oIm4IsyTgsnQk9m9pQDYvh1Z6YBGQAEm/kTS7/zUzDSJ/599p4AG8ZpAf1FszklvP/Cg2wxnZAy4U+ujRrszB/m9IEJAdI/C/ykF8en1grc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ch2XakdP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A092BC4CED4;
	Mon,  4 Nov 2024 13:04:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730725485;
	bh=nefS9y62W+X91RKHUNkgHd12LtP4HJ+GhKwwmgnAOgE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Ch2XakdPeyVjhVz+nE8nY23yzmQaM5+ySnORQ/Aq2DFApEkCrOkMhgZyoABfk19tI
	 v6gDfVRbwi5ErHBb8lrSju8xJ4jVvwRnAbxCNo3bT9voNlcFjBRtBjHu76IHwml+wA
	 tue5NvjBFp0hlIka/KReEocBN38Pdqc90lepjDyrFxXUezzl8zP2z2xHaTp4bPhJDK
	 P3AdBE4pKIGf4a6BtN0lG38cWt84t9TGmPs6JDm/GUN/k1etSHjo8w6WpTNIuGWa7j
	 +DUhVFxJkGm2qWby9vH1IzxIsVan9f3axPCAzIiAyoGpfyYp26KztYjjVnJIUoPYa6
	 BXvnvQRPd4VIw==
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3e60f6ea262so1918480b6e.1;
        Mon, 04 Nov 2024 05:04:45 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUqTd7eAiFSrcoJqLrva1sceQxNykJ4tjoVRQ/UGmZFlj3D2GxrtWE+BCripTETCVGcfe8T+4HiKO78w50y@vger.kernel.org, AJvYcCWgwIixYogqitRUPbAyToQkH7SztDFXiVEvkH0SlxxtGgtBZ04HhRKMNcqlI/HD4daf98TarLXec6Kd@vger.kernel.org, AJvYcCXp+86d0Ecp7MvKddU9Yi39cHu//kYlY8pHYArOSDk5U4VBj6z63Bmjj2xnyQVO1/or0sAQcHqNrs2z@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8Mo+sTMUrDvSTGrMDbKGzBo4yjsq+XMhoBiY90B7Q6X1jcBBo
	lYo6vkNwbZQ8tB5ob2CarKuAVpi/7Z/da3cWy3vgKQEKWHrOFaat33Qc8h6EcVJifEkONSl1g6B
	okjVInL/6t2SjO/n1K/FV6iAyZQk=
X-Google-Smtp-Source: AGHT+IGOpn/fxAkEtZRYWFwcsACtEWWadliXEDT24vXzBv3UAKaTQJxrW8AHoWUiJ9mhufbyX9TpyX4gbFfj3BLxPuM=
X-Received: by 2002:a05:6870:9686:b0:277:7633:f50b with SMTP id
 586e51a60fabf-29051b6ba29mr27146515fac.16.1730725484980; Mon, 04 Nov 2024
 05:04:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241104061342.106865-1-zhoushengqing@ttyinfo.com>
In-Reply-To: <20241104061342.106865-1-zhoushengqing@ttyinfo.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 4 Nov 2024 14:04:25 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0gQ6Y5d5uieaM0FwnKO9yrRKpwZp=YsX5Qn7_4W5_+-eA@mail.gmail.com>
Message-ID: <CAJZ5v0gQ6Y5d5uieaM0FwnKO9yrRKpwZp=YsX5Qn7_4W5_+-eA@mail.gmail.com>
Subject: Re: [PATCH] PRESERVE_BOOT_CONFIG function rev id doesn't match with spec.
To: Zhou Shengqing <zhoushengqing@ttyinfo.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, linux-acpi@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 4, 2024 at 7:14=E2=80=AFAM Zhou Shengqing <zhoushengqing@ttyinf=
o.com> wrote:
>
> Per PCI Firmware Specification Revision 3.3 Table 4-7 _DSM Definitions
> for PCI. Preserve PCI Boot Configuration Initial Revision ID is 2. But
> the code is 1.
>
> Signed-off-by: Zhou Shengqing <zhoushengqing@ttyinfo.com>

I think there should be a Fixes tag?

> ---
>  drivers/pci/pci-acpi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
> index af370628e583..7a4cad0c1f00 100644
> --- a/drivers/pci/pci-acpi.c
> +++ b/drivers/pci/pci-acpi.c
> @@ -132,7 +132,7 @@ bool pci_acpi_preserve_config(struct pci_host_bridge =
*host_bridge)
>                  */
>                 obj =3D acpi_evaluate_dsm_typed(ACPI_HANDLE(&host_bridge-=
>dev),
>                                               &pci_acpi_dsm_guid,
> -                                             1, DSM_PCI_PRESERVE_BOOT_CO=
NFIG,
> +                                             2, DSM_PCI_PRESERVE_BOOT_CO=
NFIG,
>                                               NULL, ACPI_TYPE_INTEGER);
>                 if (obj && obj->integer.value =3D=3D 0)
>                         return true;
> --
> 2.39.2
>

