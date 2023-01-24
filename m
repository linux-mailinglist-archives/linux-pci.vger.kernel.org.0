Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 697ED679577
	for <lists+linux-pci@lfdr.de>; Tue, 24 Jan 2023 11:40:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232143AbjAXKkj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 24 Jan 2023 05:40:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229933AbjAXKki (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 24 Jan 2023 05:40:38 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DCCE2D45;
        Tue, 24 Jan 2023 02:40:37 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4P1NhH4DH1z6J6DM;
        Tue, 24 Jan 2023 18:37:19 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 24 Jan
 2023 10:40:34 +0000
Date:   Tue, 24 Jan 2023 10:40:33 +0000
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
Subject: Re: [PATCH v2 03/10] PCI/DOE: Provide synchronous API and use it
 internally
Message-ID: <20230124104033.000048ec@Huawei.com>
In-Reply-To: <b589059ddc82039f00d695d75ac4017504df6bf6.1674468099.git.lukas@wunner.de>
References: <cover.1674468099.git.lukas@wunner.de>
        <b589059ddc82039f00d695d75ac4017504df6bf6.1674468099.git.lukas@wunner.de>
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

On Mon, 23 Jan 2023 11:13:00 +0100
Lukas Wunner <lukas@wunner.de> wrote:

> The DOE API only allows asynchronous exchanges and forces callers to
> provide a completion callback.  Yet all existing callers only perform
> synchronous exchanges.  Upcoming commits for CMA (Component Measurement
> and Authentication, PCIe r6.0 sec 6.31) likewise require only
> synchronous DOE exchanges.
> 
> Provide a synchronous pci_doe() API call which builds on the internal
> asynchronous machinery.
> 
> Convert the internal pci_doe_discovery() to the new call.
> 
> The new API allows submission of const-declared requests, necessitating
> the addition of a const qualifier in struct pci_doe_task.
> 
> Tested-by: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Jonathan Cameron <Jonathan.Cameron@Huawei.com>

Pushing the struct down is fine by me, though I'll note we had it
pretty much like this in one of the earlier versions and got a
request to use a struct instead to wrap up all the parameters.

Let's see if experience convinces people this is the right
approach this time :) It is perhaps easier to argue
now the completion is moved down as well as we'd end up with
a messy case of some elements of the structure being set in the
caller and others inside where it is called (or some messy
wrapper structures).  Been a while, but I don't think we had
such a strong argument in favour of this approach back then.

The const changes makes sense independent of the rest.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>


> ---
>  drivers/pci/doe.c       | 65 +++++++++++++++++++++++++++++++----------
>  include/linux/pci-doe.h |  6 +++-
>  2 files changed, 55 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/pci/doe.c b/drivers/pci/doe.c
> index 7451b5732044..dce6af2ab574 100644
> --- a/drivers/pci/doe.c
> +++ b/drivers/pci/doe.c
> @@ -319,26 +319,15 @@ static int pci_doe_discovery(struct pci_doe_mb *doe_mb, u8 *index, u16 *vid,
>  	u32 request_pl = FIELD_PREP(PCI_DOE_DATA_OBJECT_DISC_REQ_3_INDEX,
>  				    *index);
>  	u32 response_pl;
> -	DECLARE_COMPLETION_ONSTACK(c);
> -	struct pci_doe_task task = {
> -		.prot.vid = PCI_VENDOR_ID_PCI_SIG,
> -		.prot.type = PCI_DOE_PROTOCOL_DISCOVERY,
> -		.request_pl = &request_pl,
> -		.request_pl_sz = sizeof(request_pl),
> -		.response_pl = &response_pl,
> -		.response_pl_sz = sizeof(response_pl),
> -		.complete = pci_doe_task_complete,
> -		.private = &c,
> -	};
>  	int rc;
>  
> -	rc = pci_doe_submit_task(doe_mb, &task);
> +	rc = pci_doe(doe_mb, PCI_VENDOR_ID_PCI_SIG, PCI_DOE_PROTOCOL_DISCOVERY,
> +		     &request_pl, sizeof(request_pl),
> +		     &response_pl, sizeof(response_pl));
>  	if (rc < 0)
>  		return rc;
>  
> -	wait_for_completion(&c);
> -
> -	if (task.rv != sizeof(response_pl))
> +	if (rc != sizeof(response_pl))
>  		return -EIO;
>  
>  	*vid = FIELD_GET(PCI_DOE_DATA_OBJECT_DISC_RSP_3_VID, response_pl);
> @@ -549,3 +538,49 @@ int pci_doe_submit_task(struct pci_doe_mb *doe_mb, struct pci_doe_task *task)
>  	return 0;
>  }
>  EXPORT_SYMBOL_GPL(pci_doe_submit_task);
> +
> +/**
> + * pci_doe() - Perform Data Object Exchange
> + *
> + * @doe_mb: DOE Mailbox
> + * @vendor: Vendor ID
> + * @type: Data Object Type
> + * @request: Request payload
> + * @request_sz: Size of request payload (bytes)
> + * @response: Response payload
> + * @response_sz: Size of response payload (bytes)
> + *
> + * Submit @request to @doe_mb and store the @response.
> + * The DOE exchange is performed synchronously and may therefore sleep.
> + *
> + * RETURNS: Length of received response or negative errno.
> + * Received data in excess of @response_sz is discarded.
> + * The length may be smaller than @response_sz and the caller
> + * is responsible for checking that.
> + */
> +int pci_doe(struct pci_doe_mb *doe_mb, u16 vendor, u8 type,
> +	    const void *request, size_t request_sz,
> +	    void *response, size_t response_sz)
> +{
> +	DECLARE_COMPLETION_ONSTACK(c);
> +	struct pci_doe_task task = {
> +		.prot.vid = vendor,
> +		.prot.type = type,
> +		.request_pl = request,
> +		.request_pl_sz = request_sz,
> +		.response_pl = response,
> +		.response_pl_sz = response_sz,
> +		.complete = pci_doe_task_complete,
> +		.private = &c,
> +	};
> +	int rc;
> +
> +	rc = pci_doe_submit_task(doe_mb, &task);
> +	if (rc)
> +		return rc;
> +
> +	wait_for_completion(&c);
> +
> +	return task.rv;
> +}
> +EXPORT_SYMBOL_GPL(pci_doe);
> diff --git a/include/linux/pci-doe.h b/include/linux/pci-doe.h
> index ed9b4df792b8..1608e1536284 100644
> --- a/include/linux/pci-doe.h
> +++ b/include/linux/pci-doe.h
> @@ -45,7 +45,7 @@ struct pci_doe_mb;
>   */
>  struct pci_doe_task {
>  	struct pci_doe_protocol prot;
> -	u32 *request_pl;
> +	const u32 *request_pl;
>  	size_t request_pl_sz;
>  	u32 *response_pl;
>  	size_t response_pl_sz;
> @@ -74,4 +74,8 @@ struct pci_doe_mb *pcim_doe_create_mb(struct pci_dev *pdev, u16 cap_offset);
>  bool pci_doe_supports_prot(struct pci_doe_mb *doe_mb, u16 vid, u8 type);
>  int pci_doe_submit_task(struct pci_doe_mb *doe_mb, struct pci_doe_task *task);
>  
> +int pci_doe(struct pci_doe_mb *doe_mb, u16 vendor, u8 type,
> +	    const void *request, size_t request_sz,
> +	    void *response, size_t response_sz);
> +
>  #endif

