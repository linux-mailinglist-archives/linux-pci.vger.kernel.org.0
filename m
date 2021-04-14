Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 071FA35FCD4
	for <lists+linux-pci@lfdr.de>; Wed, 14 Apr 2021 22:45:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234129AbhDNUpc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 14 Apr 2021 16:45:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:52450 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233093AbhDNUpc (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 14 Apr 2021 16:45:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1B30161074;
        Wed, 14 Apr 2021 20:45:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618433110;
        bh=JX3xsI+XANgtBxpkB7G2Z/Gaw8lu/CAgqgZB6yYmDxI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=oK8nX9zj1lXIQhKN5e7wqCSXrVAf9jgw0ig5MVuFPZfnhh+szvqkQ02fmcOvE8n+M
         F1kYM9OyLd3dG88CUYjbGEEDo/HNmc1wiFWkgFPa6Xr5XcsLnMncgbJuNo2qB2lflK
         wpZ9ad4V97xBX6jWxQZ5OYhESHNyd7EiXf0DNtCmwhNtqck3G2bP374xC6bUvyqKfu
         jCzho9Tb6ddq3NDP/2DhxPs3nID1r25SgKiVqqGl3Mci1Tmw9Ph1ihRIgoXURxHb7c
         BPxiIl9c1W0PRdsRWwrltoOQSj2cAAnwxnMySNn+pLeqWL+We8bvpI3Ytl8C38P8f3
         Y60+Xu/I0staA==
Date:   Wed, 14 Apr 2021 15:45:08 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Arun Easi <aeasi@marvell.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Girish Basrur <GBasrur@marvell.com>,
        Quinn Tran <qutran@marvell.com>
Subject: Re: [PATCH v2 1/1] PCI/VPD: Fix blocking of VPD data in lspci for
 QLogic 1077:2261
Message-ID: <20210414204508.GA2536430@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210409215153.16569-2-aeasi@marvell.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Apr 09, 2021 at 02:51:53PM -0700, Arun Easi wrote:
> "lspci -vvv" for Qlogic Fibre Channel HBA 1077:2261 displays
> "Vital Product Data" as "Not readable" today and thus preventing
> customers from getting relevant HBA information. Fix it by removing
> the blacklist quirk.
> 
> The VPD quirk was added by [0] to avoid a system NMI; this issue has
> been long fixed in the HBA firmware. In addition, PCI also has changes
> to check the VPD size [1], so this quirk can be reverted now regardless
> of a firmware update.
> 
> Some more details can be found in the following thread:
>     "VPD blacklist of Marvell QLogic 1077/2261" [2]
> 
> [0] 0d5370d1d852 ("PCI: Prevent VPD access for QLogic ISP2722")
> [1] 104daa71b396 ("PCI: Determine actual VPD size on first access")
> [2] https://lore.kernel.org/linux-pci/alpine.LRH.2.21.9999.2012161641230.28924@irv1user01.caveonetworks.com/
> [3] https://lore.kernel.org/linux-pci/alpine.LRH.2.21.9999.2104071535110.13940@irv1user01.caveonetworks.com/
> 
> Clarification on why [0], which appeared in v4.11, would be an issue
> given that [1] appeared in v4.6:
> 
>     Firstly, we do not have information on which exact kernel the
>     tester was using that resulted in [0]. That said, the call
>     trace for the issue had pci_vpd_pci22_* calls, which appeared
>     only in pre-4.6 kernels. Those functions were renamed v4.6 and
>     above, so tester was indeed testing using an older kernel.
>     See [3] for further details.
> 
> Signed-off-by: Arun Easi <aeasi@marvell.com>
> CC: stable@vger.kernel.org      # v4.6+

Applied to pci/vpd for v5.13, thanks!

> ---
>  drivers/pci/vpd.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/pci/vpd.c b/drivers/pci/vpd.c
> index 6909253..a41818a 100644
> --- a/drivers/pci/vpd.c
> +++ b/drivers/pci/vpd.c
> @@ -474,7 +474,6 @@ DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LSI_LOGIC, 0x005d, quirk_blacklist_vpd);
>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LSI_LOGIC, 0x005f, quirk_blacklist_vpd);
>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATTANSIC, PCI_ANY_ID,
>  		quirk_blacklist_vpd);
> -DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_QLOGIC, 0x2261, quirk_blacklist_vpd);
>  /*
>   * The Amazon Annapurna Labs 0x0031 device id is reused for other non Root Port
>   * device types, so the quirk is registered for the PCI_CLASS_BRIDGE_PCI class.
> -- 
> 2.9.5
> 
