Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FBD922EB2F
	for <lists+linux-pci@lfdr.de>; Mon, 27 Jul 2020 13:25:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727037AbgG0LZX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 27 Jul 2020 07:25:23 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2534 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726967AbgG0LZX (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 27 Jul 2020 07:25:23 -0400
Received: from lhreml710-chm.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id EC015FC00B6E85392BDD;
        Mon, 27 Jul 2020 12:25:21 +0100 (IST)
Received: from localhost (10.52.121.176) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1913.5; Mon, 27 Jul
 2020 12:25:21 +0100
Date:   Mon, 27 Jul 2020 12:23:58 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Sean V Kelley <sean.v.kelley@intel.com>
CC:     <bhelgaas@google.com>, <rjw@rjwysocki.net>, <ashok.raj@kernel.org>,
        <tony.luck@intel.com>,
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Subject: Re: [RFC PATCH 6/9] PCI: Add 'rcec' field to pci_dev for associated
 RCiEPs
Message-ID: <20200727122358.00006c23@Huawei.com>
In-Reply-To: <20200724172223.145608-7-sean.v.kelley@intel.com>
References: <20200724172223.145608-1-sean.v.kelley@intel.com>
        <20200724172223.145608-7-sean.v.kelley@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.52.121.176]
X-ClientProxiedBy: lhreml704-chm.china.huawei.com (10.201.108.53) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, 24 Jul 2020 10:22:20 -0700
Sean V Kelley <sean.v.kelley@intel.com> wrote:

> From: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
> 
> When attempting error recovery for an RCiEP associated with an RCEC device,
> there needs to be a way to update the Root Error Status, the Uncorrectable
> Error Status and the Uncorrectable Error Severity of the parent RCEC.
> So add the 'rcec' field to the pci_dev structure and provide a hook for the
> Root Port Driver to associate RCiEPs with their respective parent RCEC.
> 
> Co-developed-by: Sean V Kelley <sean.v.kelley@intel.com>
> Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
> Signed-off-by: Sean V Kelley <sean.v.kelley@intel.com>

I haven't tested yet, but I think there is one path in here that breaks
my case (no OS visible rcec / all done in firmware GHESv2 / APEI)

Jonathan

