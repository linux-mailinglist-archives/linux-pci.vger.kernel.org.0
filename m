Return-Path: <linux-pci+bounces-1718-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 483EE825327
	for <lists+linux-pci@lfdr.de>; Fri,  5 Jan 2024 12:57:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 538981C228D7
	for <lists+linux-pci@lfdr.de>; Fri,  5 Jan 2024 11:57:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5BC62CCBB;
	Fri,  5 Jan 2024 11:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="fFZdp3TU"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-25.smtpout.orange.fr [80.12.242.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CDE22D612;
	Fri,  5 Jan 2024 11:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.18] ([92.140.202.140])
	by smtp.orange.fr with ESMTPA
	id LiokruZkFELO0LiolrhUhQ; Fri, 05 Jan 2024 12:56:54 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1704455814;
	bh=CSiok1FWoHDoltgHfZdP/28GJu+lcwq9ugIUc7oXzVM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=fFZdp3TUWenJHYNTyZN9QbMojPt3pYox0g0VCSbhvba7yYQXniBjYOGywjadbPhos
	 N24tjndEaTUI6VJguboDCBidLGxKPzTtuhK0umjONLi74boujsXwCn6o48Lo95Cc8v
	 68fvCUV/KSWuaaOTjBLiiQQByhOWos/PGNdSDe8Jo07CdCwZt3rRFgEqHejB1dNDiD
	 GmsDViMyaEMcNPJoDRjuU3c9PbtHSGSyRaIabi4q1zUrc+p5X93q6xLqbKpQNE6hek
	 vj0ixELzBRWoMhkpU3w084B9CT6vkXX+/IX5C+xD4onc+V4PGkszVntoufJ582bunU
	 6cMNXo+HiDGtQ==
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Fri, 05 Jan 2024 12:56:54 +0100
X-ME-IP: 92.140.202.140
Message-ID: <465a1275-f7a4-4d04-b69d-9d062883c2c4@wanadoo.fr>
Date: Fri, 5 Jan 2024 12:56:47 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 7/8] thermal: Add PCIe cooling driver
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Rob Herring
 <robh@kernel.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Lukas Wunner <lukas@wunner.de>, Alexandru Gagniuc <mr.nuke.me@gmail.com>,
 Krishna chaitanya chundru <quic_krichai@quicinc.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, linux-kernel@vger.kernel.org
Cc: Alex Deucher <alexdeucher@gmail.com>, Amit Kucheria <amitk@kernel.org>
References: <20240105112547.7301-1-ilpo.jarvinen@linux.intel.com>
 <20240105112547.7301-8-ilpo.jarvinen@linux.intel.com>
Content-Language: fr
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20240105112547.7301-8-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 05/01/2024 à 12:25, Ilpo Järvinen a écrit :
> Add a thermal cooling driver to provide path to access PCIe bandwidth
> controller using the usual thermal interfaces.
> 
> A cooling device is instantiated for controllable PCIe Ports from the
> bwctrl service driver.
> 
> The thermal side state 0 means no throttling, i.e., maximum supported
> PCIe Link Speed.
> 
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> Acked-by: Rafael J. Wysocki <rafael@kernel.org> # From the cooling device interface perspective
> ---

...

> +struct thermal_cooling_device *pcie_cooling_device_register(struct pci_dev *port,
> +							    struct pcie_device *pdev)
> +{
> +	struct pcie_cooling_device *pcie_cdev;
> +	struct thermal_cooling_device *cdev;
> +	size_t name_len;
> +	char *name;
> +
> +	pcie_cdev = kzalloc(sizeof(*pcie_cdev), GFP_KERNEL);
> +	if (!pcie_cdev)
> +		return ERR_PTR(-ENOMEM);
> +
> +	pcie_cdev->port = port;
> +	pcie_cdev->pdev = pdev;
> +
> +	name_len = strlen(COOLING_DEV_TYPE_PREFIX) + strlen(pci_name(port)) + 1;
> +	name = kzalloc(name_len, GFP_KERNEL);
> +	if (!name) {
> +		kfree(pcie_cdev);
> +		return ERR_PTR(-ENOMEM);
> +	}
> +
> +	snprintf(name, name_len, COOLING_DEV_TYPE_PREFIX "%s", pci_name(port));

Nit: kasprintf() ?

> +	cdev = thermal_cooling_device_register(name, pcie_cdev, &pcie_cooling_ops);
> +	kfree(name);
> +
> +	return cdev;
> +}



