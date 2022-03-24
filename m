Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83C844E64A9
	for <lists+linux-pci@lfdr.de>; Thu, 24 Mar 2022 15:05:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350542AbiCXOHR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Mar 2022 10:07:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231871AbiCXOHR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 24 Mar 2022 10:07:17 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D4A56D1AF;
        Thu, 24 Mar 2022 07:05:44 -0700 (PDT)
Received: from fraeml702-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4KPRlx4qz2z67ZTj;
        Thu, 24 Mar 2022 22:03:57 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml702-chm.china.huawei.com (10.206.15.51) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2375.24; Thu, 24 Mar 2022 15:05:41 +0100
Received: from localhost (10.202.226.41) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Thu, 24 Mar
 2022 14:05:41 +0000
Date:   Thu, 24 Mar 2022 14:05:39 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Ira Weiny <ira.weiny@intel.com>
CC:     Bjorn Helgaas <helgaas@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Alison Schofield" <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        <linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
        <linux-pci@vger.kernel.org>
Subject: Re: [PATCH V6 04/10] PCI/DOE: Introduce pci_doe_create_doe_devices
Message-ID: <20220324140539.00004be8@Huawei.com>
In-Reply-To: <Yju6quQsBDSMaNC2@iweiny-desk3>
References: <20220201071952.900068-5-ira.weiny@intel.com>
        <20220203224437.GA120552@bhelgaas>
        <Yju6quQsBDSMaNC2@iweiny-desk3>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.41]
X-ClientProxiedBy: lhreml725-chm.china.huawei.com (10.201.108.76) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Ira,

> Here is the code to be more clear...
> 
> 
> drivers/cxl/pci.c:
> 
> int cxl_pci_create_doe_devices(struct pci_dev *pdev)
> {               
>         struct device *dev = &pdev->dev;
>         bool use_irq = true;
>         int irqs = 0;
>         u16 off = 0;         
>         int rc;
>         
>         pci_doe_for_each_off(pdev, off)
>                 irqs++;
>         pci_info(pdev, "Found %d DOE mailbox's\n", irqs);
>         
>         /*                         
>          * Allocate enough vectors for the DOE's
>          */     
>         rc = pci_alloc_irq_vectors(pdev, irqs, irqs, PCI_IRQ_MSI |
>                                                      PCI_IRQ_MSIX);
>         if (rc != irqs) {
>                 pci_err(pdev, "Not enough interrupts for all the DOEs; use polling\n");
>                 use_irq = false;
>                 /* Some got allocated; clean them up */
>                 if (rc > 0)
>                         cxl_pci_free_irq_vectors(pdev); 
>         } else {
>                 /*
>                  * Enabling bus mastering is require for MSI/MSIx.  It could be
>                  * done later within the DOE initialization, but as it
>                  * potentially has other impacts keep it here when setting up
>                  * the IRQ's.
>                  */
>                 pci_set_master(pdev);
>                 rc = devm_add_action_or_reset(dev,
>                                               cxl_pci_free_irq_vectors,
>                                               pdev);
>                 if (rc)
>                         return rc;
>         }
> 
>         pci_doe_for_each_off(pdev, off) {
> ...
> 		/* Create each auxiliary device which internally calls */
> 		pci_doe_create_mb(pdev, off, use_irq);
> ...
> 	}
> ...
> }
> 
> 
> drivers/pci/pci-doe.c:
> 
> static irqreturn_t pci_doe_irq_handler(int irq, void *data)
> {
> ...
> }
> 
> static int pci_doe_request_irq(struct pci_doe_mb *doe_mb)
> {
>         struct pci_dev *pdev = doe_mb->pdev;
>         int offset = doe_mb->cap_offset;
>         int doe_irq, rc;
>         u32 val;
> 
>         pci_read_config_dword(pdev, offset + PCI_DOE_CAP, &val);
> 
>         if (!FIELD_GET(PCI_DOE_CAP_INT, val))
>                 return -ENOTSUPP;
> 
>         doe_irq = FIELD_GET(PCI_DOE_CAP_IRQ, val);
>         rc = pci_request_irq(pdev, doe_irq, pci_doe_irq_handler,
>                              NULL, doe_mb,
>                              "DOE[%d:%s]", doe_irq, pci_name(pdev));
>         if (rc) 
>                 return rc;
> 
>         doe_mb->irq = doe_irq;
>         pci_write_config_dword(pdev, offset + PCI_DOE_CTRL,
>                                PCI_DOE_CTRL_INT_EN);
>         return 0;
> }
> 
> struct pci_doe_mb *pci_doe_create_mb(struct pci_dev *pdev, u16 cap_offset,
>                                      bool use_irq)
> {
> ...
>         if (use_irq) {
>                 rc = pci_doe_request_irq(doe_mb);
>                 if (rc) 
>                         pci_err(pdev, "DOE request irq failed for mailbox @ %u : %d\n",
>                                 cap_offset, rc);
>         }
> ...
> }
> 
> 
> Does this look reasonable?

I'm a little nervous about how we are going to make DOEs on switches work.
Guess I'll do an experiment once your next version is out and check we
can do that reasonably cleanly.  For switches we'll probably have to
check for DOEs on all such ports and end up with infrastructure to
map to all protocols we might see on a switch.

Jonathan

> 
