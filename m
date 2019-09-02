Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 251C3A547A
	for <lists+linux-pci@lfdr.de>; Mon,  2 Sep 2019 12:55:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730785AbfIBKzj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 2 Sep 2019 06:55:39 -0400
Received: from foss.arm.com ([217.140.110.172]:52180 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726273AbfIBKzj (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 2 Sep 2019 06:55:39 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 98C8428;
        Mon,  2 Sep 2019 03:55:38 -0700 (PDT)
Received: from localhost (unknown [10.37.6.20])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1124E3F246;
        Mon,  2 Sep 2019 03:55:37 -0700 (PDT)
Date:   Mon, 2 Sep 2019 11:55:36 +0100
From:   Andrew Murray <andrew.murray@arm.com>
To:     Remi Pommarel <repk@triplefau.lt>
Cc:     Yue Wang <yue.wang@Amlogic.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Kevin Hilman <khilman@baylibre.com>, linux-pci@vger.kernel.org,
        linux-amlogic@lists.infradead.org
Subject: Re: [PATCH] PCI: amlogic: Fix reset assertion via gpio descriptor
Message-ID: <20190902105536.GG9720@e119886-lin.cambridge.arm.com>
References: <20190901133915.12899-1-repk@triplefau.lt>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190901133915.12899-1-repk@triplefau.lt>
User-Agent: Mutt/1.10.1+81 (426a6c1) (2018-08-26)
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

The device tree bindings for this give an example configuration:

        pcie: pcie@f9800000 {
                        compatible = "amlogic,axg-pcie", "snps,dw-pcie";
                        reg = <0x0 0xf9800000 0x0 0x400000
                                        0x0 0xff646000 0x0 0x2000
                                        0x0 0xff644000 0x0 0x2000
                                        0x0 0xf9f00000 0x0 0x100000>;
                        reg-names = "elbi", "cfg", "phy", "config";
                        reset-gpios = <&gpio GPIOX_19 GPIO_ACTIVE_HIGH>;

Is the 'reset-gpios' line still consistent with this change, or does
this need to be updated as well?

Thanks,

Andrew Murray

> 
> Signed-off-by: Remi Pommarel <repk@triplefau.lt>
> ---
>  drivers/pci/controller/dwc/pci-meson.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
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
