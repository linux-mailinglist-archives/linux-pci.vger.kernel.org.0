Return-Path: <linux-pci+bounces-11849-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9873E957CE4
	for <lists+linux-pci@lfdr.de>; Tue, 20 Aug 2024 07:52:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 21B26B20A14
	for <lists+linux-pci@lfdr.de>; Tue, 20 Aug 2024 05:52:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30A3E43AA8;
	Tue, 20 Aug 2024 05:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TilFGu0W"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 857741BF2B
	for <linux-pci@vger.kernel.org>; Tue, 20 Aug 2024 05:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724133138; cv=none; b=XoXWjdVIvXGymgcKQ7Ky5oDxs1wxtOz0frnScalaOb1EetQPgI2sCD+RQE8CYcRFsHy2RigbXL+J+Hz3ntn7QSu7DJe7hrLOvxWx+RsNGfTxoR8twt9NVye/1m7qBlNEv47J22TqKdmNaQaFxiIRratqgaG5eFgGM60kp20rkpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724133138; c=relaxed/simple;
	bh=DLK5ItQpzxghqBx4flWmDJes7nJFtU1awddB31t1t/g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z3LqHIbAd+RFf3GpIUIb3ZgdcysmsI39rMlKXlH8PpiF+veJyIMzfu6eRbrkLjUT2EOwqfSwmaRqqSkqdBtAB9B4YRvXfx93giroDx45SLJofsh+VUNFzybRYf433qqJyjjp1+0nm5nsrM0hMBLpqF4khEShOhi0CgIXCoaBkPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TilFGu0W; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-713f3b4c9f7so1360638b3a.2
        for <linux-pci@vger.kernel.org>; Mon, 19 Aug 2024 22:52:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724133136; x=1724737936; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=boJ5GhilqsNI0J+v1vrM4G45uO2RgryBQBYvfmNmTfE=;
        b=TilFGu0WCCzRLw4uqCpcjYTiQQnlv3rY+YsTXrIYWSk8sthig2wzwIX1Xs3rtOrXOr
         3msEFRKBCDYyALNbG4pMkKHSh83c1lE/dCah2avh22j7/pdFMt4tKVVLOY+q6Z6lZdm6
         fllTCVK4d1KwYB7iMYMuLh6AhytjXXwRN1ES//TTPf36IOwQVhPvPOB25MaW0W16Ks0g
         dnt2wQ5n6P2yH2cueA4nixhvmnxgyfaGFNr0ONO1vFa2GhJ0FYtdMH9lcmXTz8mujMc1
         lDqIxZ6jiTKg6Zj1HP859reM2TFNtQqOsGfc6z0PveqPW4yO4qVMwUYspBPskYOSYBjx
         z5Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724133136; x=1724737936;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=boJ5GhilqsNI0J+v1vrM4G45uO2RgryBQBYvfmNmTfE=;
        b=Ko80H61n5tybrM8HvhT/9yjBXq/mlYMfnl07vX/ENd1x9jgZ6nkt5da4vZdMa6NVoy
         HCYxVmt72FpuD+L/CNbJMtpYR8VicpMqhnWRSGteIZOEhZqgqw4zElNSg67qOaesD4Tc
         LPjYtUO9S02mZ/gLFlYwinP094faFI2MHnmohupJVOMtfk9zI534f3G+LSKrzDdSjhLi
         Dxg2AsSLiqahkYEY15x+IjEnwhNCMcV/bcsHGFZZcuzO5hFgVJM93Tbvk06v+YxlGbWg
         XMPlVLsPAzUrvXBnxqtPn09uJyTBJR8PxyscGNOIoanzlKfjJjhgngTabTbPMWIWUWoa
         QYqw==
X-Forwarded-Encrypted: i=1; AJvYcCXieElGhUWsIhGh+uy3f0L3tDOb/Cf3xu/q14oUfF3O0p106poFtRG3yGvcFsuwH1XSuUO0CKLODWk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZXBgVi+uCh0DMSyTqbfwdaRxhJJtZ+FedbkoM6hT+rXmRdwQ+
	qQA6/ElgoTlT7FYupe0ajSz8jKAhW5gvJf/k+s6X5rh11oz3dKohdQHBFo/uBQ==
X-Google-Smtp-Source: AGHT+IExg7cB/Xy0vOL//UAkuMnPPxBv49gmpCMa8JbsqU5untaUwshPv3OFJbbDot/5OFyk9/K5YA==
X-Received: by 2002:a05:6a20:2d22:b0:1bd:1e06:9db4 with SMTP id adf61e73a8af0-1c904f88a2emr17776636637.19.1724133135685;
        Mon, 19 Aug 2024 22:52:15 -0700 (PDT)
Received: from thinkpad ([120.60.128.138])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-201f02faa03sm71137595ad.19.2024.08.19.22.52.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 22:52:15 -0700 (PDT)
Date: Tue, 20 Aug 2024 11:22:08 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Rick Wertenbroek <rick.wertenbroek@gmail.com>
Cc: rick.wertenbroek@heig-vd.ch, dlemoal@kernel.org,
	alberto.dassatti@heig-vd.ch,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Niklas Cassel <cassel@kernel.org>, Frank Li <Frank.Li@nxp.com>,
	Lars-Peter Clausen <lars@metafoo.de>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] PCI: endpoint: pci-epf-test: Move DMA check into
 read/write/copy functions
