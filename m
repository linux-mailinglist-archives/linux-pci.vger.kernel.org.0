Return-Path: <linux-pci+bounces-11376-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 11CF2949800
	for <lists+linux-pci@lfdr.de>; Tue,  6 Aug 2024 21:07:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC4B11F2184E
	for <lists+linux-pci@lfdr.de>; Tue,  6 Aug 2024 19:07:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6B7F13C677;
	Tue,  6 Aug 2024 19:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QC8IPl6j"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2EE513B288;
	Tue,  6 Aug 2024 19:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722971225; cv=none; b=D6Gsa7uVFkqFZ5DpFzRPVYHIzHAsdizJgoNVhoW7Cun0NCHPwDBrdaJ8VQ8UN+SNOej6sv+m06EU8SKlncG4a8+IDH6uQJyUHY1gtIY5GTcG2V4nrmyviEXgGcAsQip5+/LDroMG9DWiTKGoW9oiH4aUF31Yt44/oporJxbCSyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722971225; c=relaxed/simple;
	bh=WVKkU+/2pLfBtVPtjXmuMIcG0wlH5uxeowV0c0yZeJE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=pfIZRcKnLVQRtsXLYle3RaSKRnjcCJmrchitVil61oIxkDPF/l5CY5MotPILsXjIfl2Abt35JvKyqcYHj1JVqK5thYF5HDiqYrMmKHpZs7LIpIqxrrGC23kUCpToXd0P053FGuolv7n02bTnXh5nurVsMdp5V3nFBK3wOnUzUMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QC8IPl6j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBC27C4AF10;
	Tue,  6 Aug 2024 19:07:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722971225;
	bh=WVKkU+/2pLfBtVPtjXmuMIcG0wlH5uxeowV0c0yZeJE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=QC8IPl6jpQTAT4L9Qp2WYsconTnPxPImCeRcw9tLpiGmNL1bhtGBiGX/9QOSRnotq
	 1gE/Lp08Zn6AlJ6ud0+3Bb90QOkEj7+H+o0Dwr3sEmryl3+ZFzGrLNsBiJ0bUsw8W0
	 D/WiXEwm327cndUskH0St8fwGWE1gRfDHWwQkU5peeLivHZh1XtgjeAt6YutfwHpNA
	 rRFq++/MkCzOky8iJK5G7rsEWII8Lm6G9zApQAQ+wAK5feQGPoOXx01wEZ7vvndfQb
	 8kl+NUc3u+UUmNeCcJM5VD5ZVI+GN1xBs+Uh2l02iipMxNKOD17e+q0ziEQrSxCk0M
	 PZnbBjuuQSzRA==
Date: Tue, 6 Aug 2024 14:07:02 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Krishna chaitanya chundru <quic_krichai@quicinc.com>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	cros-qcom-dts-watchers@chromium.org,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	andersson@kernel.org, quic_vbadigan@quicinc.com,
	linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/8] PCI: Change the parent to correctly represent
 pcie hierarchy
Message-ID: <20240806190702.GA72614@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240803-qps615-v2-4-9560b7c71369@quicinc.com>

On Sat, Aug 03, 2024 at 08:52:50AM +0530, Krishna chaitanya chundru wrote:
> Currently the pwrctl driver is child of pci-pci bridge driver,
> this will cause issue when suspend resume is introduced in the pwr
> control driver. If the supply is removed to the endpoint in the
> power control driver then the config space access by the
> pci-pci bridge driver can cause issues like Timeouts.

If "pci-pci bridge driver" refers to portdrv, please use "portdrv" to
avoid confusion.

Can you be a little more specific about config accesses by the bridge
driver?  Generally portdrv wouldn't touch devices below the bridge.
It sounds like you've tripped over something here, so you probably
have an example of a timeout.

s/pcie/PCIe/ in subject, although it'd be nice if the whole subject
could be a little more specific.  I don't think pwrctl is directly
part of the PCIe hierarchy, so I don't quite understand what you're
saying there.

> For this reason change the parent to controller from pci-pci bridge.
> 
> Fixes: 4565d2652a37 ("PCI/pwrctl: Add PCI power control core code")

Will need an ack from Bartosz, of course, since he added this.  Moved
from cc: to to: list to make sure he sees this.

> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
> ---
>  drivers/pci/bus.c         | 3 ++-
>  drivers/pci/pwrctl/core.c | 9 ++++++++-
>  2 files changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
> index 55c853686051..15b42f0f588f 100644
> --- a/drivers/pci/bus.c
> +++ b/drivers/pci/bus.c
> @@ -328,6 +328,7 @@ void __weak pcibios_bus_add_device(struct pci_dev *pdev) { }
>   */
>  void pci_bus_add_device(struct pci_dev *dev)
>  {
> +	struct pci_host_bridge *host = pci_find_host_bridge(dev->bus);
>  	struct device_node *dn = dev->dev.of_node;
>  	int retval;
>  
> @@ -352,7 +353,7 @@ void pci_bus_add_device(struct pci_dev *dev)
>  
>  	if (dev_of_node(&dev->dev) && pci_is_bridge(dev)) {
>  		retval = of_platform_populate(dev_of_node(&dev->dev), NULL, NULL,
> -					      &dev->dev);
> +					      host->dev.parent);

I'm not sure host->dev.parent is always valid.  There are
pci_create_root_bus() callers that supply a NULL parent pointer.

>  		if (retval)
>  			pci_err(dev, "failed to populate child OF nodes (%d)\n",
>  				retval);
> diff --git a/drivers/pci/pwrctl/core.c b/drivers/pci/pwrctl/core.c
> index feca26ad2f6a..4f2ffa0b0a5f 100644
> --- a/drivers/pci/pwrctl/core.c
> +++ b/drivers/pci/pwrctl/core.c
> @@ -11,6 +11,8 @@
>  #include <linux/property.h>
>  #include <linux/slab.h>
>  
> +#include "../pci.h"
> +
>  static int pci_pwrctl_notify(struct notifier_block *nb, unsigned long action,
>  			     void *data)
>  {
> @@ -64,18 +66,23 @@ static int pci_pwrctl_notify(struct notifier_block *nb, unsigned long action,
>   */
>  int pci_pwrctl_device_set_ready(struct pci_pwrctl *pwrctl)
>  {
> +	struct pci_bus *bus;
>  	int ret;
>  
>  	if (!pwrctl->dev)
>  		return -ENODEV;
>  
> +	bus = pci_find_bus(of_get_pci_domain_nr(pwrctl->dev->parent->of_node), 0);
> +	if (!bus)
> +		return -ENODEV;
> +
>  	pwrctl->nb.notifier_call = pci_pwrctl_notify;
>  	ret = bus_register_notifier(&pci_bus_type, &pwrctl->nb);
>  	if (ret)
>  		return ret;
>  
>  	pci_lock_rescan_remove();
> -	pci_rescan_bus(to_pci_dev(pwrctl->dev->parent)->bus);
> +	pci_rescan_bus(bus);
>  	pci_unlock_rescan_remove();
>  
>  	return 0;
> 
> -- 
> 2.34.1
> 

