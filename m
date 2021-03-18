Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D81C2340CD8
	for <lists+linux-pci@lfdr.de>; Thu, 18 Mar 2021 19:23:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232216AbhCRSXP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 18 Mar 2021 14:23:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:40376 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232361AbhCRSXD (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 18 Mar 2021 14:23:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 07F5664DFF;
        Thu, 18 Mar 2021 18:23:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616091783;
        bh=sXISo4PQDYozWK3fHjEB01FxcE4xjmd31yUdATknSHQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=c1Hg6KJdZUPFO+8amgDpFBICHBW3D7yXRO8aGyH5Zvw3xIvjZxbKpuwFBaebaciPw
         MPKYFTX5ZtWpAhYEL/L5gFdIkmhOvMfZn75/4dU9sNAdFUviiE+DHZwhxiFk4jp4RJ
         /w2SXiN6p5B5W3gK79sXWfvgQB7GHxBNnDakr7B7A9sMVcrjLImePQnGftNH4TuSby
         TQAiEr0nfpWma47VZYN/vi5rqSvIiX7mtfRkPi3Kl0eKrcoE1aDiUDDC0lpBL+zug6
         O/ZFD5RbT0HungY4MRNPFNXWUON4OIxtfWT4k+9Y5MJO6eqGyFRjDhPyIVyYaKv/tk
         T7mwchViYpAMQ==
Date:   Thu, 18 Mar 2021 13:23:01 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Cc:     Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND] PCI: dwc: Fix MSI not work after resume
Message-ID: <20210318182301.GA158400@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210301111031.220a38b8@xhacker.debian>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Mar 01, 2021 at 11:10:31AM +0800, Jisheng Zhang wrote:
> After we move dw_pcie_msi_init() into core -- dw_pcie_host_init(), the
> MSI stops working after resume. Because dw_pcie_host_init() is only
> called once during probe. To fix this issue, we move dw_pcie_msi_init()
> to dw_pcie_setup_rc().
> 
> Fixes: 59fbab1ae40e ("PCI: dwc: Move dw_pcie_msi_init() into core")
> Reviewed-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>

Oops, sorry, looks like this fell through the cracks.  Since
59fbab1ae40e appeared in v5.11, I think we should add:

  Cc: stable@vger.kernel.org	# v5.11+

I'm sure Lorenzo will add it when applying, so no need to repost just
for that.

> ---
> Since v1:
>  - collect Reviewed-by tag
> 
>  drivers/pci/controller/dwc/pcie-designware-host.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index 7e55b2b66182..e6c274f4485c 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -400,7 +400,6 @@ int dw_pcie_host_init(struct pcie_port *pp)
>  	}
>  
>  	dw_pcie_setup_rc(pp);
> -	dw_pcie_msi_init(pp);
>  
>  	if (!dw_pcie_link_up(pci) && pci->ops && pci->ops->start_link) {
>  		ret = pci->ops->start_link(pci);
> @@ -551,6 +550,8 @@ void dw_pcie_setup_rc(struct pcie_port *pp)
>  		}
>  	}
>  
> +	dw_pcie_msi_init(pp);
> +
>  	/* Setup RC BARs */
>  	dw_pcie_writel_dbi(pci, PCI_BASE_ADDRESS_0, 0x00000004);
>  	dw_pcie_writel_dbi(pci, PCI_BASE_ADDRESS_1, 0x00000000);
> -- 
> 2.30.1
> 