Message-ID: <20240820055208.g6iorjl4uhl2jq45@thinkpad>
References: <20240819120112.23563-1-rick.wertenbroek@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240819120112.23563-1-rick.wertenbroek@gmail.com>

On Mon, Aug 19, 2024 at 02:01:10PM +0200, Rick Wertenbroek wrote:
> The pci-epf-test PCI endpoint function /drivers/pci/endpoint/function/pci-epf_test.c
> is meant to be used in a PCI endpoint device inside a host computer with
> the host side driver: /drivers/misc/pci_endpoint_test.c.
> 

s/inside/connected to

> The host side driver can request read/write/copy transactions from the
> endpoint function and expects an IRQ from the endpoint function once
> the read/write/copy transaction is finished. These can be issued with or
> without DMA enabled. If the host side driver requests a read/write/copy
> transaction with DMA enabled and the endpoint function does not support
> DMA, the endpoint would only print an error message and wait for further
> commands without sending an IRQ because pci_epf_test_raise_irq() is
> skipped in pci_epf_test_cmd_handler(). This results in the host side
> driver hanging indefinitely waiting for the IRQ.
> 

TBH, it doesn't make sense to control the endpoint DMA from host. Host should
just issue the transfer command, and let the endpoint use DMA or memcpy based on
its capability.

> Move the DMA check into the pci_epf_test_read()/write()/copy() functions
> so that they report a transfer (IO) error and that pci_epf_test_raise_irq()
> is called when a transfer with DMA is requested, even if unsupported.
> 
> The host side driver will no longer hang but report an error on transfer
> (printing "NOT OKAY") thanks to the checksum because no data was moved.
> 
> Signed-off-by: Rick Wertenbroek <rick.wertenbroek@gmail.com>
> ---
>  drivers/pci/endpoint/functions/pci-epf-test.c | 29 +++++++++++++++----
>  1 file changed, 23 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
> index 7c2ed6eae53a..ec0f79383521 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-test.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-test.c
> @@ -314,6 +314,17 @@ static void pci_epf_test_print_rate(struct pci_epf_test *epf_test,
>  		 (u64)ts.tv_sec, (u32)ts.tv_nsec, rate);
>  }
>  
> +static int pci_epf_test_check_dma(struct pci_epf_test *epf_test,
> +				   struct pci_epf_test_reg *reg)
> +{
> +	if ((READ_ONCE(reg->flags) & FLAG_USE_DMA) &&
> +	    !epf_test->dma_supported) {
> +		dev_err(&epf_test->epf->dev, "DMA transfer not supported\n");
> +		return -EIO;
> +	}
> +	return 0;
> +}
> +
>  static void pci_epf_test_copy(struct pci_epf_test *epf_test,
>  			      struct pci_epf_test_reg *reg)
>  {
> @@ -327,6 +338,10 @@ static void pci_epf_test_copy(struct pci_epf_test *epf_test,
>  	struct device *dev = &epf->dev;
>  	struct pci_epc *epc = epf->epc;
>  
> +	ret = pci_epf_test_check_dma(epf_test, reg);
> +	if (ret)
> +		goto err;
> +
>  	src_addr = pci_epc_mem_alloc_addr(epc, &src_phys_addr, reg->size);
>  	if (!src_addr) {
>  		dev_err(dev, "Failed to allocate source address\n");
> @@ -423,6 +438,10 @@ static void pci_epf_test_read(struct pci_epf_test *epf_test,
>  	struct pci_epc *epc = epf->epc;
>  	struct device *dma_dev = epf->epc->dev.parent;
>  
> +	ret = pci_epf_test_check_dma(epf_test, reg);
> +	if (ret)
> +		goto err;
> +
>  	src_addr = pci_epc_mem_alloc_addr(epc, &phys_addr, reg->size);
>  	if (!src_addr) {
>  		dev_err(dev, "Failed to allocate address\n");
> @@ -507,6 +526,10 @@ static void pci_epf_test_write(struct pci_epf_test *epf_test,
>  	struct pci_epc *epc = epf->epc;
>  	struct device *dma_dev = epf->epc->dev.parent;
>  
> +	ret = pci_epf_test_check_dma(epf_test, reg);
> +	if (ret)
> +		goto err;
> +
>  	dst_addr = pci_epc_mem_alloc_addr(epc, &phys_addr, reg->size);
>  	if (!dst_addr) {
>  		dev_err(dev, "Failed to allocate address\n");
> @@ -647,12 +670,6 @@ static void pci_epf_test_cmd_handler(struct work_struct *work)
>  	WRITE_ONCE(reg->command, 0);
>  	WRITE_ONCE(reg->status, 0);
>  
> -	if ((READ_ONCE(reg->flags) & FLAG_USE_DMA) &&
> -	    !epf_test->dma_supported) {
> -		dev_err(dev, "Cannot transfer data using DMA\n");
> -		goto reset_handler;

Why can't you just set the status and trigger the IRQ here itself? This avoids
duplicating the check inside each command handler.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

