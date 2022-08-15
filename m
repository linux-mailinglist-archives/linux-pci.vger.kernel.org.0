Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C63335939AD
	for <lists+linux-pci@lfdr.de>; Mon, 15 Aug 2022 21:34:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243957AbiHOT2R (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 15 Aug 2022 15:28:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343775AbiHOT0O (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 15 Aug 2022 15:26:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D81C52ED58;
        Mon, 15 Aug 2022 11:41:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 56C65611C2;
        Mon, 15 Aug 2022 18:41:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EF31C433C1;
        Mon, 15 Aug 2022 18:41:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660588903;
        bh=IXMwntOfMMG69rLS3fgGLcQBvXemm6MxdOrUbCxYe7I=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=WLWP46DEf1eTmq2N8bORpL8r54qXucaoOFzO7m+O3S/a9jGAIRagoDdhNFnrA1sfa
         RybdRdLuDvrl/p5iUwVLa+eno2T7Zcq7fcHfph2bPXfApLlkgYjmC6naIU7yJgyeVY
         kI5U4tfB7RztOVB/1WIN2/Mp+B4fy4/SZy9i5f1uQi3UuSmaXO3gjBZmy1IbpaseC8
         poVpLnBLLTUC4Z62jeV+BvpZ8iUr+cbdYE43dtyLMrUPA1j+voZc1FHegKoYt3b0Ko
         21Db4vUO/pPXC5bEDUPNCihkIJrRLnWq/iAQfjU02lMHTA3B3OImF8BZecG6b7aCLA
         R/Fri/jzw3/Gw==
Date:   Mon, 15 Aug 2022 13:41:42 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Shunsuke Mie <mie@igel.co.jp>
Cc:     Jon Mason <jdmason@kudzu.us>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Frank Li <Frank.Li@nxp.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Ren Zhijie <renzhijie2@huawei.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: endpoint: fix Kconfig indent style
Message-ID: <20220815184142.GA1960338@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220815025006.48167-1-mie@igel.co.jp>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Aug 15, 2022 at 11:50:06AM +0900, Shunsuke Mie wrote:
> Change to follow the Kconfig style guide. This patch fixes to use tab
> rather than space to indent, while help text is indented an additional
> two spaces.
> 
> Fixes: e35f56bb0330 ("PCI: endpoint: Support NTB transfer between RC and EP")
> Signed-off-by: Shunsuke Mie <mie@igel.co.jp>

Thanks for doing this.  In the future make the subject line match the
history, e.g.,

  $ git log --oneline drivers/pci/endpoint/functions/Kconfig
  556a2c7dca33 ("PCI: endpoint: Fix Kconfig dependency")
  e35f56bb0330 ("PCI: endpoint: Support NTB transfer between RC and EP")
  8b821cf76150 ("PCI: endpoint: Add EP function driver to provide NTB functionality")
  98dbf5af4fdd ("PCI: endpoint: Select CRC32 to fix test build error")
  349e7a85b25f ("PCI: endpoint: functions: Add an EP function to test PCI")

Note that these are all capitalized ("Fix Kconfig indent style").

Lorenzo will likely fix this up when applying, so no need to repost
for this.

> ---
>  drivers/pci/endpoint/functions/Kconfig | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/pci/endpoint/functions/Kconfig b/drivers/pci/endpoint/functions/Kconfig
> index 295a033ee9a2..9fd560886871 100644
> --- a/drivers/pci/endpoint/functions/Kconfig
> +++ b/drivers/pci/endpoint/functions/Kconfig
> @@ -27,13 +27,13 @@ config PCI_EPF_NTB
>  	  If in doubt, say "N" to disable Endpoint NTB driver.
>  
>  config PCI_EPF_VNTB
> -        tristate "PCI Endpoint NTB driver"
> -        depends on PCI_ENDPOINT
> -        depends on NTB
> -        select CONFIGFS_FS
> -        help
> -          Select this configuration option to enable the Non-Transparent
> -          Bridge (NTB) driver for PCIe Endpoint. NTB driver implements NTB
> -          between PCI Root Port and PCIe Endpoint.
> +	tristate "PCI Endpoint NTB driver"
> +	depends on PCI_ENDPOINT
> +	depends on NTB
> +	select CONFIGFS_FS
> +	help
> +	  Select this configuration option to enable the Non-Transparent
> +	  Bridge (NTB) driver for PCIe Endpoint. NTB driver implements NTB
> +	  between PCI Root Port and PCIe Endpoint.
>  
> -          If in doubt, say "N" to disable Endpoint NTB driver.
> +	  If in doubt, say "N" to disable Endpoint NTB driver.
> -- 
> 2.17.1
> 