> ---
>  drivers/pci/pcie/aer.c         |  9 +++++----
>  drivers/pci/pcie/err.c         |  9 +++++++++
>  drivers/pci/pcie/portdrv_pci.c | 15 +++++++++++++++
>  include/linux/pci.h            |  3 +++
>  4 files changed, 32 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index 3acf56683915..f1bf06be449e 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -1335,17 +1335,18 @@ static int aer_probe(struct pcie_device *dev)
>  static pci_ers_result_t aer_root_reset(struct pci_dev *dev)
>  {
>  	int aer = dev->aer_cap;
> +	int rc = 0;
>  	u32 reg32;
> -	int rc;
> -
>  
>  	/* Disable Root's interrupt in response to error messages */
>  	pci_read_config_dword(dev, aer + PCI_ERR_ROOT_COMMAND, &reg32);
>  	reg32 &= ~ROOT_PORT_INTR_ON_MESG_MASK;
>  	pci_write_config_dword(dev, aer + PCI_ERR_ROOT_COMMAND, reg32);
>  
> -	rc = pci_bus_error_reset(dev);
> -	pci_info(dev, "Root Port link has been reset\n");
> +	if (pci_pcie_type(dev) != PCI_EXP_TYPE_RC_EC) {
> +		rc = pci_bus_error_reset(dev);
> +		pci_info(dev, "Root Port link has been reset\n");
> +	}
>  
>  	/* Clear Root Error Status */
>  	pci_read_config_dword(dev, aer + PCI_ERR_ROOT_STATUS, &reg32);
> diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
> index 9b3ec94bdf1d..0aae7643132e 100644
> --- a/drivers/pci/pcie/err.c
> +++ b/drivers/pci/pcie/err.c
> @@ -203,6 +203,11 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
>  		pci_walk_dev_affected(dev, report_frozen_detected, &status);
>  		if (pci_pcie_type(dev) == PCI_EXP_TYPE_RC_END) {
>  			status = flr_on_rciep(dev);
> +			/*
> +			 * The callback only clears the Root Error Status
> +			 * of the RCEC (see aer.c).
> +			 */
> +			reset_link(dev->rcec);

This looks dangerous for my case where APEI / GHESv2 is used.  In that case
we don't expose an RCEC at all.   I don't think the reset_link callback
is safe to a null pointer here.  Fix may be as simple as
if (dev->rcec)
	reset_link(dev->rcec);


>  			if (status != PCI_ERS_RESULT_RECOVERED) {
>  				pci_warn(dev, "function level reset failed\n");
>  				goto failed;
> @@ -246,7 +251,11 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
>  	     pci_pcie_type(dev) == PCI_EXP_TYPE_RC_EC)) {
>  		pci_aer_clear_device_status(dev);
>  		pci_aer_clear_nonfatal_status(dev);
> +	} else if (pci_pcie_type(dev) == PCI_EXP_TYPE_RC_END) {
> +		pci_aer_clear_device_status(dev->rcec);
> +		pci_aer_clear_nonfatal_status(dev->rcec);

These may be safe as in my both now have protections for !pcie_aer_is_native.

>  	}
> +
>  	pci_info(dev, "device recovery successful\n");
>  	return status;
>  
> diff --git a/drivers/pci/pcie/portdrv_pci.c b/drivers/pci/pcie/portdrv_pci.c
> index d5b109499b10..f9409a0110c2 100644
> --- a/drivers/pci/pcie/portdrv_pci.c
> +++ b/drivers/pci/pcie/portdrv_pci.c
> @@ -90,6 +90,18 @@ static const struct dev_pm_ops pcie_portdrv_pm_ops = {
>  #define PCIE_PORTDRV_PM_OPS	NULL
>  #endif /* !PM */
>  
> +static int pcie_hook_rcec(struct pci_dev *pdev, void *data)
> +{
> +	struct pci_dev *rcec = (struct pci_dev *)data;
> +
> +	pdev->rcec = rcec;
> +	pci_info(rcec, "RCiEP(under an RCEC) %04x:%02x:%02x.%d\n",
> +		 pci_domain_nr(pdev->bus), pdev->bus->number,
> +		 PCI_SLOT(pdev->devfn), PCI_FUNC(pdev->devfn));

We may want to make this debug info at somepoint if we have a way
of discovering it from userspace.   The PCI boot up is extremely
verbose already!

> +
> +	return 0;
> +}
> +
>  /*
>   * pcie_portdrv_probe - Probe PCI-Express port devices
>   * @dev: PCI-Express port device being probed
> @@ -110,6 +122,9 @@ static int pcie_portdrv_probe(struct pci_dev *dev,
>  	     (pci_pcie_type(dev) != PCI_EXP_TYPE_RC_EC)))
>  		return -ENODEV;
>  
> +	if (pci_pcie_type(dev) == PCI_EXP_TYPE_RC_EC)
> +		pcie_walk_rcec(dev, pcie_hook_rcec, dev);
> +
>  	status = pcie_port_device_register(dev);
>  	if (status)
>  		return status;
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 34c1c4f45288..e920f29df40b 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -326,6 +326,9 @@ struct pci_dev {
>  #ifdef CONFIG_PCIEAER
>  	u16		aer_cap;	/* AER capability offset */
>  	struct aer_stats *aer_stats;	/* AER stats for this device */
> +#endif
> +#ifdef CONFIG_PCIEPORTBUS
> +	struct pci_dev	*rcec;		/* Associated RCEC device */
>  #endif
>  	u8		pcie_cap;	/* PCIe capability offset */
>  	u8		msi_cap;	/* MSI capability offset */


