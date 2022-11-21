Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D595F632B3C
	for <lists+linux-pci@lfdr.de>; Mon, 21 Nov 2022 18:42:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229946AbiKURl6 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Mon, 21 Nov 2022 12:41:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbiKURlx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 21 Nov 2022 12:41:53 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1088BC696D;
        Mon, 21 Nov 2022 09:41:52 -0800 (PST)
Received: from fraeml743-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4NGF4b0yPPz67PMv;
        Tue, 22 Nov 2022 01:39:11 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 fraeml743-chm.china.huawei.com (10.206.15.224) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 21 Nov 2022 18:41:49 +0100
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Mon, 21 Nov
 2022 17:41:48 +0000
Date:   Mon, 21 Nov 2022 17:41:48 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
CC:     "Weiny, Ira" <ira.weiny@intel.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Gregory Price" <gregory.price@memverge.com>,
        "Li, Ming4" <ming4.li@intel.com>,
        "Verma, Vishal L" <vishal.l.verma@intel.com>,
        Lukas Wunner <lukas@wunner.de>,
        "Schofield, Alison" <alison.schofield@intel.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH] PCI/DOE: Remove asynchronous task support
Message-ID: <20221121174148.0000647d@Huawei.com>
In-Reply-To: <IA1PR11MB6171444A263C4ABB216FF1F5890A9@IA1PR11MB6171.namprd11.prod.outlook.com>
References: <20221119222527.1799836-1-ira.weiny@intel.com>
        <IA1PR11MB6171B27750AB469AFE47CD5E890A9@IA1PR11MB6171.namprd11.prod.outlook.com>
        <20221121110714.0000720a@Huawei.com>
        <IA1PR11MB6171444A263C4ABB216FF1F5890A9@IA1PR11MB6171.namprd11.prod.outlook.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100005.china.huawei.com (7.191.160.25) To
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

On Mon, 21 Nov 2022 14:17:37 +0000
"Zhuo, Qiuxu" <qiuxu.zhuo@intel.com> wrote:

> > From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
> > ...
> > On Mon, 21 Nov 2022 02:01:32 +0000
> > "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com> wrote:
> >   
> > > > From: Ira Weiny <ira.weiny@intel.com>  
> > > ＞　...  
> > > >
> > > > @@ -423,25 +399,13 @@ struct pci_doe_mb  
> > *pcim_doe_create_mb(struct  
> > > > pci_dev *pdev, u16 cap_offset)
> > > >  	doe_mb->pdev = pdev;
> > > >  	doe_mb->cap_offset = cap_offset;
> > > >  	init_waitqueue_head(&doe_mb->wq);
> > > > +	mutex_init(&doe_mb->exec_lock);  
> > >
> > > In real world, not sure whether there is a case that
> > > pcim_doe_create_mb() is invoked by multiple drivers to create multiple
> > > DOE mailbox instances? If there is such a case, we may need to ensure  
> > there is only one DOE mailbox instance for a physical DOE of pdev
> > @cap_offset.
> > 
> > I think if that happened we'd have a lot of mess.  The main PCI driver for a
> > given EP, switch port etc needs to handle this part.
> > 
> > Sub drivers can then do similar to
> > https://elixir.bootlin.com/linux/latest/source/drivers/cxl/core/pci.c#L465
> > to find a DOE instance that supports what they need and use it.
> > The DOE code 'should' work fine when doing this - the request/response
> > pairs will be serialized.
> > 
> > We have discussed moving that 'find' logic and the xarray into the PCI core
> > and that will need to happen to support CMA etc. For the first submission it
> > was easier to just do it in the CXL drivers..  
> 
> For the 1st submission, yes, it's easier in current way.
> 
> > 
> > Jonathan  
> 
> It's good that this potential issue has been noticed. I think moving the 'find' logic and the xarray 
> from CXL to the PCI core should save a lot of such duplicated works for other drivers using DOE.
> 
> One more though:
> For a driver, I think it's only interested in getting a DOE mailbox from a PCI device with specified VID+protocol and using it.
> The driver doesn't care how is the DOE mailbox instance created and the driver also doesn't want to maintain it.
> After using the DOE mailbox instance then the driver puts it back. 
> A pair of get-put APIs implemented in the PCI core like below might make drivers' lives easy 😊
> 
>          struct pci_doe_mb *mb = pci_doe_get(struct pci_dev *pdev, u16 vid, u8 protocol); 
>          // if (!mb) return;
>          // The driver uses the 'mb' to send requests and receive responses ...
>         pci_doe_put(mb);
> 
> The creation and all the heavy maintenance works on the 'mb' are hidden in the get-put APIs.

It will want to look like something along those lines - I'm not 100% sure we'll ever care
about the put, but we may do if there are resource to refcount - or we need to maintain
per DOE access controls (maybe only one user of a given protocol at a time for example).
Whether to have a driver call an init, or do it on first access as you suggest is an
open question - for example we may want to expose debug info on support protocols even
though none are currently in use.  There is also a dance around interrupts (once those
are supported for DOEs in general).  Until the PCI driver has requested interrupts
we can't use them for DOE, but we may want to poll it before that stage then switch
over.

There are added complexities in that the outcome of the SPDM discussion at plumbers was
that we probably want to run some DOE stuff before probing a driver at all - to allow
userspace to block driver probe if the attestation fails.  Not yet sure exactly what
that will look like yet.

Jonathan


> 
> -Qiuxu
> 
> 
> 
> 
> 
> 
> 

