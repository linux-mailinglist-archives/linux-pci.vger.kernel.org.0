Return-Path: <linux-pci+bounces-32535-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ECA8B0A592
	for <lists+linux-pci@lfdr.de>; Fri, 18 Jul 2025 15:49:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9D371C4130A
	for <lists+linux-pci@lfdr.de>; Fri, 18 Jul 2025 13:50:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 163382248AF;
	Fri, 18 Jul 2025 13:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hXLhE7tJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38419EEBB;
	Fri, 18 Jul 2025 13:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752846585; cv=none; b=GJt8EGo+UpY9EsVkWs2bMpf2Xh+cFpZzzcmK6ZKxXKG/Z19XEwuBPnuSepvCUlrX4SkFa50St08fBLJ3srt83PVfh+CnyhrhB+pSpK6TEYi7ev1aBwwElUk3TvwauGfDkHsOQaR4CFhy4Wqby/oK9fJ25WxO15H6zdRENUTf9j8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752846585; c=relaxed/simple;
	bh=MwMKvzg6GaOXygcJw3CXNPcuMDgDSIluKPqmVny5ixE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bVEG5DYCifGwkOo/ptSzL+ntRZFVtnq9vpz8+Eyt2WtoTYEz0zsWkHETyH/nwvoUIQChq9NVFZLnganozRaUnOHfFw/kMplCgf2OrcRfYbq2DIimZJLWs2ySSFZZUIQzWes82EgO1t3y5EfXRghbzkXRy683FqjdtfaaGo9QxS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hXLhE7tJ; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-455b00339c8so16067465e9.3;
        Fri, 18 Jul 2025 06:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752846581; x=1753451381; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AMgyOUgLIJ32PTJWBYJxdAEjZIylinigTisZq5Jwpk8=;
        b=hXLhE7tJ9TvfYjDFLQlVIbog8Z0gcmzypUDK6jNxlq7EGrdRZ0VEUyp+/8bwPnyUen
         W6g/8MnJ+fK8EM4yasA69y3HcNtYd7c/CtWUZwXBIbCDxsnVjLn6S2NEwwfXUc9iM9mW
         2trNsU3+vzPD3H6Oj+7JLl75A1deOuuRPElpY3q5bjGbDXOrrWVifwivkyivUOYjBwQI
         8k5svVGOLW+pc6fLlPxNaLDBxTPqoS8EZDMTnjYTVYpCdGR7jxhuHdk+eSyOITONamWz
         MGV4Dk8+HNQubPyl51o/boHrzv6PmBt9lHhF1noViuM0ttoGouPYNCq3WlqZwRwguZ1u
         gHaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752846581; x=1753451381;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AMgyOUgLIJ32PTJWBYJxdAEjZIylinigTisZq5Jwpk8=;
        b=D3KBN7QkjRSaBBLFebY3Vfk20koULptvDFRY9oVPyHKMZYSXjmhv140smb8qXYFquT
         yh3ncUOmOLkc9RCBLiKlZ7TH5IYU9q+/DThy7jkfm4SCEhYmJ9UPxgLFqqa0nGErm2kK
         MtoqLhdZaqCr0asOqgniYRZZ+9s+kO5FHzUWODb3xK0Wa9l7bAo06g8s0OB1Rix+6eMY
         De7zUNs49jGEDST5WkPUZ5H4RMrfkjQWkzle54Ee2RGkhODHSKCH5AIdxh9x7vMkYbbO
         oz99GTJj2w1FYrUCfhtE4LLkxhVMADAvEaC3HsjDC2B4kPcSLx6HBqrFHpscwkgIXA+E
         jWZg==
X-Forwarded-Encrypted: i=1; AJvYcCURBYTQ5znBVBxlNQessB7kFc0oAm8r9QTVQ1kvl+n4/Ze/Oaru51/IThVJwZ6+ANEZaV4Lf2+AJOD2@vger.kernel.org, AJvYcCVslb99gEy6R/5mWOWCtPbCRmi6PeIhMj1AMPgk8fvstQxNGt+xQU4vVZWSQXAfuiCqpUC7DZJUGFE=@vger.kernel.org, AJvYcCW/uBJ2dfOQmgt6nvXYv/BrpSFrHBSh5MEtl/F9KQfkLZVg6kTJaCNZJfwYgDlAIqHjzzoaR6GBIvY9vH7G@vger.kernel.org, AJvYcCX97gytsA6HEwmUiWwl5T1lOOFGkB8ZCgDDHs2FFF8rkwCBpjXeNhkq07yIogZe1i5Jyzg7o8rRvbgSSg==@vger.kernel.org, AJvYcCXP2gSkW5ZlKUXp0JoNj5QOxuy8kg/5txp5DqoIhTDNaGa+XUYCpgzq8NWuh9/weMT/bbWhSSl4ZBlc@vger.kernel.org
X-Gm-Message-State: AOJu0Yx01Wfg9K2BRSB0lQbMHnr8RaEHM/9AwB2yernbjrVaYvq8HCOa
	zkcBTr0FI923S0Xshl7EX3BuPqz9YRnYqcpZGo+S4ifGpumaHpg+0vyt
