Return-Path: <linux-pci+bounces-1145-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E301817740
	for <lists+linux-pci@lfdr.de>; Mon, 18 Dec 2023 17:19:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A46141C25D5B
	for <lists+linux-pci@lfdr.de>; Mon, 18 Dec 2023 16:19:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4D4A3D557;
	Mon, 18 Dec 2023 16:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lhynny4/"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA8A63A1D0
	for <linux-pci@vger.kernel.org>; Mon, 18 Dec 2023 16:19:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14FC6C433C8;
	Mon, 18 Dec 2023 16:19:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702916349;
	bh=1lukh6nFegyz6tJwQ7rJeaLa1Xr4lxmPSN3YOm58QTY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lhynny4/6923weraKUopn8VyreDl8ZfIWt/OyQWBlOUuJ2tjh7hF/wbZGTAx0/7DR
	 eeCStXSHjNaMBZnZUK+nhJrAvKYXGFm5fSeybpYtKQjGMGWZbJc6ZkO2FUW901MqBm
	 IjRbzcke/qZZ7bttpeDP6Vz3r+zXgdT1NwwXQrcwzeTuVjiiANQRRJoHfdrlPYLCDt
	 uydslAHxV4IaZTH9Dr2igf3+THOMOxqA6u8wpl2tG830S4stAWet7ouYG9yPRob7TZ
	 3084BaFOdGKu+77iXFYPzBneZgehmbgCbHLhdl81XmlaykPAbP6e7Lu00Q9NHDHxWZ
	 oNz+ppbmpXX4g==
Date: Mon, 18 Dec 2023 21:48:55 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Niklas Cassel <nks@flawful.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Niklas Cassel <niklas.cassel@wdc.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH] misc: pci_endpoint_test: Use a unique test pattern for
 each BAR
Message-ID: <20231218161855.GD50521@thinkpad>
References: <20231215105952.1531683-1-nks@flawful.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231215105952.1531683-1-nks@flawful.org>

On Fri, Dec 15, 2023 at 11:59:51AM +0100, Niklas Cassel wrote:
> From: Niklas Cassel <niklas.cassel@wdc.com>
> 
> Use a unique test pattern for each BAR in. This makes it easier to
> detect/debug address translation issues, since a developer can dump
> the backing memory on the EP side, using e.g. devmem, to verify that
> the address translation for each BAR is actually correct.
> 
> Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
>  drivers/misc/pci_endpoint_test.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
> index a765a05f0c64..7ac1922475af 100644
> --- a/drivers/misc/pci_endpoint_test.c
> +++ b/drivers/misc/pci_endpoint_test.c
> @@ -263,6 +263,15 @@ static bool pci_endpoint_test_request_irq(struct pci_endpoint_test *test)
>  	return false;
>  }
>  
> +static const u32 bar_test_pattern[] = {
> +	0xA0A0A0A0,
> +	0xA1A1A1A1,
> +	0xA2A2A2A2,
> +	0xA3A3A3A3,
> +	0xA4A4A4A4,
> +	0xA5A5A5A5,
> +};
> +
>  static bool pci_endpoint_test_bar(struct pci_endpoint_test *test,
>  				  enum pci_barno barno)
>  {
> @@ -280,11 +289,12 @@ static bool pci_endpoint_test_bar(struct pci_endpoint_test *test,
>  		size = 0x4;
>  
>  	for (j = 0; j < size; j += 4)
> -		pci_endpoint_test_bar_writel(test, barno, j, 0xA0A0A0A0);
> +		pci_endpoint_test_bar_writel(test, barno, j,
> +					     bar_test_pattern[barno]);
>  
>  	for (j = 0; j < size; j += 4) {
>  		val = pci_endpoint_test_bar_readl(test, barno, j);
> -		if (val != 0xA0A0A0A0)
> +		if (val != bar_test_pattern[barno])
>  			return false;
>  	}
>  
> -- 
> 2.43.0
> 

-- 
மணிவண்ணன் சதாசிவம்

