Return-Path: <linux-pci+bounces-32237-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4231AB06EB0
	for <lists+linux-pci@lfdr.de>; Wed, 16 Jul 2025 09:16:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CEA7566BAC
	for <lists+linux-pci@lfdr.de>; Wed, 16 Jul 2025 07:16:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8B5828850E;
	Wed, 16 Jul 2025 07:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="B9TMPI7S"
X-Original-To: linux-pci@vger.kernel.org
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C47E9381AF;
	Wed, 16 Jul 2025 07:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752650193; cv=none; b=Sp79VbGkdAnp3RLvLnyvpHr/E8oyNSH3Pdh54HV88Ek2y8LjAz21vqz/12CJ3thfw6glNGwLkU6YyMhwC+hOiTp3tgPLQ/tIJw90swCjyjBy1GcwRXwI3+9wtu3H+3qvMNE9FNI0HFQHDR3pBmwxUsWC7Z7UX2kCh9Rz7zRdy48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752650193; c=relaxed/simple;
	bh=cgJpryTbNPT4uQieh/YRbOpgBOzYOqZivYucNN76U+Y=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kIC8peEz96xSckHUTS9NSmjUMtfnyUrmEjvoqRhEHaC0OSw2LMzeq3dHlUSsR5gSK5msYt4kjmu7EtnknxMplHP/aj6J+6aD6iKTfyx+QhQuhML0wYlF4dHP46J2MfkfapppdV1aLea7wE1obs5EqplRagVp3s1xWOkAI1LXwTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=B9TMPI7S; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 56G7GF5V195870;
	Wed, 16 Jul 2025 02:16:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1752650175;
	bh=fB5TsNwWgB45LAm6ZUD/fPdEU/smhkB4TT/cSr4jjJM=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=B9TMPI7SC4qU/6z6jDeESs3xi8l7HRBuGgZM68kBwZjADBftiwxiRTOfuu+RNJ+gm
	 BEfXBxqBh6FukA4POWABRLH90qBU4yN/s+Fe7IBrh0JiI8a5MSpKsh9LaoNIQv17vg
	 t1YeqiiPoIEsREb2tO3lRivtJioX4uw+rCKULtZo=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
	by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 56G7GFXg1184742
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Wed, 16 Jul 2025 02:16:15 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Wed, 16
 Jul 2025 02:16:15 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Wed, 16 Jul 2025 02:16:15 -0500
Received: from localhost (uda0492258.dhcp.ti.com [172.24.227.169])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 56G7GDQm046600;
	Wed, 16 Jul 2025 02:16:14 -0500
Date: Wed, 16 Jul 2025 12:46:13 +0530
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <huaqian.li@siemens.com>
CC: <s-vadapalli@ti.com>, <baocheng.su@siemens.com>, <bhelgaas@google.com>,
        <conor+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <diogo.ivo@siemens.com>, <helgaas@kernel.org>,
        <jan.kiszka@siemens.com>, <kristo@kernel.org>, <krzk+dt@kernel.org>,
        <kw@linux.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <lpieralisi@kernel.org>, <nm@ti.com>, <robh@kernel.org>,
        <ssantosh@kernel.org>, <vigneshr@ti.com>
Subject: Re: [PATCH v9 (RESEND) 4/7] PCI: keystone: Add support for PVU-based
 DMA isolation on AM654
Message-ID: <0cd8175e-e448-483f-862e-b12d795ae1e5@ti.com>
References: <e21c6ead-2bcb-422b-a1b9-eb9dd63b7dc7@ti.com>
 <20250716053950.199079-1-huaqian.li@siemens.com>
 <20250716053950.199079-5-huaqian.li@siemens.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250716053950.199079-5-huaqian.li@siemens.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On Wed, Jul 16, 2025 at 01:39:47PM +0800, huaqian.li@siemens.com wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
> 
> The AM654 lacks an IOMMU, thus does not support isolating DMA requests
> from untrusted PCI devices to selected memory regions this way. Use
> static PVU-based protection instead. The PVU, when enabled, will only
> accept DMA requests that address previously configured regions.
> 
> Use the availability of a restricted-dma-pool memory region as trigger
> and register it as valid DMA target with the PVU. In addition, enable
> the mapping of requester IDs to VirtIDs in the PCI RC. Use only a single
> VirtID so far, catching all devices.
> 
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> Signed-off-by: Li Hua Qian <huaqian.li@siemens.com>
> ---
>  drivers/pci/controller/dwc/pci-keystone.c | 106 ++++++++++++++++++++++
>  1 file changed, 106 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
> index 2b2632e513b5..fbf1bf43b7ca 100644
> --- a/drivers/pci/controller/dwc/pci-keystone.c
> +++ b/drivers/pci/controller/dwc/pci-keystone.c

[------------------email has been trimmed----------------------------]

> +static void ks_release_restricted_dma(struct platform_device *pdev)
> +{
> +	struct of_phandle_iterator it;
> +	struct resource phys;
> +	int err;
> +
> +	if (!IS_ENABLED(CONFIG_TI_PVU))
> +		return;
> +
> +	of_for_each_phandle(&it, err, pdev->dev.of_node, "memory-region",
> +			    NULL, 0) {
> +		if (of_device_is_compatible(it.node, "restricted-dma-pool") &&
> +		    of_address_to_resource(it.node, 0, &phys) == 0) {
> +			ti_pvu_remove_region(KS_PCI_VIRTID, &phys);
> +			break;
> +		}
> +	}
> +}
> +
>  static int ks_pcie_probe(struct platform_device *pdev)
>  {
>  	const struct dw_pcie_host_ops *host_ops;
> @@ -1284,6 +1384,10 @@ static int ks_pcie_probe(struct platform_device *pdev)
>  	if (ret < 0)
>  		goto err_get_sync;
>  
> +	ret = ks_init_restricted_dma(pdev);
> +	if (ret < 0)
> +		goto err_get_sync;
> +

Please move the above into the section specific to RC mode. This has
been agreed to by Jan at:
https://lore.kernel.org/r/e9716614-1849-4524-af4d-20587df365cf@siemens.com/

>  	switch (mode) {
>  	case DW_PCIE_RC_TYPE:
>  		if (!IS_ENABLED(CONFIG_PCI_KEYSTONE_HOST)) {
> @@ -1365,6 +1469,8 @@ static void ks_pcie_remove(struct platform_device *pdev)
>  	int num_lanes = ks_pcie->num_lanes;
>  	struct device *dev = &pdev->dev;
>  
> +	ks_release_restricted_dma(pdev);
> +

Regards,
Siddharth.

