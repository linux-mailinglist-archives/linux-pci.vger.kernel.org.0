Return-Path: <linux-pci+bounces-19413-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E8B52A040B4
	for <lists+linux-pci@lfdr.de>; Tue,  7 Jan 2025 14:19:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C59B3A2A6C
	for <lists+linux-pci@lfdr.de>; Tue,  7 Jan 2025 13:19:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C931D1E0DE5;
	Tue,  7 Jan 2025 13:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n3FXqKEn"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9971E19ABCE;
	Tue,  7 Jan 2025 13:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736255962; cv=none; b=AlhSsUgO2SLXPCTDxRQD3VNviczxVsOaY/6qZtTvhE7Y44qx+WY94+zQkf68Peg8L33GLOCtz4BJWWnPhUpxndyfVHEY5lUpL5yQgjnGy+mmxwclthclTJOVLvNPrF5ghTvy2OgYU82abn5IguFE7MNpNXqfyfJzkaW3PgqlxLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736255962; c=relaxed/simple;
	bh=3Wqoaaw8eFj7KSekPj1twbgKltqjloEP8R1TKuD+RmI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nqeT6vYfQEkWZky9gBE+NxSyis5mKWpKAVN2jyAENgzG6Z9UTbaXdfTrPRPC36Z/Bkx1JUmDtT+KxjxQvP6zBnx2uAJmQXvVQjMJ2tvi0sqTlZF0nsYjNoxDRhwy2dHVIOHgGCwOlUevxQg2utFmcvrbJKgHl3jxaGiY+rUO7AE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n3FXqKEn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DAE6C4CEDD;
	Tue,  7 Jan 2025 13:19:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736255962;
	bh=3Wqoaaw8eFj7KSekPj1twbgKltqjloEP8R1TKuD+RmI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=n3FXqKEnV2Uk1LwH8d3Ftv2LcNrad8FM3suXsuDIZnZ3NDCRn2AenzqiYuk0Mp0L6
	 kEIxR365YfrJ9zEu9VO/7u7tgTQs64Fp+R5sWJxo6kzDYy8tt1Q9GeRPOU4GR4h6c0
	 8zQ+teqR7Oq7vAhOM0AeHAJnbyvJtl1cg64faErT74drz/Rd5VL7YS4icQpnO5kyUS
	 JD5N0MQSuet1ttLJ9hgmJcczDRM/FsGnSyPr7VJhMvNzx9Om7uwr86/6pCCGuItkx4
	 mTscB/pgXhVjdyJlql9Q63az3SP4GmhHMM5K8+pG8oD1nOFFscgeYU9BibG++6b6YU
	 VDZmK9eVJqL+A==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1tV9UO-000000006Mg-2yON;
	Tue, 07 Jan 2025 14:19:20 +0100
Date: Tue, 7 Jan 2025 14:19:20 +0100
From: Johan Hovold <johan@kernel.org>
To: Krishna chaitanya chundru <quic_krichai@quicinc.com>
Cc: Kevin Xie <kevin.xie@starfivetech.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Markus.Elfring@web.de, quic_mrana@quicinc.com, rafael@kernel.org,
	m.szyprowski@samsung.com, linux-pm@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	regressions@lists.linux.dev
Subject: Re: [PATCH v7 2/2] PCI: Enable runtime pm of the host bridge
Message-ID: <Z30p2Etwf3F2AUvD@hovoldconsulting.com>
References: <20241111-runtime_pm-v7-0-9c164eefcd87@quicinc.com>
 <20241111-runtime_pm-v7-2-9c164eefcd87@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241111-runtime_pm-v7-2-9c164eefcd87@quicinc.com>

On Mon, Nov 11, 2024 at 02:11:53PM +0530, Krishna chaitanya chundru wrote:
> The Controller driver is the parent device of the PCIe host bridge,
> PCI-PCI bridge and PCIe endpoint as shown below.
> 
>         PCIe controller(Top level parent & parent of host bridge)
>                         |
>                         v
>         PCIe Host bridge(Parent of PCI-PCI bridge)
>                         |
>                         v
>         PCI-PCI bridge(Parent of endpoint driver)
>                         |
>                         v
>                 PCIe endpoint driver
> 
> Now, when the controller device goes to runtime suspend, PM framework
> will check the runtime PM state of the child device (host bridge) and
> will find it to be disabled. So it will allow the parent (controller
> device) to go to runtime suspend. Only if the child device's state was
> 'active' it will prevent the parent to get suspended.

> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>

> @@ -3106,6 +3106,17 @@ int pci_host_probe(struct pci_host_bridge *bridge)
>  		pcie_bus_configure_settings(child);
>  
>  	pci_bus_add_devices(bus);
> +
> +	/*
> +	 * Ensure pm_runtime_enable() is called for the controller drivers,
> +	 * before calling pci_host_probe() as pm frameworks expects if the
> +	 * parent device supports runtime pm then it needs to enabled before
> +	 * child runtime pm.
> +	 */
> +	pm_runtime_set_active(&bridge->dev);
> +	pm_runtime_no_callbacks(&bridge->dev);
> +	devm_pm_runtime_enable(&bridge->dev);
> +
>  	return 0;
>  }
>  EXPORT_SYMBOL_GPL(pci_host_probe);

I just noticed that this change in 6.13-rc1 is causing the following
warning on resume from suspend on machines like the Lenovo ThinkPad
X13s:

	pci0004:00: pcie4: Enabling runtime PM for inactive device with active children

which may have unpopulated ports (this laptop SKU does not have a modem).

Reverting dc421bb3c0db ("PCI: Enable runtime PM of the host bridge")
makes the warning go away.

Johan


#regzbot introduced: dc421bb3c0db

