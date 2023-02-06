Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3460868C9AF
	for <lists+linux-pci@lfdr.de>; Mon,  6 Feb 2023 23:40:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229895AbjBFWkG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 6 Feb 2023 17:40:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229873AbjBFWkC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 6 Feb 2023 17:40:02 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C27D22FCF2;
        Mon,  6 Feb 2023 14:40:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 74292B8163C;
        Mon,  6 Feb 2023 22:40:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE7C4C4339C;
        Mon,  6 Feb 2023 22:39:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675723199;
        bh=9iz/w8OdItqhWxQdKOH1Ytz58emPE+PUWmHFZOibTSc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=b9T3I81Txdmyxr5E2HUpcPbXDH6MblYxC0TIJBgmNa4vrEqq474a9+nDKO05HogqG
         5VOLWuKOBXucq/V2iLzdd+UvDXAs1qaxcG5g5/K5UZA4I0LjU0VrZeNeJyMcvE/qAf
         iuxKBLlEqcyCGjKDx6GrsXkqVCvSZ1Jfam+eNxK36nGUsUphcV71xb8j8ejIevtwVP
         HPMnXfnhGtBpNsQ18Om+Ial+b0QbW7zAK/iJnhXUvL8mawz6IQfvh1kTe3Q0fNByh0
         SBHNbTTrbFitJWOs4zIZI8J3yhl94C6NiqCL7VZNFAHDISTY3tchBA+4xvN3Dyw3Ut
         Jjnh5cm9jdCGw==
Date:   Mon, 6 Feb 2023 16:39:57 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org, dan.j.williams@intel.com,
        ira.weiny@intel.com, vishal.l.verma@intel.com,
        alison.schofield@intel.com, rafael@kernel.org, bhelgaas@google.com,
        robert.moore@intel.com
Subject: Re: [PATCH 12/18] cxl: Add helpers to calculate pci latency for the
 CXL device
Message-ID: <20230206223957.GA2248946@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <167571666898.587790.4824622451425607591.stgit@djiang5-mobl3.local>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Feb 06, 2023 at 01:51:10PM -0700, Dave Jiang wrote:
> The latency is calculated by dividing the FLIT size over the bandwidth. Add
> support to retrieve the FLIT size for the CXL device and calculate the
> latency of the downstream link.

s/FLIT/flit/ to match spec usage.

Most of this looks like PCIe, not necessarily CXL-specific.

I guess you only care about the latency of a single link, not the
entire path?

> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/cxl/core/pci.c |   67 ++++++++++++++++++++++++++++++++++++++++++++++++
>  drivers/cxl/cxlpci.h   |   14 ++++++++++
>  2 files changed, 81 insertions(+)
> 
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index a24dac36bedd..54ac6f8825ff 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -633,3 +633,70 @@ void read_cdat_data(struct cxl_port *port)
>  	}
>  }
>  EXPORT_SYMBOL_NS_GPL(read_cdat_data, CXL);
> +
> +static int pcie_speed_to_mbps(enum pci_bus_speed speed)
> +{
> +	switch (speed) {
> +	case PCIE_SPEED_2_5GT:
> +		return 2500;
> +	case PCIE_SPEED_5_0GT:
> +		return 5000;
> +	case PCIE_SPEED_8_0GT:
> +		return 8000;
> +	case PCIE_SPEED_16_0GT:
> +		return 16000;
> +	case PCIE_SPEED_32_0GT:
> +		return 32000;
> +	case PCIE_SPEED_64_0GT:
> +		return 64000;
> +	default:
> +		break;
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static int cxl_pci_mbits_to_mbytes(struct pci_dev *pdev)
> +{
> +	int mbits;
> +
> +	mbits = pcie_speed_to_mbps(pcie_get_speed(pdev));
> +	if (mbits < 0)
> +		return mbits;
> +
> +	return mbits >> 3;
> +}
> +
> +static int cxl_get_flit_size(struct pci_dev *pdev)
> +{
> +	if (cxl_pci_flit_256(pdev))
> +		return 256;
> +
> +	return 66;

I don't know about the 66-byte flit format, maybe this part is
CXL-specific?

> + * cxl_pci_get_latency - calculate the link latency for the PCIe link
> + * @pdev - PCI device
> + *
> + * CXL Memory Device SW Guide v1.0 2.11.4 Link latency calculation
> + * Link latency = LinkPropagationLatency + FlitLatency + RetimerLatency
> + * LinkProgationLatency is negligible, so 0 will be used
> + * RetimerLatency is assumed to be neglibible and 0 will be used

s/neglibible/negligible/

> + * FlitLatency = FlitSize / LinkBandwidth
> + * FlitSize is defined by spec. CXL v3.0 4.2.1.
> + * 68B flit is used up to 32GT/s. >32GT/s, 256B flit size is used.
> + * The FlitLatency is converted to pico-seconds.

I guess this means cxl_pci_get_latency() actually *returns* a value in
picoseconds?

There are a couple instances of this written as "pico-seconds", but
most are "picoseconds".

> +long cxl_pci_get_latency(struct pci_dev *pdev)
> +{
> +	long bw, flit_size;
> +
> +	bw = cxl_pci_mbits_to_mbytes(pdev);
> +	if (bw < 0)
> +		return bw;
> +
> +	flit_size = cxl_get_flit_size(pdev);
> +	return flit_size * 1000000L / bw;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_pci_get_latency, CXL);
> diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
> index 920909791bb9..d64a3e0458ab 100644
> --- a/drivers/cxl/cxlpci.h
> +++ b/drivers/cxl/cxlpci.h
> @@ -62,8 +62,22 @@ enum cxl_regloc_type {
>  	CXL_REGLOC_RBI_TYPES
>  };
>  
> +/*
> + * CXL v3.0 6.2.3 Table 6-4

The copy I have refers to *Revision 3.0, Version 1.0*, i.e.,
"Revision" is the major level and "Version" is the minor.  So I would
cite this as "CXL r3.0", not "CXL v3.0".  I suppose the same for CXL
Memory Device above, but I don't have that spec.

> + * The table indicates that if PCIe Flit Mode is set, then CXL is in 256B flits
> + * mode, otherwise it's 68B flits mode.
> + */
> +static inline bool cxl_pci_flit_256(struct pci_dev *pdev)
> +{
> +	u32 lnksta2;
> +
> +	pcie_capability_read_dword(pdev, PCI_EXP_LNKSTA2, &lnksta2);
> +	return lnksta2 & BIT(10);

Add a #define for the bit.

AFAICT, the PCIe spec defines this bit, and it only indicates the link
is or will be operating in Flit Mode; it doesn't actually say anything
about how large the flits are.  I suppose that's because PCIe only
talks about 256B flits, not 66B ones?

Bjorn
