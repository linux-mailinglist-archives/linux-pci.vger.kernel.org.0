Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5D971FCC1C
	for <lists+linux-pci@lfdr.de>; Wed, 17 Jun 2020 13:19:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726998AbgFQLRg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 17 Jun 2020 07:17:36 -0400
Received: from elvis.franken.de ([193.175.24.41]:35911 "EHLO elvis.franken.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726905AbgFQLRe (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 17 Jun 2020 07:17:34 -0400
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1jlW4P-0006Ho-01; Wed, 17 Jun 2020 13:17:29 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 9B32DC06C3; Wed, 17 Jun 2020 13:09:13 +0200 (CEST)
Date:   Wed, 17 Jun 2020 13:09:13 +0200
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     =?iso-8859-1?Q?=C1lvaro_Fern=E1ndez?= Rojas <noltari@gmail.com>
Cc:     bhelgaas@google.com, robh+dt@kernel.org, lorenzo.pieralisi@arm.com,
        p.zabel@pengutronix.de, jiaxun.yang@flygoat.com,
        paulburton@kernel.org, info@metux.net, allison@lohutok.net,
        kstewart@linuxfoundation.org, tglx@linutronix.de,
        jonas.gorski@gmail.com, f.fainelli@gmail.com,
        bcm-kernel-feedback-list@broadcom.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org
Subject: Re: [PATCH 1/3] mips: bmips: add PCI support
Message-ID: <20200617110913.GB9940@alpha.franken.de>
References: <20200617102556.3792821-1-noltari@gmail.com>
 <20200617102556.3792821-2-noltari@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200617102556.3792821-2-noltari@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jun 17, 2020 at 12:25:54PM +0200, Álvaro Fernández Rojas wrote:
> BMIPS SoCs with PCI: BCM6358, BCM6368.
> BMIPS SoCs with PCIe (gen1): BCM6328, BCM6362, BCM63268.
> BMIPS SoCs with PCIe (gen2): BCM6318.
> 
> Signed-off-by: Álvaro Fernández Rojas <noltari@gmail.com>
> ---
>  arch/mips/Kconfig           |  1 +
>  arch/mips/pci/Makefile      |  1 +
>  arch/mips/pci/fixup-bmips.c | 17 +++++++++++++++++
>  3 files changed, 19 insertions(+)
>  create mode 100644 arch/mips/pci/fixup-bmips.c
> 
> diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
> index 6fee1a133e9d..357026cb51de 100644
> --- a/arch/mips/Kconfig
> +++ b/arch/mips/Kconfig
> @@ -230,6 +230,7 @@ config BMIPS_GENERIC
>  	select ARCH_HAS_SYNC_DMA_FOR_CPU_ALL
>  	select ARCH_HAS_PHYS_TO_DMA
>  	select BOOT_RAW
> +	select HAVE_PCI
>  	select NO_EXCEPT_FILL
>  	select USE_OF
>  	select CEVT_R4K

as everything is using DT in your patch, can't you use PCI_DRIVERS_GENERIC
here and drop fixup-bmips ?

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
