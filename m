Return-Path: <linux-pci+bounces-39809-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FF57C2002E
	for <lists+linux-pci@lfdr.de>; Thu, 30 Oct 2025 13:28:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D49224621F8
	for <lists+linux-pci@lfdr.de>; Thu, 30 Oct 2025 12:28:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B86D3126DE;
	Thu, 30 Oct 2025 12:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gXvYXwob"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F4220313E2B
	for <linux-pci@vger.kernel.org>; Thu, 30 Oct 2025 12:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761827292; cv=none; b=bpFi/bXrZd1EBU53I8teAAMP2WpoHahruztpp1YfpnoIMrRqXO7jV+rJOgwBECBAPZ3JBz4qbxfHTwXV2OjFefCyXT8Qt41os/rHWK3m1QYYkZyvMwO7RIVWBGu4MQxsAGF6cu9FDSRfs7sy5/bbUoEpmj4HulV5NBaIkgrsFCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761827292; c=relaxed/simple;
	bh=MP/GQsemHnbJLXZSkSeqHyRxgPMfPq6oei3BZNEbjXQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T0XXINKgLBFgSgEDAyVkBGMEIdfG0Cwq4eoyaxeFxmsfHruolkAwECdXz1GP/u/03DslqIxBKrlTHA7x8inWg2qTNuItBWJE55fyRwZg/h+HLsHvAm/QQ0KzbeU8GX318Is3q7RKPxSmSlLfi+uzapmClnGHOsDeTS3HC0IwYO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gXvYXwob; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-475dc6029b6so11114865e9.0
        for <linux-pci@vger.kernel.org>; Thu, 30 Oct 2025 05:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761827288; x=1762432088; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4faCkAArvXRFWP/BvJT3qCkXJoGOkTL/9xvSBBThwwA=;
        b=gXvYXwobG7Ndor2WEJoyBX0ENtjcowkmtMAvdHQOwjhR7ECEn+YhAhvvE7Gcf27kA8
         ll9Eaowj9FG1ecycGlqPqzxXnEfiJM4zJ12tOWYZbCv9ZDJrp6gnjKGvyKhhSs3FqKu9
         x8nJ6edmTH9oHg48uATPCmYQdtSEghDL13PPdwuwKftafdLc1AW8MazEIZPDZfJGE9fp
         vEhuhHLnFVS5jCWgLbo03OhC+MQE6+FKqrQTECrc+RS5nglXbEE3ltFsVC83SO/8T+dG
         B4u7w+q+XTcz3TrEnDJlGKbKm75GFei8gfJAYigBxd4P1202hxKN5/JXtygJomHGl+Pt
         pyqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761827288; x=1762432088;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4faCkAArvXRFWP/BvJT3qCkXJoGOkTL/9xvSBBThwwA=;
        b=Cw6EJQ5L/juuqDY756owOdDAYOWoPApw5HrWUfNzvZE1SFxQ/l5I87L2bGJTSlzHsD
         VqTMN8cs9ECacujEuxU6SmyVhzlDy5bcyysmORG6p5R7I2amhynWZ0BkaUp95FjJV/Gl
         KNUEuFR9870fiASsHWr/2JtSIAELWIT70gy4tVb1q/7Erq6/Uc/mRHLhV0J5AJLvbAbw
         fLOzP/wy9XqsX/BN34nMqZRYyrSj/k2GuAet6SVj3Lr4Gxiiirky25wqpkEqmrYi8Pn3
         qq/xqnd6p5slrx6OWDXg9A+et1X9VpditX6fKaiDU8uvLWZ75hnocSCzzaYIWXSRPFuq
         JROw==
X-Forwarded-Encrypted: i=1; AJvYcCU3YY2ApWUl5gzZypTjGDvEy/Gp00KiqWIGRmY6V2vHv/tdiGHOHAQHs8d/J9oJHh4RwulN6j7+JlY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKR+w9uWnAJhnFeXR5KJfMFZV1T8d5aMKpSx3T7Tf03Hl15QhO
	Uk7zgNpboaf1I4e/8h343WawAp1a4wUieoBfNv6Za3NKJqKm0MDQkPcQ
X-Gm-Gg: ASbGncuvq8a2PbWJbnLmcMJqExomSyHPJcKOHAiqI4mkYJS3E/e7owLsvM1m1we70Bm
	+CDFZAYYqkLKXhR6HAgFDZnL6dlYaZr+YO2rxxGiMQytEgS9T0HVsplnrbL9vVKxR4roGCSr992
	D3hJgQC5+iFngzElrjzo3RUX1XKkFgNVYeySUCRZ1l0oudqfDFNVPhWhlQTQaWE6pxXoAsdootO
	uwihNubBuitXgIind0agIRJr33aDhQy5DIMm9L5UUtCXRwpB9syi5afekGHmzdew4KN57IZTEi3
	4DhI8rti/YEulM7kA3YFWMIRiqYhpjXb+AworMHj4+TKssDVJmmUvVq4tz+8YFBaOK75Td599LG
	L1mwpOtZ+rRIMMgZQm9ClfDIDVn4JbS+mKuhrop8PqJBfUa5LnyTNFg3kbYrn8iZbUgeJrWKttY
	YU81kHLYAdmnQkpeaEPczT2j0w9T57Nfa/ydLSW0kNC0JJhenp1NPBNoPtrDj7QWrdAAeA1dxGU
	w==
