Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E0AE6CFA4C
	for <lists+linux-pci@lfdr.de>; Tue,  8 Oct 2019 14:47:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730317AbfJHMrZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 8 Oct 2019 08:47:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:40340 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730316AbfJHMrY (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 8 Oct 2019 08:47:24 -0400
Received: from localhost (173-25-83-245.client.mchsi.com [173.25.83.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1665F20640;
        Tue,  8 Oct 2019 12:47:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570538844;
        bh=gPpCa6p+Wso87HvLkhRvL+4LLCQTklIIhK4mGQjgaXA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=ZhNc5wiP2bjwQKEPE96Jtm8B32XiDgHnk1lCcNhInf6MdIm3rZ5TRWMidk7plGOd8
         sbb9kr4SvfvwNP4hHOt8DlAXpXC5vpzKny9kDZRx+1xrd1uilfGPhLXncxxdZMFu25
         N1/M2Eu38NLnXvGOgZMdcd8WLpWWqnCx254KocPM=
Date:   Tue, 8 Oct 2019 07:47:23 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Michal Simek <michal.simek@xilinx.com>
Cc:     linux-kernel@vger.kernel.org, monstr@monstr.eu, git@xilinx.com,
        Kuldeep Dave <kuldeep.dave@xilinx.com>,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI/MSI: Enable PCI_MSI_IRQ_DOMAIN support for Microblaze
Message-ID: <20191008124723.GA161444@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e0ead31283c74254e8c02c0e5e5123277ed1f927.1570531159.git.michal.simek@xilinx.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Oct 08, 2019 at 12:39:22PM +0200, Michal Simek wrote:
> From: Kuldeep Dave <kuldeep.dave@xilinx.com>
> 
> Add Microblaze as an arch that supports PCI_MSI_IRQ_DOMAIN.
> Enabling msi.h generation is done by separate patch.
> 
> Similar change was done by commit 2a9af0273c1c
> ("PCI/MSI: Enable PCI_MSI_IRQ_DOMAIN support for RISC-V")
> 
> Signed-off-by: Kuldeep Dave <kuldeep.dave@xilinx.com>
> Signed-off-by: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> Arch part was sent here:
> https://lkml.org/lkml/2019/10/8/277

Can you please squash this drivers/pci/Kconfig change into the same
patch as the arch/microblaze patch mentioned above?  That way there's
no ordering issue between the two patches.  I'd be glad to merge it,
or you can add my ack and apply it via the Microblaze tree.  Just let
me know which you prefer so I know whether to do something with this.

Sorry; I probably suggested the splitting in the first place for
RISC-V, but I think that was a mistake.

> ---
>  drivers/pci/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
> index a304f5ea11b9..9d259372fbfd 100644
> --- a/drivers/pci/Kconfig
> +++ b/drivers/pci/Kconfig
> @@ -52,7 +52,7 @@ config PCI_MSI
>  	   If you don't know what to do here, say Y.
>  
>  config PCI_MSI_IRQ_DOMAIN
> -	def_bool ARC || ARM || ARM64 || X86 || RISCV
> +	def_bool ARC || ARM || ARM64 || X86 || RISCV || MICROBLAZE
>  	depends on PCI_MSI
>  	select GENERIC_MSI_IRQ_DOMAIN
>  
> -- 
> 2.17.1
> 
