Return-Path: <linux-pci+bounces-3433-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DA0A854723
	for <lists+linux-pci@lfdr.de>; Wed, 14 Feb 2024 11:28:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0AC51C20865
	for <lists+linux-pci@lfdr.de>; Wed, 14 Feb 2024 10:28:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F14B417581;
	Wed, 14 Feb 2024 10:28:49 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [83.223.95.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4FFE1759D;
	Wed, 14 Feb 2024 10:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707906529; cv=none; b=VzFRSZNUiwZGMxHLOc/R8uit2giBuIWbEuCrHpJvHz8izihLax/gMNEj7kX0T03INQ5WeiUAYQPBsJoRC+wr0+Ld+GE3axB/Gij54xJxeiae+7U/cTKAYPUbL6jqw1gRFESOJXTavpTwFwxU8c7P++Iyu8E0wz96oljxJoFgAIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707906529; c=relaxed/simple;
	bh=8/XhGqCAuGX08PlCEKi60aMtlMVFlwsETgvlqDwir/o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rI9XOEFjn+J+/OGx62nf93frKK5JGw5yto7PnluDBX78TGkY6z0m7ILSlbKozv44Ji4hHnNeMADK7gBfcRi+LyF/8yXgE3y1ep0wwEPiLdnta2/k2b52pDHr5VtgWasKBHfyGLgwwxHFl72jdn68wji3zkr3AqHcI4o+rhxRTwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.95.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout1.hostsharing.net (Postfix) with ESMTPS id 0AD2A300000BE;
	Wed, 14 Feb 2024 11:28:38 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id F36764EE665; Wed, 14 Feb 2024 11:28:37 +0100 (CET)
Date: Wed, 14 Feb 2024 11:28:37 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof Wilczy??ski <kw@linux.com>, Rob Herring <robh@kernel.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	quic_krichai@quicinc.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v2] PCI: Add D3 support for PCI bridges in DT based
 platforms
Message-ID: <20240214102837.GA30420@wunner.de>
References: <20240214-pcie-qcom-bridge-v2-1-9dd6dbb1b817@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240214-pcie-qcom-bridge-v2-1-9dd6dbb1b817@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Wed, Feb 14, 2024 at 02:18:31PM +0530, Manivannan Sadhasivam wrote:
> +/**
> + * of_pci_bridge_d3 - Check if the bridge is supporting D3 states or not
> + *
> + * @node: device tree node of the bridge
> + *
> + * Return: True if the bridge is supporting D3 states, False otherwise.

A lot of kernel-doc uses %true and %false.


> +bool of_pci_bridge_d3(struct device_node *node)
> +{
> +	return of_property_read_bool(node, "supports-d3");
> +}

What's the difference between of_property_read_bool() and
of_property_present()?  When should one use which?
The former has 691 occurrences in the tree, the latter 120.
The latter would seem more "literary" / readable here,
but maybe that's just me.


> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -1142,6 +1142,9 @@ static inline bool platform_pci_bridge_d3(struct pci_dev *dev)
>  	if (pci_use_mid_pm())
>  		return false;
>  
> +	if (dev->dev.of_node)
> +		return of_pci_bridge_d3(dev->dev.of_node);
> +
>  	return acpi_pci_bridge_d3(dev);
>  }

This will result in an unnecessary test on non-DT platforms (e.g. ACPI)
whether dev->dev.of_node is set.

Please use dev_of_node() instead of "dev->dev.of_node" so that the
code added here can be optimized away by the compiler on non-DT
platforms (due to the IS_ENABLED(CONFIG_OF)).

Thanks,

Lukas

