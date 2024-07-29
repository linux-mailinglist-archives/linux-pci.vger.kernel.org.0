Return-Path: <linux-pci+bounces-10929-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4181393EF45
	for <lists+linux-pci@lfdr.de>; Mon, 29 Jul 2024 10:00:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 74452B220FB
	for <lists+linux-pci@lfdr.de>; Mon, 29 Jul 2024 08:00:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F3B813664C;
	Mon, 29 Jul 2024 08:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OsM0jrxM"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF82A126F1A
	for <linux-pci@vger.kernel.org>; Mon, 29 Jul 2024 08:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722240018; cv=none; b=DUBMLFr7vrmazLvQmmJnyd+YzyWE0NN7833o9CK3tPqw1wZHFJoyifNHvd9UQKWcp0zDXDqBYz7aiTvGtzQMj7FH1osw9isMVO5XXY9vn12KOATgqOTB1ge9k/ITpOqF7READVBDISeDQ4S8jISqQEl8EKD79S+DfV1qvjdZX20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722240018; c=relaxed/simple;
	bh=gqig0ULABc5QTf6gdBxiwlVkiMz++/xWAu8P9nXm+Yg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gO6zJLCG9mpvL6igDMSFpKLjWAY4FlihIXxNdDsDaGaMWYgmwfZAxmxqXlmLBneiICZRXjb0k+hGzh3CM+508iHVUBwdXQWPxnEwy8a2nQWzicczfQzmo+F4C6msjMdJF3sJEGno8WnTOYinMS3oACXXh3BAnJZS2rDoRjtHTU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OsM0jrxM; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1fc658b6b2eso20367115ad.0
        for <linux-pci@vger.kernel.org>; Mon, 29 Jul 2024 01:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722240015; x=1722844815; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=IZwZqPvJh4AbxW6ByMaS8C6OygwvpLTFq0TUS9PMs9s=;
        b=OsM0jrxMcH1lzh5QcMOB8asjIQc+QjfBL6uJpRQY7BT2U8y97ZbvC0oFrfMsWmv1A1
         KYKbk8lRImvcqG2z1pMAzSSSJRF6yjtgWNA4hwcMhpbLqOz2el+WBK1Pb2lRc62iaUO2
         Afemw2GzVTUfO+gd9DDWp+vdTL+WoXfPjuPnVBtacl3XtiaRqi8lDgb9sLmLJgPDZLQV
         UnmtWJlLN08QwnriLB2ZDWP6TK+bItfnt+Tz8EBuMDaVwflXPDnpwDdMmDoZqa6kSSIs
         AlpUoplVANwRnNjSM4V/Fz/n7jSnik2MaG38d0IRaysUuEtmSQPZSX+llSncB5mxObto
         DOlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722240015; x=1722844815;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IZwZqPvJh4AbxW6ByMaS8C6OygwvpLTFq0TUS9PMs9s=;
        b=XUsTQotBAU/nUrVehwnoj6RBEZ6I4v+hq4N+T6diWT7dX/HaC2U4JyHTTY/hRtBwSp
         zuIq1VCGvt/WW0GC+sAJ03kLgowdRwFJemaC91ryIHMKxV3dpo9SIBQcVMQuejXRivlt
         HA5xfB7bBWR3d6uXxhMaISLfbSlJjISBSX2PRjfyCE9OPORlz/t/gMUw3qxY119ch+IR
         K3Q+0SDHV2i9W3PRfVXZYq/f2wi3w5+Qkg0LYo3uOmsk+ABT89EilrDkA+Ca/fqooIn6
         diD6Q+X53QTUqqBc51r8anW6+2/leqXHIOf5NOWZYN4mB+eKylW8tingU0PsO09SFhGF
         ICZA==
X-Forwarded-Encrypted: i=1; AJvYcCX8SsQqCqtBEuKPVzYyK8E+x3+uOKeyIpAbmK/R3DmTOunSIm57w1jGNgJndphYBs90qUw+KZ3FD/g83/JdLzuJ7DliQAonV9Nw
X-Gm-Message-State: AOJu0YygLQ0cU/iPyULZQgKmmo5XmBlmSTMT16BtPrrsF8+DtnX4ecyJ
	Twx2hhEeqvIntlumAtW2bTNw2ApdWS4A9U/n/svQOSRShzuqvyLclJpRjNzhhQ==
X-Google-Smtp-Source: AGHT+IGw6ntMSIZXrn+M7V9oFM6znOqalhya3M3rym9hvcc6pLj47+SXg29jXV6DF+nKd83PCONWsA==
X-Received: by 2002:a17:903:22c2:b0:1fb:6663:b647 with SMTP id d9443c01a7336-1ff047e4486mr112315185ad.3.1722240014693;
        Mon, 29 Jul 2024 01:00:14 -0700 (PDT)
