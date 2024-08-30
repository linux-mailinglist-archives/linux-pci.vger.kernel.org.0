Return-Path: <linux-pci+bounces-12484-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DB13D965659
	for <lists+linux-pci@lfdr.de>; Fri, 30 Aug 2024 06:36:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BE841C227F4
	for <lists+linux-pci@lfdr.de>; Fri, 30 Aug 2024 04:36:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7C1613A243;
	Fri, 30 Aug 2024 04:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HSbOfewM"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EE9214B96F
	for <linux-pci@vger.kernel.org>; Fri, 30 Aug 2024 04:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724992553; cv=none; b=THc0bj00HoqIWZ4QVkGoNX4o/4rdFpGaJesDkVflqMzHFUOCkC0W8DxlcNsUpYiOGVWJoi+vFuHaQEMZYUrJwqHcajQ3QiOY4laoXcFUSNjaOsgkhZ1LMwlgGdjRclSffCU6KbTR0v/XERbU6alIecpXNfjGvoPrpkXB6lOAtvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724992553; c=relaxed/simple;
	bh=wSWeBiZG86EsRceJ7rPkUYuvOE2E0fdZyA7z0/EJnFM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZAhjl7GowQxUQr5QzHr+bFqcnCDfO34a6MmV/+DS/2H1hSPNAo+WQ68hxMl+k89WIevFdZGoHd5kdqYgMa5i21N3DmatTYFXzsrAW+RKdwaZ2wxDQyS73suWvVThuDhEO0067upLmliDHfeoPZu5ssKlYenoJUvsOm0BuXEt+mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HSbOfewM; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-27022a3536dso748951fac.2
        for <linux-pci@vger.kernel.org>; Thu, 29 Aug 2024 21:35:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724992551; x=1725597351; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SDojeKsnYFkZr683fbu0viahLdIhu/DA+Rk27xZ7/dk=;
        b=HSbOfewMgoeiW2fDOSlaN+eI6QBqasxgekNyHlk8xVRwDhPvHR7VWv3oAF50uMQBXI
         NKpYQiiSdALUEL5Y+sOmL/7dLrHXvSFwXy8QxyF3vs2EoVeDphkqQlhq6uvBUOqO3Ir+
         9ochnwM8HnFeLOllHpOaPDgFBCn5y6565BDpf0wmNsb7G+D14ircqk/x8AKcL2DmMKVQ
         n47u5cKBRg3Ymav04OOCGXO5iJo7xswobSuw/HUECTQCqrOUqNEI3b5IPrnl+ydhhPnl
         Zh6iuLjC/Xfs88+IT0nPjAHpk74o+L4jA8k/bu0IduzQnkPPMbuDhjs6jImqPbcO5tBz
         6C/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724992551; x=1725597351;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SDojeKsnYFkZr683fbu0viahLdIhu/DA+Rk27xZ7/dk=;
        b=XLeTw2GDX/r2MIgjxG6Y8MPXk5hiGyQQHbgdNhSGbyY3J8WmoEl/z1sfLVL2Dm+DXM
         kFxkaisN+hkDs64r/DQr96NFmQMphkB1nIi9ioGdZbYI1uzim51Wm4e5zIOfDtMAOQvn
         cXMPtyhLEeZIW2jhkpawVw+MaYA17GgOjRd8j7tMyqEopzZgCfX/D6E06A/jsnyhsqid
         CGIyDQKgcdDBVKti8KzjbNYZfCRbSsRsQ/fvWIkhkChQ4wCVM1205dbF33zvlCovFlTe
         0nGc7Nfm/5a0zri6MaF2jATvVJFO7VMhU/iKBZDFMNndCHf+1e6ldqDttdJ4eHlJP/XW
         c4ZA==
X-Forwarded-Encrypted: i=1; AJvYcCVmYS9m0Ar8rtBJ3atHxkurArN2lRXVrKSz4QJ5ZWT+nIOCppCgObGtZ8+NQG1R9N7BlA70oe62wbM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeuJ67klpFRzuIT0aOQi9lrmIhgmzRUp2Gcg33Wyemll+3EUIv
	ANsjrFrJZ26wwDjKilS3xhko0HwyNu/gjX6kWb85r0Gjd5jZeZ8oP44+RW5xauvcNvvxAWdIhK+
	RrIAl5rqmnBzkVN4xLraYVpj6Hbc=
