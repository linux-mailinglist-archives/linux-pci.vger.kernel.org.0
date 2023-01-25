Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74BEF67AEBB
	for <lists+linux-pci@lfdr.de>; Wed, 25 Jan 2023 10:48:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235174AbjAYJse (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 25 Jan 2023 04:48:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234138AbjAYJsd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 25 Jan 2023 04:48:33 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4B7E196B3;
        Wed, 25 Jan 2023 01:47:59 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4P1zWN5b9Dz683hj;
        Wed, 25 Jan 2023 17:46:40 +0800 (CST)
Received: from localhost (10.81.208.142) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 25 Jan
 2023 09:47:23 +0000
Date:   Wed, 25 Jan 2023 09:47:21 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     Lukas Wunner <lukas@wunner.de>, <linux-pci@vger.kernel.org>,
        Gregory Price <gregory.price@memverge.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        "Li, Ming" <ming4.li@intel.com>, Hillf Danton <hdanton@sina.com>,
        "Ben Widawsky" <bwidawsk@kernel.org>, <linuxarm@huawei.com>,
        <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v2 10/10] PCI/DOE: Relax restrictions on request and
 response size
Message-ID: <20230125094721.000061c1@Huawei.com>
In-Reply-To: <20230124235155.GA1114594@bhelgaas>
References: <20230124124315.00000a5c@Huawei.com>
        <20230124235155.GA1114594@bhelgaas>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.81.208.142]
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
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

On Tue, 24 Jan 2023 17:51:55 -0600
Bjorn Helgaas <helgaas@kernel.org> wrote:

> On Tue, Jan 24, 2023 at 12:43:15PM +0000, Jonathan Cameron wrote:
> > On Mon, 23 Jan 2023 11:20:00 +0100
> > Lukas Wunner <lukas@wunner.de> wrote:
> >   
> > > An upcoming user of DOE is CMA (Component Measurement and Authentication,
> > > PCIe r6.0 sec 6.31).
> > > 
> > > It builds on SPDM (Security Protocol and Data Model):
> > > https://www.dmtf.org/dsp/DSP0274
> > > 
> > > SPDM message sizes are not always a multiple of dwords.  To transport
> > > them over DOE without using bounce buffers, allow sending requests and
> > > receiving responses whose final dword is only partially populated.
> > > 
> > > Tested-by: Ira Weiny <ira.weiny@intel.com>
> > > Signed-off-by: Lukas Wunner <lukas@wunner.de>
> > > Cc: Jonathan Cameron <Jonathan.Cameron@Huawei.com>  
> > Ah. This...
> > 
> > I can't immediately find the original discussion thread, but I'm fairly
> > sure we had a version of the DOE code that did this (maybe we just
> > discussed doing it and never had code...)
> > 
> > IIRC, at the time feedback was strongly in favour of making
> > the handling of non dword payloads a problem for the caller (e.g. PCI/CMA)
> > not the DOE core, mainly so that we could keep the layering simple.
> > DOE part of PCI spec says DWORD multiples only, CMA has non dword
> > entries.  
> 
> I can't remember, but I might have been the voice in favor of making
> it the caller's problem.  Your argument about dealing with it here
> makes a lot of sense, and I'm OK with it, but I *would* like to add
> some text to the commit log and comments in the code about what is
> happening here.  Otherwise there's an unexplained disconnect between
> the DWORD spec language and the byte-oriented code.

Absolutely agree. Calling out why we have a mismatch with the specification
will avoid a bunch of head scratching in the future!

> 
> > Personally I'm fully in favour of making our lives easier and handling
> > this at the DOE layer!  The CMA padding code is nasty as we have to deal
> > with caching just the right bits of the payload for the running hashes.
> > With it at this layer I'd imagine that code gets much simpler
> > 
> > Assuming resolution to Ira's question on endianness is resolved.
> > Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>  

