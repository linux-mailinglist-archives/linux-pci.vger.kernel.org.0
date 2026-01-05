Return-Path: <linux-pci+bounces-44050-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 80CD4CF522C
	for <lists+linux-pci@lfdr.de>; Mon, 05 Jan 2026 19:01:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 000B2300A90F
	for <lists+linux-pci@lfdr.de>; Mon,  5 Jan 2026 18:01:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B8C132C943;
	Mon,  5 Jan 2026 17:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UN5dRM3z"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98E0830BB86
	for <linux-pci@vger.kernel.org>; Mon,  5 Jan 2026 17:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767635704; cv=none; b=jucuKIRdMgtfa5zJXli2lHJywOS7jtIOjbAXE4U6IcR0WFshxZigfPLEvr8sSZo3JlnRBhXIeDSgvfrzv1gbcjHvQxb8Sz6EpBLViLunD1enHJI15P+iN1M63n2NmbmcWDqTTdiSSyngvusaeQTWealPEhtZTAc4818qa8ZedTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767635704; c=relaxed/simple;
	bh=3exiw0thvbCtX+WLOhnht9nO6z7rXw54qNFKoQqhAuQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o8DzPtAu8z20HYU0PgM8YB3dvdGLU47/4fzVfr8PlYSQ6F0IUGjti+5doZHIxRtj1ZZyjjWJEfzJhWGWevLsx28n8sJC8ztqqJKsjBE/Sic8DwIx+v1FxoF87W1/CJYKy+k47vnpAf1j+b8Nt4GiSCOSJr+EPhUmYHWg+ig/7Ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UN5dRM3z; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-37d275cb96cso1667151fa.2
        for <linux-pci@vger.kernel.org>; Mon, 05 Jan 2026 09:54:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767635694; x=1768240494; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lKzk+CxxnNt9ZNHbY1DTzzVJyV243CDMIdk2HW5f4qU=;
        b=UN5dRM3ztSXkZHfhID6ClvBESyiWxxz4sPV1ufIJGKf/E3BFKB5tA+z6nHJ46yRawk
         EMSdDrmgh445S/1GVaZNcxlEdxDsmNacFx99q6Bez8Xa03+sO3oGaJw2FAbZCZF+IoSS
         BQ4QELKiCSyJxeePrT13U72odBGZNhEvweBMS+HOePiiZE/DTea1Fje8ZrXNqYvfi67z
         b3JojZFMraQQu3N4ppNwi8J/ZCIcHvbW9WdMjvC99HiyPNswN1Z/ZiX9NtFodhartE7Z
         c7hiyaxMYrJH8E58ecEYqs6EN7h3CNmUm9b/cSQFlderY5RMovkpXsndF9baBIlg5OFl
         30ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767635694; x=1768240494;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lKzk+CxxnNt9ZNHbY1DTzzVJyV243CDMIdk2HW5f4qU=;
        b=dUlb3KVv7E5POdR4kKO89FhMXYoZc+rmBi7IT2Omg2LKYWAh42U4urhf9MxRi7gCgt
         m9/YqMNg41juE2RPAzgjV5xJm5eOaGHvKInEFCQtS2VpWlBTf5EhuFNMNIFp5B9oi8dA
         0Izoao9fLYsAokxbHr4SOoSO6woCMoHdWydWJNLwa88aP2ZOjB/XjBJbuRUHH63O5bv6
         ny3V8XlG9o0c91e8//KF4WObwixJtKP8PjBbsk4DRlxGn9MYNksbmq5RhBsQSa5DhjCC
         4TMeqDBEaUS5kVB0eiJQD1iOBBL5YASjhmJLnJdVVj+kyLnU0i3tYGhx3VuAEr1N3AJG
         gvfg==
X-Forwarded-Encrypted: i=1; AJvYcCVXdgxIoPKxs1oHbmSFFhnVFxbIH02Gm8IItmZ38ldDEJ6nF/pCfV/z6tojb15CZv/hE1u4S61lsHk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEcFDlJkWgAcAKVVGqx6DvMi29gdytnMP+kOYFOG94t2zIc36s
	I/L3jkONaJmwS72iTvBBvYvOK3ZU4IcVTtchPq/9T/504JfLc9JZSZEJEJZ3Yy5e1HWh2cM+bZD
	6q9E3gib030Na82PwoyOM1qhILUlzvCURVVbnlE4s
