Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B6CA5EBF34
	for <lists+linux-pci@lfdr.de>; Tue, 27 Sep 2022 12:04:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230057AbiI0KEo convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Tue, 27 Sep 2022 06:04:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229779AbiI0KEn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 27 Sep 2022 06:04:43 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F7491005E;
        Tue, 27 Sep 2022 03:04:39 -0700 (PDT)
Received: from fraeml705-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4McFbR4yb6z6HJG9;
        Tue, 27 Sep 2022 18:04:35 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 fraeml705-chm.china.huawei.com (10.206.15.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2375.31; Tue, 27 Sep 2022 12:04:37 +0200
Received: from localhost (10.202.226.42) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 27 Sep
 2022 11:04:36 +0100
Date:   Tue, 27 Sep 2022 11:04:35 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     Shuai Xue <xueshuai@linux.alibaba.com>
CC:     Bjorn Helgaas <helgaas@kernel.org>, <will@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <rdunlap@infradead.org>,
        <robin.murphy@arm.com>, <mark.rutland@arm.com>,
        <baolin.wang@linux.alibaba.com>, <zhuo.song@linux.alibaba.com>,
        <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v1 2/3] drivers/perf: add DesignWare PCIe PMU driver
Message-ID: <20220927110435.00005b4d@huawei.com>
In-Reply-To: <7502d496-9ec1-1ca4-c643-376ec2aa662e@linux.alibaba.com>
References: <20220926171857.GA1609097@bhelgaas>
        <7502d496-9ec1-1ca4-c643-376ec2aa662e@linux.alibaba.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.202.226.42]
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
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

On Tue, 27 Sep 2022 13:13:29 +0800
Shuai Xue <xueshuai@linux.alibaba.com> wrote:

> 在 2022/9/27 AM1:18, Bjorn Helgaas 写道:
> > On Mon, Sep 26, 2022 at 09:31:34PM +0800, Shuai Xue wrote:  
> >> 在 2022/9/23 PM11:54, Jonathan Cameron 写道:  
> >>>> I found a similar definition in arch/ia64/pci/pci.c .
> >>>>
> >>>> 	#define PCI_SAL_ADDRESS(seg, bus, devfn, reg)		\
> >>>> 	(((u64) seg << 24) | (bus << 16) | (devfn << 8) | (reg))
> >>>>
> >>>> Should we move it into a common header first?  
> >>>
> >>> Maybe. The bus, devfn, reg part is standard bdf, but I don't think
> >>> the PCI 6.0 spec defined a version with the seg in the upper bits.
> >>> I'm not sure if we want to adopt that in LInux.  
> >>
> >> I found lots of code use seg,bus,devfn,reg with format "%04x:%02x:%02x.%x",
> >> I am not quite familiar with PCIe spec. What do you think about it, Bjorn?  
> > 
> > The PCIe spec defines an address encoding for bus/device/function/reg
> > for the purposes of ECAM (PCIe r6.0, sec 7.2.2), but as far as I know,
> > it doesn't define anything similar that includes the segment.  The
> > segment is really outside the scope of PCIe because each segment is a
> > completely separate PCIe hierarchy.  
> 
> Thank you for your explanation.
> 
> > 
> > So I probably wouldn't make this a generic definition.  But if/when
> > you print things like this out, please do use the format spec you
> > mentioned above so it matches the style used elsewhere.
> >   
> 
> Agree. The print format of bus/device/function/reg is "%04x:%02x:%02x.%x",
> so I named the PMU as the same format. Then the usage flow would be:
> 
> - lspci to get the device root port in format seg/bus/device/function/reg.
> 	10:00.0 PCI bridge: Device 1ded:8000 (rev 01)
> - select its PMU name pcie_bdf_100000.
> - monitor with perf:
> 	perf stat -a -e pcie_bdf_200/Rx_PCIe_TLP_Data_Payload/

I think you probably want something in there to indicate it's an RP
and the bdf part may be redundant...

Jonathan
> 
> Bjorn and Jonathan, are you happy with this flow?
> 
> Thank you.
> 
> Best Regards,
> Shuai
> 

