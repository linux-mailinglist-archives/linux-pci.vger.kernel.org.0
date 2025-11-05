Return-Path: <linux-pci+bounces-40369-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 584FEC37057
	for <lists+linux-pci@lfdr.de>; Wed, 05 Nov 2025 18:18:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28CB0627816
	for <lists+linux-pci@lfdr.de>; Wed,  5 Nov 2025 16:52:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E37B6338912;
	Wed,  5 Nov 2025 16:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AVpbhQKs"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2A22338594
	for <linux-pci@vger.kernel.org>; Wed,  5 Nov 2025 16:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762361527; cv=none; b=Ji5hccN1mWglFhe4yrpbDQnDy7QCN/gEBu8Y07SEuOq/8oQdpgRLVzqZs4cvyHycQz6t55XiuP0JNRVXuGQyfMbJEnlnsRnNKrPjygork1Ib3xlhfHMLgmgVgXBElvzGlWIRoI3ibYlp6Vzx+pG120CE5W/iAmhE9v/t6wHAJNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762361527; c=relaxed/simple;
	bh=esO8jRq9uTUw55PJsW3htw0zar+bIhexF73TArzHxxk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lxgf9f0zPxVxTOXWrNdexrOasw5SrknBSBxc+49hp8tIGcEj1tZH34K2Fq4QaEugsqosda02aJMsB1WMMfzMheb/l+thJonIBjKUpd9PunMs+2DVkwDHkud3EqgEu0RImf4fV8tICOVANUU2zRW3XkMEM9+jc4VEn1oNJmEPosI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AVpbhQKs; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4710022571cso64344095e9.3
        for <linux-pci@vger.kernel.org>; Wed, 05 Nov 2025 08:52:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762361524; x=1762966324; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=esO8jRq9uTUw55PJsW3htw0zar+bIhexF73TArzHxxk=;
        b=AVpbhQKsWHsJPurkBtpFjS569EuYKUxy0Ewl5KvxLz11TynIudTMz6x27b6A6doKWz
         ip2xD5KKY1oMJCK0Dweum3CzpsfSfe5Azmrly9qy+6lx5DTGxHpK2A+42y5Z3pqNqWXK
         5oMVmrIxCr+TXfau1fOpH55Ds8Gfkw+SKMup3+25IM0tOOtYD8mCPcmX3YHevXG3I9fS
         voKjd3O+6JkWCl7xwg0Uy4qskOwo95lmPAQUzNV1zgopuIouOGjmjNsUQ0iiplG4NNw3
         pJwe6bLtD5Fb+hz4cFTbQ+dE2Dx8twHim57o5xVAlYBYEkIZ+8VVi9pnTa3HqwZj4o61
         JDfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762361524; x=1762966324;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=esO8jRq9uTUw55PJsW3htw0zar+bIhexF73TArzHxxk=;
        b=OwRNmMWFBirrlv6jwMUrZPkKAET6ynmQJw4AlWWg64N0TgWR0XpcsX4RWLns5YCR+r
         6Jj+f8/mpuDeHzXfGsGNeCB9yljNhDZMipBpFJ5OFqcGkOxDny5k/IsV74uO36QRVbwf
         h56gkGvO/BFQLI6l0F2EZDiMqpdXnyGqIPm/mzuYg8w4vlU+kS4wNiWdVS+qiIafYPZ8
         8MNOWEMUzwCmfW8EZfaQexnE5SkaJi2f6JeiM4QdSv096Yy3aAiNjbC3MFtcB5ySG7HE
         BfSC8Xo2ncwGzbjVehw1aCofg9TlxlMSTIxu+9NeCBAnwi/5BhvLuLEXHFAGPbWA2shl
         EOsg==
X-Forwarded-Encrypted: i=1; AJvYcCU/DaZjLL1hTHrnyPwIpkRdxOc6tcEOBtU2X122rRSp8+C0otIKHnbuvPE4divgT7f7aMuirCXx0yc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzc4PRNpJ3kUCarTxuGxT33yFWNkdksH+0Q95in8Qr4vOHRNfDj
	lb6BASM3aGfp0/exLXr6rPcYzcHWMyyOlScXJAu9ocDWWvDJIvqeX7yv
X-Gm-Gg: ASbGncvAfHe1E0Js/guWT4bBrZ9ehnXl0k6ENmjvAMZ/F7l/luZIamfPtsAQ8/kh49R
	eA6VgkRNwlGdKpqgvLSJGeBxNB5Bkx2uTo/j6Jgy8jDt17jStQoTbhaE4M2RIjGX61igEG1+Mt7
	hmJQ8UZWQ3sLcV7TFeyxr9pw6Ut7tK6OGLGPpop06bKHNv6IceanSEpVd6WIaxKTU7qRg3H+GIX
	WsRHX1RhjCczMYeTHeY8KOOScHXN93CYWqxpURXeOsbSPZ9JDMP73kPZ7Ydbr1y1zOFkWKyh2eU
	CyaEkgxdCjAXujL+G5a0bkNrHqSurKqn69OVRT9QBHeqOAYc1O9jmXgjv8x8Hkl0Du2r2Cbckzw
	vumJFQRPoEjwBWXq3NIbWLDW87UpRzXVo1xVOmj6QiAIoJIklkXdL2Gjj6lVBY5GelBTsx14DVT
	WBIyta4MG3pC/GvSxkYFLvC1WzxZnRldOqQ/T7vfuQJKUsXFxIKYz76I8tz8mbwyk=
