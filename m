Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFF0537BCC5
	for <lists+linux-pci@lfdr.de>; Wed, 12 May 2021 14:46:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233296AbhELMrq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 12 May 2021 08:47:46 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3066 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233299AbhELMrp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 12 May 2021 08:47:45 -0400
Received: from fraeml736-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4FgDsc0fVPz6cvjj;
        Wed, 12 May 2021 20:40:36 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml736-chm.china.huawei.com (10.206.15.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 12 May 2021 14:46:35 +0200
Received: from localhost (10.52.125.138) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Wed, 12 May
 2021 13:46:34 +0100
Date:   Wed, 12 May 2021 13:44:51 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     <linux-cxl@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Chris Browy <cbrowy@avery-design.com>,
        <linux-acpi@vger.kernel.org>, <alison.schofield@intel.com>,
        <vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
        <linuxarm@huawei.com>, Fangjian <f.fangjian@huawei.com>
Subject: Re: [RFC PATCH v3 2/4] PCI/doe: Add Data Object Exchange support
Message-ID: <20210512134451.000070c5@Huawei.com>
In-Reply-To: <20210507231013.GA1548806@bjorn-Precision-5520>
References: <20210419165451.2176200-3-Jonathan.Cameron@huawei.com>
        <20210507231013.GA1548806@bjorn-Precision-5520>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.52.125.138]
X-ClientProxiedBy: lhreml725-chm.china.huawei.com (10.201.108.76) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, 7 May 2021 18:10:13 -0500
Bjorn Helgaas <helgaas@kernel.org> wrote:

Thanks. All updates as per your comments.

> > +static int pci_doe_register(struct pci_doe *doe)
> > +{
> > +	struct pci_dev *pdev = doe->pdev;
> > +	bool poll = !pci_dev_msi_enabled(pdev);
> > +	int rc, irq;
> > +	u32 val;
> > +
> > +	pci_read_config_dword(pdev, doe->cap + PCI_DOE_CAP, &val);
> > +
> > +	if (!poll && FIELD_GET(PCI_DOE_CAP_INT, val)) {
> > +		irq = pci_irq_vector(pdev, FIELD_GET(PCI_DOE_CAP_IRQ, val));
> > +		if (irq < 0)
> > +			return irq;
> > +
> > +		rc = request_irq(irq, pci_doe_irq, 0, "DOE", doe);  
> 
> I expect there may be many devices with DOE.  Do you want some
> device identification here?  E.g., on my system I see things like this
> in /proc/interrupts:
> 
>   dmar0
>   nvme0q0
>   snd_hda_intel:card0
>   ahci[0000:00:17.0]

Good point.  For this I've currently gone with

DOE[0000:00:81.0]_160
DOE[0000:00:81.0]_190

etc as a single function can have multiple DOE instances
and the easiest way to distinguish them is the offset at
which the capability is found in config space of the device.

I'm open to other suggestions.

Jonathan


