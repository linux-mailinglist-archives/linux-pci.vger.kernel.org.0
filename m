Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A8FF48C22F
	for <lists+linux-pci@lfdr.de>; Wed, 12 Jan 2022 11:23:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352483AbiALKX4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 12 Jan 2022 05:23:56 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:58570 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238224AbiALKX4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 12 Jan 2022 05:23:56 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CFDAFB81EA2
        for <linux-pci@vger.kernel.org>; Wed, 12 Jan 2022 10:23:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 709E8C36AEA;
        Wed, 12 Jan 2022 10:23:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641983033;
        bh=BZ04WAZ0t+8XI/iyQq7uC0dZRvJBAC8mSXpO3DrxMjE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iS3ShwiQccQP2LOlGcfxP/FDsv3bsAP0r5hriM4tX+21E5sjp+3hC4JlFqH+u/rna
         /raHI0/XoMuL1IxIWNleyZ+CHa7T3W9WYfEf2bX6UifAI1NxbquvswfKJaex9fmjEV
         1mRnkNFsqsvg02k2/kSCP2c3EqlbTKcNXTjgSnKNN9D14T9QOZJh/w1HMioMh+6Ksr
         AuHvsHaNd1wtBAnodnNxnPLlknAbuYveA2anCwcJzw1dL2oB5RKGiP4q6GYNzrU+t6
         om50xMc3thnbDozhPW0WHKZShwZHdfipwtjByt2Nsm4kmkLM8muF29NFyxJ329Z/Bf
         JDjqMxQl9ur5Q==
Received: by pali.im (Postfix)
        id 80CB5768; Wed, 12 Jan 2022 11:23:50 +0100 (CET)
Date:   Wed, 12 Jan 2022 11:23:50 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Stefan Roese <sr@denx.de>
Cc:     linux-pci@vger.kernel.org,
        Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>
Subject: Re: [RESEND PATCH v2 1/4] PCI: Add setup_platform_service_irq hook
 to struct pci_host_bridge
Message-ID: <20220112102350.hewhzawceohtmtx3@pali>
References: <20220112094251.1271531-1-sr@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220112094251.1271531-1-sr@denx.de>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello!

On Wednesday 12 January 2022 10:42:48 Stefan Roese wrote:
> From: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
> 
> As per section 6.2.4.1.2, 6.2.6 in PCIe r4.0 error interrupts can
> be delivered with platform specific interrupt lines.

My understanding of these sections is that they still have to be
deliverable via standard interrupts (INTx / MSI) if root port supports
standard interrupts:

"If a Root Port or Root Complex Event Collector is enabled for
level-triggered interrupt signaling using the INTx messages, the virtual
INTx wire must be asserted..."

"If a Root Port or Root Complex Event Collector is enabled for
edge-triggered interrupt signaling using MSI or MSI-X, an interrupt
message must be sent every time..."

> Add setup_platform_service_irq hook to struct pci_host_bridge.
> Some platforms have dedicated interrupt line from root complex to
> interrupt controller for PCIe services like AER.
> This hook is to register platform IRQ's to PCIe port services.
> 
> Signed-off-by: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
> Signed-off-by: Stefan Roese <sr@denx.de>
> Tested-by: Stefan Roese <sr@denx.de>
> Cc: Bjorn Helgaas <helgaas@kernel.org>
> Cc: Pali Rohár <pali@kernel.org>
> Cc: Michal Simek <michal.simek@xilinx.com>
> ---
>  include/linux/pci.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 18a75c8e615c..291eadade811 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -554,6 +554,8 @@ struct pci_host_bridge {
>  	u8 (*swizzle_irq)(struct pci_dev *, u8 *); /* Platform IRQ swizzler */
>  	int (*map_irq)(const struct pci_dev *, u8, u8);
>  	void (*release_fn)(struct pci_host_bridge *);
> +	void (*setup_platform_service_irq)(struct pci_host_bridge *, int *,
> +					   int);

This callback is used only for root port. So I would suggest to put
_root port_ into the name of the callback to indicate it. To distinguish
for which devices is callback designed because other callbacks (e.g.
map_irq) are used for any device.

This callback is root port specific and therefore struct pci_dev *
pointer should be passed as callback argument. Host bridge may have
multiple root ports, so passing only host bridge is not enough.

Maybe it would be better to pass struct pci_dev * instead of struct
pci_host_bridge * As from pci_dev can be easily derived host bridge.

Anyway, this callback looks to be very useful, I would like to use it in
pci-aardvark.c and pci-mvebu.c drivers for better mapping of PME, AER
and HP interrupts. And pci-mvebu.c is multi root port driver, so needs
pci_dev*.

And my guess is that this callback can be useful for adding AER support
also for pcie-uniphier.c driver, as replacement for this (rather ugly)
patches:
https://lore.kernel.org/linux-pci/1619111097-10232-1-git-send-email-hayashi.kunihiko@socionext.com/

So I would be happy to see it!

>  	void		*release_data;
>  	unsigned int	ignore_reset_delay:1;	/* For entire hierarchy */
>  	unsigned int	no_ext_tags:1;		/* No Extended Tags */
> -- 
> 2.34.1
> 
