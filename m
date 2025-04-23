Return-Path: <linux-pci+bounces-26579-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EEC5A9964D
	for <lists+linux-pci@lfdr.de>; Wed, 23 Apr 2025 19:17:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDB8E5A701C
	for <lists+linux-pci@lfdr.de>; Wed, 23 Apr 2025 17:17:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F14D228A3F2;
	Wed, 23 Apr 2025 17:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QxPnZ76B"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD0E82857C3;
	Wed, 23 Apr 2025 17:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745428637; cv=none; b=GsA/7WTDPFttdKDdwYihZMOEhqtEUQi0ymiqYyclh1+Or0M+pZNS/hol7QiFgKs2any+DgT6di908PyyZ2TNMXM6y4WGMz7LUWICfVPxBAijpqHRYWlfQJ8omAjgEcIVFG6WE9CUANB44JnlNreWdO/Ex+rJXocnynBrTBbeSQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745428637; c=relaxed/simple;
	bh=5zuLKKZD6t7o07tEGhpoSHITV1456s45wx0bf1ltqFY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Bu003cpWzRvLO6FmuyfPVYMrkfuIrCJFCifcauCDpqzNmFy7UQHAozKosDK67AuMfFmToNjxfjBEpaP53sP4iCgGFMh/oRGDQQFjKUwgsIPKQ0HtR9UZ9e3W/1Qnh/6/kjC431Uo/2wJvu8pdTYl559y5KR3Zbj0q7QmLVEY2N0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QxPnZ76B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F12F3C4CEE2;
	Wed, 23 Apr 2025 17:17:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745428637;
	bh=5zuLKKZD6t7o07tEGhpoSHITV1456s45wx0bf1ltqFY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=QxPnZ76Bip0N0EzbDxLFq45byCvtqYqWbORH1JnPdt3SM0Q1yn8SRPrsr5JwCT8MX
	 yzG2x3Rsg/5ZMowmZAiXcEetxAaDmRRD+DqMmN7eawirBaL12ETTQLq6Hdr6GjOZWu
	 XT3sSvEVKKOZ6YSqP6isJEKsRO0lMWp+pqng57bRI6x4KQ4eUFw2KPW/avjtGqGGWa
	 36JN6n2NcmrT3LqSvKXMEkN7mWsj+yFq4oIphytGaAfAsqbaz2WMXldmidYKxBCvzQ
	 mP1Zy7n8BGLdGsCmJEeWjbs1NEEW6QaVH2ehHmz2fGmdx4ZGeFKMPRJJdrB55eaO+I
	 fm6TIGtoIPbCA==
Date: Wed, 23 Apr 2025 12:17:15 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org, quic_mrana@quicinc.com,
	quic_vbadigan@quicinc.com, quic_ramkri@quicinc.com,
	quic_vpernami@quicinc.com,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Danilo Krummrich <dakr@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, Niklas Cassel <cassel@kernel.org>
Subject: Re: [PATCH] PCI: qcom: Implement shutdown() callback
Message-ID: <20250423171715.GA430351@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250401-shutdown-v1-1-f699859403ae@oss.qualcomm.com>

[+cc Greg, Rafael, Danilo for driver model .shutdown() question]
[+cc Heiner et al for related conversation at
https://lore.kernel.org/r/20250415095335.506266-2-cassel@kernel.org]

On Tue, Apr 01, 2025 at 04:51:37PM +0530, Krishna Chaitanya Chundru wrote:
> From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> 
> PCIe host controller drivers are supposed to properly remove the
> endpoint drivers and release the resources during host shutdown/reboot
> to avoid issues like smmu errors, NOC errors, etc.

The effect of this patch is:

    .shutdown()
  +   qcom_pcie_shutdown
  +     dw_pcie_host_deinit
  +       pci_stop_root_bus     # release all drivers of downstream pci_devs
  +       pci_remove_root_bus   # remove all downstream pci_devs

I'm not sure about removing all these drivers in the .shutdown() path.
The generic .shutdown() doc is "quiesce the device" [1], and my
current interpretation for PCI is that it should disable DMA and
interrupts from the device [2].

If PCI host controller drivers are supposed to remove all downstream
drivers and devices in .shutdown(), they're all broken because that's
currently only done in .remove() (and not even all of those).

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/include/linux/device/driver.h?id=v6.14#n73
[2] https://lore.kernel.org/all/61f70fd6-52fd-da07-ce73-303f95132131@codeaurora.org/

> So, stop and remove the root bus and its associated devices and release
> its resources during system shutdown to ensure a clean shutdown/reboot.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> ---
>  drivers/pci/controller/dwc/pcie-qcom.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index e4d3366ead1f9198693e6f9da4ae1dc40a3a0519..926811a0e63eb3663c1f41dc598659993546d832 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -1754,6 +1754,16 @@ static int qcom_pcie_probe(struct platform_device *pdev)
>  	return ret;
>  }
>  
> +static void qcom_pcie_shutdown(struct platform_device *pdev)
> +{
> +	struct qcom_pcie *pcie = platform_get_drvdata(pdev);
> +
> +	dw_pcie_host_deinit(&pcie->pci->pp);
> +	phy_exit(pcie->phy);
> +	pm_runtime_put(&pdev->dev);
> +	pm_runtime_disable(&pdev->dev);
> +}
> +
>  static int qcom_pcie_suspend_noirq(struct device *dev)
>  {
>  	struct qcom_pcie *pcie = dev_get_drvdata(dev);
> @@ -1890,5 +1900,6 @@ static struct platform_driver qcom_pcie_driver = {
>  		.pm = &qcom_pcie_pm_ops,
>  		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
>  	},
> +	.shutdown = qcom_pcie_shutdown,
>  };
>  builtin_platform_driver(qcom_pcie_driver);

