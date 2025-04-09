Return-Path: <linux-pci+bounces-25534-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AAB2DA81DDA
	for <lists+linux-pci@lfdr.de>; Wed,  9 Apr 2025 09:05:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DFBB37B7480
	for <lists+linux-pci@lfdr.de>; Wed,  9 Apr 2025 07:03:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1824822CBFD;
	Wed,  9 Apr 2025 07:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="t2hcSW0S"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4907322CBEC
	for <linux-pci@vger.kernel.org>; Wed,  9 Apr 2025 07:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744182225; cv=none; b=ktSGUBeQ95pQvj3xaLParKUmR8LepbLaDwip6aBVYGPGD4iV4t6Nu0g6sJ/buxIH4MgwszcnS0cKYfipPxYP0TnbkcOxbxVEoyYl5v4w/CTSY9HalcK8U+NpEzSSQI0CasTgypQOqBjNGcZr61i3xB8YTG904G7qHWHm2mq9KFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744182225; c=relaxed/simple;
	bh=EZq22anG/9npbJ/VrGJauJO2Uk+ibd8U4E4kMBT5yKc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n6tt96IeUBhGTBa4kMQ7tw9ucPPTgpUQzbCXwpBgFfM75UdlQcOynUZLv2BQib1hizjuhJpUSLtLYC3B5p1t5D1FScKLcDumm/qMvE7sMvPzIPZD3CB9rqj5m4K/i29ua3/i359TjN8l6tHBXlQHfNQLnxtlK0FDHrOg4XQdodU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=t2hcSW0S; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-227b828de00so63626755ad.1
        for <linux-pci@vger.kernel.org>; Wed, 09 Apr 2025 00:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1744182222; x=1744787022; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=DGElUBIVZnFwsgQhaZUiAdQk0emW8IaLlp1izuhH+xo=;
        b=t2hcSW0SBAMLkivwExyPXd/X1/GpOLa4Tlw4ulv+SKRr9NJLb8lizs4MfAFMyAVios
         Bgwr42oxtfsdMOEvj4bFc6AxO+DqOsjmGOmgC1BmSL2Zbzovp9YMemN148lR3i0RNEQr
         pQ0Mz/tb6eS/LMWaP95EDdfRxt+qDdki33hsGMqLjs8SveiTED4UeVfPzbNpfxa5ES53
         tX2dEzBRimUoZF7YRQjE7WDzqIRyjaon+k9ywQM5dXjhXLdBhJ/9DK6tj32ksX6KKo0y
         lThALSxLD0gRDlmglqp+XWBhPHDqosm3m2Zz3s4OJbT42VltQaaSmYUGuvFhGqPaAuXK
         dtHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744182222; x=1744787022;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DGElUBIVZnFwsgQhaZUiAdQk0emW8IaLlp1izuhH+xo=;
        b=MusaNhA4aMH0U0vuuuT4XlBCV/37AbIzagxwMnUGU+YqPHJvUnBzsVFqJlZwJyfAc9
         r3Mqs3DIzUNePs4UOlbh3bHOWY+/Sr8569iCL6d6PTj2/oLHtETA/yOdxCOF1WJ/HAED
         lTe+hbFKw3MDAvcutNzVimjsQqjKpwTKnEKS5qzUkHnr3ahSwHLCsFm5/TXkpcPe7w8c
         QkU5B0Vl0L81hcYXnQBHzB3mvM2w/9qyGezXETi/amK80jkARDvvDPu2bC7G4fOD8tI1
         S4/IzN/uBVg33W4/5oYDOULqJAwrdiw/gyfCUDhtJ3y9KThuxwIJw/49GwOXRHIiPn9W
         jBow==
X-Forwarded-Encrypted: i=1; AJvYcCU/xk0AxCuibP1l1dPOOqQ4nD1sDzttLrm6Db3S69Hu/pFFm+vYLzZ48YrDx8ihyvyWi1HI1C220ZQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxu8JVYRARYnphJ/1kx/+7pJ8NBGdFb4WnIZsJWKtPmgdMd6aNf
	YU9L8qTFWIAZ8mujk3sDIDqtJV2ci8/c7s08hNZ/3GAjFQnS7wBdwh58NmaqVw==
