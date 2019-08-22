Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DFBE59949A
	for <lists+linux-pci@lfdr.de>; Thu, 22 Aug 2019 15:10:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731108AbfHVNKf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 22 Aug 2019 09:10:35 -0400
Received: from mga05.intel.com ([192.55.52.43]:25237 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729122AbfHVNKf (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 22 Aug 2019 09:10:35 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Aug 2019 06:10:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,416,1559545200"; 
   d="scan'208";a="378511655"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.145])
  by fmsmga005.fm.intel.com with ESMTP; 22 Aug 2019 06:10:31 -0700
Received: from andy by smile with local (Exim 4.92.1)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1i0mrE-0001iO-9K; Thu, 22 Aug 2019 16:10:28 +0300
Date:   Thu, 22 Aug 2019 16:10:28 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Russell Currey <ruscur@russell.cc>,
        Sam Bobroff <sbobroff@linux.ibm.com>,
        Oliver O'Halloran <oohall@gmail.com>, stefan.maetje@esd.eu,
        Patrick Talbert <ptalbert@redhat.com>,
        "David S . Miller" <davem@davemloft.net>,
        Lukas Wunner <lukas@wunner.de>,
        Frederick Lawler <fred@fredlawl.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Yijing Wang <wangyijing@huawei.com>,
        Robert White <rwhite@pobox.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH 1/2] PCI: Make pcie_downstream_port() available outside
 of access.c
Message-ID: <20190822131028.GP30120@smile.fi.intel.com>
References: <20190822085553.62697-1-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190822085553.62697-1-mika.westerberg@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Aug 22, 2019 at 11:55:52AM +0300, Mika Westerberg wrote:
> This helper function is useful in other places where code needs to
> determine whether the PCIe port is downstream so make it available
> outside of access.c.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> 
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> ---
>  drivers/pci/access.c | 9 ---------
>  drivers/pci/pci.h    | 9 +++++++++
>  2 files changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/pci/access.c b/drivers/pci/access.c
> index 544922f097c0..2fccb5762c76 100644
> --- a/drivers/pci/access.c
> +++ b/drivers/pci/access.c
> @@ -336,15 +336,6 @@ static inline int pcie_cap_version(const struct pci_dev *dev)
>  	return pcie_caps_reg(dev) & PCI_EXP_FLAGS_VERS;
>  }
>  
> -static bool pcie_downstream_port(const struct pci_dev *dev)
> -{
> -	int type = pci_pcie_type(dev);
> -
> -	return type == PCI_EXP_TYPE_ROOT_PORT ||
> -	       type == PCI_EXP_TYPE_DOWNSTREAM ||
> -	       type == PCI_EXP_TYPE_PCIE_BRIDGE;
> -}
> -
>  bool pcie_cap_has_lnkctl(const struct pci_dev *dev)
>  {
>  	int type = pci_pcie_type(dev);
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 9a83fcf612ca..ae8d839dca4f 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -118,6 +118,15 @@ static inline bool pci_power_manageable(struct pci_dev *pci_dev)
>  	return !pci_has_subordinate(pci_dev) || pci_dev->bridge_d3;
>  }
>  
> +static inline bool pcie_downstream_port(const struct pci_dev *dev)
> +{
> +	int type = pci_pcie_type(dev);
> +
> +	return type == PCI_EXP_TYPE_ROOT_PORT ||
> +	       type == PCI_EXP_TYPE_DOWNSTREAM ||
> +	       type == PCI_EXP_TYPE_PCIE_BRIDGE;
> +}
> +
>  int pci_vpd_init(struct pci_dev *dev);
>  void pci_vpd_release(struct pci_dev *dev);
>  void pcie_vpd_create_sysfs_dev_files(struct pci_dev *dev);
> -- 
> 2.23.0.rc1
> 

-- 
With Best Regards,
Andy Shevchenko


