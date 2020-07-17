Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39F4822451D
	for <lists+linux-pci@lfdr.de>; Fri, 17 Jul 2020 22:20:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728285AbgGQUUY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 17 Jul 2020 16:20:24 -0400
Received: from mga17.intel.com ([192.55.52.151]:44166 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726771AbgGQUUX (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 17 Jul 2020 16:20:23 -0400
IronPort-SDR: 88PfWby2AeNsuquskwwhlnLPkkPnr9MKmUIo70/1SnmUo2vTGcUimAHIGFH5WIFSc4R3dfNo9u
 p4q7soQwy2Eg==
X-IronPort-AV: E=McAfee;i="6000,8403,9685"; a="129751324"
X-IronPort-AV: E=Sophos;i="5.75,364,1589266800"; 
   d="scan'208";a="129751324"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2020 13:20:23 -0700
IronPort-SDR: p4yUaDfPSPz9A38C7vdgN0+hqvDVPOAUVtv4PWPU8KQAlgfIqc5jnlUqz6cDWmEXwIVadqNHmD
 sZ6xvf1jmO5g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,364,1589266800"; 
   d="scan'208";a="460961618"
Received: from jmharral-mobl.amr.corp.intel.com (HELO [10.254.77.39]) ([10.254.77.39])
  by orsmga005.jf.intel.com with ESMTP; 17 Jul 2020 13:20:22 -0700
Subject: Re: [PATCH] PCI/ERR: Rename pci_aer_clear_device_status() to
 pcie_clear_device_status()
To:     Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Sean Kelley <sean.v.kelley@linux.intel.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linuxarm@huawei.com, Bjorn Helgaas <bhelgaas@google.com>
References: <20200717195619.766662-1-helgaas@kernel.org>
From:   "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <0cee203b-3ba9-3e42-0caa-92d12b9086fe@linux.intel.com>
Date:   Fri, 17 Jul 2020 13:20:22 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200717195619.766662-1-helgaas@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

On 7/17/20 12:56 PM, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> pci_aer_clear_device_status() clears the error bits in the PCIe Device
> Status Register (PCI_EXP_DEVSTA).  Every PCIe device has this register,
> regardless of whether it supports AER.
Since its not related to AER, can we move it out of AER driver ? May be
to pci.c ?
> 
> Rename pci_aer_clear_device_status() to pcie_clear_device_status() to make
> clear that it is PCIe-specific but not AER-specific.  No functional change
> intended.
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>   drivers/pci/pci.h      | 4 ++--
>   drivers/pci/pcie/aer.c | 4 ++--
>   drivers/pci/pcie/err.c | 2 +-
>   3 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index c6c0c455f59f..c5f271e6e276 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -657,16 +657,16 @@ void pci_no_aer(void);
>   void pci_aer_init(struct pci_dev *dev);
>   void pci_aer_exit(struct pci_dev *dev);
>   extern const struct attribute_group aer_stats_attr_group;
> +void pcie_clear_device_status(struct pci_dev *dev);
>   void pci_aer_clear_fatal_status(struct pci_dev *dev);
> -void pci_aer_clear_device_status(struct pci_dev *dev);
>   int pci_aer_clear_status(struct pci_dev *dev);
>   int pci_aer_raw_clear_status(struct pci_dev *dev);
>   #else
>   static inline void pci_no_aer(void) { }
>   static inline void pci_aer_init(struct pci_dev *d) { }
>   static inline void pci_aer_exit(struct pci_dev *d) { }
> +static inline void pcie_clear_device_status(struct pci_dev *dev) { }
>   static inline void pci_aer_clear_fatal_status(struct pci_dev *dev) { }
> -static inline void pci_aer_clear_device_status(struct pci_dev *dev) { }
>   static inline int pci_aer_clear_status(struct pci_dev *dev) { return -EINVAL; }
>   static inline int pci_aer_raw_clear_status(struct pci_dev *dev) { return -EINVAL; }
>   #endif
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index ca886bf91fd9..d3ea667c8520 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -241,7 +241,7 @@ int pci_disable_pcie_error_reporting(struct pci_dev *dev)
>   }
>   EXPORT_SYMBOL_GPL(pci_disable_pcie_error_reporting);
>   
> -void pci_aer_clear_device_status(struct pci_dev *dev)
> +void pcie_clear_device_status(struct pci_dev *dev)
>   {
>   	u16 sta;
>   
> @@ -947,7 +947,7 @@ static void handle_error_source(struct pci_dev *dev, struct aer_err_info *info)
>   		if (aer)
>   			pci_write_config_dword(dev, aer + PCI_ERR_COR_STATUS,
>   					info->status);
> -		pci_aer_clear_device_status(dev);
> +		pcie_clear_device_status(dev);
>   	} else if (info->severity == AER_NONFATAL)
>   		pcie_do_recovery(dev, pci_channel_io_normal, aer_root_reset);
>   	else if (info->severity == AER_FATAL)
> diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
> index 467686ee2d8b..55755bc493f1 100644
> --- a/drivers/pci/pcie/err.c
> +++ b/drivers/pci/pcie/err.c
> @@ -197,7 +197,7 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
>   	pci_dbg(dev, "broadcast resume message\n");
>   	pci_walk_bus(bus, report_resume, &status);
>   
> -	pci_aer_clear_device_status(dev);
> +	pcie_clear_device_status(dev);
>   	pci_aer_clear_nonfatal_status(dev);
>   	pci_info(dev, "device recovery successful\n");
>   	return status;
> 

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
