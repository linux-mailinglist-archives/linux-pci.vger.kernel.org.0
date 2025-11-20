Return-Path: <linux-pci+bounces-41738-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 464BEC729D7
	for <lists+linux-pci@lfdr.de>; Thu, 20 Nov 2025 08:33:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 397D6289D4
	for <lists+linux-pci@lfdr.de>; Thu, 20 Nov 2025 07:33:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0824E184E;
	Thu, 20 Nov 2025 07:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="grvCc5Tn"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 373CE288C0E
	for <linux-pci@vger.kernel.org>; Thu, 20 Nov 2025 07:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763624004; cv=none; b=IXSb6xShaTK5KWPquc8ltcLF/VVDHeN6YeP02D9deYU6Ydf9GXpj6ovIYhuLJ89UKkGoGwVGfot4UBZdn8WbwmiV5w2ZvTZGaySHkfrh7qEsyY270JsP3hfqTh8hBau1kvnggQW97l+CivjeYg75xXUF0ILIndoAchyxoOqIMjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763624004; c=relaxed/simple;
	bh=KFBnui6rPjAi53zIWecorUcdMS7QkWr6WfZXkU9nyuc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Bqo1YLm+OzpAIJv4NXSqkgRsyquTdKIaLXFxPVQ+kxAzGfxchjB4EFrvQzrTd3kq9vu+iP4MsTA/PeEBq12XUgGCGRtkaVGg2QOl4Slb8yCbmXWAjDw6D/Ki1z+PQ2jAkfw02Mlv208KlXq632QfR59prBkWX6sqQvkXraXRd2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=grvCc5Tn; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b7291af7190so84050566b.3
        for <linux-pci@vger.kernel.org>; Wed, 19 Nov 2025 23:33:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1763624001; x=1764228801; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MVfkIhRM3NgSRE5RLXEAkdQGNqO22B4nKJCnXIMJHvk=;
        b=grvCc5TnKGyv5LO00XYphGOfes8n1WwAHBIG2SidLRRVCdRbG0RJg4l0F49YuDmJAK
         7y1T/wcrQeeZgDOR9VBuEfRsnD1FEQvj+dPx22dZr7qJ4xBBwfW38s0jEvWZrKNNTKAo
         vTwltZI2vuecwgG3gbMNEu33i/Sd9jdyValZSF7bx4mY5P2Az4aAZVQwyhCGaCdvBJWQ
         QIxaU+dxxtGljCSY+Rpr0k7JsZmvgTfHwqc7+nonJtbldC5BLiHl2i04/3jSHEw9LFbs
         9J30ek1P4bN0Sgpz/k0IritBzq5TCYl4K207hktcjvOx4cG9omEBvsaQN7SBXW7bH2wO
         H4QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763624001; x=1764228801;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MVfkIhRM3NgSRE5RLXEAkdQGNqO22B4nKJCnXIMJHvk=;
        b=Npeu+jxiX0GlN+EOxZOevMxynWLNTU20ZVvoXQEeMTvxyO7Y4Xz+I3qShGeVV/IAWh
         MW7+PlDMt1xqeOija6bH3ucX04oDb68forhMfMRa7EtRVciEWcJ+mqTG1/T/VisMXAhi
         HxZ8NciGLX1Og5l5ywep0fygLWnWRAI3zHsOrTBGCvF3OAc27DaGXfSgR0BDVhvWLW8J
         9SIn7UAtNpQBdPKEMHWkknpz0kYUu9w776x4agWRMwTjW+HBxSneAws4BoLEG2ZeOdru
         2SdcsWp74cWIlHgojDdJx5tAyoC3wM+zxMr45Jytubl7hVhinO6ki4TF66gtgOglTL2a
         9h5w==
