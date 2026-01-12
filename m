Return-Path: <linux-pci+bounces-44463-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 11930D107A7
	for <lists+linux-pci@lfdr.de>; Mon, 12 Jan 2026 04:27:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5D41C301787E
	for <lists+linux-pci@lfdr.de>; Mon, 12 Jan 2026 03:27:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6458C306D36;
	Mon, 12 Jan 2026 03:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TWt4Chmf"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40BD63033C7;
	Mon, 12 Jan 2026 03:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768188441; cv=none; b=YToNIxOulzNCY9e3NreCQBLjH452/5S5Mcg8/2i4swPwKgdkTEwJHYVeij+hHX+Ofu/Vx7g5neKZ4OjMDCK0NBzB/+r45iTJoPpxQOnNo2BIY00HSGeOiNOElZhfdbBXhugabJ4ftlDG2xrCKCzn5ETGQx+of5Ss+eDSBi8s+zE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768188441; c=relaxed/simple;
	bh=yC8D0y2JAkWG1UB4jRKStQgFfGKk6E+tdA2BanaY9eI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=USxYfByud4OCNhFvoSCrm/peS/vkVCsP5l+C2OtpRDtT6frFrPEqYeLDD1TofeMZdmZSm8rJ0mX0ewCuxMH8fP6bUCFUivZoyariwcrmtmQfcD8p/CVQyEkMhTTcsP49aPsZfOBcVHy7izqLH8YO1YOAefbXOrgnJlf7iioWVmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TWt4Chmf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A56BFC116D0;
	Mon, 12 Jan 2026 03:27:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768188440;
	bh=yC8D0y2JAkWG1UB4jRKStQgFfGKk6E+tdA2BanaY9eI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=TWt4ChmfrSoPoyf+Obf+VreIXmE61yBak8pDVaDX9oxE3iGf+CX/GrDTVrgcDUDaS
	 8fM9P+0ZXi+TYN+Z3hSJlCt9qjJxOV9+PuQqwZ41g0OzwjAO83kRfM7moz19OYB9RV
	 Il7D5Zum9939lvUQhJrlqFpHxYu0sPWEX30j0TJOh/ZMg9JAOsTs6m8e7ALN5qPNvd
	 VBnSM+OJUm/nYLXsum9TXV/1zQmMqmxJJ0xs10kN99EF2TUKNwavTwomXCbsv5S/CQ
	 UOie+nRAa7wEfSVoKZpymv2I3xqzZ8WAy2vPYB4aoR9nvOv7b3Tb2fqlHv/BzOrPto
	 yzchm/dqYXgEw==
Date: Sun, 11 Jan 2026 21:27:19 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: manivannan.sadhasivam@oss.qualcomm.com
Cc: Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Bartosz Golaszewski <brgl@bgdev.pl>, linux-pci@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
	Chen-Yu Tsai <wens@kernel.org>,
	Brian Norris <briannorris@chromium.org>,
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
	Niklas Cassel <cassel@kernel.org>, Alex Elder <elder@riscstar.com>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Chen-Yu Tsai <wenst@chromium.org>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v4 4/8] PCI/pwrctrl: Add APIs to power on/off the pwrctrl
 devices
Message-ID: <20260112032719.GA695866@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260105-pci-pwrctrl-rework-v4-4-6d41a7a49789@oss.qualcomm.com>

On Mon, Jan 05, 2026 at 07:25:44PM +0530, Manivannan Sadhasivam via B4 Relay wrote:
> From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> 
> To fix PCIe bridge resource allocation issues when powering PCIe
> switches with the pwrctrl driver, introduce APIs to explicitly power
> on and off all related devices simultaneously.
> ...

> +static void pci_pwrctrl_power_off_device(struct device_node *np)
> +{
> +	struct platform_device *pdev;
> +	int ret;
> +
> +	for_each_available_child_of_node_scoped(np, child)
> +		pci_pwrctrl_power_off_device(child);
> +
> +	pdev = of_find_device_by_node(np);
> +	if (pdev) {
> +		if (device_is_bound(&pdev->dev)) {
> +			ret = __pci_pwrctrl_power_off_device(&pdev->dev);
> +			if (ret)
> +				dev_err(&pdev->dev, "Failed to power off device: %d", ret);
> +		}
> +
> +		platform_device_put(pdev);
> +	}

Suggest this to reduce indentation:

  pdev = of_find_device_by_node(np);
  if (!pdev)
    return;

  if (device_is_bound(&pdev->dev)) {
    ...
  }

  platform_device_put(pdev);

> +static int pci_pwrctrl_power_on_device(struct device_node *np)
> +{
> +	struct platform_device *pdev;
> +	int ret;
> +
> +	for_each_available_child_of_node_scoped(np, child) {
> +		ret = pci_pwrctrl_power_on_device(child);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	pdev = of_find_device_by_node(np);
> +	if (pdev) {
> +		if (!device_is_bound(&pdev->dev)) {
> +			/* FIXME: Use blocking wait instead of probe deferral */
> +			dev_dbg(&pdev->dev, "driver is not bound\n");
> +			ret = -EPROBE_DEFER;
> +		} else {
> +			ret = __pci_pwrctrl_power_on_device(&pdev->dev);
> +		}
> +		platform_device_put(pdev);
> +
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return 0;

And this:

  pdev = of_find_device_by_node(np);
  if (!pdev)
    return 0;

  if (device_is_bound(&pdev->dev)) {
    ...
  } else {
    ...
  }

  platform_device_put(pdev);

  return ret;

