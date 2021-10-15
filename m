Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7940A42F6D1
	for <lists+linux-pci@lfdr.de>; Fri, 15 Oct 2021 17:16:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240272AbhJOPSW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 15 Oct 2021 11:18:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232051AbhJOPSW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 15 Oct 2021 11:18:22 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3B2AC061570;
        Fri, 15 Oct 2021 08:16:15 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id nn3-20020a17090b38c300b001a03bb6c4ebso7512563pjb.1;
        Fri, 15 Oct 2021 08:16:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Rsq7Coa4DOxPOn0eZbpZdLfOClr4GNCnmw0Rnrrt1Qw=;
        b=hSxnHl3oyN/MtM+qsldq6hsB1s7pGGZvJuASUryBHZCU+ZEL6mFCa+LtSZlsPk+Mgl
         zs2SzaxQgnKpwzxL39QHUcwxwaf4a33HvycHcpvF6cWAQn/W9JCWr+btdMEbeuxhoS+F
         vQ4NfS0llRXA+CWI6qZrx5qNuMywGXiv0KB5EBtZ8lkaSZPDLOnHksy1KtjMoqdII5mI
         sQCDLmlhqaLD71rnga3U1iVmsRLXnRAHu3ZRG/Dr2yOFz0l7dOSDLgt82MGIG+EiRc0j
         34dAlMzS2KD0Qn9OU0ynsLHSUCMSkPfL1ECpVAqJ7KADGWkSpMe/yuK4HuMJ4exCEbr9
         zjtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Rsq7Coa4DOxPOn0eZbpZdLfOClr4GNCnmw0Rnrrt1Qw=;
        b=SQkn3K0YW2NsHKao7SwyHY6YnWFYgaw7o+VtrNTjqvUdp+uQHeqTQUcbznWYBIFYTr
         1NvagOh/pfSilyvGd1rZ576JajO2NYZ7wZw+Zc9KzkznQql1r5YwpQHqoRbTE5pNCZBj
         AqGS+E0zESTLIRaGweuPuTDRGCZWr45Je9vEVkiSteI1iuuAeY5BNPQE7ySkA1iMkw+Q
         BgqnpY5ase+Gqbgbl9Tg+VxhKmFhV1wdNvnmK6389K4Okf7kbIhbGTm6Hyq1raBqwqLJ
         MhaZVM1UxXQM1LAbEluybP1rvm0ah7dEkAOF1UMFPqqX2A3f3H1jUFkzBQ/USb3TqG2n
         P0IQ==
X-Gm-Message-State: AOAM532W6ULQ3WXNG1ufhCb1ZDP6uDF1LUh5m0QcWy4fHmxVASy93pUB
        RqbR79ClkLTVgdSl3PhKof65w0sUkU2h5Ke/
X-Google-Smtp-Source: ABdhPJyCqbZfWSMhuuPRjAv0uUPvUBqyW5wVqCXkRUL4kLCQLYBGm/nfmiSu2Y23rgpo7KvQd5u0Ow==
X-Received: by 2002:a17:90a:df0e:: with SMTP id gp14mr14183780pjb.35.1634310975311;
        Fri, 15 Oct 2021 08:16:15 -0700 (PDT)
Received: from theprophet ([2406:7400:63:4806:9a51:7f4b:9b5c:337a])
        by smtp.gmail.com with ESMTPSA id on17sm12250018pjb.47.2021.10.15.08.16.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Oct 2021 08:16:14 -0700 (PDT)
Date:   Fri, 15 Oct 2021 20:45:59 +0530
From:   Naveen Naidu <naveennaidu479@gmail.com>
To:     bhelgaas@google.com
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Wunner <lukas@wunner.de>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Amey Narkhede <ameynarkhede03@gmail.com>
Subject: Re: [PATCH v2 18/24] PCI: pciehp: Use RESPONSE_IS_PCI_ERROR() to
 check read from hardware
Message-ID: <20211015151553.wjztlftdmi2xnsyd@theprophet>
References: <cover.1634306198.git.naveennaidu479@gmail.com>
 <2bc987dc1dfb753c37a65b6c8c98c32e66a4d2a0.1634306198.git.naveennaidu479@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2bc987dc1dfb753c37a65b6c8c98c32e66a4d2a0.1634306198.git.naveennaidu479@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 15/10, Naveen Naidu wrote:
