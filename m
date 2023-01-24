Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 904A86795ED
	for <lists+linux-pci@lfdr.de>; Tue, 24 Jan 2023 12:02:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232276AbjAXLBn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 24 Jan 2023 06:01:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233072AbjAXLBe (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 24 Jan 2023 06:01:34 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E4026A6A;
        Tue, 24 Jan 2023 03:01:31 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4P1P8N6Jjhz6J6DN;
        Tue, 24 Jan 2023 18:58:12 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 24 Jan
 2023 11:01:28 +0000
Date:   Tue, 24 Jan 2023 11:01:27 +0000
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
Subject: Re: [PATCH v2 04/10] cxl/pci: Use synchronous API for DOE
Message-ID: <20230124110127.00001de0@Huawei.com>
In-Reply-To: <b5469cbb8a3e138a1c709ed3eaab02d7ca8e84b2.1674468099.git.lukas@wunner.de>
References: <cover.1674468099.git.lukas@wunner.de>
        <b5469cbb8a3e138a1c709ed3eaab02d7ca8e84b2.1674468099.git.lukas@wunner.de>
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

On Mon, 23 Jan 2023 11:14:00 +0100
Lukas Wunner <lukas@wunner.de> wrote:

> A synchronous API for DOE has just been introduced.  Convert CXL CDAT
> retrieval over to it.
> 
> Tested-by: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Jonathan Cameron <Jonathan.Cameron@Huawei.com>

The clean up here gives opportunities for 'right sizing' at least
the response to reading the header. The others are harder was we
don't know what each one is going to be.

May make more sense as a follow on patch though. 

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>


> ---
>  drivers/cxl/core/pci.c | 62 ++++++++++++++----------------------------
>  1 file changed, 20 insertions(+), 42 deletions(-)
> 
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index 57764e9cd19d..a02a2b005e6a 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -487,51 +487,26 @@ static struct pci_doe_mb *find_cdat_doe(struct device *uport)
>  		    CXL_DOE_TABLE_ACCESS_TABLE_TYPE_CDATA) |		\
>  	 FIELD_PREP(CXL_DOE_TABLE_ACCESS_ENTRY_HANDLE, (entry_handle)))
>  
> -static void cxl_doe_task_complete(struct pci_doe_task *task)
> -{
> -	complete(task->private);
> -}
> -
> -struct cdat_doe_task {
> -	u32 request_pl;
> -	u32 response_pl[32];
> -	struct completion c;
> -	struct pci_doe_task task;
> -};
> -
> -#define DECLARE_CDAT_DOE_TASK(req, cdt)                       \
> -struct cdat_doe_task cdt = {                                  \
> -	.c = COMPLETION_INITIALIZER_ONSTACK(cdt.c),           \
> -	.request_pl = req,				      \
> -	.task = {                                             \
> -		.prot.vid = PCI_DVSEC_VENDOR_ID_CXL,        \
> -		.prot.type = CXL_DOE_PROTOCOL_TABLE_ACCESS, \
> -		.request_pl = &cdt.request_pl,                \
> -		.request_pl_sz = sizeof(cdt.request_pl),      \
> -		.response_pl = cdt.response_pl,               \
> -		.response_pl_sz = sizeof(cdt.response_pl),    \
> -		.complete = cxl_doe_task_complete,            \
> -		.private = &cdt.c,                            \
> -	}                                                     \
> -}
> -
>  static int cxl_cdat_get_length(struct device *dev,
>  			       struct pci_doe_mb *cdat_doe,
>  			       size_t *length)
>  {
> -	DECLARE_CDAT_DOE_TASK(CDAT_DOE_REQ(0), t);
> +	u32 request = CDAT_DOE_REQ(0);
> +	u32 response[32];

As we aren't now using a single structure for multiple purposes
we should take the opportunity to cleanup the magic sizes (32 dword
is just intended to be 'big enough' for anything we expect to read.
Perhaps even declare a structure for the header case.

struct cdat_header_resp {
	u8 resp_code;
	u8 table_type; /* 0 - CDAT */
	u16 entry_handle; /* 0 - Header */
	u32 cdat_length;
	u8 rev;
	u8 checksum;
	u8 resvd[6];
	u32 sequence;
};

A lot less than 32 dword.



>  	int rc;
>  
> -	rc = pci_doe_submit_task(cdat_doe, &t.task);
> +	rc = pci_doe(cdat_doe, PCI_DVSEC_VENDOR_ID_CXL,
> +		     CXL_DOE_PROTOCOL_TABLE_ACCESS,
> +		     &request, sizeof(request),
> +		     &response, sizeof(response));
>  	if (rc < 0) {
> -		dev_err(dev, "DOE submit failed: %d", rc);
> +		dev_err(dev, "DOE failed: %d", rc);
>  		return rc;
>  	}
> -	wait_for_completion(&t.c);
> -	if (t.task.rv < sizeof(u32))
> +	if (rc < sizeof(u32))
>  		return -EIO;
>  
> -	*length = t.response_pl[1];
> +	*length = response[1];
>  	dev_dbg(dev, "CDAT length %zu\n", *length);
>  
>  	return 0;
> @@ -546,26 +521,29 @@ static int cxl_cdat_read_table(struct device *dev,
>  	int entry_handle = 0;
>  
>  	do {
> -		DECLARE_CDAT_DOE_TASK(CDAT_DOE_REQ(entry_handle), t);
> +		u32 request = CDAT_DOE_REQ(entry_handle);
> +		u32 response[32];
As above, this is still a bit random.
Things we might be reading.
DSMAS: 6 dword
DSLBIS: 6 dword
DSIS: 2 dword
DSEMTS: 6 dword
SSLBIS: 4 dword + 2 * entires dwords.  This can get huge - as
can include p2p as well as the smaller usp / dsp set.

Right now we aren't reading from switches though so we can fix
that later (I posted an RFC for switches ages ago, but haven't
gotten back to it since then)

So for now probably leave this one at the 32 dwords.



>  		size_t entry_dw;
>  		u32 *entry;
>  		int rc;
>  
> -		rc = pci_doe_submit_task(cdat_doe, &t.task);
> +		rc = pci_doe(cdat_doe, PCI_DVSEC_VENDOR_ID_CXL,
> +			     CXL_DOE_PROTOCOL_TABLE_ACCESS,
> +			     &request, sizeof(request),
> +			     &response, sizeof(response));
>  		if (rc < 0) {
> -			dev_err(dev, "DOE submit failed: %d", rc);
> +			dev_err(dev, "DOE failed: %d", rc);
>  			return rc;
>  		}
> -		wait_for_completion(&t.c);
>  		/* 1 DW header + 1 DW data min */
> -		if (t.task.rv < (2 * sizeof(u32)))
> +		if (rc < (2 * sizeof(u32)))
>  			return -EIO;
>  
>  		/* Get the CXL table access header entry handle */
>  		entry_handle = FIELD_GET(CXL_DOE_TABLE_ACCESS_ENTRY_HANDLE,
> -					 t.response_pl[0]);
> -		entry = t.response_pl + 1;
> -		entry_dw = t.task.rv / sizeof(u32);
> +					 response[0]);
> +		entry = response + 1;
> +		entry_dw = rc / sizeof(u32);
>  		/* Skip Header */
>  		entry_dw -= 1;
>  		entry_dw = min(length / sizeof(u32), entry_dw);

