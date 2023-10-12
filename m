Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A76AD7C7167
	for <lists+linux-pci@lfdr.de>; Thu, 12 Oct 2023 17:27:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379459AbjJLP1Q (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 12 Oct 2023 11:27:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379476AbjJLP1L (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 12 Oct 2023 11:27:11 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C04DCFD;
        Thu, 12 Oct 2023 08:27:08 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11FEDC433C7;
        Thu, 12 Oct 2023 15:27:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697124428;
        bh=2H8uGr4Sh1OiavbH2JgHBR1t5d/J1kkWJxFqreXacg0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=bhzWOIrpuMZoiq7IdctJDzTQtMCE8yHFiZ3kY8XAPqEyyLH81t/fU18359sKdvOIj
         uoKgIWPcSAiWMo52UUFt5+2zHdgtd1SPKUbjpL/BhFXQjyzZFtwxaqjmNFao8AaT1H
         +baVPnJQC/38rsOJZ+7CzRAcGSaR0qiDUUUnFL55Fy9YTBryvjb4b33iQln0RzFddT
         MHK94ipJ+h2DC0EbZJ3eexQdfoxyN49BeG6fy5PUTeko7tdY/dwac67KiVCgh646ME
         Ws6pCtpHgaYvqqpfiod96tjTbIGsQXT+XSs3BO26ndwnU/k1U8OpKajzeZDEBKeeSx
         hRpq/cpqM12GQ==
Date:   Thu, 12 Oct 2023 10:27:05 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Shuai Xue <xueshuai@linux.alibaba.com>
Cc:     chengyou@linux.alibaba.com, kaishen@linux.alibaba.com,
        yangyicong@huawei.com, will@kernel.org,
        Jonathan.Cameron@huawei.com, baolin.wang@linux.alibaba.com,
        robin.murphy@arm.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        rdunlap@infradead.org, mark.rutland@arm.com,
        zhuo.song@linux.alibaba.com, renyu.zj@linux.alibaba.com
Subject: Re: [PATCH v7 2/4] PCI: Add Alibaba Vendor ID to linux/pci_ids.h
Message-ID: <20231012152705.GA1070955@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231012145940.GA1069329@bhelgaas>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Oct 12, 2023 at 09:59:40AM -0500, Bjorn Helgaas wrote:
> On Thu, Oct 12, 2023 at 11:28:54AM +0800, Shuai Xue wrote:
> > The Alibaba Vendor ID (0x1ded) is now used by Alibaba elasticRDMA ("erdma")
> > and will be shared with the upcoming PCIe PMU ("dwc_pcie_pmu"). Move the
> > Vendor ID to linux/pci_ids.h so that it can shared by several drivers
> > later.
> > 
> > Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
> 
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>	# pci_ids.h

Hehe, just noticed that I acked this previously:
https://lore.kernel.org/r/20230606153143.GA1124867@bhelgaas

You can pick up acks like that and include them when you post future
versions so people don't have to ack them again.  (Drop the acks if
you make significant changes to the patch, of course.)

> > ---
> >  drivers/infiniband/hw/erdma/erdma_hw.h | 2 --
> >  include/linux/pci_ids.h                | 2 ++
> >  2 files changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/infiniband/hw/erdma/erdma_hw.h b/drivers/infiniband/hw/erdma/erdma_hw.h
> > index 9d316fdc6f9a..a155519a862f 100644
> > --- a/drivers/infiniband/hw/erdma/erdma_hw.h
> > +++ b/drivers/infiniband/hw/erdma/erdma_hw.h
> > @@ -11,8 +11,6 @@
> >  #include <linux/types.h>
> >  
> >  /* PCIe device related definition. */
> > -#define PCI_VENDOR_ID_ALIBABA 0x1ded
> > -
> >  #define ERDMA_PCI_WIDTH 64
> >  #define ERDMA_FUNC_BAR 0
> >  #define ERDMA_MISX_BAR 2
> > diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> > index 5fb3d4c393a9..d8760daf9e5a 100644
> > --- a/include/linux/pci_ids.h
> > +++ b/include/linux/pci_ids.h
> > @@ -2601,6 +2601,8 @@
> >  #define PCI_VENDOR_ID_TEKRAM		0x1de1
> >  #define PCI_DEVICE_ID_TEKRAM_DC290	0xdc29
> >  
> > +#define PCI_VENDOR_ID_ALIBABA		0x1ded
> > +
> >  #define PCI_VENDOR_ID_TEHUTI		0x1fc9
> >  #define PCI_DEVICE_ID_TEHUTI_3009	0x3009
> >  #define PCI_DEVICE_ID_TEHUTI_3010	0x3010
> > -- 
> > 2.39.3
> > 
> > 
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
