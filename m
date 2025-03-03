Return-Path: <linux-pci+bounces-22776-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99CA1A4CB18
	for <lists+linux-pci@lfdr.de>; Mon,  3 Mar 2025 19:40:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CF763AB954
	for <lists+linux-pci@lfdr.de>; Mon,  3 Mar 2025 18:40:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBCCE214A60;
	Mon,  3 Mar 2025 18:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mOE/feWO"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A32A320FA85;
	Mon,  3 Mar 2025 18:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741027213; cv=none; b=t4+FX73GEr9JC5Laj9Jn46XRqB3i051JlV+87dbmyDp5QVOwFTZCC61sTLi36pp1XLKbMXXTeHID8JzycbsXuPQJ1Y/JFGWh973vb3B28ggaIXJp3IfkCWImb7lYcyCqBiBQuRskcQUVyLfa6VfsD+G8ft+vhXbVBbNs0eAkwpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741027213; c=relaxed/simple;
	bh=LMcjnXUMRisPi6cns32MGe0Eh+x3GI+oq769ibqyYQE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=YZmUUTwi2vSvR9AXiQNoJk+tVMGfjOXqSBNsRosnQDlLXHVSdgJXpPRJgaLx4tRvKstpEd/zJPyRrmqmQPlzHYPNSfWhRoMvVxMTg9DQYlnCBKpfZKhX0zQ0MQwLFYk+eOcU5Q/ePEfGZ2TPbzFGFkEo4aanC07pbiXaH7xXDyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mOE/feWO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E11B1C4CED6;
	Mon,  3 Mar 2025 18:40:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741027213;
	bh=LMcjnXUMRisPi6cns32MGe0Eh+x3GI+oq769ibqyYQE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=mOE/feWOMI5QBDfGntKwEW2sMwYsBWmxRIxRC0pbaEIRGHtz3KkUOSjnvqNUPrSB/
	 EdR894U/HftKtEilBcmM+5dxQqBeGiQRHwSaw1sVNyHCYcreVvS8fsGQ97Vtip9AnN
	 Zm17RQWrm/c4SgwAeRdkwIgWbibmJnaZP1ksgdeSUX1L/fM4MDRSF+effKh8tZTjOd
	 W2OEYlldiejka6KB+t7hJsNOMYANUYWwEUowhZEe5sSBf3mYNt3GAl+NpoJQSrcRD2
	 ibsl02/0xTC0YhdB6ZMU278KAl2kMikfDRHcZgBtsweuUzJn1jZu7McpJvYmanl4zO
	 ofod9s4njvGfw==
Date: Mon, 3 Mar 2025 12:40:11 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jim Quinlan <james.quinlan@broadcom.com>
Cc: linux-pci@vger.kernel.org, Nicolas Saenz Julienne <nsaenz@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Cyril Brulebois <kibi@debian.org>,
	Stanimir Varbanov <svarbanov@suse.de>,
	bcm-kernel-feedback-list@broadcom.com, jim2101024@gmail.com,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>,
	"moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" <linux-rpi-kernel@lists.infradead.org>,
	"moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 4/8] PCI: brcmstb: Fix error path upon call of
 regulator_bulk_get()
Message-ID: <20250303184011.GA172021@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250214173944.47506-5-james.quinlan@broadcom.com>

On Fri, Feb 14, 2025 at 12:39:32PM -0500, Jim Quinlan wrote:
> If regulator_bulk_get() returns an error, no regulators are created and we
> need to set their number to zero.  If we do not do this and the PCIe
> link-up fails, regulator_bulk_free() will be invoked and effect a panic.
> 
> Also print out the error value, as we cannot return an error upwards as
> Linux will WARN on an error from add_bus().
> 
> Fixes: 9e6be018b263 ("PCI: brcmstb: Enable child bus device regulators from DT")
> Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
> ---
>  drivers/pci/controller/pcie-brcmstb.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
> index e0b20f58c604..56b49d3cae19 100644
> --- a/drivers/pci/controller/pcie-brcmstb.c
> +++ b/drivers/pci/controller/pcie-brcmstb.c
> @@ -1416,7 +1416,8 @@ static int brcm_pcie_add_bus(struct pci_bus *bus)
>  
>  		ret = regulator_bulk_get(dev, sr->num_supplies, sr->supplies);
>  		if (ret) {
> -			dev_info(dev, "No regulators for downstream device\n");
> +			dev_info(dev, "Did not get regulators; err=%d\n", ret);
> +			pcie->sr = NULL;

Is alloc_subdev_regulators() buying us something useful?  It seems
like it would be simpler to have:

  struct brcm_pcie {
    ...
    struct regulator_bulk_data supplies[3];
    ...
  };

I think that's what most callers of devm_regulator_bulk_get() do.

>  			goto no_regulators;
>  		}
>  
> -- 
> 2.43.0
> 

