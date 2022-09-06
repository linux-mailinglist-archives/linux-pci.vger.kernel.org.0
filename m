Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 763875AE70D
	for <lists+linux-pci@lfdr.de>; Tue,  6 Sep 2022 14:00:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233864AbiIFL77 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 6 Sep 2022 07:59:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234098AbiIFL7z (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 6 Sep 2022 07:59:55 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20F2E3DF00;
        Tue,  6 Sep 2022 04:59:54 -0700 (PDT)
Received: from fraeml707-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4MMP3V693zz6HJTR;
        Tue,  6 Sep 2022 19:55:50 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 fraeml707-chm.china.huawei.com (10.206.15.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 6 Sep 2022 13:59:52 +0200
Received: from localhost (10.202.226.42) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 6 Sep
 2022 12:59:51 +0100
Date:   Tue, 6 Sep 2022 12:59:50 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     Adam Manzanares <a.manzanares@samsung.com>
CC:     Lukas Wunner <lukas@wunner.de>, Ira Weiny <ira.weiny@intel.com>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        "ben@bwidawsk.net" <ben@bwidawsk.net>,
        "linuxarm@huawei.com" <linuxarm@huawei.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "Box, David E" <david.e.box@intel.com>,
        "Chuck Lever" <chuck.lever@oracle.com>,
        Krzysztof Wilczy??ski <kw@linux.com>,
        "Bjorn Helgaas" <bhelgaas@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Chris Browy <cbrowy@avery-design.com>,
        hchkuo <hchkuo@avery-design.com.tw>
Subject: Re: (SPDM) Device attestation, secure channels from host to device
 etc: Discuss at Plumbers?
Message-ID: <20220906125950.00006e4f@huawei.com>
In-Reply-To: <20220629160149.GA1039216@bgt-140510-bm01>
References: <20220609124702.000037b0@Huawei.com>
        <YqICCSd/6Vxidu+v@iweiny-desk3>
        <20220617112124.00002296@Huawei.com>
        <20220620165217.GA18451@wunner.de>
        <20220622124638.00004456@Huawei.com>
        <20220624120830.00002eef@Huawei.com>
        <20220624141531.GA32171@wunner.de>
        <CGME20220624143249uscas1p1ae96e45ccb5b3b4f22a5b863c7a6fc9f@uscas1p1.samsung.com>
        <20220624153241.000055e2@Huawei.com>
        <20220629160149.GA1039216@bgt-140510-bm01>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.42]
X-ClientProxiedBy: lhrpeml100002.china.huawei.com (7.191.160.241) To
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

Hi All,

The BoF has been accepted though not scheduled yet.
https://lpc.events/event/16/contributions/1304/

Updated RFC of kernel based cert handling with SPDM 1.2 support:
https://lore.kernel.org/linux-pci/20220906111556.1544-1-Jonathan.Cameron@huawei.com/
Applies cleanly to current mainline.  As it's an RFC I've been lazy
in a few places, but it should convey what an in kernel only solution might
look like.

The old QEMU emulation should work fine with this (against new
spdm-emu). https://gitlab.com/jic23/qemu/-/commits/cxl-next

I might push out a rebased CXL QEMU tree with it on later this week if
I get time and resist hacking too much on another plumbers related PoC :)

Thanks all and look forward to talking to people about this next week.

Jonathan

p.s. Chris / Huai-Cheng Kuo.  I'd completely forgotten you were interested in this
topic from emulation side of things.  Not sure if you care about what Linux does
with it however but your QEMU work is still proving very useful.


On Wed, 29 Jun 2022 16:01:57 +0000
Adam Manzanares <a.manzanares@samsung.com> wrote:

> On Fri, Jun 24, 2022 at 03:32:41PM +0100, Jonathan Cameron wrote:
> > On Fri, 24 Jun 2022 16:15:31 +0200
> > Lukas Wunner <lukas@wunner.de> wrote:
> >   
> > > On Fri, Jun 24, 2022 at 12:08:30PM +0100, Jonathan Cameron wrote:  
> > > > I've put this in for now:    
> > > 
> > > Perfect!  For me as a non-native English speaker, it would have been
> > > a lot more difficult to write up such an excellent description,
> > > so thanks for doing this.  
> > 
> > It always feels a bit like cheating when you get to write these
> > things in your first language!  
> > >   
> > > > Hence this proposal for a BoF rather than session in 
> > > > either PCI or CXL uconf.    
> > >   
> 
> I am planning to be attending plumbers in person and am quite interested in 
> this BOF.
> 


> 
> > > I think this has overlap with the Confidential Computing uconf as well,
> > > so that might be another potentially interested audience.
> > > 
> > > (Link encryption is by its very nature "confidential computing",
> > > and attestation is explicitly mentioned on the CC uconf page:
> > > https://urldefense.com/v3/__https://protect2.fireeye.com/v1/url?k=10369d39-71bd8872-10371676-74fe485fb305-1ce6f2197c6a68d6&q=1&e=6639a8eb-2d66-432f-a3d9-760b3e8def9f&u=https*3A*2F*2Flpc.events*2Fevent*2F16*2Fcontributions*2F1143*2F__;JSUlJSUlJSU!!EwVzqGoTKBqv-0DWAJBm!UGKGabNBEqfdQU-FrF-bEnhwu9mRW4PRGa1LoMvehedU3XRfsZzuoHGUZUVWHVD3p26pNa-le6OwJPQwMs7wV4kiu9GUb9ld$  )
> > > 
> > > Thanks,
> > > 
> > > Lukas
> > >   
> > 
> > Good point. That is an area in which we need dance around what we
> > can an can't say (i.e. what is public from various standards orgs) but they 
> > may well still be interested.
> > 
> > Added 
> > - Confidential compute community
> > to list of people who might be interested.
> > 
> > +CC Joerg so he knows this proposal exists and can perhaps drag in anyone
> > else who might be interested.
> > 
> > https://urldefense.com/v3/__https://lore.kernel.org/all/20220624120830.00002eef@Huawei.com/__;!!EwVzqGoTKBqv-0DWAJBm!UGKGabNBEqfdQU-FrF-bEnhwu9mRW4PRGa1LoMvehedU3XRfsZzuoHGUZUVWHVD3p26pNa-le6OwJPQwMs7wV4kiu68CJwlU$ 
> > for abstract.
> > 
> > Thanks,
> > 
> > Jonathan
> >  

