Return-Path: <linux-pci+bounces-17172-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 614129D50DF
	for <lists+linux-pci@lfdr.de>; Thu, 21 Nov 2024 17:46:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16D591F22EFD
	for <lists+linux-pci@lfdr.de>; Thu, 21 Nov 2024 16:46:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E720118A944;
	Thu, 21 Nov 2024 16:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aCqQ3o25"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8C2D130E27;
	Thu, 21 Nov 2024 16:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732207610; cv=none; b=a6/hAk84utHqg5Mo6f/3+G++C8ijcr+QMWx8n6LIRNWF30rgxwVUyMxnt6oaMsc9OuyR+zDwPNu//P6t9myQvC9JeyfXC4DIF/G9JQ4YzvzYmYZu1s9KZxPRhojkcQeX7+DF51enTIurKqof1HhgWBM9LmFxiCGn3PxvcIS71Po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732207610; c=relaxed/simple;
	bh=fTV7N3XK38wOcga7Asc8Yj7zbLcQNsiiS8PEJTraF5s=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=HKMiyVW0YVJvB6eYu5sRxOccNgBSLiZKJyvIVrBoOHCXScq3ZW89cAbJuq4kAGnVaOKheJO9+jduW5Q2mY3daoIcqKIP3RC7LPq7lQKFQ63n6N11TSlfTe4EY9Cbpmz6sfKesO8TWx5ILfznspQWhy99w/aRx9cEMsdyF7UhSdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aCqQ3o25; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1274BC4CECC;
	Thu, 21 Nov 2024 16:46:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732207610;
	bh=fTV7N3XK38wOcga7Asc8Yj7zbLcQNsiiS8PEJTraF5s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=aCqQ3o250uicq6U7i22m1xLP1NvfMLncxBVdHciwiiuGr07OJBeeLn7KeSTkgRvAz
	 KlvMCLVZnacSHk2kh/qu3dHJBRvTcYCpiNjnNx0xUOo8Zfk0I5rdBeyCLiiZaVwUcb
	 udXET/8Tx2Tm5cNMEoYZfrPmdlYwbZ3uNe1uOn1W1lEbadB/trzThVA9cWMgWEjXrS
	 AuZtCflFCN6dMrf833tRfKA5IMRyT5yRzDG5Yqq55VLN0Z9nvnh4tifVXmBa8y8MVv
	 pnf+DZkzFPN8bpGIdJkgsMN5IJUcSH1a39MoH2flnykN/Mp1rQSMt1LaeIJjZAh6AQ
	 +vkHXXrLG0Epw==
Date: Thu, 21 Nov 2024 10:46:48 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Chen-Yu Tsai <wenst@chromium.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, Klara Modin <klarasmodin@gmail.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	stable+noautosel@kernel.org, Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>, devicetree@vger.kernel.org
Subject: Re: [PATCH] PCI/pwrctl: Do not assume device node presence
Message-ID: <20241121164648.GA2387727@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241121094020.3679787-1-wenst@chromium.org>

[+cc OF folks]

On Thu, Nov 21, 2024 at 05:40:19PM +0800, Chen-Yu Tsai wrote:
> A PCI device normally does not have a device node, since the bus is
> fully enumerable. Assuming that a device node is presence is likely
> bad.

> The newly added pwrctl code assumes such and crashes with a NULL
> pointer dereference.

> Besides that, of_find_device_by_node(NULL)
> is likely going to return some random device.

I thought this sounded implausible, but after looking at the code, I
think you're right, because bus_find_device() will use
device_match_of_node(), which decides the device matches if
"dev->of_node == np" (where "np" is NULL in this case).

I'm sure many devices will have "dev->of_node == NULL", so it does
seem like of_find_device_by_node(NULL) will return the first one it
finds.

This seems ... pretty janky and unexpected to me, but it's been this
way for years, so maybe it's safe?  Cc'ing the OF folks just in case.

> Reported-by: Klara Modin <klarasmodin@gmail.com>
> Closes: https://lore.kernel.org/linux-pci/a7b8f84d-efa6-490c-8594-84c1de9a7031@gmail.com/
> Fixes: cc70852b0962 ("PCI/pwrctl: Ensure that pwrctl drivers are probed before PCI client drivers")
> Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Cc: Krzysztof Wilczyński <kwilczynski@kernel.org>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> Cc: stable+noautosel@kernel.org         # Depends on power supply check
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> ---
>  drivers/pci/bus.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
> index 98910bc0fcc4..eca72e0c3b6c 100644
> --- a/drivers/pci/bus.c
> +++ b/drivers/pci/bus.c
> @@ -405,7 +405,7 @@ void pci_bus_add_device(struct pci_dev *dev)
>  	 * before PCI client drivers.
>  	 */
>  	pdev = of_find_device_by_node(dn);
> -	if (pdev && of_pci_supply_present(dn)) {
> +	if (dn && pdev && of_pci_supply_present(dn)) {

Thanks for this fix.  Krzysztof restored the NULL pointer check in
of_pci_supply_present(), so of_pci_supply_present(NULL) will return
false, which should also solve this problem.

If of_find_device_by_node(NULL) returned NULL, we wouldn't need this,
but for now I guess we do.

>  		if (!device_link_add(&dev->dev, &pdev->dev,
>  				     DL_FLAG_AUTOREMOVE_CONSUMER))
>  			pci_err(dev, "failed to add device link to power control device %s\n",
> -- 
> 2.47.0.338.g60cca15819-goog
> 

