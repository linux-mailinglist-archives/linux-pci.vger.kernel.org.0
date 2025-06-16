Return-Path: <linux-pci+bounces-29849-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CB0AADAE1E
	for <lists+linux-pci@lfdr.de>; Mon, 16 Jun 2025 13:15:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66EB1188F0DB
	for <lists+linux-pci@lfdr.de>; Mon, 16 Jun 2025 11:15:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 130B5299928;
	Mon, 16 Jun 2025 11:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xd+a8q+8"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D41F32750E9;
	Mon, 16 Jun 2025 11:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750072517; cv=none; b=BtIscEJAf0zv55tKgtwHtljdy6l6a5CbVR9lMXtg6/4rro69YRGcZ4iBnKp1mVavrTEU3hRKFIPfr9/M+wPRnax8Ew74AawCPNz8P/ePJPVhPynYmuHFDWJhptrKtim89SAGdohdPXdIGXbYEA5Yp7xqxzjXx2B2hCNJYNzPfNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750072517; c=relaxed/simple;
	bh=7XruesgmCvrpWGKOVk4pK39pQEFV9NmZ788H3C4BwN8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DSbRxbDST0xsStt8kwXqGOj8fZJo0M27sLmUr8p98BrGsY/LMa2UOHVIO+vXzJF+Ina9SeqGSauACCVX5krNPLmUiQHKaMaJp7gnJsRyuZ0hn+Mhp7Z91ieRV1f65P6SPGuFDnNfgtku4+rIxrkrnwdPVZkLGp5/LjnpiFLBI2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xd+a8q+8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56E3CC4CEEE;
	Mon, 16 Jun 2025 11:15:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750072516;
	bh=7XruesgmCvrpWGKOVk4pK39pQEFV9NmZ788H3C4BwN8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Xd+a8q+8+XpTU2USUk+pYFAXHGcoYDfYrAc9ElwknnCeiVUhsmB1/nbrAoxCmMij9
	 7XL6U7mYRCSQKjZzHcro+PLye3yIkq3CFDtDM0Hhie9/gWdKHiOJjeqGtD8fyEDuvJ
	 WAXdWdovVEcl70QjlBnIPuMPXoD8mHcGfdksnelLVxVyDIADJOedYAXVGIdF5mddMl
	 vXZbl4BWZC2RY1kOLebMY6J5DTSQdCozKDYUsEhDm2/5Sl1a/0S5yn8XMFvrymTU3W
	 7twyQDy2GvgR5SB1HELx3Hnft2r0+ZdeAlkA2rk4wxITbQi2JXhbaWPskTDV7REco/
	 vgZIIO/Xh1c3g==
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-40a4bf1eb0dso2413289b6e.3;
        Mon, 16 Jun 2025 04:15:16 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUebzbihFovcXofUPw25G9eZrx919MpeP5E9vLXO51XhsgT5/cd9mgMv5uBra8vvbSQRHXD8tVDvUO9UF5m@vger.kernel.org, AJvYcCVhxPZe5ketXg2z1zIzGPYTzD/4Re1zuP5sN9WEi8lUvooy5+O+bqvlUU+uq8vmTGzszyWOVAUklRBK@vger.kernel.org, AJvYcCXuEt1ICrCjBhu0zqim44d+VLJTUqb8e3theokFEzHr6PTY3xGsdOePyEIovlo+da7Be5DTLqIX8oct@vger.kernel.org
X-Gm-Message-State: AOJu0YyW0Awb+f2m9BvEIfFsndGHSNhiE5ok4uffTHR/UjAKu9SGzTla
	LUsC6Jak0qcrM9oU5PaNTaJYBv24U566QdxlpRvQVfAWoMu637x65YKZcw/KBYAh+b02C3qOIEN
	9yTVi8VcVvwrfAK143YT+elHs2jhmneU=
X-Google-Smtp-Source: AGHT+IEXNQFfySWCatJvZfvLo+9/K2Xb6V9D2wxdtjt9RUuj8wwr4E1vs+SwmpSWnN545c2RBci1ckd1Rebq0o8cGA4=
X-Received: by 2002:a05:6808:152c:b0:406:6e89:499f with SMTP id
 5614622812f47-40a7c18e2abmr6418202b6e.35.1750072515501; Mon, 16 Jun 2025
 04:15:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250616084420.526381-1-qiaozhe@iscas.ac.cn>
In-Reply-To: <20250616084420.526381-1-qiaozhe@iscas.ac.cn>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 16 Jun 2025 13:15:01 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jpJLMZYONVxg3ncEDEKoTy0tyaoBfCSnRrhJYmF8fngA@mail.gmail.com>
X-Gm-Features: AX0GCFsTGnJNpIoRuI6mVAfFTLL-AckWye-THmELgyOS52Pknrtxspza669re8I
Message-ID: <CAJZ5v0jpJLMZYONVxg3ncEDEKoTy0tyaoBfCSnRrhJYmF8fngA@mail.gmail.com>
Subject: Re: [PATCH] PCI/ACPI: Fix double free bug in pci_acpi_scan_root() function
To: Zhe Qiao <qiaozhe@iscas.ac.cn>
Cc: sashal@kernel.org, rafael@kernel.org, lenb@kernel.org, bhelgaas@google.com, 
	kwilczynski@kernel.org, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 16, 2025 at 10:44=E2=80=AFAM Zhe Qiao <qiaozhe@iscas.ac.cn> wro=
te:
>
> Fix the double free bug introduced in the patch "PCI/ACPI: Fix
> allocated memory release on error in pci_acpi_scan_root()".

More details, please.

What's the bug and why is this the best fix?

> Fixes: 631b2af2f357 ("PCI/ACPI: Fix allocated memory release on error in =
pci_acpi_scan_root()")
> Signed-off-by: Zhe Qiao <qiaozhe@iscas.ac.cn>
> ---
>  drivers/pci/pci-acpi.c | 10 +---------
>  1 file changed, 1 insertion(+), 9 deletions(-)
>
> diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
> index b78e0e417324..49b72596ae37 100644
> --- a/drivers/pci/pci-acpi.c
> +++ b/drivers/pci/pci-acpi.c
> @@ -1653,15 +1653,7 @@ pci_acpi_setup_ecam_mapping(struct acpi_pci_root *=
root)
>  }
>
>  /* release_info: free resources allocated by init_info */
> -static void pci_acpi_generic_release_info(struct acpi_pci_root_info *ci)
> -{
> -       struct acpi_pci_generic_root_info *ri;
> -
> -       ri =3D container_of(ci, struct acpi_pci_generic_root_info, common=
);
> -       pci_ecam_free(ri->cfg);
> -       kfree(ci->ops);
> -       kfree(ri);
> -}
> +static void pci_acpi_generic_release_info(struct acpi_pci_root_info *ci)=
 {}

Why don't you add a check for info->ops->release_info to
__acpi_pci_root_release_info() and drop this altogether?

>  /* Interface called from ACPI code to setup PCI host controller */
>  struct pci_bus *pci_acpi_scan_root(struct acpi_pci_root *root)
> --

