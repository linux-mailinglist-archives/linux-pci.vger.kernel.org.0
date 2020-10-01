Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BA1527FCC4
	for <lists+linux-pci@lfdr.de>; Thu,  1 Oct 2020 12:02:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725975AbgJAKCh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 1 Oct 2020 06:02:37 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2938 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725938AbgJAKCh (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 1 Oct 2020 06:02:37 -0400
Received: from lhreml710-chm.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id A04EBA1DF8756758B9D4;
        Thu,  1 Oct 2020 11:02:35 +0100 (IST)
Received: from localhost (10.52.127.250) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Thu, 1 Oct 2020
 11:02:35 +0100
Date:   Thu, 1 Oct 2020 11:00:52 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Sean V Kelley <seanvk.dev@oregontracks.org>
CC:     <bhelgaas@google.com>, <rafael.j.wysocki@intel.com>,
        <ashok.raj@intel.com>, <tony.luck@intel.com>,
        <sathyanarayanan.kuppuswamy@intel.com>, <qiuxu.zhuo@intel.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Sean V Kelley <sean.v.kelley@intel.com>
Subject: Re: [PATCH v7 06/13] PCI/ERR: Limit AER resets in
 pcie_do_recovery()
Message-ID: <20201001100052.00004f86@Huawei.com>
In-Reply-To: <20200930215820.1113353-7-seanvk.dev@oregontracks.org>
References: <20200930215820.1113353-1-seanvk.dev@oregontracks.org>
        <20200930215820.1113353-7-seanvk.dev@oregontracks.org>
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

On Wed, 30 Sep 2020 14:58:13 -0700
Sean V Kelley <seanvk.dev@oregontracks.org> wrote:

> From: Sean V Kelley <sean.v.kelley@intel.com>
> 
> In some cases a bridge may not exist as the hardware
> controlling may be handled only by firmware and so is
> not visible to the OS. This scenario is also possible
> in future use cases involving non-native use of RCECs
> by firmware. So explicitly apply conditional logic
> around these resets by limiting them to root ports and
> downstream ports.
> 
> Signed-off-by: Sean V Kelley <sean.v.kelley@intel.com>

Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/pci/pcie/err.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
> index c6922c099c76..9e552330155b 100644
> --- a/drivers/pci/pcie/err.c
> +++ b/drivers/pci/pcie/err.c
> @@ -203,9 +203,12 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
>  	pci_dbg(dev, "broadcast resume message\n");
>  	pci_walk_bus(bus, report_resume, &status);
>  
> -	if (pcie_aer_is_native(dev))
> -		pcie_clear_device_status(dev);
> -	pci_aer_clear_nonfatal_status(dev);
> +	if (type == PCI_EXP_TYPE_ROOT_PORT ||
> +	    type == PCI_EXP_TYPE_DOWNSTREAM) {
> +		if (pcie_aer_is_native(bridge))
> +			pcie_clear_device_status(bridge);
> +		pci_aer_clear_nonfatal_status(bridge);
> +	}
>  	pci_info(dev, "device recovery successful\n");
>  	return status;
>  


