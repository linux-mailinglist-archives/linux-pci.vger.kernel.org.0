Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C336B3762F6
	for <lists+linux-pci@lfdr.de>; Fri,  7 May 2021 11:38:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236766AbhEGJjZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 7 May 2021 05:39:25 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3038 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236764AbhEGJjZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 7 May 2021 05:39:25 -0400
Received: from fraeml714-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Fc4wv0h6Lz6rn00;
        Fri,  7 May 2021 17:32:31 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml714-chm.china.huawei.com (10.206.15.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 7 May 2021 11:38:22 +0200
Received: from localhost (10.52.124.175) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Fri, 7 May 2021
 10:38:21 +0100
Date:   Fri, 7 May 2021 10:36:38 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     <linux-cxl@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        "Lorenzo Pieralisi" <lorenzo.pieralisi@arm.com>
CC:     Ben Widawsky <ben.widawsky@intel.com>,
        Chris Browy <cbrowy@avery-design.com>,
        <linux-acpi@vger.kernel.org>, <alison.schofield@intel.com>,
        <vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
        <linuxarm@huawei.com>, Fangjian <f.fangjian@huawei.com>
Subject: Re: [RFC PATCH v3 2/4] PCI/doe: Add Data Object Exchange support
Message-ID: <20210507103638.00006c89@Huawei.com>
In-Reply-To: <20210419165451.2176200-3-Jonathan.Cameron@huawei.com>
References: <20210419165451.2176200-1-Jonathan.Cameron@huawei.com>
        <20210419165451.2176200-3-Jonathan.Cameron@huawei.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.52.124.175]
X-ClientProxiedBy: lhreml733-chm.china.huawei.com (10.201.108.84) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 20 Apr 2021 00:54:49 +0800
Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:

> Introduced in a PCI ECN [1], DOE provides a config space
> based mailbox with standard protocol discovery.  Each mailbox
> is accessed through a DOE Extended Capability.
> 
> A device may have 1 or more DOE mailboxes, each of which is allowed
> to support any number of protocols (some DOE protocol
> specifications apply additional restrictions).  A given protocol
> may be supported on more than one DOE mailbox on a given function.
> 
> If a driver wishes to access any number of DOE instances / protocols
> it makes a single call to pcie_doe_register_all() which will find
> available DOEs, create the required infrastructure and cache the
> protocols they support.  pcie_doe_find() can then retrieve a
> pointer to an appropriate DOE instance.
> 
> A synchronous interface is provided in pcie_doe_exchange_sync() to
> perform a single query / response exchange.
> 
> Testing conducted against QEMU using:
> 
> https://lore.kernel.org/qemu-devel/1612900760-7361-1-git-send-email-cbrowy@avery-design.com/
> + fix for interrupt flag mentioned in that thread and a whole load
> of hacks to exercise error paths etc.
> 
> [1] https://members.pcisig.com/wg/PCI-SIG/document/14143
>     Data Object Exchange (DOE) - Approved 12 March 2020
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---

...

> +static int pci_doe_recv_resp(struct pci_doe *doe, struct pci_doe_exchange *ex)
> +{
> +	struct pci_dev *pdev = doe->pdev;
> +	size_t length;
> +	u32 val;
> +	int i;
> +
> +	/* Read the first two dwords to get the length and protocol */
> +	pci_read_config_dword(pdev, doe->cap + PCI_DOE_READ, &val);
> +	if ((FIELD_GET(PCI_DOE_DATA_OBJECT_HEADER_1_VID, val) != ex->vid) ||
> +	    (FIELD_GET(PCI_DOE_DATA_OBJECT_HEADER_1_TYPE, val) != ex->protocol)) {
> +		pci_err(pdev,
> +			"Expected [VID, Protocol] = [%x, %x], got [%x, %x]\n",
> +			ex->vid, ex->protocol,
> +			FIELD_GET(PCI_DOE_DATA_OBJECT_HEADER_1_VID, val),
> +			FIELD_GET(PCI_DOE_DATA_OBJECT_HEADER_1_TYPE, val));
> +		return -EIO;
> +	}
> +
> +	pci_write_config_dword(pdev, doe->cap + PCI_DOE_READ, 0);
> +	pci_read_config_dword(pdev, doe->cap + PCI_DOE_READ, &val);
> +	pci_write_config_dword(pdev, doe->cap + PCI_DOE_READ, 0);
> +
> +	length = FIELD_GET(PCI_DOE_DATA_OBJECT_HEADER_2_LENGTH, val);
> +	if (length > SZ_1M)
> +		return -EIO;
> +
> +	/* Read the rest of the response payload */
> +	for (i = 0; i < min(length, ex->response_pl_sz / sizeof(u32)); i++) {

Note for anyone testing these that there is a bug here which leads to
a buffer underflow triggered reset with the latest QEMU patches
(I've not figured out yet why this didn't trigger a problem with the earlier
QEMU patch versions).

This needs to take into account that length includes the two header DW, but
the response_pl_sz does not.
 

> +		pci_read_config_dword(pdev, doe->cap + PCI_DOE_READ,
> +				      &ex->response_pl[i]);
> +		pci_write_config_dword(pdev, doe->cap + PCI_DOE_READ, 0);
> +	}
> +
> +	/* Flush excess length */
> +	for (; i < length; i++) {
> +		pci_read_config_dword(pdev, doe->cap + PCI_DOE_READ, &val);
> +		pci_write_config_dword(pdev, doe->cap + PCI_DOE_READ, 0);
> +	}
> +	/* Final error check to pick up on any since Data Object Ready */
> +	pci_read_config_dword(pdev, doe->cap + PCI_DOE_STATUS, &val);
> +	if (FIELD_GET(PCI_DOE_STATUS_ERROR, val))
> +		return -EIO;
> +
> +	return min(length, ex->response_pl_sz / sizeof(u32)) * sizeof(u32);
> +}
> +
