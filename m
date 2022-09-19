Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7ED35BD4E9
	for <lists+linux-pci@lfdr.de>; Mon, 19 Sep 2022 20:45:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229549AbiISSpu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 19 Sep 2022 14:45:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbiISSpt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 19 Sep 2022 14:45:49 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4007F476F2
        for <linux-pci@vger.kernel.org>; Mon, 19 Sep 2022 11:45:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9CBDBB8085E
        for <linux-pci@vger.kernel.org>; Mon, 19 Sep 2022 18:45:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1403CC433D6;
        Mon, 19 Sep 2022 18:45:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663613145;
        bh=CaPH1GiQw43HQHeKmwuNXofzz3y75x5BPTF3AxKZvns=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=SS2gab+sRIyrG24IMe7OjgnThXZDGmcOTv8cdU+XlJ7wqeeOkleamtqD6mGjULC1U
         GbuU7x31eHcbjxrRNPpFcHljYYN1YLU+3hrjBtAZ2nL7sdR8q/CH3PTp9SRIR1pGW2
         wiBKFKFc5Nh3tTBFzuYiLIk/Yxyv4KZgcwDtRYBxlFyR5+Ea6celqaEYuPVMTDO8Sy
         eUBVRPOc5Cw7vMtP/wMqc+a8P2i3lsWxa3rZJZu7D7xkYpGvU8ng1n8BCJGkl0ijRu
         Cwa9x5E1Fn4eBVLpER4//Nqrc2L0qKhF43CDGer8MKYqKRe6m4sp3vRv7IteJmQpz+
         6Qkd2agDe2Duw==
Date:   Mon, 19 Sep 2022 13:45:43 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     linux-pci@vger.kernel.org, bhelgaas@google.com,
        logang@deltatee.com, hch@lst.de
Subject: Re: [PATCH -next] PCI/P2PDMA: Switch to use for_each_pci_dev() helper
Message-ID: <20220919184543.GA1022568@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220916140329.679633-1-yangyingliang@huawei.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Sep 16, 2022 at 10:03:29PM +0800, Yang Yingliang wrote:
> Use for_each_pci_dev() instead of open-coding it.
> No functional change.
> 
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>

Applied with Logan's Reviewed-by to pci/misc for v6.1, thanks!

> ---
>  drivers/pci/p2pdma.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
> index 4496a7c5c478..88dc66ee1c46 100644
> --- a/drivers/pci/p2pdma.c
> +++ b/drivers/pci/p2pdma.c
> @@ -649,7 +649,7 @@ struct pci_dev *pci_p2pmem_find_many(struct device **clients, int num_clients)
>  	if (!closest_pdevs)
>  		return NULL;
>  
> -	while ((pdev = pci_get_device(PCI_ANY_ID, PCI_ANY_ID, pdev))) {
> +	for_each_pci_dev(pdev) {
>  		if (!pci_has_p2pmem(pdev))
>  			continue;
>  
> -- 
> 2.25.1
> 
