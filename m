Return-Path: <linux-pci+bounces-43698-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3138ACDCA71
	for <lists+linux-pci@lfdr.de>; Wed, 24 Dec 2025 16:16:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DEC073065E5F
	for <lists+linux-pci@lfdr.de>; Wed, 24 Dec 2025 15:15:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7326F34B68F;
	Wed, 24 Dec 2025 15:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="V1fy0kKd"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5648B349AFF
	for <linux-pci@vger.kernel.org>; Wed, 24 Dec 2025 15:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766589311; cv=none; b=VUME6tlCDhSMFUntvzhMUBcYDJGnvtORBjti2hRe4naO07gJF2qWoiy449tQd3dnKEqh3etTGrbpY7aW6gLGF0NtQjIuQoY5KsTf/1S1QyekFuHWlJQnCtAn6OMRx+J8lDcQTJUm1+D64ZTrMth/jR4P5lTaFSUr5rKDYGxLpSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766589311; c=relaxed/simple;
	bh=PLbXfJOBSydZYACTYejV8mQBqwfOFdpRlG8pXY3VutY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TFdGtqOBvXqoA9xfBo5JqBQb1MHkE4+49szmQQgsN0ZURhCS+bvS7px40JTUjC2oWZKGcCEetJUCWcbztDN5PBSiFV8QDA7YxG7CAzj1HncaSTBgSeMSSeaURHX4a6n8W1LsA9ge3SgR15JQDZb9vYpi+ingOz4MXyyvdIGdtUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=V1fy0kKd; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5945510fd7aso4839606e87.0
        for <linux-pci@vger.kernel.org>; Wed, 24 Dec 2025 07:15:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1766589307; x=1767194107; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CycBEaw+g/cgJWbkk2PhM07iK10d4RJ2J4V6y6kRz3A=;
        b=V1fy0kKdhaqlkqgegYMxw0AMFQ7gf6mGNmTSnD344SqWENHyLqXtc8G9MkH5uYXF/G
         roR2seQstUZxOvnJSTN3HxxiAG/bOjlbgZfQa5dseU+aTm2rpYZUoOsCtgG+WqtenbGF
         0QJIPHXEPpuOqcDd0xw4kl+SpEqpzbV/t41sS4Y6+1/aCaKpk/3O3dUqTqQochKmiIpT
         nzGEHUBK0cBJm+zD0D15BM74tDLm23lTclJERRZfblDieRyiUAoFelZz6ptUy05fLqVI
         0DZUIZ/bctKGDNqjG8Rc6SDxxEZlLLz+qMCbSEahLjfenidJK52deYjeF4O1iEt15INf
         nZOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766589307; x=1767194107;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CycBEaw+g/cgJWbkk2PhM07iK10d4RJ2J4V6y6kRz3A=;
        b=vjg2rUFWXzGxvRc4uL18qQQOzy55tz2Fq4MlzjaHu3mMtD+I1hOvhJMch+cEoBG+Jg
         8O9iPnDxxbPFU0ZhM3C26n3fHf5ehvMxDhILuU7o7fcqR45PYW8tZ8OH0pKT5QvcWHa0
         X/qm76IZ7FhE/dglXQRmlJuploiTiTe6oLiAUc1TXP3MwidgsPrWwPG0WwYyBk39cJhO
         wkTwKI01AJ509xmWEecvnJmO3YdgxEaM+s5KBO6w57/i63DWz242Py7luxa5gbICEDD5
         L38qe7OwfurnQZuC0PMduc5Kckz6VYh+Wy339mHnIE95AUtW5tkGu3J9HM+Ky4eePpLH
         rvWQ==
