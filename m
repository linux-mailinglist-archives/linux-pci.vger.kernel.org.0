Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6713627238B
	for <lists+linux-pci@lfdr.de>; Mon, 21 Sep 2020 14:16:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726460AbgIUMQk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Sep 2020 08:16:40 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2903 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726341AbgIUMQk (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 21 Sep 2020 08:16:40 -0400
Received: from lhreml710-chm.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id 7FCFE8CEFE2E4464AA92;
        Mon, 21 Sep 2020 13:16:39 +0100 (IST)
Received: from localhost (10.52.121.13) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Mon, 21 Sep
 2020 13:16:38 +0100
Date:   Mon, 21 Sep 2020 13:15:00 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Sean V Kelley <sean.v.kelley@intel.com>
CC:     <bhelgaas@google.com>, <rafael.j.wysocki@intel.com>,
        <ashok.raj@intel.com>, <tony.luck@intel.com>,
        <sathyanarayanan.kuppuswamy@intel.com>, <qiuxu.zhuo@intel.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 09/10] PCI/PME: Add pcie_walk_rcec() to RCEC PME
 handling
Message-ID: <20200921131500.00004f57@Huawei.com>
In-Reply-To: <20200918204603.62100-10-sean.v.kelley@intel.com>
References: <20200918204603.62100-1-sean.v.kelley@intel.com>
        <20200918204603.62100-10-sean.v.kelley@intel.com>
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

On Fri, 18 Sep 2020 13:46:02 -0700
Sean V Kelley <sean.v.kelley@intel.com> wrote:

> The Root Complex Event Collectors(RCEC) appear as peers of Root Ports
> and also have the PME capability. As with AER, there is a need to be
> able to walk the RCiEPs associated with their RCEC for purposes of
> acting upon them with callbacks. So add RCEC support through the use
> of pcie_walk_rcec() to the current PME service driver and attach the
> PME service driver to the RCEC device.
> 
> Co-developed-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
> Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
> Signed-off-by: Sean V Kelley <sean.v.kelley@intel.com>

I'm a lot less familiar with this code, but looks
good to me.

Thanks,

Jonathan

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
>  	.service	= PCIE_PORT_SERVICE_PME,
>  
>  	.probe		= pcie_pme_probe,


