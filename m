Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 949CC27531A
	for <lists+linux-pci@lfdr.de>; Wed, 23 Sep 2020 10:20:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726360AbgIWIUN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 23 Sep 2020 04:20:13 -0400
Received: from foss.arm.com ([217.140.110.172]:39640 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726178AbgIWIUN (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 23 Sep 2020 04:20:13 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 51DB1113E;
        Wed, 23 Sep 2020 01:20:12 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D7B813F718;
        Wed, 23 Sep 2020 01:20:10 -0700 (PDT)
Date:   Wed, 23 Sep 2020 09:20:05 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Alex Dewar <alex.dewar90@gmail.com>
Cc:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Jim Quinlan <jquinlan@broadcom.com>,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] PCI: brcmstb: Add missing if statement and error path
Message-ID: <20200923082005.GA31075@e121166-lin.cambridge.arm.com>
References: <CA+-6iNwJt4zq1fZv5ujsUJqTs_kcvF9iAcLRp6rtQudwm5CfHA@mail.gmail.com>
 <20200921211623.33908-1-alex.dewar90@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200921211623.33908-1-alex.dewar90@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Sep 21, 2020 at 10:16:24PM +0100, Alex Dewar wrote:
> brcm_pcie_resume() contains a return statement that was presumably
> intended to have an "if (ret)" in front of it, otherwise the function
> returns prematurely. Fix this.
> 
> Additionally, redisable the clock on the error path.
> 
> I don't know if this code was tested or not, but I assume that this bug
> means that this driver will not resume properly.
> 
> Fixes: ad3d29c77e1e ("PCI: brcmstb: Add control of rescal reset")
> Addresses-Coverity: CID 1497099: Control flow issues (UNREACHABLE)
> Signed-off-by: Alex Dewar <alex.dewar90@gmail.com>
> ---
> Hi Jim,
> 
> Here's a new version of the patch.
> 
> I added the missing clk_disable_unprepare() and assumed that it would
> also be required in the case that the call to brcm_pcie_setup() fails.
> 
> I didn't follow the suggestion of adding extra braces to the
> if-statement as the kernel style is not to add unnecessary braces in
> this case: https://www.kernel.org/doc/html/latest/process/coding-style.html?highlight=style#placing-braces-and-spaces
> 
> Best,
> Alex
> 
>  drivers/pci/controller/pcie-brcmstb.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)

Squashed in the original patch, pushed out in my pci/brcmstb branch,
I will drop Colin's patch following this discussion. If there is
any issue please shout, thanks.

Lorenzo

> diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
> index 7a3ff4632e7c..8bae3a4f8e49 100644
> --- a/drivers/pci/controller/pcie-brcmstb.c
> +++ b/drivers/pci/controller/pcie-brcmstb.c
> @@ -1154,7 +1154,8 @@ static int brcm_pcie_resume(struct device *dev)
>  	clk_prepare_enable(pcie->clk);
>  
>  	ret = brcm_phy_start(pcie);
> -		return ret;
> +	if (ret)
> +		goto err;
>  
>  	/* Take bridge out of reset so we can access the SERDES reg */
>  	pcie->bridge_sw_init_set(pcie, 0);
> @@ -1169,12 +1170,16 @@ static int brcm_pcie_resume(struct device *dev)
>  
>  	ret = brcm_pcie_setup(pcie);
>  	if (ret)
> -		return ret;
> +		goto err;
>  
>  	if (pcie->msi)
>  		brcm_msi_set_regs(pcie->msi);
>  
>  	return 0;
> +
> +err:
> +	clk_disable_unprepare(pcie->clk);
> +	return ret;
>  }
>  
>  static void __brcm_pcie_remove(struct brcm_pcie *pcie)
> -- 
> 2.28.0
> 
