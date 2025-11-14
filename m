Return-Path: <linux-pci+bounces-41235-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A6908C5D016
	for <lists+linux-pci@lfdr.de>; Fri, 14 Nov 2025 13:06:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 648ED3AF002
	for <lists+linux-pci@lfdr.de>; Fri, 14 Nov 2025 12:06:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F56A2417F2;
	Fri, 14 Nov 2025 12:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zMWlYnp1"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 744DB258EF6
	for <linux-pci@vger.kernel.org>; Fri, 14 Nov 2025 12:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763121966; cv=none; b=mZQ/Wv9EC/cCD4vv4eofPAeZabhByYU/oOw0ExTnTHFcBmSh9cwCbn0AJAtl0xVH/NnbM/zbX/mc6/mCVQSOyVGC2cO7FOwkKt2g9hEYLVf24qvfMQmrJvznffKKn8WQWie17Yp6NezpN2aaOpDbVkNC8uFc9MXoNs7mt7Ne2Ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763121966; c=relaxed/simple;
	bh=K95f3YlNhCQTt8GtlNX0mi3FKRnBks4BFfnVQ8YE34o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=inQzMgkUDKi5SQMg90LW4n1PkjKUP9PW702pvYqoArlfdpo8Pna6LH8Zx53XwGhq87NEFezITYNJWr+poDmozb0F9qgm6tuzRcVgKA7jSNyA0KVLeq0wM+ThBkltMmBf+/5z676Ysh9NLlP7DdaWpSuNjnX1nrlTZEFaTgD0mCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zMWlYnp1; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-42b3d7c1321so1420264f8f.3
        for <linux-pci@vger.kernel.org>; Fri, 14 Nov 2025 04:06:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1763121962; x=1763726762; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:user-agent
         :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K95f3YlNhCQTt8GtlNX0mi3FKRnBks4BFfnVQ8YE34o=;
        b=zMWlYnp1VevZvnn3IvvG8ItBs9pOPwP2RYxieG5WIKB0MEBXj/yHV9/NEKQz0l89fo
         Y4hf/fs9ZXRg0VetXPH5dGAkOQ5hkcOjpavgK/62NwmgBscjyS4Ju/VnkmPeHOtC/Zf2
         CXgVGssgzzWCeNBWB6C4g+iFD9kPG/kX0lvbtq824vALlroOq+Ma0BPWTonp63WSktMQ
         sbtb8magQIlKvHkMD69s7RNR7ELeMek+VFEF23wN8n26Ie4W8S9XgoG5y88cCrXqdsdD
         2Bm/EDTC8tDdvnxn+5iFgv+bSU7xg0eEAvppkTSTTXonU5da0RUflv3t767xf4hUgeSc
         G3mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763121962; x=1763726762;
        h=content-transfer-encoding:mime-version:message-id:date:user-agent
         :references:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K95f3YlNhCQTt8GtlNX0mi3FKRnBks4BFfnVQ8YE34o=;
        b=t3MofRUO7VcyihcoUvk73PCs0BL3Rh9YBNhFoiUrTYUXGLJSx2wdo+mRwt5/1zvP8+
         RT3PH/D0VbvxB66wNHo0q3498h+uVWeSBI6Vq+0xp9bkPnzv20YnWMQZRaEs5+J1F+s+
         uYm4BD47hByVQRxlQ3qO8OO0Su8ipQlmdtirzaNb9y5hzW4BEdIHaFxvvYgx9X90PcUA
         YFBpseX5RSg2MgYa/kcWybD7KSVde3V+KJO8/L8epiTcK7C+FEhMnsTlBfkFvg3rNq90
         5kiMDMJKEWNStYLwf24OiZPaKrSoGtPupgKTvovDvhuWp7FHiiCWFPaznoBZabNyWpMT
         nt/g==
X-Forwarded-Encrypted: i=1; AJvYcCXERhYlPeqI8giZDJPNwf+eyVcuo8Dr035ETEcHm++NQ1p3UBcTTzmTX8Nu7pcc/6bwe0MjUo+kR2M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrUt1o8XxjdNoegWtwRlFBQ9Cg6NSZexzNwZKGPW473M1SGrPe
	NB1CAUZZo1OGhLQX+1cT3/2RmpK3PiXQpyiOXTudCUNwaoceQlRbs8ul7DA+n/83uDA=
X-Gm-Gg: ASbGnctD+xEo/x/xHJtAdY59Mo5b7nJ8ZDRV62rZeMk3+JPyZ5IbVRgo3YiWYcZm5AF
	61zggEXs2r7Naa1p6/9qNWWLDK7o1Wd+jVVxdkAErtvDjPm+eExKJka8QflkFhEFN1yVxivSnuK
	OokvL1KrsGD7K6vtMb1uhe8bcr68EukwNuvlhF6uszzdMBrP8XQCxsIVTKABmQ0piw9wIkWcErE
	NELDHmXulLZL8ICHE22NVAVaIxkn/x3ow2kHDzOjCnPe4oGvEDcMTQYW/T6J0jcmaVheCWOhmAh
	buysi+TbiOg/h4wr5yftHfYtr8ChjONoRW57M4Vjsv4dFRnHzDXjPBnipXsdfU5ENDvzvontEU6
	35roALseeOzFgTgkIprRHJIW5AkfTzAZf+WGAEZENVvDybEtDJ2vvDBkhtZYRUEmot83pF2JNGe
	Cz
X-Google-Smtp-Source: AGHT+IHE8wmfBLRimraz6qGrkqAB1kcfDLmC9Ei9799tyFpwTbyC2bx5mJA0Z5MS/+tIuTgQ7sZknA==
X-Received: by 2002:a05:6000:25c8:b0:429:c851:69bc with SMTP id ffacd0b85a97d-42b59342f3fmr1891458f8f.8.1763121961723;
        Fri, 14 Nov 2025 04:06:01 -0800 (PST)
Received: from draig.lan ([185.126.160.19])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53f206e2sm9569035f8f.41.2025.11.14.04.06.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Nov 2025 04:06:00 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
	by draig.lan (Postfix) with ESMTP id 1D11A5F820;
	Fri, 14 Nov 2025 12:06:00 +0000 (GMT)
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
 <michal.winiarski@intel.com>
Subject: Re: [PATCH v2 00/11] PCI: BAR resizing fix/rework
In-Reply-To: <20251113162628.5946-1-ilpo.jarvinen@linux.intel.com> ("Ilpo
	=?utf-8?Q?J=C3=A4rvinen=22's?= message of "Thu, 13 Nov 2025 18:26:17
 +0200")
References: <20251113162628.5946-1-ilpo.jarvinen@linux.intel.com>
User-Agent: mu4e 1.12.14-dev2; emacs 30.1
Date: Fri, 14 Nov 2025 12:06:00 +0000
Message-ID: <87jyzsq0nr.fsf@draig.linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com> writes:

> Hi all,
>
> Thanks to issue reports from Simon Richter and Alex Benn=C3=A9e, I
> discovered BAR resize rollback can corrupt the resource tree. As fixing
> corruption requires avoiding overlapping resource assignments, the
> correct fix can unfortunately results in worse user experience, what
> appeared to be "working" previously might no longer do so. Thus, I had
> to do a larger rework to pci_resize_resource() in order to properly
> restore resource states as it was prior to BAR resize.
<snip>
>
> base-commit: 3a8660878839faadb4f1a6dd72c3179c1df56787

Ahh I have applied to 6.18-rc5 with minor conflicts and can verify that
on my AVA the AMD GPU shows up again and I can run inference jobs
against it. So for that case:

Tested-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

