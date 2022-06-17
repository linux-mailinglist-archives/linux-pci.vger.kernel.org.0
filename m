Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E50A854F53D
	for <lists+linux-pci@lfdr.de>; Fri, 17 Jun 2022 12:22:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230307AbiFQKVf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 17 Jun 2022 06:21:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235307AbiFQKVe (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 17 Jun 2022 06:21:34 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05E9E6A016;
        Fri, 17 Jun 2022 03:21:31 -0700 (PDT)
Received: from fraeml740-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4LPZm31CyTz67LSS;
        Fri, 17 Jun 2022 18:19:47 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml740-chm.china.huawei.com (10.206.15.221) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 17 Jun 2022 12:21:29 +0200
Received: from localhost (10.81.209.131) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2375.24; Fri, 17 Jun
 2022 11:21:28 +0100
Date:   Fri, 17 Jun 2022 11:21:24 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Ira Weiny <ira.weiny@intel.com>
CC:     "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, Lukas Wunner <lukas@wunner.de>,
        "Christoph Hellwig" <hch@infradead.org>,
        Adam Manzanares <a.manzanares@samsung.com>,
        "ben@bwidawsk.net" <ben@bwidawsk.net>, <linuxarm@huawei.com>,
        <lorenzo.pieralisi@arm.com>,
        "Box, David E" <david.e.box@intel.com>,
        "Chuck Lever" <chuck.lever@oracle.com>,
        Krzysztof =?UTF-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: (SPDM) Device attestation, secure channels from host to device
 etc: Discuss at Plumbers?
Message-ID: <20220617112124.00002296@Huawei.com>
In-Reply-To: <YqICCSd/6Vxidu+v@iweiny-desk3>
References: <20220609124702.000037b0@Huawei.com>
        <YqICCSd/6Vxidu+v@iweiny-desk3>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.81.209.131]
X-ClientProxiedBy: lhreml709-chm.china.huawei.com (10.201.108.58) To
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

On Thu, 9 Jun 2022 07:22:01 -0700
Ira Weiny <ira.weiny@intel.com> wrote:

> On Thu, Jun 09, 2022 at 12:47:02PM +0100, Jonathan Cameron wrote:
> > Hi All,
> > 
> > +CC list almost certainly misses people interested in this topic
> >     so please forward as appropriate.
> > 
> > I'll start by saying I haven't moved forward much with the
> > SPDM/CMA over Data Object Exchange proposal from the PoC that led to
> > presenting it last year as part of the PCI etc uconf last year.
> > https://lpc.events/event/11/contributions/1089/
> > https://lore.kernel.org/all/20220303135905.10420-1-Jonathan.Cameron@huawei.com/
> > I'm continuing to carry the QEMU emulation but not posted for a while
> > as we are slowly working through a backlog of CXL stuff to merge.
> > https://gitlab.com/jic23/qemu/-/commit/f989c8cf283302c70eb5b0b73625b5357c4eb44f
> > On the plus side, Ira is driving the DOE support forwards so
> > that will resolve one missing precursor.
> > 
> > We had a lot of open questions last year and many of them are
> > still at least somewhat open; perhaps now is time to revisit?
> > 
> > In the meantime there has been discussion[1]:
> > [1] https://lore.kernel.org/all/CAPcyv4jb7D5AKZsxGE5X0jon5suob5feggotdCZWrO_XNaer3A@mail.gmail.com/
> > [2] https://lore.kernel.org/all/20220511191345.GA26623@wunner.de/
> > [3] https://lore.kernel.org/all/CAPcyv4iWGb7baQSsjjLJFuT1E11X8cHYdZoGXsNd+B9GHtsxLw@mail.gmail.com/
> > 
> > Perhaps it is worth putting in a proposal for either a session in an
> > appropriate uconf at plumbers, or maybe a BoF given it is a
> > broader topic than either PCI or CXL?  
> 
> Yes, while this could work as part of the CXL uconf it is probably a more
> general topic.

Maybe steal time from PCI given CXL uconf is going to be busy!
(lets see if any of the PCI folk are reading this thread.. :)

At the moment I'm not seeing enough interest to put in a proposal for
anything 'officially scheduled', but there is a bit more time until
the deadline so let's see if we get any other interest in that time.

> 
> > 
> > We'll still need to dance around work in various standards bodies
> > that we can't talk about yet, but it feels like it's worth
> > some time hammering out a plan of attack on what we can
> > discuss.
> > 
> > Rough topics:
> > 
> > * Use models. Without those hard to define the rest!
> > * Policy.  What do we do if we can't establish a secure channel?
> > * Transports of interest.  Single solution for MCTP vs
> >   PCI/CMA or not?
> > * Session setup etc in kernel / userspace / carefully curated hybrid
> >   of the two (Dan mentioned this last one in one of the links above)
> >   There may be similarities to the discussion around TLS (much simpler
> >   though I think!)  
> 
> I think this is something which really does need some face to face (or virtual
> face) time.  FWIW another idea from Christoph is kernel bundled userspace code.
> 
> 	https://lore.kernel.org/linux-cxl/YoT4C77Yem37NUUR@infradead.org/
> 
> I'm not sure any real implementation would be workable.

Ah. I remembered to CC Christoph but not to actually link the relevant mail.

That proposal is definitely interesting.

> 
> > * Key management
> > * Potential to use github.com/dmtf/libSPDM - is it suitable for any solutions
> >   (it's handy for emulation if nothing else!)
> > * Measurement and what to do with it.
> > * No public hardware yet, so what else should we emulate to enable
> >   work in this area. (SPDM over MCTP over I2C is on my list as easy
> >   to do in QEMU building on
> >   https://lore.kernel.org/all/20220520170128.4436-1-Jonathan.Cameron@huawei.com/ 
> > * Many other things I've forgotten about - please add!
> > 
> > So are people who care going to be at plumbers (in person or virtually)
> > and if so, do we want to put forward a session proposal?  
> 
> I have submitted a non-CXL topic in the arch uconf and was hoping to go in
> person but I'm unsure of travel budgets.  I will likely be virtual if I can't
> attend in person.

Cool. See you there in some fashion.  

Jonathan

> 
> Ira

