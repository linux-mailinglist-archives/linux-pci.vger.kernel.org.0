Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12412679843
	for <lists+linux-pci@lfdr.de>; Tue, 24 Jan 2023 13:43:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233957AbjAXMnX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 24 Jan 2023 07:43:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233959AbjAXMnW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 24 Jan 2023 07:43:22 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 666464523F;
        Tue, 24 Jan 2023 04:43:19 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4P1RNx0Yw1z6J7Xn;
        Tue, 24 Jan 2023 20:39:13 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 24 Jan
 2023 12:43:16 +0000
Date:   Tue, 24 Jan 2023 12:43:15 +0000
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
Subject: Re: [PATCH v2 10/10] PCI/DOE: Relax restrictions on request and
 response size
Message-ID: <20230124124315.00000a5c@Huawei.com>
In-Reply-To: <4dba01ff87d630abdd5a09d52e954d3c212d2018.1674468099.git.lukas@wunner.de>
References: <cover.1674468099.git.lukas@wunner.de>
        <4dba01ff87d630abdd5a09d52e954d3c212d2018.1674468099.git.lukas@wunner.de>
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

On Mon, 23 Jan 2023 11:20:00 +0100
Lukas Wunner <lukas@wunner.de> wrote:

> An upcoming user of DOE is CMA (Component Measurement and Authentication,
> PCIe r6.0 sec 6.31).
> 
> It builds on SPDM (Security Protocol and Data Model):
> https://www.dmtf.org/dsp/DSP0274
> 
> SPDM message sizes are not always a multiple of dwords.  To transport
> them over DOE without using bounce buffers, allow sending requests and
> receiving responses whose final dword is only partially populated.
> 
> Tested-by: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> Cc: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Ah. This...

I can't immediately find the original discussion thread, but I'm fairly
sure we had a version of the DOE code that did this (maybe we just
discussed doing it and never had code...)

IIRC, at the time feedback was strongly in favour of making
the handling of non dword payloads a problem for the caller (e.g. PCI/CMA)
not the DOE core, mainly so that we could keep the layering simple.
DOE part of PCI spec says DWORD multiples only, CMA has non dword
entries.

Personally I'm fully in favour of making our lives easier and handling
this at the DOE layer!  The CMA padding code is nasty as we have to deal
with caching just the right bits of the payload for the running hashes.
With it at this layer I'd imagine that code gets much simpler

