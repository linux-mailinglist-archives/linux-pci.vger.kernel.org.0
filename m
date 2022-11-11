Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0010625FCD
	for <lists+linux-pci@lfdr.de>; Fri, 11 Nov 2022 17:47:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233940AbiKKQr0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 11 Nov 2022 11:47:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234306AbiKKQrX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 11 Nov 2022 11:47:23 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A7C883B84
        for <linux-pci@vger.kernel.org>; Fri, 11 Nov 2022 08:47:21 -0800 (PST)
Received: from fraeml703-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4N84JG6wqjz67Ls2;
        Sat, 12 Nov 2022 00:42:54 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 fraeml703-chm.china.huawei.com (10.206.15.52) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2375.31; Fri, 11 Nov 2022 17:47:18 +0100
Received: from localhost (10.45.151.252) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Fri, 11 Nov
 2022 16:47:18 +0000
Date:   Fri, 11 Nov 2022 16:47:17 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Li Ming <ming4.li@intel.com>
CC:     <bhelgaas@google.com>, <ira.weiny@intel.com>,
        <linux-pci@vger.kernel.org>
Subject: Re: [PATCH 1/1] PCI/DOE: adjust data object length
Message-ID: <20221111164717.00002d7e@Huawei.com>
In-Reply-To: <20221109022044.1827423-1-ming4.li@intel.com>
References: <20221109022044.1827423-1-ming4.li@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.45.151.252]
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
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

On Wed,  9 Nov 2022 10:20:44 +0800
Li Ming <ming4.li@intel.com> wrote:

> The value of data object length 0x0 indicates 2^18 dwords being
> transferred, it is introduced in PCIe r6.0,sec 6.30.1. This patch

Was introduced prior to that in the DOE ECN, so perhaps just drop "introduced".

I'm not sure why we missed that little detail of the spec originally so good to fix this up.
Probably deserves a fixes tag though it would be very hard to hit
with the only protocol we currently have upstream.

Other than what Bjorn pointed out and the missing bracket the
Robot found, looks good to me.

> adjusts the value of data object length for the above case on both
> sending side and receiving side.
> 
> Besides, it is unnecessary to check whether length is greater than
> SZ_1M while receiving a response data object, because length from LENGTH
> field of data object header, max value is 2^18.
> 
> Signed-off-by: Li Ming <ming4.li@intel.com>
> ---
>  drivers/pci/doe.c | 21 +++++++++++++++++----
>  1 file changed, 17 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/doe.c b/drivers/pci/doe.c
> index e402f05068a5..204cbc570f63 100644
> --- a/drivers/pci/doe.c
> +++ b/drivers/pci/doe.c
> @@ -29,6 +29,9 @@
>  #define PCI_DOE_FLAG_CANCEL	0
>  #define PCI_DOE_FLAG_DEAD	1
>  
> +/* Max data object length is 2^18 dwords */
> +#define PCI_DOE_MAX_LENGTH	(2 << 18)
> +
>  /**
>   * struct pci_doe_mb - State for a single DOE mailbox
>   *
> @@ -107,6 +110,7 @@ static int pci_doe_send_req(struct pci_doe_mb *doe_mb,
>  {
>  	struct pci_dev *pdev = doe_mb->pdev;
>  	int offset = doe_mb->cap_offset;
> +	u32 length;
>  	u32 val;
>  	int i;
>  
> @@ -128,10 +132,12 @@ static int pci_doe_send_req(struct pci_doe_mb *doe_mb,
>  		FIELD_PREP(PCI_DOE_DATA_OBJECT_HEADER_1_TYPE, task->prot.type);
>  	pci_write_config_dword(pdev, offset + PCI_DOE_WRITE, val);
>  	/* Length is 2 DW of header + length of payload in DW */
> +	length = 2 + task->request_pl_sz / sizeof(u32);
> +	if (length == PCI_DOE_MAX_LENGTH)
> +		length = 0;
>  	pci_write_config_dword(pdev, offset + PCI_DOE_WRITE,
>  			       FIELD_PREP(PCI_DOE_DATA_OBJECT_HEADER_2_LENGTH,
> -					  2 + task->request_pl_sz /
> -						sizeof(u32)));
> +					  length);
>  	for (i = 0; i < task->request_pl_sz / sizeof(u32); i++)
>  		pci_write_config_dword(pdev, offset + PCI_DOE_WRITE,
>  				       task->request_pl[i]);
> @@ -178,7 +184,10 @@ static int pci_doe_recv_resp(struct pci_doe_mb *doe_mb, struct pci_doe_task *tas
>  	pci_write_config_dword(pdev, offset + PCI_DOE_READ, 0);
>  
>  	length = FIELD_GET(PCI_DOE_DATA_OBJECT_HEADER_2_LENGTH, val);
> -	if (length > SZ_1M || length < 2)
> +	/* A value of 0x0 indicates max data object length */
> +	if (!length)
> +		length = PCI_DOE_MAX_LENGTH;
> +	if (length < 2)
>  		return -EIO;
>  
>  	/* First 2 dwords have already been read */
> @@ -520,8 +529,12 @@ int pci_doe_submit_task(struct pci_doe_mb *doe_mb, struct pci_doe_task *task)
>  	/*
>  	 * DOE requests must be a whole number of DW and the response needs to
>  	 * be big enough for at least 1 DW
> +	 *
> +	 * Max data object length is 1MB, and data object header occupies 8B,
> +	 * thus request_pl_sz should not be greater than 1MB - 8B.
>  	 */
> -	if (task->request_pl_sz % sizeof(u32) ||
> +	if (task->request_pl_sz > SZ_1M - 8 ||
> +	    task->request_pl_sz % sizeof(u32) ||
>  	    task->response_pl_sz < sizeof(u32))
>  		return -EINVAL;
>  

