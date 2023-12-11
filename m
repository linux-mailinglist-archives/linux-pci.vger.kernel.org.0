Return-Path: <linux-pci+bounces-758-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6496180DB44
	for <lists+linux-pci@lfdr.de>; Mon, 11 Dec 2023 21:07:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CD93DB21510
	for <lists+linux-pci@lfdr.de>; Mon, 11 Dec 2023 20:07:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1884053810;
	Mon, 11 Dec 2023 20:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fKunPx2/"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1CC652F9C
	for <linux-pci@vger.kernel.org>; Mon, 11 Dec 2023 20:07:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 303FDC433CC;
	Mon, 11 Dec 2023 20:07:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702325242;
	bh=LKeHZBb6JKYAmHddd83S8bgUsHx/KGnr+Nj4UjhnTOA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=fKunPx2/y1lVcA5+0696r1ULEr8fkc8usfCXm6B2wFFt3P1g2pWlXA7p5YnY3lkTO
	 Z9vlROguNMK6BCBlFEna8tZM9nkz3gADukNqc0rFB3zKF7YSIUHXouvm7hgEwpJOGS
	 7CDlzSGYCF0LZLSeoN9m9vZCv2OABY9i+dgZqpAcJjmY5fekO8XrMrYGT+PXhm1taA
	 eqS33bun+3bNCpBSczM/v3LFyDhhqOLzA6D4HKIIg0vBaRXBxDDGFiJrD33o5rRMru
	 +H7hKxiMxLp9oDRkKOtdbpXaVyCDSDoVheo0Vur9YS0dLdpoHCKQjFfu0jA6ICK4hP
	 9zhAgcCmSLnPw==
Date: Mon, 11 Dec 2023 14:07:19 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: LeoLiu-oc <LeoLiu-oc@zhaoxin.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, CobeChen@zhaoxin.com,
	TonyWWang@zhaoxin.com, YeeLi@zhaoxin.com, Leoliu@zhaoxin.com
Subject: Re: [PATCH v2] PCI: Extend PCI root port device IDs for Zhaoxin
 platforms
Message-ID: <20231211200719.GA964402@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231211091543.735903-1-LeoLiu-oc@zhaoxin.com>

On Mon, Dec 11, 2023 at 05:15:43PM +0800, LeoLiu-oc wrote:
> From: LeoLiuoc <LeoLiu-oc@zhaoxin.com>
> 
> Add more PCI root port device IDs to the
> pci_quirk_zhaoxin_pcie_ports_acs() for some new Zhaoxin platforms.
> 
> v1 -> v2:
> 1. Add a note to indicate future Zhaoxin devices will implement ACS
> Capability based on the PCIe Spec.
> 2. Includes DID of more Zhaoxin devices that have not yet implemented ACS
> Capability.
> 
> Signed-off-by: LeoLiuoc <LeoLiu-oc@zhaoxin.com>

Applied as below to pci/virtualization for v6.8, thanks!

This extends 299bd044a6f3 ("PCI: Add ACS quirk for Zhaoxin
Root/Downstream Ports"), so I made the subject similar to that, added
a Fixes: line for it, and added a stable tag.

> ---
>  drivers/pci/quirks.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index ea476252280a..f4546590d9e3 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -4706,10 +4706,14 @@ static int  pci_quirk_zhaoxin_pcie_ports_acs(struct pci_dev *dev, u16 acs_flags)
>  	     (pci_pcie_type(dev) != PCI_EXP_TYPE_DOWNSTREAM)))
>  		return -ENOTTY;
>  
> +	/*
> +	 * Future Zhaoxin Root Ports and Switch Downstream Ports will implement ACS
> +	 * capability in accordance with the PCIe Spec.
> +	 */
>  	switch (dev->device) {
>  	case 0x0710 ... 0x071e:
>  	case 0x0721:
> -	case 0x0723 ... 0x0732:
> +	case 0x0723 ... 0x0752:
>  		return pci_acs_ctrl_enabled(acs_flags,
>  			PCI_ACS_SV | PCI_ACS_RR | PCI_ACS_CR | PCI_ACS_UF);
>  	}
> 

commit e367e3c765f5 ("PCI: Add ACS quirk for more Zhaoxin Root Ports")
Author: LeoLiuoc <LeoLiu-oc@zhaoxin.com>
Date:   Mon Dec 11 17:15:43 2023 +0800

    PCI: Add ACS quirk for more Zhaoxin Root Ports
    
    Add more Root Port Device IDs to pci_quirk_zhaoxin_pcie_ports_acs() for
    some new Zhaoxin platforms.
    
    Fixes: 299bd044a6f3 ("PCI: Add ACS quirk for Zhaoxin Root/Downstream Ports")
    Link: https://lore.kernel.org/r/20231211091543.735903-1-LeoLiu-oc@zhaoxin.com
    Signed-off-by: LeoLiuoc <LeoLiu-oc@zhaoxin.com>
    [bhelgaas: update subject, drop changelog, add Fixes, add stable tag, fix
    whitespace, wrap code comment]
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
    Cc: <stable@vger.kernel.org>	# 5.7


diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index ea476252280a..d55a3ffae4b8 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -4699,17 +4699,21 @@ static int pci_quirk_xgene_acs(struct pci_dev *dev, u16 acs_flags)
  * But the implementation could block peer-to-peer transactions between them
  * and provide ACS-like functionality.
  */
-static int  pci_quirk_zhaoxin_pcie_ports_acs(struct pci_dev *dev, u16 acs_flags)
+static int pci_quirk_zhaoxin_pcie_ports_acs(struct pci_dev *dev, u16 acs_flags)
 {
 	if (!pci_is_pcie(dev) ||
 	    ((pci_pcie_type(dev) != PCI_EXP_TYPE_ROOT_PORT) &&
 	     (pci_pcie_type(dev) != PCI_EXP_TYPE_DOWNSTREAM)))
 		return -ENOTTY;
 
+	/*
+	 * Future Zhaoxin Root Ports and Switch Downstream Ports will
+	 * implement ACS capability in accordance with the PCIe Spec.
+	 */
 	switch (dev->device) {
 	case 0x0710 ... 0x071e:
 	case 0x0721:
-	case 0x0723 ... 0x0732:
+	case 0x0723 ... 0x0752:
 		return pci_acs_ctrl_enabled(acs_flags,
 			PCI_ACS_SV | PCI_ACS_RR | PCI_ACS_CR | PCI_ACS_UF);
 	}

