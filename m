Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 940E0559B8C
	for <lists+linux-pci@lfdr.de>; Fri, 24 Jun 2022 16:32:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231615AbiFXOcs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 24 Jun 2022 10:32:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230073AbiFXOcr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 24 Jun 2022 10:32:47 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61692562CB;
        Fri, 24 Jun 2022 07:32:46 -0700 (PDT)
Received: from fraeml712-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4LV0242RPSz67DYv;
        Fri, 24 Jun 2022 22:32:12 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml712-chm.china.huawei.com (10.206.15.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 24 Jun 2022 16:32:44 +0200
Received: from localhost (10.81.207.131) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 24 Jun
 2022 15:32:42 +0100
Date:   Fri, 24 Jun 2022 15:32:41 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Lukas Wunner <lukas@wunner.de>
CC:     Ira Weiny <ira.weiny@intel.com>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, Christoph Hellwig <hch@infradead.org>,
        Adam Manzanares <a.manzanares@samsung.com>,
        "ben@bwidawsk.net" <ben@bwidawsk.net>, <linuxarm@huawei.com>,
        <lorenzo.pieralisi@arm.com>,
        "Box, David E" <david.e.box@intel.com>,
        "Chuck Lever" <chuck.lever@oracle.com>,
        Krzysztof Wilczy??ski <kw@linux.com>,
        "Bjorn Helgaas" <bhelgaas@google.com>,
        Joerg Roedel <joro@8bytes.org>
Subject: Re: (SPDM) Device attestation, secure channels from host to device
 etc: Discuss at Plumbers?
Message-ID: <20220624153241.000055e2@Huawei.com>
In-Reply-To: <20220624141531.GA32171@wunner.de>
References: <20220609124702.000037b0@Huawei.com>
        <YqICCSd/6Vxidu+v@iweiny-desk3>
        <20220617112124.00002296@Huawei.com>
        <20220620165217.GA18451@wunner.de>
        <20220622124638.00004456@Huawei.com>
        <20220624120830.00002eef@Huawei.com>
        <20220624141531.GA32171@wunner.de>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.81.207.131]
X-ClientProxiedBy: lhreml735-chm.china.huawei.com (10.201.108.86) To
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

On Fri, 24 Jun 2022 16:15:31 +0200
Lukas Wunner <lukas@wunner.de> wrote:

> On Fri, Jun 24, 2022 at 12:08:30PM +0100, Jonathan Cameron wrote:
> > I've put this in for now:  
> 
> Perfect!  For me as a non-native English speaker, it would have been
> a lot more difficult to write up such an excellent description,
> so thanks for doing this.

It always feels a bit like cheating when you get to write these
things in your first language!
> 
> > Hence this proposal for a BoF rather than session in 
> > either PCI or CXL uconf.  
> 
> I think this has overlap with the Confidential Computing uconf as well,
> so that might be another potentially interested audience.
> 
> (Link encryption is by its very nature "confidential computing",
> and attestation is explicitly mentioned on the CC uconf page:
> https://lpc.events/event/16/contributions/1143/ )
> 
> Thanks,
> 
> Lukas
> 

Good point. That is an area in which we need dance around what we
can an can't say (i.e. what is public from various standards orgs) but they 
may well still be interested.

Added 
- Confidential compute community
to list of people who might be interested.

+CC Joerg so he knows this proposal exists and can perhaps drag in anyone
else who might be interested.

https://lore.kernel.org/all/20220624120830.00002eef@Huawei.com/
for abstract.

Thanks,

Jonathan

