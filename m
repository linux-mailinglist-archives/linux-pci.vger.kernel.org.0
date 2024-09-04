Return-Path: <linux-pci+bounces-12782-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FBC396C7BC
	for <lists+linux-pci@lfdr.de>; Wed,  4 Sep 2024 21:41:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E98F61F262CF
	for <lists+linux-pci@lfdr.de>; Wed,  4 Sep 2024 19:41:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E14D91E6DC3;
	Wed,  4 Sep 2024 19:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RbgTmhu1"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B014D1E6321;
	Wed,  4 Sep 2024 19:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725478854; cv=none; b=m7bYS+n9SOyU86Oz4qyqB+yGNxmpOyqlMyceUbbQUn2vrcUlVJOsmI2Hor4paEPMRBzYpO0dnL+buJBiqLKoL72Y/C7STye7rDjfGh/Jj2QhmfjPX6fqrFesRT8AfA2OJk/LATxGbaqxyLBzudAMfutW0+LREoDYZshcaT0sVus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725478854; c=relaxed/simple;
	bh=bQK+yFu5fRg8+syHRGxnt1pzKtg69U9NOvqBoa1Brlw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Q5AbebltciRKsY7/5AZzdAUH9bvQAx9+iX1Ci3MNPLgiYAm6eyZwSwtAIv+Z+3Hjdeko1/0to2m8jATEmq0yn509D9xvzhl4h/+De5I7c0s9j1IzHZCvN/0J44wZY8/BFyTGc6YlFq3Uboagjso29vx+t9Hn97i9L4pzb+ySGu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RbgTmhu1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02476C4CEC2;
	Wed,  4 Sep 2024 19:40:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725478854;
	bh=bQK+yFu5fRg8+syHRGxnt1pzKtg69U9NOvqBoa1Brlw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=RbgTmhu1X/pELnHTv8/3BSXPVlW1Mq6ZP4H+iGofs9wvYFpFLQPeKENdYGzXzA0gz
	 FhjkQhIMTsR4JO6gkoCwLTXR+h/ibWGe4RLo1/m1V2jUeEkGltGuD9fOadX3uTi+pX
	 F+9Pz39X6HMpcuaVlG43LylLf8oERXJuTui1xxklGZfPyXM3jJeGjv7fX+mYFgDV0I
	 YExTlRyDuLkQcX12XzIzj/2JAOSywyjj7A+JveVoDBIKiqHGs5ZW3rE1HQseqymFdk
	 oCVaYTJ/tou7bkpNyjk2jlrDeMuQ6Yg4kvwZxZpxsGX7+r0Jhqa05DInN2FFC2aWt2
	 6b2NQFZOfKDIQ==
Date: Wed, 4 Sep 2024 14:40:52 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Wei Huang <wei.huang2@amd.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, netdev@vger.kernel.org,
	Jonathan.Cameron@huawei.com, corbet@lwn.net, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	alex.williamson@redhat.com, gospo@broadcom.com,
	michael.chan@broadcom.com, ajit.khaparde@broadcom.com,
	somnath.kotur@broadcom.com, andrew.gospodarek@broadcom.com,
	manoj.panicker2@amd.com, Eric.VanTassell@amd.com,
	vadim.fedorenko@linux.dev, horms@kernel.org, bagasdotme@gmail.com,
	bhelgaas@google.com, lukas@wunner.de, paul.e.luse@intel.com,
	jing2.liu@intel.com
Subject: Re: [PATCH V4 03/12] PCI/TPH: Add pcie_tph_modes() to query TPH modes
Message-ID: <20240904194052.GA344429@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240822204120.3634-4-wei.huang2@amd.com>

On Thu, Aug 22, 2024 at 03:41:11PM -0500, Wei Huang wrote:
> Add pcie_tph_modes() to allow drivers to query the TPH modes supported
> by an endpoint device, as reported in the TPH Requester Capability
> register. The modes are reported as a bitmask and current supported
> modes include:
> 
>  - PCI_TPH_CAP_NO_ST: NO ST Mode Supported
>  - PCI_TPH_CAP_INT_VEC: Interrupt Vector Mode Supported
>  - PCI_TPH_CAP_DEV_SPEC: Device Specific Mode Supported

> + * pcie_tph_modes - Get the ST modes supported by device
> + * @pdev: PCI device
> + *
> + * Returns a bitmask with all TPH modes supported by a device as shown in the
> + * TPH capability register. Current supported modes include:
> + *   PCI_TPH_CAP_NO_ST - NO ST Mode Supported
> + *   PCI_TPH_CAP_INT_VEC - Interrupt Vector Mode Supported
> + *   PCI_TPH_CAP_DEV_SPEC - Device Specific Mode Supported
> + *
> + * Return: 0 when TPH is not supported, otherwise bitmask of supported modes
> + */
> +int pcie_tph_modes(struct pci_dev *pdev)
> +{
> +	if (!pdev->tph_cap)
> +		return 0;
> +
> +	return get_st_modes(pdev);
> +}
> +EXPORT_SYMBOL(pcie_tph_modes);

I'm not sure I see the need for pcie_tph_modes().  The new bnxt code
looks like this:

  bnxt_request_irq
    if (pcie_tph_modes(bp->pdev) & PCI_TPH_CAP_INT_VEC)
      rc = pcie_enable_tph(bp->pdev, PCI_TPH_CAP_INT_VEC);

What is the advantage of this over just this?

  bnxt_request_irq
    rc = pcie_enable_tph(bp->pdev, PCI_TPH_CAP_INT_VEC);

It seems like drivers could just ask for what they want since
pcie_enable_tph() has to verify support for it anyway.  If that fails,
the driver can fall back to another mode.

Returning a bitmask of supported modes might be useful if the driver
could combine them, but IIUC the modes are all mutually exclusive, so
the driver can't request a combination of them.

Bjorn

