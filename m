Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 788DD27237E
	for <lists+linux-pci@lfdr.de>; Mon, 21 Sep 2020 14:14:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726395AbgIUMOh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Sep 2020 08:14:37 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2902 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726367AbgIUMOh (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 21 Sep 2020 08:14:37 -0400
Received: from lhreml710-chm.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id 1D89D6BAABF9D10A1784;
        Mon, 21 Sep 2020 13:14:35 +0100 (IST)
Received: from localhost (10.52.121.13) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Mon, 21 Sep
 2020 13:14:34 +0100
Date:   Mon, 21 Sep 2020 13:12:55 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Sean V Kelley <sean.v.kelley@intel.com>
CC:     <bhelgaas@google.com>, <rafael.j.wysocki@intel.com>,
        <ashok.raj@intel.com>, <tony.luck@intel.com>,
        <sathyanarayanan.kuppuswamy@intel.com>, <qiuxu.zhuo@intel.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 08/10] PCI/AER: Add pcie_walk_rcec() to RCEC AER
 handling
Message-ID: <20200921131255.00004381@Huawei.com>
In-Reply-To: <20200918204603.62100-9-sean.v.kelley@intel.com>
References: <20200918204603.62100-1-sean.v.kelley@intel.com>
        <20200918204603.62100-9-sean.v.kelley@intel.com>
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

On Fri, 18 Sep 2020 13:46:01 -0700
Sean V Kelley <sean.v.kelley@intel.com> wrote:

> The Root Complex Event Collectors(RCEC) appear as peers to Root Ports
> and also have the AER capability. In addition, actions need to be taken
> for assocated RCiEPs. In such cases the RCECs will need to be walked in
> order to find and act upon their respective RCiEPs.  Extend the existing
> ability to link the RCECs with a walking function pcie_walk_rcec(). Add
> RCEC support to the current AER service driver and attach the AER service
> driver to the RCEC device.
> 
> Co-developed-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
> Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
> Signed-off-by: Sean V Kelley <sean.v.kelley@intel.com>
Hi,

