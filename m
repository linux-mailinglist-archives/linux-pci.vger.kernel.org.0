Return-Path: <linux-pci+bounces-5264-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B140488E701
	for <lists+linux-pci@lfdr.de>; Wed, 27 Mar 2024 15:47:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC44F1C26D5F
	for <lists+linux-pci@lfdr.de>; Wed, 27 Mar 2024 14:47:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D715013CFB4;
	Wed, 27 Mar 2024 13:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="igBxeSmS"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DAF5130482
	for <linux-pci@vger.kernel.org>; Wed, 27 Mar 2024 13:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711546521; cv=none; b=p5CdJvmI6DFtQKf6WISbFqOHQ0p0ueFMm5iZ8N1gNdbP+T3/yKSNBZP60toUnesOT5zfIxj7bhrxDKAJzoJPvWIsZOwUhafVbWGVzDVoIMnEdpIqAisWy/Y5icV4Ma4LuUUfh/hGMvO6fC/xoL9Yta9fUltDw//EmdgjRaBU2Ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711546521; c=relaxed/simple;
	bh=4PAqrg9dUBPe+VNGRO6PREAWBX5CjE7+Q4T65E6s8+Y=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BKkByTFWgBb24XDqCmTaABjsKsFSUqXgvFKuy0XqXHqjVjiKheeFZulJK9uzGIlPWFFTNyYOi9Bvta/KaYXTrIIaFw2R5rAI9jNpxT4PslXhfyHzLBEKjfNnRnFl7zlTOI0m0oQkvNah7GjSfPl6fPBVkq5pl6Vrl2OFSwoanSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=igBxeSmS; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711546519;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VVrCuxpTJ0gCHZTB0QxvdcPy8C9E7vvFJM6R//tX0K4=;
	b=igBxeSmSbtod55Z+vnvZoSvOOSU5t5TcGXgWVYbLmj6ELbRpXvDzTNcUxC+EssBVoBelfY
	gdEc9cf5tQDoOnAdPrEHUikTDcGDpE41J5xx4yclfGzBLxeetv7TOnBoTVMH4gl5zenVc7
	M+gB7OEXDr9HB/RWkBvKSOLSEoTbJLo=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-654-VHgAsFOgN4OoxgLSTbfKDg-1; Wed, 27 Mar 2024 09:35:17 -0400
X-MC-Unique: VHgAsFOgN4OoxgLSTbfKDg-1
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2d472320daeso13567721fa.0
        for <linux-pci@vger.kernel.org>; Wed, 27 Mar 2024 06:35:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711546516; x=1712151316;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VVrCuxpTJ0gCHZTB0QxvdcPy8C9E7vvFJM6R//tX0K4=;
        b=uf8vJdB5JWaFqiv1a8udXJXLcjg6YmP7dtZ0NnsQqT2Efud81md9MSwXKjZVy4o/9C
         NVrQfSvmPiLzzhIvlHXO+Zyp2Y+tSuCmqhiB5It8s5MtDS2Dxal3+xMn9DSzCZdnKDPw
         CVs9z+QveJnNT/dPPYNKCX6JpmtYtIJK+Qc8OWnHke2HHzGs8FF+UXM7SDAhiDHvZViQ
         6FgytTK9/aONB/r9gGFvXwi3lPuL1NZr9MMtmbPzAhdwXyGrN5OgnxNe4ruonArOeew9
         cium+rdZBM87IwAlP9xdPYl4cTg5a45Xzp8XXhyh/gqRZpxsL8nlxgzq9RWQKl8kkMxi
         Hlew==
X-Gm-Message-State: AOJu0YwPDzWr2Jdbw9TFXIln9UUMlHppQCfaM/fENTcJFCyCwAQbqsIH
	bAcKkhJ23j9Pvba6zXwKvnwTr6q0tnnGELKzwvDRRQn/gQGTcz2L89SQZolhO3InRgvXjPYPv14
	xwpubv50zTppanvsr22xPBfqZVjy1X7Zai4XcvfHiNIB68StTr8udSTN7OA==
X-Received: by 2002:ac2:464e:0:b0:514:b446:f5d9 with SMTP id s14-20020ac2464e000000b00514b446f5d9mr8965362lfo.3.1711546516386;
        Wed, 27 Mar 2024 06:35:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGQKIU9SHXAL1+Jnd1RxSm68b2VOAzsmpECG/7Uos2n1azhI8UWjryVQIJwi+EZrekuHsWPbg==
X-Received: by 2002:ac2:464e:0:b0:514:b446:f5d9 with SMTP id s14-20020ac2464e000000b00514b446f5d9mr8965350lfo.3.1711546516004;
        Wed, 27 Mar 2024 06:35:16 -0700 (PDT)
Received: from pstanner-thinkpadt14sgen1.remote.csb (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id dn1-20020a0560000c0100b0033ec7182673sm14913658wrb.52.2024.03.27.06.35.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 06:35:15 -0700 (PDT)
Message-ID: <cd94a64536b687ee07f4e59be5bc6fed0df48404.camel@redhat.com>
Subject: Re: [PATCH 2/2] r8169: use new function pcim_iomap_region()
From: Philipp Stanner <pstanner@redhat.com>
To: Heiner Kallweit <hkallweit1@gmail.com>, Bjorn Helgaas
 <bhelgaas@google.com>,  Realtek linux nic maintainers
 <nic_swsd@realtek.com>, Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski
 <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>, David Miller
 <davem@davemloft.net>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, 
	"netdev@vger.kernel.org"
	 <netdev@vger.kernel.org>
Date: Wed, 27 Mar 2024 14:35:14 +0100
In-Reply-To: <e1016eec-c059-47e5-8e01-539b1b48012a@gmail.com>
References: <982b02cb-a095-4131-84a7-24817ac68857@gmail.com>
	 <e1016eec-c059-47e5-8e01-539b1b48012a@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-03-27 at 12:54 +0100, Heiner Kallweit wrote:
> Use new function pcim_iomap_region() to simplify the code.
>=20
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---
> =C2=A0drivers/net/ethernet/realtek/r8169_main.c | 8 +++-----
> =C2=A01 file changed, 3 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/realtek/r8169_main.c
> b/drivers/net/ethernet/realtek/r8169_main.c
> index 5c879a5c8..7411cf1a1 100644
> --- a/drivers/net/ethernet/realtek/r8169_main.c
> +++ b/drivers/net/ethernet/realtek/r8169_main.c
> @@ -5333,11 +5333,9 @@ static int rtl_init_one(struct pci_dev *pdev,
> const struct pci_device_id *ent)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (region < 0)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0return dev_err_probe(&pdev->dev, -ENODEV, "no MMIO
> resource found\n");
> =C2=A0
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0rc =3D pcim_iomap_regions(pdev=
, BIT(region), KBUILD_MODNAME);
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (rc < 0)
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0return dev_err_probe(&pdev->dev, rc, "cannot remap
> MMIO, aborting\n");
> -
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0tp->mmio_addr =3D pcim_iomap_t=
able(pdev)[region];
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0tp->mmio_addr =3D pcim_iomap_r=
egion(pdev, region,
> KBUILD_MODNAME);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (!tp->mmio_addr)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0return dev_err_probe(&pdev->dev, -ENOMEM, "cannot
> remap MMIO, aborting\n");
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0txconfig =3D RTL_R32(tp, =
TxConfig);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (txconfig =3D=3D ~0U)

You could use this patch then on top of my series; the only little
change necessary would be that you have to check for an ERR_PTR:

if (IS_ERR(tp->mmio_addr))
   ...


Looks very good otherwise.

P.


