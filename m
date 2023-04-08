Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E59936DB9DA
	for <lists+linux-pci@lfdr.de>; Sat,  8 Apr 2023 11:33:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229719AbjDHJdZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 8 Apr 2023 05:33:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjDHJdY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 8 Apr 2023 05:33:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D607AC14A;
        Sat,  8 Apr 2023 02:33:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 73B6261277;
        Sat,  8 Apr 2023 09:33:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8BA8C433EF;
        Sat,  8 Apr 2023 09:33:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680946402;
        bh=1Na8BLaXtLhPBoLxzKdgkj/jz4zip9OEjD2Tn6ZX0ws=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Zi1FXjTgjY4EAhLbkxFoXQGtfDYOBFigzjC/OeVE5bl2jDhvMUPHmbg0SJGrpbN9F
         5gUfRL+LgiVJ21oIZAZLIdTvHS48G0OoQ9BmNvp6xwpZdqvnUcSK9RDeMTq1uWef4+
         i9TvitAd/1XhsxeOPap19OZmIM2M+rLNv+t8NUR52KFKm3Rf1vbutb5Ai3cY+qxOEG
         PmisgCBtiuNe9U4p1FXSVdk/yZq+aW/Qx04r6cOkuWEpvKdvJRPubg+z/AWKMigw74
         7iMOkuAtJNKt3NtteIs1A2QJ3xAF0QKLLQKXCVSfkOFwzc6PWH3ReN7rj+Hfm7e5hY
         HD6IcOwMklWlQ==
Date:   Sat, 8 Apr 2023 15:03:16 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>
Cc:     jdmason@kudzu.us, dave.jiang@intel.com, allenbh@gmail.com,
        lpieralisi@kernel.org, kw@linux.com, kishon@kernel.org,
        bhelgaas@google.com, ntb@lists.linux.dev,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: endpoint: pci-epf-ntb: Add missing check for
 alloc_workqueue
Message-ID: <20230408093316.GE11124@thinkpad>
References: <20230104091601.22719-1-jiasheng@iscas.ac.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230104091601.22719-1-jiasheng@iscas.ac.cn>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jan 04, 2023 at 05:16:01PM +0800, Jiasheng Jiang wrote:
> Add check for the return value of alloc_workqueue since it may return
> NULL pointer.
> 
> Fixes: 8b821cf76150 ("PCI: endpoint: Add EP function driver to provide NTB functionality")
> Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>

Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>

- Mani

> ---
>  drivers/pci/endpoint/functions/pci-epf-ntb.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/pci/endpoint/functions/pci-epf-ntb.c b/drivers/pci/endpoint/functions/pci-epf-ntb.c
> index 9a00448c7e61..304956bc0516 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-ntb.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-ntb.c
> @@ -2124,6 +2124,9 @@ static int __init epf_ntb_init(void)
>  
>  	kpcintb_workqueue = alloc_workqueue("kpcintb", WQ_MEM_RECLAIM |
>  					    WQ_HIGHPRI, 0);
> +	if (!kpcintb_workqueue)
> +		return -ENOMEM;
> +
>  	ret = pci_epf_register_driver(&epf_ntb_driver);
>  	if (ret) {
>  		destroy_workqueue(kpcintb_workqueue);
> -- 
> 2.25.1
> 

-- 
மணிவண்ணன் சதாசிவம்
