Return-Path: <linux-pci+bounces-13352-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B6F597E6EA
	for <lists+linux-pci@lfdr.de>; Mon, 23 Sep 2024 09:54:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62024281636
	for <lists+linux-pci@lfdr.de>; Mon, 23 Sep 2024 07:54:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAF6644C8C;
	Mon, 23 Sep 2024 07:54:41 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [176.9.242.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAD7D328B6;
	Mon, 23 Sep 2024 07:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.242.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727078081; cv=none; b=tvQCQkpAZuJjb6NwVaLchplSeLQ0QgYLarSnjSZtw1gu1xIipqY/KJyZSbFp/j9nxSkKeSiX9Sb4vYg6+Eovv87sxZwF3cfq8dVYgJ+qC0Qbli3smPTRU5pDbDHe08r93EmFpNB+oBWEYG8UsMhmdUe3gWaSLZYjKV1P53R7S1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727078081; c=relaxed/simple;
	bh=QxXIxc+0eslzVUrsut9gNNpsLrYacQ4/TUMBkZGoA+g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VPKDtjalLIy+eOBan5mV2mSSjkQchyMKaQRSOOIc8OLisKqQwD3H9E3RXi7Djn1pmPuOo1ZdKMVw+m4OMg2L+Bfk0+D8Z9pWyYNRAUXlDFeBXmQ5aEQmFhyOePOduXbv366lHZfhAK++ozIHFKWIs4eeV8sHlKPPrrI/No03p2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=176.9.242.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout3.hostsharing.net (Postfix) with ESMTPS id A8B64100FC269;
	Mon, 23 Sep 2024 09:43:00 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 6E1303972D4; Mon, 23 Sep 2024 09:43:00 +0200 (CEST)
Date: Mon, 23 Sep 2024 09:43:00 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Wei Huang <wei.huang2@amd.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, netdev@vger.kernel.org,
	Jonathan.Cameron@huawei.com, helgaas@kernel.org, corbet@lwn.net,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, alex.williamson@redhat.com, gospo@broadcom.com,
	michael.chan@broadcom.com, ajit.khaparde@broadcom.com,
	somnath.kotur@broadcom.com, andrew.gospodarek@broadcom.com,
	manoj.panicker2@amd.com, Eric.VanTassell@amd.com,
	vadim.fedorenko@linux.dev, horms@kernel.org, bagasdotme@gmail.com,
	bhelgaas@google.com, paul.e.luse@intel.com, jing2.liu@intel.com
Subject: Re: [PATCH V5 1/5] PCI: Add TLP Processing Hints (TPH) support
Message-ID: <ZvEcBLGqlJMj3MHA@wunner.de>
References: <20240916205103.3882081-1-wei.huang2@amd.com>
 <20240916205103.3882081-2-wei.huang2@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240916205103.3882081-2-wei.huang2@amd.com>

On Mon, Sep 16, 2024 at 03:50:59PM -0500, Wei Huang wrote:
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -1813,6 +1813,7 @@ int pci_save_state(struct pci_dev *dev)
>  	pci_save_dpc_state(dev);
>  	pci_save_aer_state(dev);
>  	pci_save_ptm_state(dev);
> +	pci_save_tph_state(dev);
>  	return pci_save_vc_state(dev);
>  }
>  EXPORT_SYMBOL(pci_save_state);
> @@ -1917,6 +1918,7 @@ void pci_restore_state(struct pci_dev *dev)
>  	pci_restore_vc_state(dev);
>  	pci_restore_rebar_state(dev);
>  	pci_restore_dpc_state(dev);
> +	pci_restore_tph_state(dev);
>  	pci_restore_ptm_state(dev);
>  
>  	pci_aer_clear_status(dev);

I'm wondering if there's a reason to use a different order on save versus
restore?  E.g. does PTM need to be restored last?


> --- a/drivers/pci/pcie/Kconfig
> +++ b/drivers/pci/pcie/Kconfig
> @@ -155,3 +155,14 @@ config PCIE_EDR
>  	  the PCI Firmware Specification r3.2.  Enable this if you want to
>  	  support hybrid DPC model which uses both firmware and OS to
>  	  implement DPC.
> +
> +config PCIE_TPH
> +	bool "TLP Processing Hints"
> +	depends on ACPI

TPH isn't really an ACPI-specific feature, it could exist on
devicetree-based platforms as well.  I think there could be valid
use cases for enabling TPH support on such platforms:

E.g. the platform firmware or bootloader might set up the TPH Extended
Capability in a specific way and the kernel would have to save/restore
it on system sleep.

So I'd recommend removing this dependency.

Note that there's a static inline for acpi_check_dsm() which returns
false if CONFIG_ACPI=n, so tph_invoke_dsm() returns AE_ERROR and
pcie_tph_get_cpu_st() returns -EINVAL.  It thus looks like you may not
even need an #ifdef.


> diff --git a/drivers/pci/pcie/tph.c b/drivers/pci/pcie/tph.c
> new file mode 100644

The PCIe features added most recently (such as DOE) have been placed
directly in drivers/pci/ instead of the pcie/ subdirectory.
The pcie/ subdirectory mostly deals with port drivers.
So perhaps tph.c should likewise be placed in drivers/pci/ ?


> --- /dev/null
> +++ b/drivers/pci/pcie/tph.c
> @@ -0,0 +1,199 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * TPH (TLP Processing Hints) support
> + *
> + * Copyright (C) 2024 Advanced Micro Devices, Inc.
> + *     Eric Van Tassell <Eric.VanTassell@amd.com>
> + *     Wei Huang <wei.huang2@amd.com>
> + */
> +#include <linux/pci.h>
> +#include <linux/pci-acpi.h>

This patch doesn't seem to use any of the symbols defined in pci-acpi.h,
or did I miss anything?  I'd move the inclusion of pci-acpi.h to the patch
that actually uses its symbols.

Thanks,

Lukas

