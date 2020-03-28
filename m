Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4C2C7196961
	for <lists+linux-pci@lfdr.de>; Sat, 28 Mar 2020 22:12:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727176AbgC1VMu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 28 Mar 2020 17:12:50 -0400
Received: from mga17.intel.com ([192.55.52.151]:40684 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726604AbgC1VMu (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 28 Mar 2020 17:12:50 -0400
IronPort-SDR: 3P5UnqVVEyL9KYglzbEAIzoDnd40K/kFGXH1ex5xVKAkRbqQdF0x5BsdQDW8EmWBLr5Wn7A/vg
 IaCm06uX+BYw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2020 14:12:49 -0700
IronPort-SDR: bnbXWG8s6q28X0226IZOO75NStnuUdLcMstgbqpglkjnuEl8RbOf218/ZUpviyZkyXa8oAvsLi
 qKeK6K+FjpJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,317,1580803200"; 
   d="scan'208";a="447816206"
Received: from ssafrin-mobl.ger.corp.intel.com (HELO [10.255.229.125]) ([10.255.229.125])
  by fmsmga005.fm.intel.com with ESMTP; 28 Mar 2020 14:12:48 -0700
Subject: Re: [PATCH v18 05/11] PCI/ERR: Remove service dependency in
 pcie_do_recovery()
To:     bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ashok.raj@intel.com
References: <cover.1585000084.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <60e02b87b526cdf2930400059d98704bf0a147d1.1585000084.git.sathyanarayanan.kuppuswamy@linux.intel.com>
From:   "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <bcc1910b-90fe-25b5-3cee-8f9d7e83e45e@linux.intel.com>
Date:   Sat, 28 Mar 2020 14:12:48 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <60e02b87b526cdf2930400059d98704bf0a147d1.1585000084.git.sathyanarayanan.kuppuswamy@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

On 3/23/20 5:26 PM, sathyanarayanan.kuppuswamy@linux.intel.com wrote:
> From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> 

> +void pcie_do_recovery(struct pci_dev *dev,
> +		      enum pci_channel_state state,
> +		      pci_ers_result_t (*reset_link)(struct pci_dev *pdev))
>   {
>   	pci_ers_result_t status = PCI_ERS_RESULT_CAN_RECOVER;
>   	struct pci_bus *bus;
> @@ -206,9 +165,12 @@ void pcie_do_recovery(struct pci_dev *dev, enum pci_channel_state state,
>   	pci_dbg(dev, "broadcast error_detected message\n");
>   	if (state == pci_channel_io_frozen) {
>   		pci_walk_bus(bus, report_frozen_detected, &status);
> -		status = reset_link(dev, service);
> -		if 		if (reset_link)
			status = reset_link(dev);(status == PCI_ERS_RESULT_DISCONNECT
> +		status = reset_link(dev);
Above line needs to be replaced as below. Since there is a
possibility reset_link can NULL (eventhough currently its
not true).
		if (reset_link)
			status = reset_link(dev);
Shall I submit another version to add above fix on top of
our pci/edr branch ?
> +		if ((status != PCI_ERS_RESULT_RECOVERED) &&
> +		    (status != PCI_ERS_RESULT_NEED_RESET)) {
> +			pci_dbg(dev, "link reset at upstream device failed\n");
>   			goto failed;
> +		}
>   	} else {
>   		pci_walk_bus(bus, report_normal_detected, &status);
>   	}
> diff --git a/drivers/pci/pcie/portdrv.h b/drivers/pci/pcie/portdrv.h
> index 1e673619b101..64b5e081cdb2 100644
> --- a/drivers/pci/pcie/portdrv.h
> +++ b/drivers/pci/pcie/portdrv.h
> @@ -92,9 +92,6 @@ struct pcie_port_service_driver {
>   	/* Device driver may resume normal operations */
>   	void (*error_resume)(struct pci_dev *dev);
>   
> -	/* Link Reset Capability - AER service driver specific */
> -	pci_ers_result_t (*reset_link)(struct pci_dev *dev);
> -
>   	int port_type;  /* Type of the port this driver can handle */
>   	u32 service;    /* Port service this device represents */
>   
> @@ -161,7 +158,5 @@ static inline int pcie_aer_get_firmware_first(struct pci_dev *pci_dev)
>   }
>   #endif
>   
> -struct pcie_port_service_driver *pcie_port_find_service(struct pci_dev *dev,
> -							u32 service);
>   struct device *pcie_port_find_device(struct pci_dev *dev, u32 service);
>   #endif /* _PORTDRV_H_ */
> diff --git a/drivers/pci/pcie/portdrv_core.c b/drivers/pci/pcie/portdrv_core.c
> index 5075cb9e850c..50a9522ab07d 100644
> --- a/drivers/pci/pcie/portdrv_core.c
> +++ b/drivers/pci/pcie/portdrv_core.c
> @@ -458,27 +458,6 @@ static int find_service_iter(struct device *device, void *data)
>   	return 0;
>   }
>   
> -/**
> - * pcie_port_find_service - find the service driver
> - * @dev: PCI Express port the service is associated with
> - * @service: Service to find
> - *
> - * Find PCI Express port service driver associated with given service
> - */
> -struct pcie_port_service_driver *pcie_port_find_service(struct pci_dev *dev,
> -							u32 service)
> -{
> -	struct pcie_port_service_driver *drv;
> -	struct portdrv_service_data pdrvs;
> -
> -	pdrvs.drv = NULL;
> -	pdrvs.service = service;
> -	device_for_each_child(&dev->dev, &pdrvs, find_service_iter);
> -
> -	drv = pdrvs.drv;
> -	return drv;
> -}
> -
>   /**
>    * pcie_port_find_device - find the struct device
>    * @dev: PCI Express port the service is associated with
> 
