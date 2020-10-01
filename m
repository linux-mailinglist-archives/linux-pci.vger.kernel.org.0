Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFAED27FC2B
	for <lists+linux-pci@lfdr.de>; Thu,  1 Oct 2020 11:04:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725921AbgJAJEs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 1 Oct 2020 05:04:48 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2936 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725894AbgJAJEs (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 1 Oct 2020 05:04:48 -0400
Received: from lhreml710-chm.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id A1A4C8585A12267FE48A;
        Thu,  1 Oct 2020 10:04:47 +0100 (IST)
Received: from localhost (10.52.127.250) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Thu, 1 Oct 2020
 10:04:47 +0100
Date:   Thu, 1 Oct 2020 10:03:04 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Sean V Kelley <seanvk.dev@oregontracks.org>
CC:     <bhelgaas@google.com>, <rafael.j.wysocki@intel.com>,
        <ashok.raj@intel.com>, <tony.luck@intel.com>,
        <sathyanarayanan.kuppuswamy@intel.com>, <qiuxu.zhuo@intel.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Sean V Kelley <sean.v.kelley@intel.com>,
        Bjorn Helgaas <helgaas@google.com>
Subject: Re: [PATCH v7 04/13] PCI/ERR: Rename reset_link() to
 reset_subordinate_device()
Message-ID: <20201001090304.00003ab7@Huawei.com>
In-Reply-To: <20200930215820.1113353-5-seanvk.dev@oregontracks.org>
References: <20200930215820.1113353-1-seanvk.dev@oregontracks.org>
        <20200930215820.1113353-5-seanvk.dev@oregontracks.org>
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

On Wed, 30 Sep 2020 14:58:11 -0700
Sean V Kelley <seanvk.dev@oregontracks.org> wrote:

> From: Sean V Kelley <sean.v.kelley@intel.com>
> 
> reset_link() appears to be misnamed. The point is to really
> reset any devices below a given bridge. So rename it to
> reset_subordinate_devices() to make it clear that we are
> passing a bridge with the intent to reset the devices below it.
> 
> Suggested-by: Bjorn Helgaas <helgaas@google.com>
> Signed-off-by: Sean V Kelley <sean.v.kelley@intel.com>

Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/pci/pci.h      | 2 +-
>  drivers/pci/pcie/err.c | 6 +++---
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 88e27a98def5..efea170805fa 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -574,7 +574,7 @@ static inline int pci_dev_specific_disable_acs_redir(struct pci_dev *dev)
>  /* PCI error reporting and recovery */
>  pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
>  			pci_channel_state_t state,
> -			pci_ers_result_t (*reset_link)(struct pci_dev *pdev));
> +			pci_ers_result_t (*reset_subordinate_devices)(struct pci_dev *pdev));
>  
>  bool pcie_wait_for_link(struct pci_dev *pdev, bool active);
>  #ifdef CONFIG_PCIEASPM
> diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
> index c543f419d8f9..950612342f1c 100644
> --- a/drivers/pci/pcie/err.c
> +++ b/drivers/pci/pcie/err.c
> @@ -148,7 +148,7 @@ static int report_resume(struct pci_dev *dev, void *data)
>  
>  pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
>  			pci_channel_state_t state,
> -			pci_ers_result_t (*reset_link)(struct pci_dev *pdev))
> +			pci_ers_result_t (*reset_subordinate_devices)(struct pci_dev *pdev))
>  {
>  	pci_ers_result_t status = PCI_ERS_RESULT_CAN_RECOVER;
>  	struct pci_bus *bus;
> @@ -165,9 +165,9 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
>  	pci_dbg(dev, "broadcast error_detected message\n");
>  	if (state == pci_channel_io_frozen) {
>  		pci_walk_bus(bus, report_frozen_detected, &status);
> -		status = reset_link(dev);
> +		status = reset_subordinate_device(dev);
>  		if (status != PCI_ERS_RESULT_RECOVERED) {
> -			pci_warn(dev, "link reset failed\n");
> +			pci_warn(dev, "subordinate device reset failed\n");
>  			goto failed;
>  		}
>  	} else {


