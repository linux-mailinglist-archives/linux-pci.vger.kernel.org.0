Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE3A34C2FF7
	for <lists+linux-pci@lfdr.de>; Thu, 24 Feb 2022 16:37:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236447AbiBXPiA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Feb 2022 10:38:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236472AbiBXPh5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 24 Feb 2022 10:37:57 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 60E031045B1
        for <linux-pci@vger.kernel.org>; Thu, 24 Feb 2022 07:37:27 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2A804ED1;
        Thu, 24 Feb 2022 07:37:27 -0800 (PST)
Received: from lpieralisi (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5EE753F66F;
        Thu, 24 Feb 2022 07:37:26 -0800 (PST)
Date:   Thu, 24 Feb 2022 15:37:21 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>
Cc:     pali@kernel.org, linux-pci@vger.kernel.org,
        Vinod Koul <vkoul@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: Re: [PATCH phy v4 5/5] Revert "PCI: aardvark: Fix initialization
 with old Marvell's Arm Trusted Firmware"
Message-ID: <20220224153720.GA5579@lpieralisi>
References: <20220224151718.7679-1-kabel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220224151718.7679-1-kabel@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Feb 24, 2022 at 04:17:18PM +0100, Marek Behún wrote:
> From: Pali Rohár <pali@kernel.org>
> 
> This reverts commit b0c6ae0f8948a2be6bf4e8b4bbab9ca1343289b6.
> 
> Armada 3720 phy driver (phy-mvebu-a3700-comphy.c) does not return
> -EOPNOTSUPP from phy_power_on() callback anymore.
> 
> So remove dead code which handles -EOPNOTSUPP return value.
> 
> Signed-off-by: Pali Rohár <pali@kernel.org>
> Signed-off-by: Marek Behún <kabel@kernel.org>
> Acked-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
> Dear Lorenzo,
> 
> could you please give your Ack for this, so that Vinod can apply it
> with the rest of the comphy series?
> The series can be found at
>   https://lore.kernel.org/linux-phy/20220203214444.1508-1-kabel@kernel.org/
> 
> Marek
> ---
>  drivers/pci/controller/pci-aardvark.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)

Acked-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

> diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
> index 4f5b44827d21..6bae688852a5 100644
> --- a/drivers/pci/controller/pci-aardvark.c
> +++ b/drivers/pci/controller/pci-aardvark.c
> @@ -1482,9 +1482,7 @@ static int advk_pcie_enable_phy(struct advk_pcie *pcie)
>  	}
>  
>  	ret = phy_power_on(pcie->phy);
> -	if (ret == -EOPNOTSUPP) {
> -		dev_warn(&pcie->pdev->dev, "PHY unsupported by firmware\n");
> -	} else if (ret) {
> +	if (ret) {
>  		phy_exit(pcie->phy);
>  		return ret;
>  	}
> -- 
> 2.34.1
> 
