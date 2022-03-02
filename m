Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0C7A4CAF75
	for <lists+linux-pci@lfdr.de>; Wed,  2 Mar 2022 21:14:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231761AbiCBUOq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 2 Mar 2022 15:14:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbiCBUOp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 2 Mar 2022 15:14:45 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 596337E090
        for <linux-pci@vger.kernel.org>; Wed,  2 Mar 2022 12:14:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 11FCDB82161
        for <linux-pci@vger.kernel.org>; Wed,  2 Mar 2022 20:14:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88DA1C004E1;
        Wed,  2 Mar 2022 20:13:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646252039;
        bh=J/y80A8ZgC/MaxL5IxHjbAOaU/PKJTX0fRyI8c9SHYQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=bmy9cYckWlp/P5iAYolxs/8EYlwDRlXib2R4RMwiBYFIoVXB6xO3ZuUnaPWOQlrq/
         zFQi44gMdcfyu0pZbg4nBWjvbQAt2xLSD3XvuZRIph8StuuWAzxiMscQrhPuEKBwxy
         1DdF/g0QTOodGuYQrHxxxDFeDtC3l9NarcX4IFRbzKE9gUayEM0GQ9hfxLdUdCtvCf
         agg6ZZt0AiJYGmIDrMC15B6FUx8osBCh77RrItVN/NOslcQMavZcxS953bA7vMHe1p
         ASNBt/0JaoCOpf2NW2VTMZfZICILUGcyZD7Pizynww9rpJSD7ir2SF1NfAX66ekypr
         0JT0cEBNl6snA==
Date:   Wed, 2 Mar 2022 14:13:56 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Yicong Yang <yangyicong@hisilicon.com>
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org, linuxarm@huawei.com
Subject: Re: [PATCH] PCI/AER: Update the link to the aer-inject tool
Message-ID: <20220302201356.GA746983@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220115104921.21606-1-yangyicong@hisilicon.com>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Jan 15, 2022 at 06:49:21PM +0800, Yicong Yang wrote:
> The link to the aer-inject referenced leads to an empty repo
> and seems no longer used. Replace it with the link mentioned
> in Documentation/PCI/pcieaer-howto.rst.
> 
> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>

Applied to pci/misc for v5.18, thanks!

> ---
>  drivers/pci/pcie/Kconfig      | 2 +-
>  drivers/pci/pcie/aer_inject.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/pcie/Kconfig b/drivers/pci/pcie/Kconfig
> index 45a2ef702b45..788ac8df3f9d 100644
> --- a/drivers/pci/pcie/Kconfig
> +++ b/drivers/pci/pcie/Kconfig
> @@ -43,7 +43,7 @@ config PCIEAER_INJECT
>  	  error injection can fake almost all kinds of errors with the
>  	  help of a user space helper tool aer-inject, which can be
>  	  gotten from:
> -	     https://www.kernel.org/pub/linux/utils/pci/aer-inject/
> +	     https://git.kernel.org/cgit/linux/kernel/git/gong.chen/aer-inject.git/
>  
>  #
>  # PCI Express ECRC
> diff --git a/drivers/pci/pcie/aer_inject.c b/drivers/pci/pcie/aer_inject.c
> index 767f8859b99b..2dab275d252f 100644
> --- a/drivers/pci/pcie/aer_inject.c
> +++ b/drivers/pci/pcie/aer_inject.c
> @@ -6,7 +6,7 @@
>   * trigger various real hardware errors. Software based error
>   * injection can fake almost all kinds of errors with the help of a
>   * user space helper tool aer-inject, which can be gotten from:
> - *   https://www.kernel.org/pub/linux/utils/pci/aer-inject/
> + *   https://git.kernel.org/cgit/linux/kernel/git/gong.chen/aer-inject.git/
>   *
>   * Copyright 2009 Intel Corporation.
>   *     Huang Ying <ying.huang@intel.com>
> -- 
> 2.24.0
> 
