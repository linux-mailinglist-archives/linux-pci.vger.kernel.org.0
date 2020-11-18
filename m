Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54B7B2B7621
	for <lists+linux-pci@lfdr.de>; Wed, 18 Nov 2020 07:05:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726200AbgKRGEz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 18 Nov 2020 01:04:55 -0500
Received: from mga04.intel.com ([192.55.52.120]:13150 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725787AbgKRGEz (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 18 Nov 2020 01:04:55 -0500
IronPort-SDR: 58MaGMmt6WKmYLR+94A6s6C7p9lwS5R3QtZ/8iWWE9vSqIknP6WtT1ymJNOP9/uv7gEv3JKfNz
 Unnkt0C3BZpQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9808"; a="168498586"
X-IronPort-AV: E=Sophos;i="5.77,486,1596524400"; 
   d="scan'208";a="168498586"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2020 22:04:53 -0800
IronPort-SDR: F2/9Cai2wDQDTKCuOOPEN3xnksgZ85vos5KHDXwqW2airwPqdqeh1qFhLwGoFUTjhZXio4U1Tk
 qkxvBtf4Lw9A==
X-IronPort-AV: E=Sophos;i="5.77,486,1596524400"; 
   d="scan'208";a="544357568"
Received: from chimtrax-mobl.amr.corp.intel.com (HELO skuppusw-mobl5.amr.corp.intel.com) ([10.254.101.222])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2020 22:04:52 -0800
Subject: Re: [PATCH v11 14/16] PCI/AER: Add pcie_walk_rcec() to RCEC AER
 handling
To:     Sean V Kelley <sean.v.kelley@intel.com>, bhelgaas@google.com,
        Jonathan.Cameron@huawei.com, xerces.zhao@gmail.com,
        rafael.j.wysocki@intel.com, ashok.raj@intel.com,
        tony.luck@intel.com, sathyanarayanan.kuppuswamy@intel.com,
        qiuxu.zhuo@intel.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20201117191954.1322844-1-sean.v.kelley@intel.com>
 <20201117191954.1322844-15-sean.v.kelley@intel.com>
From:   "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <9e88e209-8d3a-5b15-5463-350ae661daa3@linux.intel.com>
Date:   Tue, 17 Nov 2020 22:04:52 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201117191954.1322844-15-sean.v.kelley@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 11/17/20 11:19 AM, Sean V Kelley wrote:
> Root Complex Event Collectors (RCEC) appear as peers to Root Ports and also
> have the AER capability. In addition, actions need to be taken for
> associated RCiEPs. In such cases the RCECs will need to be walked in order
> to find and act upon their respective RCiEPs.
> 
> Extend the existing ability to link the RCECs with a walking function
> pcie_walk_rcec(). Add RCEC support to the current AER service driver and
> attach the AER service driver to the RCEC device.
> 
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> [bhelgaas: kernel doc, whitespace cleanup]
> Co-developed-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
> Link: https://lore.kernel.org/r/20201002184735.1229220-13-seanvk.dev@oregontracks.org
> Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
> Signed-off-by: Sean V Kelley <sean.v.kelley@intel.com>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>   drivers/pci/pci.h       |  6 ++++++
>   drivers/pci/pcie/aer.c  | 29 ++++++++++++++++++++++-------
>   drivers/pci/pcie/rcec.c | 37 +++++++++++++++++++++++++++++++++++++
>   3 files changed, 65 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index ae2ee4df1cff..e988cc930d0b 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -473,10 +473,16 @@ static inline void pci_dpc_init(struct pci_dev *pdev) {}
>   void pci_rcec_init(struct pci_dev *dev);
>   void pci_rcec_exit(struct pci_dev *dev);
>   void pcie_link_rcec(struct pci_dev *rcec);
> +void pcie_walk_rcec(struct pci_dev *rcec,
> +		    int (*cb)(struct pci_dev *, void *),
> +		    void *userdata);
>   #else
>   static inline void pci_rcec_init(struct pci_dev *dev) {}
>   static inline void pci_rcec_exit(struct pci_dev *dev) {}
>   static inline void pcie_link_rcec(struct pci_dev *rcec) {}
> +static inline void pcie_walk_rcec(struct pci_dev *rcec,
> +				  int (*cb)(struct pci_dev *, void *),
> +				  void *userdata) {}
>   #endif
>   
>   #ifdef CONFIG_PCI_ATS
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index 2869212af8b4..72723a1b67af 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -300,7 +300,8 @@ int pci_aer_raw_clear_status(struct pci_dev *dev)
>   		return -EIO;
>   
>   	port_type = pci_pcie_type(dev);
> -	if (port_type == PCI_EXP_TYPE_ROOT_PORT) {
> +	if (port_type == PCI_EXP_TYPE_ROOT_PORT ||
> +	    port_type == PCI_EXP_TYPE_RC_EC) {
>   		pci_read_config_dword(dev, aer + PCI_ERR_ROOT_STATUS, &status);
>   		pci_write_config_dword(dev, aer + PCI_ERR_ROOT_STATUS, status);
>   	}
> @@ -595,7 +596,8 @@ static umode_t aer_stats_attrs_are_visible(struct kobject *kobj,
>   	if ((a == &dev_attr_aer_rootport_total_err_cor.attr ||
>   	     a == &dev_attr_aer_rootport_total_err_fatal.attr ||
>   	     a == &dev_attr_aer_rootport_total_err_nonfatal.attr) &&
> -	    pci_pcie_type(pdev) != PCI_EXP_TYPE_ROOT_PORT)
> +	    ((pci_pcie_type(pdev) != PCI_EXP_TYPE_ROOT_PORT) &&
> +	     (pci_pcie_type(pdev) != PCI_EXP_TYPE_RC_EC)))
>   		return 0;
>   
>   	return a->mode;
> @@ -916,7 +918,10 @@ static bool find_source_device(struct pci_dev *parent,
>   	if (result)
>   		return true;
>   
> -	pci_walk_bus(parent->subordinate, find_device_iter, e_info);
> +	if (pci_pcie_type(parent) == PCI_EXP_TYPE_RC_EC)
> +		pcie_walk_rcec(parent, find_device_iter, e_info);
> +	else
> +		pci_walk_bus(parent->subordinate, find_device_iter, e_info);
>   
>   	if (!e_info->error_dev_num) {
>   		pci_info(parent, "can't find device of ID%04x\n", e_info->id);
> @@ -1053,6 +1058,7 @@ int aer_get_device_error_info(struct pci_dev *dev, struct aer_err_info *info)
>   		if (!(info->status & ~info->mask))
>   			return 0;
>   	} else if (pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT ||
> +		   pci_pcie_type(dev) == PCI_EXP_TYPE_RC_EC ||
>   	           pci_pcie_type(dev) == PCI_EXP_TYPE_DOWNSTREAM ||
>   		   info->severity == AER_NONFATAL) {
>   
> @@ -1205,6 +1211,7 @@ static int set_device_error_reporting(struct pci_dev *dev, void *data)
>   	int type = pci_pcie_type(dev);
>   
>   	if ((type == PCI_EXP_TYPE_ROOT_PORT) ||
> +	    (type == PCI_EXP_TYPE_RC_EC) ||
>   	    (type == PCI_EXP_TYPE_UPSTREAM) ||
>   	    (type == PCI_EXP_TYPE_DOWNSTREAM)) {
>   		if (enable)
> @@ -1229,9 +1236,12 @@ static void set_downstream_devices_error_reporting(struct pci_dev *dev,
>   {
>   	set_device_error_reporting(dev, &enable);
>   
> -	if (!dev->subordinate)
> -		return;
> -	pci_walk_bus(dev->subordinate, set_device_error_reporting, &enable);
> +	if (pci_pcie_type(dev) == PCI_EXP_TYPE_RC_EC)
> +		pcie_walk_rcec(dev, set_device_error_reporting, &enable);
> +	else if (dev->subordinate)
> +		pci_walk_bus(dev->subordinate, set_device_error_reporting,
> +			     &enable);
> +
>   }
>   
>   /**
> @@ -1329,6 +1339,11 @@ static int aer_probe(struct pcie_device *dev)
>   	struct device *device = &dev->device;
>   	struct pci_dev *port = dev->port;
>   
> +	/* Limit to Root Ports or Root Complex Event Collectors */
> +	if ((pci_pcie_type(port) != PCI_EXP_TYPE_RC_EC) &&
> +	    (pci_pcie_type(port) != PCI_EXP_TYPE_ROOT_PORT))
> +		return -ENODEV;
> +
>   	rpc = devm_kzalloc(device, sizeof(struct aer_rpc), GFP_KERNEL);
>   	if (!rpc)
>   		return -ENOMEM;
> @@ -1409,7 +1424,7 @@ static pci_ers_result_t aer_root_reset(struct pci_dev *dev)
>   
>   static struct pcie_port_service_driver aerdriver = {
>   	.name		= "aer",
> -	.port_type	= PCI_EXP_TYPE_ROOT_PORT,
> +	.port_type	= PCIE_ANY_PORT,
>   	.service	= PCIE_PORT_SERVICE_AER,
>   
>   	.probe		= aer_probe,
> diff --git a/drivers/pci/pcie/rcec.c b/drivers/pci/pcie/rcec.c
> index cdec277cbd62..2c5c552994e4 100644
> --- a/drivers/pci/pcie/rcec.c
> +++ b/drivers/pci/pcie/rcec.c
> @@ -53,6 +53,18 @@ static int link_rcec_helper(struct pci_dev *dev, void *data)
>   	return 0;
>   }
>   
> +static int walk_rcec_helper(struct pci_dev *dev, void *data)
> +{
> +	struct walk_rcec_data *rcec_data = data;
> +	struct pci_dev *rcec = rcec_data->rcec;
> +
> +	if ((pci_pcie_type(dev) == PCI_EXP_TYPE_RC_END) &&
> +	    rcec_assoc_rciep(rcec, dev))
> +		rcec_data->user_callback(dev, rcec_data->user_data);
> +
> +	return 0;
> +}
> +
>   static void walk_rcec(int (*cb)(struct pci_dev *dev, void *data),
>   		      void *userdata)
>   {
> @@ -109,6 +121,31 @@ void pcie_link_rcec(struct pci_dev *rcec)
>   	walk_rcec(link_rcec_helper, &rcec_data);
>   }
>   
> +/**
> + * pcie_walk_rcec - Walk RCiEP devices associating with RCEC and call callback.
> + * @rcec:	RCEC whose RCiEP devices should be walked
> + * @cb:		Callback to be called for each RCiEP device found
> + * @userdata:	Arbitrary pointer to be passed to callback
> + *
> + * Walk the given RCEC. Call the callback on each RCiEP found.
> + *
> + * If @cb returns anything other than 0, break out.
> + */
> +void pcie_walk_rcec(struct pci_dev *rcec, int (*cb)(struct pci_dev *, void *),
> +		    void *userdata)
> +{
> +	struct walk_rcec_data rcec_data;
> +
> +	if (!rcec->rcec_ea)
> +		return;
> +
> +	rcec_data.rcec = rcec;
> +	rcec_data.user_callback = cb;
> +	rcec_data.user_data = userdata;
> +
> +	walk_rcec(walk_rcec_helper, &rcec_data);
> +}
> +
>   void pci_rcec_init(struct pci_dev *dev)
>   {
>   	struct rcec_ea *rcec_ea;
> 

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
