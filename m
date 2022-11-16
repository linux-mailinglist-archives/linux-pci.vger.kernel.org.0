Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9579862C72E
	for <lists+linux-pci@lfdr.de>; Wed, 16 Nov 2022 19:03:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233325AbiKPSDj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Nov 2022 13:03:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238617AbiKPSDB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Nov 2022 13:03:01 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2B8363B8D
        for <linux-pci@vger.kernel.org>; Wed, 16 Nov 2022 10:02:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 91D3961F2B
        for <linux-pci@vger.kernel.org>; Wed, 16 Nov 2022 18:02:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6DDFC433C1;
        Wed, 16 Nov 2022 18:02:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668621773;
        bh=g4NcNAgj1KTAMUYDuGsnA87eGIv3EgwCIYKYNyRNsc0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=G4MIIRKCvemhBvpT4sa/BGpXAN6W42e56sq48IiWJWyy78k9RZlTHctWMZ6nJhjZZ
         kEPXLY/kUdZRZlFCVaEj2VtZhNR/3mAuw83npIcdwUVdQ3PsB8/pwWQ34H11LYrcEi
         sjvjEk7/mj716EN9e44oxaW4JtXZR5HSzw++CG3KUErfcELfdZctu+wg1ObWs8VRGc
         Hk2vOt7XyTwQws9S3OwmUBWWxSLZrlSCMNRfWStU8y9aYOzpPVHENDn17jTc6FW3MF
         tMBKWIlhaOXtzVyAS8A+Z4Hbu3Wjvj6CpcGaoDWNJVom9kA1ovT6OJbrJOOCGwa4KM
         Oj2dOhSZorYrA==
Date:   Wed, 16 Nov 2022 12:02:50 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Li Ming <ming4.li@intel.com>
Cc:     bhelgaas@google.com, Jonathan.Cameron@huawei.com,
        ira.weiny@intel.com, linux-pci@vger.kernel.org
Subject: Re: [PATCH V2 1/1] PCI/DOE: Fix maximum data object length
 miscalculation
Message-ID: <20221116180250.GA1125709@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221116015637.3299664-1-ming4.li@intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Nov 16, 2022 at 09:56:37AM +0800, Li Ming wrote:
> The value of data object length 0x0 indicates 2^18 dwords being
> transferred. This patch adjusts the value of data object length for the
> above case on both sending side and receiving side.
> 
> Besides, it is unnecessary to check whether length is greater than
> SZ_1M while receiving a response data object, because length from LENGTH
> field of data object header, max value is 2^18.
> 
> Signed-off-by: Li Ming <ming4.li@intel.com>

Applied with Reviewed-by from Jonathan and Lukas, thank you very much
to all of you!

I touched up the commit log; let me know if I made anything worse:

    PCI/DOE: Fix maximum data object length miscalculation
    
    Per PCIe r6.0, sec 6.30.1, a data object Length of 0x0 indicates 2^18
    DWORDs (256K DW or 1MB) being transferred.  Adjust the value of data object
    length for this case on both sending side and receiving side.
    
    Don't bother checking whether Length is greater than SZ_1M because all
    values of the 18-bit Length field are valid, and it is impossible to
    represent anything larger than SZ_1M:
    
      0x00000    256K DW (1M bytes)
      0x00001       1 DW (4 bytes)
      ...
      0x3ffff  256K-1 DW (1M - 4 bytes)

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
> -- 
> 2.25.1
> 
