Return-Path: <linux-pci+bounces-20820-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A22EA2AED4
	for <lists+linux-pci@lfdr.de>; Thu,  6 Feb 2025 18:29:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBBD6165708
	for <lists+linux-pci@lfdr.de>; Thu,  6 Feb 2025 17:29:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 228E4165F01;
	Thu,  6 Feb 2025 17:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LjldJCd1"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEBE7239572;
	Thu,  6 Feb 2025 17:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738862977; cv=none; b=md4gP+zK92ewkXRPAEjG8FZY6lmd5xcVJdmcGO3MVW6CNIrL4H9F6Rr6Kfcj4XSkTeJvtnNAJJC01J4NgxMkuvu/LGzj1TUulU2ty0RAmJ7f4G094ZzOcjWOiF1EKoDtnKq+Lv5FKrJmR2ldo1Blh0ZlcVx4u+GWNl6rUWATnS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738862977; c=relaxed/simple;
	bh=ZFUgiEXBwBsq3cq1cnrV8wXRIbWYk/FzOHDXWiMPIuo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=i5C0ArgofKzfT8CqscNk/Mf/iGi9URws5t4tB1nqfiHrPFK858mQiEE3dLG1wucDgdipPylXuBJ+8z9jQlOCFzJHfYNnOZxEpmdd+bkgKLoLvYU59QcVYaHu9oXrjY886G9t9E24ASweb44+2yoBMRYiMth+zcTYY4kMG/7OD/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LjldJCd1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B3A1C4CEDD;
	Thu,  6 Feb 2025 17:29:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738862976;
	bh=ZFUgiEXBwBsq3cq1cnrV8wXRIbWYk/FzOHDXWiMPIuo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=LjldJCd1N9i6F2+at+s8vw0UYjW1hZLi57idJMOjzMxFeT4puhC5nOo/zQbwL1vJ2
	 7u/TX3Cy6iIfP3iLdZHOuHL4VvCH04iI4FehKGJJAziJmjjfe3mpNTuG5RGnVFwWuO
	 sjJcCSj+6facGTP/+OOSpRQQ8oEuPXJqWvmG5VzAHWJmycziliimQjwFT8qVUiYTG7
	 pBsRHA7avRWoZf/lMX3EhDLaF/a6LQaGz+yEvsayHlCGPglJlXeJIJmifPvEunADF9
	 VazugdRiewd1sVVTgAgvt27p9fVn+w7MUoxYZn/6RHL4IkSZcTHLEYGru8EhTmPRbh
	 Zu5CyshDpgWZQ==
Date: Thu, 6 Feb 2025 11:29:35 -0600
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
Subject: Re: [PATCH v1 2/6] PCI: brcmstb: Fix error path upon call of
 regulator_bulk_get()
Message-ID: <20250206172935.GA990026@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250205191213.29202-3-james.quinlan@broadcom.com>

On Wed, Feb 05, 2025 at 02:12:02PM -0500, Jim Quinlan wrote:
> If regulator_bulk_get() returns an error, no regulators are
> created and we need to set their number to zero.  If we do
> not do this and the PCIe link-up fails, regulator_bulk_free()
> will be invoked and effect a panic.
> 
> Also print out the error value, as we cannot return an error
> upwards as Linux will WARN on an error from add_bus().

Wrap all these commit logs to fill 75 columns.  No point in leaving
unused space when most things are formatted to fill 80ish columns or
more.

> Fixes: 9e6be018b263 ("PCI: brcmstb: Enable child bus device regulators from DT")
> Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
> ---
>  drivers/pci/controller/pcie-brcmstb.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
> index f8fc3d620ee2..bf919467cbcd 100644
> --- a/drivers/pci/controller/pcie-brcmstb.c
> +++ b/drivers/pci/controller/pcie-brcmstb.c
> @@ -1417,7 +1417,8 @@ static int brcm_pcie_add_bus(struct pci_bus *bus)
>  
>  		ret = regulator_bulk_get(dev, sr->num_supplies, sr->supplies);
>  		if (ret) {
> -			dev_info(dev, "No regulators for downstream device\n");
> +			dev_info(dev, "Did not get regulators; err=%d\n", ret);
> +			sr->num_supplies = 0;
>  			goto no_regulators;

I think it might have been better if we could do the
regulator_bulk_get() separately, before pci_host_probe(), so that if 
this error happens, we can deal with it more easily.

Setting num_supplies = 0 is an unusual way of handling this error, and
if this pattern of managing PCIe regulators spreads to other drivers,
we might trip over this again.

Not asking for a redesign here, and maybe it wouldn't even be
possible, but it kind of fits with thinking about splitting Root Port
support from the Root Complex/host bridge support.

Bjorn