X-Forwarded-Encrypted: i=1; AJvYcCWvZv/5Z51SVo4zVh7po4xpuhpfczzSognvKitUp02PxcVB2Z9x+7VyxgHXr0yIBSSTK3UzxwIKiuA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyN0SiQX24ApCOP7BI4Ej3j64mRQpcDSvoYVp100n826rzkhv9V
	8xX2u0H1vVG9dHoOFnqV/YWcuFIj8184RXx2+Hv50na7t0Uog6Y2Pk+jSMgHzHp76dcIA8j1wTP
	aI9wBCn6FE0lLUgU45jCl3jFBcZM/Z8qeyKLmhfjZ/Q==
X-Gm-Gg: AY/fxX56qhxjrtzs/aGFJwc9v1JmMLvEbh/1K8Zy7dRnf8nGqikQK5w14ZDUdLeNrRB
	AFH/Qo75P724bFnJn83Qsxlh86E5Sg8RBfsznMHRUs8JY9YPFNJYCBTXrH3Nn8EThdAUdZDFMlC
	ZFng7H99Z6ioJ1BhdrhYgaVZTOQq8JrnbULjRW5AzOKcrGPvx+FA4uCOcH7VKOhBv6hkMH6W49S
	98duXd5vewWVjh2MZc4ayFtVEhkOBGjcmmdAKFxZrOxZ5nTZ1CClgo0FBa5H5fkfMgLCFKt3Bph
	C7hnsoy4oGO0ZND1dTAEu8xAM0+TaCgw3571cZ3QQX+ELUbIbA==
X-Google-Smtp-Source: AGHT+IG5doQ1AoM607tW6NsnGv1eeFmuWxpyUXAogngdumreggtFnGADJc34A7ALOET4J+lArW6e7KSNKfEXkw5zH0k=
X-Received: by 2002:a05:6512:2304:b0:594:cb92:b377 with SMTP id
 2adb3069b0e04-59a17dea461mr6709412e87.42.1766589307288; Wed, 24 Dec 2025
 07:15:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251107143335.242342-1-marco.crivellari@suse.com>
In-Reply-To: <20251107143335.242342-1-marco.crivellari@suse.com>
From: Marco Crivellari <marco.crivellari@suse.com>
Date: Wed, 24 Dec 2025 16:14:56 +0100
X-Gm-Features: AQt7F2oLWWcUyBViQcoQGcfXMQVcKlSndHpfyMlDE84FGBNAbRZ8IuvKSmFMtPw
Message-ID: <CAAofZF4M_iAbYssdkfoZb8XGXQVxOzQqGPrW-nTaknUWdCiz=Q@mail.gmail.com>
Subject: Re: [PATCH] PCI: pnv_php: add WQ_PERCPU to alloc_workqueue users
To: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org
Cc: Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Frederic Weisbecker <frederic@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Michal Hocko <mhocko@suse.com>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, Bjorn Helgaas <bhelgaas@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 7, 2025 at 3:33=E2=80=AFPM Marco Crivellari
<marco.crivellari@suse.com> wrote:
> [...]
> ---
>  drivers/pci/hotplug/pnv_php.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/pci/hotplug/pnv_php.c b/drivers/pci/hotplug/pnv_php.=
c
> index c5345bff9a55..35f1758126c6 100644
> --- a/drivers/pci/hotplug/pnv_php.c
> +++ b/drivers/pci/hotplug/pnv_php.c
> @@ -802,7 +802,7 @@ static struct pnv_php_slot *pnv_php_alloc_slot(struct=
 device_node *dn)
>         }
>
>         /* Allocate workqueue for this slot's interrupt handling */
> -       php_slot->wq =3D alloc_workqueue("pciehp-%s", 0, 0, php_slot->nam=
e);
> +       php_slot->wq =3D alloc_workqueue("pciehp-%s", WQ_PERCPU, 0, php_s=
lot->name);
>         if (!php_slot->wq) {
>                 SLOT_WARN(php_slot, "Cannot alloc workqueue\n");
>                 kfree(php_slot->name);

Gentle ping.

Thanks!

--=20

Marco Crivellari

L3 Support Engineer