X-Gm-Gg: ASbGncujdYNRSwsLIKsBe/iemF7KpR26C+59ZvoP4RkuKrgOsC6mATc7ImDmiGZEHUz
	8bAs5yuvoJLCvEpQrS3D12d7erKlNO3xcCHMuD1GLeRzmnYxgQr9sbPp3IafHQHhAD78iOenKr2
	E4h1jmpAadcplRlhiPebDP8sJcVGUqnwtkhQfIrnvBymuzXSIWMvfC5+PwL0lD5aJg3zrpaqM8A
	EGm0pxJn3T2bFkccQ83XxHHhDiY+ghpR1tzKMzw3ZCEo2+uNn+WvR7GUZwSi8eP8pPQzTnOEju/
	F72LLYfyPoqwvxKet9iRInr9UMDZQscOogMlDBiFAl5o5wlDiZZdemSLCa/+omN9NqPCwb3XUx+
	o8LFNxRpk8c0+a0gEBAZHK8NVz1srC57TDj1TNrzS01pUCm939AWuTlRBLRhzU+IrRH8DgVNUh5
	PNVnuRswag
X-Google-Smtp-Source: AGHT+IHffGdFSHvYOR3y1R1hMWHllBX1SeAON/ZoD7Ch8x5l+0sSh2Ktls2hMGgkwYE+UWSbANbmhg==
X-Received: by 2002:a05:600c:4e02:b0:456:201a:99f with SMTP id 5b1f17b1804b1-4562e373d4fmr108407665e9.18.1752846581084;
        Fri, 18 Jul 2025 06:49:41 -0700 (PDT)
Received: from orome (p200300e41f4e9b00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f4e:9b00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45626cde7aasm62335145e9.1.2025.07.18.06.49.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jul 2025 06:49:39 -0700 (PDT)
Date: Fri, 18 Jul 2025 15:49:37 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: x86@kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-riscv@lists.infradead.org, linux-mips@vger.kernel.org, loongarch@lists.linux.dev, 
	linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/7] syscore: Pass context data to callbacks
Message-ID: <rzbzah5iigz25jtxyqadnitkzkazxsaxntajhlfrfdslyioevk@pylcjkfh5n42>
References: <20250717103241.2806798-1-thierry.reding@gmail.com>
 <2025071716-phoney-object-1648@gregkh>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xzuw4l5ej7k2fa3p"
Content-Disposition: inline
In-Reply-To: <2025071716-phoney-object-1648@gregkh>


--xzuw4l5ej7k2fa3p
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 0/7] syscore: Pass context data to callbacks
MIME-Version: 1.0

On Thu, Jul 17, 2025 at 02:11:41PM +0200, Greg Kroah-Hartman wrote:
> On Thu, Jul 17, 2025 at 12:32:34PM +0200, Thierry Reding wrote:
> > From: Thierry Reding <treding@nvidia.com>
> >=20
> > Hi,
> >=20
> > Something that's been bugging me over the years is how some drivers have
> > had to adopt file-scoped variables to pass data into something like the
> > syscore operations. This is often harmless, but usually leads to drivers
> > not being able to deal with multiple instances, or additional frameworks
> > or data structures needing to be created to handle multiple instances.
> >=20
> > This series proposes to "objectify" struct syscore_ops by passing a
> > pointer to struct syscore_ops to the syscore callbacks. Implementations
> > of these callbacks can then make use of container_of() to get access to
> > contextual data that struct syscore_ops was embedded in. This elegantly
> > avoids the need for file-scoped, singleton variables, by tying syscore
> > to individual instances.
> >=20
> > Patch 1 contains the bulk of these changes. It's fairly intrusive
> > because it does the conversion of the function signature all in one
> > patch. An alternative would've been to introduce new callbacks such that
> > these changes could be staged in. However, the amount of changes here
> > are not quite numerous enough to justify that, in my opinion, and
> > syscore isn't very frequently used, so the risk of another user getting
> > added while this is merged is rather small. All in all I think merging
> > this in one go is the simplest way.
>=20
> All at once is good, I like the idea, but:
>=20
> > Patches 2-7 are conversions of some existing drivers to take advantage
> > of this new parameter and tie the code to per-instance data.
>=20
> That's great, but none of these conversions actually get rid of the
> global structure, so what actually was helped here other than the churn
> of this "potentially" allowing the global data variables from being
> removed in the future?
>=20
> So how does this actually help?

