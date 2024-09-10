Return-Path: <linux-pci+bounces-12969-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A0F859726B3
	for <lists+linux-pci@lfdr.de>; Tue, 10 Sep 2024 03:45:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2E9ECB22B65
	for <lists+linux-pci@lfdr.de>; Tue, 10 Sep 2024 01:45:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B78965674D;
	Tue, 10 Sep 2024 01:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D04sHib8"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E59537165;
	Tue, 10 Sep 2024 01:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725932751; cv=none; b=SE62bz7d5f6hudpQdAxvqPNQBupe81i6IL6rxGYNbb1ml1UOR0snTeGTTQrPzmyBYA+qW1CFBbC3ycCoLPpHRf9L1VfAvpzDVV7uoVOUZVzD9FHEXkODj7xcwQqZ/8gnJiW8nlEOgiCkRnCp52nsNvnC7g91YYHpVjzgnpLz658=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725932751; c=relaxed/simple;
	bh=nWPIEmLDwbrdFNx75Xf3vEnJ8myVckeOOQiX0vtRiiE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=inaZTQCl7Fd7rPtiVmXXgHKRT3Q+eGWKoNYHiUooVipXlQ9NariFtbRMpYzemmudD19FBrI1n4hhtSBKcoN27a8GOiBF9ANnVoCjS8KmRV7Et1SjP7eMH4rxz3xQXlrg8kP2NlcR0MF2S4xGOyvnU0glI029N06BYxa0hHEgQ+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D04sHib8; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2053525bd90so42205765ad.0;
        Mon, 09 Sep 2024 18:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725932750; x=1726537550; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JhAIyu0RTUe65FO11DVzvQKkyR9dMgsMirLbBNuoVgw=;
        b=D04sHib8Ah/b0PJgb/YeeAESrmmhkdixEEtUvOwbaJRkWK78hOVsLA3PqwEZPvtqC2
         tVP8b/L67GMvd0fGn+hCXFqhGVwCFubMGp/x6QxUpoeLFxlANoVNloHzuhrnj7+fFfvY
         GUvLEZvsC5uljRVqFQwn/NwE8S7BWjDEw5kQ06aqomcKd4FxmY+VAYSrBk30wPkRkyhi
         rOZa1enkGRaRsMXN9l9oT1/wr6HPYS55VgzQzqG31ta2EEWUohv3CR9HP4bIrApKUwin
         qybCcPPKZU8anoc3lw/1HHcHUmAT1S/nT+CY71lMdoAZ/vAPZxo2Rv3ZvcPkZoJ/+kdz
         lfkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725932750; x=1726537550;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JhAIyu0RTUe65FO11DVzvQKkyR9dMgsMirLbBNuoVgw=;
        b=US2ztBsHa+qaLAKF9Ou/GGNJpYok7BP1UeH+O7jFE0FkDOl88Sq3arSR6f8KlQSrrD
         uuypeN3tIQ5H6eZEyz3v2i0XSsEzGBxGwmn4nfFKuACEVkM8pSkzCY+hMYU5kT4O/AO8
         93SyJf1eAKcL3xhwCxGqa2jhBKKgsnxGO28yOg+bUXXe2Edf3RVxSoKnKydQoLn2X3gI
         KcjHcqe8QyMvSCH1bG0dQs6cdjUWV3iOGXTbbxGqh7fgPDOmWb+Z9TqhevsIQNYcb0Oj
         dc+DztEt1bThDKDIsznTnSgufWgkKFzJakCkhNU0VhyToHXziyKtbP/GWvAL7tMFl8eE
         bIQA==
X-Forwarded-Encrypted: i=1; AJvYcCU/gXAUIVWSeDKe2NoOdC+hbNV1QcBV8QrnWOqhE1Ae0tNIBrohoxbvT+r2dJf/EHaismAmYVR8BWj6@vger.kernel.org, AJvYcCUkxVcQ7WRXkQs8lCjGpnHSzHPJEL7NOp/Zv4pkZFrdIyu3dXf+hd4L0WToTCCWLK2xkk9b+ndRsNK0VcDB@vger.kernel.org, AJvYcCVzeAS2HvV6OGliBU+vMemoaSU2xpA+44l1dU2hwPqulPHp6Pa11O8FdNlZrzynjQzS/q32vkMkLsI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxwcx5I+6oCSaOERldW5Lmy+p1afw5ZSRgAGSZaizot9CHmIozD
	xWiUq4NYgaodDVUIYoO+i/cZr3v2PZL26+IjXxoSb4bBBIwO2pHz
X-Google-Smtp-Source: AGHT+IFmHak8m/g6m73sF1eAOxf24YWjx+IT+IWb0J0hI+mSUL5lKLxXDxk6fv+6tPVhnTEGqELu5g==
X-Received: by 2002:a17:902:ec87:b0:205:7b1f:cf6d with SMTP id d9443c01a7336-206f053113bmr144666235ad.30.1725932749365;
        Mon, 09 Sep 2024 18:45:49 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20710f21726sm39350755ad.236.2024.09.09.18.45.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 18:45:48 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 9000F4A0EB86; Tue, 10 Sep 2024 08:45:45 +0700 (WIB)
Date: Tue, 10 Sep 2024 08:45:45 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Abdul Rahim <abdul.rahim@myyahoo.com>, bhelgaas@google.com,
	corbet@lwn.net
Cc: helgaas@kernel.org, linux-pci@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation: PCI: fix typo in pci.rst
Message-ID: <Zt-kyY2p3dmOxqJx@archie.me>
References: <20240906205656.8261-1-abdul.rahim.ref@myyahoo.com>
 <20240906205656.8261-1-abdul.rahim@myyahoo.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="YrGAIVQG7ZZPzhC9"
Content-Disposition: inline
In-Reply-To: <20240906205656.8261-1-abdul.rahim@myyahoo.com>


--YrGAIVQG7ZZPzhC9
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 07, 2024 at 02:26:56AM +0530, Abdul Rahim wrote:
>  When done using the device, and perhaps the module needs to be unloaded,
> -the driver needs to take the follow steps:
> +the driver needs to take the following steps:
> =20

Looks good, thanks!

Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--YrGAIVQG7ZZPzhC9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZt+kyQAKCRD2uYlJVVFO
o3C8AQDgUYrjQ61jhoK/drpH/yfBgUI5Cuc6Ukj21TaX1f0BGgD/Xh+09Y9U4PMr
IhQRPk0Nbg0Tm9ZUSBuf87QFiy4sOwU=
=ybWZ
-----END PGP SIGNATURE-----

--YrGAIVQG7ZZPzhC9--

