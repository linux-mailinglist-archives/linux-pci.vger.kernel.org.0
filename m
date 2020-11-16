Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1D2C2B4B79
	for <lists+linux-pci@lfdr.de>; Mon, 16 Nov 2020 17:42:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731108AbgKPQmD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 16 Nov 2020 11:42:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:58972 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729689AbgKPQmC (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 16 Nov 2020 11:42:02 -0500
Received: from localhost (189.sub-72-105-114.myvzw.com [72.105.114.189])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8A6AD206D9;
        Mon, 16 Nov 2020 16:42:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605544922;
        bh=TgH1abjAGKm1AI19eKqktN7to1FFPzXHleFxcxbkKI8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=sQ5aXPh3snFjQmczM+VPazL8s/aZevGo5eKBMXnrsHdeK2P4LWLWwhRgrP+4tjo8v
         fW5whkpjlstLvmNNEO8dlnYlFNu6k+v/nUNQX7WySZoxfEoEU88ZimYtMLQAhFVB1f
         GulmiaLGww5TeaexigJXCTBgVktebrIBLAsYafiM=
Date:   Mon, 16 Nov 2020 10:41:59 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Chen-Yu Tsai <wens@kernel.org>
Cc:     Shawn Lin <shawn.lin@rock-chips.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Heiko Stuebner <heiko@sntech.de>, Chen-Yu Tsai <wens@csie.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Johan Jonker <jbx6244@gmail.com>, linux-pci@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 1/4] PCI: rockchip: make ep_gpio optional
Message-ID: <20201116164159.GA1282970@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201116075215.15303-2-wens@kernel.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Run "git log --oneline drivers/pci/controller/pcie-rockchip.c" (or
even just look at the Fixes: commits you mention) and follow the
convention, e.g.,

  PCI: rockchip: Make 'ep-gpios' DT property optional

Also, you used 'ep_gpio' (singular, with an underline) in the subject
but 'ep-gpios' (plural, with hyphen) in the commit log.  The error
message and Documentation/devicetree/bindings/pci/rockchip-pcie-host.txt
both say 'ep-gpios' (plural, with hyphen).

Please fix so this is all consistent.  Details matter.

On Mon, Nov 16, 2020 at 03:52:12PM +0800, Chen-Yu Tsai wrote:
> From: Chen-Yu Tsai <wens@csie.org>
> 
> The Rockchip PCIe controller DT binding clearly states that ep-gpios is
> an optional property. And indeed there are boards that don't require it.
> 
> Make the driver follow the binding by using devm_gpiod_get_optional()
> instead of devm_gpiod_get().
> 
> Fixes: e77f847df54c ("PCI: rockchip: Add Rockchip PCIe controller support")
> Fixes: 956cd99b35a8 ("PCI: rockchip: Separate common code from RC driver")
> Fixes: 964bac9455be ("PCI: rockchip: Split out rockchip_pcie_parse_dt() to parse DT")
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---
>  drivers/pci/controller/pcie-rockchip.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/pcie-rockchip.c b/drivers/pci/controller/pcie-rockchip.c
> index 904dec0d3a88..c95950e9004f 100644
> --- a/drivers/pci/controller/pcie-rockchip.c
> +++ b/drivers/pci/controller/pcie-rockchip.c
> @@ -118,7 +118,7 @@ int rockchip_pcie_parse_dt(struct rockchip_pcie *rockchip)
>  	}
>  
>  	if (rockchip->is_rc) {
> -		rockchip->ep_gpio = devm_gpiod_get(dev, "ep", GPIOD_OUT_HIGH);
> +		rockchip->ep_gpio = devm_gpiod_get_optional(dev, "ep", GPIOD_OUT_HIGH);
>  		if (IS_ERR(rockchip->ep_gpio)) {
>  			dev_err(dev, "missing ep-gpios property in node\n");
>  			return PTR_ERR(rockchip->ep_gpio);
> -- 
> 2.29.1
> 
