Return-Path: <linux-pci+bounces-27523-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 068FDAB1CAF
	for <lists+linux-pci@lfdr.de>; Fri,  9 May 2025 20:51:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBB463BDCCA
	for <lists+linux-pci@lfdr.de>; Fri,  9 May 2025 18:50:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C96623ED5E;
	Fri,  9 May 2025 18:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m7l1iPae"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DE29212B28;
	Fri,  9 May 2025 18:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746816664; cv=none; b=MCO2hnYQy00V3VeoqnUXJLsqC4CxNBeTWJQSduclUZxmLrRBV7csqEHFELYcjm0mF5SJAF95TipJqTBieRCdvZj5EL/cTjWNr2PK8uCq4aIXZlf1fFL7g8NnvYYLweVfSZGeUKqdGNlvfyhbp6RAtUfY2lfMCJghG/qZ0aIZR8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746816664; c=relaxed/simple;
	bh=t3m6be5GBZKdrb2ZBxNNUDmrq2ECraazOtASPCG9dFc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UfqRuI7/OmOOTVOpXVQW50onpigDiPKmAZMMxMhkkyCSNaNEAdolTqQnikVNAbyKncHPgjX3g4inXpHSCP2hir3UIB66r2ud59kzGA/a7Lsi/ujOJiW4HE27hih/FysB0XuCQjCuRN+lbr7SiXMPqBgQSvhHg8AXFLpSEu/Z+MA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m7l1iPae; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BA4EC4CEF2;
	Fri,  9 May 2025 18:51:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746816663;
	bh=t3m6be5GBZKdrb2ZBxNNUDmrq2ECraazOtASPCG9dFc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=m7l1iPaebPB8QpdtDxlJvrG3KsATtIsUwTvEgjfVgiFb3gblXrLyISJH+qQrrNgCP
	 0uZ4ljcnpDAZvwGeYNKKXp9bru/8418ffz4WgAmkJilx+cf8Ygm4bWpkNkQzp5iTRj
	 TBTlPEwu0QxAd8epq3hJfqEYiecfrnsTeh5QCYMYWPprnnkNfrBQ2vkOQB7ljcwmzH
	 EdVlXisW9LiDKm8wRBD05zF3BcCONSQLvz+c3CSCssjXY8PGgPS9g8fe2mioZW9Uhz
	 KIh9VwNou+LnlevjzAvNBOF4nBx/WJXsXnGd3B5R6RE+In1bkLGwYOaCRFE74pVzhj
	 sHz/6CEN1NYbw==
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-2cc36b39545so1175315fac.1;
        Fri, 09 May 2025 11:51:03 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCULMq8Nc0Xp824uWoX+mXQmcAfIaTalLcTbon/yajrRztBOxPpKWEpLF7xK0HXp3eRTcH0jzfNtU19x@vger.kernel.org, AJvYcCUV1yMDGW81Q4RPiDjrTbU0BwE7jNXavXRJjP1mMFkcsPitFqBzICk8grfnE/pY7+ryQLbBO+qxoKkWVQLW@vger.kernel.org, AJvYcCXy/9BEnWqp3a59Gw2tRp6QfPEroJyI4rpTAEO342QPk29eVIV4SzSaxWr6iNUg5yzuLAApC1Ck8sfg@vger.kernel.org
X-Gm-Message-State: AOJu0YwUv3oLffckSbd5E4jicWKHqb+GYG5afqjfbTuQYs1zHIf3irUl
	oT/geaJ6kHQ3rfAMgRVDYuhve7iP1ERY+VlhxoS//5qsQdGbZla9GsqF3V1zxRTcg3KfpYrwVag
	jlUi5gHIz9vlQmdY73nxAk7ahxbo=
X-Google-Smtp-Source: AGHT+IF4m7l+X6tZAgUz1gBcgt1P07SQ28/qgwEd1nl2wrew0Ro2n7fDj43fzLHAM5GtUHYRT57r+FiLxNVkwVGsavc=
X-Received: by 2002:a05:6870:718b:b0:2d5:307f:cc5f with SMTP id
 586e51a60fabf-2dba588d3acmr2708220fac.12.1746816662921; Fri, 09 May 2025
 11:51:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250430060603.381504-1-qiaozhe@iscas.ac.cn>
