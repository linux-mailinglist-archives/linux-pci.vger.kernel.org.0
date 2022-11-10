Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 947A76245E3
	for <lists+linux-pci@lfdr.de>; Thu, 10 Nov 2022 16:31:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229958AbiKJPbJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 10 Nov 2022 10:31:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230480AbiKJPad (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 10 Nov 2022 10:30:33 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD7B04044F;
        Thu, 10 Nov 2022 07:29:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5E7DBB82192;
        Thu, 10 Nov 2022 15:29:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53EA3C433C1;
        Thu, 10 Nov 2022 15:28:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668094143;
        bh=b1tXEdAkG7FjFwcJznZTpiZu17tiittNuwu2BIgCp3U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qe4srMJqydGdXXK1KXUKd7JrqnhJl+z0eatx1nK/Ecm/ErzRKIS2BZ2ZwhyJeYTmx
         veW26JSCd1QjWQ+7gg7hzR6tIL5G+55ALlPVG8UoECvZPlhle1wzIQnPg9/FCAVebR
         YG/egHpEtYw//zAAEAn1iwpWPWMkAoEPDa+68OCO4JeCfNnVudn6I21uPPm7aQvslK
         2UGnzEOE962gsPkRoPna2uLi2tfTWK5wp83ng45xYY+Une/tX6H1/D6jXOaAZo2ur0
         rmJ8EoX5WvRGX8yDfvpJQyDktWOpmEYPFGhIREsGwb/iEXsLARwqMlP/BD54FVDkbv
         jQkVymI/2wczg==
Date:   Thu, 10 Nov 2022 16:28:55 +0100
From:   Lorenzo Pieralisi <lpieralisi@kernel.org>
To:     Frank Li <Frank.Li@nxp.com>
Cc:     mani@kernel.org, allenbh@gmail.com, bhelgaas@google.com,
        dave.jiang@intel.com, helgaas@kernel.org, imx@lists.linux.dev,
        jdmason@kudzu.us, kw@linux.com, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, ntb@lists.linux.dev
Subject: Re: [PATCH v16 4/7] PCI: endpoint: pci-epf-vntb: remove unused field
 epf_db_phy
Message-ID: <Y20Yt7T0bivqUvop@lpieralisi>
References: <20221102141014.1025893-1-Frank.Li@nxp.com>
 <20221102141014.1025893-5-Frank.Li@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221102141014.1025893-5-Frank.Li@nxp.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Nov 02, 2022 at 10:10:11AM -0400, Frank Li wrote:
> From: Frank Li <frank.li@nxp.com>
> 
> epf_db_phy is not used, so remove it

Sentences end with a period (.). I can fix these things but
we can't spend our lives telling you how to write a commit log,
check how they are written in the PCI subsystem and follow the
pattern.

https://lore.kernel.org/all/20171026223701.GA25649@bhelgaas-glaptop.roam.corp.google.com

> 
> Signed-off-by: Frank Li <frank.li@nxp.com>
> Acked-by: Manivannan Sadhasivam <mani@kernel.org>
> ---
>  drivers/pci/endpoint/functions/pci-epf-vntb.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> index 191924a83454..ee66101cb5c4 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> @@ -136,7 +136,6 @@ struct epf_ntb {
>  
>  	struct epf_ntb_ctrl *reg;
>  
> -	phys_addr_t epf_db_phy;
>  	void __iomem *epf_db;
>  
>  	phys_addr_t vpci_mw_phy[MAX_MW];
> -- 
> 2.34.1
> 
