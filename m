Return-Path: <linux-pci+bounces-9524-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0026591E6F7
	for <lists+linux-pci@lfdr.de>; Mon,  1 Jul 2024 19:54:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B04CC283D6F
	for <lists+linux-pci@lfdr.de>; Mon,  1 Jul 2024 17:54:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A24916EB5E;
	Mon,  1 Jul 2024 17:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RyxT2TMs"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68A4115AAC6;
	Mon,  1 Jul 2024 17:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719856458; cv=none; b=GN617pWG0ubZkm3rIjFOmJjYrLCUFrhqNQHCAI0ZuuQWnEw5LcLtjhKDsVtuRTkKeiUAsz2KGRnUPBPFAxS6xUYCCI6kBuVQuBYbNklmvBe5iYVZzt0wjJdJJHIcfrlK+qFKmMNIaY5UJ7oXEdxHFnPWcvMe07il+ICmKPEwYPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719856458; c=relaxed/simple;
	bh=6mIW1u70/NRimseRE8HhFNsZISu2UuydhcoCDO13GjY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Qp0MqPi6wmUZceZ+7ze7DAzgmvRb0c3KxDernQ8zksKH3wgEUmKrvQQx6nEBkUrabpgolklf+b/pMw3pEtvQJscQrb/8jkzrIDUNNX39YFTrW/2/t93qCCC37UBl30DQbqrVTlfnIi1N4uKcafLCtGlvvVjwPZp/tkKzerEqV2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RyxT2TMs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94921C32781;
	Mon,  1 Jul 2024 17:54:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719856458;
	bh=6mIW1u70/NRimseRE8HhFNsZISu2UuydhcoCDO13GjY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=RyxT2TMstKqfLVcIwEnBjQ8A9xeCzmV0s+khq9h6f5Jha4PgVMehACN7SqDvzjeMR
	 I0RM0svGcedP7zA21w2D3iqrruyVp8pm+eTnAOnwvOYO2AMlcmdBk8lNOcZrBmGhEH
	 XPgJn2C3383VMfJ4lxj9GxVtFhv9ZhU+PnSRDoGX31kosC21752zzI5POlde++bWRf
	 0IQkxZ6mE5oqDcMNz6PAOQOO0kK6EJzF8fCXnSIC045Ux0Ch0TCPRMF/v+U/+/ZUNo
	 4F76HqenSbfTWkiKnnTxprKQyEeO3r+cEn8dXSCf8HRFjLYPQgzpefGeNadt7HxXzL
	 i5liQs5VD7s7A==
Date: Mon, 1 Jul 2024 12:54:15 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Krishna chaitanya chundru <quic_krichai@quicinc.com>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Jingoo Han <jingoohan1@gmail.com>, quic_vbadigan@quicinc.com,
	quic_skananth@quicinc.com, quic_nitegupt@quicinc.com,
	linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 3/7] pci: Change the parent of the platform devices
 for child OF nodes
Message-ID: <20240701175415.GA11601@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240626-qps615-v1-3-2ade7bd91e02@quicinc.com>

"Change the parent" basically says what the C code does.  Can we say
something more specific about what the *purpose* of changing it is?

On Wed, Jun 26, 2024 at 06:07:51PM +0530, Krishna chaitanya chundru wrote:
> Currently the power control driver is child of pci-pci bridge driver,
> this will cause issue when suspend resume is introduced in the pwr
> control driver. If the supply is removed to the endpoint in the

Use "pwrctl" so we can connect them.  Also below.

> power control driver then the config space access initaited by the
> pci-pci bridge driver can cause issues like Timeouts.

s/initaited/initiated/ (or just drop it and say "access by the ...")

> For this reason change the parent to controller from pci-pci bridge.

Add blank line here.

> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
> ---
>  drivers/pci/bus.c         | 5 +++--
>  drivers/pci/pwrctl/core.c | 7 ++++++-
>  2 files changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
> index 3e3517567721..eedab4aabd81 100644
> --- a/drivers/pci/bus.c
> +++ b/drivers/pci/bus.c
> @@ -335,6 +335,7 @@ void __weak pcibios_bus_add_device(struct pci_dev *pdev) { }
>  void pci_bus_add_device(struct pci_dev *dev)
>  {
>  	struct device_node *dn = dev->dev.of_node;
> +	struct pci_host_bridge *host = pci_find_host_bridge(dev->bus);
>  	int retval;
>  
>  	/*
> @@ -356,9 +357,9 @@ void pci_bus_add_device(struct pci_dev *dev)
>  
>  	pci_dev_assign_added(dev, true);
>  
> -	if (pci_is_bridge(dev)) {
> +	if (pci_is_bridge(dev) && host) {
>  		retval = of_platform_populate(dev->dev.of_node, NULL, NULL,
> -					      &dev->dev);
> +					      host->dev.parent);
>  		if (retval)
>  			pci_err(dev, "failed to populate child OF nodes (%d)\n",
>  				retval);
> diff --git a/drivers/pci/pwrctl/core.c b/drivers/pci/pwrctl/core.c
> index feca26ad2f6a..4c0d0f3b15f8 100644
> --- a/drivers/pci/pwrctl/core.c
> +++ b/drivers/pci/pwrctl/core.c
> @@ -10,6 +10,7 @@
>  #include <linux/pci-pwrctl.h>
>  #include <linux/property.h>
>  #include <linux/slab.h>
> +#include "../pci.h"
>  
>  static int pci_pwrctl_notify(struct notifier_block *nb, unsigned long action,
>  			     void *data)
> @@ -64,18 +65,22 @@ static int pci_pwrctl_notify(struct notifier_block *nb, unsigned long action,
>   */
>  int pci_pwrctl_device_set_ready(struct pci_pwrctl *pwrctl)
>  {
> +	struct pci_bus *bus = pci_find_bus(of_get_pci_domain_nr(pwrctl->dev->parent->of_node), 0);
>  	int ret;
>  
>  	if (!pwrctl->dev)
>  		return -ENODEV;
>  
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
> 2.42.0
> 

