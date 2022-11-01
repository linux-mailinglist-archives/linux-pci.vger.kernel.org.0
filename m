Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 998D4614AFD
	for <lists+linux-pci@lfdr.de>; Tue,  1 Nov 2022 13:43:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230000AbiKAMnX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 1 Nov 2022 08:43:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230018AbiKAMnW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 1 Nov 2022 08:43:22 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F29B0318;
        Tue,  1 Nov 2022 05:43:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id ABA29B81C89;
        Tue,  1 Nov 2022 12:43:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DCB2C433D6;
        Tue,  1 Nov 2022 12:43:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667306598;
        bh=K1vcFPGKANidQII+rMpXf8xUoisR1b4GIhVpK68UraQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gdbMGaErLqdCJ3Dii/wj8oza0YrKXANNOUhPtzDVjYkpJl+JAvuoZwqsEpSHSGFR+
         h2s2nY3uMUGwzWglj0oktPN5wbi2ckwThAbQcnT6+fAXq69mEHWag2bDSyjIA7Z5e0
         Fq6FcKkMLwAIhzc0DrS1ShJOLRDY4/lKm80nVJJTfREPTqWECZspqUwWcSfqjLUz+N
         CV4X0AdP2eOyTn5BpkaBjJvElyY9DSIn97DWrd/uwtsbNvn5H0GZPWlvLWrpFdcB1S
         3T+v8TKj+gjyHr+NuvH38GikXoWFGfF0xOhkqVJOno6mtU5RsjB0+6QdHWW3b5HYOz
         aJ+qHgHVYFJuA==
Date:   Tue, 1 Nov 2022 18:13:03 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Vidya Sagar <vidyas@nvidia.com>
Cc:     jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        lpieralisi@kernel.org, robh@kernel.org, kw@linux.com,
        bhelgaas@google.com, kishon@ti.com, thierry.reding@gmail.com,
        jonathanh@nvidia.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, kthota@nvidia.com,
        mmaddireddy@nvidia.com, sagar.tv@gmail.com
Subject: Re: [PATCH V2 3/4] PCI: endpoint: Delete list entry before freeing
Message-ID: <20221101124303.GM54667@thinkpad>
References: <20221013181815.2133-1-vidyas@nvidia.com>
 <20221013181815.2133-4-vidyas@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221013181815.2133-4-vidyas@nvidia.com>
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Oct 13, 2022 at 11:48:14PM +0530, Vidya Sagar wrote:
> Currently, epf_group list is traversed, and each group entry is freed and
> epf_group list head is deleted in the end. Deleting the list head is
> corrupting the data in the group entries that are already freed, leading to
> random crashes. To fix this issue, delete each group entry and then free
> it, and don't delete epf_group list head.
> 
> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>

Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>

Thanks,
Mani

> ---
> V2:
> * Reworded the commit message
> 
>  drivers/pci/endpoint/pci-epf-core.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/endpoint/pci-epf-core.c b/drivers/pci/endpoint/pci-epf-core.c
> index 9ed556936f48..a7f4ae33905d 100644
> --- a/drivers/pci/endpoint/pci-epf-core.c
> +++ b/drivers/pci/endpoint/pci-epf-core.c
> @@ -340,9 +340,10 @@ static void pci_epf_remove_cfs(struct pci_epf_driver *driver)
>  		return;
>  
>  	mutex_lock(&pci_epf_mutex);
> -	list_for_each_entry_safe(group, tmp, &driver->epf_group, group_entry)
> +	list_for_each_entry_safe(group, tmp, &driver->epf_group, group_entry) {
> +		list_del(&group->group_entry);
>  		pci_ep_cfs_remove_epf_group(group);
> -	list_del(&driver->epf_group);
> +	}
>  	mutex_unlock(&pci_epf_mutex);
>  }
>  
> -- 
> 2.17.1
> 

-- 
மணிவண்ணன் சதாசிவம்
