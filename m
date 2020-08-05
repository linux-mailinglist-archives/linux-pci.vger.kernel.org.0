Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5520123CDCF
	for <lists+linux-pci@lfdr.de>; Wed,  5 Aug 2020 19:54:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728982AbgHERxr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 5 Aug 2020 13:53:47 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2582 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728936AbgHERxZ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 5 Aug 2020 13:53:25 -0400
Received: from lhreml710-chm.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id 21B0DB8CEC8AF97E1437;
        Wed,  5 Aug 2020 18:53:24 +0100 (IST)
Received: from localhost (10.52.120.30) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Wed, 5 Aug 2020
 18:53:23 +0100
Date:   Wed, 5 Aug 2020 18:51:58 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Sean V Kelley <sean.v.kelley@intel.com>
CC:     <bhelgaas@google.com>, <rjw@rjwysocki.net>, <ashok.raj@intel.com>,
        <tony.luck@intel.com>,
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Subject: Re: [PATCH V2 8/9] PCI/PME: Add RCEC PME handling
Message-ID: <20200805185158.00001196@Huawei.com>
In-Reply-To: <20200804194052.193272-9-sean.v.kelley@intel.com>
References: <20200804194052.193272-1-sean.v.kelley@intel.com>
        <20200804194052.193272-9-sean.v.kelley@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.52.120.30]
X-ClientProxiedBy: lhreml744-chm.china.huawei.com (10.201.108.194) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 4 Aug 2020 12:40:51 -0700
Sean V Kelley <sean.v.kelley@intel.com> wrote:

> The Root Complex Event Collectors(RCEC) appear as peers of Root Ports
> and also have the PME capability. So add RCEC support to the current PME
> service driver and attach the PME service driver to the RCEC device.
> 
> Co-developed-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
> Signed-off-by: Sean V Kelley <sean.v.kelley@intel.com>
> Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>

I'm not particularly familiar with the PME side of things, but from the
stand point of it does what I'd expect to see...

FWIW:
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

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