Thanks for pointing this out and letting me look at it again. Most of
these actually do get rid of the global data variables. The MIPS patch
doesn't because I forgot, but the __alchemy_pci_ctx is no longer used
after the patch (except where it's initialized to the ctx variable, but
that's no longer needed now). I've updated that patch.

The Ingenic TCU patch gets rid of it, and so do the clk/mvebu and
irq-imx-gpcv2 patches. The two exceptions where it wasn't possible to
get rid of the global data variables are mvebu-mbus and Tegra PMC, in
both cases because there is other functionality that relies on the
global variable. The bits that make it very difficult to remove these
entirely is that they export functions that are called without context
=66rom other parts of code.

I have a fairly large series on top of this that converts the Tegra PMC
driver to move away from this as much as possible. It's not possible to
do on 32-bit ARM because there is some low-level CPU code that needs to
call into this function. However, the goal is to at least make the PMC
driver data completely instance-specific on 64-bit ARM so that we can
support multiple instances eventually.

Maybe something similar could be done for mvebu-bus, but I'm not sure
it's worth it. Typically for these cases you need some form of context
in order to replace the global data. On Tegra we do have that in many
cases (via DT phandle references), but I'm not familiar enough with
mvebu to know if something similar exists.

My goal with this series is to get this a bit more established so that
people don't use the lack of context in syscore as an excuse for not
properly encapsulating things. These usually tend to go hand in hand,
where people end up using a global data variable for syscore and since
they can't get around that one, they keep using it for a bunch of other
shortcuts.

> Also, small nit, make the function pointers const please :)

I originally tried that. Unfortunately, the struct syscore_ops contains
a struct list_head to add it to the global list of structures. I suppose
I could move the function pointers into a different structure and make
pointers to that const, something like this:

	struct syscore;

	struct syscore_ops {
		int (*suspend)(struct syscore *syscore);
		void (*resume)(struct syscore *syscore);
		void (*shutdown)(struct syscore *syscore);
	};

	struct syscore {
		const struct syscore_ops *ops;
		struct list_head node;
	};

Is that what you had in mind?

Thanks,
Thierry

--xzuw4l5ej7k2fa3p
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmh6UO0ACgkQ3SOs138+
s6HHnQ//RJDy7HyKY3QGC3LCcmt2Vfyic7ACiUP72YYAnBKVHsFoF36OZi9Jv5iG
Bq9Go0qFfluWgOrOlsjmhHE2BEj6shRzh/+yjZWu4MpCdM2CpxnUz/bwHQryuDKL
3TMs47m/NEVQ0IqPBmMmqHjLoSZ8q1c5URJv8kzhGFUZPif5CfeDwU5Myq7IDMd9
yqc25SLzHS8bhHyFXDVzGc06uTrdwRbopvwS+VEFtupMNrGD/bmVo2f7HE38Vrgx
aoX6xxuDqTeRRonB9OxU0Upm0Kv/JGXetysgOLLHml2TvQudYg1sG/xbIQqymU2K
YopxcFWmObA5qAPRadidJChbWyaKpZXfr2rqsgvM28cnRmCjKIDRpmVzCsLpQHBb
fJ7tbGWQBz4ZFczYLM9Z6cjZPJFFuwHjzm9dRNH/ppJKWmtr23eSYuWX44kG19CM
644Z1OYxg9GBp5mZ7mGLu3HF8ycXWFKDoApp62SLm7TyHRTP/W0Kn90MqgHuAd4U
0RhHg1+7MlFBE9jC/X1Ac+RsZNaZUd+biEy6QvAkOHL5VtPxlR9OCKhftZcsPRuM
YdQVi9IgteKqzq0ul2dQbTD1LaqzrEYmFXJ1So3dTTSbOUqrb+VDt9Bqtfm7oGdG
O1NPiukTbLVBWb9QXt5vvJ6QXxC7wn5jdhgby0kUROvSnCkM+8U=
=McxE
-----END PGP SIGNATURE-----

--xzuw4l5ej7k2fa3p--

