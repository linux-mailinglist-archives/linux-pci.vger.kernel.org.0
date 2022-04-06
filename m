Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 913154F61C8
	for <lists+linux-pci@lfdr.de>; Wed,  6 Apr 2022 16:37:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234702AbiDFOVU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 6 Apr 2022 10:21:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234614AbiDFOVJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 6 Apr 2022 10:21:09 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF6493479AB;
        Wed,  6 Apr 2022 03:27:06 -0700 (PDT)
Received: from fraeml743-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4KYKvz0p6rz686vL;
        Wed,  6 Apr 2022 18:08:15 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml743-chm.china.huawei.com (10.206.15.224) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 6 Apr 2022 12:11:12 +0200
Received: from localhost (10.202.226.41) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 6 Apr
 2022 11:11:11 +0100
Date:   Wed, 6 Apr 2022 11:11:10 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Ira Weiny <ira.weiny@intel.com>
CC:     Lukas Wunner <lukas@wunner.de>,
        Christoph Hellwig <hch@infradead.org>,
        "Dan Williams" <dan.j.williams@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        <linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
        <linux-pci@vger.kernel.org>
Subject: Re: [PATCH V7 03/10] PCI: Create PCI library functions in support
 of DOE mailboxes.
Message-ID: <20220406111110.00000e72@Huawei.com>
In-Reply-To: <YkzPIzIhfzQKIMe0@iweiny-desk3>
References: <20220330235920.2800929-1-ira.weiny@intel.com>
        <20220330235920.2800929-4-ira.weiny@intel.com>
        <YkVBJ+nRA2g/WDxa@infradead.org>
        <YkXGnKsTEUAe29io@iweiny-desk3>
        <20220402144845.GA7822@wunner.de>
        <YkzPIzIhfzQKIMe0@iweiny-desk3>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.41]
X-ClientProxiedBy: lhreml720-chm.china.huawei.com (10.201.108.71) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 5 Apr 2022 16:22:11 -0700
Ira Weiny <ira.weiny@intel.com> wrote:

> On Sat, Apr 02, 2022 at 04:48:45PM +0200, Lukas Wunner wrote:
> > On Thu, Mar 31, 2022 at 08:19:56AM -0700, Ira Weiny wrote:  
> > > On Wed, Mar 30, 2022 at 10:50:31PM -0700, Christoph Hellwig wrote:  
> > > > On Wed, Mar 30, 2022 at 04:59:13PM -0700, ira.weiny@intel.com wrote:  
> > > > > Introduced in a PCI v6.0[1], DOE provides a config space based mailbox
> > > > > with standard protocol discovery.  Each mailbox is accessed through a
> > > > > DOE Extended Capability.  
> > > > 
> > > > I really don't think this should be built unconditionally and bloat
> > > > every single kernel built with PCI support.  
> > > 
> > > I can add a Kconfig.  
> > 
> > Ideally, that config option should live in the pcie/ subdirectory,
> > i.e. in drivers/pci/pcie/Kconfig, alongside drivers/pci/pcie/doe.c,
> > as we try to consolidate PCIe-specific features there and reserve
> > core code in drivers/pci/*.c for functionality that also applies
> > to Conventional PCI.  
> 
> Thanks for letting me know about this direction.  I was unaware of this.

We had this in the pcie directory, but Bjorn asked us to move it to the pci
directory as there isn't anything specific to PCIe about DOE. You could
implement it on pci-x (maybe 2.0?) I think even though it's in the PCIe specification.

https://lore.kernel.org/linux-pci/20210413194927.GA2241331@bjorn-Precision-5520/

Thanks,

Jonathan


> 
> I'll move the file no problem, thanks,
> Ira
> 
> > 
> > Thanks,
> > 
> > Lukas  

