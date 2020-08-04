Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4DF123B6D6
	for <lists+linux-pci@lfdr.de>; Tue,  4 Aug 2020 10:35:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729584AbgHDIfr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 4 Aug 2020 04:35:47 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:2601 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728163AbgHDIfr (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 4 Aug 2020 04:35:47 -0400
Received: from dggeme758-chm.china.huawei.com (unknown [172.30.72.56])
        by Forcepoint Email with ESMTP id 97260A2700479B0058EC;
        Tue,  4 Aug 2020 16:35:44 +0800 (CST)
Received: from [10.40.49.11] (10.40.49.11) by dggeme758-chm.china.huawei.com
 (10.3.19.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1913.5; Tue, 4 Aug
 2020 16:35:44 +0800
Subject: Re: [RFC PATCH 8/9] PCI/PME: Add RCEC PME handling
To:     Sean V Kelley <sean.v.kelley@intel.com>, <bhelgaas@google.com>,
        <Jonathan.Cameron@huawei.com>, <rjw@rjwysocki.net>,
        <ashok.raj@kernel.org>, <tony.luck@intel.com>,
        <sathyanarayanan.kuppuswamy@linux.intel.com>
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Qiuxu Zhuo <qiuxu.zhuo@intel.com>
References: <20200724172223.145608-1-sean.v.kelley@intel.com>
 <20200724172223.145608-9-sean.v.kelley@intel.com>
From:   Jay Fang <f.fangjian@huawei.com>
Message-ID: <edbcf3da-a1d5-e1b6-6a1a-a286429fc4e3@huawei.com>
Date:   Tue, 4 Aug 2020 16:35:59 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.0.1
MIME-Version: 1.0
In-Reply-To: <20200724172223.145608-9-sean.v.kelley@intel.com>
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.40.49.11]
X-ClientProxiedBy: dggeme718-chm.china.huawei.com (10.1.199.114) To
 dggeme758-chm.china.huawei.com (10.3.19.104)
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



ÔÚ 2020/7/25 1:22, Sean V Kelley Ð´µÀ:
> The Root Complex Event Collectors(RCEC) appear as peers of Root Ports
> and also have the PME capability. So add RCEC support to the current PME
> service driver and attach the PME service driver to the RCEC device.
> 
> Co-developed-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
> Signed-off-by: Sean V Kelley <sean.v.kelley@intel.com>
> Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
> ---
>  drivers/pci/pcie/pme.c | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/pcie/pme.c b/drivers/pci/pcie/pme.c
> index 6a32970bb731..87799166c96a 100644
> --- a/drivers/pci/pcie/pme.c
> +++ b/drivers/pci/pcie/pme.c
> @@ -310,7 +310,10 @@ static int pcie_pme_can_wakeup(struct pci_dev *dev, void *ign)
>  static void pcie_pme_mark_devices(struct pci_dev *port)
>  {
>  	pcie_pme_can_wakeup(port, NULL);
> -	if (port->subordinate)
> +
> +	if (pci_pcie_type(port) == PCI_EXP_TYPE_RC_EC)
> +		pcie_walk_rcec(port, pcie_pme_can_wakeup, NULL);
> +	else if (port->subordinate)
>  		pci_walk_bus(port->subordinate, pcie_pme_can_wakeup, NULL);
>  }
>  
> @@ -320,10 +323,15 @@ static void pcie_pme_mark_devices(struct pci_dev *port)
>   */
>  static int pcie_pme_probe(struct pcie_device *srv)
>  {
> -	struct pci_dev *port;
> +	struct pci_dev *port = srv->port;
>  	struct pcie_pme_service_data *data;
>  	int ret;
>  
> +	/* Limit to Root Ports or Root Complex Event Collectors */
> +	if ((pci_pcie_type(port) != PCI_EXP_TYPE_RC_EC) &&
> +	    (pci_pcie_type(port) != PCI_EXP_TYPE_ROOT_PORT))
> +		return -ENODEV;
> +
>  	data = kzalloc(sizeof(*data), GFP_KERNEL);
>  	if (!data)
>  		return -ENOMEM;
> @@ -333,7 +341,6 @@ static int pcie_pme_probe(struct pcie_device *srv)
>  	data->srv = srv;
>  	set_service_data(srv, data);
>  
> -	port = srv->port;
>  	pcie_pme_interrupt_enable(port, false);
>  	pcie_clear_root_pme_status(port);
>  
> @@ -445,7 +452,7 @@ static void pcie_pme_remove(struct pcie_device *srv)
>  
>  static struct pcie_port_service_driver pcie_pme_driver = {
>  	.name		= "pcie_pme",
> -	.port_type	= PCI_EXP_TYPE_ROOT_PORT,
> +	.port_type	= PCIE_ANY_PORT,
Maybe we can use port_type for driver matching. There is no need
to check the type of port in pcie_pme_probe function.


Jay

>  	.service	= PCIE_PORT_SERVICE_PME,
>  
>  	.probe		= pcie_pme_probe,
> 
