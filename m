Return-Path: <linux-pci+bounces-10672-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4016293A8E6
	for <lists+linux-pci@lfdr.de>; Tue, 23 Jul 2024 23:50:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 601731C209E0
	for <lists+linux-pci@lfdr.de>; Tue, 23 Jul 2024 21:50:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E90714373B;
	Tue, 23 Jul 2024 21:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZLEnu2BB"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08A5F13D898;
	Tue, 23 Jul 2024 21:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721771443; cv=none; b=hiYNPZUgfFOrW4ryVLquB0QRXY9lU73CDgnloY3jjcy6MESGqwSZ2RaRitfz6VHtM/bchBIyFNtL2e1nYXDMhfHi8dqhz9kNTbACMRLpz6tQxCmu7I0H0DsVkgtwfmw70U9GpCW/urHYXgtjm9PnlLKhOyIp5NVUpUnhJWftxfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721771443; c=relaxed/simple;
	bh=bzv8yP69JRQobNQs9gMg1Wvqa9EoQrlbdR8UpvqyDl8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=BzlPjnoJx/RhP8E1vj3kingyLO9BkQcDTy1RLOJ9CVEm1MKXsN5RsydR1SsH1Va0jn7FNORZomfrMjWbOpBWcKMpwUIVcilXn6ATy8ugxfx+uISI+lZHwNCKmYZuRA9SzPdp5IG7I2ZDou/g9IP0ULBxP14gCAHchCFysI9ax3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZLEnu2BB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 466DAC4AF09;
	Tue, 23 Jul 2024 21:50:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721771442;
	bh=bzv8yP69JRQobNQs9gMg1Wvqa9EoQrlbdR8UpvqyDl8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=ZLEnu2BBkIERneq3aiidNnhmPmlbxBiFs1WNDWeTQokn0M6o8IZrBHhQal7m4LRoB
	 8NBn3cTmHkOixRNp88wsBNQHEgPqikS8mOlsBSMse0MsklOTizqeuarshk3+2YWKu1
	 +NjNFJoIXqElCPCr4MnjLc6u6xoh7YprkTvuOWDhQEMx1WzyIGbylQ9qleXEbMQx91
	 xKimD5TLTIg0608yT/XDMsCKSpHCWFyUX/IDyTULcrpxOB9Lo14V6piw7q5TQpHxw4
	 KKM1kLoMh7mVt+PCgyS5GDycj7TWMTIEFGqwfgI9Kd84HIFHU/Zk+cATlBeBlHcBkA
	 ill/Ng9TeAaug==
Date: Tue, 23 Jul 2024 16:50:40 -0500
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
	bhelgaas@google.com
Subject: Re: [PATCH V3 08/10] PCI/TPH: Add TPH documentation
Message-ID: <20240723215040.GA760037@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240717205511.2541693-9-wei.huang2@amd.com>

On Wed, Jul 17, 2024 at 03:55:09PM -0500, Wei Huang wrote:
> Provide a document for TPH feature, including the description of
> kernel options and driver API interface.
> 
> Co-developed-by: Eric Van Tassell <Eric.VanTassell@amd.com>
> Signed-off-by: Eric Van Tassell <Eric.VanTassell@amd.com>
> Signed-off-by: Wei Huang <wei.huang2@amd.com>
> Reviewed-by: Ajit Khaparde <ajit.khaparde@broadcom.com>
> Reviewed-by: Somnath Kotur <somnath.kotur@broadcom.com>
> Reviewed-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  Documentation/PCI/index.rst          |  1 +
>  Documentation/PCI/tph.rst            | 57 ++++++++++++++++++++++++++++

Wrap file to fit in 80 columns.  Looks like about 86 now, which is
kind of a random size.

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
> index 000000000000..103f4c3251e2
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

I see that this is basically cribbed from sec 6.17, but it sort of
conflates Processing Hints (Bi-directional data structure, Requester,
Target, Target with Priority) with Steering Tags (hints about where to
target a TLP), and "optimize the utilization of platform resources for
the requests" is pretty vague marketing-speak.

I think it might be useful to at least mention the Processing Hints
because the distinction between PH and ST helps motivate the need for
both "pci=notph" and "pci=nostmode".

IIUC, we can enable TPH with the TPH Requester Enable bit, but I don't
see an architected mechanism to control the PH bits in the TLP header.
I assume there might be device-specific ways or it might be built into
the hardware.

Use "Steering Tags" to indicate that this is a term defined by the
spec.

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

I think we should include a spec reference for more details here,
e.g., PCIe r6.0, sec 6.17, 6.17.3.

> +.. code-block:: c
> +
> +    for (i = 0, j = 0; i < nr_rings; i++) {

"j" is not relevant here and makes the example unnecessarily
complicated.

> +        ...
> +        rc = request_irq(irq->vector, irq->handler, flags, irq->name, NULL);
> +        ...
> +        if (!pcie_tph_set_st(pdev, i, cpumask_first(irq->cpu_mask),
> +                             TPH_MEM_TYPE_VM, PCI_TPH_REQ_TPH_ONLY))
> +               pr_err("Error in configuring steering tag\n");

pci_err().  I don't want to encourage drivers to print messages that
have no connection to a specific device.

> +        ...
> +    }
> +
> +The caller is suggested to check if interrupt vector mode is supported using
> +pcie_tph_intr_vec_supported() before updating the steering tags.

I guess this refers to "Interrupt Vector Mode", an ST mode of
operation (PCIe r6.0, sec 6.17.3).  Helpful to style this as
"Interrupt Vector Mode" to indicate that it is a technical term
defined in the spec.

> If a device only
> +supports TPH vendor specific mode, its driver can call pcie_tph_get_st_from_acpi()
> +to retrieve the steering tag for a specific CPU and uses the tag to control TPH
> +behavior.

I'm not sure what "vendor specific mode" refers to here.  If it's the
"Device Specific" ST Mode, use the exact language from the spec to
help people find the details.

> +.. kernel-doc:: drivers/pci/pcie/tph.c
> +   :export:
> +   :identifiers: pcie_tph_intr_vec_supported pcie_tph_get_st_from_acpi pcie_tph_set_st
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
> -- 
> 2.45.1
> 

