Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F06F362B6A7
	for <lists+linux-pci@lfdr.de>; Wed, 16 Nov 2022 10:37:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231985AbiKPJhQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Nov 2022 04:37:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232614AbiKPJhP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Nov 2022 04:37:15 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 002876246
        for <linux-pci@vger.kernel.org>; Wed, 16 Nov 2022 01:37:13 -0800 (PST)
Received: from fraeml709-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4NByZ00vsWz6HJY4;
        Wed, 16 Nov 2022 17:34:48 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 fraeml709-chm.china.huawei.com (10.206.15.37) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 16 Nov 2022 10:37:11 +0100
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 16 Nov
 2022 09:37:11 +0000
Date:   Wed, 16 Nov 2022 09:37:10 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Li Ming <ming4.li@intel.com>
CC:     <bhelgaas@google.com>, <ira.weiny@intel.com>,
        <linux-pci@vger.kernel.org>
Subject: Re: [PATCH V2 1/1] PCI/DOE: Fix maximum data object length
 miscalculation
Message-ID: <20221116093710.00002091@Huawei.com>
In-Reply-To: <20221116015637.3299664-1-ming4.li@intel.com>
References: <20221116015637.3299664-1-ming4.li@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
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

On Wed, 16 Nov 2022 09:56:37 +0800
Li Ming <ming4.li@intel.com> wrote:

> The value of data object length 0x0 indicates 2^18 dwords being
> transferred. This patch adjusts the value of data object length for the
> above case on both sending side and receiving side.
> 
> Besides, it is unnecessary to check whether length is greater than
> SZ_1M while receiving a response data object, because length from LENGTH
> field of data object header, max value is 2^18.
> 
> Signed-off-by: Li Ming <ming4.li@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Thanks,


> ---
> v1->v2:
>  * Fix the value of PCI_DOE_MAX_LENGTH
>  * Moving length checking closer to transferring process
>  * Add a missing bracket
>  * Adjust patch description
> ---
>  drivers/pci/doe.c | 20 ++++++++++++++++----
>  1 file changed, 16 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/doe.c b/drivers/pci/doe.c
> index e402f05068a5..66d9ab288646 100644
> --- a/drivers/pci/doe.c
> +++ b/drivers/pci/doe.c
> @@ -29,6 +29,9 @@
>  #define PCI_DOE_FLAG_CANCEL	0
>  #define PCI_DOE_FLAG_DEAD	1
>  
> +/* Max data object length is 2^18 dwords */
> +#define PCI_DOE_MAX_LENGTH	(1 << 18)
> +
>  /**
>   * struct pci_doe_mb - State for a single DOE mailbox
>   *
> @@ -107,6 +110,7 @@ static int pci_doe_send_req(struct pci_doe_mb *doe_mb,
>  {
>  	struct pci_dev *pdev = doe_mb->pdev;
>  	int offset = doe_mb->cap_offset;
> +	size_t length;
>  	u32 val;
>  	int i;
>  
> @@ -123,15 +127,20 @@ static int pci_doe_send_req(struct pci_doe_mb *doe_mb,
>  	if (FIELD_GET(PCI_DOE_STATUS_ERROR, val))
>  		return -EIO;
>  
> +	/* Length is 2 DW of header + length of payload in DW */
> +	length = 2 + task->request_pl_sz / sizeof(u32);
> +	if (length > PCI_DOE_MAX_LENGTH)
> +		return -EIO;
> +	if (length == PCI_DOE_MAX_LENGTH)
> +		length = 0;
> +
>  	/* Write DOE Header */
>  	val = FIELD_PREP(PCI_DOE_DATA_OBJECT_HEADER_1_VID, task->prot.vid) |
>  		FIELD_PREP(PCI_DOE_DATA_OBJECT_HEADER_1_TYPE, task->prot.type);
>  	pci_write_config_dword(pdev, offset + PCI_DOE_WRITE, val);
> -	/* Length is 2 DW of header + length of payload in DW */
>  	pci_write_config_dword(pdev, offset + PCI_DOE_WRITE,
>  			       FIELD_PREP(PCI_DOE_DATA_OBJECT_HEADER_2_LENGTH,
> -					  2 + task->request_pl_sz /
> -						sizeof(u32)));
> +					  length));
>  	for (i = 0; i < task->request_pl_sz / sizeof(u32); i++)
>  		pci_write_config_dword(pdev, offset + PCI_DOE_WRITE,
>  				       task->request_pl[i]);
> @@ -178,7 +187,10 @@ static int pci_doe_recv_resp(struct pci_doe_mb *doe_mb, struct pci_doe_task *tas
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

