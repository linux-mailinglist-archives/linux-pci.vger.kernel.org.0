Return-Path: <linux-pci+bounces-8625-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55254904A4B
	for <lists+linux-pci@lfdr.de>; Wed, 12 Jun 2024 06:52:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 65A3BB21BB2
	for <lists+linux-pci@lfdr.de>; Wed, 12 Jun 2024 04:52:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A95C5282F1;
	Wed, 12 Jun 2024 04:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V7IRrFqw"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B61225605;
	Wed, 12 Jun 2024 04:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718167929; cv=none; b=BpQ3eU1ukxvK/D46qOGkVLfjKFpMIQYtqHk8Qa7hA/f6XnUK4HlhZMsEftFB5D5D2l5poIZRQX+Pgp+tvOOp0pY9NOL4n65eFzBsEbHumfRzJsZCRjZNGysphVwaElNKgHxjGetmsoYGS8V1tAHKoixLY1OuNMO0Mqigv4Ymjas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718167929; c=relaxed/simple;
	bh=nruark1B8eb2OhgQvZff82JhFN78K2Md0UA5EQhbk50=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bjBoLY0NUyfMrDVKwX7c2DXtw14htIl6vVw/2ob0/RhFfgS9S/zfWxcJgmoJnJtNKAZQpaM+nY/vzJ4kBpvHfSPHZnS+2+uoqxnLh9Dbxum6nDzyv/Ik6X0wtSEv8XpoCYrKqH0AgQkqHukJCmAxdCz9bYoRXizKnKl0mrX8sfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V7IRrFqw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DE53C4AF49;
	Wed, 12 Jun 2024 04:52:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718167929;
	bh=nruark1B8eb2OhgQvZff82JhFN78K2Md0UA5EQhbk50=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=V7IRrFqw0vhujpKJDtVvKy/JReetTM2vUKY8lFwSBdLERP26LrljRT7sIUxnryLMS
	 PtF5NJONsUCKOD1fAsIa07+ST83Cw1LR99MSbvtuFbPK4lBbG3JY4YqfUXxfX98CON
	 imTXIpJEjCIu8HJXvIk7XWPm7J3oM3t9UA4aGwk132kot/ZP9XqCjmnK1nfWO7UTAI
	 zBMozZl8qxcKbh6Sa118tdpYL4owEzcMy0wHunJIlycHt4It1q7l7VuGBSOgaNfjTa
	 Q3jDUa4tAwbTZMI1R0cmwU0lLBqotdjxi+J8j+Qf2baFEJvhnNQi5gpLvgZhRD6Zsa
	 2fJj7kXXsTfbQ==
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a68b41ef3f6so722332666b.1;
        Tue, 11 Jun 2024 21:52:08 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXaziy4HKAD78jNBt5FPSj8E2U9WYmY/PhupRdInU1r3Yno38JAR5m4R1uJUkQEbB24LZEnNvdNEcuLkmM/hXy51WIcIHyeNueJwhHym7FAMgwdMvqyG4AwQGYEZ4P2AWxMD50E9tzPnyE2/oH0fVgtj1QgsX6OyP+SA2DQUjQF
X-Gm-Message-State: AOJu0YyxBV1Jl0QJHUBbnIr0hcknfzJmApkMp/E1AeAS1QkxBqstdIpR
	l6i+8dsnbljTdUrzBcERTUvCLX73nhjHQNMDNwNdeQVVXyDBZYbNPz5iACcPdVB7rrvZ5X+OXDo
	FREg3bvuGnFHgbdg33mDVXvMgCFw=
X-Google-Smtp-Source: AGHT+IHFivSjvIbnYSVPMTEzbltjhXBgE/Sw7akDiWaje007gDxL4ef1RyuKjpql8Ck29Kk5g0Vq1mt95AktB7YQxqw=
X-Received: by 2002:a17:906:489:b0:a6e:7e1f:2eae with SMTP id
 a640c23a62f3a-a6f4800b167mr32026166b.74.1718167927547; Tue, 11 Jun 2024
 21:52:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240605075419.3973256-1-zhanghongchen@loongson.cn>
In-Reply-To: <20240605075419.3973256-1-zhanghongchen@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Wed, 12 Jun 2024 12:51:56 +0800
X-Gmail-Original-Message-ID: <CAAhV-H5+47ZMFQGiirSxgF9NoJjng4dL2huPXdiw1ydbbAk0ug@mail.gmail.com>
Message-ID: <CAAhV-H5+47ZMFQGiirSxgF9NoJjng4dL2huPXdiw1ydbbAk0ug@mail.gmail.com>
Subject: Re: [PATCH v2] PCI: use local_pci_probe when best selected cpu is offline
To: Hongchen Zhang <zhanghongchen@loongson.cn>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, loongarch@lists.linux.dev, 
	stable@vger.kernel.org, Huacai Chen <chenhuacai@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Hongchen,

It seems you forgot to update the title which I have pointed out. :)

And Bjorn,

Could you please take some time to review this patch? Thank you.

Huacai

On Wed, Jun 5, 2024 at 3:54=E2=80=AFPM Hongchen Zhang <zhanghongchen@loongs=
on.cn> wrote:
>
> When the best selected CPU is offline, work_on_cpu() will stuck forever.
> This can be happen if a node is online while all its CPUs are offline
> (we can use "maxcpus=3D1" without "nr_cpus=3D1" to reproduce it), Therefo=
re,
> in this case, we should call local_pci_probe() instead of work_on_cpu().
>
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> Signed-off-by: Hongchen Zhang <zhanghongchen@loongson.cn>
> ---
> v1 -> v2 Added the method to reproduce this issue
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