X-Google-Smtp-Source: AGHT+IFnyqNrPlsug/S68ahl+zS6yb4/d5ML0KiSXqE862rsfEBorGTQRdjYhWv6Mk2FR++8LYaDHbft5aaiYd5OmMo=
X-Received: by 2002:a05:6870:170f:b0:268:b4b6:91ab with SMTP id
 586e51a60fabf-277900d397amr5351577fac.18.1724992551002; Thu, 29 Aug 2024
 21:35:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240830035819.13718-1-zhangzekun11@huawei.com> <20240830035819.13718-5-zhangzekun11@huawei.com>
In-Reply-To: <20240830035819.13718-5-zhangzekun11@huawei.com>
From: Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date: Fri, 30 Aug 2024 06:35:40 +0200
Message-ID: <CAMhs-H_iWPV8NZhAoZjueysxSeq58pL2Xz83AmWgxdn1ndELmg@mail.gmail.com>
Subject: Re: [PATCH v2 4/6] PCI: mt7621: Use helper function for_each_available_child_of_node_scoped()
To: Zhang Zekun <zhangzekun11@huawei.com>
Cc: songxiaowei@hisilicon.com, wangbinghui@hisilicon.com, 
	lpieralisi@kernel.org, kw@linux.com, manivannan.sadhasivam@linaro.org, 
	robh@kernel.org, bhelgaas@google.com, linux-pci@vger.kernel.org, 
	ryder.lee@mediatek.com, jianjun.wang@mediatek.com, 
	angelogioacchino.delregno@collabora.com, matthias.bgg@gmail.com, 
	alyssa@rosenzweig.io, maz@kernel.org, thierry.reding@gmail.com, 
	Jonathan.Cameron@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Aug 30, 2024 at 6:11=E2=80=AFAM Zhang Zekun <zhangzekun11@huawei.co=
m> wrote:
>
> for_each_available_child_of_node_scoped() provides a scope-based cleanup
> functinality to put the device_node automatically, and we don't need to
> call of_node_put() directly.  Let's simplify the code a bit with the use
> of these functions.
>
> Signed-off-by: Zhang Zekun <zhangzekun11@huawei.com>
> Reviewed-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
> v2:
> - Use dev_perr_probe to simplify code.
> - Fix spelling error in commit message.

This commit message still has the type 'functinality"....

Thanks,
    Sergio Paracuellos
>
>  drivers/pci/controller/pcie-mt7621.c | 15 +++++----------
>  1 file changed, 5 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/pci/controller/pcie-mt7621.c b/drivers/pci/controlle=
r/pcie-mt7621.c
> index 9b4754a45515..354d401428f0 100644
> --- a/drivers/pci/controller/pcie-mt7621.c
> +++ b/drivers/pci/controller/pcie-mt7621.c
> @@ -258,30 +258,25 @@ static int mt7621_pcie_parse_dt(struct mt7621_pcie =
*pcie)
>  {
>         struct device *dev =3D pcie->dev;
>         struct platform_device *pdev =3D to_platform_device(dev);
> -       struct device_node *node =3D dev->of_node, *child;
> +       struct device_node *node =3D dev->of_node;
>         int err;
>
>         pcie->base =3D devm_platform_ioremap_resource(pdev, 0);
>         if (IS_ERR(pcie->base))
>                 return PTR_ERR(pcie->base);
>
> -       for_each_available_child_of_node(node, child) {
> +       for_each_available_child_of_node_scoped(node, child) {
>                 int slot;
>
>                 err =3D of_pci_get_devfn(child);
> -               if (err < 0) {
> -                       of_node_put(child);
> -                       dev_err(dev, "failed to parse devfn: %d\n", err);
> -                       return err;
> -               }
> +               if (err < 0)
> +                       return dev_err_probe(dev, err, "failed to parse d=
evfn\n");
>
>                 slot =3D PCI_SLOT(err);
>
>                 err =3D mt7621_pcie_parse_port(pcie, child, slot);
> -               if (err) {
> -                       of_node_put(child);
> +               if (err)
>                         return err;
> -               }
>         }
>
>         return 0;
> --
> 2.17.1
>

