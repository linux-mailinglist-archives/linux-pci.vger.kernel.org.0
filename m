Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B3BF2520DA
	for <lists+linux-pci@lfdr.de>; Tue, 25 Aug 2020 21:44:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726711AbgHYToi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 25 Aug 2020 15:44:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:52380 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726820AbgHYTo2 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 25 Aug 2020 15:44:28 -0400
Received: from localhost (104.sub-72-107-126.myvzw.com [72.107.126.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 21F262076C;
        Tue, 25 Aug 2020 19:44:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598384668;
        bh=9Go/Zhclcce+flMww2sY3aWDPzUfYx7gBKodCIGY8g0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=mRgqK9U0so7TKb9tGf3mKjc7Qoz7L+zuD1nCa1PUm/ZFAF9ZHedfsXfQsk1+aEBPQ
         vg9s5BZxQMIvvV3xlL+/+9XNZq+FOIvz4GkSoGzk7UW9t/FEYVV8PTl8yW/yepF1Rc
         0EFukoesUcYCzzrC1VevYPkEYDz86gtpVyXMPxpk=
Date:   Tue, 25 Aug 2020 14:44:26 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Marc Zyngier <maz@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Valentin Schneider <valentin.schneider@arm.com>
Subject: Re: [PATCH 3/9] PCI/MSI: Provide default retrigger callback
Message-ID: <20200825194426.GA1922753@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200824102317.1038259-4-maz@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Aug 24, 2020 at 11:23:11AM +0100, Marc Zyngier wrote:
> Signed-off-by: Marc Zyngier <maz@kernel.org>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> ---
>  drivers/pci/msi.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
> index 30ae4ffda5c1..c4d31ce2d951 100644
> --- a/drivers/pci/msi.c
> +++ b/drivers/pci/msi.c
> @@ -1446,6 +1446,8 @@ static void pci_msi_domain_update_chip_ops(struct msi_domain_info *info)
>  		chip->irq_mask = pci_msi_mask_irq;
>  	if (!chip->irq_unmask)
>  		chip->irq_unmask = pci_msi_unmask_irq;
> +	if (!chip->irq_retrigger)
> +		chip->irq_retrigger = irq_chip_retrigger_hierarchy;
>  }
>  
>  /**
> -- 
> 2.27.0
> 
