Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD53163D98F
	for <lists+linux-pci@lfdr.de>; Wed, 30 Nov 2022 16:37:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbiK3PhO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 30 Nov 2022 10:37:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229952AbiK3PhE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 30 Nov 2022 10:37:04 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 970D76248;
        Wed, 30 Nov 2022 07:37:01 -0800 (PST)
Received: from frapeml500006.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4NMjsv6pb5z6HJZX;
        Wed, 30 Nov 2022 23:33:55 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 frapeml500006.china.huawei.com (7.182.85.219) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 30 Nov 2022 16:36:59 +0100
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 30 Nov
 2022 15:36:59 +0000
Date:   Wed, 30 Nov 2022 15:36:58 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Lukas Wunner <lukas@wunner.de>
CC:     Bjorn Helgaas <helgaas@kernel.org>, <linux-pci@vger.kernel.org>,
        "Gregory Price" <gregory.price@memverge.com>,
        Ira Weiny <ira.weiny@intel.com>,
        "Dan Williams" <dan.j.williams@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Li, Ming" <ming4.li@intel.com>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 1/2] PCI/DOE: Silence WARN splat upon task submission
Message-ID: <20221130153658.00006674@Huawei.com>
In-Reply-To: <9eb6af0763f1ec05673a7dd6731d9fd646cf1dd4.1669608950.git.lukas@wunner.de>
References: <cover.1669608950.git.lukas@wunner.de>
        <9eb6af0763f1ec05673a7dd6731d9fd646cf1dd4.1669608950.git.lukas@wunner.de>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
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

On Mon, 28 Nov 2022 05:25:51 +0100
Lukas Wunner <lukas@wunner.de> wrote:

> Gregory Price reports a WARN splat with CONFIG_DEBUG_OBJECTS=y upon CXL
> probing because pci_doe_submit_task() invokes INIT_WORK() instead of
> INIT_WORK_ONSTACK() for a work_struct that was allocated on the stack.
> 
> All callers of pci_doe_submit_task() allocate the work_struct on the
> stack, so replace INIT_WORK() with INIT_WORK_ONSTACK() as a backportable
> short-term fix.
> 
> Stacktrace for posterity:
> 
> WARNING: CPU: 0 PID: 23 at lib/debugobjects.c:545 __debug_object_init.cold+0x18/0x183
> CPU: 0 PID: 23 Comm: kworker/u2:1 Not tainted 6.1.0-0.rc1.20221019gitaae703b02f92.17.fc38.x86_64 #1
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
> Call Trace:
>  pci_doe_submit_task+0x5d/0xd0
>  pci_doe_discovery+0xb4/0x100
>  pcim_doe_create_mb+0x219/0x290
>  cxl_pci_probe+0x192/0x430
>  local_pci_probe+0x41/0x80
>  pci_device_probe+0xb3/0x220
>  really_probe+0xde/0x380
>  __driver_probe_device+0x78/0x170
>  driver_probe_device+0x1f/0x90
>  __driver_attach_async_helper+0x5c/0xe0
>  async_run_entry_fn+0x30/0x130
>  process_one_work+0x294/0x5b0
> 
> Fixes: 9d24322e887b ("PCI/DOE: Add DOE mailbox support functions")
> Link: https://lore.kernel.org/linux-cxl/Y1bOniJliOFszvIK@memverge.com/
> Reported-by: Gregory Price <gregory.price@memverge.com>
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> Cc: stable@vger.kernel.org # v6.0+
> Cc: Ira Weiny <ira.weiny@intel.com>
> Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  drivers/pci/doe.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/doe.c b/drivers/pci/doe.c
> index 66d9ab288646..52541eac17f1 100644
> --- a/drivers/pci/doe.c
> +++ b/drivers/pci/doe.c
> @@ -541,7 +541,7 @@ int pci_doe_submit_task(struct pci_doe_mb *doe_mb, struct pci_doe_task *task)
>  		return -EIO;
>  
>  	task->doe_mb = doe_mb;
> -	INIT_WORK(&task->work, doe_statemachine_work);
> +	INIT_WORK_ONSTACK(&task->work, doe_statemachine_work);

If we go this way, add a comment to say 'why' it is ONSTACK
or add to the function description to say it 'must be on stack'.

>  	queue_work(doe_mb->work_queue, &task->work);
>  	return 0;
>  }

