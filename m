Return-Path: <linux-pci+bounces-27440-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 59A03AAFA7F
	for <lists+linux-pci@lfdr.de>; Thu,  8 May 2025 14:51:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 461BF3B260E
	for <lists+linux-pci@lfdr.de>; Thu,  8 May 2025 12:51:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23BA422655E;
	Thu,  8 May 2025 12:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cxXfurJY"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6109B1F9ED2;
	Thu,  8 May 2025 12:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746708703; cv=none; b=DvaAza6IrhMiuaG3Yx73dDz5EpC0CRZUgm7HACtddOzS4hVsaKO5Zq83RWpDX/p0u/kcGqCzj1nqQk2VKfKxvU5O8xuRLQ7v2khKn8dNbb8ZVVkt90auqWp/ljkbecYnbyR9S7xq7CrcZGn+AT0pND1g58ISiNFrDSkCF2jBVak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746708703; c=relaxed/simple;
	bh=yIiNkKLReloXickrnQEpD87aT447ViZNb8D5a9BKc9M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tUdGmm5qiMV2if7gvp7wVr06K88k+h4/wbaAFelHpLrXjIsGUapnyqUNAz7v0ai6o4EwM4w43zccBehjAebW1yb1Rgl2G5p5u+v7+fKkP9UiuplsQg7K+9JXA1swUit1SUgJZTXiCWLRX1O55XCzBPy3xNrXNLDpMzo6D7Eemyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cxXfurJY; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-43edecbfb94so10096955e9.1;
        Thu, 08 May 2025 05:51:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746708700; x=1747313500; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yIiNkKLReloXickrnQEpD87aT447ViZNb8D5a9BKc9M=;
        b=cxXfurJY/O4NHDAhRbj83PNLHIHkdhXuEAHUDaHIxr7bRFu6Mj5ZE2qtTHBr/vutCT
         mGWM01juhiBw9Ub/0nXWsbjTfm/Krmsw/xrr9nQ6Ngda5CZ6LoDlFcgPnlViahQ/hnzK
         niFCP2bXK9bmFdn9JfBMEqIlRyaPTg1enKR4k4YgnJw38l7bB5VeVBN5bH1O5IuUdQiN
         InpC6UyTT952xyzrcTcLF9dm7BD3iF1h83tetn0iKxuvJZyGwvbm1A3fv4yBWRadsJWf
         kxR7olcX7TSzlDtJfYJ/lElDC78ajvPpOfWq1CpTSZUjriGIEvMUwOCH/h86o/Pvevsw
         F24g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746708700; x=1747313500;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yIiNkKLReloXickrnQEpD87aT447ViZNb8D5a9BKc9M=;
        b=AdnzPrAbHXXkINunFUAjRztG0wWNlHdBecPSYn4AMOj8xIiyAQ1b34Mtoy5X8IQtJ8
         7mZ8TXiENF6/IV7TgWS+zsJIhUuGnLGJ4hkLMWv8K8RZV0jnBBLB3hQItDzHduxNmb/A
         C8jvi4dxczMyNULRZuWPmqhlQ75nPcFhHTu4aZc2y5sCH76/zOplrtHX74b8JkINjEWl
         mqcRN5+mi33QebM4v7TcA8IvBCEf0FBp0OZSkqZXW2YIMpBDjOlHqx3EpB+r/u/51cjC
         kI2st3b2QKsh4gVW660otDQfuhXH6rzeu9rmXKLCXjYkiJNK44YIaGhrHKcjYDuKR2S9
         e04A==
X-Forwarded-Encrypted: i=1; AJvYcCXY3CMuyKAiGKE+Lq1qtenjanZuSFaCaqQQwAiqmsUrBjRwtpSkrdzLNNcFlxN57DgWFTqLpK9ny4zI@vger.kernel.org, AJvYcCXe7q2cXzcQoYseWrtDoBOdkt2qDgANHUzoC9BmrWWkLP4wObr+EnB9fhYvtzZi/cVP+1GPFYoE+pD+CPA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2uwQNiu4ekKs7Cqf/XQ+4obdTDdkRIfyTPKGNk0J6NRrUtHMN
	0SjXlK7Fgj0k88dLkW51HWjkwoccrSdfj7OjCL0g9icp1rgxvrM8
X-Gm-Gg: ASbGncugzh5QwLMQohJ2UcovSqpiZd52HDR8q/av4CFxF28ffttwfsHi7CdcVun5ow/
	eYmd4yGJhTaoizu6CHi1M/AP7BvhW7ZCJihURKKiCg+dnGhJYg4RE9j+Cj/IJ1YmNETVGNP3ls3
	dLwvZMgjZUSgJPcH5aNJLIwhbg+hy0U3qdfGsMej+mayaNzaD/4tbfU24IkJQ8p+GiiUUc1WYY/
	BHD5YBQchCr2zMkDIEYIAQD5XEySsdL48+VZwvnFAcLYpnzFj1loEnEv6P5fZ5xAbBXsEg7TY8k
	7Dj1DQvZRO1rVGzeKCG52jpB5z6sBMWHDTeeLeh44C435y1ujFadQNLD2beq3k1JIOrx3zAY6Ji
	9N0kLB4SvT1IQxzIQjYXLS8xGVt2ZMglI0Y51gQ==
