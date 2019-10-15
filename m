Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 91189D77E1
	for <lists+linux-pci@lfdr.de>; Tue, 15 Oct 2019 16:02:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732028AbfJOOCT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 15 Oct 2019 10:02:19 -0400
Received: from foss.arm.com ([217.140.110.172]:39312 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732011AbfJOOCT (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 15 Oct 2019 10:02:19 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0C822337;
        Tue, 15 Oct 2019 07:02:19 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (unknown [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2436B3F718;
        Tue, 15 Oct 2019 07:02:18 -0700 (PDT)
Date:   Tue, 15 Oct 2019 15:02:13 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Remi Pommarel <repk@triplefau.lt>
Cc:     Yue Wang <yue.wang@Amlogic.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Kevin Hilman <khilman@baylibre.com>, linux-pci@vger.kernel.org,
        linux-amlogic@lists.infradead.org
Subject: Re: [PATCH] PCI: amlogic: Fix reset assertion via gpio descriptor
Message-ID: <20191015140213.GA18503@e121166-lin.cambridge.arm.com>
References: <20190901133915.12899-1-repk@triplefau.lt>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190901133915.12899-1-repk@triplefau.lt>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Sep 01, 2019 at 03:39:15PM +0200, Remi Pommarel wrote:
> Normally asserting reset signal on gpio would be achieved with:
> 	gpiod_set_value_cansleep(reset_gpio, 1);
> 
> Meson PCI driver set reset value to '0' instead of '1' as it takes into
> account the PERST# signal polarity. The polarity should be taken care
> in the device tree instead.
> 
> This fixes the reset assertion meaning and moves out the polarity
> configuration in DT (please note that there is no DT currently using
> this driver).
> 
> Signed-off-by: Remi Pommarel <repk@triplefau.lt>
> ---
>  drivers/pci/controller/dwc/pci-meson.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied to pci/meson, thanks.

Lorenzo

> diff --git a/drivers/pci/controller/dwc/pci-meson.c b/drivers/pci/controller/dwc/pci-meson.c
> index e35e9eaa50ee..541f37a6f6a5 100644
> --- a/drivers/pci/controller/dwc/pci-meson.c
> +++ b/drivers/pci/controller/dwc/pci-meson.c
> @@ -287,9 +287,9 @@ static inline void meson_cfg_writel(struct meson_pcie *mp, u32 val, u32 reg)
>  
>  static void meson_pcie_assert_reset(struct meson_pcie *mp)
>  {
> -	gpiod_set_value_cansleep(mp->reset_gpio, 0);
> -	udelay(500);
>  	gpiod_set_value_cansleep(mp->reset_gpio, 1);
> +	udelay(500);
> +	gpiod_set_value_cansleep(mp->reset_gpio, 0);
>  }
>  
>  static void meson_pcie_init_dw(struct meson_pcie *mp)
> -- 
> 2.20.1
> 
