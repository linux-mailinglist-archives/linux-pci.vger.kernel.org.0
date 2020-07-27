Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9542A22EC0F
	for <lists+linux-pci@lfdr.de>; Mon, 27 Jul 2020 14:24:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728423AbgG0MYS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 27 Jul 2020 08:24:18 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2535 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728292AbgG0MYS (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 27 Jul 2020 08:24:18 -0400
Received: from lhreml710-chm.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id 50336B258D4D68A1850D;
        Mon, 27 Jul 2020 13:24:16 +0100 (IST)
Received: from localhost (10.52.121.176) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1913.5; Mon, 27 Jul
 2020 13:24:15 +0100
Date:   Mon, 27 Jul 2020 13:22:52 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Sean V Kelley <sean.v.kelley@intel.com>
CC:     <bhelgaas@google.com>, <rjw@rjwysocki.net>, <ashok.raj@kernel.org>,
        <tony.luck@intel.com>,
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Subject: Re: [RFC PATCH 7/9] PCI/AER: Add RCEC AER handling
Message-ID: <20200727132252.0000644c@Huawei.com>
In-Reply-To: <20200724172223.145608-8-sean.v.kelley@intel.com>
References: <20200724172223.145608-1-sean.v.kelley@intel.com>
        <20200724172223.145608-8-sean.v.kelley@intel.com>
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

On Fri, 24 Jul 2020 10:22:21 -0700
Sean V Kelley <sean.v.kelley@intel.com> wrote:

> The Root Complex Event Collectors(RCEC) appear as peers to Root Ports
> and also have the AER capability. So add RCEC support to the current AER
> service driver and attach the AER service driver to the RCEC device.
> 
> Co-developed-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
> Signed-off-by: Sean V Kelley <sean.v.kelley@intel.com>
> Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>

A few questions and comments for this patch.

See inline.

Jonathan


> ---
>  drivers/pci/pcie/aer.c | 34 +++++++++++++++++++++++++++-------
>  1 file changed, 27 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index f1bf06be449e..7cc430c74c46 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -303,7 +303,7 @@ int pci_aer_raw_clear_status(struct pci_dev *dev)
>  		return -EIO;
>  
>  	port_type = pci_pcie_type(dev);
> -	if (port_type == PCI_EXP_TYPE_ROOT_PORT) {
> +	if (port_type == PCI_EXP_TYPE_ROOT_PORT || port_type == PCI_EXP_TYPE_RC_EC) {
>  		pci_read_config_dword(dev, aer + PCI_ERR_ROOT_STATUS, &status);
>  		pci_write_config_dword(dev, aer + PCI_ERR_ROOT_STATUS, status);
>  	}
> @@ -389,6 +389,12 @@ void pci_aer_init(struct pci_dev *dev)
>  	pci_add_ext_cap_save_buffer(dev, PCI_EXT_CAP_ID_ERR, sizeof(u32) * n);
>  
>  	pci_aer_clear_status(dev);
> +
> +	if (pci_pcie_type(dev) == PCI_EXP_TYPE_RC_EC) {
> +		if (!pci_find_ext_capability(dev, PCI_EXT_CAP_ID_RCEC))
> +			return;
> +		pci_info(dev, "AER: RCEC CAP FOUND and cap_has_rtctl = %d\n", n);

It feels like failing to find an RC_EC extended cap in a RCEC deserved
a nice strong error message.  Perhaps this isn't the right place to do it
though.  For that matter, why are we checking for it here?

> +	}
>  }
>  
>  void pci_aer_exit(struct pci_dev *dev)
> @@ -577,7 +583,8 @@ static umode_t aer_stats_attrs_are_visible(struct kobject *kobj,
>  	if ((a == &dev_attr_aer_rootport_total_err_cor.attr ||
>  	     a == &dev_attr_aer_rootport_total_err_fatal.attr ||
>  	     a == &dev_attr_aer_rootport_total_err_nonfatal.attr) &&

It is a bit ugly to have these called rootport_total_err etc for the rcec.
Perhaps we should just add additional attributes to reflect we are looking at
an RCEC?

> -	    pci_pcie_type(pdev) != PCI_EXP_TYPE_ROOT_PORT)
> +	    ((pci_pcie_type(pdev) != PCI_EXP_TYPE_ROOT_PORT) &&
> +	    (pci_pcie_type(pdev) != PCI_EXP_TYPE_RC_EC)))
>  		return 0;
>  
>  	return a->mode;
> @@ -894,7 +901,10 @@ static bool find_source_device(struct pci_dev *parent,
>  	if (result)
>  		return true;
>  
> -	pci_walk_bus(parent->subordinate, find_device_iter, e_info);
> +	if (pci_pcie_type(parent) == PCI_EXP_TYPE_RC_EC)
> +		pcie_walk_rcec(parent, find_device_iter, e_info);
> +	else
> +		pci_walk_bus(parent->subordinate, find_device_iter, e_info);
>  
>  	if (!e_info->error_dev_num) {
>  		pci_info(parent, "can't find device of ID%04x\n", e_info->id);
> @@ -1030,6 +1040,7 @@ int aer_get_device_error_info(struct pci_dev *dev, struct aer_err_info *info)
>  		if (!(info->status & ~info->mask))
>  			return 0;
>  	} else if (pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT ||
> +		   pci_pcie_type(dev) == PCI_EXP_TYPE_RC_EC ||
>  	           pci_pcie_type(dev) == PCI_EXP_TYPE_DOWNSTREAM ||
>  		   info->severity == AER_NONFATAL) {
>  
> @@ -1182,6 +1193,8 @@ static int set_device_error_reporting(struct pci_dev *dev, void *data)
>  	int type = pci_pcie_type(dev);
>  
>  	if ((type == PCI_EXP_TYPE_ROOT_PORT) ||
> +	    (type == PCI_EXP_TYPE_RC_EC) ||
> +	    (type == PCI_EXP_TYPE_RC_END) ||

Why add RC_END here?

>  	    (type == PCI_EXP_TYPE_UPSTREAM) ||
>  	    (type == PCI_EXP_TYPE_DOWNSTREAM)) {
>  		if (enable)
> @@ -1206,9 +1219,11 @@ static void set_downstream_devices_error_reporting(struct pci_dev *dev,
>  {
>  	set_device_error_reporting(dev, &enable);
>  
> -	if (!dev->subordinate)
> -		return;
> -	pci_walk_bus(dev->subordinate, set_device_error_reporting, &enable);
> +	if (pci_pcie_type(dev) == PCI_EXP_TYPE_RC_EC)
> +		pcie_walk_rcec(dev, set_device_error_reporting, &enable);
> +	else if (dev->subordinate)
> +		pci_walk_bus(dev->subordinate, set_device_error_reporting, &enable);
> +
>  }
>  
>  /**
> @@ -1306,6 +1321,11 @@ static int aer_probe(struct pcie_device *dev)
>  	struct device *device = &dev->device;
>  	struct pci_dev *port = dev->port;
>  
> +	/* Limit to Root Ports or Root Complex Event Collectors */
> +	if ((pci_pcie_type(port) != PCI_EXP_TYPE_RC_EC) &&
> +	    (pci_pcie_type(port) != PCI_EXP_TYPE_ROOT_PORT))
> +		return -ENODEV;
> +
>  	rpc = devm_kzalloc(device, sizeof(struct aer_rpc), GFP_KERNEL);
>  	if (!rpc)
>  		return -ENOMEM;
> @@ -1362,7 +1382,7 @@ static pci_ers_result_t aer_root_reset(struct pci_dev *dev)
>  
>  static struct pcie_port_service_driver aerdriver = {
>  	.name		= "aer",
> -	.port_type	= PCI_EXP_TYPE_ROOT_PORT,
> +	.port_type	= PCIE_ANY_PORT,

Why this particular change?  Seems that is a lot wider than simply
adding RCEC.  Obviously we'll then drop out in the aer_probe but it
is still rather inelegant.

>  	.service	= PCIE_PORT_SERVICE_AER,
>  
>  	.probe		= aer_probe,


