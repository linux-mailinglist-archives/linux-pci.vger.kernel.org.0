Return-Path: <linux-pci+bounces-8467-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 90E7F900A3E
	for <lists+linux-pci@lfdr.de>; Fri,  7 Jun 2024 18:27:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B1AE28A275
	for <lists+linux-pci@lfdr.de>; Fri,  7 Jun 2024 16:27:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EFB219A2BE;
	Fri,  7 Jun 2024 16:27:08 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B81D19007A;
	Fri,  7 Jun 2024 16:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717777628; cv=none; b=kdnwS9KeOlkrB0I8bew6EluHkNRat4elkfGXGAh9ZlblSCv+XXR+XEYuFAJ4KkP6TH/I8g3CWPvaucyGSJ+kGXnwJ73UTMMu+qYpVcI2YN2Mv+7XQ0BM6ZhUAJiTBGXx3vO/hX1YpLGh8jKobunFeLx2qY+Bbl+PN+z8WlwEqgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717777628; c=relaxed/simple;
	bh=4Q10J8kr9vNr8phtfffRz/SvOstz+NEUvY6qN2pdO3k=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HHuoUK7Rd7i0+kjU7wbcMOwmqLUQwypIG0+sYd8YJ3TgS7FZ17F3wmetTX6LIjsBwWkXCtdN7um+WumY0tcSWvPGrsILPcIt8JuGbtvkhgepfC78Ze/K9Y1DZIJRRBXUQSgG0tTrkfg4QmOV8TxBZVjvnoatolcvBPX0CzVUv+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Vwmld2snFz67Lqc;
	Sat,  8 Jun 2024 00:25:49 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 846D81408FE;
	Sat,  8 Jun 2024 00:27:03 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 7 Jun
 2024 17:27:02 +0100
Date: Fri, 7 Jun 2024 17:27:01 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Wei Huang <wei.huang2@amd.com>
CC: <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <netdev@vger.kernel.org>, <bhelgaas@google.com>,
	<corbet@lwn.net>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <alex.williamson@redhat.com>,
	<gospo@broadcom.com>, <michael.chan@broadcom.com>,
	<ajit.khaparde@broadcom.com>, <somnath.kotur@broadcom.com>,
	<andrew.gospodarek@broadcom.com>, <manoj.panicker2@amd.com>,
	<Eric.VanTassell@amd.com>, <vadim.fedorenko@linux.dev>, <horms@kernel.org>,
	<bagasdotme@gmail.com>
Subject: Re: [PATCH V2 3/9] PCI/TPH: Implement a command line option to
 disable TPH
Message-ID: <20240607172701.00006ae1@Huawei.com>
In-Reply-To: <20240531213841.3246055-4-wei.huang2@amd.com>
References: <20240531213841.3246055-1-wei.huang2@amd.com>
	<20240531213841.3246055-4-wei.huang2@amd.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Fri, 31 May 2024 16:38:35 -0500
Wei Huang <wei.huang2@amd.com> wrote:

> Provide a kernel option, with related helper functions, to completely
> disable TPH so that no TPH headers are generated.

Why would someone use this option?

