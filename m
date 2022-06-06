Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14F1053E600
	for <lists+linux-pci@lfdr.de>; Mon,  6 Jun 2022 19:06:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240041AbiFFOt7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 6 Jun 2022 10:49:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240032AbiFFOt6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 6 Jun 2022 10:49:58 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0E8B81499;
        Mon,  6 Jun 2022 07:49:56 -0700 (PDT)
Received: from fraeml745-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4LGx9R1CJBz67ms2;
        Mon,  6 Jun 2022 22:45:15 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml745-chm.china.huawei.com (10.206.15.226) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 6 Jun 2022 16:49:55 +0200
Received: from localhost (10.202.226.42) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 6 Jun
 2022 15:49:54 +0100
Date:   Mon, 6 Jun 2022 15:49:52 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Ira Weiny <ira.weiny@intel.com>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Alison Schofield <alison.schofield@intel.com>,
        "Vishal Verma" <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        "Ben Widawsky" <ben@bwidawsk.net>, <linux-kernel@vger.kernel.org>,
        <linux-cxl@vger.kernel.org>, <linux-pci@vger.kernel.org>
Subject: Re: [PATCH V9 6/9] cxl/port: Read CDAT table
Message-ID: <20220606154952.000008c7@Huawei.com>
In-Reply-To: <Ypk+Cc0fWelIcamX@iweiny-desk3>
References: <20220531152632.1397976-1-ira.weiny@intel.com>
        <20220531152632.1397976-7-ira.weiny@intel.com>
        <20220601163540.00006978@Huawei.com>
        <20220601173113.000005a6@Huawei.com>
        <YpkCHADvGv6i3jVP@iweiny-desk3>
        <Ypk+Cc0fWelIcamX@iweiny-desk3>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.42]
X-ClientProxiedBy: lhreml728-chm.china.huawei.com (10.201.108.79) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 2 Jun 2022 15:47:37 -0700
Ira Weiny <ira.weiny@intel.com> wrote:

> On Thu, Jun 02, 2022 at 11:31:56AM -0700, Ira wrote:
> > On Wed, Jun 01, 2022 at 05:31:13PM +0100, Jonathan Cameron wrote:  
> > > On Wed, 1 Jun 2022 16:35:40 +0100
> > > Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:
> > >   
> > > > On Tue, 31 May 2022 08:26:29 -0700
> > > > ira.weiny@intel.com wrote:
> > > >   
> > > > > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > > > 
> > > > > The OS will need CDAT data from CXL devices to properly set up
> > > > > interleave sets.  Currently this is supported through a DOE mailbox
> > > > > which supports CDAT.
> > > > > 
> > > > > Cache the CDAT data for later parsing.  Provide a sysfs binary attribute
> > > > > to allow dumping of the CDAT.
> > > > > 
> > > > > Binary dumping is modeled on /sys/firmware/ACPI/tables/
> > > > > 
> > > > > The ability to dump this table will be very useful for emulation of real
> > > > > devices once they become available as QEMU CXL type 3 device emulation will
> > > > > be able to load this file in.
> > > > > 
> > > > > This does not support table updates at runtime. It will always provide
> > > > > whatever was there when first cached. Handling of table updates can be
> > > > > implemented later.
> > > > > 
> > > > > Finally create a complete list of DOE defines within cdat.h for code
> > > > > wishing to decode the CDAT table.
> > > > > 
> > > > > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > > > Co-developed-by: Ira Weiny <ira.weiny@intel.com>
> > > > > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> > > > >     
> > > > 
> > > > Fun question of ownership inline...  
> > > 
> > > And a follow up due to triggering a bug that predated this series...
> > > 
> > > I'd send a fix, but I'm off on a long weekend shortly :)  
> > 
> > NP I discussed with Dan and the use of dev_groups should allow me to move this
> > to port probe where it belongs.  I put it here for the sysfs stuff.  
> 
> Not to make a habit of replying to my own mails but this works.
> 
> So I'm going to go forward with spinning this again.

It's the right solution - cleaner than moving the ownership.

Jonathan

> 
> Ira

