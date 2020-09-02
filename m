Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11FAC25B42C
	for <lists+linux-pci@lfdr.de>; Wed,  2 Sep 2020 21:00:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726567AbgIBTAE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 2 Sep 2020 15:00:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:54314 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726124AbgIBTAE (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 2 Sep 2020 15:00:04 -0400
Received: from localhost (47.sub-72-107-117.myvzw.com [72.107.117.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6FA58208C7;
        Wed,  2 Sep 2020 19:00:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599073203;
        bh=m7dab6zgYPsBP10ZzjOLqWiJXikP+vtrxyKVWAUKSzw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=IMG1STsFQZ86rslUzvSvPWR68C/6MnVb8PoDM7TPcxfjN83ri7YqR7uODaoGYabJS
         Ve4z+bByFXF1BT8/9SUYsoQW9Xo0B9YRUmfzaVNu2IWvqoUMu+QrTQ6ARPsWS4Wkhb
         v9MRbQlUPt/YkDRKCpKmoiBrl2pt4LoZOQ2WPcww=
Date:   Wed, 2 Sep 2020 14:00:00 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Sean V Kelley <sean.v.kelley@intel.com>
Cc:     bhelgaas@google.com, Jonathan.Cameron@huawei.com,
        rjw@rjwysocki.net, ashok.raj@intel.com, tony.luck@intel.com,
        sathyanarayanan.kuppuswamy@linux.intel.com, qiuxu.zhuo@intel.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 04/10] PCI/RCEC: Add pcie_walk_rcec() to walk
 associated RCiEPs
Message-ID: <20200902190000.GA204399@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200812164659.1118946-5-sean.v.kelley@intel.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Aug 12, 2020 at 09:46:53AM -0700, Sean V Kelley wrote:
> From: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
> 
> When an RCEC device signals error(s) to a CPU core, the CPU core
> needs to walk all the RCiEPs associated with that RCEC to check
> errors. So add the function pcie_walk_rcec() to walk all RCiEPs
> associated with the RCEC device.
> 
> Co-developed-by: Sean V Kelley <sean.v.kelley@intel.com>
> Signed-off-by: Sean V Kelley <sean.v.kelley@intel.com>
> Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  drivers/pci/pci.h       |  4 +++
>  drivers/pci/pcie/rcec.c | 76 +++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 80 insertions(+)
> 
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index bd25e6047b54..8bd7528d6977 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -473,9 +473,13 @@ static inline void pci_dpc_init(struct pci_dev *pdev) {}
>  #ifdef CONFIG_PCIEPORTBUS
>  void pci_rcec_init(struct pci_dev *dev);
>  void pci_rcec_exit(struct pci_dev *dev);
> +void pcie_walk_rcec(struct pci_dev *rcec, int (*cb)(struct pci_dev *, void *),
> +		    void *userdata);
>  #else
>  static inline void pci_rcec_init(struct pci_dev *dev) {}
>  static inline void pci_rcec_exit(struct pci_dev *dev) {}
> +static inline void pcie_walk_rcec(struct pci_dev *rcec, int (*cb)(struct pci_dev *, void *),
> +				  void *userdata) {}
>  #endif
>  
>  #ifdef CONFIG_PCI_ATS
> diff --git a/drivers/pci/pcie/rcec.c b/drivers/pci/pcie/rcec.c
> index 519ae086ff41..405f92fcdf7f 100644
> --- a/drivers/pci/pcie/rcec.c
> +++ b/drivers/pci/pcie/rcec.c
> @@ -17,6 +17,82 @@
>  
>  #include "../pci.h"
>  
> +static int pcie_walk_rciep_devfn(struct pci_bus *bus, int (*cb)(struct pci_dev *, void *),
> +				 void *userdata, const unsigned long bitmap)
> +{
> +	unsigned int devn, fn;
> +	struct pci_dev *dev;
> +	int retval;
> +
> +	for_each_set_bit(devn, &bitmap, 32) {
> +		for (fn = 0; fn < 8; fn++) {
> +			dev = pci_get_slot(bus, PCI_DEVFN(devn, fn));

Wow, this is a lot of churning to call pci_get_slot() 256 times per
bus for the "associated bus numbers" case where we pass a bitmap of
0xffffffff.  They didn't really make it easy for software when they
added the next/last bus number thing.

Just thinking out loud here.  What if we could set dev->rcec during
enumeration, and then use that to build pcie_walk_rcec()?

  bool rcec_assoc_rciep(rcec, rciep)
  {
    if (rcec->bus == rciep->bus)
      return (rcec->bitmap contains rciep->devfn);

    return (rcec->next/last contains rciep->bus);
  }

  link_rcec(dev, data)
  {
    struct pci_dev *rcec = data;

    if ((dev is RCiEP) && rcec_assoc_rciep(rcec, dev))
      dev->rcec = rcec;
  }

  find_rcec(dev, data)
  {
    struct pci_dev *rciep = data;

    if ((dev is RCEC) && rcec_assoc_rciep(dev, rciep))
      rciep->rcec = dev;
  }

  pci_setup_device
    ...
      if (dev is RCEC) {
	pci_rcec_init(dev)		# cache bitmap, next/last bus #
	pci_walk_bus(root_bus, link_rcec, dev); # link any RCiEP already found
      }
      if (dev is RCiEP) {
	pci_walk_bus(root_bus, find_rcec, dev); # link any RCEC already found
      }

Now we should have a valid dev->rcec for everything we've enumerated.

  struct walk_rcec_data {
    struct pci_dev *rcec;
    ... user_callback;
    void *user_data;
  };

  pcie_rcec_helper(dev, callback, data)
  {
    struct walk_rcec_data *rcec_data = data;

    if (dev->rcec == rcec_data->rcec)
      rcec_data->user_callback(dev, rcec_data->user_data);
  }

  pcie_walk_rcec(rcec, callback, data)
  {
    struct walk_rcec_data rcec_data;
    ...
    rcec_data.rcec = rcec;
    rcec_data.user_callback = callback;
    rcec_data.user_data = data;
    pci_walk_bus(root_bus, pcie_rcec_helper, &rcec_data);
  }

I hate having to walk the bus so many times, but I do like the fact
that in the runtime path (pcie_walk_rcec()) we don't have to do 256
pci_get_slot() calls per bus, almost all of which are going to fail.

> +			if (!dev)
> +				continue;
> +
> +			if (pci_pcie_type(dev) != PCI_EXP_TYPE_RC_END) {
> +				pci_dev_put(dev);
> +				continue;
> +			}
> +
> +			retval = cb(dev, userdata);
> +			pci_dev_put(dev);
> +			if (retval)
> +				return retval;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +/**
> + * pcie_walk_rcec - Walk RCiEP devices associating with RCEC and call callback.
> + * @rcec     RCEC whose RCiEP devices should be walked.
> + * @cb       Callback to be called for each RCiEP device found.
> + * @userdata Arbitrary pointer to be passed to callback.
> + *
> + * Walk the given RCEC. Call the provided callback on each RCiEP device found.
> + *
> + * We check the return of @cb each time. If it returns anything
> + * other than 0, we break out.
> + */
> +void pcie_walk_rcec(struct pci_dev *rcec, int (*cb)(struct pci_dev *, void *),
> +		    void *userdata)
> +{
> +	u8 nextbusn, lastbusn;
> +	struct pci_bus *bus;
> +	unsigned int bnr;
> +
> +	if (!rcec->rcec_cap)
> +		return;
> +
> +	/* Find RCiEP devices on the same bus as the RCEC */
> +	if (pcie_walk_rciep_devfn(rcec->bus, cb, userdata, rcec->rcec_ext->bitmap))
> +		return;
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

I think we also need to skip the RCEC bus here, don't we?  7.9.10.3
says the Associated Bus Numbers register does not indicate association
between an EC and any Function on the same bus number as the EC
itself.  Something like this:

  if (bnr == rcec->bus->number)
    continue;

> +		bus = pci_find_bus(pci_domain_nr(rcec->bus), bnr);
> +		if (!bus)
> +			continue;
> +
> +		/* Find RCiEP devices on the given bus */
> +		if (pcie_walk_rciep_devfn(bus, cb, userdata, 0xffffffff))
> +			return;
> +	}
> +}
> +
>  void pci_rcec_init(struct pci_dev *dev)
>  {
>  	u32 rcec, hdr, busn;
> -- 
> 2.28.0
> 
