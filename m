Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EBD05A6410
	for <lists+linux-pci@lfdr.de>; Tue, 30 Aug 2022 14:54:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230185AbiH3MyP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 30 Aug 2022 08:54:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230078AbiH3Mxx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 30 Aug 2022 08:53:53 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 835A614FC96;
        Tue, 30 Aug 2022 05:53:45 -0700 (PDT)
Received: from fraeml708-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4MH6ft0wyhz687Jl;
        Tue, 30 Aug 2022 20:53:10 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 fraeml708-chm.china.huawei.com (10.206.15.36) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 30 Aug 2022 14:53:42 +0200
Received: from localhost (10.202.226.42) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 30 Aug
 2022 13:53:41 +0100
Date:   Tue, 30 Aug 2022 13:53:40 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     Ira Weiny <ira.weiny@intel.com>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pci@vger.kernel.org>
Subject: Re: [PATCH V2 1/2] PCI: Allow drivers to request exclusive config
 regions
Message-ID: <20220830135340.00000e6f@huawei.com>
In-Reply-To: <YweZjRYVcT5uCg2i@iweiny-desk3>
References: <20220824232450.723179-1-ira.weiny@intel.com>
        <20220824232450.723179-2-ira.weiny@intel.com>
        <20220825160658.000051a6@huawei.com>
        <YweZjRYVcT5uCg2i@iweiny-desk3>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.42]
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 25 Aug 2022 08:47:25 -0700
Ira Weiny <ira.weiny@intel.com> wrote:

> On Thu, Aug 25, 2022 at 04:06:58PM +0100, Jonathan Cameron wrote:
> > On Wed, 24 Aug 2022 16:24:49 -0700
> > ira.weiny@intel.com wrote:
> >   
> > > From: Ira Weiny <ira.weiny@intel.com>
> > > 
> > > PCI config space access from user space has traditionally been
> > > unrestricted with writes being an understood risk for device operation.
> > > 
> > > Unfortunately, device breakage or odd behavior from config writes lacks
> > > indicators that can leave driver writers confused when evaluating
> > > failures.  This is especially true with the new PCIe Data Object
> > > Exchange (DOE) mailbox protocol where backdoor shenanigans from user
> > > space through things such as vendor defined protocols may affect device
> > > operation without complete breakage.
> > > 
> > > A prior proposal restricted read and writes completely.[1]  Greg and
> > > Bjorn pointed out that proposal is flawed for a couple of reasons.
> > > First, lspci should always be allowed and should not interfere with any
> > > device operation.  Second, setpci is a valuable tool that is sometimes
> > > necessary and it should not be completely restricted.[2]  Finally
> > > methods exist for full lock of device access if required.
> > > 
> > > Even though access should not be restricted it would be nice for driver
> > > writers to be able to flag critical parts of the config space such that
> > > interference from user space can be detected.
> > > 
> > > Introduce pci_request_config_region_exclusive() to mark exclusive config
> > > regions.  Such regions trigger a warning and kernel taint if accessed
> > > via user space.
> > > 
> > > Create pci_warn_once() to restrict the user from spamming the log.
> > > 
> > > [1] https://lore.kernel.org/all/161663543465.1867664.5674061943008380442.stgit@dwillia2-desk3.amr.corp.intel.com/
> > > [2] https://lore.kernel.org/all/YF8NGeGv9vYcMfTV@kroah.com/
> > > 
> > > Cc: Bjorn Helgaas <bhelgaas@google.com>
> > > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > Suggested-by: Dan Williams <dan.j.williams@intel.com>
> > > Signed-off-by: Ira Weiny <ira.weiny@intel.com>  
> > One comment inline.
> > 
> > I'm not totally convinced of the necessity of this, but done this way
> > it has very little impact so I'm fine with it.
> > 
> > Other than the comment about not realigning things...
> > 
> > Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>  
> 
> Thanks!
> 
> [snip]
> 
> > >  /* drivers/pci/bus.c */
> > >  void pci_add_resource(struct list_head *resources, struct resource *res);
> > >  void pci_add_resource_offset(struct list_head *resources, struct resource *res,
> > > @@ -2486,14 +2502,15 @@ void pci_uevent_ers(struct pci_dev *pdev, enum  pci_ers_result err_type);
> > >  #define pci_printk(level, pdev, fmt, arg...) \
> > >  	dev_printk(level, &(pdev)->dev, fmt, ##arg)
> > >  
> > > -#define pci_emerg(pdev, fmt, arg...)	dev_emerg(&(pdev)->dev, fmt, ##arg)
> > > -#define pci_alert(pdev, fmt, arg...)	dev_alert(&(pdev)->dev, fmt, ##arg)
> > > -#define pci_crit(pdev, fmt, arg...)	dev_crit(&(pdev)->dev, fmt, ##arg)
> > > -#define pci_err(pdev, fmt, arg...)	dev_err(&(pdev)->dev, fmt, ##arg)
> > > -#define pci_warn(pdev, fmt, arg...)	dev_warn(&(pdev)->dev, fmt, ##arg)
> > > -#define pci_notice(pdev, fmt, arg...)	dev_notice(&(pdev)->dev, fmt, ##arg)
> > > -#define pci_info(pdev, fmt, arg...)	dev_info(&(pdev)->dev, fmt, ##arg)
> > > -#define pci_dbg(pdev, fmt, arg...)	dev_dbg(&(pdev)->dev, fmt, ##arg)
> > > +#define pci_emerg(pdev, fmt, arg...)	 dev_emerg(&(pdev)->dev, fmt, ##arg)
> > > +#define pci_alert(pdev, fmt, arg...)	 dev_alert(&(pdev)->dev, fmt, ##arg)
> > > +#define pci_crit(pdev, fmt, arg...)	 dev_crit(&(pdev)->dev, fmt, ##arg)
> > > +#define pci_err(pdev, fmt, arg...)	 dev_err(&(pdev)->dev, fmt, ##arg)
> > > +#define pci_warn(pdev, fmt, arg...)	 dev_warn(&(pdev)->dev, fmt, ##arg)
> > > +#define pci_warn_once(pdev, fmt, arg...) dev_warn_once(&(pdev)->dev, fmt, ##arg)
> > > +#define pci_notice(pdev, fmt, arg...)	 dev_notice(&(pdev)->dev, fmt, ##arg)
> > > +#define pci_info(pdev, fmt, arg...)	 dev_info(&(pdev)->dev, fmt, ##arg)
> > > +#define pci_dbg(pdev, fmt, arg...)	 dev_dbg(&(pdev)->dev, fmt, ##arg)  
> > 
> > This realignment is a lot of noise.  Do we really care about one diffentlyu
> > aligned entry? + if you are going to do it two tabs rather than a space
> > following the tab (I think that's what you have here?)  
> 
> I struggled a bit on this.  Not aligning makes the final code look odd while
> the patch looks good.  Aligning with 2 tabs pushes everything past the 80 col
> standard.

If you really want to do this then break the 80 char limit.  Weird space + tab combinations
are a bad idea longer term.  Maybe do reformat as precursor 'no functional change' patch
to make it all readable?

> 
> This seemed like a good compromise.
> 
> Thanks for the review,
> Ira
> 
> 

