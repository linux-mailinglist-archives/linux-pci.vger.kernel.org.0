Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D9EE6DB9CD
	for <lists+linux-pci@lfdr.de>; Sat,  8 Apr 2023 11:19:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229516AbjDHJT4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 8 Apr 2023 05:19:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjDHJTz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 8 Apr 2023 05:19:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54D7ECA22;
        Sat,  8 Apr 2023 02:19:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DDDFF60C6B;
        Sat,  8 Apr 2023 09:19:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5971BC433EF;
        Sat,  8 Apr 2023 09:19:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680945593;
        bh=OA/izTH3fkHkNUUFqMpgAfOwRFv6ZGz7GZeLURg1iO8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=h1j809D1K4o2/4Ak8mJs772bM4LNId6YQSuBuoRfqhLBMRXw69af13fyMzkPRk78C
         sqEfqxqcNbteHr0PR98dHVapDp2fWtmaC0JlACQFvQaXb7sTxCUkHwj6KdP9BEIYIF
         WrnbIguZpuds8H7YwBf2Ch2YLsck0cT+y2/+O9EhQ43wpmf9EafYljIHkWtf44CxPj
         ykb+OT15A2KxWPro1Vu8jFKAP5FMER9piPjKupQajmKSdpsVk9OnhZsYPSgQQ+AwIw
         D+UXiecp8TJpts/BrCZn1gGsD+lFDSzjThi/AAOLUt0oj35jwc29VeePU7i9JqNb/v
         aIj3mBhX0iiRw==
Date:   Sat, 8 Apr 2023 14:49:45 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Shunsuke Mie <mie@igel.co.jp>
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jon Mason <jdmason@kudzu.us>, Frank Li <Frank.Li@nxp.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Ren Zhijie <renzhijie2@huawei.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: endpoint: Fix a Kconfig prompt of vNTB driver
Message-ID: <20230408091945.GB11124@thinkpad>
References: <20230202103832.2038286-1-mie@igel.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230202103832.2038286-1-mie@igel.co.jp>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Feb 02, 2023 at 07:38:32PM +0900, Shunsuke Mie wrote:
> vNTB driver and NTB driver have same Kconfig prompt. Changed to make it
> distinguishable.
> 
> Fixes: e35f56bb0330 ("PCI: endpoint: Support NTB transfer between RC and EP")
> 
> Signed-off-by: Shunsuke Mie <mie@igel.co.jp>

Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>

- Mani

> ---
>  drivers/pci/endpoint/functions/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/endpoint/functions/Kconfig b/drivers/pci/endpoint/functions/Kconfig
> index 9fd560886871..8efb6a869e7c 100644
> --- a/drivers/pci/endpoint/functions/Kconfig
> +++ b/drivers/pci/endpoint/functions/Kconfig
> @@ -27,7 +27,7 @@ config PCI_EPF_NTB
>  	  If in doubt, say "N" to disable Endpoint NTB driver.
>  
>  config PCI_EPF_VNTB
> -	tristate "PCI Endpoint NTB driver"
> +	tristate "PCI Endpoint Virtual NTB driver"
>  	depends on PCI_ENDPOINT
>  	depends on NTB
>  	select CONFIGFS_FS
> -- 
> 2.25.1
> 

-- 
மணிவண்ணன் சதாசிவம்
