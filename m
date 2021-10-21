Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F0994365F8
	for <lists+linux-pci@lfdr.de>; Thu, 21 Oct 2021 17:23:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231865AbhJUPZW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 21 Oct 2021 11:25:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231795AbhJUPZW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 21 Oct 2021 11:25:22 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33F3DC061764;
        Thu, 21 Oct 2021 08:23:06 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id a15-20020a17090a688f00b001a132a1679bso3423769pjd.0;
        Thu, 21 Oct 2021 08:23:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=u8MgP9EyHiwfzS+PfrhohOi5W9AFD7yrctxjYPpGCNs=;
        b=WVm5YA3svbpKDgEwEWf79YIA2d+HMr3vgMUHlvL/Q51sZB1k2BjB9D7OsHHe/c6ZKR
         3jo0jGxj8JujkkKMJhKYdcEd/cKgCG0WMlt9XvJeSW+eGf4jQaIAEAeYa55sICeLOZaV
         htM63ArD0dzfszA64bl2Zs+CReRT/73uwp0oWQt18dn/jQqZQcB8udEnM7Cj6mWPDiuE
         +4kAM3z3gaanSnhrYgy4hAfp6xgol2yZl7O0uBcvhdh1I+5SN3IPuyoCebu8a/jyf57v
         prYMYOkeURk7aJQt/MlEV0Wq7OhpA/mwL0HPnkGLFh6zkUpJ9CRl1VMFMi7W9FYDW+jz
         SLzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=u8MgP9EyHiwfzS+PfrhohOi5W9AFD7yrctxjYPpGCNs=;
        b=Nni676keI8Kib+udjH0zD31AIRYHuq6+JObt/qbLAn+RCBE+s3ZsBVJMswX4hAH12S
         4ezBYlmRucBb155CyLAmsQMzRyL3N+m68IgLqSDFBL5D9f6RhEFai+uxR0DDikdlfSRo
         MrDMjyrSr8QqqklZsPDjzcfChPZk0foVl9huNrmAIm4EfRBBVzzEYY4PdMnjo0Mp2ffL
         4cRq58KdNMjMVxJuCsPv+9h08dRNr5yQTzMDBzkgbTPd4uagG6FH9BFy2STYcnk16jFO
         OQeopQsKrZPkJzJwKEkvwt/0V2HrOyO9oaFSbgHDyJTQigsW1/0eryrmqs26FLQkC6T/
         1ceQ==
X-Gm-Message-State: AOAM531Pp+0Hf6s3QUuORI9rz9exeMQ1+6zsuseTnM9H3XVfro++X+Kr
        8YCUcLC9nO9Y/Zv3NgDfUxQ=
X-Google-Smtp-Source: ABdhPJyM7v0zXEyGqjciHtSAM+WG0z/jW2TYz2BvKHQIg0x3oAjMjTZKgmIFXVMU8//fhdvqmoiD5g==
X-Received: by 2002:a17:90a:4b47:: with SMTP id o7mr7491151pjl.198.1634829785570;
        Thu, 21 Oct 2021 08:23:05 -0700 (PDT)
Received: from theprophet ([2406:7400:63:29a4:d874:a949:6890:f95f])
        by smtp.gmail.com with ESMTPSA id f84sm6347400pfa.25.2021.10.21.08.23.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 08:23:05 -0700 (PDT)
Date:   Thu, 21 Oct 2021 20:52:53 +0530
From:   Naveen Naidu <naveennaidu479@gmail.com>
To:     bhelgaas@google.com
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org, Lukas Wunner <lukas@wunner.de>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Amey Narkhede <ameynarkhede03@gmail.com>
Subject: Re: [PATCH v3 18/25] PCI: pciehp: Use RESPONSE_IS_PCI_ERROR() to
 check read from hardware
