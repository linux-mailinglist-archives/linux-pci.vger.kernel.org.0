Return-Path: <linux-pci+bounces-33860-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3721BB22841
	for <lists+linux-pci@lfdr.de>; Tue, 12 Aug 2025 15:22:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 497DE3A4417
	for <lists+linux-pci@lfdr.de>; Tue, 12 Aug 2025 13:16:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CC4227932D;
	Tue, 12 Aug 2025 13:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xz4nTBbZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DDF32727E6;
	Tue, 12 Aug 2025 13:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755004612; cv=none; b=AmTrQfXHnwOf7aeDD1TqkeRE0/0W9+TpZuCmEreAc4qRfkYA+BIeWh4HE0hw5ADScYbJLnT0GCoqEWkjFk0QvyaTh+z3w3a4HasBb+5kfwV34wFymwtW9LJF5vadz9pWKDvtMYPWKmSj2VNZMl51sZoSmph8iadFt/OQc29WVgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755004612; c=relaxed/simple;
	bh=3I4/6rSY3BH0T9rdZqBCmXxrvG5EfYLBX+MERG/7QnA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m50fPgneK4dH65aBXfTKtwUvFOXeVtYOnM84/UwiOqKQbVl9kga1WqWdC/daBtbFG7twpKCIHRw3Kvb9gU7BFwQ/6IzzGn7eyQAwDQYzmnTKmubvUHDQXZu4Urfh+TiIlDBoqlrhN+wr0swQhXAU7rg6YcfkiSJ6+LjziQ5Rrjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xz4nTBbZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C90BDC4CEF6;
	Tue, 12 Aug 2025 13:16:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755004611;
	bh=3I4/6rSY3BH0T9rdZqBCmXxrvG5EfYLBX+MERG/7QnA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Xz4nTBbZHXJL3miuxpLiIHff1UkIzFCVnyExiIQIkGFdGStmVQtRntxFTusfaPVEh
	 j1b3lIo5y6Jr22FEuwVJiojt+WW+QLdpJ2qC/uQrHmt1ERitEHiLUnfLdVMwFmoqfm
	 HUWCqCl4B2CxSTc75ej7hWVzZe3VT++LU1cPcVB4GNeGgWOCCOTAcpsMkTrz8/Irv+
	 rP1GmdE8LNUgsmAqLLV7RqUcpOxYd7an7dHjIP0/PfZQ80l7Pshosnr0cE+6sTXhyt
	 p7JWcrDKlxZjo2mrs0gPGjokl4F8+G9b8gxgZrrG4+t3dLbTmM7SNXz4K03fvzdvDS
	 oMbDdADY91fjg==
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-741b8c26fc3so4511534a34.1;
        Tue, 12 Aug 2025 06:16:51 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU1R2J3DhKKmSKTME22Acs1jTEUOLWmGlzAMX9l2z+3HTEFpgdKlQjrtVfKaVqhEBeA0Cmc2ETQ5pkh@vger.kernel.org, AJvYcCUu7XCZt/K7LijkZa879nYub+Gh0YDvotYHrS1RvMug0IgSVbnIvR8l9uUqa5jxrQCpjw7OYGGEBep9/wXC@vger.kernel.org, AJvYcCXP093uoGTY8w0YiuEozp3MlUP+IImVXit3cfEPhKiV+soaQ1DXiC7YDAI6Q44y82JSxwtH6w4jiMAr@vger.kernel.org
X-Gm-Message-State: AOJu0YxEyq6uU1iv8GAfJJc0dCXorbG+wUcQ6+856NVqwZSbrmBBCDTJ
	p3J/e99+raJApQVUMDVA1Rd55us/LS/xM7Sxvdm/hgv6yS/HlEoTYqB4vnSBH8OsSghNl63MeCE
	rT0PhIuAzaokLe0T1ettttA6L8bmkYvg=
X-Google-Smtp-Source: AGHT+IEfq1ext6EYDCouxq3ABr2rZT7IgagaWXGMqeYGVjXnrCVE0lgDoj8A+4W9+qPH5iWTbbvwam/QiUkPanmSRN0=
X-Received: by 2002:a05:6830:7192:b0:741:9157:7179 with SMTP id
 46e09a7af769-74366c549d2mr3151105a34.21.1755004611125; Tue, 12 Aug 2025
 06:16:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250811082223.377017-1-liaoyuanhong@vivo.com>
In-Reply-To: <20250811082223.377017-1-liaoyuanhong@vivo.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 12 Aug 2025 15:16:40 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0irjA9sXjA_arW8QWueJ-C3OJHX7yDwU6TT=EAM7hjq3A@mail.gmail.com>
X-Gm-Features: Ac12FXxftdbuk568xipLP2ndtRkLURx3wxGwC4Ftfcqq9ocGTfw4SdBpIkz59jg
Message-ID: <CAJZ5v0irjA9sXjA_arW8QWueJ-C3OJHX7yDwU6TT=EAM7hjq3A@mail.gmail.com>
Subject: Re: [PATCH] PCI: acpiphp_ibm: Using kmemdup() to simplify code
To: Liao Yuanhong <liaoyuanhong@vivo.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, "open list:ACPI" <linux-acpi@vger.kernel.org>, 
	"open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 11, 2025 at 10:22=E2=80=AFAM Liao Yuanhong <liaoyuanhong@vivo.c=
om> wrote:
>
> Use kmemdup() to replace the original code's allocate-and-copy operations=
.
> It enhances code readability and simplifies nested conditionals.
>
> Signed-off-by: Liao Yuanhong <liaoyuanhong@vivo.com>
> ---
>  drivers/pci/hotplug/acpiphp_ibm.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/pci/hotplug/acpiphp_ibm.c b/drivers/pci/hotplug/acpi=
php_ibm.c
> index 18e01cd55a8e..6a16c8e8238f 100644
> --- a/drivers/pci/hotplug/acpiphp_ibm.c
> +++ b/drivers/pci/hotplug/acpiphp_ibm.c
> @@ -140,11 +140,8 @@ static union apci_descriptor *ibm_slot_from_id(int i=
d)
>                 ret =3D des;
>
>  ibm_slot_done:
> -       if (ret) {
> -               ret =3D kmalloc(sizeof(union apci_descriptor), GFP_KERNEL=
);
> -               if (ret)
> -                       memcpy(ret, des, sizeof(union apci_descriptor));
> -       }
> +       if (ret)
> +               ret =3D kmemdup(des, sizeof(union apci_descriptor), GFP_K=
ERNEL);

Maybe do

        ret =3D kmemdup(des, sizeof(*des), GFP_KERNEL);

while at it?

>         kfree(table);
>         return ret;
>  }
> --

