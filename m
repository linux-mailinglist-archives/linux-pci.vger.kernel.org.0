Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30D786DB9CF
	for <lists+linux-pci@lfdr.de>; Sat,  8 Apr 2023 11:23:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229457AbjDHJX0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 8 Apr 2023 05:23:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjDHJXZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 8 Apr 2023 05:23:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79ACD44AA;
        Sat,  8 Apr 2023 02:23:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 145DC611AA;
        Sat,  8 Apr 2023 09:23:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13DD0C4339B;
        Sat,  8 Apr 2023 09:23:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680945803;
        bh=YjH2Go6xcqqP+wyvMBuRxxTe01duxRbcpjxWyjTUeBg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XcTxkGTbVNTckxRaZTgohCEnIRrJoG4D7swj0KAJL7MLKMvwisJczdGzI46tuwagB
         EnI2ZCW8XOH3jEVrgWT6vmz/dTPnHNPk0J3dO6KBxDk1uDYKDaZp7vUaEUfOXToGzr
         gzLGEZH6ZcURFnEP4Bn/Pss8zT46PNIL+UB4LWPYLKOK1+wIOdAUGrAtwwJXQMJXlO
         VvR5lJMvcAahpEpBjTVRCycqQlJhYKAsnWqqs+mB9krPByBQbwgTZfOu0mPThAAhIG
         zTkG/uk3D0htFMncaGZR0R7LKrgXMwtpPy+DbrOfpg/H4Tr3HrjN3Ek4NwT4f0tVNZ
         YNSHUtK6tZiVw==
Date:   Sat, 8 Apr 2023 14:53:16 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        jdmason@kudzu.us, dave.jiang@intel.com, allenbh@gmail.com,
        lpieralisi@kernel.org, kw@linux.com, kishon@kernel.org,
        bhelgaas@google.com, helgaas@kernel.org, Frank.Li@nxp.com
Subject: Re: [PATCH] PCI: endpoint: pci-epf-vntb: fix doc warnings in
 pci-epf-vntb.c
Message-ID: <20230408092316.GC11124@thinkpad>
References: <20221214062617.2210218-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221214062617.2210218-1-yangyingliang@huawei.com>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Dec 14, 2022 at 02:26:17PM +0800, Yang Yingliang wrote:
> Fix the following make W=1 warnings:
> 
>   drivers/pci/endpoint/functions/pci-epf-vntb.c:338: warning: Function parameter or member 'ntb' not described in 'epf_ntb_config_sspad_bar_clear'
>   drivers/pci/endpoint/functions/pci-epf-vntb.c:338: warning: Excess function parameter 'ntb_epc' description in 'epf_ntb_config_sspad_bar_clear'
>   drivers/pci/endpoint/functions/pci-epf-vntb.c:645: warning: Function parameter or member 'num_mws' not described in 'epf_ntb_mw_bar_clear'
> 
> Fixes: 8e4bfbe644a6 ("PCI: endpoint: pci-epf-vntb: fix error handle in epf_ntb_mw_bar_init()")
> Fixes: e35f56bb0330 ("PCI: endpoint: Support NTB transfer between RC and EP")
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>

Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>

- Mani

> ---
>  drivers/pci/endpoint/functions/pci-epf-vntb.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> index 0ea85e1d292e..9e3a21c9debe 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> @@ -321,7 +321,7 @@ static void epf_ntb_cmd_handler(struct work_struct *work)
>  
>  /**
>   * epf_ntb_config_sspad_bar_clear() - Clear Config + Self scratchpad BAR
> - * @ntb_epc: EPC associated with one of the HOST which holds peer's outbound
> + * @ntb: EPC associated with one of the HOST which holds peer's outbound
>   *	     address.
>   *
>   * Clear BAR0 of EP CONTROLLER 1 which contains the HOST1's config and
> @@ -640,6 +640,7 @@ static int epf_ntb_mw_bar_init(struct epf_ntb *ntb)
>  /**
>   * epf_ntb_mw_bar_clear() - Clear Memory window BARs
>   * @ntb: NTB device that facilitates communication between HOST and vHOST
> + * @num_mws: the number of Memory window BARs that to be cleared
>   */
>  static void epf_ntb_mw_bar_clear(struct epf_ntb *ntb, int num_mws)
>  {
> -- 
> 2.25.1
> 

-- 
மணிவண்ணன் சதாசிவம்
