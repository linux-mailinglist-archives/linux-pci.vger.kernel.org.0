Return-Path: <linux-pci+bounces-17130-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 339269D45F7
	for <lists+linux-pci@lfdr.de>; Thu, 21 Nov 2024 03:55:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ACBC8B23E2B
	for <lists+linux-pci@lfdr.de>; Thu, 21 Nov 2024 02:55:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8F5513B584;
	Thu, 21 Nov 2024 02:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yx+QNjpH"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAC69524B4
	for <linux-pci@vger.kernel.org>; Thu, 21 Nov 2024 02:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732157690; cv=none; b=dq+MS4crVrc9PhXmY5JVDQX+WRVY9bFwRMHeLzsQawdlhILgEPPb7zcPoE4jymir/3ubASM9q7XD1BbsYZ66H3t9H40lqa016moZaH2wtOrM4sfci62tsh1dihLsgSrqYsU9u2Ioro1JldPN4OzvYJ29YnqeC6pFn1uGslrtYPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732157690; c=relaxed/simple;
	bh=4ww03cmlXBiyVOibj2SYlxr7RqhPF8+WXUfljLGMbg8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jzyqXj771opCqRYzmTT3/e+LcNTY62liMFQ7yTA2bM/SkFGcGehoWr6xlcDVu3M8FKfmpdEUy7pu/vpqnNHeh+Wgvy+TW7Tk6cNx0C+LvzX9s6S1Vl4nMzFvG4zni3kbylANChwlmBG9KJuRQ2tshAxW0N5BZEVh0ISkfZ0yC+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yx+QNjpH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56551C4CECD;
	Thu, 21 Nov 2024 02:54:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732157690;
	bh=4ww03cmlXBiyVOibj2SYlxr7RqhPF8+WXUfljLGMbg8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Yx+QNjpH/VXV2o2SifOkJxRYJzIOqlONiV2rC3eAXSfT7yDi7mY66KPcFy5iEfour
	 STLliBnv+FK+8CZTxdfl2yZ1o9n3f3w9XgnahqxATsST6Al5oFTJo/CJWjjVK6Hyms
	 Xg9n6vIoqhZoHtK/ZTEABz/wOGnptZHM9K5JP4i3+/78WO8Cp3w553gxpH+FSuc/G+
	 lTrVkropTOKk6CGkx1g5T5uWnmVIn7+lyo/qRTLqSH1XGODZ3x5fZ5JYLKyNhMj7K7
	 EaEzBQiPVFB81qIpVXTvl7jGltKS2RpBX58yHYWvEQHxVvOxN8wX3/vKRUZrhmIQbD
	 K1Nl8+LNczIvA==
Message-ID: <00f1303d-7ab8-4cea-9491-5f689cbc423b@kernel.org>
Date: Thu, 21 Nov 2024 11:54:48 +0900
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] misc: pci_endpoint_test: Add support for capabilities
To: Niklas Cassel <cassel@kernel.org>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Kishon Vijay Abraham I <kishon@kernel.org>
Cc: linux-pci@vger.kernel.org, Frank Li <Frank.Li@nxp.com>
References: <20241120155730.2833836-4-cassel@kernel.org>
 <20241120155730.2833836-6-cassel@kernel.org>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20241120155730.2833836-6-cassel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/21/24 00:57, Niklas Cassel wrote:
> If running pci_endpoint_test.c (host side) against a version of
> pci-epf-test.c (EP side), we will not see any capabilities being set.
> 
> For now, only add the CAP_HAS_ALIGN_ADDR capability.
> 
> If the CAP_HAS_ALIGN_ADDR is set, that means that the EP side supports
> reading/writing to an address without any alignment requirements.
> 
> Thus, if CAP_HAS_ALIGN_ADDR is set, make sure that we do not add any
> specific padding to the buffers that we allocate (which was only made
> in order to get the buffers to satisfy certain alignment requirements).
> 
> Signed-off-by: Niklas Cassel <cassel@kernel.org>
> ---
>  drivers/misc/pci_endpoint_test.c | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
> index 3aaaf47fa4ee..ab2b322410fb 100644
> --- a/drivers/misc/pci_endpoint_test.c
> +++ b/drivers/misc/pci_endpoint_test.c
> @@ -69,6 +69,9 @@
>  #define PCI_ENDPOINT_TEST_FLAGS			0x2c
>  #define FLAG_USE_DMA				BIT(0)
>  
> +#define PCI_ENDPOINT_TEST_CAPS			0x30
> +#define CAP_HAS_ALIGN_ADDR			BIT(0)
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
> +	bool has_align_addr;
> +
> +	caps = pci_endpoint_test_readl(test, PCI_ENDPOINT_TEST_CAPS);
> +
> +	has_align_addr = caps & CAP_HAS_ALIGN_ADDR;
> +	dev_dbg(dev, "CAP_HAS_ALIGN_ADDR: %d\n", has_align_addr);
> +
> +	if (has_align_addr)

Shouldn't this be "if (!has_align_addr)" ?

> +		test->alignment = 0;
> +}
> +
>  static int pci_endpoint_test_probe(struct pci_dev *pdev,
>  				   const struct pci_device_id *ent)
>  {
> @@ -906,6 +925,8 @@ static int pci_endpoint_test_probe(struct pci_dev *pdev,
>  		goto err_kfree_test_name;
>  	}
>  
> +	pci_endpoint_test_get_capabilities(test);
> +
>  	misc_device = &test->miscdev;
>  	misc_device->minor = MISC_DYNAMIC_MINOR;
>  	misc_device->name = kstrdup(name, GFP_KERNEL);


-- 
Damien Le Moal
Western Digital Research

