Return-Path: <linux-pci+bounces-11135-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49E9A945257
	for <lists+linux-pci@lfdr.de>; Thu,  1 Aug 2024 19:56:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D7E31C230BA
	for <lists+linux-pci@lfdr.de>; Thu,  1 Aug 2024 17:56:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB6E11B9B47;
	Thu,  1 Aug 2024 17:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iBtGfO0Q"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAD651B32D9;
	Thu,  1 Aug 2024 17:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722534970; cv=none; b=PP/dBVC5TE5EBqO5PbLsis0tCE6oU/RRcdZxOivbmvJIDNnHloBYd5Lki1mme458t/USKC4UD1TBVAqcuHON6mqUeIMR2TpNLKLA3ee9J4v59wXU8l62vKDLk60onXsRkWuukohpJjpO3H7GWjjJBDviyoumR0mZYwxdJbTrFyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722534970; c=relaxed/simple;
	bh=tvue2mYTfwnEUwml27Tmo8Nu3VBPB0p3/0YXnVpNxyk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pbOCHfKbmalgwSO5o0nXhtxgB2Sltx0s5ify0vRiSCbKvMUwR5ed7LTQHhCXOY8L6su+D0NfIeyVFcVxR+1hjH4T6X/O7ZPcQ2ZVFYlJLBlW1esTxtmaSr3BHGuksuciO4RlQvyM0fdtdgtMU5QEACS0IOhaLoTgHdaVTaoJH+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iBtGfO0Q; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2eeb1051360so80958481fa.0;
        Thu, 01 Aug 2024 10:56:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722534967; x=1723139767; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QrRMVRpNUsdGLYtVeQ+Si89ML1jZN7HWMBFx7Phtrik=;
        b=iBtGfO0QRwOpmsaC71aEx+g3UZaZURyveGgrKo26D7DvUmwLxiaUKjTBaPYtpjwCYp
         0ce8BzDnRWEza4HZuIdx1TxoFbYZadqhdbwvDRJSX+AIeeUn+u9ytWpkBxuBDoFKqu14
         T0KaLy35w/gM2zezXQr770TxRSM/PBDTZgMSFudhxG2PNfesTfitqvJyrxdf0K4DNvFf
         AMeXV2faiurvARavfnbhjCxI9Kg4mJhIIruAot5rnFcO8U2hwih5vC1ECz/MJVdSmodE
         BPLgcXz30I3IRzGuPflqD8iJMayDfV4dnj0m3EGqUow5jJB0Gnezy5GEyxH5T36qhvXc
         nUPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722534967; x=1723139767;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QrRMVRpNUsdGLYtVeQ+Si89ML1jZN7HWMBFx7Phtrik=;
        b=n22IhfOjnefYd4yZhcaAIWYHTSW5l1Alm+BuuYJIPonsVhFkDHm2C0sHJ/WOY94bXd
         J5wD6PL7t29UTstpTkKAJ35zp8itrdbu4Gfhz6pQeyjr+LNKTsnbl/Lh0dLvBKHG1GV8
         BoVWXnRbvbKqUAGZlv7zylO0wuBN1RkAkzhmYEqbeqphtFF4OGwjQgprOpUvYWNftjm2
         hRGwwl5MycXXIMvzErkueb3trViSMK4l0NKLkM+TOHJnVfHcEPgF2E5TS055uKX3tZhi
         JJqHLK0VYoT3TndpO2YZDzxpnojbarjc5aIquEegYFGWlfrJ+jXXorYaKGQHTHPvYze7
         vSgQ==
X-Forwarded-Encrypted: i=1; AJvYcCUMCKFZXYkDoQEoOunqeyqcQHe/0vQhd0TzRc9kVykTZxo8MOnYVznbEvrdD7E/mjJfINHWOmFvWTlBiMI=@vger.kernel.org, AJvYcCVJmWSc+dfhsqFxJgTR0Lspid2vXZdjhlBmdcukgUabb+/wwLQ2T7YXcB/k87vKofs9AnSHtvUwC0J/LWrT@vger.kernel.org, AJvYcCVRdDc4EMbm1Uu87v90YBUiApcqZcRMFRSJszHifm0MO/4WhmKwRN6LND9FnX9Grz+j+HRHqnuVmNtU@vger.kernel.org, AJvYcCVbeAXO9isKRLpKj7QPDdZK8Se/uADih+WGETPvdOUsQsTV4vd0I1/tTF4+qL0G0J/5a6x262UhxpjSM1VY@vger.kernel.org, AJvYcCWg/Q7aPWYwIpSvDVkapi6/0znq7FQP2RugZXNx6NsbUvgw6aUUaKaAZ132SCBsbn3JWJvAVNFNyCdo/tCtZ8g=@vger.kernel.org, AJvYcCX3744FySOLPtS8Xg8pMAK9OFepHlrGxk9w/T2KmW5Y61ZBeMu5XugMs/S1nVnItJiKtU3Om6SNBXy9@vger.kernel.org, AJvYcCXti2eaeI22vUGo8vvAZzgnKpSXE/Wwe+g3z74BA4/6sEGJqFaiFWxcib7FO1OZ6F1Wde41EMBHcwCtQHg=@vger.kernel.org, AJvYcCXz0KbFgY1SgM9H2ppBcPVQqWS4yQnQ1ElaXbeACBpdukgAL48+zB03CjxzhHFzsChAS0D1CigwTc/K@vger.kernel.org
X-Gm-Message-State: AOJu0YyOczApyo9oy2bUzvSBfRYUcUP48IQkcjAK/Vdrcl4o+iLm6hiZ
	ih7Ednczjj4QGhWLa1Ipiv9b/Ff0W0NFG5EilpLJMjrP6h+/mLhj