In-Reply-To: <20250430060603.381504-1-qiaozhe@iscas.ac.cn>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 9 May 2025 20:50:52 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iUG01cMG7hqgAh21qobtC_RJEkppbD0fLPZRYCpe=Caw@mail.gmail.com>
X-Gm-Features: ATxdqUH5P_ScXYpyMAS_V-YgW3i9d9OJ83MtS_D1QA7lk97Ld8GMllF6pNGkutw
Message-ID: <CAJZ5v0iUG01cMG7hqgAh21qobtC_RJEkppbD0fLPZRYCpe=Caw@mail.gmail.com>
Subject: Re: [PATCH v3] ACPI: PCI: Release excess memory usage.
To: Zhe Qiao <qiaozhe@iscas.ac.cn>
Cc: rafael@kernel.org, lenb@kernel.org, bhelgaas@google.com, will@kernel.org, 
	sunilvl@ventanamicro.com, Markus.Elfring@web.de, linux-acpi@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 30, 2025 at 8:06=E2=80=AFAM Zhe Qiao <qiaozhe@iscas.ac.cn> wrot=
e:
>
> In the pci_acpi_scan_root() function, when creating a PCI bus fails,
> we need to free up the previously allocated memory, which can avoid
> invalid memory usage and save resources.
>
> Fixes: 789befdfa389 ("arm64: PCI: Migrate ACPI related functions to pci-a=
cpi.c")
> Signed-off-by: Zhe Qiao <qiaozhe@iscas.ac.cn>

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

and I'm expecting this to go in via PCI.

> ---
> V2 -> V3
>     1. Modify commit description.
>     2. Add release operation for ecam mapping resources.
> ---
>
>  drivers/pci/pci-acpi.c | 23 +++++++++++++----------
>  1 file changed, 13 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
> index af370628e583..e00790ecdc0f 100644
> --- a/drivers/pci/pci-acpi.c
> +++ b/drivers/pci/pci-acpi.c
> @@ -1676,24 +1676,19 @@ struct pci_bus *pci_acpi_scan_root(struct acpi_pc=
i_root *root)
>                 return NULL;
>
>         root_ops =3D kzalloc(sizeof(*root_ops), GFP_KERNEL);
> -       if (!root_ops) {
> -               kfree(ri);
> -               return NULL;
> -       }
> +       if (!root_ops)
> +               goto free_ri;
>
>         ri->cfg =3D pci_acpi_setup_ecam_mapping(root);
> -       if (!ri->cfg) {
> -               kfree(ri);
> -               kfree(root_ops);
> -               return NULL;
> -       }
> +       if (!ri->cfg)
> +               goto free_root_ops;
>
>         root_ops->release_info =3D pci_acpi_generic_release_info;
>         root_ops->prepare_resources =3D pci_acpi_root_prepare_resources;
>         root_ops->pci_ops =3D (struct pci_ops *)&ri->cfg->ops->pci_ops;
>         bus =3D acpi_pci_root_create(root, root_ops, &ri->common, ri->cfg=
);
>         if (!bus)
> -               return NULL;
> +               goto free_cfg;
>
>         /* If we must preserve the resource configuration, claim now */
>         host =3D pci_find_host_bridge(bus);
> @@ -1710,6 +1705,14 @@ struct pci_bus *pci_acpi_scan_root(struct acpi_pci=
_root *root)
>                 pcie_bus_configure_settings(child);
>
>         return bus;
> +
> +free_cfg:
> +       pci_ecam_free(ri->cfg);
> +free_root_ops:
> +       kfree(root_ops);
> +free_ri:
> +       kfree(ri);
> +       return NULL;
>  }
>
>  void pcibios_add_bus(struct pci_bus *bus)
> --
> 2.43.0
>

