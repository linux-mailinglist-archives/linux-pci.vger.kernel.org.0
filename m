Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2919C259E24
	for <lists+linux-pci@lfdr.de>; Tue,  1 Sep 2020 20:37:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728424AbgIAShE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 1 Sep 2020 14:37:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:42242 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726489AbgIAShE (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 1 Sep 2020 14:37:04 -0400
Received: from localhost (113.sub-72-107-119.myvzw.com [72.107.119.113])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 887092078B;
        Tue,  1 Sep 2020 18:37:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598985423;
        bh=3HthENpfVJJhSbk44Xutyzx8/hu1uwR2FNIa2WacDqs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=FjQjLR8Oxylk284FfpXTpRA4NzLBcSVErL4dd4x02rhNMrotc2AvV9SdcFQEHpf28
         nCphJFK2upCb3gT87BAQ1B/kNrdwlsSVcP3sxBaEOjB4OoUqFb3tf1Wt8w4xHCcuxP
         U6T6XXNvh3UNnulfrXzhLDaOt837a+VpvkI5nTGQ=
Date:   Tue, 1 Sep 2020 13:37:02 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Clint Sbisa <csbisa@amazon.com>
Cc:     linux-pci@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        benh@kernel.crashing.org
Subject: Re: [PATCH] arm64: Enable PCI write-combine resources under sysfs
Message-ID: <20200901183702.GA196025@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200831151827.pumm2p54fyj7fz5s@amazon.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Aug 31, 2020 at 03:18:27PM +0000, Clint Sbisa wrote:
> Using write-combine is crucial for performance of PCI devices where
> significant amounts of transactions go over PCI BARs.
> 
> arm64 supports write-combine PCI mappings, so the appropriate define
> has been added which will expose write-combine mappings under sysfs
> for prefetchable PCI resources.
> 
> Signed-off-by: Clint Sbisa <csbisa@amazon.com>

Fine with me, I assume Will or Catalin will apply this.

> ---
>  arch/arm64/include/asm/pci.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/include/asm/pci.h b/arch/arm64/include/asm/pci.h
> index 70b323cf8300..b33ca260e3c9 100644
> --- a/arch/arm64/include/asm/pci.h
> +++ b/arch/arm64/include/asm/pci.h
> @@ -17,6 +17,7 @@
>  #define pcibios_assign_all_busses() \
>  	(pci_has_flag(PCI_REASSIGN_ALL_BUS))
>  
> +#define arch_can_pci_mmap_wc() 1
>  #define ARCH_GENERIC_PCI_MMAP_RESOURCE	1
>  
>  extern int isa_dma_bridge_buggy;
> -- 
> 2.23.3
> 
