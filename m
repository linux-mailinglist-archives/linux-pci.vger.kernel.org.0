Return-Path: <linux-pci+bounces-24749-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F38E0A71292
	for <lists+linux-pci@lfdr.de>; Wed, 26 Mar 2025 09:23:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB05B18958B6
	for <lists+linux-pci@lfdr.de>; Wed, 26 Mar 2025 08:23:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 276DC1A0BCA;
	Wed, 26 Mar 2025 08:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jy+so43p"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F07372A1B2;
	Wed, 26 Mar 2025 08:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742977376; cv=none; b=AA7uKvcWbotO+uK8TjQ8fjhdWg5jvzhXG9QGCNjEk4rULRN3+P6Dn3aIMTYAl44Rgjj7xuzVxNKkhHQI7An+VR+tPyB8tUN+2HRh6Uz26gFP+xVDLk1UUDErV2P/CKFOuOIpE/7XSV7vUr+AjSXwFOYZ05Z38HTB4ErGGfNmB+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742977376; c=relaxed/simple;
	bh=9tkiqJYo1RoLYJT8Q7zax6/knmsceudeeZvRwv/gSoU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QZxtLSG1awDHADLvjB5v/x6nkyWPK94sf/yQDJ3oFBbgWv99QwRHrIKeinPVA7quf/65wmk6b90AWsMtpfYTTF/xqKCDKL92jbEOfT4kEfR/o4UnAzTMPuGNMt1QGCwoj4gyorXEdHinIJqRNI0qRV22yUok1uPgIg/QC0wD9OQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jy+so43p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10405C4CEE2;
	Wed, 26 Mar 2025 08:22:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742977375;
	bh=9tkiqJYo1RoLYJT8Q7zax6/knmsceudeeZvRwv/gSoU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jy+so43pXJ9AMK+8zE5riNq1VLSBgz4885QM4+ZA1ZhLieRR32E2jnxcW4hcQGrR6
	 /fA46i1qCPLfWYyCRbx4eIInfirVdR1XxMticFGzEDxSfA0TK/n1co+Q7K49LdvWZr
	 o6SVLyC/2JueDn8F1T6fqnk2Hm0X+rL9MkFhsVhz71V1ZtwfPhFm1ulUgBweaG+8Z6
	 a04TTyAq5v+gqsXQz5/hwnX1G2HvBwwttATSqErvgX5MST9xlS4N8NULGu1VmdrsB8
	 vVsWkfvYOpT3JhPWL+DpGvfJn0JreUCY0bMNzvAYYUB8UyTcOjZqxa4sP+37YkjFIw
	 eginNwMd9xDUw==
Date: Wed, 26 Mar 2025 09:22:52 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Sai Krishna Musham <sai.krishna.musham@amd.com>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com, 
	manivannan.sadhasivam@linaro.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	cassel@kernel.org, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, michal.simek@amd.com, bharat.kumar.gogada@amd.com, 
	thippeswamy.havalige@amd.com
Subject: Re: [PATCH 2/2] PCI: amd-mdb: Add support for PCIe RP PERST# signal
Message-ID: <20250326-succinct-steadfast-pronghorn-5fcc21@krzk-bin>
References: <20250326041507.98232-1-sai.krishna.musham@amd.com>
 <20250326041507.98232-3-sai.krishna.musham@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250326041507.98232-3-sai.krishna.musham@amd.com>

On Wed, Mar 26, 2025 at 09:45:07AM +0530, Sai Krishna Musham wrote:
> Add PERST# signal handling via I2C GPIO expander for AMD Versal2
> MDB PCIe Root Port.
> 
> Signed-off-by: Sai Krishna Musham <sai.krishna.musham@amd.com>
> ---
>  drivers/pci/controller/dwc/pcie-amd-mdb.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-amd-mdb.c b/drivers/pci/controller/dwc/pcie-amd-mdb.c
> index 4eb2a4e8189d..4eea53e9e197 100644
> --- a/drivers/pci/controller/dwc/pcie-amd-mdb.c
> +++ b/drivers/pci/controller/dwc/pcie-amd-mdb.c
> @@ -18,6 +18,7 @@
>  #include <linux/resource.h>
>  #include <linux/types.h>
>  
> +#include "../../pci.h"
>  #include "pcie-designware.h"
>  
>  #define AMD_MDB_TLP_IR_STATUS_MISC		0x4C0
> @@ -408,6 +409,7 @@ static int amd_mdb_add_pcie_port(struct amd_mdb_pcie *pcie,
>  	struct dw_pcie *pci = &pcie->pci;
>  	struct dw_pcie_rp *pp = &pci->pp;
>  	struct device *dev = &pdev->dev;
> +	struct gpio_desc *reset_gpio;
>  	int err;
>  
>  	pcie->slcr = devm_platform_ioremap_resource_byname(pdev, "slcr");
> @@ -426,6 +428,24 @@ static int amd_mdb_add_pcie_port(struct amd_mdb_pcie *pcie,
>  
>  	pp->ops = &amd_mdb_pcie_host_ops;
>  
> +	/* Request the GPIO for PCIe reset signal and assert */
> +	reset_gpio = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
> +	if (IS_ERR(reset_gpio)) {
> +		if (PTR_ERR(reset_gpio) == -EPROBE_DEFER)
> +			return -EPROBE_DEFER;
> +		dev_err(dev, "Failed to request reset GPIO\n");

Do not open-code dev_err_probe.

Best regards,
Krzysztof