X-Google-Smtp-Source: AGHT+IHvjEgp8SzrbRoSN/aHtB0pDailmN+501lqd79ClZo8CZfX2mxC+K4sF5JPxDjOtcs/TSF3BQ==
X-Received: by 2002:a2e:9689:0:b0:2ef:2d3a:e70a with SMTP id 38308e7fff4ca-2f15aa93150mr8058061fa.18.1722534966525;
        Thu, 01 Aug 2024 10:56:06 -0700 (PDT)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2f15c431639sm153591fa.92.2024.08.01.10.56.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Aug 2024 10:56:06 -0700 (PDT)
Date: Thu, 1 Aug 2024 20:56:02 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Philipp Stanner <pstanner@redhat.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Damien Le Moal <dlemoal@kernel.org>, 
	Niklas Cassel <cassel@kernel.org>, Giovanni Cabiddu <giovanni.cabiddu@intel.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>, 
	Boris Brezillon <bbrezillon@kernel.org>, Arnaud Ebalard <arno@natisbad.org>, 
	Srujana Challa <schalla@marvell.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Miri Korenblit <miriam.rachel.korenblit@intel.com>, Kalle Valo <kvalo@kernel.org>, Jon Mason <jdmason@kudzu.us>, 
	Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Kevin Cernekee <cernekee@gmail.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, 
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Jie Wang <jie.wang@intel.com>, 
	Adam Guerin <adam.guerin@intel.com>, Shashank Gupta <shashank.gupta@intel.com>, 
	Damian Muszynski <damian.muszynski@intel.com>, Nithin Dabilpuram <ndabilpuram@marvell.com>, 
	Bharat Bhushan <bbhushan2@marvell.com>, Johannes Berg <johannes.berg@intel.com>, 
	Gregory Greenman <gregory.greenman@intel.com>, Emmanuel Grumbach <emmanuel.grumbach@intel.com>, 
	Yedidya Benshimol <yedidya.ben.shimol@intel.com>, Breno Leitao <leitao@debian.org>, 
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, John Ogness <john.ogness@linutronix.de>, 
	Thomas Gleixner <tglx@linutronix.de>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-ide@vger.kernel.org, qat-linux@intel.com, linux-crypto@vger.kernel.org, 
	linux-wireless@vger.kernel.org, ntb@lists.linux.dev, linux-pci@vger.kernel.org, 
	linux-serial@vger.kernel.org, linux-sound@vger.kernel.org
Subject: Re: [PATCH 07/10] ntb: idt: Replace deprecated PCI functions
Message-ID: <gxl6trxfwcjsjbte5pg3334iqxofh2kau4fsfovdptibnng3jl@332tt4vrpo3o>
References: <20240801174608.50592-1-pstanner@redhat.com>
 <20240801174608.50592-8-pstanner@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240801174608.50592-8-pstanner@redhat.com>

Hi Philipp

On Thu, Aug 01, 2024 at 07:46:05PM +0200, Philipp Stanner wrote:
> pcim_iomap_table() and pcim_iomap_regions_request_all() have been
> deprecated by the PCI subsystem in commit e354bb84a4c1 ("PCI: Deprecate
> pcim_iomap_table(), pcim_iomap_regions_request_all()").
> 
> Replace these functions with their successors, pcim_iomap() and
> pcim_request_all_regions()
> 
> Signed-off-by: Philipp Stanner <pstanner@redhat.com>

Looking good to me. Thanks.

Acked-by: Serge Semin <fancer.lancer@gmail.com>

-Serge(y)

> ---
>  drivers/ntb/hw/idt/ntb_hw_idt.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/ntb/hw/idt/ntb_hw_idt.c b/drivers/ntb/hw/idt/ntb_hw_idt.c
> index 48dfb1a69a77..f1b57d51a814 100644
> --- a/drivers/ntb/hw/idt/ntb_hw_idt.c
> +++ b/drivers/ntb/hw/idt/ntb_hw_idt.c
> @@ -2671,15 +2671,20 @@ static int idt_init_pci(struct idt_ntb_dev *ndev)
>  	 */
>  	pci_set_master(pdev);
>  
> -	/* Request all BARs resources and map BAR0 only */
> -	ret = pcim_iomap_regions_request_all(pdev, 1, NTB_NAME);
> +	/* Request all BARs resources */
> +	ret = pcim_request_all_regions(pdev, NTB_NAME);
>  	if (ret != 0) {
>  		dev_err(&pdev->dev, "Failed to request resources\n");
>  		goto err_clear_master;
>  	}
>  
> -	/* Retrieve virtual address of BAR0 - PCI configuration space */
> -	ndev->cfgspc = pcim_iomap_table(pdev)[0];
> +	/* ioremap BAR0 - PCI configuration space */
> +	ndev->cfgspc = pcim_iomap(pdev, 0, 0);
> +	if (!ndev->cfgspc) {
> +		dev_err(&pdev->dev, "Failed to ioremap BAR 0\n");
> +		ret = -ENOMEM;
> +		goto err_clear_master;
> +	}
>  
>  	/* Put the IDT driver data pointer to the PCI-device private pointer */
>  	pci_set_drvdata(pdev, ndev);
> -- 
> 2.45.2
> 

