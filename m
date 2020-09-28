Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A837927B849
	for <lists+linux-pci@lfdr.de>; Tue, 29 Sep 2020 01:35:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726993AbgI1Xfb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 28 Sep 2020 19:35:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:59744 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726379AbgI1Xfb (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 28 Sep 2020 19:35:31 -0400
Received: from localhost (52.sub-72-107-123.myvzw.com [72.107.123.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9E8462388B;
        Mon, 28 Sep 2020 22:18:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601331496;
        bh=PUhM2Ga8oNnbG1Q+CupQvWsGL9gLNVc8nvROFjzbG18=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=IJDJQiOAiEsFmlXaHr7IUI3+NaSMTxcpvN2Wpx+Af0P7iA89G6WVCHoOxP8NbXzzI
         93dS594EejrOYRM7+TH2GlEeki328oaJOgiUKfn8wJaJJwsRfKG4oI9z44JxEgXUQo
         W23B7Se84nQZhZ7/+hU9lQGUKJ/tg+XUXVbyRD2A=
Date:   Mon, 28 Sep 2020 17:18:15 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: Fix comparison to bool warning in pci.c
Message-ID: <20200928221815.GA2501439@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200925224555.1752460-1-kw@linux.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Sep 25, 2020 at 10:45:55PM +0000, Krzysztof Wilczyński wrote:
> Take care about Coccinelle warnings:
> 
>   drivers/pci/pci.c:6008:6-12: WARNING: Comparison to bool
>   drivers/pci/pci.c:6024:7-13: WARNING: Comparison to bool
> 
> No change to functionality intended.
> 
> Signed-off-by: Krzysztof Wilczyński <kw@linux.com>

Applied to pci/misc for v5.10, thanks!

I can't remember why I thought about renaming "decode".

> ---
>  drivers/pci/pci.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index e39c5499770f..487e7214743d 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -6005,7 +6005,7 @@ int pci_set_vga_state(struct pci_dev *dev, bool decode,
>  
>  	if (flags & PCI_VGA_STATE_CHANGE_DECODES) {
>  		pci_read_config_word(dev, PCI_COMMAND, &cmd);
> -		if (decode == true)
> +		if (decode)
>  			cmd |= command_bits;
>  		else
>  			cmd &= ~command_bits;
> @@ -6021,7 +6021,7 @@ int pci_set_vga_state(struct pci_dev *dev, bool decode,
>  		if (bridge) {
>  			pci_read_config_word(bridge, PCI_BRIDGE_CONTROL,
>  					     &cmd);
> -			if (decode == true)
> +			if (decode)
>  				cmd |= PCI_BRIDGE_CTL_VGA;
>  			else
>  				cmd &= ~PCI_BRIDGE_CTL_VGA;
> -- 
> 2.28.0
> 
