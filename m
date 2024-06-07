Return-Path: <linux-pci+bounces-8474-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D5885900B73
	for <lists+linux-pci@lfdr.de>; Fri,  7 Jun 2024 19:43:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13EBC28B6F0
	for <lists+linux-pci@lfdr.de>; Fri,  7 Jun 2024 17:43:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94FFE19ADAD;
	Fri,  7 Jun 2024 17:43:37 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E71119AD56;
	Fri,  7 Jun 2024 17:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717782217; cv=none; b=Tv1w921oDj6QZrnPMFN3++coHTiqPITjSNQ/oFLeHZwZWFHzDS0T/rOEHMRvyuWbOm/cldZnQheC3qkSo/0rKOsrsWL7NQ7eRYtZXRJvsBYB+E1r/6rxDZ7F7cauoAHhfsuzLSDNAmTyZh0umCWahuw2PNFkGHJ5cLgEbrjp10E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717782217; c=relaxed/simple;
	bh=fqvbyEdkiheu3Y3sbPvhK1sNPqECpIq6Z0OC2KEKcNA=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TMG3H+V1/0ZMWs6yCJVy0PRkN+QRdS2vpIaAp0ZbmLLxC3FynOE6RcAfhNjjCmx9ca7R5ALTP9uxtqbhDUIayEMl/KZQpfO/yMr19bDEt+8wlvVfhzh4qXYb74KkZRHI+goHNKF8p83mW3g0mHociCxxwj6BpsQNYxSCvPMQGDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VwpND3DRkz6J9dh;
	Sat,  8 Jun 2024 01:39:08 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 1D2601402CB;
	Sat,  8 Jun 2024 01:43:33 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 7 Jun
 2024 18:43:32 +0100
Date: Fri, 7 Jun 2024 18:43:31 +0100
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
Subject: Re: [PATCH V2 7/9] PCI/TPH: Add TPH documentation
Message-ID: <20240607184331.00000fa0@Huawei.com>
In-Reply-To: <20240531213841.3246055-8-wei.huang2@amd.com>
References: <20240531213841.3246055-1-wei.huang2@amd.com>
	<20240531213841.3246055-8-wei.huang2@amd.com>
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
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Fri, 31 May 2024 16:38:39 -0500
Wei Huang <wei.huang2@amd.com> wrote:

> Provide a document for TPH feature, including the description of
> kernel options and driver API interface.
> 
> Co-developed-by: Eric Van Tassell <Eric.VanTassell@amd.com>
> Signed-off-by: Eric Van Tassell <Eric.VanTassell@amd.com>
> Signed-off-by: Wei Huang <wei.huang2@amd.com>
> Reviewed-by: Ajit Khaparde <ajit.khaparde@broadcom.com>
> Reviewed-by: Somnath Kotur <somnath.kotur@broadcom.com> 
> Reviewed-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
Sort and sweet.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  Documentation/PCI/index.rst          |  1 +
>  Documentation/PCI/tph.rst            | 57 ++++++++++++++++++++++++++++
>  Documentation/driver-api/pci/pci.rst |  3 ++
>  3 files changed, 61 insertions(+)
>  create mode 100644 Documentation/PCI/tph.rst
> 
> diff --git a/Documentation/PCI/index.rst b/Documentation/PCI/index.rst
> index e73f84aebde3..5e7c4e6e726b 100644
> --- a/Documentation/PCI/index.rst
> +++ b/Documentation/PCI/index.rst
> @@ -18,3 +18,4 @@ PCI Bus Subsystem
>     pcieaer-howto
>     endpoint/index
>     boot-interrupts
> +   tph
> diff --git a/Documentation/PCI/tph.rst b/Documentation/PCI/tph.rst
> new file mode 100644
> index 000000000000..ea9c8313f3e4
> --- /dev/null
> +++ b/Documentation/PCI/tph.rst
> @@ -0,0 +1,57 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +===========
> +TPH Support
> +===========
> +
> +
> +:Copyright: 2024 Advanced Micro Devices, Inc.
> +:Authors: - Eric van Tassell <eric.vantassell@amd.com>
> +          - Wei Huang <wei.huang2@amd.com>
> +
> +Overview
> +========
> +TPH (TLP Processing Hints) is a PCIe feature that allows endpoint devices
> +to provide optimization hints, such as desired caching behavior, for
> +requests that target memory space. These hints, in a format called steering
> +tags, are provided in the requester's TLP headers and can empower the system
> +hardware, including the Root Complex, to optimize the utilization of platform
> +resources for the requests.
> +
> +User Guide
> +==========
> +
> +Kernel Options
> +--------------
> +There are two kernel command line options available to control TPH feature
> +
> +   * "notph": TPH will be disabled for all endpoint devices.
> +   * "nostmode": TPH will be enabled but the ST Mode will be forced to "No ST Mode".
> +
> +Device Driver API
> +-----------------
> +In brief, an endpoint device driver using the TPH interface to configure
> +Interrupt Vector Mode will call pcie_tph_set_st() when setting up MSI-X
> +interrupts as shown below:
> +
> +.. code-block:: c
> +
> +    for (i = 0, j = 0; i < nr_rings; i++) {
> +        ...
> +        rc = request_irq(irq->vector, irq->handler, flags, irq->name, NULL);
> +        ...
> +        if (!pcie_tph_set_st(pdev, i, cpumask_first(irq->cpu_mask),
> +                             TPH_MEM_TYPE_VM, PCI_TPH_REQ_TPH_ONLY))
> +               pr_err("Error in configuring steering tag\n");
> +        ...
> +    }
> +
> +If a device only supports TPH vendor specific mode, its driver can call
> +pcie_tph_get_st() to retrieve the steering tag for a specific CPU and uses
> +the tag to control TPH behavior.
> +
> +.. kernel-doc:: drivers/pci/pcie/tph.c
> +   :export:
> +
> +.. kernel-doc:: drivers/pci/pcie/tph.c
> +   :identifiers: pcie_tph_set_st
> diff --git a/Documentation/driver-api/pci/pci.rst b/Documentation/driver-api/pci/pci.rst
> index aa40b1cc243b..3d896b2cf16e 100644
> --- a/Documentation/driver-api/pci/pci.rst
> +++ b/Documentation/driver-api/pci/pci.rst
> @@ -46,6 +46,9 @@ PCI Support Library
>  .. kernel-doc:: drivers/pci/pci-sysfs.c
>     :internal:
>  
> +.. kernel-doc:: drivers/pci/pcie/tph.c
> +   :export:
> +
>  PCI Hotplug Support Library
>  ---------------------------
>  


