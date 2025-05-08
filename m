Return-Path: <linux-pci+bounces-27432-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 05494AAF5E5
	for <lists+linux-pci@lfdr.de>; Thu,  8 May 2025 10:40:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C79071642E4
	for <lists+linux-pci@lfdr.de>; Thu,  8 May 2025 08:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DCFA2627F9;
	Thu,  8 May 2025 08:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MLLFxppV"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62FCF262FC9;
	Thu,  8 May 2025 08:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746693627; cv=none; b=n0QiVvg1za2aT/bcl7zqpi8kEgLAGSuKiQTCLm7XhJLT+AQd6BIED0tky1FyFc6fRH7ffn6k/Bc84HY77T9yMEwhziajs3c+HyksJMKIwuElW/N96jI+6lc4uPsKEe++zrhk5wfWJGDdMnlqn0Q6xpHxhZ1m8B4sbaO0DZ+4ovU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746693627; c=relaxed/simple;
	bh=biF9LbNbWIVmr1lu/SJD7jTVvIudv3FbyuuHOOWKLi4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d6b0A0gvFrhZE9oobfydzJ3kJ4GhHIrXKOpB95xK4b0a1Ye3g8PPEJPQlHWU3fucmmVsJKz6eLjU9JZcWKehjd7SbUFsScHvrZsw62X1Fn7WY8MXUziDBCoKL5Jj+IvQMkFpKrlMgF6HYmOyIzu89MkkixXt2I4e3eiXXIkEdZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MLLFxppV; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-43cf257158fso4637625e9.2;
        Thu, 08 May 2025 01:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746693624; x=1747298424; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=biF9LbNbWIVmr1lu/SJD7jTVvIudv3FbyuuHOOWKLi4=;
        b=MLLFxppVu1Z0fZCHsJnWTjnvDTIw3cde5GFAXARa+qgb3AZ67y33Lhp/ZLV0ZvN3Iw
         j324BoPhy2FYNFkWFusFLuflfj31F+wnTEMf4C58Cur43EgK9kKenkI2gYznRujom65c
         A/5sdSxLgu20/Mfh3cy2xQqD7RfJy/7eQa/8tW/ZGKMnNWZtxhvFUjYkXfXOAYIOYLBk
         YFJ8zHcLAHMaNkub1Yk2qrR0v6cp0oyY0qPhyAVdJrr9vKMKqdHZyt2cOdimesjWFHqn
         7uazVsP0Sdn84ecrqskkev+8focgYyXYyL1n/B40qZZsxo9tF1sNFcW5TvGsH6iy6baq
         ROKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746693624; x=1747298424;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=biF9LbNbWIVmr1lu/SJD7jTVvIudv3FbyuuHOOWKLi4=;
        b=XJrASmoDUA6EKYEWO2XaAOM4H4Lvz43Ca2VOHDI1SDQ6EOEaeCXTb+XwLb6Z6NWwg0
         XE0+zKU2cORKSu+BiGP7591JGOIYjOLquX828QFQgX9GA9xS7xst+Y9oKtMkBdtXfU7+
         JvP7wP64mo/kAYh6sn4QWFAe6FsVy5CZzqF68iEpt1tvSg7xMWfJDvGPX8NBtoLnPTFX
         QwcchI/fdk7vVjq7AQ3Qxukv7i1iFCNZU+dgKs6n7yeCjtNYHYUrJoW9bdQf6SBNwvoz
         Cr8rR4rg5x1os/PnQSZXGAE+INgplQe0qnqy27AWUY3eXG8M5Z/ABcAE5fvNf/u5P296
         P4JQ==
X-Forwarded-Encrypted: i=1; AJvYcCUW/WriAW1RNg8vl6dUBIHKBLNBMG/u6CiNqRm5beIRRRAL/myplRk5Wsok/W2BRw8Mk+n4ThJ1CyfERNw=@vger.kernel.org, AJvYcCWH6diyIMnfH1dPbtGBD4LeMoX6xrFiWXDoA8py8B87e/gP/huRSZ0q7GbkSTZhVlt/esiRGlT9hSQ/@vger.kernel.org, AJvYcCXRRnXxoIesHyrn+YqnMRUcgZiGBH9Vjuk2ZZeJE6MQqoosksQ0zlBqGTFo73w7qB0XhHNPkjt4E4M=@vger.kernel.org, AJvYcCXkD7ULxGp95fWE63H1Gya1bXmhixhjeGTUJBT4JRLYvthvjS/xsm5ohrWOUbTri+OdieJj3Djrbax7Ir0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrwwWbMqIfx+xvvmI+Mh/v6KSYkXB0qS2osz9cEfzGiHeYf23V
	TjkAvhp7/FyK7za7j6n62RdNQ0bN1yjflwNpRx0I979Jv50pOBpm
