Return-Path: <linux-pci+bounces-8241-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A6518FB653
	for <lists+linux-pci@lfdr.de>; Tue,  4 Jun 2024 16:57:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E673D281D95
	for <lists+linux-pci@lfdr.de>; Tue,  4 Jun 2024 14:57:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E3D213957E;
	Tue,  4 Jun 2024 14:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GPyubfwH"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E084846D;
	Tue,  4 Jun 2024 14:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717513039; cv=none; b=NO9tn6LEWN0BI1zs2JhMAAiqs1Q/9IBM/fKMKQlaW/gLPL9ywAK1jpN4d6EbQnU2xm8HKTMYqfZ0tQpap9ICx//UhveMrL4gjXpoQTMpE5JxsBYFqrrZr+8oIQAluzHa3CYkrv5e/KvUy35dpObqHQR1QFbtC2YxNyhcOTZNpog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717513039; c=relaxed/simple;
	bh=Prc229CixKADL7r01Yfc9cHrwltTAJ/Gc5KJY4hP6nk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O0r31dNIX7ktrbL0wfi6ME07yleq6rAhGgijAOtnoqtEzHRCHZoCOfHcsrTc1R+AZSCwmuPcQ/KyEx6GAvNGlHDUQrBnOdQEzeK2sgOxeWdd9yJOPE/Wj3p9W1733er9R1N8qmJPpGJMjthS9ydRYkiMQH3mDVJ2rEu02ErSfyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GPyubfwH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3966C4AF09;
	Tue,  4 Jun 2024 14:57:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717513038;
	bh=Prc229CixKADL7r01Yfc9cHrwltTAJ/Gc5KJY4hP6nk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=GPyubfwHpOshcn9woxjTA8pVIYNzr4+MA9DsWohWeqJwxCj6CdeLb8/NCsc4+rU/z
	 pdN20XEWaCc8xT9sRgp/A0HLFVtZST/lrxsu/ZHPcssg1M2zT6a+Pxs7IFCecs60wJ
	 XyFojn91BfU0KOSqCwI2uzWiHmnjiejW67EjOdJ8zGx0c5jE7VqCECK4gMoxhBx36b
	 m3RYsdDF+JxeQBg6DADVw1/Gf9b0J2nmBKb9csG54LwMScMk7QbOUjSSl4w0tGCguG
	 LPGt3wzYVoXOodTE70wH01vU+0U8JtmqrYNOU7PFtTbin7DCFKrokcXcUmAdIHl45G
	 HypO0WzI0yjWQ==
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-57a4ea8058bso3784605a12.1;
        Tue, 04 Jun 2024 07:57:18 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXIdHy0xkuEy5xv9pYhav5pcWiT6D9PvyjsRnqNq4QLX9ulDBVqP5OWhkPxcyxo7qRLq3CDfJ5KhQjozffte9ay8jP7O8CImNHI5SbcvGhG+kPujwlMzIbW8gEe3Tx2buMuw7U9ULUa5pVpROJIM92yQZIyeaYWgh+4v43KqkDU
X-Gm-Message-State: AOJu0YyzyhtHeMJDDD2Y7SrvCZrI2XTxp2nXzC1YPYiQ2b8LSDF2vyrQ
	X26PKXq1BeE9drQkIG4/vjChSLndeshCBSBYLEiCMqHdCQmqXaJNBgIpBSjLE/S3wR6hD1KmudX
	ltYbYJReea1tTSxS8OU5FSXB2ofo=
X-Google-Smtp-Source: AGHT+IFI8QP1aHzAaEgzn6Yxg5h6Mz9ZFEuDthtMFRKRH3AuaG3MxPpYeNODMvyHqxzRyF9UIP4Zso0m/Gr29N8anZY=
X-Received: by 2002:a17:906:37d2:b0:a68:c14d:2686 with SMTP id
 a640c23a62f3a-a68c14d26ccmr576013066b.25.1717513037225; Tue, 04 Jun 2024
 07:57:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240529111947.1549556-1-zhanghongchen@loongson.cn>
In-Reply-To: <20240529111947.1549556-1-zhanghongchen@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Tue, 4 Jun 2024 22:57:06 +0800
X-Gmail-Original-Message-ID: <CAAhV-H5KD8BPzZYjpj5s4iSjOfJr+Q9hCV1nQn6fsUXPU8sriA@mail.gmail.com>
Message-ID: <CAAhV-H5KD8BPzZYjpj5s4iSjOfJr+Q9hCV1nQn6fsUXPU8sriA@mail.gmail.com>
Subject: Re: [PATCH] PCI: use local_pci_probe when best selected cpu is offline
To: Hongchen Zhang <zhanghongchen@loongson.cn>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Huacai Chen <chenhuacai@loongson.cn>, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	loongarch@lists.linux.dev, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Hongchen,

On Wed, May 29, 2024 at 7:19=E2=80=AFPM Hongchen Zhang
<zhanghongchen@loongson.cn> wrote:
The title should be better like this:
PCI: Use local_pci_probe() when best selected CPU is offline

>
> When the best selected cpu is offline, work_on_cpu will stuck
> forever. Therefore, in this case, we should call
> local_pci_probe instead of work_on_cpu.

It is better to reword like this:

When the best selected CPU is offline, work_on_cpu() will stuck forever.
This can be happen if a node is online while all its CPUs are offline
(we can use "maxcpus=3D1" without "nr_cpus=3D1" to reproduce it), Therefore=
,
in this case, we should call local_pci_probe() instead of work_on_cpu().

Huacai

>
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> Signed-off-by: Hongchen Zhang <zhanghongchen@loongson.cn>
> ---
>  drivers/pci/pci-driver.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> index af2996d0d17f..32a99828e6a3 100644
> --- a/drivers/pci/pci-driver.c
> +++ b/drivers/pci/pci-driver.c
> @@ -386,7 +386,7 @@ static int pci_call_probe(struct pci_driver *drv, str=
uct pci_dev *dev,
>                 free_cpumask_var(wq_domain_mask);
>         }
>
> -       if (cpu < nr_cpu_ids)
> +       if ((cpu < nr_cpu_ids) && cpu_online(cpu))
>                 error =3D work_on_cpu(cpu, local_pci_probe, &ddi);
>         else
>                 error =3D local_pci_probe(&ddi);
> --
> 2.33.0
>
>

