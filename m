Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E9C561942B7
	for <lists+linux-pci@lfdr.de>; Thu, 26 Mar 2020 16:12:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727502AbgCZPMI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 26 Mar 2020 11:12:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:37542 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726496AbgCZPMI (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 26 Mar 2020 11:12:08 -0400
Received: from localhost (mobile-166-175-186-165.mycingular.net [166.175.186.165])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9991E206F8;
        Thu, 26 Mar 2020 15:12:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585235528;
        bh=gNmb1UwpI1bot54AGT9LmV+Ay1kJtk9PvnEvdt7OJfc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=HswQ9GU3pelOso6U3R+842+f+BEsJtKi+asi1ius/Kpn2ivVMGAkMxQdfx4AdmRWL
         OXIpK3kwBDOOPY60j6YQgGoDi/R1l/B3W2qIVR2ZIZhJqacpgQuvx/Hur4AJIK+DoY
         froEyzgClLoLaQL8Y/qmAtHqp2GIHJ1KQZMKnUFw=
Date:   Thu, 26 Mar 2020 10:12:05 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Srinath Mannam <srinath.mannam@broadcom.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Andrew Murray <andrew.murray@arm.com>,
        bcm-kernel-feedback-list@broadcom.com, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] PCI: iproc: Display PCIe Link information
Message-ID: <20200326151205.GA6837@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1585206447-1363-4-git-send-email-srinath.mannam@broadcom.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Mar 26, 2020 at 12:37:27PM +0530, Srinath Mannam wrote:
> Add more comprehensive information to show PCIe link speed and link
> width to the console.
> 
> Signed-off-by: Srinath Mannam <srinath.mannam@broadcom.com>
> ---
>  drivers/pci/controller/pcie-iproc.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/pcie-iproc.c b/drivers/pci/controller/pcie-iproc.c
> index e7f0d58..ed41357 100644
> --- a/drivers/pci/controller/pcie-iproc.c
> +++ b/drivers/pci/controller/pcie-iproc.c
> @@ -823,6 +823,8 @@ static int iproc_pcie_check_link(struct iproc_pcie *pcie)
>  #define PCI_TARGET_LINK_SPEED_MASK	0xf
>  #define PCI_TARGET_LINK_SPEED_GEN2	0x2
>  #define PCI_TARGET_LINK_SPEED_GEN1	0x1
> +#define PCI_TARGET_LINK_WIDTH_MASK	0x3f
> +#define PCI_TARGET_LINK_WIDTH_OFFSET	0x4
>  		iproc_pci_raw_config_read32(pcie, 0,
>  					    IPROC_PCI_EXP_CAP + PCI_EXP_LNKCTL2,
>  					    4, &link_ctrl);
> @@ -843,7 +845,14 @@ static int iproc_pcie_check_link(struct iproc_pcie *pcie)
>  		}
>  	}
>  
> -	dev_info(dev, "link: %s\n", link_is_active ? "UP" : "DOWN");
> +	if (link_is_active) {
> +		dev_info(dev, "link UP @ Speed Gen-%d and width-x%d\n",
> +			 link_status & PCI_TARGET_LINK_SPEED_MASK,
> +			 (link_status >> PCI_TARGET_LINK_WIDTH_OFFSET) &
> +			 PCI_TARGET_LINK_WIDTH_MASK);

Can you use pcie_print_link_status() or some variant here instead of
rolling your own?

> +	} else {
> +		dev_info(dev, "link DOWN\n");
> +	}
>  
>  	return link_is_active ? 0 : -ENODEV;
>  }
> -- 
> 2.7.4
> 
