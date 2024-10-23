Return-Path: <linux-pci+bounces-15109-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 61DEA9AC383
	for <lists+linux-pci@lfdr.de>; Wed, 23 Oct 2024 11:19:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D7C41F248C9
	for <lists+linux-pci@lfdr.de>; Wed, 23 Oct 2024 09:19:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8798199256;
	Wed, 23 Oct 2024 09:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tMCHXHHn"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B76B815B122
	for <linux-pci@vger.kernel.org>; Wed, 23 Oct 2024 09:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729675146; cv=none; b=KE4RQwnhDkaVSDfIJ8oQUF5GppZse3SDTLpAOwG4g7nuP5xv/V5ROk+GC0x3WszTsXB1DksmG5b2ItNdx6qDgB/eod9W9PQQdKQmte4+ecmh3fk/JjQaF+P9vJCbSYnIg5w2w9xifUm0BBQ+GjpwGTRjRnQrgM7i5wQ5VqjlAiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729675146; c=relaxed/simple;
	bh=GF4XUnEbwxghALos0MVhZhrcg5it838v2dRUxeo28GU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ak3Nxb0Bw/XdW5gONiIkST5jMq+QJ7BYNA2khvR85FLjbDpifswDYG5gM42ajSDkpm7eKTERASK03PKn4rgrIuXW/ZqzaCorqQa1ePkRqFYROddJQ/7Hzm5wAykq18Eb7DrPWlOpRfEM4jVJm1Opw2d0si498QXYzwY9Mmhul4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tMCHXHHn; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-6e2f4c1f79bso55192577b3.1
        for <linux-pci@vger.kernel.org>; Wed, 23 Oct 2024 02:19:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729675142; x=1730279942; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6yNYAMo6nIY0af8IfvqpVjHErg1EBytGiMZlODLuLvI=;
        b=tMCHXHHnvETaL3FycbUdL1e31p6LZeKf3H7L60zHqEMUQxq3bls1FWe+TYAYxmf0Nn
         PxsQeq1wdTvWR8jlgY7GCSPA9+zJyLP5av4d+KekxTBw8Jd6O0apRK0XNCRQA6+mW5JQ
         khqV+IU4zGY7kls/mzOjnmrU3JJ3NF9FurW006HsSZRTF6WQ5De2MWOsm75rFWxCvQBU
         Qd/sjJvEEacfTWqRSm/qgLqII3wXn30qzhM4qP9VbPjibr3D2YjxkyIhLTWTAO9Mkdi6
         viMISa9zV+tjL/+FGFw/jn3d2oQgET9nuJqXyufDtRbUNpSpA4pX7FxwvAJywA1szp3Y
         bP9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729675142; x=1730279942;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6yNYAMo6nIY0af8IfvqpVjHErg1EBytGiMZlODLuLvI=;
        b=rq01hk9Zn4RavTgN3fC5AAff7IsBDpcxhJjzMu9m+aJtw81brbeB0+nNvM0cDtlJdk
         Js7HkzqXi/riW0m9GNiKheGWD0GoyGwzQtQnzkpteknaPz1don3ZdcDTXISauJr3+ypp
         j0qGSfYZB0QPWAkln6oUR4jL1SbCsa6YZAPacfOTtbwgG3WNPIrTCkB4zuqs0O0Rrpyw
         DZsZ6ETWKuqZSrSVttIvYi1AkbIPA/C8STWzNbfwKoxkkoIeMXtj7WnRUTM6VrmVO3fk
         sbcdDAqKIM+uoiIP+XFdIaMG24/4QtRpfpFFQOHoXr7sDUyey4XvchG+LuUX0TZfpMZE
         leLA==
X-Forwarded-Encrypted: i=1; AJvYcCVImY1iUcFZ5Rf6dRek/P/9GiIo/aq8vkG+Ld8ApHAEPTtv+vwaFt7caTrxo4++2M9LhXLjpb1MooI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwelWwXJqh9ApEkWSrBm/k9tPco5edjnaqsa34Dj57rO+Phgn8+
	YtxNM0zUuHJ55ih/yMONxF9el1T68Yx0BHF0DyFCuiuvs119FOlZkFA175sA/t287z8T5fVmE0o
	RKGqJHwKO3DvChi5eBheROtjZPqBQ2FVRpmYRlg==