> An MMIO read from a PCI device that doesn't exist or doesn't respond
> causes a PCI error.  There's no real data to return to satisfy the
> CPU read, so most hardware fabricates ~0 data.
> 
> Use RESPONSE_IS_PCI_ERROR() to check the response we get when we read
> data from hardware.
> 
> This helps unify PCI error response checking and make error checks
> consistent and easier to find.
> 
> Compile tested only.
> 
> Acked-by: Lukas Wunner <lukas@wunner.de>
> Signed-off-by: Naveen Naidu <naveennaidu479@gmail.com>
> ---
>  drivers/pci/hotplug/pciehp_hpc.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
> index 3024d7e85e6a..8a2f6bb643b5 100644
> --- a/drivers/pci/hotplug/pciehp_hpc.c
> +++ b/drivers/pci/hotplug/pciehp_hpc.c
> @@ -89,7 +89,7 @@ static int pcie_poll_cmd(struct controller *ctrl, int timeout)
>  
>  	do {
>  		pcie_capability_read_word(pdev, PCI_EXP_SLTSTA, &slot_status);
> -		if (slot_status == (u16) ~0) {
> +		if (RESPONSE_IS_PCI_ERROR(&slot_status)) {
>  			ctrl_info(ctrl, "%s: no response from device\n",
>  				  __func__);
>  			return 0;
> @@ -165,7 +165,7 @@ static void pcie_do_write_cmd(struct controller *ctrl, u16 cmd,
>  	pcie_wait_cmd(ctrl);
>  
>  	pcie_capability_read_word(pdev, PCI_EXP_SLTCTL, &slot_ctrl);
> -	if (slot_ctrl == (u16) ~0) {
> +	if (RESPONSE_IS_PCI_ERROR(&slot_ctrl)) {
>  		ctrl_info(ctrl, "%s: no response from device\n", __func__);
>  		goto out;
>  	}
> @@ -236,7 +236,7 @@ int pciehp_check_link_active(struct controller *ctrl)
>  	int ret;
>  
>  	ret = pcie_capability_read_word(pdev, PCI_EXP_LNKSTA, &lnk_status);
> -	if (ret == PCIBIOS_DEVICE_NOT_FOUND || lnk_status == (u16)~0)
> +	if (ret == PCIBIOS_DEVICE_NOT_FOUND || RESPONSE_IS_PCI_ERROR(&lnk_status))
>  		return -ENODEV;
>  
>  	ret = !!(lnk_status & PCI_EXP_LNKSTA_DLLLA);
> @@ -443,7 +443,7 @@ int pciehp_card_present(struct controller *ctrl)
>  	int ret;
>  
>  	ret = pcie_capability_read_word(pdev, PCI_EXP_SLTSTA, &slot_status);
> -	if (ret == PCIBIOS_DEVICE_NOT_FOUND || slot_status == (u16)~0)
> +	if (ret == PCIBIOS_DEVICE_NOT_FOUND || RESPONSE_IS_PCI_ERROR(&slot_status))
>  		return -ENODEV;
>  
>  	return !!(slot_status & PCI_EXP_SLTSTA_PDS);
> @@ -621,7 +621,7 @@ static irqreturn_t pciehp_isr(int irq, void *dev_id)
>  
>  read_status:
>  	pcie_capability_read_word(pdev, PCI_EXP_SLTSTA, &status);
> -	if (status == (u16) ~0) {
> +	if (RESPONSE_IS_PCI_ERROR(&status)) {
>  		ctrl_info(ctrl, "%s: no response from device\n", __func__);
>  		if (parent)
>  			pm_runtime_put(parent);
> -- 
> 2.25.1
> 

Lukas, I have added your Acked-by tag from the v1 [1] of patch series,
since this patch has not changed in v2. I hope that's okay. If not, I
apologize for that and can resend the patch series without the tag.
Apologies for the inconvenience.

[1]: https://lore.kernel.org/linux-pci/20211011194740.GA14357@wunner.de/

Also, regarding your comments from v1 patch series [1] about re-naming the
RESPONSE_IS_PCI_ERROR to RESPONSE_IS_PCI_TIMEOUT. We could indeed change
the change to RESPONSE_IS_PCI_TIMEOUT for pciehp, but then I'm afraid
that picehp would be the odd one out. I mean, since in all the other
places we are using RESPONE_IS_PCI_TIMEOUT to see if any error occured
while reading from a device.

RESPONSE_IS_PCI_ERROR stills gives an idea to the readers that some PCI
error occured. It was my understanding that timeout is also a kind of
PCI error (I might be horribly wrong here, given my very less experience
with PCI subsystem) so it would be okay to use RESPONSE_IS_PCI_ERROR
here.

If that is not the case please let me know. But I am not sure what to
do here? If RESPONSE_IS_PCI_ERROR does not fit here, should the right
option would be to revert/remove this patch from the series?

Thanks,
Naveen