X-Forwarded-Encrypted: i=1; AJvYcCXzNB5RL2sou623CGt+aFofZFukKq85FRvw1wCyDZ8rvogjydESNxOtNo34iKL6pDEzFFKQe35hxu0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYqsyRo81WKMnsOPAPpCH5LF5H/0QCwQoRoyIvWnucZEShW1gT
	Tb0JnZobLUQzl9nYeNybW8HSjy3eQbMc/E9OdOT8rI79CFemJv0ExyY+LzaPjrgACLOLLdBnoEp
	/b1s68OWvt4FwPl0GwBzj3UDmlJlwllWdp2Vuc5HXTQ==
X-Gm-Gg: ASbGnctdQngdwM4EkXI6sjix2NBdsS8JXOvOoRbGBSRCu9OSYdfjhS5lsDSm6BhuBtm
	uvAkIsVnLRs68KNGtsbezWBBOK6m5rU8huyDwEFNAM/rc0C5xbfdIsqdE8PW6q6C7nz+JAarSqf
	Iy9SIsnwt0uYlB3glN/YfGVwwaW3CXLrCwCE+bqxmmO7ILfWaUKkI3gnxryuxLTxSc5tuc1YGR4
	Y1vuljQrWuy8U8Nc+n09If0HAifUoJUdkjUyHfvN7+IRuLN5XfOhycl9yiN91nunDY8RhHgYCy/
	CrIzHBD/S0c+wCdw1bzcHxSTKNAjxZFP1RI=
X-Google-Smtp-Source: AGHT+IGrBjsWGQrGykL6ffk3fkB/IMHlvu/W915gtS6XGras8xWeYHAhTtfC2TIoFsE0FQyTsy8fXGwwZAJo/EO2m4M=
X-Received: by 2002:a17:907:9722:b0:b73:80de:e6b2 with SMTP id
 a640c23a62f3a-b76588aff91mr147960066b.31.1763624001540; Wed, 19 Nov 2025
 23:33:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251119-pci-dwc-suspend-rework-v1-0-aad104828562@oss.qualcomm.com>
 <20251119-pci-dwc-suspend-rework-v1-1-aad104828562@oss.qualcomm.com>
In-Reply-To: <20251119-pci-dwc-suspend-rework-v1-1-aad104828562@oss.qualcomm.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Thu, 20 Nov 2025 08:33:09 +0100
X-Gm-Features: AWmQ_blFK9VHm0z9cBp-9NWI0hN-zFp3wxCCL2qaoe6WYJsrlALzWaBKwmyg6pI
Message-ID: <CAKfTPtB+h3eU5Fe5UzFva_-W2-EOX7RjaM_EG7qxuyTnCSHEWg@mail.gmail.com>
Subject: Re: [PATCH 1/2] PCI: dwc: Skip PME_Turn_Off broadcast and L2/L3
 transition during suspend if link is not up
To: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Cc: Jingoo Han <jingoohan1@gmail.com>, Manivannan Sadhasivam <mani@kernel.org>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, zhangsenchuan@eswincomputing.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 19 Nov 2025 at 19:10, Manivannan Sadhasivam
<manivannan.sadhasivam@oss.qualcomm.com> wrote:
>
> During system suspend, if the PCIe link is not up, then there is no need
> to broadcast PME_Turn_Off message and wait for L2/L3 transition. So skip
> them.
>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Tested-by: Vincent Guittot <vincent.guittot@linaro.org>

> ---
>  drivers/pci/controller/dwc/pcie-designware-host.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index 20c9333bcb1c..8fe3454f3b13 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -1129,6 +1129,9 @@ int dw_pcie_suspend_noirq(struct dw_pcie *pci)
>         u32 val;
>         int ret;
>
> +       if (!dw_pcie_link_up(pci))
> +               goto stop_link;
> +
>         /*
>          * If L1SS is supported, then do not put the link into L2 as some
>          * devices such as NVMe expect low resume latency.
> @@ -1162,6 +1165,7 @@ int dw_pcie_suspend_noirq(struct dw_pcie *pci)
>          */
>         udelay(1);
>
> +stop_link:
>         dw_pcie_stop_link(pci);
>         if (pci->pp.ops->deinit)
>                 pci->pp.ops->deinit(&pci->pp);
>
> --
> 2.48.1
>

