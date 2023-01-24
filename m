Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D61C679541
	for <lists+linux-pci@lfdr.de>; Tue, 24 Jan 2023 11:33:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230191AbjAXKdW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 24 Jan 2023 05:33:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232995AbjAXKdU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 24 Jan 2023 05:33:20 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AEAD1E5C6;
        Tue, 24 Jan 2023 02:33:18 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4P1NZr21Y7z6J9fy;
        Tue, 24 Jan 2023 18:32:36 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 24 Jan
 2023 10:33:16 +0000
Date:   Tue, 24 Jan 2023 10:33:15 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Ira Weiny <ira.weiny@intel.com>
CC:     Lukas Wunner <lukas@wunner.de>, Bjorn Helgaas <helgaas@kernel.org>,
        <linux-pci@vger.kernel.org>,
        Gregory Price <gregory.price@memverge.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        "Li, Ming" <ming4.li@intel.com>, "Hillf Danton" <hdanton@sina.com>,
        Ben Widawsky <bwidawsk@kernel.org>, <linuxarm@huawei.com>,
        <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v2 02/10] PCI/DOE: Fix memory leak with
 CONFIG_DEBUG_OBJECTS=y
Message-ID: <20230124103315.000014d2@Huawei.com>
In-Reply-To: <63cf27ea17c33_521a294ee@iweiny-mobl.notmuch>
References: <cover.1674468099.git.lukas@wunner.de>
        <4b510b0979704c587e531cd7d814c1e5361ecbea.1674468099.git.lukas@wunner.de>
        <63cf27ea17c33_521a294ee@iweiny-mobl.notmuch>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
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

On Mon, 23 Jan 2023 16:35:54 -0800
Ira Weiny <ira.weiny@intel.com> wrote:

> Lukas Wunner wrote:
> > After a pci_doe_task completes, its work_struct needs to be destroyed
> > to avoid a memory leak with CONFIG_DEBUG_OBJECTS=y.
> > 
> > Fixes: 9d24322e887b ("PCI/DOE: Add DOE mailbox support functions")
> > Tested-by: Ira Weiny <ira.weiny@intel.com>  
> 
> Reviewed-by: Ira Weiny <ira.weiny@intel.com>
Good find.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> 
> > Signed-off-by: Lukas Wunner <lukas@wunner.de>
> > Cc: stable@vger.kernel.org # v6.0+
> > Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > ---
> >  drivers/pci/doe.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/pci/doe.c b/drivers/pci/doe.c
> > index 12a6752351bf..7451b5732044 100644
> > --- a/drivers/pci/doe.c
> > +++ b/drivers/pci/doe.c
> > @@ -224,6 +224,7 @@ static void signal_task_complete(struct pci_doe_task *task, int rv)
> >  {
> >  	task->rv = rv;
> >  	task->complete(task);
> > +	destroy_work_on_stack(&task->work);
> >  }
> >  
> >  static void signal_task_abort(struct pci_doe_task *task, int rv)
> > -- 
> > 2.39.1
> >   
> 
> 