Received: from thinkpad ([117.213.101.9])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7fbd8d4sm76322585ad.271.2024.07.29.01.00.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 01:00:14 -0700 (PDT)
Date: Mon, 29 Jul 2024 13:30:06 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Siddharth Vadapalli <s-vadapalli@ti.com>, robh@kernel.org
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com,
	vigneshr@ti.com, kishon@kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	stable@vger.kernel.org, ahalaney@redhat.com, srk@ti.com
Subject: Re: [PATCH v2] PCI: j721e: Disable INTx mapping and swizzling
Message-ID: <20240729080006.GA8698@thinkpad>
References: <20240726135903.1255825-1-s-vadapalli@ti.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240726135903.1255825-1-s-vadapalli@ti.com>

On Fri, Jul 26, 2024 at 07:29:03PM +0530, Siddharth Vadapalli wrote:
> Since the configuration of INTx (Legacy Interrupt) is not supported, set
> the .map_irq and .swizzle_irq callbacks to NULL. This fixes the error:
>   of_irq_parse_pci: failed with rc=-22
> when the pcieport driver attempts to setup INTx for the Host Bridge via
> "pci_assign_irq()". The device-tree node of the Host Bridge doesn't
> contain Legacy Interrupts. As a result, Legacy Interrupts are searched for
> in the MSI Interrupt Parent of the Host Bridge with the help of
> "of_irq_parse_raw()". Since the MSI Interrupt Parent of the Host Bridge
> uses 3 interrupt cells while Legacy Interrupts only use 1, the search
> for Legacy Interrupts is terminated prematurely by the "of_irq_parse_raw()"
> function with the -EINVAL error code (rc=-22).
> 
> Fixes: f3e25911a430 ("PCI: j721e: Add TI J721E PCIe driver")
> Cc: stable@vger.kernel.org
> Reported-by: Andrew Halaney <ahalaney@redhat.com>
> Tested-by: Andrew Halaney <ahalaney@redhat.com>
> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>

TBH, I'm not comfortable with this change. Because, the INTx compatibility
_should_ come from the platform description (in this case DT) and not the
driver. The default map_irq() function is supposed to check the existence of
INTx and correctly report it. In this case the issue is, the platform is not
supporting INTx, but of_irq_parse_pci() reports a dubious error:

'of_irq_parse_pci: failed with rc=-22'

instead of the actual error:

`of_irq_parse_pci: no interrupt-map found, INTx interrupts not available'

So I would say that the fix is in of_irq_parse_pci() implementation.
of_irq_parse_pci() is supposed to find whether the PCIe controller is supporting
INTx or not by parsing the 'interrupt-{map/extended}' properties till host
bridge/controller node. But this API along with of_irq_parse_raw(), just walks
up the tree till the top level interrupt controller and checks for INTx, which
just feels wrong (that's why you are getting -EINVAL because of #interrupt-cells
mismatch).

I looked into the implementation over the weekend, but I'm not quite sure how to
fix it though.

Rob, perhaps you have any idea?

- Mani

> ---
> 
> Hello,
> 
> This patch is based on commit
> 1722389b0d86 Merge tag 'net-6.11-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net
> of Mainline Linux.
> 
> v1:
> https://lore.kernel.org/r/20240724065048.285838-1-s-vadapalli@ti.com
> Changes since v1:
> - Added "Cc: stable@vger.kernel.org" in the commit message.
> - Based on Bjorn's feedback at:
>   https://lore.kernel.org/r/20240724162304.GA802428@bhelgaas/
>   the $subject and commit message have been updated. Additionally, the
>   comment in the driver has also been updated to specify "INTx" instead of
>   "Legacy Interrupts".
> - Collected Tested-by tag from Andrew Halaney <ahalaney@redhat.com>:
>   https://lore.kernel.org/r/vj6vtjphpmqv6hcblaalr2m4bwjujjwvom6ca4bjdzcmgazyaa@436unrb2lav7/
> 
> Patch has been tested on J721e-EVM and J784S4-EVM.
> 
> Regards,
> Siddharth.
> 
>  drivers/pci/controller/cadence/pci-j721e.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/pci/controller/cadence/pci-j721e.c b/drivers/pci/controller/cadence/pci-j721e.c
> index 85718246016b..eaa6cfeb03c7 100644
> --- a/drivers/pci/controller/cadence/pci-j721e.c
> +++ b/drivers/pci/controller/cadence/pci-j721e.c
> @@ -417,6 +417,10 @@ static int j721e_pcie_probe(struct platform_device *pdev)
>  		if (!bridge)
>  			return -ENOMEM;
>  
> +		/* INTx is not supported */
> +		bridge->map_irq = NULL;
> +		bridge->swizzle_irq = NULL;
> +
>  		if (!data->byte_access_allowed)
>  			bridge->ops = &cdns_ti_pcie_host_ops;
>  		rc = pci_host_bridge_priv(bridge);
> -- 
> 2.40.1
> 

-- 
மணிவண்ணன் சதாசிவம்

