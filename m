Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13E012793FF
	for <lists+linux-pci@lfdr.de>; Sat, 26 Sep 2020 00:15:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728431AbgIYWPo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 25 Sep 2020 18:15:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:49874 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728171AbgIYWPn (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 25 Sep 2020 18:15:43 -0400
Received: from localhost (52.sub-72-107-123.myvzw.com [72.107.123.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8C4C820809;
        Fri, 25 Sep 2020 22:15:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601072143;
        bh=2hOV9JcU0J5teRkwVCkPUAdtrzsWK+/gvtfXSFG9gKI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=RcIyO0tBv5W8bvTSwQuG+AmEbMYPIgticU24c5R6clNFnWEZOUEmotZ6v0c3OJd87
         c0fqGPjVWEpqUBqVonwUPPNetdlWFxKZrfmKencCLDtHrklWXCxrO+lmwTUXhfx0Hs
         xQWr1ExTU3yA4Sg4BSZxvNFHoI2cIvhma1c71mSQ=
Date:   Fri, 25 Sep 2020 17:15:40 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Sean V Kelley <seanvk.dev@oregontracks.org>
Cc:     bhelgaas@google.com, Jonathan.Cameron@huawei.com,
        rafael.j.wysocki@intel.com, ashok.raj@intel.com,
        tony.luck@intel.com, sathyanarayanan.kuppuswamy@intel.com,
        qiuxu.zhuo@intel.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sean V Kelley <sean.v.kelley@intel.com>
Subject: Re: [PATCH v6 06/10] PCI/RCEC: Add pcie_link_rcec() to associate
 RCiEPs
Message-ID: <20200925221540.GA2460947@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200922213859.108826-7-seanvk.dev@oregontracks.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Sep 22, 2020 at 02:38:55PM -0700, Sean V Kelley wrote:
> From: Sean V Kelley <sean.v.kelley@intel.com>
> 
> A Root Complex Event Collector provides support for
> terminating error and PME messages from associated RCiEPs.
> 
> Make use of the RCEC Endpoint Association Extended Capability
> to identify associated RCiEPs. Link the associated RCiEPs as
> the RCECs are enumerated.
> 
> Co-developed-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
> Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
> Signed-off-by: Sean V Kelley <sean.v.kelley@intel.com>
> ---
>  drivers/pci/pci.h              |  2 +
>  drivers/pci/pcie/portdrv_pci.c |  3 ++
>  drivers/pci/pcie/rcec.c        | 96 ++++++++++++++++++++++++++++++++++
>  include/linux/pci.h            |  1 +
>  4 files changed, 102 insertions(+)
> 
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 7b547fc3679a..ddb5872466fb 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -474,9 +474,11 @@ static inline void pci_dpc_init(struct pci_dev *pdev) {}
>  #ifdef CONFIG_PCIEPORTBUS
>  void pci_rcec_init(struct pci_dev *dev);
>  void pci_rcec_exit(struct pci_dev *dev);
> +void pcie_link_rcec(struct pci_dev *rcec);
>  #else
>  static inline void pci_rcec_init(struct pci_dev *dev) {}
>  static inline void pci_rcec_exit(struct pci_dev *dev) {}
> +static inline void pcie_link_rcec(struct pci_dev *rcec) {}
>  #endif
>  
>  #ifdef CONFIG_PCI_ATS
> diff --git a/drivers/pci/pcie/portdrv_pci.c b/drivers/pci/pcie/portdrv_pci.c
> index 4d880679b9b1..dbeb0155c2c3 100644
> --- a/drivers/pci/pcie/portdrv_pci.c
> +++ b/drivers/pci/pcie/portdrv_pci.c
> @@ -110,6 +110,9 @@ static int pcie_portdrv_probe(struct pci_dev *dev,
>  	     (pci_pcie_type(dev) != PCI_EXP_TYPE_RC_EC)))
>  		return -ENODEV;
>  
> +	if (pci_pcie_type(dev) == PCI_EXP_TYPE_RC_EC)
> +		pcie_link_rcec(dev);

Nice solution.  One day we'll get rid of pcie_portdrv_probe() and
integrate this stuff better into the PCI core, and we'll have to
figure out a little different solution then.  But we'll be smarter
then so it should be possible :)

>  	status = pcie_port_device_register(dev);
>  	if (status)
>  		return status;
> diff --git a/drivers/pci/pcie/rcec.c b/drivers/pci/pcie/rcec.c
> index 519ae086ff41..5630480a6659 100644
> --- a/drivers/pci/pcie/rcec.c
> +++ b/drivers/pci/pcie/rcec.c
> @@ -17,6 +17,102 @@
>  
>  #include "../pci.h"
>  
> +struct walk_rcec_data {
> +	struct pci_dev *rcec;
> +	int (*user_callback)(struct pci_dev *dev, void *data);
> +	void *user_data;
> +};
> +
> +static bool rcec_assoc_rciep(struct pci_dev *rcec, struct pci_dev *rciep)
> +{
> +	unsigned long bitmap = rcec->rcec_ext->bitmap;
> +	unsigned int devn;
> +
> +	/* An RCiEP found on bus in range */
> +	if (rcec->bus->number != rciep->bus->number)
> +		return true;
> +
> +	/* Same bus, so check bitmap */
> +	for_each_set_bit(devn, &bitmap, 32)
> +		if (devn == rciep->devfn)
> +			return true;
> +
> +	return false;
> +}
> +
> +static int link_rcec_helper(struct pci_dev *dev, void *data)
> +{
> +	struct walk_rcec_data *rcec_data = data;
> +	struct pci_dev *rcec = rcec_data->rcec;
> +
> +	if ((pci_pcie_type(dev) == PCI_EXP_TYPE_RC_END) && rcec_assoc_rciep(rcec, dev)) {
> +		dev->rcec = rcec;
> +		pci_dbg(dev, "PME & error events reported via %s\n", pci_name(rcec));
> +	}
> +
> +	return 0;
> +}
> +
> +void walk_rcec(int (*cb)(struct pci_dev *dev, void *data), void *userdata)
> +{
> +	struct walk_rcec_data *rcec_data = userdata;
> +	struct pci_dev *rcec = rcec_data->rcec;
> +	u8 nextbusn, lastbusn;
> +	struct pci_bus *bus;
> +	unsigned int bnr;
> +
> +	if (!rcec->rcec_cap)
> +		return;
> +
> +	/* Walk own bus for bitmap based association */
> +	pci_walk_bus(rcec->bus, cb, rcec_data);
> +
> +	/* Check whether RCEC BUSN register is present */
> +	if (rcec->rcec_ext->ver < PCI_RCEC_BUSN_REG_VER)
> +		return;
> +
> +	nextbusn = rcec->rcec_ext->nextbusn;
> +	lastbusn = rcec->rcec_ext->lastbusn;
> +
> +	/* All RCiEP devices are on the same bus as the RCEC */
> +	if (nextbusn == 0xff && lastbusn == 0x00)
> +		return;
> +
> +	for (bnr = nextbusn; bnr <= lastbusn; bnr++) {
> +		/* No association indicated (PCIe 5.0-1, 7.9.10.3) */
> +		if (bnr == rcec->bus->number)
> +			continue;
> +
> +		bus = pci_find_bus(pci_domain_nr(rcec->bus), bnr);
> +		if (!bus)
> +			continue;
> +
> +		/* Find RCiEP devices on the given bus ranges */
> +		pci_walk_bus(bus, cb, rcec_data);
> +	}
> +}
> +
> +/**
> + * pcie_link_rcec - Link RCiEP devices associating with RCEC.
> + * @rcec     RCEC whose RCiEP devices should be linked.
> + *
> + * Link the given RCEC to each RCiEP device found.
> + *
> + */
> +void pcie_link_rcec(struct pci_dev *rcec)
> +{
> +	struct walk_rcec_data rcec_data;
> +
> +	if (!rcec->rcec_cap)
> +		return;
> +
> +	rcec_data.rcec = rcec;
> +	rcec_data.user_callback = NULL;
> +	rcec_data.user_data = NULL;
> +
> +	walk_rcec(link_rcec_helper, &rcec_data);
> +}
> +
>  void pci_rcec_init(struct pci_dev *dev)
>  {
>  	u32 rcec, hdr, busn;
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 5c5c4eb642b6..ad382a9484ea 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -330,6 +330,7 @@ struct pci_dev {
>  #ifdef CONFIG_PCIEPORTBUS
>  	u16		rcec_cap;	/* RCEC capability offset */
>  	struct rcec_ext *rcec_ext;	/* RCEC cached assoc. endpoint extended capabilities */
> +	struct pci_dev  *rcec;          /* Associated RCEC device */

Wondering if we can put this pointer inside the struct rcec_ext (or
whatever we call it) so we don't have to pay *two* pointers for every
PCI device?  Maybe it should be something like this:

  struct rcec {
    u8			ea_ver;
    u8			ea_nextbusn;
    u8			ea_lastbusn;
    u32			ea_bitmap;
    struct pci_dev	*rcec;
  }

I dunno.  Not sure if that would be better or worse, since we'd be
mixing RCEC stuff (the EA capability info) with RCiEP stuff (the
pointer to the related RCEC).  Could even be a union, since any given
device only needs one of them, but I'm pretty sure that would be
worse.

BTW, 03/10 didn't add a forward declaration, e.g.,

  struct rcec_ext;

to include/linux/pci.h, and the actual definition is in
drivers/pci/pci.h.  It seems like you should need that?

>  #endif
>  	u8		pcie_cap;	/* PCIe capability offset */
>  	u8		msi_cap;	/* MSI capability offset */
> -- 
> 2.28.0
> 
