Return-Path: <linux-pci+bounces-17488-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D0329DEF4C
	for <lists+linux-pci@lfdr.de>; Sat, 30 Nov 2024 09:21:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CCDD163779
	for <lists+linux-pci@lfdr.de>; Sat, 30 Nov 2024 08:21:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D53CF139D05;
	Sat, 30 Nov 2024 08:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XsKPVIzh"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 135D02FC52
	for <linux-pci@vger.kernel.org>; Sat, 30 Nov 2024 08:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732954897; cv=none; b=uPYmRaCrYaOX/0PbNAHmVpjUDI5L1NlOTeUvZjj79zanXWM0qJm2VbCD/u30P9fmuP4kMKCwOJ1BmT8Nk2FcKAKrQGrN/A8XtF0XKZnRLojU/+9RrWj1iveV8mhM7N/b9Hq5pdgXbgSEBJromx8r+WUicKhUO08HF7n7vJk5tSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732954897; c=relaxed/simple;
	bh=PRzunPHP4ujOrWmvocspceAeTjVvFMdFLuh9PhexXfg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dfaJpIQ08xB9s5fJY+21dvSXrU9uG300KJDzU5S7G56NP7bFwSgkdrENj6I/k+rh5m4UB9gfYI0e9VFPe213xtFT7VcbwqC2HFxj59A2LcAbmD2wvUDmkHSItfu7LyhG/ioFZTG1IrZhrIa0xxrMPyNgknMV0qn54IHzjAMBuKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XsKPVIzh; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-724d8422f37so2171817b3a.2
        for <linux-pci@vger.kernel.org>; Sat, 30 Nov 2024 00:21:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732954895; x=1733559695; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=DaJm0nKnnksG9Jmzi9R8rKjQhCOefaYPRWz4WJaVqHI=;
        b=XsKPVIzhaWFVp30eXEACcELcQNf4bKoA4qIo3X3ONcTNB2HqO5KRsEn+Tepi3eCGZR
         XS3MsvqEWtOZOsIOYNTR2u1xdgGh9ovL3mQeu3okstodfhRz/K9jW/Okm/wMpA2ayuS6
         +6pTIK6GpYFwrI+OFufzVlVI9/uBwISBbo8TTOEKq5AxcM+DlZhwDZrXKWgKZp4sW2zz
         ITirDNz8NmtlJvgA2nr0fE7juoxZvwjFSML/aRt+esBoC5GtATiHPLKHITRkl9YozcRB
         4H46ulFAsZzHgcgqXzb2f3vRD2FbzGAJ8ql32RlFF70964SYOb7tKhOjv7T337YzOMmV
         tgdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732954895; x=1733559695;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DaJm0nKnnksG9Jmzi9R8rKjQhCOefaYPRWz4WJaVqHI=;
        b=xFGIeIZo5+UiPgzjz7xs/JZpHE8u73Hlbd1SotKJYZ4DEndcYjv0WAo4VWYkjymIqW
         ymNkdNLpnE2dneGepmMuO9YCzWccSxsvXHkLMzE37N84TwqlcPzL8lPxUWv+2TRxjphS
         5XDJSmtgzGVqv/98Bwr7svUisZ31Yc8jAYENFOlWpfU5U4J1Kf9sAuyJaJrX6DVLdjQ4
         C1xcDSIbIJVC92+bxAIGbSBCYpun8Z1LYnLem1mGivJENH8EGhRpkwmRFy/aDI5u5Pua
         wEAtlmIkC08pT73fIGbC/dvqk64L830VDcr5EattCozMyzyGwfBeTgqFzChaTsVph9H/
         so1g==
X-Forwarded-Encrypted: i=1; AJvYcCXwcLoOuZ6H3ORsLJ/74BVaZ7WJG4aRoOfZluYlM0u8AdCbQAsPYcvRMon7tXLrOQjf0gpitOv4eKE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWN3IDkWmF9aGUBqA5MFOpBptxpaxPrdqSlv/80aa5yPHsACRr
	VAYgdrRJ+Xb6rXqg1CJCO7h9kKzVxlkz/Xo7SMPeGYGhF2XRMcxD0ckkStmcYg==
X-Gm-Gg: ASbGncsKnTDx43QpNpkIgldFqUXTaZQY3Ao0fNS37F272lZrIDtVcCbyhioVOWvLvWe
	rnr0SFFlVgnzFiTzpqLFfD3d5HYgQBkdoOYE523s46MOfcV5egT6ndEXfgKZrXYcBUnmiuwtKLp
	Y4Y4lfKfDr/p5SVTiUMzhqW4s9MjUAomynqq+y/ST7b2ghy+z3nkYNwKkiJ+n2BAuEk3nV7bP0+
	PevWXMfHnD2v436Pr6Nfaum8Kxf43sj3GEdY2hm1TYKE1AsNYcUqbBd+3q/
