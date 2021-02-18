Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F39F831EF48
	for <lists+linux-pci@lfdr.de>; Thu, 18 Feb 2021 20:11:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230263AbhBRTJQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 18 Feb 2021 14:09:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:42840 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232155AbhBRRVh (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 18 Feb 2021 12:21:37 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 26CFE64EAD;
        Thu, 18 Feb 2021 17:20:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613668855;
        bh=r5MkiuheCs61QCnk9rUMSbxTrMxyY9x4PJ7M7Kgiwus=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=FCocjhG9A+ZgONipWtIT/pv6jNFzUG/0Rc0NfiBNcpVD6E4Ax7hM5ORNJtG+ypg97
         uyMPvYw7op5n0H6Y4Lnt8ac4BNR7ERC2Sh13oDh448l5noutLU1+ULxau0WidUKmmN
         pa2YYMN+RgCmEVfD7n2DYWi0NMS+Giy17j0wcRIwVXX12LXRBAnH3xOcNLeLjvAjRx
         +jiNRcMaFYhmZzopkM7RBzkxFVwCyhRa+lX7u/SAJd2agw60AubTRuQzsGI+CMkR5E
         QUOJUuwn3Nv/awc/fZelLG/vk5LutDCMtROJtfmC3EPLVFbzS1vRULqo0KVm984MHV
         7JTUbrI5Sbm6w==
Date:   Thu, 18 Feb 2021 11:20:53 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Yicong Yang <yangyicong@hisilicon.com>
Cc:     linux-pci@vger.kernel.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, kbusch@kernel.org,
        sean.v.kelley@intel.com, qiuxu.zhuo@intel.com,
        prime.zeng@huawei.com, linuxarm@openeuler.org
Subject: Re: [PATCH] PCI/DPC: Disable ERR_COR explicitly for native dpc
 service
Message-ID: <20210218172053.GA986776@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1612356795-32505-2-git-send-email-yangyicong@hisilicon.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Feb 03, 2021 at 08:53:15PM +0800, Yicong Yang wrote:
> Per Downstream Port Containment Related Enhancements ECN[1],
> Table 4-6 Interpretation of _OSC Control Field Returned Value,
> for bit 7 of _OSC control return value:
> 
>   "If firmware allows the OS control of this feature, then,
>   in the context of the _OSC method the OS must ensure that
>   Downstream Port Containment ERR_COR signaling is disabled
>   as described in the PCI Express Base Specification."

I think "the OS must ensure" is a typo in the spec.  In the new r3.3
of the spec, it has been corrected to:

  If firmware allows the operating system control of this feature,
  then, in the context of the _OSC method firmware must clear the DPC
  ERR_COR Enable bit in the DPC Control Register (refer to the PCI
  Express Base Specification) to 0.

> and PCI Express Base Specification Revision 4.0 Version 1.0
> section 6.2.10.2, Use of DPC ERR_COR Signaling:
> 
>   "...DPC ERR_COR signaling is primarily intended for use by
>   platform firmware..."
> 
> Currently we don't set DPC ERR_COR enable bit, but explicitly
> clear the bit to ensure it's disabled.

Does this fix a problem you observed?  If you're seeing a problem, and
this patch fixes it, we need to do something.  But if it's just to
line up with the language in the spec, I think we can rely on the
corrected spec language, which says the *firmware* is responsible for
doing this, and leave dpc_probe() alone.

> [1] Downstream Port Containment Related Enhancements ECN,
>     Jan 28, 2019, affecting PCI Firmware Specification, Rev. 3.2
>     https://members.pcisig.com/wg/PCI-SIG/document/12888
> 
> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
> ---
>  drivers/pci/pcie/dpc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
> index e05aba8..5cc8ef3 100644
> --- a/drivers/pci/pcie/dpc.c
> +++ b/drivers/pci/pcie/dpc.c
> @@ -302,7 +302,7 @@ static int dpc_probe(struct pcie_device *dev)
>  	pci_read_config_word(pdev, pdev->dpc_cap + PCI_EXP_DPC_CAP, &cap);
>  	pci_read_config_word(pdev, pdev->dpc_cap + PCI_EXP_DPC_CTL, &ctl);
>  
> -	ctl = (ctl & 0xfff4) | PCI_EXP_DPC_CTL_EN_FATAL | PCI_EXP_DPC_CTL_INT_EN;
> +	ctl = (ctl & 0xffe4) | PCI_EXP_DPC_CTL_EN_FATAL | PCI_EXP_DPC_CTL_INT_EN;

If we need to clear things here, I'd prefer to have names instead of
the 0xfff4 or 0xffe4 magic numbers.

>  	pci_write_config_word(pdev, pdev->dpc_cap + PCI_EXP_DPC_CTL, ctl);
>  	pci_info(pdev, "enabled with IRQ %d\n", dev->irq);
>  
> -- 
> 2.8.1
> 
