Return-Path: <linux-pci+bounces-41241-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CDD1C5D48C
	for <lists+linux-pci@lfdr.de>; Fri, 14 Nov 2025 14:15:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 102BF34B8B6
	for <lists+linux-pci@lfdr.de>; Fri, 14 Nov 2025 13:10:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 953C61A0728;
	Fri, 14 Nov 2025 13:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BVmpwxtL"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF0FA1FE44B
	for <linux-pci@vger.kernel.org>; Fri, 14 Nov 2025 13:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763125816; cv=none; b=VJipiGY7l/yii/Ddap5MM7jXLqNpvueVhJcgQJWXpivtlRGWYD1V31e4D3EGJXLMJGuKH2XD3ZK91W80EcAvKKYgfqpSjIC122kFJpb/5H8ZduvfIsrQCxMKG3c/Who65eHIQjl7mdVZb2PuBgcsOPSEaqXzdlu0p1ufwomlN0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763125816; c=relaxed/simple;
	bh=RN+oS9V0JBuDCUU2h38OjtR/75MiXG1oI7KgYKVEfEo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=R6sNQalGEXNuR0RfVdbEnGPpjuLXUsF14WmNa46sECGatKzxDjz0XGD/I+Kzld567EkJsTn6o6b21fSHV2Szx4mEK5eNjnmqNKM9KCq11IJ6N2vSzC+H3F07GhCffMvnEtO0UbaXXcPtR/r6IdYofaCAPHXj0HVH67ChoMyu/X8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BVmpwxtL; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-477775d3728so20060915e9.2
        for <linux-pci@vger.kernel.org>; Fri, 14 Nov 2025 05:10:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1763125813; x=1763730613; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:user-agent
         :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EJ9S8y/liwc1XSXK0RvzbAJey2hh3NqcyHJfhnjyxSE=;
        b=BVmpwxtLKXCjxD2blA41IYyEGW/Lo1HlP1SzzWm7IZxYhij6jVL3y+oLlUU9QD9qJk
         O/5Xwx7mAYIhQZmAwgdFpAOIGEXgPk/Tk8F+Shl9pfP2m6pzRDvyB9xVI3xVYwWuvlVl
         TXQ8kmFXHFBGTM13Wmd2HNyc39+kQHsyP889sB76PJUZaOW5bysFB9ahHZVVWhSdL4f9
         sX4D7fHbEiw84Vul6BbyX7WvwR7nPxTXyaWi3tsaYtqnmSQestL7eBh+QmCnIyNGXulo
         HY8gL3jYAfft+yl1ziH+I5ThTAIg2XXakyVvzk1S2mnxbQC8H7wIPmTvHiyJQXRp0Ov+
         sYpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763125813; x=1763730613;
        h=content-transfer-encoding:mime-version:message-id:date:user-agent
         :references:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EJ9S8y/liwc1XSXK0RvzbAJey2hh3NqcyHJfhnjyxSE=;
        b=VzOSlBE68Zr9h0kLcXRQvtEzR0BSIXSSYtQDrStjC5//ZhW+bwKLlZAvQZl1ARHNcd
         N6EPZII5MREwD9M3fLMMFp5rBBE0x4DaOJD04EqzBDevPs+gSk3PinOKWBLgDjLRAJHw
         AawJFqPQIrazPJ3xmUz+BzGl/oIryjTCPPszoe0KAd5Q5e18fzfbqqni3kziY373cDq9
         k7eVnCdsQKGWwur3I6RYn8QI/0mygjtzr817nTEy4gInPrXWbB1pE+D3VFoXzgEhWFdV
         MMKc1e7qWYxS1Wm90f5dR+97V8MSQtWgJvUflrjGd168DpEmPGDDl0pysfhMpcYI5Yfn
         oyQg==
X-Forwarded-Encrypted: i=1; AJvYcCVOsS30Tz0nCIvyGhxd5i/hBC49WBV5E1BAYn06vXRrR9a3lgLNFzysQMdse6vPoJUB7AzCSdhUwLU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfPSNf1JRKYBdKLMvMzmwro7EfPK1BcaL3NGaH0s+YyGs1YUqA
	XdlrhPZwM4h4KIwT9i7uYJcm9aZtyIJBkDpMzHzpC//xss4hPE48CN9/gFZVo+MKMNE=
