Return-Path: <linux-pci+bounces-42503-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F099C9C2A8
	for <lists+linux-pci@lfdr.de>; Tue, 02 Dec 2025 17:17:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 193623AB870
	for <lists+linux-pci@lfdr.de>; Tue,  2 Dec 2025 16:10:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DD7E2367D5;
	Tue,  2 Dec 2025 16:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="WPf6N1BV"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2EF4248896
	for <linux-pci@vger.kernel.org>; Tue,  2 Dec 2025 16:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764691842; cv=none; b=AGrFbiqBtsfiup+jgc7KXqvcEmHLENCj6YUiPtrxgP6x0YZOL2yCbahHldWQcsQH8UPBjIzddkbZ7QFYaKcAp0sZah79MbkNCRgrGsE0OywNwGSBYri6XlCTpg13+aVBSUrPJI+VREo674muUDc4srYaIw8B/OXoE/+xarcjSyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764691842; c=relaxed/simple;
	bh=Rv3ORYpUoLapibHnhDahj9X3LIqllYxiQYMXrjJmokc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RqBIRniu03dW0cGWtz0CoGM89Y3rVPPk6gnF8PW6nwa51CA0QWzSi7QZXmjR3vMK1FnFVO4zwJZ1TW3bGE4ScJJQQ7VMgM+q4aGedaQTBLToSs1Ho29DyKgBChN5VqqziCI0PK/agUa5+olu7sOzNjWR9wIY9tHyTi3lo/pzB0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=WPf6N1BV; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b728a43e410so963065766b.1
        for <linux-pci@vger.kernel.org>; Tue, 02 Dec 2025 08:10:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1764691838; x=1765296638; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Rv3ORYpUoLapibHnhDahj9X3LIqllYxiQYMXrjJmokc=;
        b=WPf6N1BVTWzPeIS/YWR/uQjHcodHK+RP4ae4T+39lPQwsQDrwaHSKwWxvjT4aVXK62
         GYHHUm307pvbKEC4nD/lMTGCgIkQ+EZ8S+C2gh9ApDi+DfGP/YWyfKIcVyL0H0egjwqb
         wfr2b1vRYrokl8tjZVXlzRAgf8NvITp4IKnLu3bKlSPWKABjn4lICnjs0M1/NQ4rgSK5
         zQnkAXiaEMJgkakYjNCDbH2R9Xa/EaOYhhBcCIe3RCVXQPqhq84OG0LE4go6RMxc1Djd
         c/5NWgy/hYLtwtPyFm5wA03pxx2JxKo5+GLSIjvjO8/3v/ucr+NIc29wOIoNz1QxiGnn
         iyGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764691838; x=1765296638;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rv3ORYpUoLapibHnhDahj9X3LIqllYxiQYMXrjJmokc=;
        b=ICgntosp3vUaMoL+Sfwjmv6O4ShYS/C4F2Y8lB3VMCsS3zMHDxZkPiFQ+sr/dheZJI
         frcHHhVp632Q7NxIBxz/cr50sCJRRSEY239Uv61JeH9q9s0skmrrFVBMQTM6EFT1htpZ
         RoaoDBMu8geybbIKziBVSs1PYOH8AKxrxJ7JJmXmzx5zObH1mpD9TLlsEcWPk0IAbeXN
         w25OX9HewBYt+c2xK5X5KVaIq5lzNGYpawBUdfvMIWwfqeK+uvS0SqTviJOmnNs6LQvB
         GO1nfu4vp2wxeB9DeBPJZvVci1dTdUvRZpzgRoECcs+TUP5a7s+uiQXOzu5NNTZAVSqx
         sIlA==
X-Forwarded-Encrypted: i=1; AJvYcCVx5lSOJ+vRaWUdYBgJV1ZAQKYvqbU5RF89gqrDMmatJBHMe4Ln6I2yzcDWKhTUNXmTtVnCLApCUuU=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywc/nFoX/b7EkwnC+/GdJfx7YunBJtZNwJlK5zi9mSGyqaWIl0v
	teKoobKCjfOzKhEzBLWbQ1fTe13sn1HyI4gOZ9aSqtQpiRjl9HEp+YAT3Lg3/wBfRo6aVVfB0Td
	abcVc
