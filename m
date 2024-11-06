Return-Path: <linux-pci+bounces-16169-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 39E309BF87B
	for <lists+linux-pci@lfdr.de>; Wed,  6 Nov 2024 22:28:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E64861F22D28
	for <lists+linux-pci@lfdr.de>; Wed,  6 Nov 2024 21:28:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFB2C1D6DDA;
	Wed,  6 Nov 2024 21:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jK1f788f"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7F8013A26F;
	Wed,  6 Nov 2024 21:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730928508; cv=none; b=Iucu7Ni5rKA4OjG5G8+eYb3XQGCoeFyBDT6wz9cl/RdCzxklvouMV2LDv+QtLFEYpBuDe555cxZqqHg7c1lMTUZ3Xbatsu+exkm9wA8sbmqaAfxNzAAP6O2UN9VQHDdRpm4Mgdu11OlsZlYlVGp8o9AwS68ghqm+CjfqyIDF3kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730928508; c=relaxed/simple;
	bh=heDwOmYS80a2vqQlU25vx5OhaEZ1g8fx/F1gOcqR6zc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=TX2O1170Y+sRKxRYLi1h9z9taqj1JyQVWdn+6bjHFml4TL7mO6JRinDs9xp/lifxXjHwMysbHUbtu9Pph9ma1yPDtkjBgtZrK3tdC4NuypkqrjDa3NE0avqs1l2OUIyGPcdfnIpmGXOeJ5+96gJy/2YD+swxiWe8ppOJ24UC2WY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jK1f788f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E76FC4CEC6;
	Wed,  6 Nov 2024 21:28:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730928508;
	bh=heDwOmYS80a2vqQlU25vx5OhaEZ1g8fx/F1gOcqR6zc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=jK1f788ffg+9zXXmPZvT8rJRWmXB4XglinUbPR1ef2rHV4POXF6XEpiPahJr2wYHG
	 NtnzlYm9bcH0MxqRUTyIeLoNQ6XlVaZ9LNGNiSkdQUVDb0x1IBOp51rCgW7N0YhcCe
	 DyNewWoK8j7gz8Wr2DN7HLWO64QUWEmnDdQKXBD98I5NjQoqbtsuS0t+WOySy7qnmu
	 F6bZNzF2spJDzoiRE4FedLwrXVbdQwz3D+LkAWlADotv35ZJqp0TiUmh1QMpuzyUph
	 wQHQDfu2MLnZs22MarnGOIhWxODtd6/FpA2wwX0oYsXL3/KvOIbzEJ51C2HTb/UwXc
	 jpgt6Wd1O1EVg==
Date: Wed, 6 Nov 2024 15:28:26 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: manivannan.sadhasivam@linaro.org
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Johan Hovold <johan+linaro@kernel.org>,
	Abel Vesa <abel.vesa@linaro.org>,
	Stephan Gerhold <stephan.gerhold@linaro.org>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>,
	stable+noautosel@kernel.org,
	Krishna chaitanya chundru <quic_krichai@quicinc.com>
Subject: Re: [PATCH v2 2/5] PCI/pwrctl: Create pwrctl devices only if at
 least one power supply is present
Message-ID: <20241106212826.GA1540916@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241025-pci-pwrctl-rework-v2-2-568756156cbe@linaro.org>

On Fri, Oct 25, 2024 at 01:24:52PM +0530, Manivannan Sadhasivam via B4 Relay wrote:
> From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> 
> Currently, pwrctl devices are created if the corresponding PCI nodes are
> defined in devicetree. But this is not correct, because not all PCI nodes
> defined in devicetree require pwrctl support. Pwrctl comes into picture
> only when the device requires kernel to manage its power state. This can
> be determined using the power supply properties present in the devicetree
> node of the device.

> +bool of_pci_is_supply_present(struct device_node *np)
> +{
> +	struct property *prop;
> +	char *supply;
> +
> +	if (!np)
> +		return false;

Why do we need to test !np here?  It should always be non-NULL.

> +	for_each_property_of_node(np, prop) {
> +		supply = strrchr(prop->name, '-');
> +		if (supply && !strcmp(supply, "-supply"))
> +			return true;
> +	}
> +
> +	return false;
> +}

