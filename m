Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71EC4679612
	for <lists+linux-pci@lfdr.de>; Tue, 24 Jan 2023 12:03:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231538AbjAXLDv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 24 Jan 2023 06:03:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233512AbjAXLDZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 24 Jan 2023 06:03:25 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE34C17CF7;
        Tue, 24 Jan 2023 03:03:10 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4P1P9N5zzZz6J7br;
        Tue, 24 Jan 2023 18:59:04 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 24 Jan
 2023 11:03:08 +0000
Date:   Tue, 24 Jan 2023 11:03:08 +0000
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
Subject: Re: [PATCH v2 05/10] PCI/DOE: Make asynchronous API private
Message-ID: <20230124110308.0000052e@Huawei.com>
In-Reply-To: <ec7155b88895ab6a644c0ba33aaa10012d0e4fd7.1674468099.git.lukas@wunner.de>
References: <cover.1674468099.git.lukas@wunner.de>
        <ec7155b88895ab6a644c0ba33aaa10012d0e4fd7.1674468099.git.lukas@wunner.de>
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

On Mon, 23 Jan 2023 11:15:00 +0100
Lukas Wunner <lukas@wunner.de> wrote:

> A synchronous API for DOE has just been introduced.  CXL (the only
> in-tree DOE user so far) was converted to use it instead of the
> asynchronous API.
> 
> Consequently, pci_doe_submit_task() as well as the pci_doe_task struct
> are only used internally, so make them private.
> 
> Tested-by: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> Cc: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  Changes v1 -> v2:
>  * Deduplicate note in kernel-doc of struct pci_doe_task that caller need
>    not initialize certain fields (Jonathan)
> 
>  drivers/pci/doe.c       | 45 +++++++++++++++++++++++++++++++++++++++--
>  include/linux/pci-doe.h | 44 ----------------------------------------
>  2 files changed, 43 insertions(+), 46 deletions(-)
> 
> diff --git a/drivers/pci/doe.c b/drivers/pci/doe.c
> index dce6af2ab574..066400531d09 100644
> --- a/drivers/pci/doe.c
> +++ b/drivers/pci/doe.c
> @@ -56,6 +56,47 @@ struct pci_doe_mb {
>  	unsigned long flags;
>  };
>  
> +struct pci_doe_protocol {
> +	u16 vid;
> +	u8 type;
> +};
> +
> +/**
> + * struct pci_doe_task - represents a single query/response
> + *
> + * @prot: DOE Protocol
> + * @request_pl: The request payload
> + * @request_pl_sz: Size of the request payload (bytes)
> + * @response_pl: The response payload
> + * @response_pl_sz: Size of the response payload (bytes)
> + * @rv: Return value.  Length of received response or error (bytes)
> + * @complete: Called when task is complete
> + * @private: Private data for the consumer
> + * @work: Used internally by the mailbox
> + * @doe_mb: Used internally by the mailbox
> + *
> + * The payload sizes and rv are specified in bytes with the following
> + * restrictions concerning the protocol.
> + *
> + *	1) The request_pl_sz must be a multiple of double words (4 bytes)
> + *	2) The response_pl_sz must be >= a single double word (4 bytes)
> + *	3) rv is returned as bytes but it will be a multiple of double words
> + */
> +struct pci_doe_task {
> +	struct pci_doe_protocol prot;
> +	const u32 *request_pl;
> +	size_t request_pl_sz;
> +	u32 *response_pl;
> +	size_t response_pl_sz;
> +	int rv;
> +	void (*complete)(struct pci_doe_task *task);
> +	void *private;
> +
> +	/* initialized by pci_doe_submit_task() */
> +	struct work_struct work;
> +	struct pci_doe_mb *doe_mb;
> +};
> +
>  static int pci_doe_wait(struct pci_doe_mb *doe_mb, unsigned long timeout)
>  {
>  	if (wait_event_timeout(doe_mb->wq,
> @@ -516,7 +557,8 @@ EXPORT_SYMBOL_GPL(pci_doe_supports_prot);
>   *
>   * RETURNS: 0 when task has been successfully queued, -ERRNO on error
>   */
> -int pci_doe_submit_task(struct pci_doe_mb *doe_mb, struct pci_doe_task *task)
> +static int pci_doe_submit_task(struct pci_doe_mb *doe_mb,
> +			       struct pci_doe_task *task)
>  {
>  	if (!pci_doe_supports_prot(doe_mb, task->prot.vid, task->prot.type))
>  		return -EINVAL;
> @@ -537,7 +579,6 @@ int pci_doe_submit_task(struct pci_doe_mb *doe_mb, struct pci_doe_task *task)
>  	queue_work(doe_mb->work_queue, &task->work);
>  	return 0;
>  }
> -EXPORT_SYMBOL_GPL(pci_doe_submit_task);
>  
>  /**
>   * pci_doe() - Perform Data Object Exchange
> diff --git a/include/linux/pci-doe.h b/include/linux/pci-doe.h
> index 1608e1536284..7f16749c6aa3 100644
> --- a/include/linux/pci-doe.h
> +++ b/include/linux/pci-doe.h
> @@ -13,51 +13,8 @@
>  #ifndef LINUX_PCI_DOE_H
>  #define LINUX_PCI_DOE_H
>  
> -struct pci_doe_protocol {
> -	u16 vid;
> -	u8 type;
> -};
> -
>  struct pci_doe_mb;
>  
> -/**
> - * struct pci_doe_task - represents a single query/response
> - *
> - * @prot: DOE Protocol
> - * @request_pl: The request payload
> - * @request_pl_sz: Size of the request payload (bytes)
> - * @response_pl: The response payload
> - * @response_pl_sz: Size of the response payload (bytes)
> - * @rv: Return value.  Length of received response or error (bytes)
> - * @complete: Called when task is complete
> - * @private: Private data for the consumer
> - * @work: Used internally by the mailbox
> - * @doe_mb: Used internally by the mailbox
> - *
> - * The payload sizes and rv are specified in bytes with the following
> - * restrictions concerning the protocol.
> - *
> - *	1) The request_pl_sz must be a multiple of double words (4 bytes)
> - *	2) The response_pl_sz must be >= a single double word (4 bytes)
> - *	3) rv is returned as bytes but it will be a multiple of double words
> - *
> - * NOTE there is no need for the caller to initialize work or doe_mb.
> - */
> -struct pci_doe_task {
> -	struct pci_doe_protocol prot;
> -	const u32 *request_pl;
> -	size_t request_pl_sz;
> -	u32 *response_pl;
> -	size_t response_pl_sz;
> -	int rv;
> -	void (*complete)(struct pci_doe_task *task);
> -	void *private;
> -
> -	/* No need for the user to initialize these fields */
> -	struct work_struct work;
> -	struct pci_doe_mb *doe_mb;
> -};
> -
>  /**
>   * pci_doe_for_each_off - Iterate each DOE capability
>   * @pdev: struct pci_dev to iterate
> @@ -72,7 +29,6 @@ struct pci_doe_task {
>  
>  struct pci_doe_mb *pcim_doe_create_mb(struct pci_dev *pdev, u16 cap_offset);
>  bool pci_doe_supports_prot(struct pci_doe_mb *doe_mb, u16 vid, u8 type);
> -int pci_doe_submit_task(struct pci_doe_mb *doe_mb, struct pci_doe_task *task);
>  
>  int pci_doe(struct pci_doe_mb *doe_mb, u16 vendor, u8 type,
>  	    const void *request, size_t request_sz,