Message-ID: <20211021152253.pqc6xp3vnv5fpczj@theprophet>
References: <cover.1634825082.git.naveennaidu479@gmail.com>
 <c21290fe02a7a342a8b93c692586b6a2b6cde9e0.1634825082.git.naveennaidu479@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c21290fe02a7a342a8b93c692586b6a2b6cde9e0.1634825082.git.naveennaidu479@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 21/10, Naveen Naidu wrote:
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
> Signed-off-by: Naveen Naidu <naveennaidu479@gmail.com>
> ---
>  drivers/pci/hotplug/pciehp_hpc.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
> index 3024d7e85e6a..f472f83f6cce 100644
> --- a/drivers/pci/hotplug/pciehp_hpc.c
> +++ b/drivers/pci/hotplug/pciehp_hpc.c
> @@ -89,7 +89,7 @@ static int pcie_poll_cmd(struct controller *ctrl, int timeout)
>  
>  	do {
>  		pcie_capability_read_word(pdev, PCI_EXP_SLTSTA, &slot_status);
> -		if (slot_status == (u16) ~0) {
> +		if (RESPONSE_IS_PCI_ERROR(slot_status)) {
>  			ctrl_info(ctrl, "%s: no response from device\n",
>  				  __func__);
>  			return 0;
> @@ -165,7 +165,7 @@ static void pcie_do_write_cmd(struct controller *ctrl, u16 cmd,
>  	pcie_wait_cmd(ctrl);
>  
>  	pcie_capability_read_word(pdev, PCI_EXP_SLTCTL, &slot_ctrl);
> -	if (slot_ctrl == (u16) ~0) {
> +	if (RESPONSE_IS_PCI_ERROR(slot_ctrl)) {
>  		ctrl_info(ctrl, "%s: no response from device\n", __func__);
>  		goto out;
>  	}
> @@ -236,7 +236,7 @@ int pciehp_check_link_active(struct controller *ctrl)
>  	int ret;
>  
>  	ret = pcie_capability_read_word(pdev, PCI_EXP_LNKSTA, &lnk_status);
> -	if (ret == PCIBIOS_DEVICE_NOT_FOUND || lnk_status == (u16)~0)
> +	if (ret == PCIBIOS_DEVICE_NOT_FOUND || RESPONSE_IS_PCI_ERROR(lnk_status))
>  		return -ENODEV;
>  
>  	ret = !!(lnk_status & PCI_EXP_LNKSTA_DLLLA);
> @@ -443,7 +443,7 @@ int pciehp_card_present(struct controller *ctrl)
>  	int ret;
>  
>  	ret = pcie_capability_read_word(pdev, PCI_EXP_SLTSTA, &slot_status);
> -	if (ret == PCIBIOS_DEVICE_NOT_FOUND || slot_status == (u16)~0)
> +	if (ret == PCIBIOS_DEVICE_NOT_FOUND || RESPONSE_IS_PCI_ERROR(slot_status))
>  		return -ENODEV;
>  
>  	return !!(slot_status & PCI_EXP_SLTSTA_PDS);
> @@ -621,7 +621,7 @@ static irqreturn_t pciehp_isr(int irq, void *dev_id)
>  
>  read_status:
>  	pcie_capability_read_word(pdev, PCI_EXP_SLTSTA, &status);
> -	if (status == (u16) ~0) {
> +	if (RESPONSE_IS_PCI_ERROR(status)) {
>  		ctrl_info(ctrl, "%s: no response from device\n", __func__);
>  		if (parent)
>  			pm_runtime_put(parent);
> -- 
> 2.25.1
> 

Lukas, I have not added your Acked-by tag from the v1 [1] of the patch 
series, since the RESPONSE_IS_PCI_ERROR macro definition slightly 
changed. I hope this was the right thing to do.

[1]: https://lore.kernel.org/linux-pci/20211011194740.GA14357@wunner.de/

Also, regarding your comments from v1 patch series [1] about re-naming
the RESPONSE_IS_PCI_ERROR to RESPONSE_IS_PCI_TIMEOUT. We could indeed 
change the change to RESPONSE_IS_PCI_TIMEOUT for pciehp, but then 
I'm afraid that picehp would be the odd one out. I mean, since in all 
the other places we are using RESPONE_IS_PCI_TIMEOUT to see if any 
error occured while reading from a device.

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

