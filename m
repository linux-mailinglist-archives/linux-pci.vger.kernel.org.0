Return-Path: <linux-pci+bounces-9813-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CB425927944
	for <lists+linux-pci@lfdr.de>; Thu,  4 Jul 2024 16:50:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A31D1F21666
	for <lists+linux-pci@lfdr.de>; Thu,  4 Jul 2024 14:50:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5707B1B011E;
	Thu,  4 Jul 2024 14:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WWIlscDS"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 951791A3BDA;
	Thu,  4 Jul 2024 14:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720104633; cv=none; b=cRuQzcOk3X0wCeLp008uZBhOAGUSsFC0TyLkb28zF1YfsZxYEB32gXFDvOnPrsbhTDOL1qQsN7ZsSIptXvC4F09hjsSxdHG3ff1Qw0u1VKOjXItrDSoW2Kv6I8j1xXwtpyUIOOYaXecgtvU4hiyX7bpfE4jC1HeOAUw948Yxi3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720104633; c=relaxed/simple;
	bh=si/MNdaKQ5RN0Ou8FI/P3JxXnTW7I6dza5KbazBRGp8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UDkG1lK4allKOMnQd26Ep+/UFOc9IaX2keoFbRwov/cGlN6f26GRN3wnAcFedVJ8K4Mk7RHmbiz7Q3fivJbPVqJ5f3rGV5fdnasN2za0XkknBtgpag+JHWGiJ8yHdKE6tmuXQox3Lpw+0OKzC9OR889rAZ8PsU7tefk6Ecd/56s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WWIlscDS; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-424ad289949so4817585e9.2;
        Thu, 04 Jul 2024 07:50:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720104630; x=1720709430; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gyv5bEBx0v3sKJzqVfj3oAivspk6SkN1NANENmR71Mc=;
        b=WWIlscDStiJQ/0wgHrJad2+53aJ8fxO8ngvVgelAAQn6Nh+ZCKMoAWy1/HQNzjVpp8
         OPsi2k9xigMWB8mhDs6V6MApDWsSKU9q5cO5+3oYJT1fcE+wYHgySfWpIuQg/K/rRSnE
         2XEiZC2KtnztAIQqKxnMO/Dgaxwt9ptthuvPiFSj3+bJzqKN6SpbWBNpTPO+NnvdGcNV
         dBgqwguZDMC17e1iqb05gyitFojld7Huw3gexFOz2acNjKW1P5YDYBJzrsdj05oFVJMG
         714i29mcxzxdHLCvrEAfbY7BkJwLLeFYnzdS4tQ3nC6cwD7Ayh0RohZmc1JLK1Ic5toa
         nyBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720104630; x=1720709430;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gyv5bEBx0v3sKJzqVfj3oAivspk6SkN1NANENmR71Mc=;
        b=U7C0kjUbmUcKPeYVGqgyBG9BiE5dLSdcYWitDLO6kfFRPzZQEk7vuh+0bhDBTxaA8B
         dxgjyMyMB/rKS+/EW0jvKk0ShOBAIOcCo0e4V5etquNViZZZniIcPfsePvvvL0esMI6t
         O0sIcjqoDHyj62eHTJxKGeeey9HV+Uu1i3mTxciN8r+gYAKTaIsEe1R/a4waEd2YRfh7
         MtUEoJ5gqI8UKHP+reGPxAsRZtbJzJwoM4kngbNis3BGKpXtcPyVVxX7fXcC1AJR/yAY
         6nplHwaCBrOfJKbrPp25JIlEN0mPoQuSgNjxwIH4gC4PoJou1kF+UN5xwEFVOhEl3crT
         oO9Q==
X-Forwarded-Encrypted: i=1; AJvYcCVANrfPx+aKjePQtgh5TrCCVeoK8QdSUNU05l/K0tiJ1lOqbc9N6oK+N8OGjYAN7TR7cmQnjYEimJRECK0Cl5TlLGT69sny/jHf3bOKbezFJ9E7tFixpPvhTx3YoVTMe5r8OfOeSsIo
X-Gm-Message-State: AOJu0YzOBW2KovuKtwxD0ya7Ul8b4gJ0jWaHnWY3ntF+vFAR128st+Ro
	tIgaI8EQnLv+Lh+rUNpD+7OqDK91lRsPkQ1WEyrhvnzxFzGN0g2p4FsrVi0T
X-Google-Smtp-Source: AGHT+IEDvX2K6Si8LB0HPSmGFjaJY3UNx5iXdACTQu0hQsI176AMqQsKKaL3/Y9mkhasPuEsE6RGAA==
X-Received: by 2002:a7b:c056:0:b0:426:491e:6252 with SMTP id 5b1f17b1804b1-4264a3d7676mr13617585e9.11.1720104629665;
        Thu, 04 Jul 2024 07:50:29 -0700 (PDT)