X-Google-Smtp-Source: AGHT+IFjClLBCOma1v7TfMk1NMdg04DnrdjRWX/Qf1fUQBkDZqHHKJ2StSz0Exx3dnqkzaAGiHyhRA==
X-Received: by 2002:a05:600c:a00f:b0:43d:ac5:11e8 with SMTP id 5b1f17b1804b1-442d033a3fdmr24244835e9.21.1746708699394;
        Thu, 08 May 2025 05:51:39 -0700 (PDT)
Received: from orome (p200300e41f281b00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f28:1b00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442cd33331bsm36163885e9.14.2025.05.08.05.51.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 May 2025 05:51:38 -0700 (PDT)
Date: Thu, 8 May 2025 14:51:36 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Niklas Cassel <cassel@kernel.org>
Cc: Vidya Sagar <vidyas@nvidia.com>, lpieralisi@kernel.org, kw@linux.com, 
	manivannan.sadhasivam@linaro.org, robh@kernel.org, bhelgaas@google.com, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, treding@nvidia.com, jonathanh@nvidia.com, kthota@nvidia.com, 
	mmaddireddy@nvidia.com, sagar.tv@gmail.com
Subject: Re: [PATCH V4] PCI: dwc: tegra194: Broaden architecture dependency
Message-ID: <a6dx377rhakpl3gvvyofdbui5sbccf3fhw6o2qb55fmmx4v4fv@ifvzdjep2kp5>
References: <20250417074607.2281010-1-vidyas@nvidia.com>
 <20250508051922.4134041-1-vidyas@nvidia.com>
 <aByg1GUBno3Gzf4w@ryzen>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="s5xgpf6bsu2ar5wd"
Content-Disposition: inline
In-Reply-To: <aByg1GUBno3Gzf4w@ryzen>


--s5xgpf6bsu2ar5wd
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH V4] PCI: dwc: tegra194: Broaden architecture dependency
MIME-Version: 1.0

On Thu, May 08, 2025 at 02:17:24PM +0200, Niklas Cassel wrote:
> On Thu, May 08, 2025 at 10:49:22AM +0530, Vidya Sagar wrote:
> > Replace ARCH_TEGRA_194_SOC dependency with a more generic ARCH_TEGRA
> > check for the Tegra194 PCIe controller, allowing it to be built on
> > Tegra platforms beyond Tegra194. Additionally, ensure compatibility
> > by requiring ARM64 or COMPILE_TEST.
> >=20
> > Link: https://patchwork.kernel.org/project/linux-pci/patch/202501280442=
44.2766334-1-vidyas@nvidia.com/
> > Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> > ---
>=20
> Looks good to me, but there will need coordination between the
> PHY and PCI maintainers for this to not cause a kernel test bot
> build failure, if the PCI patch is merged before the PHY patch.
>=20
> Reviewed-by: Niklas Cassel <cassel@kernel.org>

Either the PCI or PHY maintainers would need to provide an Acked-by so
these can go through the same tree.

Alternatively, since these are only platform-related Kconfig changes, I
could pick this up into the Tegra tree if I get Acked-bys from both
subsystems.

Either way is fine, and in case it helps:

Acked-by: Thierry Reding <treding@nvidia.com>

--s5xgpf6bsu2ar5wd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmgcqNgACgkQ3SOs138+
s6G94g/9EYpEju+sw29ZHmw7J6bxE0T+wHJHQXMv8l8jo8DZVHyfZeGioqb2PjNw
PCt2Rd8DhNSj5jZuiJyNMBp2kirlKJxI+zuKQ7hA7OLSdXp2+xQhaYAIXEKf9cdN
0joxct/6B6AvAA4ccXb7LM4GcqbHX039+use52o12wTgZqoeumFuZk0Tmyvf3kCr
3HWgBY7xIN7B2nyiOS1jWhtzURmf7zDO1bgMMQ5h+iT033Pr4Px9DiWV6/NkolT4
ZD0D7svrTiYr/VDs5162CsIR9zeL+AdbNhqBxYcjXFFVS/U0QelD95sUIvMunjNp
HkJBfnIDou4nrzsb7qUFapG0Tr4Rtfsa4T24KlLZhg2egDrSZIvDAGmLd4QI1G2A
LldOxBh7ND8mZGh16LvxI4XBF8jxrALzVJs7pYTYr2k+XO9jYznXDoQFFoV1ktYZ
+7CarzTC6aEQkc6FuWETnWeBADj5tbwL4yR/IsC/AORyASrrPuQvTyPhg9+W2k+Z
cUlLMJcR6JY8mMvjaroAyQ7ez6qewcJyNEsEI7GJ3WEAy9dwUy0OcfOapyGjN4cE
/p0wIUw2FntyKfr00/XAQhpMI5z33AQNLJRJj4TTpelOG12LVFVhEr9qc8jP+yqY
37h1efVocLcm7ioar5UX3t/Ony4zl89RTWrTtFequ1FxSkY4FE4=
=gVmM
-----END PGP SIGNATURE-----

--s5xgpf6bsu2ar5wd--