X-Google-Smtp-Source: AGHT+IGpIjD7BcdD46tPOh7kmUpH9whjxlEjOddX1QK/EBlWQrZcPllLG0fxN1sSQbTKDC6i0jaawobrC8kt1HUWii4=
X-Received: by 2002:a05:690c:34c1:b0:6e3:d4e3:b9ad with SMTP id
 00721157ae682-6e7f0f89792mr22653317b3.33.1729675142656; Wed, 23 Oct 2024
 02:19:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241022-pci-pwrctl-rework-v1-0-94a7e90f58c5@linaro.org> <20241022-pci-pwrctl-rework-v1-1-94a7e90f58c5@linaro.org>
In-Reply-To: <20241022-pci-pwrctl-rework-v1-1-94a7e90f58c5@linaro.org>
From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Date: Wed, 23 Oct 2024 11:18:51 +0200
Message-ID: <CACMJSeuBb9VmRrGJnak6D3Ddow+-OMb+79uZzUUaWe3BF1SgTg@mail.gmail.com>
Subject: Re: [PATCH 1/5] PCI/pwrctl: Use of_platform_device_create() to create
 pwrctl devices
To: manivannan.sadhasivam@linaro.org
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
	Johan Hovold <johan+linaro@kernel.org>, Abel Vesa <abel.vesa@linaro.org>, 
	Stephan Gerhold <stephan.gerhold@linaro.org>, 
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
	Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 22 Oct 2024 at 12:28, Manivannan Sadhasivam via B4 Relay
<devnull+manivannan.sadhasivam.linaro.org@kernel.org> wrote:
>
> From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
>
> of_platform_populate() API creates platform devices by descending through
> the children of the parent node. But it provides no control over the child
> nodes, which makes it difficult to add checks for the child nodes in the
> future. So use of_platform_device_create() API together with
> for_each_child_of_node_scoped() so that it is possible to add checks for
> each node before creating the platform device.
>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  drivers/pci/bus.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
> index 55c853686051..959044b059b5 100644
> --- a/drivers/pci/bus.c
> +++ b/drivers/pci/bus.c
> @@ -13,6 +13,7 @@
>  #include <linux/ioport.h>
>  #include <linux/of.h>
>  #include <linux/of_platform.h>
> +#include <linux/platform_device.h>
>  #include <linux/proc_fs.h>
>  #include <linux/slab.h>
>
> @@ -329,6 +330,7 @@ void __weak pcibios_bus_add_device(struct pci_dev *pdev) { }
>  void pci_bus_add_device(struct pci_dev *dev)
>  {
>         struct device_node *dn = dev->dev.of_node;
> +       struct platform_device *pdev;
>         int retval;
>
>         /*
> @@ -351,11 +353,11 @@ void pci_bus_add_device(struct pci_dev *dev)
>         pci_dev_assign_added(dev, true);
>
>         if (dev_of_node(&dev->dev) && pci_is_bridge(dev)) {
> -               retval = of_platform_populate(dev_of_node(&dev->dev), NULL, NULL,
> -                                             &dev->dev);
> -               if (retval)
> -                       pci_err(dev, "failed to populate child OF nodes (%d)\n",
> -                               retval);
> +               for_each_child_of_node_scoped(dn, child) {

Since we won't be populating any disabled nodes, I'd use
for_each_available_child_of_node_scoped() here.

Bart

> +                       pdev = of_platform_device_create(child, NULL, &dev->dev);
> +                       if (!pdev)
> +                               pci_err(dev, "failed to create OF node: %s\n", child->name);
> +               }
>         }
>  }
>  EXPORT_SYMBOL_GPL(pci_bus_add_device);
>
> --
> 2.25.1
>
>

