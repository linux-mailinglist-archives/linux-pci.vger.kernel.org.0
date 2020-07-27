Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 625A922EE31
	for <lists+linux-pci@lfdr.de>; Mon, 27 Jul 2020 16:04:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726247AbgG0OEb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 27 Jul 2020 10:04:31 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2538 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726222AbgG0OEb (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 27 Jul 2020 10:04:31 -0400
Received: from lhreml710-chm.china.huawei.com (unknown [172.18.7.106])
        by Forcepoint Email with ESMTP id 4F2AE8D2104DF16A698C;
        Mon, 27 Jul 2020 15:04:27 +0100 (IST)
Received: from localhost (10.227.96.57) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Mon, 27 Jul
 2020 15:04:27 +0100
Date:   Mon, 27 Jul 2020 15:04:26 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     Sean V Kelley <sean.v.kelley@intel.com>
CC:     <bhelgaas@google.com>, <rjw@rjwysocki.net>, <ashok.raj@kernel.org>,
        <tony.luck@intel.com>,
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 4/9] PCI/AER: Extend AER error handling to RCECs
Message-ID: <20200727150426.00005cde@huawei.com>
In-Reply-To: <20200724172223.145608-5-sean.v.kelley@intel.com>
References: <20200724172223.145608-1-sean.v.kelley@intel.com>
        <20200724172223.145608-5-sean.v.kelley@intel.com>
Organization: Huawei tech. R&D (UK)  Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.227.96.57]
X-ClientProxiedBy: lhreml719-chm.china.huawei.com (10.201.108.70) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, 24 Jul 2020 10:22:18 -0700
Sean V Kelley <sean.v.kelley@intel.com> wrote:

> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Currently the kernel does not handle AER errors for Root Complex integrated
> End Points (RCiEPs)[0]. These devices sit on a root bus within the Root Complex
> (RC). AER handling is performed by a Root Complex Event Collector (RCEC) [1]
> which is a effectively a type of RCiEP on the same root bus.
> 
> For an RCEC (technically not a Bridge), error messages "received" from
> associated RCiEPs must be enabled for "transmission" in order to cause a
> System Error via the Root Control register or (when the Advanced Error
> Reporting Capability is present) reporting via the Root Error Command
> register and logging in the Root Error Status register and Error Source
> Identification register.
> 
> In addition to the defined OS level handling of the reset flow for the
> associated RCiEPs of an RCEC, it is possible to also have a firmware first
> model. In that case there is no need to take any actions on the RCEC because
> the firmware is responsible for them. This is true where APEI [2] is used
> to report the AER errors via a GHES[v2] HEST entry [3] and relevant
> AER CPER record [4] and Firmware First handling is in use.
> 
> We effectively end up with two different types of discovery for
> purposes of handling AER errors:
> 
> 1) Normal bus walk - we pass the downstream port above a bus to which
> the device is attached and it walks everything below that point.
> 
> 2) An RCiEP with no visible association with an RCEC as there is no need to
> walk devices. In that case, the flow is to just call the callbacks for the actual
> device.
> 
> A new walk function, similar to pci_bus_walk is provided that takes a pci_dev
> instead of a bus. If that dev corresponds to a downstream port it will walk
> the subordinate bus of that downstream port. If the dev does not then it
> will call the function on that device alone.
> 
> [0] ACPI PCI Express Base Specification 5.0-1 1.3.2.3 Root Complex Integrated
>     Endpoint Rules.
> [1] ACPI PCI Express Base Specification 5.0-1 6.2 Error Signalling and Logging
> [2] ACPI Specification 6.3 Chapter 18 ACPI Platform Error Interface (APEI)
> [3] ACPI Specification 6.3 18.2.3.7 Generic Hardware Error Source
> [4] UEFI Specification 2.8, N.2.7 PCI Express Error Section
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Sean V Kelley <sean.v.kelley@intel.com>
> ---
...


>  	pci_dbg(dev, "broadcast resume message\n");
> -	pci_walk_bus(bus, report_resume, &status);
> +	pci_walk_dev_affected(dev, report_resume, &status);
>  
> -	pci_aer_clear_device_status(dev);
> -	pci_aer_clear_nonfatal_status(dev);

This code had changed a little in Bjorn's pci/next branch so do a rebase on that
before v2.

> +	if ((pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT ||
> +	     pci_pcie_type(dev) == PCI_EXP_TYPE_DOWNSTREAM ||
> +	     pci_pcie_type(dev) == PCI_EXP_TYPE_RC_EC)) {
> +		pci_aer_clear_device_status(dev);
> +		pci_aer_clear_nonfatal_status(dev);
> +	}
>  	pci_info(dev, "device recovery successful\n");
>  	return status;
>  