X-Google-Smtp-Source: AGHT+IFohGfPrMB+gEC0PPjeDu6wKsKn5Xw4tnoTnVq6JsR15gq4re74GuIZTwiApDmgxJjGG1cQpQ==
X-Received: by 2002:a5d:5d06:0:b0:3ec:d78d:8fcc with SMTP id ffacd0b85a97d-429aef82ae4mr6294449f8f.14.1761827288007;
        Thu, 30 Oct 2025 05:28:08 -0700 (PDT)
Received: from orome (p200300e41f274600f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f27:4600:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429ba445463sm2028625f8f.10.2025.10.30.05.28.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 05:28:06 -0700 (PDT)
Date: Thu, 30 Oct 2025 13:28:04 +0100
From: Thierry Reding <thierry.reding@gmail.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, x86@kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-riscv@lists.infradead.org, linux-mips@vger.kernel.org, loongarch@lists.linux.dev, 
	linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/7] clk: ingenic: tcu: Use contextual data instead of
 global variable
Message-ID: <5psq67p7ozmfz6mbi626q2uixqtbtfpejkhud5fv6wqr66xasz@ksiokkf5qsgr>
References: <20251029163336.2785270-5-thierry.reding@gmail.com>
 <20251029175647.GA1572736@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6ob5xm6zi76m7ppm"
Content-Disposition: inline
In-Reply-To: <20251029175647.GA1572736@bhelgaas>


--6ob5xm6zi76m7ppm
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3 4/7] clk: ingenic: tcu: Use contextual data instead of
 global variable
MIME-Version: 1.0

On Wed, Oct 29, 2025 at 12:56:47PM -0500, Bjorn Helgaas wrote:
> On Wed, Oct 29, 2025 at 05:33:33PM +0100, Thierry Reding wrote:
> > From: Thierry Reding <treding@nvidia.com>
> >=20
> > Pass the driver-specific data via the syscore struct and use it in the
> > syscore ops.
>=20
> Some of these things in drivers/clk/ are also platform_device drivers
> (though not this one) and use generic power management, e.g.,
>=20
>   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/drivers/clk/qcom/q6sstop-qcs404.c?id=3Dv6.17#n209
>=20
> I have no idea if that's desirable or practical here, but using the
> platform_device model instead of syscore could have advantages in
> terms of modeling device dependencies and ordering.

Similar to the MIPS/Alchemy PCI driver, although there's no git log
reference in this case, I suspect this was not in driver PM on purpose.
The pattern I've seen quite often is very low-level device driver code
doing this using syscore_ops because they run very late/early during
suspend/resume, respectively, so the driver PM callbacks often aren't
sufficient.

In recent years, some of the issues have been alleviated by things such
as device links, so a conversion may work now.

However, often these are also exotic and/or old devices that are
difficult to find testers for, so I've been trying to keep the changes
in this series as minimal as possible, so that we can be reasonably sure
things will continue to work just by reviewing the code.

The most important bit in the series is patch 1, which lays the
groundwork for avoiding these global variables for new code. Also, in
particular I have a concrete case where the global variable approach
doesn't work because an IP block that used to be a guaranteed singleton
now no longer is.

I have looked at various drivers that I ended up not converting because
they use a global variable not only for syscore but also for other
things and fixing that up would've been way out of scope of this series.

Thierry

--6ob5xm6zi76m7ppm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmkDWcwACgkQ3SOs138+
s6Hg1w//bfwZK2UyWYgH0DjUdLRkw/JLbu/3memPliSQO+SxPOEf7uwnD1QnAiQ3
AaL3UiueXsnj30IkhBnqYoPaFQRz3G5Ag/PFIKX3kireFrAExwZP/9AKWiJflD1I
gh+QOfqgZ1HpJr3QSmmjosBmkm5T7a/J5dUNuCcZoRcya8QmACQqg3sWy8gj4BdT
Hy/aq2/JWEEJs1pLE5SvCexBqTP5gxTj8MTuNgqm3hRDtZc4TQnKNZIcJwgOruMX
Wy4rrgBPQiASKxxP7ksI7iXCTOYM61AlEm39RUFNcGKI9iOw1YxFn2LuVIPoFJc6
H92dgYcRmcEgy/oWPc8yTs9iX2POH5p/40/nb53U3sj6iQVhEMoVIGmIuxEX9RHL
VHkn3RNfYCZlwqDtwCCoN6DWBW2PNUAX3dsD1ng3ZZHuDH2lbQaQudKRi7MGhAxm
ADqiAfq1HO8Fk6uo5BFMtpieue14jJFHaQs21TkOlurf/LH9GT2qO52/8KtcxYx8
F8pXjAM4Ps+sj+Er6h1Tb6PpXrpJ1lvGqagYTEJpWQuWyjXLGeseMpif2ucjdzjp
4qfcE13QtePpLlbO8kklfDMdo6+uClFAMgWMM0jWWFtczIaUWmwRYcDGUbW4RbHt
H6TJJVsDtuaQNx9wfo+vq3oMZviuttJPzFqYefIOL7oACIZD6sk=
=0K07
-----END PGP SIGNATURE-----

--6ob5xm6zi76m7ppm--