X-Gm-Gg: ASbGncurh3hGWIlqskNBEYQtUkNXdyyEM9r1XiC8Lj5reebaWECDRZ7l9US9PD7x59M
	Mp/rIniv5N79j8tTL30yaFX76V9KR47vA5r8FnGopnXMZ3bmTdKfo767HNmHGxjPB1Dmc583NtR
	TwXFlAmZAI18kP+SVAAbmG+409sSK4xZrglrIvHNDV0FitdEjN9xJP2htJgBuV1jU1pKRELt/mD
	af+G+e0jiI9kvjHMLfPUbj4aeC3mH8CGhiU2eMXhKCe0uWqZLuyPLg34P6p/K/xIIG3Ed639vDM
	JlsjA31TeMosDQmiQA3ABr1FJ0Aza1tQsD0/EOiWsyU6I32Nyzk=
X-Google-Smtp-Source: AGHT+IHJWzSsXJw2VZkhyJEXKQj3l3Q6r/TTI9SW2X0aqBW9IPTMqyWhVeTcmshL0WO+GqY9reIywA==
X-Received: by 2002:a17:902:f706:b0:226:38ff:1d6a with SMTP id d9443c01a7336-22ac298442fmr27396745ad.7.1744182222402;
        Wed, 09 Apr 2025 00:03:42 -0700 (PDT)
Received: from thinkpad ([120.56.198.53])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22ac7b8b73asm4639085ad.86.2025.04.09.00.03.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Apr 2025 00:03:41 -0700 (PDT)
Date: Wed, 9 Apr 2025 12:33:38 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: bhelgaas@google.com, kw@linux.com, Frank Li <Frank.Li@nxp.com>, 
	linux-pci@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>, 
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: Re: [PATCH] misc: pci_endpoint_test: Defer IRQ allocation until
 ioctl(PCITEST_SET_IRQTYPE)
Message-ID: <3eukqjibpeom2td6aa5jf56avjc2lxfhhdeqg3b7hghj73rkdj@b2tqstyomtv7>
References: <20250402085659.4033434-2-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250402085659.4033434-2-cassel@kernel.org>