Received: from [192.168.0.31] (84-115-213-37.cable.dynamic.surfer.at. [84.115.213.37])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4264a283577sm27295385e9.44.2024.07.04.07.50.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jul 2024 07:50:28 -0700 (PDT)
Message-ID: <7a8d4e4d-4e2b-48a6-b8e2-d23460154777@gmail.com>
Date: Thu, 4 Jul 2024 16:50:26 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: kirin: fix memory leak in kirin_pcie_parse_port()
To: Xiaowei Song <songxiaowei@hisilicon.com>,
 Binghui Wang <wangbinghui@hisilicon.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Linus Walleij <linus.walleij@linaro.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240609-pcie-kirin-memleak-v1-1-62b45b879576@gmail.com>
Content-Language: en-US, de-AT
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
In-Reply-To: <20240609-pcie-kirin-memleak-v1-1-62b45b879576@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 09/06/2024 12:56, Javier Carrasco wrote:
> The conversion of this file to use the agnostic GPIO API has introduced
> a new early return where the refcounts of two device nodes (parent and
> child) are not decremented.
> 
> Given that the device nodes are not required outside the loops where
> they are used, and to avoid potential bugs every time a new error path
> is introduced to the loop, the _scoped() versions of the macros have
> been applied. The bug was introduced recently, and the fix is not
> relevant for old stable kernels that might not support the scoped()
> variant.
> 
> Fixes: 1d38f9d89f85 ("PCI: kirin: Convert to use agnostic GPIO API")
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
> ---
> This bug was found while analyzing the code and I don't have hardware to
> validate it beyond compilation and static analysis. Any test with real
> hardware to make sure there are no regressions is always welcome.
> 
> The dev_err() messages have not been converted into dev_err_probe() to
> keep the current format, but I am open to convert them if preferred.
> ---
>  drivers/pci/controller/dwc/pcie-kirin.c | 21 ++++++---------------
>  1 file changed, 6 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-kirin.c b/drivers/pci/controller/dwc/pcie-kirin.c
> index d1f54f188e71..0a29136491b8 100644
> --- a/drivers/pci/controller/dwc/pcie-kirin.c
> +++ b/drivers/pci/controller/dwc/pcie-kirin.c
> @@ -403,11 +403,10 @@ static int kirin_pcie_parse_port(struct kirin_pcie *pcie,
>  				 struct device_node *node)
>  {
>  	struct device *dev = &pdev->dev;
> -	struct device_node *parent, *child;
>  	int ret, slot, i;
>  
> -	for_each_available_child_of_node(node, parent) {
> -		for_each_available_child_of_node(parent, child) {
> +	for_each_available_child_of_node_scoped(node, parent) {
> +		for_each_available_child_of_node_scoped(parent, child) {
>  			i = pcie->num_slots;
>  
>  			pcie->id_reset_gpio[i] = devm_fwnode_gpiod_get_index(dev,
> @@ -424,14 +423,13 @@ static int kirin_pcie_parse_port(struct kirin_pcie *pcie,
>  			pcie->num_slots++;
>  			if (pcie->num_slots > MAX_PCI_SLOTS) {
>  				dev_err(dev, "Too many PCI slots!\n");
> -				ret = -EINVAL;
> -				goto put_node;
> +				return -EINVAL;
>  			}
>  
>  			ret = of_pci_get_devfn(child);
>  			if (ret < 0) {
>  				dev_err(dev, "failed to parse devfn: %d\n", ret);
> -				goto put_node;
> +				return ret;
>  			}
>  
>  			slot = PCI_SLOT(ret);
> @@ -439,10 +437,8 @@ static int kirin_pcie_parse_port(struct kirin_pcie *pcie,
>  			pcie->reset_names[i] = devm_kasprintf(dev, GFP_KERNEL,
>  							      "pcie_perst_%d",
>  							      slot);
> -			if (!pcie->reset_names[i]) {
> -				ret = -ENOMEM;
> -				goto put_node;
> -			}
> +			if (!pcie->reset_names[i])
> +				return -ENOMEM;
>  
>  			gpiod_set_consumer_name(pcie->id_reset_gpio[i],
>  						pcie->reset_names[i]);
> @@ -450,11 +446,6 @@ static int kirin_pcie_parse_port(struct kirin_pcie *pcie,
>  	}
>  
>  	return 0;
> -
> -put_node:
> -	of_node_put(child);
> -	of_node_put(parent);
> -	return ret;
>  }
>  
>  static long kirin_pcie_get_resource(struct kirin_pcie *kirin_pcie,
> 
> ---
> base-commit: d35b2284e966c0bef3e2182a5c5ea02177dd32e4
> change-id: 20240609-pcie-kirin-memleak-18c83a31d111
> 
> Best regards,


Hi, has this patch been applied anywhere? I couldn't find it in
linux-next and pci/next.

Best regards,
Javier Carrasco

