Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A1FE6231E8
	for <lists+linux-pci@lfdr.de>; Wed,  9 Nov 2022 18:52:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229850AbiKIRwK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 9 Nov 2022 12:52:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230222AbiKIRwJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 9 Nov 2022 12:52:09 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AD5E9FDF
        for <linux-pci@vger.kernel.org>; Wed,  9 Nov 2022 09:52:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D2286B80AE1
        for <linux-pci@vger.kernel.org>; Wed,  9 Nov 2022 17:52:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6009AC433B5;
        Wed,  9 Nov 2022 17:52:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668016325;
        bh=44Eab1vCaH84NeYBMMsFGmGcoxn+rXWkIsJWD04IPzI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=Xqg+9fXpGX4NJzQcOEsw8hOPv77I2h+KpLYI9yL+d6Hl67B8VwTJ5EQDu1da7g0Ic
         6wrsMVL6Ibst+F7gzNo5DZOPrvBiMoNXZo4kOHHACTEDqBXT4HekzKVBm+i+6WWrdT
         vG6ii3RE9zfh3HMJGrGZQHe9gjniWH6MSPAXw4jQL1ULLgoXMG/l66M6pJ6q+UoaAt
         nazLsgXgnw076WG72FA3vL/OTkr/bC02wzZFKH9x/gOm7hf3Nl/1U9D5aYZ7zuZQmJ
         C3xZux/4PsogYASBrTbO0R68S1EuxcuBBodT7DGjS5NhpWVdTZJ8AgTOKEEr0vu1wo
         cbwOjsq5vyBxg==
Date:   Wed, 9 Nov 2022 11:52:04 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Li Ming <ming4.li@intel.com>
Cc:     bhelgaas@google.com, Jonathan.Cameron@huawei.com,
        ira.weiny@intel.com, linux-pci@vger.kernel.org
Subject: Re: [PATCH 1/1] PCI/DOE: adjust data object length
Message-ID: <20221109175204.GA568218@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221109022044.1827423-1-ming4.li@intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Nov 09, 2022 at 10:20:44AM +0800, Li Ming wrote:
> The value of data object length 0x0 indicates 2^18 dwords being
> transferred, it is introduced in PCIe r6.0,sec 6.30.1. This patch
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

2 ^  18 == 262144
2 << 18 == 524288

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

Do you check for overflow anywhere?  What if length is
PCI_DOE_MAX_LENGTH + 1?

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

Oh, I see, this looks like the check for overflow.  It would be nice
if it were expressed in terms of PCI_DOE_MAX_LENGTH somehow.

It would also be nice, but maybe not practical, to have it closer to
the FIELD_PREP above so it's more obvious that we never try to encode
something too big.

>  	    task->response_pl_sz < sizeof(u32))
>  		return -EINVAL;
>  
> -- 
> 2.25.1
> 
