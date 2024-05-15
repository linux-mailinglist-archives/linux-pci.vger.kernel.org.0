Return-Path: <linux-pci+bounces-7502-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF9908C662F
	for <lists+linux-pci@lfdr.de>; Wed, 15 May 2024 14:11:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BFF128548C
	for <lists+linux-pci@lfdr.de>; Wed, 15 May 2024 12:11:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 681117317C;
	Wed, 15 May 2024 12:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gmXbYVAD"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFB56219E8;
	Wed, 15 May 2024 12:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715775092; cv=none; b=ZIK/9unn4QJqQheqQ48VUZqvSctmwfIO4e9WzGltHkr/BB27wD+iSBNFvojWPrVoOcXxFfjCqWzgHQuGcQ1GfKKkL+OkxcF/9qGsEO0xaED7oz3MnEnm5Qqxwj26NB374z1lDPUwKyyutDFJv6NPEX3PSUfKvHYEEUeE1yYrsc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715775092; c=relaxed/simple;
	bh=TRsDlL8sCyl98mO7vQCQry7hPCiEZjBcOThVQmDnsAE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aDMRAkTfBLnagQIrOj92uiiylA5vevadQpULak3PxHLWocV5ZoDCcQNYQqAe3IPmPxz0zhHcdqPBCilsROUCsWhjw0gycLrQHn2XHKZ55rVLcRAvKySlEyq+UZbAquYVgug5Hw/6Vcrv+feK7wypUiTWLWcH4utQUgOZjjLFOJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gmXbYVAD; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6f4ed9dc7beso2867310b3a.1;
        Wed, 15 May 2024 05:11:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715775090; x=1716379890; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uRO1GLnelDCAkzspkfFkF5Khl58EqY3Lr1TOrAInGvA=;
        b=gmXbYVADnOoQlMaDrdYfLO1IDK0Lx+34fQAv94a1XUPqn9EvsquYyXFZrKyUNnGc6l
         EX2FzsMEmf/wGwhffT06nQKmBq8ZM96RYQRAiGoDN5i+rJx2/bi9rZUukxxUTZi01a9i
         kvmR1eohvrQ+60LNJr9nkajBSfbkzvYQx4oA2pbOw6a+O5xkS9QcA65emHfnJt04Zba7
         Z7baC9Tf2PMmzqDwmSDSDj0c6BgExKsymKi98d6l9WlqFxsFfZz4b7pFnfkiom+wciL+
         wyS4dtA8IycFTsi1joCIBBsVlVKuXQVD8VtxvOlOrhjxpXWO78dZ2OwNNdwY2sJ9sClo
         SzZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715775090; x=1716379890;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uRO1GLnelDCAkzspkfFkF5Khl58EqY3Lr1TOrAInGvA=;
        b=UnwD0Ok+lin9CLXvvjscV4y5xB6k4nccDHiazCu3jZZD+4Un2z+ykRPIqZx8N0q5vR
         qlYKEZOYg6Y81DWBcGxH/VbDapDqShmVW54Bkb630NBHb0wDowno4CFWIq93z8c0Hccf
         RZwFq+7sAiZrNQBY1/4TSJT276Jg3oepr9b/Cpc6UNbgZYKmMN0H9zccsmFrxCW16NgV
         9VEVWv25PwQfKVtPPPVpyqsEibGHDCwvYTkQwZj/Lo93OV+dKgNUh/n5XLW24O1rmZwV
         Hf9ZRR+XGrQi9243kpE4GN+7z1cza+Rn1nqODpBrV2uNW/fytIx6nnCsqEZfdUQ9ts3i
         0nng==
X-Forwarded-Encrypted: i=1; AJvYcCXYHiWJW0nmGNV0/pZneMbZmn51nhFOgtZeARvXtP0W7du6a88yA+9+Rs/Rcnwa3//+p4i2xelELfjw5qZDon45Pe+hHumNvCnJEOaBFtt8yIKGnzx/TeACvH4yc0DUBJCIOLAo1Fuaaag22L3njPYQYPw3eN5JF9p58P6Aum3YtaGsYucCyjERUTz/MDhHEeSeLNgDVhy/R+Ho
X-Gm-Message-State: AOJu0YwbPHEg9Ho082cUHsZtj9xRCHpngTaVJ8P/rzZyRtYTKRsuEv58
	K4nlW5rG2Ml6MMcCIlWV8RggD2x0Tgxa72oZq5m3eflYX2zUuSlZnEmAlQ==
X-Google-Smtp-Source: AGHT+IHG7hHxrV/oUj7QxhLr2TFdf3HfhAtMErEVrrunpdY238v3hTNUjjGBpDRhqlnNkn7dL17tRg==
X-Received: by 2002:a05:6a00:984:b0:6f3:e6c3:eadf with SMTP id d2e1a72fcca58-6f4df44ca45mr25106612b3a.15.1715775090173;
        Wed, 15 May 2024 05:11:30 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f66897e209sm3228060b3a.136.2024.05.15.05.11.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 May 2024 05:11:29 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 04746187C5760; Wed, 15 May 2024 19:11:25 +0700 (WIB)
Date: Wed, 15 May 2024 19:11:25 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Wei Huang <wei.huang2@amd.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	netdev@vger.kernel.org
Cc: bhelgaas@google.com, corbet@lwn.net, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	alex.williamson@redhat.com, gospo@broadcom.com,
	michael.chan@broadcom.com, ajit.khaparde@broadcom.com,
	manoj.panicker2@amd.com, Eric.VanTassell@amd.com
Subject: Re: [PATCH V1 7/9] PCI/TPH: Add TPH documentation
Message-ID: <ZkSmbZr_9hFj4kZi@archie.me>
References: <20240509162741.1937586-1-wei.huang2@amd.com>
 <20240509162741.1937586-8-wei.huang2@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="vG4xZd3V2A4WD42D"
Content-Disposition: inline
In-Reply-To: <20240509162741.1937586-8-wei.huang2@amd.com>


--vG4xZd3V2A4WD42D
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 09, 2024 at 11:27:39AM -0500, Wei Huang wrote:
> +:Copyright: |copy| 2024 Advanced Micro Devices, Inc.
> +:Authors: - Eric van Tassell <eric.vantassell@amd.com>
> +          - Wei Huang <wei.huang2@amd.com>

You can directly embed copyright symbol without having to pull in <isonum.t=
xt>:

---- >8 ----
diff --git a/Documentation/PCI/tph.rst b/Documentation/PCI/tph.rst
index ea9c8313f3e4f8..d7043fb0b71b3a 100644
--- a/Documentation/PCI/tph.rst
+++ b/Documentation/PCI/tph.rst
@@ -5,7 +5,7 @@ TPH Support
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
=20
-:Copyright: |copy| 2024 Advanced Micro Devices, Inc.
+:Copyright: =C2=A9 2024 Advanced Micro Devices, Inc.
 :Authors: - Eric van Tassell <eric.vantassell@amd.com>
           - Wei Huang <wei.huang2@amd.com>
=20
Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--vG4xZd3V2A4WD42D
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZkSmbQAKCRD2uYlJVVFO
o2/fAQDWwU+Co9SFTXcGix+apuCZ0tAf7zDMA5Y56ZXlRYlm1gD/VpD3ni4CLkMP
Iq5VgmqCFz0/e1qtYk4/CevT7Ltelg8=
=6Crw
-----END PGP SIGNATURE-----

--vG4xZd3V2A4WD42D--

