Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEBB6678ABF
	for <lists+linux-pci@lfdr.de>; Mon, 23 Jan 2023 23:29:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231915AbjAWW3n (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 23 Jan 2023 17:29:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231607AbjAWW3m (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 23 Jan 2023 17:29:42 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E56C3756E;
        Mon, 23 Jan 2023 14:29:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C5338B80EB9;
        Mon, 23 Jan 2023 22:29:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33E00C433EF;
        Mon, 23 Jan 2023 22:29:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674512978;
        bh=FO3TnLFMsjJWu/x8I8xYcsimmkdwbuUDJP3y835QPjo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=E+CLd4otiowjlGtsP2WOBmVjSXK+3ZM2TA7ZqiXFrHZs8AdN3xHpZuJOcdkP+S1sK
         QhP39biJnyLI1ZvHimatKpVlq2KcycHHdaqBNdO3EzwrbC2AHaDssoSjRK+TTMcJlp
         DZ6YPJtwWA84Pnh2tBihJ+pP0sVM9VxHmp4ToGX0W0hEvvCu9S1MXMGO5xbF4gNlzU
         mDsvA7IQK0C7yW8jLMKgcTOPnz8Sgs2TAMaXPv/PhApCNrXOYXMssoy5pEyk3oiKeM
         G9vIHRMQDrK4zHXIZx2F0BWw/TmNthtATghz6pEkl5ITh9n+she4OV15aUNUMWd+p2
         pw77k5R5+Fb2g==
Date:   Mon, 23 Jan 2023 16:29:36 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     linux-pci@vger.kernel.org,
        Gregory Price <gregory.price@memverge.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        "Li, Ming" <ming4.li@intel.com>, Hillf Danton <hdanton@sina.com>,
        Ben Widawsky <bwidawsk@kernel.org>, linuxarm@huawei.com,
        linux-cxl@vger.kernel.org
Subject: Re: [PATCH v2 10/10] PCI/DOE: Relax restrictions on request and
 response size
Message-ID: <20230123222936.GA993507@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4dba01ff87d630abdd5a09d52e954d3c212d2018.1674468099.git.lukas@wunner.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Lukas,

On Mon, Jan 23, 2023 at 11:20:00AM +0100, Lukas Wunner wrote:
> An upcoming user of DOE is CMA (Component Measurement and Authentication,
> PCIe r6.0 sec 6.31).
> 
> It builds on SPDM (Security Protocol and Data Model):
> https://www.dmtf.org/dsp/DSP0274
> 
> SPDM message sizes are not always a multiple of dwords.  To transport
> them over DOE without using bounce buffers, allow sending requests and
> receiving responses whose final dword is only partially populated.

Can you add a note about this non-dwordness?  The sec 6.30.1 Data
Object Header 2 "Length" field is in DW and the code in
pci_doe_send_req() and pci_doe_recv_resp() still reads/writes dwords.
I don't see the 6.31 text that requires non-dword sizes.

From a spec point of view, AFAICS, DOE is still specified in dwords,
but I guess you're leaving the actual PCI config-level DOE interface
in dwords and just making it more convenient for callers by having
pci_doe_*() hide the details of any partial dwords at the end by
transferring the entire dword over PCI but only copying the requested
bytes to/from the caller's buffer?

> Tested-by: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> Cc: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
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
> -- 
> 2.39.1
> 
