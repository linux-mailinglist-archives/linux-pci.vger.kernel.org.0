Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE3B562480A
	for <lists+linux-pci@lfdr.de>; Thu, 10 Nov 2022 18:14:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229638AbiKJROx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 10 Nov 2022 12:14:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbiKJROw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 10 Nov 2022 12:14:52 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCCA61145C
        for <linux-pci@vger.kernel.org>; Thu, 10 Nov 2022 09:14:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5732161CE4
        for <linux-pci@vger.kernel.org>; Thu, 10 Nov 2022 17:14:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92A84C433C1;
        Thu, 10 Nov 2022 17:14:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668100490;
        bh=IKcIyH17GeNOygv4ZCCJvlbwVchegQq2z60oFv//HiI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=VO70PDel4vgmb7xX2fQAp++IYLrn9mkI2lsscs9BMGPdHqLb4LWNFko8EHS7yFDy7
         /z4V6xEQH05J4QLQJ16d/NfciXH+9I0Khv9/6f8MZ4Yy97nV0QwxWoyYqjIaqaurL6
         WHxwxcQvPmMq2/BJquw81qlLwdg7rSjeVSJvi3CLX/Avq7YQE2XL0Zkqzmg5kv7vZW
         MjUKWUp/xeooOW0lB1blESN9e78W11TGcnoXudKk437wnCT8Z9hR3rq521DGXNzB5i
         NEjADoa/bc6k3dtC7AuWqcg2/P887n7/5SKjV4I8r+pn93tnBCov7roR9ukyLf9XH9
         yCBrVPhZ62q2w==
Date:   Thu, 10 Nov 2022 11:14:48 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Li, Ming" <ming4.li@intel.com>
Cc:     bhelgaas@google.com, Jonathan.Cameron@huawei.com,
        ira.weiny@intel.com, linux-pci@vger.kernel.org
Subject: Re: [PATCH 1/1] PCI/DOE: adjust data object length
Message-ID: <20221110171448.GA628197@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4e83c0ea-6d40-f26a-5a30-29234c9d92a2@intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Nov 10, 2022 at 09:27:52AM +0800, Li, Ming wrote:
> On 11/10/2022 1:52 AM, Bjorn Helgaas wrote:
> > On Wed, Nov 09, 2022 at 10:20:44AM +0800, Li Ming wrote:
> >> The value of data object length 0x0 indicates 2^18 dwords being
> >> transferred, it is introduced in PCIe r6.0,sec 6.30.1. This patch
> >> adjusts the value of data object length for the above case on both
> >> sending side and receiving side.
> >>
> >> Besides, it is unnecessary to check whether length is greater than
> >> SZ_1M while receiving a response data object, because length from LENGTH
> >> field of data object header, max value is 2^18.
> >>
> >> Signed-off-by: Li Ming <ming4.li@intel.com>
> >> ---
> >>  drivers/pci/doe.c | 21 +++++++++++++++++----
> >>  1 file changed, 17 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/drivers/pci/doe.c b/drivers/pci/doe.c
> >> index e402f05068a5..204cbc570f63 100644
> >> --- a/drivers/pci/doe.c
> >> +++ b/drivers/pci/doe.c
> >> @@ -29,6 +29,9 @@
> >>  #define PCI_DOE_FLAG_CANCEL	0
> >>  #define PCI_DOE_FLAG_DEAD	1
> >>  
> >> +/* Max data object length is 2^18 dwords */
> >> +#define PCI_DOE_MAX_LENGTH	(2 << 18)

> >>  /**
> >>   * struct pci_doe_mb - State for a single DOE mailbox
> >>   *
> >> @@ -107,6 +110,7 @@ static int pci_doe_send_req(struct pci_doe_mb *doe_mb,
> >>  {
> >>  	struct pci_dev *pdev = doe_mb->pdev;
> >>  	int offset = doe_mb->cap_offset;
> >> +	u32 length;
> >>  	u32 val;
> >>  	int i;
> >>  
> >> @@ -128,10 +132,12 @@ static int pci_doe_send_req(struct pci_doe_mb *doe_mb,
> >>  		FIELD_PREP(PCI_DOE_DATA_OBJECT_HEADER_1_TYPE, task->prot.type);
> >>  	pci_write_config_dword(pdev, offset + PCI_DOE_WRITE, val);
> >>  	/* Length is 2 DW of header + length of payload in DW */
> >> +	length = 2 + task->request_pl_sz / sizeof(u32);
> >> +	if (length == PCI_DOE_MAX_LENGTH)
> >> +		length = 0;
> > 
> > Do you check for overflow anywhere?  What if length is
> > PCI_DOE_MAX_LENGTH + 1?
> > 
> >>  	pci_write_config_dword(pdev, offset + PCI_DOE_WRITE,
> >>  			       FIELD_PREP(PCI_DOE_DATA_OBJECT_HEADER_2_LENGTH,
> >> -					  2 + task->request_pl_sz /
> >> -						sizeof(u32)));
> >> +					  length);
> >>  	for (i = 0; i < task->request_pl_sz / sizeof(u32); i++)
> >>  		pci_write_config_dword(pdev, offset + PCI_DOE_WRITE,
> >>  				       task->request_pl[i]);
> >> @@ -178,7 +184,10 @@ static int pci_doe_recv_resp(struct pci_doe_mb *doe_mb, struct pci_doe_task *tas
> >>  	pci_write_config_dword(pdev, offset + PCI_DOE_READ, 0);
> >>  
> >>  	length = FIELD_GET(PCI_DOE_DATA_OBJECT_HEADER_2_LENGTH, val);
> >> -	if (length > SZ_1M || length < 2)
> >> +	/* A value of 0x0 indicates max data object length */
> >> +	if (!length)
> >> +		length = PCI_DOE_MAX_LENGTH;
> >> +	if (length < 2)
> >>  		return -EIO;
> >>  
> >>  	/* First 2 dwords have already been read */
> >> @@ -520,8 +529,12 @@ int pci_doe_submit_task(struct pci_doe_mb *doe_mb, struct pci_doe_task *task)
> >>  	/*
> >>  	 * DOE requests must be a whole number of DW and the response needs to
> >>  	 * be big enough for at least 1 DW
> >> +	 *
> >> +	 * Max data object length is 1MB, and data object header occupies 8B,
> >> +	 * thus request_pl_sz should not be greater than 1MB - 8B.
> >>  	 */
> >> -	if (task->request_pl_sz % sizeof(u32) ||
> >> +	if (task->request_pl_sz > SZ_1M - 8 ||
> >> +	    task->request_pl_sz % sizeof(u32) ||
> > 
> > Oh, I see, this looks like the check for overflow.  It would be nice
> > if it were expressed in terms of PCI_DOE_MAX_LENGTH somehow.
> > 
> > It would also be nice, but maybe not practical, to have it closer to
> > the FIELD_PREP above so it's more obvious that we never try to encode
> > something too big.
> > 
> here is the beginning of a task, and starting to check
> task->request_pl_sz, so I put request_pl_sz overflow checking here.
>
> do you mean that we keep task->request_pl_sz % sizeof(u32) here and
> move request_pl_sz overflow checking to closer to the FIELD_PREP
> above?

Yes, that's what I meant.

I think the more important thing is to do the check using
PCI_DOE_MAX_LENGTH if possible so the connection is obvious and
consistent.