X-Gm-Gg: ASbGncvHPOci+GqlMusDFXRn3kkXd7NNhdyVQxA9pnBC1rxhVD1aAFmsPLR03FUtqik
	+SJXcFyRBkdKR3qsq7LKODt7/h4+GYp9w3S0pfFVDWpqCqUNFFOj2UxFha2DdcdgSw485r95KuI
	c+AB934mMWzjlW8wcaFG2cVwK9rFmVeSbPy4uFgFh9in0vushFS90ciUBKDaZ4adA/8mPuYblqP
	d4Jk4iY76S1xzwikN9h0UglIYS2R/KzOd8ZiHXr0eodrRb6Kz0l88QtkXs+Uu8IUbxiPxUyn7GO
	BVcUyVXLtG6ayBAV94SHyYRC2HNduFi5q423Rwc21uZ/Hl2M3brOrkz9vaZQLZCOphFMlr2UEvY
	Zk3SEq2rnppRJk/0OOlC+tonORsRWm8BHM8Pglt1xGO4e3GQU8AXRs9sFujQMzoADVo3YXybfA8
	2vrvA3/ufpIp53ALzTV1iYBOnS1ZcldAxjaS+Vo4ACID6VmcDyvZXbl8GCSzognSS8MLRtNsbUh
	NTJtdhYHGM5bQ==
X-Google-Smtp-Source: AGHT+IFtSiTjheiEEb9pofveRDxC66a01GE1WpwXcCPmSCCpouaedopeDj9JWPZ2qcatCxaxoF1GjQ==
X-Received: by 2002:a17:907:dab:b0:b73:4fbb:37a2 with SMTP id a640c23a62f3a-b7671514106mr4650765366b.5.1764691838255;
        Tue, 02 Dec 2025 08:10:38 -0800 (PST)
Received: from localhost (p200300f65f006608cf714cc86879bb1e.dip0.t-ipconnect.de. [2003:f6:5f00:6608:cf71:4cc8:6879:bb1e])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b76f59aea6bsm1518678866b.35.2025.12.02.08.10.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Dec 2025 08:10:37 -0800 (PST)
Date: Tue, 2 Dec 2025 17:10:36 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Lukas Wunner <lukas@wunner.de>, 
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Feng Tang <feng.tang@linux.alibaba.com>, Jonathan Cameron <Jonthan.Cameron@huawei.com>, 
	linux-pci@vger.kernel.org
Subject: Re: [PATCH 2/6] PCI/portdrv: Drop empty shutdown callback
Message-ID: <xmwaahsu4lho75z6fbxojsqlqbgips3thqw44jlxtfqnhowqv3@rvbt2wm26mxd>
References: <cover.1764688034.git.u.kleine-koenig@baylibre.com>
 <283fef06ac51efbb7df25f347d6f3a2967f96429.1764688034.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="p3menys6kwepsq2e"
Content-Disposition: inline
In-Reply-To: <283fef06ac51efbb7df25f347d6f3a2967f96429.1764688034.git.u.kleine-koenig@baylibre.com>


--p3menys6kwepsq2e
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 2/6] PCI/portdrv: Drop empty shutdown callback
MIME-Version: 1.0

On Tue, Dec 02, 2025 at 04:13:50PM +0100, Uwe Kleine-K=F6nig wrote:
> .shutdown() is an optional callback and the core only calls it if the
> pointer in struct device_driver is non-NULL. So make nothing in a bit
> shorter time and remove the empty function.
>=20
> Signed-off-by: Uwe Kleine-K=F6nig <ukleinek@kernel.org>

I got the email address wrong here. If this version is picked up, can
you please make this=20

Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@baylibre.com>

to match the author? I'll fix it in my tree to get this right for v2 (if
that will happen).

Thanks
Uwe

--p3menys6kwepsq2e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmkvD3oACgkQj4D7WH0S
/k6mzwf/ZIcmqoAr0DIxcsNwlKmGPpeaQN0K33SAVEknesPMKDZozhjeasv56NzZ
gUWMFG+zQROqi49QNGzMhMRkbDc+7ddQ0JF76uoladuE4PBVJb+34kAmr8lckEg7
Xciv88/OkI5RJAHcIFlLTj2rzsTGWGoH56D3Pi3UKUtP2CaR1WqmR5dx2cqKnDtn
UuM/DuZmjjG/TtJq83mQADsZeXWzcbjs4rPYxFRv7NpteDgd2ptKJVTj8Xy/jzuT
Pvqp8BEsHPe9xFQkwRiVElF0Rp87DlzTr5FHjr1mR5yt9BFSfmrgidL0vu3oKk1O
ZUzIX8C9zQxm6lp9NpPcRzWnhXhrOw==
=l/iQ
-----END PGP SIGNATURE-----

--p3menys6kwepsq2e--