X-Gm-Gg: AY/fxX4SVcuInO1CvvAR94h5n5XvEttEGf/8/aYhmstXn1xamzCZxKCVycXX1xX2WB0
	XhNoaW7jP0t0Cu2dxQQXwzDlcxxXCw9Cl7D+v+Uyi8V4FhAUlnaJzkMumjd+vVXKz1+8EDw9+LF
	IEkis3VzbkXLfpfeQ0KwzkYxYCzxjZxn2ezhB1NmCdliRcx7zHFwAdE9fXbiiHjjHOom33aN15T
	DVZb6DVcKqQVxSt4dMc99BYV7aGaV/tWukXGSL9mGEYhIXHZVv8QQtewpkUnVs3vdLdR8l0
X-Google-Smtp-Source: AGHT+IG1OlQp7L7xGRo0uQarvmhbCxjRiBs9CCPI1n79KwlTxoqllow+YbWs7GIzqxYb/LvpuhvZzbuvoSSvtdK3ah8=
X-Received: by 2002:a05:651c:511:b0:37f:aa88:83fb with SMTP id
 38308e7fff4ca-382eaac1869mr377291fa.32.1767635693427; Mon, 05 Jan 2026
 09:54:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251126193608.2678510-1-dmatlack@google.com> <20251126193608.2678510-20-dmatlack@google.com>
 <f0439348-dca7-4f1b-9d96-b5a596c9407d@linux.dev>
In-Reply-To: <f0439348-dca7-4f1b-9d96-b5a596c9407d@linux.dev>
From: David Matlack <dmatlack@google.com>
Date: Mon, 5 Jan 2026 09:54:24 -0800
X-Gm-Features: AQt7F2pamlADbdQVNO88tt3y4iAorzOwRP2E99cUQN8k3LcTYOLnYFBdkWya6hg
Message-ID: <CALzav=duUuUaFLmTnRR41ZiWZKxbRAcb9LGvA5S8g2b5_Liv4g@mail.gmail.com>
Subject: Re: [PATCH 19/21] vfio: selftests: Expose low-level helper routines
 for setting up struct vfio_pci_device
To: Zhu Yanjun <yanjun.zhu@linux.dev>
Cc: Alex Williamson <alex@shazbot.org>, Adithya Jayachandran <ajayachandra@nvidia.com>, 
	Alex Mastro <amastro@fb.com>, Alistair Popple <apopple@nvidia.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Chris Li <chrisl@kernel.org>, David Rientjes <rientjes@google.com>, 
	Jacob Pan <jacob.pan@linux.microsoft.com>, Jason Gunthorpe <jgg@nvidia.com>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Josh Hilke <jrhilke@google.com>, Kevin Tian <kevin.tian@intel.com>, 
	kvm@vger.kernel.org, Leon Romanovsky <leonro@nvidia.com>, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-pci@vger.kernel.org, 
	Lukas Wunner <lukas@wunner.de>, Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Philipp Stanner <pstanner@redhat.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, 
	Samiullah Khawaja <skhawaja@google.com>, Shuah Khan <shuah@kernel.org>, 
	Tomita Moeko <tomitamoeko@gmail.com>, Vipin Sharma <vipinsh@google.com>, William Tu <witu@nvidia.com>, 
	Yi Liu <yi.l.liu@intel.com>, Yunxiang Li <Yunxiang.Li@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 27, 2025 at 8:04=E2=80=AFPM Zhu Yanjun <yanjun.zhu@linux.dev> w=
rote:
> =E5=9C=A8 2025/11/26 11:36, David Matlack =E5=86=99=E9=81=93:
> > @@ -349,9 +351,20 @@ struct vfio_pci_device *__vfio_pci_device_init(con=
st char *bdf,
> >       device->bdf =3D bdf;
> >       device->iommu =3D iommu;
> >
> > +     return device;
> > +}
> > +
>
> In the latest kernel, this part changes too much.

Can you clarify what you mean by "changes too much"? What is the issue?

