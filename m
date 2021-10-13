Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A21842B269
	for <lists+linux-pci@lfdr.de>; Wed, 13 Oct 2021 03:50:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236387AbhJMBwq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 12 Oct 2021 21:52:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:60592 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235881AbhJMBwq (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 12 Oct 2021 21:52:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2BA256101D;
        Wed, 13 Oct 2021 01:50:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634089843;
        bh=qNcEiteJJu/cQri5OdigN6+5v8g6HA2Si4AnIagvQ0o=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=IDjLuo4M3Hu1i2uDv0G7lyrTUPMrLZdVgRxHhbboqn/jMjowTY8oInszB4+nOExDv
         PPUKDD5b2F/OynhbZgrrC+sy2oO3xRH/myrXVb1T8u7foMO8zmq2FOQsCKtIUDWaRp
         3Yq+BKX71mku+ThWiylkmG55xuujiyctbtfmzOmFii4oG6zH51VzG7LBfvsr38oBzP
         OTK7IcG5sXIp+dCa5PXvhkZarohn3PwKAqmsCMM2owzrfWKYha4qMoM3EarvJJwhy4
         g15zNmXe2UCVyJPMW06sBO2HbAEtS97OYs5yPDBelteMpXjASHz3KfjDY01swydgaZ
         L00yqTqGQkZJA==
Date:   Tue, 12 Oct 2021 20:50:41 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: cpqphp: Format if-statement code block correctly
Message-ID: <20211013015041.GA1862613@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211013011412.1110829-1-kw@linux.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Oct 13, 2021 at 01:14:12AM +0000, Krzysztof Wilczyński wrote:
> The if-statement code block as seen in the cpqhp_s
> 
> The code block related to the if-statement in cpqhp_set_irq() is
> somewhat awkwardly formatted making the code hard to read.
> 
> Thus, update the code to match preferred code formatting style.
> 
> No change to functionality intended.
> 
> Signed-off-by: Krzysztof Wilczyński <kw@linux.com>
> ---
>  drivers/pci/hotplug/cpqphp_pci.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)

Applied with the commit log touchup to pci/misc for v5.16, thanks!

Looks like somebody's "J" key got stuck in vi :)

> diff --git a/drivers/pci/hotplug/cpqphp_pci.c b/drivers/pci/hotplug/cpqphp_pci.c
> index 1b2b3f3b648b..9038039ad6db 100644
> --- a/drivers/pci/hotplug/cpqphp_pci.c
> +++ b/drivers/pci/hotplug/cpqphp_pci.c
> @@ -189,8 +189,10 @@ int cpqhp_set_irq(u8 bus_num, u8 dev_num, u8 int_pin, u8 irq_num)
>  		/* This should only be for x86 as it sets the Edge Level
>  		 * Control Register
>  		 */
> -		outb((u8) (temp_word & 0xFF), 0x4d0); outb((u8) ((temp_word &
> -		0xFF00) >> 8), 0x4d1); rc = 0; }
> +		outb((u8)(temp_word & 0xFF), 0x4d0);
> +		outb((u8)((temp_word & 0xFF00) >> 8), 0x4d1);
> +		rc = 0;
> +	}
>  
>  	return rc;
>  }
> -- 
> 2.33.0
> 
