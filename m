Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B27C7419D5E
	for <lists+linux-pci@lfdr.de>; Mon, 27 Sep 2021 19:47:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237940AbhI0RtN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 27 Sep 2021 13:49:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:57252 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238171AbhI0RsW (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 27 Sep 2021 13:48:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D90CF60FBF;
        Mon, 27 Sep 2021 17:46:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632764804;
        bh=H8Mj81WyvY+HesKTc7Fr+jbrmn+2nM8SxLPaQtOgGIk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=ZittX7dsrCxpUqN8o37oZKbtwhDDRSMGteLP7htIcE97ezSL5hLEWtgtFTfMftD4e
         CYwr2z84HijxnJHnlx2Vr2XnnnUzJnIHQBlphYKAODAoFWl2WYj56rnXzj1UAcmrvA
         1jlqXZrF6dDHlMQ2+bXx4Iinc4r6Hy4KkHIBwTcgeRtx+LXtO2yw8W1A3qGL+pMzx6
         cMEZDA5ncBnXfuv1FmQRVuR7TMh1aiOkPpFQXGM3BmoRWzKuKqw+UVVGa3SQ/ddu5A
         yBrQyDHe//KBx0FqVPhl76WYY/CsBta3w+VoXlryUBMj4/yxoHSpV15GYjV8aQ/7BF
         r1L7xhiACVKEQ==
Date:   Mon, 27 Sep 2021 12:46:42 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Ben Widawsky <ben.widawsky@intel.com>
Cc:     linux-cxl@vger.kernel.org,
        "David E . Box" <david.e.box@linux.intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Andrew Donnellan <ajd@linux.ibm.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Frederic Barrat <fbarrat@linux.ibm.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        iommu@lists.linux-foundation.org
Subject: Re: [PATCH v2 6/9] PCI: Add pci_find_dvsec_capability to find
 designated VSEC
Message-ID: <20210927174642.GA661147@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210923172647.72738-7-ben.widawsky@intel.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

s/pci_find_dvsec_capability/pci_find_dvsec_capability()/ in subject
and commit log.

On Thu, Sep 23, 2021 at 10:26:44AM -0700, Ben Widawsky wrote:
> Add pci_find_dvsec_capability to locate a Designated Vendor-Specific
> Extended Capability with the specified DVSEC ID.

"specified Vendor ID and Capability ID".

> The Designated Vendor-Specific Extended Capability (DVSEC) allows one or
> more vendor specific capabilities that aren't tied to the vendor ID of
> the PCI component.
> 
> DVSEC is critical for both the Compute Express Link (CXL) driver as well
> as the driver for OpenCAPI coherent accelerator (OCXL).

Strictly speaking, not really relevant for the commit log.

> Cc: David E. Box <david.e.box@linux.intel.com>
> Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: linux-pci@vger.kernel.org
> Cc: linuxppc-dev@lists.ozlabs.org
> Cc: Andrew Donnellan <ajd@linux.ibm.com>
> Cc: Lu Baolu <baolu.lu@linux.intel.com>
> Reviewed-by: Frederic Barrat <fbarrat@linux.ibm.com>
> Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>

If you want to merge this with the series,

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

Or if you want me to merge this on a branch, let me know.

> ---
>  drivers/pci/pci.c   | 32 ++++++++++++++++++++++++++++++++
>  include/linux/pci.h |  1 +
>  2 files changed, 33 insertions(+)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index ce2ab62b64cf..94ac86ff28b0 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -732,6 +732,38 @@ u16 pci_find_vsec_capability(struct pci_dev *dev, u16 vendor, int cap)
>  }
>  EXPORT_SYMBOL_GPL(pci_find_vsec_capability);
>  
> +/**
> + * pci_find_dvsec_capability - Find DVSEC for vendor
> + * @dev: PCI device to query
> + * @vendor: Vendor ID to match for the DVSEC
> + * @dvsec: Designated Vendor-specific capability ID
> + *
> + * If DVSEC has Vendor ID @vendor and DVSEC ID @dvsec return the capability
> + * offset in config space; otherwise return 0.
> + */
> +u16 pci_find_dvsec_capability(struct pci_dev *dev, u16 vendor, u16 dvsec)
> +{
> +	int pos;
> +
> +	pos = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_DVSEC);
> +	if (!pos)
> +		return 0;
> +
> +	while (pos) {
> +		u16 v, id;
> +
> +		pci_read_config_word(dev, pos + PCI_DVSEC_HEADER1, &v);
> +		pci_read_config_word(dev, pos + PCI_DVSEC_HEADER2, &id);
> +		if (vendor == v && dvsec == id)
> +			return pos;
> +
> +		pos = pci_find_next_ext_capability(dev, pos, PCI_EXT_CAP_ID_DVSEC);
> +	}
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(pci_find_dvsec_capability);
> +
>  /**
>   * pci_find_parent_resource - return resource region of parent bus of given
>   *			      region
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index cd8aa6fce204..c93ccfa4571b 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -1130,6 +1130,7 @@ u16 pci_find_ext_capability(struct pci_dev *dev, int cap);
>  u16 pci_find_next_ext_capability(struct pci_dev *dev, u16 pos, int cap);
>  struct pci_bus *pci_find_next_bus(const struct pci_bus *from);
>  u16 pci_find_vsec_capability(struct pci_dev *dev, u16 vendor, int cap);
> +u16 pci_find_dvsec_capability(struct pci_dev *dev, u16 vendor, u16 dvsec);
>  
>  u64 pci_get_dsn(struct pci_dev *dev);
>  
> -- 
> 2.33.0
> 
