Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60E9563D97F
	for <lists+linux-pci@lfdr.de>; Wed, 30 Nov 2022 16:33:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229661AbiK3Pds (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 30 Nov 2022 10:33:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229749AbiK3Pdn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 30 Nov 2022 10:33:43 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48C5E27B28;
        Wed, 30 Nov 2022 07:33:34 -0800 (PST)
Received: from fraeml714-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4NMjnw0WkRz6HJZj;
        Wed, 30 Nov 2022 23:30:28 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 fraeml714-chm.china.huawei.com (10.206.15.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 30 Nov 2022 16:33:31 +0100
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 30 Nov
 2022 15:33:31 +0000
Date:   Wed, 30 Nov 2022 15:33:30 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Lukas Wunner <lukas@wunner.de>
CC:     Bjorn Helgaas <helgaas@kernel.org>, <linux-pci@vger.kernel.org>,
        "Gregory Price" <gregory.price@memverge.com>,
        Ira Weiny <ira.weiny@intel.com>,
        "Dan Williams" <dan.j.williams@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Li, Ming" <ming4.li@intel.com>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 2/2] PCI/DOE: Provide synchronous API
Message-ID: <20221130153330.000049b3@Huawei.com>
In-Reply-To: <7ced46eaf68bed71b6414a93ac41f26cfd54a991.1669608950.git.lukas@wunner.de>
References: <cover.1669608950.git.lukas@wunner.de>
        <7ced46eaf68bed71b6414a93ac41f26cfd54a991.1669608950.git.lukas@wunner.de>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500001.china.huawei.com (7.191.163.213) To
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

On Mon, 28 Nov 2022 05:25:52 +0100
Lukas Wunner <lukas@wunner.de> wrote:

> The DOE API only allows asynchronous exchanges and forces callers to
> provide a completion callback.  Yet all existing callers only perform
> synchronous exchanges.  Upcoming patches for CMA (Component Measurement
> and Authentication, PCIe r6.0.1 sec 6.31) likewise require only
> synchronous DOE exchanges.  Asynchronous users are currently not
> foreseeable.
> 
> Provide a synchronous pci_doe() API call which builds on the internal
> asynchronous machinery.  Should asynchronous users appear, reintroducing
> a pci_doe_async() API call will be trivial.
> 
> Convert all users to the new synchronous API and make the asynchronous
> pci_doe_submit_task() as well as the pci_doe_task struct private.
> 
> Signed-off-by: Lukas Wunner <lukas@wunner.de>

Hi Lukas,

Thanks for looking at this.  A few trivial comments line.

This covers the existing question around async vs sync
but doesn't have the potential advantages that Ira's series
has in terms of ripping out a bunch of complexity.

I'm too tied up in the various implementations to offer a clear
view on which way was should go on this - I'll end up spending
all day arguing with myself!

It's a bit of crystal ball gazing for how useful keeping the async stuff
around will be.  Might be a case of taking your first patch then
sitting on the current implementation for a cycle or two to see
if it get users... Or take approach Ira proposed and only put the
infrastructure back in when we have a user for async.

Jonathan

> diff --git a/drivers/pci/doe.c b/drivers/pci/doe.c
> index 52541eac17f1..7d1eb5bef4b5 100644
> --- a/drivers/pci/doe.c
> +++ b/drivers/pci/doe.c

...

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
> + *
> + * NOTE there is no need for the caller to initialize work or doe_mb.

Cut and paste from original, but what's the "caller" of a struct? I'd just
drop this NOTE as it's better explained below.

> + */
> +struct pci_doe_task {
> +	struct pci_doe_protocol prot;
> +	u32 *request_pl;
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

...

>  /**
>   * pci_doe_for_each_off - Iterate each DOE capability
>   * @pdev: struct pci_dev to iterate
> @@ -72,6 +29,8 @@ struct pci_doe_task {
>  
>  struct pci_doe_mb *pcim_doe_create_mb(struct pci_dev *pdev, u16 cap_offset);
>  bool pci_doe_supports_prot(struct pci_doe_mb *doe_mb, u16 vid, u8 type);
> -int pci_doe_submit_task(struct pci_doe_mb *doe_mb, struct pci_doe_task *task);
> +int pci_doe(struct pci_doe_mb *doe_mb, u16 vendor, u8 type,
Whilst there is clearly a verb hidden in that doe, the fact that the
whole spec section is called the same is confusing.

pci_doe_query_response() maybe or pci_doe_do() perhaps?


> +	    void *request, size_t request_sz,
> +	    void *response, size_t response_sz);
>  
>  #endif

