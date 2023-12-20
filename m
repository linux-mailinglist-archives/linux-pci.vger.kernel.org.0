Return-Path: <linux-pci+bounces-1219-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 179D5819E62
	for <lists+linux-pci@lfdr.de>; Wed, 20 Dec 2023 12:45:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7FFF2860A2
	for <lists+linux-pci@lfdr.de>; Wed, 20 Dec 2023 11:45:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B54EF2137F;
	Wed, 20 Dec 2023 11:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="smh6+6fU"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FBD01DFCD;
	Wed, 20 Dec 2023 11:45:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 713ECC433C7;
	Wed, 20 Dec 2023 11:45:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703072725;
	bh=e3V0eBbLWUL0Jag3MGgZ63p7pyhYoE/YfY9WainlOKg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=smh6+6fUXOQRA4Bkc3O4XtMXmddsTQI9Xx6mCa/miE0KLttTucJTd1cY8Tcjloh0c
	 F7Bl8dnjSrIuDifCn5ESWO6sbvFsJkmkwnLutRnnHVrNU3x2W8TDlFyN6coK478a35
	 BrC0SkbUQcrv5IhoJvcj1WoabuYf9RZyAwa1a3i2H24WEeRUYbYpQp43BNKKuQ2juz
	 ULhbf9PMP9SZg4mWs0+auuZBTBz8U4xU5ZElo/22JFOvNTGHl/0VfZdlkD5HYYXiax
	 zcyYH8v8+dvE114sJls6JG0Q5IEY2Y22SoF1f6AcFg8wqNEGn5SntqdNvhh7M+AUcI
	 P3/dXGmGNKtsg==
Date: Wed, 20 Dec 2023 17:15:10 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH] misc: pci_endpoint_test: Remove usage of the deprecated
 ida_simple_xx() API
Message-ID: <20231220114510.GD3544@thinkpad>
References: <47a30441242c4d5f0e00555cbddd7783350ff1b2.1702966523.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <47a30441242c4d5f0e00555cbddd7783350ff1b2.1702966523.git.christophe.jaillet@wanadoo.fr>

On Tue, Dec 19, 2023 at 07:15:37AM +0100, Christophe JAILLET wrote:
> ida_alloc() and ida_free() should be preferred to the deprecated
> ida_simple_get() and ida_simple_remove().
> 
> This is less verbose.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
>  drivers/misc/pci_endpoint_test.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
> index af519088732d..34124bdce68c 100644
> --- a/drivers/misc/pci_endpoint_test.c
> +++ b/drivers/misc/pci_endpoint_test.c
> @@ -860,7 +860,7 @@ static int pci_endpoint_test_probe(struct pci_dev *pdev,
>  
>  	pci_set_drvdata(pdev, test);
>  
> -	id = ida_simple_get(&pci_endpoint_test_ida, 0, 0, GFP_KERNEL);
> +	id = ida_alloc(&pci_endpoint_test_ida, GFP_KERNEL);
>  	if (id < 0) {
>  		err = id;
>  		dev_err(dev, "Unable to get id\n");
> @@ -907,7 +907,7 @@ static int pci_endpoint_test_probe(struct pci_dev *pdev,
>  	kfree(test->name);
>  
>  err_ida_remove:
> -	ida_simple_remove(&pci_endpoint_test_ida, id);
> +	ida_free(&pci_endpoint_test_ida, id);
>  
>  err_iounmap:
>  	for (bar = 0; bar < PCI_STD_NUM_BARS; bar++) {
> @@ -943,7 +943,7 @@ static void pci_endpoint_test_remove(struct pci_dev *pdev)
>  	misc_deregister(&test->miscdev);
>  	kfree(misc_device->name);
>  	kfree(test->name);
> -	ida_simple_remove(&pci_endpoint_test_ida, id);
> +	ida_free(&pci_endpoint_test_ida, id);
>  	for (bar = 0; bar < PCI_STD_NUM_BARS; bar++) {
>  		if (test->bar[bar])
>  			pci_iounmap(pdev, test->bar[bar]);
> -- 
> 2.34.1
> 

-- 
மணிவண்ணன் சதாசிவம்

