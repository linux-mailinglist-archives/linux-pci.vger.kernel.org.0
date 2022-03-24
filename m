Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AFE94E6B4E
	for <lists+linux-pci@lfdr.de>; Fri, 25 Mar 2022 00:44:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356525AbiCXXqV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Mar 2022 19:46:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356523AbiCXXqU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 24 Mar 2022 19:46:20 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 443AE5D18D;
        Thu, 24 Mar 2022 16:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648165487; x=1679701487;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KBpnlCVZ8nRN+ALtwdZ8Rbm5u3lomhYmGYs2GDkyH+E=;
  b=lSYDkl9/hZbXFG0BLHnmUGtHlY/++2IG+Z3xHcUxFvtQ32O0WNnPDc7G
   RiEwjDhByAJzx2WNcY3bPzpPU93MNzkdy5dhJD4EudPwAIFIJnoL/X6Vg
   8ud4ro0wWXsjO1aWfH90yC4yrN/0X5ysNGahfAt3AOBAu9WsXccO7NqKz
   2KfbBNrUUOZWnBoeCXWQ4MaxvE70eYlnzYx6rZMSivkrxVy3JBrjYj1V+
   Yvr5dMa0+eZjqToDgT4JyLKciYSaUvnxndN2hap3sHCZsjZGYiLP/Vi+o
   B7epwrYXxreKDJX/yquis17czhs502NKVqUz8cwSaj6A1i+QaqJGkBKgB
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10296"; a="239119914"
X-IronPort-AV: E=Sophos;i="5.90,208,1643702400"; 
   d="scan'208";a="239119914"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2022 16:44:33 -0700
X-IronPort-AV: E=Sophos;i="5.90,208,1643702400"; 
   d="scan'208";a="786348143"
Received: from padillaa-mobl.amr.corp.intel.com (HELO localhost) ([10.212.46.66])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2022 16:44:33 -0700
Date:   Thu, 24 Mar 2022 16:44:33 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH V6 04/10] PCI/DOE: Introduce pci_doe_create_doe_devices
Message-ID: <Yj0CYdSrVMxlmXyJ@iweiny-desk3>
References: <20220201071952.900068-5-ira.weiny@intel.com>
 <20220203224437.GA120552@bhelgaas>
 <Yju6quQsBDSMaNC2@iweiny-desk3>
 <20220324140539.00004be8@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220324140539.00004be8@Huawei.com>
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Mar 24, 2022 at 02:05:39PM +0000, Jonathan Cameron wrote:
> Hi Ira,
> 
> > Here is the code to be more clear...
> > 
> > 
> > drivers/cxl/pci.c:
> > 
> > int cxl_pci_create_doe_devices(struct pci_dev *pdev)
> > {               
> >         struct device *dev = &pdev->dev;
> >         bool use_irq = true;
> >         int irqs = 0;
> >         u16 off = 0;         
> >         int rc;
> >         
> >         pci_doe_for_each_off(pdev, off)
> >                 irqs++;
> >         pci_info(pdev, "Found %d DOE mailbox's\n", irqs);
> >         
> >         /*                         
> >          * Allocate enough vectors for the DOE's
> >          */     
> >         rc = pci_alloc_irq_vectors(pdev, irqs, irqs, PCI_IRQ_MSI |
> >                                                      PCI_IRQ_MSIX);
> >         if (rc != irqs) {
> >                 pci_err(pdev, "Not enough interrupts for all the DOEs; use polling\n");
> >                 use_irq = false;
> >                 /* Some got allocated; clean them up */
> >                 if (rc > 0)
> >                         cxl_pci_free_irq_vectors(pdev); 
> >         } else {
> >                 /*
> >                  * Enabling bus mastering is require for MSI/MSIx.  It could be
> >                  * done later within the DOE initialization, but as it
> >                  * potentially has other impacts keep it here when setting up
> >                  * the IRQ's.
> >                  */
> >                 pci_set_master(pdev);
> >                 rc = devm_add_action_or_reset(dev,
> >                                               cxl_pci_free_irq_vectors,
> >                                               pdev);
> >                 if (rc)
> >                         return rc;
> >         }
> > 
> >         pci_doe_for_each_off(pdev, off) {
> > ...
> > 		/* Create each auxiliary device which internally calls */
> > 		pci_doe_create_mb(pdev, off, use_irq);
> > ...
> > 	}
> > ...
> > }
> > 
> > 
> > drivers/pci/pci-doe.c:
> > 
> > static irqreturn_t pci_doe_irq_handler(int irq, void *data)
> > {
> > ...
> > }
> > 
> > static int pci_doe_request_irq(struct pci_doe_mb *doe_mb)
> > {
> >         struct pci_dev *pdev = doe_mb->pdev;
> >         int offset = doe_mb->cap_offset;
> >         int doe_irq, rc;
> >         u32 val;
> > 
> >         pci_read_config_dword(pdev, offset + PCI_DOE_CAP, &val);
> > 
> >         if (!FIELD_GET(PCI_DOE_CAP_INT, val))
> >                 return -ENOTSUPP;
> > 
> >         doe_irq = FIELD_GET(PCI_DOE_CAP_IRQ, val);
> >         rc = pci_request_irq(pdev, doe_irq, pci_doe_irq_handler,
> >                              NULL, doe_mb,
> >                              "DOE[%d:%s]", doe_irq, pci_name(pdev));
> >         if (rc) 
> >                 return rc;
> > 
> >         doe_mb->irq = doe_irq;
> >         pci_write_config_dword(pdev, offset + PCI_DOE_CTRL,
> >                                PCI_DOE_CTRL_INT_EN);
> >         return 0;
> > }
> > 
> > struct pci_doe_mb *pci_doe_create_mb(struct pci_dev *pdev, u16 cap_offset,
> >                                      bool use_irq)
> > {
> > ...
> >         if (use_irq) {
> >                 rc = pci_doe_request_irq(doe_mb);
> >                 if (rc) 
> >                         pci_err(pdev, "DOE request irq failed for mailbox @ %u : %d\n",
> >                                 cap_offset, rc);
> >         }
> > ...
> > }
> > 
> > 
> > Does this look reasonable?
> 
> I'm a little nervous about how we are going to make DOEs on switches work.
> Guess I'll do an experiment once your next version is out and check we
> can do that reasonably cleanly.  For switches we'll probably have to
> check for DOEs on all such ports and end up with infrastructure to
> map to all protocols we might see on a switch.

Are the switches not represented as PCI devices in linux?

If my vision of switches is correct I think that problem is independent of what
I'm solving here.  In other words the relationship between a port on a switch
and a DOE capability on that switch will have to be established somehow and
nothing I'm doing precludes doing that, but at the same time nothing I'm doing
helps that either.

Ira

> 
> Jonathan
> 
> > 
