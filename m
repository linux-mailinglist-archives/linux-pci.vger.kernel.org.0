Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1A6F27FC39
	for <lists+linux-pci@lfdr.de>; Thu,  1 Oct 2020 11:08:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731067AbgJAJIl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 1 Oct 2020 05:08:41 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2937 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725921AbgJAJIl (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 1 Oct 2020 05:08:41 -0400
Received: from lhreml710-chm.china.huawei.com (unknown [172.18.7.106])
        by Forcepoint Email with ESMTP id DCB6EF852BA1783EFB83;
        Thu,  1 Oct 2020 10:08:39 +0100 (IST)
Received: from localhost (10.52.127.250) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Thu, 1 Oct 2020
 10:08:39 +0100
Date:   Thu, 1 Oct 2020 10:06:57 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Sean V Kelley <seanvk.dev@oregontracks.org>
CC:     <bhelgaas@google.com>, <rafael.j.wysocki@intel.com>,
        <ashok.raj@intel.com>, <tony.luck@intel.com>,
        <sathyanarayanan.kuppuswamy@intel.com>, <qiuxu.zhuo@intel.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Sean V Kelley <sean.v.kelley@intel.com>
Subject: Re: [PATCH v7 05/13] PCI/ERR: Use "bridge" for clarity in
 pcie_do_recovery()
Message-ID: <20201001090657.00003fe4@Huawei.com>
In-Reply-To: <20200930215820.1113353-6-seanvk.dev@oregontracks.org>
References: <20200930215820.1113353-1-seanvk.dev@oregontracks.org>
        <20200930215820.1113353-6-seanvk.dev@oregontracks.org>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.52.127.250]
X-ClientProxiedBy: lhreml754-chm.china.huawei.com (10.201.108.204) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 30 Sep 2020 14:58:12 -0700
Sean V Kelley <seanvk.dev@oregontracks.org> wrote:

> From: Sean V Kelley <sean.v.kelley@intel.com>
> 
> The term "dev" is being applied to root ports, switch
> upstream ports, switch downstream ports, and the upstream
> ports on endpoints. While endpoint upstream ports don't have
> subordinate buses, a generic term such as "bridge" may be used

This sentence is a bit confusing.  The bit before the comma
seems only slightly connected. Perhaps 2 sentences?

> for something with a subordinate bus. The current conditional
> logic in pcie_do_recovery() would also benefit from some
> simplification with use of pci_upstream_bridge() in place of
> dev->bus->self. Reverse the pcie_do_recovery() conditional logic
> and replace use of "dev" with "bridge" for greater clarity.
> 
> Suggested-by: Bjorn Helgaas <bhelgaas@google.com>
> Signed-off-by: Sean V Kelley <sean.v.kelley@intel.com>

Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/pci/pcie/err.c | 20 +++++++++++++-------
>  1 file changed, 13 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
> index 950612342f1c..c6922c099c76 100644
> --- a/drivers/pci/pcie/err.c
> +++ b/drivers/pci/pcie/err.c
> @@ -152,16 +152,22 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
>  {
>  	pci_ers_result_t status = PCI_ERS_RESULT_CAN_RECOVER;
>  	struct pci_bus *bus;
> +	struct pci_dev *bridge;
> +	int type;
>  
>  	/*
> -	 * Error recovery runs on all subordinates of the first downstream port.
> -	 * If the downstream port detected the error, it is cleared at the end.
> +	 * Error recovery runs on all subordinates of the first downstream
> +	 * bridge. If the downstream bridge detected the error, it is
> +	 * cleared at the end.
>  	 */
> -	if (!(pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT ||
> -	      pci_pcie_type(dev) == PCI_EXP_TYPE_DOWNSTREAM))
> -		dev = dev->bus->self;
> -	bus = dev->subordinate;
> -
> +	type = pci_pcie_type(dev);
> +	if (type == PCI_EXP_TYPE_ROOT_PORT ||
> +	    type == PCI_EXP_TYPE_DOWNSTREAM)
> +		bridge = dev;
> +	else
> +		bridge = pci_upstream_bridge(dev);
> +
> +	bus = bridge->subordinate;
>  	pci_dbg(dev, "broadcast error_detected message\n");
>  	if (state == pci_channel_io_frozen) {
>  		pci_walk_bus(bus, report_frozen_detected, &status);