X-Gm-Gg: ASbGncvMUxEuTps28m+E8JB3KD4wLyhdVwJEnCK0r3zNbqY2M3EhBcFmER24si0IqoB
	pfvUf7HGQoTJ2Fid12w2sulIZ4EAAuesbRYgBCy2LLfHHIGIPGYewULReyemzNsD7UYXVUPZLhe
	jjXQwILx2QBfK+GbaraQCNmZs0sluR94uRmCS+oBvGOARgUJHKGChz2gsmvrjh2QcUm6ATI1Abq
	crsX+7jwy0C/S9dXM9O5i+pKJwoSS9wRNbCHGjgo19Zqw90+TiWuATvNy3OMqJy5waEpwgokzyn
	iPrXv4/cbLS+GisaMglUD1p4hiVmo9CHXl92FJAGIB2TYhHifyhNIutCTbkicz86qRZ1WLPFrX3
	Oe9Wwlgep/Bg7NgktVE+NNSut+7k=
X-Google-Smtp-Source: AGHT+IE9uqNT3gs5cTTSDhRlYuFC4GTWbpWQezWktgdQ2wds9Sy/hE9+Jxp8jSBAj09Y6gpoG60aQw==
X-Received: by 2002:a05:600c:1c03:b0:43c:f85d:1245 with SMTP id 5b1f17b1804b1-441d44c7c41mr58471955e9.17.1746693623489;
        Thu, 08 May 2025 01:40:23 -0700 (PDT)
Received: from orome (p200300e41f281b00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f28:1b00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442cd35f40asm28526745e9.27.2025.05.08.01.40.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 May 2025 01:40:22 -0700 (PDT)
Date: Thu, 8 May 2025 10:40:20 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: webgeek1234@gmail.com
Cc: Thomas Gleixner <tglx@linutronix.de>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Rob Herring <robh@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Jonathan Hunter <jonathanh@nvidia.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, linux-tegra@vger.kernel.org, 
	linux-pm@vger.kernel.org
Subject: Re: [PATCH v6 3/3] PCI: tegra: Allow building as a module
Message-ID: <w2ertcizgmtu27kcike3lpw5dvhvqi2b4c6amqzwdfs2xtebfy@itrpen3oblhs>
References: <20250507-pci-tegra-module-v6-0-5fe363eaa302@gmail.com>
 <20250507-pci-tegra-module-v6-3-5fe363eaa302@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="5kggnoviwlppqn34"
Content-Disposition: inline
In-Reply-To: <20250507-pci-tegra-module-v6-3-5fe363eaa302@gmail.com>


--5kggnoviwlppqn34
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v6 3/3] PCI: tegra: Allow building as a module
MIME-Version: 1.0

On Wed, May 07, 2025 at 10:25:54PM -0500, Aaron Kling via B4 Relay wrote:
> From: Aaron Kling <webgeek1234@gmail.com>
>=20
> This changes the module macro back to builtin, which does not define an
> exit function. This will prevent the module from being unloaded. There
> are concerns with modules not cleaning up IRQs on unload, thus this
> needs specifically disallowed. The remove callback is also dropped as it
> is unused.

What exactly are these concerns? I haven't done this lately, but I'm
pretty sure that unbinding the PCI controller is something that I
extensively tested back when this code was introduced. PCI is designed
to be hot-pluggable, so there shouldn't be a need to prevent unloading
of the controller.

Rather than just forcing this to be always there, can we not fix any
issues and keep this unloadable?

Thierry

--5kggnoviwlppqn34
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmgcbfAACgkQ3SOs138+
s6Fz+A/8C7VaC4JinitRsZHtP4F8qGpgtEyHU0xDilJjzE9nyNjUuZ9JzEjmRmk9
2LBWYKOWNKou1WycC86QEOKiP4QTBVVtS7SuTctUmm1q5CMRA3EmwQg5Grm6aIXA
0ke8RS+ycqpoOxfp21HAX+06ZmcSNfXGvwd0lRTIDASygkNPU+SYrWrXptpJJEzl
G/plwuuN0guIQGlJbi4N0Hy1WA4tz9/A89vdmmqoTP9lgpeGVyy0OHIRlUpVHjX+
SLTAvvrCWdwcMPFbY+1Pn05SpwDfsDZFWzmQQIJw6nVWxPSsl8lr78h6SEZNMb0p
WsEDQ9hiu0umMdgAt72kspcXRrXYyxFZlkc6mfMTlluOYaGmxIV0giKD34P9jKME
QxgTXokluvh4Upy1R3xdOVtQlfGC3hFRkk9Kl64Lho6v9KM+6L3/vH9Ckl1KP3pu
I3Dbxj+MGbIPv6+b5Zxpa7VTUbvzgWg0vkUVhByJZ4OizdDYMpKBahF9gSCrJoFK
lr5GxmqFPV5ebkddsavHQIM4oLq4nLbnyclgqNRqNP2dpxRnnJkmOK+lkIBz5cX/
uSagR6ocrkuc5xKNLMNdgxWDD87FoowGa+Tkagx+qrtF90chIpGAj1YJaufbVqOH
79EUtQCPydxK6SJV5I93R+zQZ+UFmLJjS44g7Rcqn0A8hVXrmI4=
=QGvC
-----END PGP SIGNATURE-----

--5kggnoviwlppqn34--