On Wed, Apr 02, 2025 at 10:57:00AM +0200, Niklas Cassel wrote:
> Commit a402006d48a9 ("misc: pci_endpoint_test: Remove global 'irq_type'
> and 'no_msi'") changed so that the default IRQ vector requested by
> pci_endpoint_test_probe() was no longer the module param 'irq_type',
> but instead test->irq_type. test->irq_type is by default
> IRQ_TYPE_UNDEFINED (until someone calls ioctl(PCITEST_SET_IRQTYPE)).
> 
> However, the commit also changed so that after initializing test->irq_type
> to IRQ_TYPE_UNDEFINED, it also overrides it with driver_data->irq_type, if
> the PCI device and vendor ID provides driver_data.
> 
> This causes a regression for PCI device and vendor IDs that do not provide
> driver_data, and the driver now fails to probe on such platforms.
> 
> Considering that the pci endpoint selftests and the old pcitest always
> call ioctl(PCITEST_SET_IRQTYPE) before performing any test that requires
> IRQs, simply remove the allocation of IRQs in pci_endpoint_test_probe(),
> and defer it until ioctl(PCITEST_SET_IRQTYPE) has been called.
> 
> A positive side effect of this is that even if the endpoint controller has
> issues with IRQs, the user can do still do all the tests/ioctls() that do
> not require working IRQs, e.g. PCITEST_BAR and PCITEST_BARS.
> 
> This also means that we can remove the now unused irq_type from
> driver_data. The irq_type will always be the one configured by the user
> using ioctl(PCITEST_SET_IRQTYPE). (A user that does not know, or care
> which irq_type that is used, can use PCITEST_IRQ_TYPE_AUTO. This has
> superseded the need for a default irq_type in driver_data.)
> 
> Fixes: a402006d48a9c ("misc: pci_endpoint_test: Remove global 'irq_type' and 'no_msi'")
> Signed-off-by: Niklas Cassel <cassel@kernel.org>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
>  drivers/misc/pci_endpoint_test.c | 21 +--------------------
>  1 file changed, 1 insertion(+), 20 deletions(-)
> 
> diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
> index d294850a35a1..c4e5e2c977be 100644
> --- a/drivers/misc/pci_endpoint_test.c
> +++ b/drivers/misc/pci_endpoint_test.c
> @@ -122,7 +122,6 @@ struct pci_endpoint_test {
>  struct pci_endpoint_test_data {
>  	enum pci_barno test_reg_bar;
>  	size_t alignment;
> -	int irq_type;
>  };
>  
>  static inline u32 pci_endpoint_test_readl(struct pci_endpoint_test *test,
> @@ -948,7 +947,6 @@ static int pci_endpoint_test_probe(struct pci_dev *pdev,
>  		test_reg_bar = data->test_reg_bar;
>  		test->test_reg_bar = test_reg_bar;
>  		test->alignment = data->alignment;
> -		test->irq_type = data->irq_type;
>  	}
>  
>  	init_completion(&test->irq_raised);
> @@ -970,10 +968,6 @@ static int pci_endpoint_test_probe(struct pci_dev *pdev,
>  
>  	pci_set_master(pdev);
>  
> -	ret = pci_endpoint_test_alloc_irq_vectors(test, test->irq_type);
> -	if (ret)
> -		goto err_disable_irq;
> -
>  	for (bar = 0; bar < PCI_STD_NUM_BARS; bar++) {
>  		if (pci_resource_flags(pdev, bar) & IORESOURCE_MEM) {
>  			base = pci_ioremap_bar(pdev, bar);
> @@ -1009,10 +1003,6 @@ static int pci_endpoint_test_probe(struct pci_dev *pdev,
>  		goto err_ida_remove;
>  	}
>  
> -	ret = pci_endpoint_test_request_irq(test);
> -	if (ret)
> -		goto err_kfree_test_name;
> -
>  	pci_endpoint_test_get_capabilities(test);
>  
>  	misc_device = &test->miscdev;
> @@ -1020,7 +1010,7 @@ static int pci_endpoint_test_probe(struct pci_dev *pdev,
>  	misc_device->name = kstrdup(name, GFP_KERNEL);
>  	if (!misc_device->name) {
>  		ret = -ENOMEM;
> -		goto err_release_irq;
> +		goto err_kfree_test_name;
>  	}
>  	misc_device->parent = &pdev->dev;
>  	misc_device->fops = &pci_endpoint_test_fops;
> @@ -1036,9 +1026,6 @@ static int pci_endpoint_test_probe(struct pci_dev *pdev,
>  err_kfree_name:
>  	kfree(misc_device->name);
>  
> -err_release_irq:
> -	pci_endpoint_test_release_irq(test);
> -
>  err_kfree_test_name:
>  	kfree(test->name);
>  
> @@ -1051,8 +1038,6 @@ static int pci_endpoint_test_probe(struct pci_dev *pdev,
>  			pci_iounmap(pdev, test->bar[bar]);
>  	}
>  
> -err_disable_irq:
> -	pci_endpoint_test_free_irq_vectors(test);
>  	pci_release_regions(pdev);
>  
>  err_disable_pdev:
> @@ -1092,23 +1077,19 @@ static void pci_endpoint_test_remove(struct pci_dev *pdev)
>  static const struct pci_endpoint_test_data default_data = {
>  	.test_reg_bar = BAR_0,
>  	.alignment = SZ_4K,
> -	.irq_type = PCITEST_IRQ_TYPE_MSI,
>  };
>  
>  static const struct pci_endpoint_test_data am654_data = {
>  	.test_reg_bar = BAR_2,
>  	.alignment = SZ_64K,
> -	.irq_type = PCITEST_IRQ_TYPE_MSI,
>  };
>  
>  static const struct pci_endpoint_test_data j721e_data = {
>  	.alignment = 256,
> -	.irq_type = PCITEST_IRQ_TYPE_MSI,
>  };
>  
>  static const struct pci_endpoint_test_data rk3588_data = {
>  	.alignment = SZ_64K,
> -	.irq_type = PCITEST_IRQ_TYPE_MSI,
>  };
>  
>  /*
> -- 
> 2.49.0
> 

-- 
மணிவண்ணன் சதாசிவம்

