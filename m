Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CD09696287
	for <lists+linux-pci@lfdr.de>; Tue, 14 Feb 2023 12:36:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231447AbjBNLgT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Feb 2023 06:36:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbjBNLgS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 14 Feb 2023 06:36:18 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4EA021280;
        Tue, 14 Feb 2023 03:36:17 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4PGJyg4xcVz6J9gG;
        Tue, 14 Feb 2023 19:34:35 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.17; Tue, 14 Feb
 2023 11:36:15 +0000
Date:   Tue, 14 Feb 2023 11:36:14 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Lukas Wunner <lukas@wunner.de>
CC:     Bjorn Helgaas <helgaas@kernel.org>, <linux-pci@vger.kernel.org>,
        "Gregory Price" <gregory.price@memverge.com>,
        Ira Weiny <ira.weiny@intel.com>,
        "Dan Williams" <dan.j.williams@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        "Li, Ming" <ming4.li@intel.com>, "Hillf Danton" <hdanton@sina.com>,
        Ben Widawsky <bwidawsk@kernel.org>, <linuxarm@huawei.com>,
        <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v3 10/16] PCI/DOE: Deduplicate mailbox flushing
Message-ID: <20230214113614.00006ec9@Huawei.com>
In-Reply-To: <7b5cf1e007ba1638ff2512f221e8a7fd72ed8245.1676043318.git.lukas@wunner.de>
References: <cover.1676043318.git.lukas@wunner.de>
        <7b5cf1e007ba1638ff2512f221e8a7fd72ed8245.1676043318.git.lukas@wunner.de>
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
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, 10 Feb 2023 21:25:10 +0100
Lukas Wunner <lukas@wunner.de> wrote:

> When a DOE mailbox is torn down, its workqueue is flushed once in
> pci_doe_flush_mb() through a call to flush_workqueue() and subsequently
> flushed once more in pci_doe_destroy_workqueue() through a call to
> destroy_workqueue().
> 
> Deduplicate by dropping flush_workqueue() from pci_doe_flush_mb().
> 
> Rename pci_doe_flush_mb() to pci_doe_cancel_tasks() to more aptly
> describe what it now does.
> 
> Tested-by: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
LGTM

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  Changes v2 -> v3:
>  * Newly added patch in v3
> 
>  drivers/pci/doe.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/pci/doe.c b/drivers/pci/doe.c
> index afb53bc1b4aa..291cd7a46a39 100644
> --- a/drivers/pci/doe.c
> +++ b/drivers/pci/doe.c
> @@ -429,7 +429,7 @@ static void pci_doe_destroy_workqueue(void *mb)
>  	destroy_workqueue(doe_mb->work_queue);
>  }
>  
> -static void pci_doe_flush_mb(void *mb)
> +static void pci_doe_cancel_tasks(void *mb)
>  {
>  	struct pci_doe_mb *doe_mb = mb;
>  
> @@ -439,9 +439,6 @@ static void pci_doe_flush_mb(void *mb)
>  	/* Cancel an in progress work item, if necessary */
>  	set_bit(PCI_DOE_FLAG_CANCEL, &doe_mb->flags);
>  	wake_up(&doe_mb->wq);
> -
> -	/* Flush all work items */
> -	flush_workqueue(doe_mb->work_queue);
>  }
>  
>  /**
> @@ -498,9 +495,9 @@ struct pci_doe_mb *pcim_doe_create_mb(struct pci_dev *pdev, u16 cap_offset)
>  
>  	/*
>  	 * The state machine and the mailbox should be in sync now;
> -	 * Set up mailbox flush prior to using the mailbox to query protocols.
> +	 * Set up cancel tasks prior to using the mailbox to query protocols.
>  	 */
> -	rc = devm_add_action_or_reset(dev, pci_doe_flush_mb, doe_mb);
> +	rc = devm_add_action_or_reset(dev, pci_doe_cancel_tasks, doe_mb);
>  	if (rc)
>  		return ERR_PTR(rc);
>  