X-Gm-Gg: ASbGncsGKQzTFhZF6wCtisVOKZVuX3nX4pFvS4dUMBC3AXfvktFAViP+NfQcri1oPDf
	ArC2i3Ig+L4nvS+oSn0mOsXvCEDErIy9Jd87paIMnSTDNouQsWZbzw5u9/YGum/gTh1yfK8eD+a
	5FVqiIVRxAW8Mr+kzE8rS+Lb6c9mIpWWOt1nC7CHSLaTo/H+eQDhNOcaq7TRlo1qZyKDUWJKYpr
	u2alpCJNDV4vljepv7IBrIrm29vTuTBiiCkyb7rzr64EHDfW620gPv2UnZt1eMscfNt38/lfAW+
	SDefYG5pXKkHVPq97xeOECVzorJeLYB/iqC5uj+YaKgsEw78B5n+nfTZD3Z8R3Vu9enrk0rdn3q
	gRhbvdlqybeKCZSFFG3Vp1lvQDXqciFdzb/o1GwrZd1A7tbVfsbuKCt87XfQD4asEdFT5mqGj7d
	jx
X-Google-Smtp-Source: AGHT+IFRUwKdmMnVHD85N3NvYRNZUnPZKMrSMMhF+DQcXz4gku9fHv+s1niWianlCFXxAAY6/RwthA==
X-Received: by 2002:a05:600c:3587:b0:477:63b5:7148 with SMTP id 5b1f17b1804b1-4778fe55174mr31972855e9.6.1763125812943;
        Fri, 14 Nov 2025 05:10:12 -0800 (PST)
Received: from draig.lan ([185.126.160.19])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4779527a656sm5951845e9.10.2025.11.14.05.10.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Nov 2025 05:10:11 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
	by draig.lan (Postfix) with ESMTP id 1B92A5F820;
	Fri, 14 Nov 2025 13:10:11 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Ilpo =?utf-8?Q?J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Simon Richter <Simon.Richter@hogyros.de>,  Lucas De Marchi
 <lucas.demarchi@intel.com>,  Alex Deucher <alexander.deucher@amd.com>,
  amd-gfx@lists.freedesktop.org,  Bjorn Helgaas <bhelgaas@google.com>,
  David Airlie <airlied@gmail.com>,  dri-devel@lists.freedesktop.org,
  intel-gfx@lists.freedesktop.org,  intel-xe@lists.freedesktop.org,  Jani
 Nikula <jani.nikula@linux.intel.com>,  Joonas Lahtinen
 <joonas.lahtinen@linux.intel.com>,  linux-pci@vger.kernel.org,  Rodrigo
 Vivi <rodrigo.vivi@intel.com>,  Simona Vetter <simona@ffwll.ch>,  Tvrtko
 Ursulin <tursulin@ursulin.net>,  Christian =?utf-8?Q?K=C3=B6nig?=
 <christian.koenig@amd.com>,  Thomas =?utf-8?Q?Hellstr=C3=B6m?=
 <thomas.hellstrom@linux.intel.com>,  =?utf-8?Q?Micha=C5=82?= Winiarski
 <michal.winiarski@intel.com>,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 08/11] drm/xe: Remove driver side BAR release before
 resize
In-Reply-To: <20251113162628.5946-9-ilpo.jarvinen@linux.intel.com> ("Ilpo
	=?utf-8?Q?J=C3=A4rvinen=22's?= message of "Thu, 13 Nov 2025 18:26:25
 +0200")
References: <20251113162628.5946-1-ilpo.jarvinen@linux.intel.com>
	<20251113162628.5946-9-ilpo.jarvinen@linux.intel.com>
User-Agent: mu4e 1.12.14-dev2; emacs 30.1
Date: Fri, 14 Nov 2025 13:10:11 +0000
Message-ID: <87ecq0pxos.fsf@draig.linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com> writes:

> PCI core handles releasing device's resources and their rollback in
> case of failure of a BAR resizing operation. Releasing resource prior
> to calling pci_resize_resource() prevents PCI core from restoring the
> BARs as they were.
>
> Remove driver-side release of BARs from the xe driver.
>
> Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> Cc: Lucas De Marchi <lucas.demarchi@intel.com>
> ---
>  drivers/gpu/drm/xe/xe_vram.c | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/xe/xe_vram.c b/drivers/gpu/drm/xe/xe_vram.c
> index 00dd027057df..5aacab9358a4 100644
> --- a/drivers/gpu/drm/xe/xe_vram.c
> +++ b/drivers/gpu/drm/xe/xe_vram.c
> @@ -33,9 +33,6 @@ _resize_bar(struct xe_device *xe, int resno, resource_s=
ize_t size)
>  	int bar_size =3D pci_rebar_bytes_to_size(size);
>  	int ret;
>=20=20
> -	if (pci_resource_len(pdev, resno))
> -		pci_release_resource(pdev, resno);
> -
>  	ret =3D pci_resize_resource(pdev, resno, bar_size, 0);
>  	if (ret) {
>  		drm_info(&xe->drm, "Failed to resize BAR%d to %dM (%pe). Consider enab=
ling 'Resizable BAR' support in your BIOS\n",

This didn't apply, I assume due to a clash with:

  d30203739be79 (drm/xe: Move rebar to be done earlier)

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

