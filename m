Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F3C06C2D8E
	for <lists+linux-pci@lfdr.de>; Tue, 21 Mar 2023 10:06:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229497AbjCUJGh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 21 Mar 2023 05:06:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229846AbjCUJGc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 21 Mar 2023 05:06:32 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45A7016895;
        Tue, 21 Mar 2023 02:06:04 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Pglzd0vBNz6J6cF;
        Tue, 21 Mar 2023 17:04:45 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Tue, 21 Mar
 2023 09:05:56 +0000
Date:   Tue, 21 Mar 2023 09:05:59 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Alexey Kardashevskiy <aik@amd.com>
CC:     Lukas Wunner <lukas@wunner.de>, Bjorn Helgaas <helgaas@kernel.org>,
        "Dan Williams" <dan.j.williams@intel.com>,
        <linux-pci@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
        Gregory Price <gregory.price@memverge.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Dave Jiang" <dave.jiang@intel.com>,
        "Li, Ming" <ming4.li@intel.com>, Hillf Danton <hdanton@sina.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>, <linuxarm@huawei.com>
Subject: Re: [PATCH v4 05/17] PCI/DOE: Silence WARN splat with
 CONFIG_DEBUG_OBJECTS=y
Message-ID: <20230321090559.00002bb6@Huawei.com>
In-Reply-To: <b3d2d326-8736-09e4-0886-68c6d69aa404@amd.com>
References: <cover.1678543498.git.lukas@wunner.de>
        <67a9117f463ecdb38a2dbca6a20391ce2f1e7a06.1678543498.git.lukas@wunner.de>
        <b3d2d326-8736-09e4-0886-68c6d69aa404@amd.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500003.china.huawei.com (7.191.162.67) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 21 Mar 2023 14:42:01 +1100
Alexey Kardashevskiy <aik@amd.com> wrote:

> On 12/3/23 01:40, Lukas Wunner wrote:
> > Gregory Price reports a WARN splat with CONFIG_DEBUG_OBJECTS=y upon CXL
> > probing because pci_doe_submit_task() invokes INIT_WORK() instead of
> > INIT_WORK_ONSTACK() for a work_struct that was allocated on the stack.
> > 
> > All callers of pci_doe_submit_task() allocate the work_struct on the
> > stack, so replace INIT_WORK() with INIT_WORK_ONSTACK() as a backportable
> > short-term fix.
> > 
> > The long-term fix implemented by a subsequent commit is to move to a
> > synchronous API which allocates the work_struct internally in the DOE
> > library.
> > 
> > Stacktrace for posterity:
> > 
> > WARNING: CPU: 0 PID: 23 at lib/debugobjects.c:545 __debug_object_init.cold+0x18/0x183
> > CPU: 0 PID: 23 Comm: kworker/u2:1 Not tainted 6.1.0-0.rc1.20221019gitaae703b02f92.17.fc38.x86_64 #1
> > Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
> > Call Trace:
> >   pci_doe_submit_task+0x5d/0xd0
> >   pci_doe_discovery+0xb4/0x100
> >   pcim_doe_create_mb+0x219/0x290
> >   cxl_pci_probe+0x192/0x430
> >   local_pci_probe+0x41/0x80
> >   pci_device_probe+0xb3/0x220
> >   really_probe+0xde/0x380
> >   __driver_probe_device+0x78/0x170
> >   driver_probe_device+0x1f/0x90
> >   __driver_attach_async_helper+0x5c/0xe0
> >   async_run_entry_fn+0x30/0x130
> >   process_one_work+0x294/0x5b0
> > 
> > Fixes: 9d24322e887b ("PCI/DOE: Add DOE mailbox support functions")
> > Link: https://lore.kernel.org/linux-cxl/Y1bOniJliOFszvIK@memverge.com/
> > Reported-by: Gregory Price <gregory.price@memverge.com>
> > Tested-by: Ira Weiny <ira.weiny@intel.com>
> > Tested-by: Gregory Price <gregory.price@memverge.com>
> > Signed-off-by: Lukas Wunner <lukas@wunner.de>
> > Reviewed-by: Ira Weiny <ira.weiny@intel.com>
> > Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> > Reviewed-by: Gregory Price <gregory.price@memverge.com>
> > Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huwei.com>  
>                                                    ^^^^^
> 
> huwei? :)
Doh.  I normally type my own name wrong ;)

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Thanks,

Jonathan

> 
> 

