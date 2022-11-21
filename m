Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C28D8631FF6
	for <lists+linux-pci@lfdr.de>; Mon, 21 Nov 2022 12:12:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229984AbiKULMQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Nov 2022 06:12:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230340AbiKULLh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 21 Nov 2022 06:11:37 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FF402250E;
        Mon, 21 Nov 2022 03:07:45 -0800 (PST)
Received: from frapeml500003.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4NG4KS3Rplz6H7TF;
        Mon, 21 Nov 2022 19:04:44 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 frapeml500003.china.huawei.com (7.182.85.28) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 21 Nov 2022 12:07:16 +0100
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Mon, 21 Nov
 2022 11:07:15 +0000
Date:   Mon, 21 Nov 2022 11:07:14 +0000
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
Message-ID: <20221121110714.0000720a@Huawei.com>
In-Reply-To: <IA1PR11MB6171B27750AB469AFE47CD5E890A9@IA1PR11MB6171.namprd11.prod.outlook.com>
References: <20221119222527.1799836-1-ira.weiny@intel.com>
        <IA1PR11MB6171B27750AB469AFE47CD5E890A9@IA1PR11MB6171.namprd11.prod.outlook.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100002.china.huawei.com (7.191.160.241) To
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

On Mon, 21 Nov 2022 02:01:32 +0000
"Zhuo, Qiuxu" <qiuxu.zhuo@intel.com> wrote:

> > From: Ira Weiny <ira.weiny@intel.com>  
> ＞　...
> > 
> > @@ -423,25 +399,13 @@ struct pci_doe_mb
> > *pcim_doe_create_mb(struct pci_dev *pdev, u16 cap_offset)
> >  	doe_mb->pdev = pdev;
> >  	doe_mb->cap_offset = cap_offset;
> >  	init_waitqueue_head(&doe_mb->wq);
> > +	mutex_init(&doe_mb->exec_lock);  
> 
> In real world, not sure whether there is a case that pcim_doe_create_mb() is invoked by 
> multiple drivers to create multiple DOE mailbox instances? If there is such a case, we may 
> need to ensure there is only one DOE mailbox instance for a physical DOE of pdev @cap_offset.

I think if that happened we'd have a lot of mess.  The main PCI driver for a given
EP, switch port etc needs to handle this part.

Sub drivers can then do similar to
https://elixir.bootlin.com/linux/latest/source/drivers/cxl/core/pci.c#L465
to find a DOE instance that supports what they need and use it.
The DOE code 'should' work fine when doing this - the request/response pairs
will be serialized.

We have discussed moving that 'find' logic and the xarray into the PCI core
and that will need to happen to support CMA etc. For the first submission it
was easier to just do it in the CXL drivers..

Jonathan

> 
> -Qiuxu

