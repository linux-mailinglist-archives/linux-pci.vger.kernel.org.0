Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E291622E8BD
	for <lists+linux-pci@lfdr.de>; Mon, 27 Jul 2020 11:21:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726846AbgG0JVt convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Mon, 27 Jul 2020 05:21:49 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2526 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726263AbgG0JVt (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 27 Jul 2020 05:21:49 -0400
Received: from lhreml710-chm.china.huawei.com (unknown [172.18.7.106])
        by Forcepoint Email with ESMTP id E39C5FA1E84846A6F6C9;
        Mon, 27 Jul 2020 10:21:47 +0100 (IST)
Received: from localhost (10.52.121.176) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1913.5; Mon, 27 Jul
 2020 10:21:47 +0100
Date:   Mon, 27 Jul 2020 10:20:24 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Logan Gunthorpe <logang@deltatee.com>
CC:     Bjorn Helgaas <helgaas@kernel.org>,
        Alex Deucher <alexdeucher@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Huang Rui <ray.huang@amd.com>,
        Andrew Maier <andrew.maier@eideticom.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Eric Wehage <Eric.Wehage@futurewei.com>,
        "Alex Umansky" <alex.umansky@huawei.com>
Subject: Re: [PATCH] PCI/P2PDMA: Add AMD Zen 2 root complex to the list of
 allowed bridges
Message-ID: <20200727102024.00005f8b@Huawei.com>
In-Reply-To: <59b68da4-cd3c-bf65-6654-02d4feaede27@deltatee.com>
References: <20200724150641.GA1518875@bjorn-Precision-5520>
        <59b68da4-cd3c-bf65-6654-02d4feaede27@deltatee.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.52.121.176]
X-ClientProxiedBy: lhreml704-chm.china.huawei.com (10.201.108.53) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, 24 Jul 2020 09:56:39 -0600
Logan Gunthorpe <logang@deltatee.com> wrote:

> [+cc Jonathan]
> 
> On 2020-07-24 9:06 a.m., Bjorn Helgaas wrote:
> > On Thu, Jul 23, 2020 at 02:10:52PM -0600, Logan Gunthorpe wrote:  
> >> On 2020-07-23 1:57 p.m., Bjorn Helgaas wrote:  
> >>> On Thu, Jul 23, 2020 at 02:01:17PM -0400, Alex Deucher wrote:  
> >>>> On Thu, Jul 23, 2020 at 1:43 PM Logan Gunthorpe <logang@deltatee.com> wrote:  
> >>>>>
> >>>>> The AMD Zen 2 root complex (Starship/Matisse) was tested for P2PDMA
> >>>>> transactions between root ports and found to work. Therefore add it
> >>>>> to the list.
> >>>>>
> >>>>> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> >>>>> Cc: Bjorn Helgaas <bhelgaas@google.com>
> >>>>> Cc: Christian König <christian.koenig@amd.com>
> >>>>> Cc: Huang Rui <ray.huang@amd.com>
> >>>>> Cc: Alex Deucher <alexdeucher@gmail.com>  
> >>>>
> >>>> Starting with Zen, all AMD platforms support P2P for reads and writes.  
> >>>
> >>> What's the plan for getting out of the cycle of "update this list for
> >>> every new chip"?  Any new _DSMs planned, for instance?  
> >>
> >> Well there was an effort to add capabilities in the PCI spec to describe
> >> this but, as far as I know, they never got anywhere, and hardware still
> >> doesn't self describe with this.  
> > 
> > Any idea what happened?  Is there hope for the future?  I'm really not
> > happy about signing up for open-ended device-specific patches like
> > this.  It's certainly not in the plug and play spirit that has made
> > PCI successful.  I know, preaching to the choir here.  
> 
> Agreed, though I'm not really hooked into the PCI SIG. The last email I
> got about this was an RFC from Jonathan Cameron in late 2018. I've CC'd
> him here, maybe he'll have a bit more insight.

For non technical reasons, you can probably figure out, that particular
ECR stalled. Unfortunately I can't directly provide info on any newer
discussions. Eric, could you perhaps find out if there is anything we can share?

This is the same question of trying to find a way to avoid white listing
root complexes that can do peer 2 peer that would have been covered by
your Advanced Peer to Peer Capabilities ECR.

Thanks,

Jonathan





> 
> Logan