> 
> Co-developed-by: Eric Van Tassell <Eric.VanTassell@amd.com>
> Signed-off-by: Eric Van Tassell <Eric.VanTassell@amd.com>
> Signed-off-by: Wei Huang <wei.huang2@amd.com>
> Reviewed-by: Ajit Khaparde <ajit.khaparde@broadcom.com>
> Reviewed-by: Somnath Kotur <somnath.kotur@broadcom.com> 
> Reviewed-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
> ---
>  .../admin-guide/kernel-parameters.txt         |  1 +
>  drivers/pci/pci-driver.c                      |  7 ++++-
>  drivers/pci/pci.c                             | 12 ++++++++
>  drivers/pci/pcie/tph.c                        | 30 +++++++++++++++++++
>  include/linux/pci-tph.h                       | 19 ++++++++++++
>  include/linux/pci.h                           |  1 +
>  6 files changed, 69 insertions(+), 1 deletion(-)
>  create mode 100644 include/linux/pci-tph.h
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 500cfa776225..fedcc69e35c1 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -4623,6 +4623,7 @@
>  		nomio		[S390] Do not use MIO instructions.
>  		norid		[S390] ignore the RID field and force use of
>  				one PCI domain per PCI function
> +		notph		[PCIE] Do not use PCIe TPH
>  
>  	pcie_aspm=	[PCIE] Forcibly enable or ignore PCIe Active State Power
>  			Management.
> diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> index af2996d0d17f..9722d070c0ca 100644
> --- a/drivers/pci/pci-driver.c
> +++ b/drivers/pci/pci-driver.c
> @@ -21,6 +21,7 @@
>  #include <linux/acpi.h>
>  #include <linux/dma-map-ops.h>
>  #include <linux/iommu.h>
> +#include <linux/pci-tph.h>
>  #include "pci.h"
>  #include "pcie/portdrv.h"
>  
> @@ -322,8 +323,12 @@ static long local_pci_probe(void *_ddi)
>  	pm_runtime_get_sync(dev);
>  	pci_dev->driver = pci_drv;
>  	rc = pci_drv->probe(pci_dev, ddi->id);
> -	if (!rc)
> +	if (!rc) {
> +		if (pci_tph_disabled())
> +			pcie_tph_disable(pci_dev);
> +
>  		return rc;
> +	}
>  	if (rc < 0) {
>  		pci_dev->driver = NULL;
>  		pm_runtime_put_sync(dev);
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 59e0949fb079..31c443504ce9 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -157,6 +157,9 @@ static bool pcie_ari_disabled;
>  /* If set, the PCIe ATS capability will not be used. */
>  static bool pcie_ats_disabled;
>  
> +/* If set, the PCIe TPH capability will not be used. */
> +static bool pcie_tph_disabled;
> +
>  /* If set, the PCI config space of each device is printed during boot. */
>  bool pci_early_dump;
>  
> @@ -166,6 +169,12 @@ bool pci_ats_disabled(void)
>  }
>  EXPORT_SYMBOL_GPL(pci_ats_disabled);
>  
> +bool pci_tph_disabled(void)
> +{
> +	return pcie_tph_disabled;
> +}
> +EXPORT_SYMBOL_GPL(pci_tph_disabled);
> +
>  /* Disable bridge_d3 for all PCIe ports */
>  static bool pci_bridge_d3_disable;
>  /* Force bridge_d3 for all PCIe ports */
> @@ -6806,6 +6815,9 @@ static int __init pci_setup(char *str)
>  				pci_no_domains();
>  			} else if (!strncmp(str, "noari", 5)) {
>  				pcie_ari_disabled = true;
> +			} else if (!strcmp(str, "notph")) {
> +				pr_info("PCIe: TPH is disabled\n");
> +				pcie_tph_disabled = true;
>  			} else if (!strncmp(str, "cbiosize=", 9)) {
>  				pci_cardbus_io_size = memparse(str + 9, &str);
>  			} else if (!strncmp(str, "cbmemsize=", 10)) {
> diff --git a/drivers/pci/pcie/tph.c b/drivers/pci/pcie/tph.c
> index 5f0cc06b74bb..5dc533b89a33 100644
> --- a/drivers/pci/pcie/tph.c
> +++ b/drivers/pci/pcie/tph.c
> @@ -16,11 +16,41 @@
>  #include <linux/errno.h>
>  #include <linux/msi.h>
>  #include <linux/pci.h>
> +#include <linux/pci-tph.h>
>  #include <linux/msi.h>
>  #include <linux/pci-acpi.h>
>  
>  #include "../pci.h"
>  
> +static int tph_set_reg_field_u32(struct pci_dev *dev, u8 offset, u32 mask,
> +				 u8 shift, u32 field)

I'm unconvinced this helper makes sense.  Do we do similar for other
PCI capabilities?

If it does make sense to have a field update, then provide
one alongside pci_read_config_dword() etc.

> +{
> +	u32 reg_val;
> +	int ret;
> +
> +	if (!dev->tph_cap)
> +		return -EINVAL;
> +
> +	ret = pci_read_config_dword(dev, dev->tph_cap + offset, &reg_val);
> +	if (ret)
> +		return ret;
> +
> +	reg_val &= ~mask;
> +	reg_val |= (field << shift) & mask;
> +
> +	ret = pci_write_config_dword(dev, dev->tph_cap + offset, reg_val);
> +
> +	return ret;

	return pci_write_config_dword();

> +}
> +
> +int pcie_tph_disable(struct pci_dev *dev)
> +{
> +	return  tph_set_reg_field_u32(dev, PCI_TPH_CTRL,

extra space after return

> +				      PCI_TPH_CTRL_REQ_EN_MASK,
> +				      PCI_TPH_CTRL_REQ_EN_SHIFT,
> +				      PCI_TPH_REQ_DISABLE);
> +}
> +
>  void pcie_tph_init(struct pci_dev *dev)
>  {
>  	dev->tph_cap = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_TPH);


