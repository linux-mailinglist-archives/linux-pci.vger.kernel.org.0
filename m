Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E02A035776D
	for <lists+linux-pci@lfdr.de>; Thu,  8 Apr 2021 00:13:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229469AbhDGWNY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 7 Apr 2021 18:13:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:51514 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229497AbhDGWNY (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 7 Apr 2021 18:13:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B6EDB61164;
        Wed,  7 Apr 2021 22:13:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617833594;
        bh=EF2Wxx9ULMW94k59cSVNy9LBCK9xxy3RfKRRD/nj6eo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=C3vAC9eIr//Cfme7eCLvEaUjd+52YaVm6Bh/a1ds/YNk6rMbxXih+2t8AwHK2iSFO
         XV/ge+z7UpykD3QP+rRQPE8znPiRWvc79Qy4IuNA49MF1KURMrgQ87HsQas2gGoex9
         6ofQwHMVSjXA8f8khMJVlxdH0UaQKdTGSK506ggRuRMW0r8x9RZONekRyY9O5+ADRi
         NjTYc9+hjY/2AVDf5tPVSTWivfATrmSMRMZs1jDbQ45EqM4ST0OLi1XSENxIc/YfeW
         NKcVRBxd0R9Rvuz+j7AIjmYZHEYD4EzHdJZMxjCl2KyG41+GQWRgicwDr5Q99l7C/4
         2uI8bGNVPuwNA==
Date:   Wed, 7 Apr 2021 17:13:12 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Arun Easi <aeasi@marvell.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Girish Basrur <GBasrur@marvell.com>,
        Quinn Tran <qutran@marvell.com>
Subject: Re: [PATCH 1/1] PCI/VPD: Fix blocking of VPD data in lspci for
 QLogic 1077:2261
Message-ID: <20210407221312.GA1872228@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210303224250.12618-2-aeasi@marvell.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Mar 03, 2021 at 02:42:50PM -0800, Arun Easi wrote:
> "lspci -vvv" for Qlogic Fibre Channel HBA 1077:2261 displays
> "Vital Product Data" as "Not readable" today and thus preventing
> customers from getting relevant HBA information. Fix it by removing
> the blacklist quirk.
> 
> The VPD quirk was added by [0] to avoid a system NMI; this issue has
> been long fixed in the HBA firmware. In addition, PCI also has changes
> to check the VPD size [1], so this quirk can be reverted now regardless
> of a firmware update.

This is not a very convincing argument yet since 104daa71b396 ("PCI:
Determine actual VPD size on first access") appeared in v4.6 and
0d5370d1d852 ("PCI: Prevent VPD access for QLogic ISP2722") appeared
in v4.11.

If 104daa71b396 really fixed the problem, why did we need
0d5370d1d852?

> Some more details can be found in the following thread:
>     "VPD blacklist of Marvell QLogic 1077/2261" [2].
> 
> [0] 0d5370d1d852 ("PCI: Prevent VPD access for QLogic ISP2722")
> [1] 104daa71b396 ("PCI: Determine actual VPD size on first access")
> [2] https://lore.kernel.org/linux-pci/alpine.LRH.2.21.9999.2012161641230.28924@irv1user01.caveonetworks.com/
> 
> Signed-off-by: Arun Easi <aeasi@marvell.com>
> CC: stable@vger.kernel.org      # v4.6+
> ---
>  drivers/pci/vpd.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/pci/vpd.c b/drivers/pci/vpd.c
> index 7915d10..bd54907 100644
> --- a/drivers/pci/vpd.c
> +++ b/drivers/pci/vpd.c
> @@ -570,7 +570,6 @@ DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LSI_LOGIC, 0x005d, quirk_blacklist_vpd);
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
