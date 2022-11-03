Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 835C361871D
	for <lists+linux-pci@lfdr.de>; Thu,  3 Nov 2022 19:09:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230194AbiKCSJm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 3 Nov 2022 14:09:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231531AbiKCSJI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 3 Nov 2022 14:09:08 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD08B267A;
        Thu,  3 Nov 2022 11:08:38 -0700 (PDT)
Received: from fraeml704-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4N3BXQ49CSz67KdQ;
        Fri,  4 Nov 2022 02:06:30 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 fraeml704-chm.china.huawei.com (10.206.15.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2375.31; Thu, 3 Nov 2022 19:08:36 +0100
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Thu, 3 Nov
 2022 18:08:36 +0000
Date:   Thu, 3 Nov 2022 18:08:35 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Davidlohr Bueso <dave@stgolabs.net>
CC:     Bjorn Helgaas <helgaas@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>, <dave.jiang@intel.com>,
        <alison.schofield@intel.com>, <bwidawsk@kernel.org>,
        <vishal.l.verma@intel.com>, <a.manzanares@samsung.com>,
        <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        <linux-pci@vger.kernel.org>, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 1/2] cxl/pci: Add generic MSI-X/MSI irq support
Message-ID: <20221103180835.000078f6@Huawei.com>
In-Reply-To: <20221102171524.thsz2kwtirhxn7ee@offworld>
References: <20221024133633.00000467@huawei.com>
        <20221025232535.GA579167@bhelgaas>
        <20221102171524.thsz2kwtirhxn7ee@offworld>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 2 Nov 2022 10:15:24 -0700
Davidlohr Bueso <dave@stgolabs.net> wrote:

> On Tue, 25 Oct 2022, Bjorn Helgaas wrote:
> 
> >> In short that calls:
> >> /* Allocate the maximum possible number of MSI/MSI-X vectors */
> >> nr_entries = pci_alloc_irq_vectors(dev, 1, PCIE_PORT_MAX_MSI_ENTRIES,
> >>			PCI_IRQ_MSIX | PCI_IRQ_MSI);
> >>
> >> /* See how many and which Interrupt Message Numbers we actually use */
> >> nvec = pcie_message_numbers(dev, mask, &pme, &aer, &dpc);
> >>
> >> if (nvec != nr_entries) {
> >>	pci_free_irq_vectors(dev);
> >>
> >>	nr_entries = pci_alloc_irq_vectors(dev, nvec, nvec,
> >>			PCI_IRQ_MSIX | PCI_IRQ_MSI);
> >> }
> >>
> >> My worry here is that the implicit assumption is that the vectors
> >> won't move if we reduce the overall number of vectors we are asking
> >> for...  
> 
> This would also apply to what is currently in portdrv machinery, no?
> 
> >>
> >> However, imagine the case that we have a feature the driver doesn't
> >> know about that was previously at a higher vector.  After reducing
> >> the vectors allocated the hardware might decide that feature needs
> >> its own vector whereas some others can be combined.  Hence we'd end
> >> up with a less than ideal packing for the features we actually
> >> support.
> >>
> >> Could do something iterative to solve this if it actually matters
> >> (increase number of vectors until the layout matches what we get
> >> with max possible vectors).  
> 
> Maybe do a bounded retry loop until we get stable value?
> 
> retry = 1;
> do {
> 	pci_alloc_irq_vectors(1, 32);
> 	nvecs = get_max_msgnum(); // max(pmu, events, mbox, isolation)
> 	pci_free_irq_vectors();
> 
> 	pci_alloc_irq_vectors(nvecs, nvecs);
> 	new_nvecs = get_max_msgnum();
> 
> 	if (likely(new_nvecs == nvecs))
> 		return 0;
> 
> 	pci_free_irq_vectors();
> }  while (retry--);
> 
> return -1; // no irq support

Yup. That's pretty much what I was thinking - if we care :)

> 
> But yeah I'm not sure how much we actually care about this. 

That was my feeling. This might be worth a comment to say that
it's not guaranteed to be optimal (in portdrv), but probably 
a won't fix.

Jonathan
