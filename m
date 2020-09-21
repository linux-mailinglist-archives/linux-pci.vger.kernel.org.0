Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01789272261
	for <lists+linux-pci@lfdr.de>; Mon, 21 Sep 2020 13:26:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726541AbgIUL0l (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Sep 2020 07:26:41 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2900 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726596AbgIUL0l (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 21 Sep 2020 07:26:41 -0400
Received: from lhreml710-chm.china.huawei.com (unknown [172.18.7.106])
        by Forcepoint Email with ESMTP id BED74476BC36C441F46C;
        Mon, 21 Sep 2020 12:26:39 +0100 (IST)
Received: from localhost (10.52.121.13) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Mon, 21 Sep
 2020 12:26:39 +0100
Date:   Mon, 21 Sep 2020 12:25:00 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Sean V Kelley <sean.v.kelley@intel.com>
CC:     <bhelgaas@google.com>, <rafael.j.wysocki@intel.com>,
        <ashok.raj@intel.com>, <tony.luck@intel.com>,
        <sathyanarayanan.kuppuswamy@intel.com>, <qiuxu.zhuo@intel.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 06/10] PCI/RCEC: Add pcie_link_rcec() to associate
 RCiEPs
Message-ID: <20200921122500.000032ff@Huawei.com>
In-Reply-To: <20200918204603.62100-7-sean.v.kelley@intel.com>
References: <20200918204603.62100-1-sean.v.kelley@intel.com>
        <20200918204603.62100-7-sean.v.kelley@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.52.121.13]
X-ClientProxiedBy: lhreml744-chm.china.huawei.com (10.201.108.194) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, 18 Sep 2020 13:45:59 -0700
Sean V Kelley <sean.v.kelley@intel.com> wrote:

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
A couple of minor things inline plus follow through on not
special casing the older versions of the capability.

Otherwise looks good to me.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

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
> +
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
Perhaps adjust the comment to say:
	/* An RCiEP found on a different bus in range */

as the actual rcec bus can be in the range as I understand it.

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

static, or declare it in a header if we are going to need it elsewhere
later in the series.

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

If you make earlier suggested change go fill in nextbusn = 0xFF
for the earlier versions of the capability can avoid special casing
here.

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

I'm a fusspot on blank lines. The one here doesn't add anything!

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
>  #endif
>  	u8		pcie_cap;	/* PCIe capability offset */
>  	u8		msi_cap;	/* MSI capability offset */


