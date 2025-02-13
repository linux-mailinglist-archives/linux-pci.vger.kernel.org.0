Return-Path: <linux-pci+bounces-21346-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A9886A34089
	for <lists+linux-pci@lfdr.de>; Thu, 13 Feb 2025 14:41:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 704797A2DC1
	for <lists+linux-pci@lfdr.de>; Thu, 13 Feb 2025 13:40:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16726221721;
	Thu, 13 Feb 2025 13:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LZfXtDQ5"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6A8120B80D
	for <linux-pci@vger.kernel.org>; Thu, 13 Feb 2025 13:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739454078; cv=none; b=Qhf5hxXjJu2IYlW+qWTOqay+Ar65CcEI5TUvOUqP3gFOgxS60NANyI0nP94+VxmRnvlU385cQg5phKiqgVCn7r96VUYf13Mnh6WHFpz5g5DEfe7H88e0htIlDAl0yWJre1+GO4MRDUO0/I4icn3HEs/0CN5q78VwpV5/mEbHOtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739454078; c=relaxed/simple;
	bh=j6YrB5TGg1ZmLL/UTNokQX/55IJabM9jfHGQ9GDUyZM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K20APDMclE4iL5FIGsVhI/iTxyhEMTSr1ERSZ8Ymh/s4pgY79Smi0B+pRpArZ1CWBiTa3TMl30ZPPVVPSe1J5cPgKmOKKYOb3jz9Mb5595QVVSQRDoC6X2g8kl0GVYKkSMxoj+Ax28ryvCThO9wgmlsU6NunTXXxc+oNc4Ky57I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LZfXtDQ5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EA5EC4CED1;
	Thu, 13 Feb 2025 13:41:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739454074;
	bh=j6YrB5TGg1ZmLL/UTNokQX/55IJabM9jfHGQ9GDUyZM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LZfXtDQ5rlTajBgdaT9VydBOblOqHI2ko5pJdGhYEjsLsBRLJJ6DvSTe9UWI8uLw5
	 7wSMVNqdI9UD2/WxZoXoau/+a3Y6NxJPh9YSrEv1Nm8iK8rwz5/roSfmAmkiB1MsIp
	 lCI/WJfAN7VEijhzSILtRuBF5/o3KjY0gV8R/YIj25pUJDVP5XjsVZJUWp6XpYSx9p
	 6pXKmv7fFurbouCbCXsB0asproM0RjEY2/LXh5BFVfBGN5TYHVoZAx6lP7WDxY+APF
	 0iPo5uoXxaEEgbubNBHevlV7A1EAesos7yL2c0oJe8ugpVKvOj79qBx48GBbb4hAkK
	 9aDdkN4lPSa8A==
Date: Thu, 13 Feb 2025 14:41:10 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-pci@vger.kernel.org
Subject: Re: [PATCH] misc: pci_endpoint_test: Fix potential truncation in
 pci_endpoint_test_probe()
Message-ID: <Z632dhmGkqJIaCOA@ryzen>
References: <20250123103127.3581432-2-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250123103127.3581432-2-cassel@kernel.org>

On Thu, Jan 23, 2025 at 11:31:28AM +0100, Niklas Cassel wrote:
> Increase the size of the string buffer to avoid potential truncation in
> pci_endpoint_test_probe().
> 
> This fixes the following build warning when compiling with W=1:
> 
> drivers/misc/pci_endpoint_test.c:29:49: note: directive argument in the range [0, 2147483647]
>    29 | #define DRV_MODULE_NAME                         "pci-endpoint-test"
>       |                                                 ^~~~~~~~~~~~~~~~~~~
> drivers/misc/pci_endpoint_test.c:998:38: note: in expansion of macro ‘DRV_MODULE_NAME’
>   998 |         snprintf(name, sizeof(name), DRV_MODULE_NAME ".%d", id);
>       |                                      ^~~~~~~~~~~~~~~
> drivers/misc/pci_endpoint_test.c:998:9: note: ‘snprintf’ output between 20 and 29 bytes into a destination of size 24
>   998 |         snprintf(name, sizeof(name), DRV_MODULE_NAME ".%d", id);
>       |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> Signed-off-by: Niklas Cassel <cassel@kernel.org>
> ---
>  drivers/misc/pci_endpoint_test.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
> index 8e48a15100f1..b0db94161d31 100644
> --- a/drivers/misc/pci_endpoint_test.c
> +++ b/drivers/misc/pci_endpoint_test.c
> @@ -912,7 +912,7 @@ static int pci_endpoint_test_probe(struct pci_dev *pdev,
>  {
>  	int ret;
>  	int id;
> -	char name[24];
> +	char name[29];
>  	enum pci_barno bar;
>  	void __iomem *base;
>  	struct device *dev = &pdev->dev;
> -- 
> 2.48.1
> 

Gentle ping.


Kind regards,
Niklas