X-Google-Smtp-Source: AGHT+IHmFd1SG7Pf+M0+gG6hzoS6BYfXZZydcMDHjJ3ipvbUqu8AokzKf3/LIw6c/yeuLwniYkKMwg==
X-Received: by 2002:a05:6a00:148e:b0:724:dba1:61ef with SMTP id d2e1a72fcca58-7253016e2ccmr20092948b3a.24.1732954895336;
        Sat, 30 Nov 2024 00:21:35 -0800 (PST)
Received: from thinkpad ([120.60.57.102])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72541849d6csm4851763b3a.182.2024.11.30.00.21.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Nov 2024 00:21:34 -0800 (PST)
Date: Sat, 30 Nov 2024 13:51:19 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>, linux-pci@vger.kernel.org,
	Frank Li <Frank.Li@nxp.com>
Subject: Re: [PATCH v2 2/2] misc: pci_endpoint_test: Add support for
 capabilities
Message-ID: <20241130082119.44zpza3ehlwf3zct@thinkpad>
References: <20241121152318.2888179-4-cassel@kernel.org>
 <20241121152318.2888179-6-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241121152318.2888179-6-cassel@kernel.org>

On Thu, Nov 21, 2024 at 04:23:21PM +0100, Niklas Cassel wrote:
> The test BAR is on the EP side is allocated using pci_epf_alloc_space(),
> which allocates the backing memory using dma_alloc_coherent(), which will
> return zeroed memory regardless of __GFP_ZERO was set or not.
> 
> This means that running a new version of pci-endpoint-test.c (host side)
> with an old version of pci-epf-test.c (EP side) will not see any
> capabilities being set (as intended), so this is backwards compatible.
> 
> Additionally, the EP side always allocates at least 128 bytes for the test
> BAR (excluding the MSI-X table), this means that adding another register at
> offset 0x30 is still within the 128 available bytes.
> 
> For now, we only add the CAP_UNALIGNED_ACCESS capability.
> 
> If CAP_UNALIGNED_ACCESS is set, that means that the EP side supports
> reading/writing to an address without any alignment requirements.
> 
> Thus, if CAP_UNALIGNED_ACCESS is set, make sure that the host side does
> not add any extra padding to the buffers that we allocate (which was only
> done in order to get the buffers to satisfy certain alignment requirements
> by the endpoint controller).
> 
> Signed-off-by: Niklas Cassel <cassel@kernel.org>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

One suggestion below.

> ---
>  drivers/misc/pci_endpoint_test.c | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
> index 3aaaf47fa4ee..caae815ab75a 100644
> --- a/drivers/misc/pci_endpoint_test.c
> +++ b/drivers/misc/pci_endpoint_test.c
> @@ -69,6 +69,9 @@
>  #define PCI_ENDPOINT_TEST_FLAGS			0x2c
>  #define FLAG_USE_DMA				BIT(0)
>  
> +#define PCI_ENDPOINT_TEST_CAPS			0x30
> +#define CAP_UNALIGNED_ACCESS			BIT(0)
> +
>  #define PCI_DEVICE_ID_TI_AM654			0xb00c
>  #define PCI_DEVICE_ID_TI_J7200			0xb00f
>  #define PCI_DEVICE_ID_TI_AM64			0xb010
> @@ -805,6 +808,22 @@ static const struct file_operations pci_endpoint_test_fops = {
>  	.unlocked_ioctl = pci_endpoint_test_ioctl,
>  };
>  
> +static void pci_endpoint_test_get_capabilities(struct pci_endpoint_test *test)
> +{
> +	struct pci_dev *pdev = test->pdev;
> +	struct device *dev = &pdev->dev;
> +	u32 caps;
> +	bool ep_can_do_unaligned_access;
> +
> +	caps = pci_endpoint_test_readl(test, PCI_ENDPOINT_TEST_CAPS);
> +
> +	ep_can_do_unaligned_access = caps & CAP_UNALIGNED_ACCESS;
> +	dev_dbg(dev, "CAP_UNALIGNED_ACCESS: %d\n", ep_can_do_unaligned_access);

IDK if the users really need to know about this flag, nor it will assist in any
debugging. Otherwise, I'd suggest to drop this debug print and just do:

	if (pci_endpoint_test_readl(test, PCI_ENDPOINT_TEST_CAPS))
		test->alignment = 0;

- Mani

-- 
மணிவண்ணன் சதாசிவம்