Assuming resolution to Ira's question on endianness is resolved.
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/pci/doe.c | 66 ++++++++++++++++++++++++++++-------------------
>  1 file changed, 40 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/pci/doe.c b/drivers/pci/doe.c
> index 0263bcfdddd8..2113ec95379f 100644
> --- a/drivers/pci/doe.c
> +++ b/drivers/pci/doe.c
> @@ -76,13 +76,6 @@ struct pci_doe_protocol {
>   * @private: Private data for the consumer
>   * @work: Used internally by the mailbox
>   * @doe_mb: Used internally by the mailbox
> - *
> - * The payload sizes and rv are specified in bytes with the following
> - * restrictions concerning the protocol.
> - *
> - *	1) The request_pl_sz must be a multiple of double words (4 bytes)
> - *	2) The response_pl_sz must be >= a single double word (4 bytes)
> - *	3) rv is returned as bytes but it will be a multiple of double words
>   */
>  struct pci_doe_task {
>  	struct pci_doe_protocol prot;
> @@ -153,7 +146,7 @@ static int pci_doe_send_req(struct pci_doe_mb *doe_mb,
>  {
>  	struct pci_dev *pdev = doe_mb->pdev;
>  	int offset = doe_mb->cap_offset;
> -	size_t length;
> +	size_t length, remainder;
>  	u32 val;
>  	int i;
>  
> @@ -171,7 +164,7 @@ static int pci_doe_send_req(struct pci_doe_mb *doe_mb,
>  		return -EIO;
>  
>  	/* Length is 2 DW of header + length of payload in DW */
> -	length = 2 + task->request_pl_sz / sizeof(u32);
> +	length = 2 + DIV_ROUND_UP(task->request_pl_sz, sizeof(u32));
>  	if (length > PCI_DOE_MAX_LENGTH)
>  		return -EIO;
>  	if (length == PCI_DOE_MAX_LENGTH)
> @@ -184,10 +177,20 @@ static int pci_doe_send_req(struct pci_doe_mb *doe_mb,
>  	pci_write_config_dword(pdev, offset + PCI_DOE_WRITE,
>  			       FIELD_PREP(PCI_DOE_DATA_OBJECT_HEADER_2_LENGTH,
>  					  length));
> +
> +	/* Write payload */
>  	for (i = 0; i < task->request_pl_sz / sizeof(u32); i++)
>  		pci_write_config_dword(pdev, offset + PCI_DOE_WRITE,
>  				       task->request_pl[i]);
>  
> +	/* Write last payload dword */
> +	remainder = task->request_pl_sz % sizeof(u32);
> +	if (remainder) {
> +		val = 0;
> +		memcpy(&val, &task->request_pl[i], remainder);
> +		pci_write_config_dword(pdev, offset + PCI_DOE_WRITE, val);
> +	}
> +
>  	pci_doe_write_ctrl(doe_mb, PCI_DOE_CTRL_GO);
>  
>  	return 0;
> @@ -207,11 +210,11 @@ static bool pci_doe_data_obj_ready(struct pci_doe_mb *doe_mb)
>  
>  static int pci_doe_recv_resp(struct pci_doe_mb *doe_mb, struct pci_doe_task *task)
>  {
> +	size_t length, payload_length, remainder, received;
>  	struct pci_dev *pdev = doe_mb->pdev;
>  	int offset = doe_mb->cap_offset;
> -	size_t length, payload_length;
> +	int i = 0;
>  	u32 val;
> -	int i;
>  
>  	/* Read the first dword to get the protocol */
>  	pci_read_config_dword(pdev, offset + PCI_DOE_READ, &val);
> @@ -238,15 +241,34 @@ static int pci_doe_recv_resp(struct pci_doe_mb *doe_mb, struct pci_doe_task *tas
>  
>  	/* First 2 dwords have already been read */
>  	length -= 2;
> -	payload_length = min(length, task->response_pl_sz / sizeof(u32));
> -	/* Read the rest of the response payload */
> -	for (i = 0; i < payload_length; i++) {
> -		pci_read_config_dword(pdev, offset + PCI_DOE_READ,
> -				      &task->response_pl[i]);
> +	received = task->response_pl_sz;
> +	payload_length = DIV_ROUND_UP(task->response_pl_sz, sizeof(u32));
> +	remainder = task->response_pl_sz % sizeof(u32);
> +	if (!remainder)
> +		remainder = sizeof(u32);
> +
> +	if (length < payload_length) {
> +		received = length * sizeof(u32);
> +		payload_length = length;
> +		remainder = sizeof(u32);
> +	}
> +
> +	if (payload_length) {
> +		/* Read all payload dwords except the last */
> +		for (; i < payload_length - 1; i++) {
> +			pci_read_config_dword(pdev, offset + PCI_DOE_READ,
> +					      &task->response_pl[i]);
> +			pci_write_config_dword(pdev, offset + PCI_DOE_READ, 0);
> +		}
> +
> +		/* Read last payload dword */
> +		pci_read_config_dword(pdev, offset + PCI_DOE_READ, &val);
> +		memcpy(&task->response_pl[i], &val, remainder);
>  		/* Prior to the last ack, ensure Data Object Ready */
> -		if (i == (payload_length - 1) && !pci_doe_data_obj_ready(doe_mb))
> +		if (!pci_doe_data_obj_ready(doe_mb))
>  			return -EIO;
>  		pci_write_config_dword(pdev, offset + PCI_DOE_READ, 0);
> +		i++;
>  	}
>  
>  	/* Flush excess length */
> @@ -260,7 +282,7 @@ static int pci_doe_recv_resp(struct pci_doe_mb *doe_mb, struct pci_doe_task *tas
>  	if (FIELD_GET(PCI_DOE_STATUS_ERROR, val))
>  		return -EIO;
>  
> -	return min(length, task->response_pl_sz / sizeof(u32)) * sizeof(u32);
> +	return received;
>  }
>  
>  static void signal_task_complete(struct pci_doe_task *task, int rv)
> @@ -560,14 +582,6 @@ static int pci_doe_submit_task(struct pci_doe_mb *doe_mb,
>  	if (!pci_doe_supports_prot(doe_mb, task->prot.vid, task->prot.type))
>  		return -EINVAL;
>  
> -	/*
> -	 * DOE requests must be a whole number of DW and the response needs to
> -	 * be big enough for at least 1 DW
> -	 */
> -	if (task->request_pl_sz % sizeof(u32) ||
> -	    task->response_pl_sz < sizeof(u32))
> -		return -EINVAL;
> -
>  	if (test_bit(PCI_DOE_FLAG_DEAD, &doe_mb->flags))
>  		return -EIO;
>  