Couple of minor things in here, but assuming you tidy those up.
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/pci/pci.h       |  4 ++++
>  drivers/pci/pcie/aer.c  | 27 ++++++++++++++++++++-------
>  drivers/pci/pcie/rcec.c | 39 ++++++++++++++++++++++++++++++++++++++-
>  3 files changed, 62 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index ddb5872466fb..e8535a7d4b53 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -475,10 +475,14 @@ static inline void pci_dpc_init(struct pci_dev *pdev) {}
>  void pci_rcec_init(struct pci_dev *dev);
>  void pci_rcec_exit(struct pci_dev *dev);
>  void pcie_link_rcec(struct pci_dev *rcec);
> +void pcie_walk_rcec(struct pci_dev *rcec, int (*cb)(struct pci_dev *, void *),
> +		    void *userdata);
>  #else
>  static inline void pci_rcec_init(struct pci_dev *dev) {}
>  static inline void pci_rcec_exit(struct pci_dev *dev) {}
>  static inline void pcie_link_rcec(struct pci_dev *rcec) {}
> +static inline void pcie_walk_rcec(struct pci_dev *rcec, int (*cb)(struct pci_dev *, void *),
> +				  void *userdata) {}
>  #endif
>  
>  #ifdef CONFIG_PCI_ATS
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index dccdba60b5d9..43772bfc134e 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -300,7 +300,7 @@ int pci_aer_raw_clear_status(struct pci_dev *dev)
>  		return -EIO;
>  
>  	port_type = pci_pcie_type(dev);
> -	if (port_type == PCI_EXP_TYPE_ROOT_PORT) {
> +	if (port_type == PCI_EXP_TYPE_ROOT_PORT || port_type == PCI_EXP_TYPE_RC_EC) {
>  		pci_read_config_dword(dev, aer + PCI_ERR_ROOT_STATUS, &status);
>  		pci_write_config_dword(dev, aer + PCI_ERR_ROOT_STATUS, status);
>  	}
> @@ -595,7 +595,8 @@ static umode_t aer_stats_attrs_are_visible(struct kobject *kobj,
>  	if ((a == &dev_attr_aer_rootport_total_err_cor.attr ||
>  	     a == &dev_attr_aer_rootport_total_err_fatal.attr ||
>  	     a == &dev_attr_aer_rootport_total_err_nonfatal.attr) &&
> -	    pci_pcie_type(pdev) != PCI_EXP_TYPE_ROOT_PORT)
> +	    ((pci_pcie_type(pdev) != PCI_EXP_TYPE_ROOT_PORT) &&
> +	    (pci_pcie_type(pdev) != PCI_EXP_TYPE_RC_EC)))

This line should be indented one more space I think..

>  		return 0;
>  
>  	return a->mode;
> @@ -916,7 +917,10 @@ static bool find_source_device(struct pci_dev *parent,
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
> @@ -1053,6 +1057,7 @@ int aer_get_device_error_info(struct pci_dev *dev, struct aer_err_info *info)
>  		if (!(info->status & ~info->mask))
>  			return 0;
>  	} else if (pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT ||
> +		   pci_pcie_type(dev) == PCI_EXP_TYPE_RC_EC ||
>  	           pci_pcie_type(dev) == PCI_EXP_TYPE_DOWNSTREAM ||
>  		   info->severity == AER_NONFATAL) {
>  
> @@ -1205,6 +1210,7 @@ static int set_device_error_reporting(struct pci_dev *dev, void *data)
>  	int type = pci_pcie_type(dev);
>  
>  	if ((type == PCI_EXP_TYPE_ROOT_PORT) ||
> +	    (type == PCI_EXP_TYPE_RC_EC) ||
>  	    (type == PCI_EXP_TYPE_UPSTREAM) ||
>  	    (type == PCI_EXP_TYPE_DOWNSTREAM)) {
>  		if (enable)
> @@ -1229,9 +1235,11 @@ static void set_downstream_devices_error_reporting(struct pci_dev *dev,
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
> @@ -1329,6 +1337,11 @@ static int aer_probe(struct pcie_device *dev)
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
> @@ -1385,7 +1398,7 @@ static pci_ers_result_t aer_root_reset(struct pci_dev *dev)
>  
>  static struct pcie_port_service_driver aerdriver = {
>  	.name		= "aer",
> -	.port_type	= PCI_EXP_TYPE_ROOT_PORT,
> +	.port_type	= PCIE_ANY_PORT,
>  	.service	= PCIE_PORT_SERVICE_AER,
>  
>  	.probe		= aer_probe,
> diff --git a/drivers/pci/pcie/rcec.c b/drivers/pci/pcie/rcec.c
> index 5630480a6659..e6d20131b578 100644
> --- a/drivers/pci/pcie/rcec.c
> +++ b/drivers/pci/pcie/rcec.c
> @@ -53,7 +53,18 @@ static int link_rcec_helper(struct pci_dev *dev, void *data)
>  	return 0;
>  }
>  
> -void walk_rcec(int (*cb)(struct pci_dev *dev, void *data), void *userdata)
> +static int walk_rcec_helper(struct pci_dev *dev, void *data)
> +{
> +	struct walk_rcec_data *rcec_data = data;
> +	struct pci_dev *rcec = rcec_data->rcec;
> +
> +	if ((pci_pcie_type(dev) == PCI_EXP_TYPE_RC_END) && rcec_assoc_rciep(rcec, dev))
> +		rcec_data->user_callback(dev, rcec_data->user_data);
> +
> +	return 0;
> +}
> +
> +static void walk_rcec(int (*cb)(struct pci_dev *dev, void *data), void *userdata)

Ah. The missing static. Shift that into the earlier patch!

>  {
>  	struct walk_rcec_data *rcec_data = userdata;
>  	struct pci_dev *rcec = rcec_data->rcec;
> @@ -113,6 +124,32 @@ void pcie_link_rcec(struct pci_dev *rcec)
>  	walk_rcec(link_rcec_helper, &rcec_data);
>  }
>  
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
> +	struct walk_rcec_data rcec_data;
> +
> +	if (!rcec->rcec_cap)
> +		return;
> +
> +	rcec_data.rcec = rcec;
> +	rcec_data.user_callback = cb;
> +	rcec_data.user_data = userdata;
> +
> +	walk_rcec(walk_rcec_helper, &rcec_data);
> +}
> +
>  void pci_rcec_init(struct pci_dev *dev)
>  {
>  	u32 rcec, hdr, busn;


