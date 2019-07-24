Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6EBFC7370A
	for <lists+linux-pci@lfdr.de>; Wed, 24 Jul 2019 20:55:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728174AbfGXSzi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 24 Jul 2019 14:55:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:43216 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727902AbfGXSzi (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 24 Jul 2019 14:55:38 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 35FC421841;
        Wed, 24 Jul 2019 18:55:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563994537;
        bh=VDzwqFOhiJh4xMSVBeOvME1RCnGWO7EYQb2dPUri730=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zU6Sq1X/0gjhgFpf5zT2I4CbMcLHIt39ArDSGVGRT1uWsa5BftBXTWsPt/AdJd6P5
         2FkfWHxrTdFC016LwuOyQKip4Fh2D9zpw+erxBlheqe7OZxBcCSv1yghaZZ/4e/Ebm
         nM7BpfiyJV8JcsYDBnIiRXpmrvtszZFKPjsnkZ8g=
Date:   Wed, 24 Jul 2019 13:55:35 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Shannon Zhao <shenglong.zsl@alibaba-inc.com>
Cc:     linux-kernel@vger.kernel.org, jnair@marvell.com,
        linux-pci@vger.kernel.org, gduan@marvell.com
Subject: Re: [PATCH] PCI: Add ACS quirk for Cavium ThunderX 2 root port
 devices
Message-ID: <20190724185535.GD203187@google.com>
References: <1563541835-141011-1-git-send-email-shenglong.zsl@alibaba-inc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1563541835-141011-1-git-send-email-shenglong.zsl@alibaba-inc.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

See
https://lkml.kernel.org/r/20171026223701.GA25649@bhelgaas-glaptop.roam.corp.google.com
for incidental hints (subject, commit log, commit reference).  Your
patch basically extends that commit, so the subject should be very
similar.

On Fri, Jul 19, 2019 at 09:10:35PM +0800, Shannon Zhao wrote:
> From: Shannon Zhao <shannon.zhao@linux.alibaba.com>
> 
> Like commit f2ddaf8(PCI: Apply Cavium ThunderX ACS quirk to more Root
> Ports), it should apply ACS quirk to ThunderX 2 root port devices.

s/root port/Root Port/ to be consistent

> Signed-off-by: Shannon Zhao <shannon.zhao@linux.alibaba.com>

I suppose this should have the same stable tag as f2ddaf8dfd4a ("PCI:
Apply Cavium ThunderX ACS quirk to more Root Ports") itself?

> ---
>  drivers/pci/quirks.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 28c64f8..ea7848b 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -4224,10 +4224,12 @@ static bool pci_quirk_cavium_acs_match(struct pci_dev *dev)
>  	 * family by 0xf800 mask (which represents 8 SoCs), while the lower
>  	 * bits of device ID are used to indicate which subdevice is used
>  	 * within the SoC.
> +	 * Effectively selects the ThunderX 2 root ports whose device ID
> +	 * is 0xaf84.
>  	 */
>  	return (pci_is_pcie(dev) &&
>  		(pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT) &&
> -		((dev->device & 0xf800) == 0xa000));
> +		((dev->device & 0xf800) == 0xa000 || dev->device == 0xaf84));

I'm somewhat doubtful about this because previously we at least
selected a whole class of ThunderX 1 devices:

  ((dev->device & 0xf800) == 0xa000)

while you're adding only a *single* ThunderX device.

I don't want a constant trickle of adding new devices.  Can somebody
from Cavium or Marvell provide a corresponding mask for ThunderX 2, or
confirm that 0xaf84 is really the single device we expect to need
here?

>  }
>  
>  static int pci_quirk_cavium_acs(struct pci_dev *dev, u16 acs_flags)
> -- 
> 1.8.3.1
> 