X-Google-Smtp-Source: AGHT+IF1eT04urNHEfsD9kdCj32CNL1YcHJ6oGuMVK3cU2BLT/aQRFRmm7ox5OYZe77ML31HK9v5ow==
X-Received: by 2002:a05:600c:1c94:b0:477:fcb:2256 with SMTP id 5b1f17b1804b1-4775ce23efemr42468465e9.17.1762361524090;
        Wed, 05 Nov 2025 08:52:04 -0800 (PST)
Received: from orome (p200300e41f274600f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f27:4600:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4775ce210a7sm59725725e9.12.2025.11.05.08.52.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 08:52:02 -0800 (PST)
Date: Wed, 5 Nov 2025 17:52:01 +0100
From: Thierry Reding <thierry.reding@gmail.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: x86@kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-riscv@lists.infradead.org, linux-mips@vger.kernel.org, loongarch@lists.linux.dev, 
	linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/7] syscore: Pass context data to callbacks
Message-ID: <3dzha4qyqdrbutxby3n5nkvihnxrhniqr6w726eumhzgln2w5l@fbu72mzmjz4m>
References: <20251029163336.2785270-1-thierry.reding@gmail.com>
 <20251029163336.2785270-2-thierry.reding@gmail.com>
 <CAJZ5v0igMJ12KoYCmrWauvOfdxaNP5-XVKoSxUroaKFN7S-rTQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ykyajizgfjgayrmb"
Content-Disposition: inline
In-Reply-To: <CAJZ5v0igMJ12KoYCmrWauvOfdxaNP5-XVKoSxUroaKFN7S-rTQ@mail.gmail.com>


--ykyajizgfjgayrmb
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3 1/7] syscore: Pass context data to callbacks
MIME-Version: 1.0

On Mon, Nov 03, 2025 at 05:18:08PM +0100, Rafael J. Wysocki wrote:
> On Wed, Oct 29, 2025 at 5:33=E2=80=AFPM Thierry Reding <thierry.reding@gm=
ail.com> wrote:
> >
> > From: Thierry Reding <treding@nvidia.com>
> >
> > Several drivers can benefit from registering per-instance data along
> > with the syscore operations. To achieve this, move the modifiable fields
> > out of the syscore_ops structure and into a separate struct syscore that
> > can be registered with the framework. Add a void * driver data field for
> > drivers to store contextual data that will be passed to the syscore ops.
> >
> > Signed-off-by: Thierry Reding <treding@nvidia.com>
>=20
> This change is fine with me, so I can apply it unless somebody has any
> specific heartburn related to it (Greg?), but in case you want to
> route it differently
>=20
> Acked-by: Rafael J. Wysocki (Intel) <rafael@kernel.org>

I have a few follow-up patches for the Tegra PMC driver that depend on
this. 6.19 is what I was targetting, so if we could put this into a
stable branch that'd be the best solution. I can set that up via the
Tegra tree if you and Greg are okay with it.

If that's all too complicated, I can probably wait until the next cycle
to merge the PMC changes.

Thierry

--ykyajizgfjgayrmb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmkLgLAACgkQ3SOs138+
s6F0Lg//dTn1/PUCYHRhF8cm1xB6JKggiLC40TRct49fcf9eF5gAdCqXm44qKoaF
67aqiXAiwzovTctJIu3rz8p71/FeXp/qGWDdPm/+wI7yD+BoCcVO0nmvXuPwCzhd
ZMwqeaRVm57JX4M9S5BdkOGtDLgAjyZ/6Qq/2isiQSPiWWl/IT3YiLyzw8vq8mcY
VoepQGK5hm7CHFf8FOBs+sMt6q5JJDm0VjNi+seVcCNg9U25GaXCRc2D9ztAqRib
3768/KMhlftnoJKsizCwWq2Gyw0Se7ifz66djjf51sHd064LLDv7OZpfeGyiFK01
MvVGXoPFuIJB0yqIoMRBbeRULm4kq+dkUkt1JWwYAMw9ZJnhXPJJI8bal2IASj8/
E6NADiYd9HS8kAXWYvLkm0xHv4FN5WXWG2a+Gf6K2vpBm07zG2xnI+eVjYQSnb9W
O9TcZf3jDWvgEQ31plH5JFY32sI4vjLAdcKS2oRfkbxFDJvTS+RRjj3EPqFshNXf
B5E6pXTCltOkUepuhbGDzIifVWzYgg/GyXNfwzdnJUXcAz7QPPJySfMraf/dn+8S
hggVgAivRFDEtaNEqKU6iqoePR3HIUJe/Ebjrb199RV9t4FcnVYOpviJRf5EWpsF
2YEUJPiA7neiac9fPLwCoRh33bJTIzanmWVxmFF1nQ2vozIt68U=
=3Mmd
-----END PGP SIGNATURE-----

--ykyajizgfjgayrmb--

