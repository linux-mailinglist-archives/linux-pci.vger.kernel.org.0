Return-Path: <linux-pci+bounces-8463-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 563589009B8
	for <lists+linux-pci@lfdr.de>; Fri,  7 Jun 2024 17:57:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6595D1C23146
	for <lists+linux-pci@lfdr.de>; Fri,  7 Jun 2024 15:57:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DE91199E84;
	Fri,  7 Jun 2024 15:57:00 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 038BE1990D0;
	Fri,  7 Jun 2024 15:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717775820; cv=none; b=t0/C2ByX04vB/upcauDUXdFPGdBPH54IiST/wR/PjjyBZYR5XZ6oiUX+s+MG+zNnbEnBOf2HMMNh9VidxCeOhmNmK6WctpjGrP5QXD+BKi/cwxhBiLsyqbZ32TyCy3Hphepdi3Odg1BLT6POwjyMAAZA/2eCCRtCSaARmeYHQ44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717775820; c=relaxed/simple;
	bh=AvfwU2peuip8Rxw2RQR7kZaaaxxe71BZQ8M6oVTESCo=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U39M26V8kTx6kJ4I317YQm9/qerNkCTkqX/n9HHPW3ZANCWc7P/oqVHwbzS8BtzCSRUfkXMeC9m6/UNDyrla7Tmc0Pm3GZvg6UEm9dcf0W0ooBbaIn12QeXRU7nShZLTh5bFe/ZvzPmoZlluABqDYH7GSjjSvCgGZkJHpwMv7fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Vwm4r0W1zz6D94q;
	Fri,  7 Jun 2024 23:55:40 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 2BF87140A70;
	Fri,  7 Jun 2024 23:56:54 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 7 Jun
 2024 16:56:53 +0100
Date: Fri, 7 Jun 2024 16:56:51 +0100
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
Subject: Re: [PATCH V2 1/9] PCI: Introduce PCIe TPH support framework
Message-ID: <20240607165651.00006554@Huawei.com>
In-Reply-To: <20240531213841.3246055-2-wei.huang2@amd.com>
References: <20240531213841.3246055-1-wei.huang2@amd.com>
	<20240531213841.3246055-2-wei.huang2@amd.com>
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
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Fri, 31 May 2024 16:38:33 -0500
Wei Huang <wei.huang2@amd.com> wrote:

> This patch implements the framework for PCIe TPH support. It introduces
> tph.c source file, along with CONFIG_PCIE_TPH, to Linux PCIe subsystem.
> A new member, named tph_cap, is also introduced in pci_dev to cache TPH
> capability offset.
> 
> Co-developed-by: Eric Van Tassell <Eric.VanTassell@amd.com>
> Signed-off-by: Eric Van Tassell <Eric.VanTassell@amd.com>
> Signed-off-by: Wei Huang <wei.huang2@amd.com>
> Reviewed-by: Ajit Khaparde <ajit.khaparde@broadcom.com>
> Reviewed-by: Somnath Kotur <somnath.kotur@broadcom.com> 
> Reviewed-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>


One trivial comment inline.
With that fixed.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> diff --git a/drivers/pci/pcie/tph.c b/drivers/pci/pcie/tph.c
> new file mode 100644
> index 000000000000..5f0cc06b74bb
> --- /dev/null
> +++ b/drivers/pci/pcie/tph.c
> @@ -0,0 +1,28 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * TPH (TLP Processing Hints) support
> + *
> + * Copyright (C) 2024 Advanced Micro Devices, Inc.
> + *     Eric Van Tassell <Eric.VanTassell@amd.com>
> + *     Wei Huang <wei.huang2@amd.com>
> + */
> +
> +#define pr_fmt(fmt) "TPH: " fmt
> +#define dev_fmt pr_fmt
> +
> +#include <linux/acpi.h>
> +#include <uapi/linux/pci_regs.h>
> +#include <linux/kernel.h>
> +#include <linux/errno.h>
> +#include <linux/msi.h>
> +#include <linux/pci.h>
> +#include <linux/msi.h>
> +#include <linux/pci-acpi.h>

Introduce headers as you first use them.  That way we can more
easily see if there are unused ones in this list.


> +
> +#include "../pci.h"
> +
> +void pcie_tph_init(struct pci_dev *dev)
> +{
> +	dev->tph_cap = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_TPH);
> +}
> +
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 15168881ec94..1f1ae55a5f83 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -2484,6 +2484,7 @@ static void pci_init_capabilities(struct pci_dev *dev)
>  	pci_dpc_init(dev);		/* Downstream Port Containment */
>  	pci_rcec_init(dev);		/* Root Complex Event Collector */
>  	pci_doe_init(dev);		/* Data Object Exchange */
> +	pcie_tph_init(dev);             /* TLP Processing Hints */
>  
>  	pcie_report_downtraining(dev);
>  	pci_init_reset_methods(dev);
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 5bece7fd11f8..d75a88ec5136 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -530,6 +530,10 @@ struct pci_dev {
>  
>  	/* These methods index pci_reset_fn_methods[] */
>  	u8 reset_methods[PCI_NUM_RESET_METHODS]; /* In priority order */
> +
> +#ifdef CONFIG_PCIE_TPH
> +	u16 tph_cap; /* TPH capability offset */
> +#endif
>  };
>  
>  static inline struct pci_dev *pci_physfn(struct pci_dev *dev)


