Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A90C127EF21
	for <lists+linux-pci@lfdr.de>; Wed, 30 Sep 2020 18:27:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731071AbgI3Q11 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 30 Sep 2020 12:27:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725355AbgI3Q10 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 30 Sep 2020 12:27:26 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFC36C0613D1
        for <linux-pci@vger.kernel.org>; Wed, 30 Sep 2020 09:27:24 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id y17so2897197lfa.8
        for <linux-pci@vger.kernel.org>; Wed, 30 Sep 2020 09:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ragnatech-se.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=SDgDsKonRl9jKYsZXyPmbBwG+e3LnZR8gLRHIxhxmiU=;
        b=nrxha9o+yENidrz+UzMaKu4BoX+lo90cT7XY4QgLsjnRDLNQGJGSY9uD1gZ1j95+BM
         fVFFaU/yWA/EXnIH8o/IHp+xG0AZK7WvY7szYAyny8WO7MsWZW//FlllvvSbwJ8wkiDj
         KHNfyLIK6B8sQit/STZHE2/Itu8DMOoajo9TPMv3epsIUxBwK8dcoOpi4haOWBvAaUry
         QSGWlitgBAnG+TtFQ5p12/3ir2eSAoXN0tZfvwH4m1dV7QmPemwezQ76O3PT6P4SjC11
         GM8JEUZ2PlA1IJxMfHmaglslwpuWtWoItwMASrNjVxGkosSmWg2qqLcUfk+H+ixAOJPi
         1LpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=SDgDsKonRl9jKYsZXyPmbBwG+e3LnZR8gLRHIxhxmiU=;
        b=qLhXueDx66Kq397FF1YGuVkeBKCbSsSJVAZ2VIPTjBMipRD48KakmXivkrLS+mUuyB
         CUZvQ7bm6dpgFV8OqVO5fjJOL40DzrXpm984piIRR7R8JmnrvzH6AVJLkpLb0cV8NYvy
         69kEALOLLjOoAIzrAZSgZBIJlwZpJiTxv7+8NuLMYzUPV7mv0g4EuLv9S1W7JSU7GKL2
         u4yvB9Y9VD5buZEpU9u2DPApYHwwOBUbW8QinFflRGu3VZWcxMcI+c5YRnTDC4m9Qt/j
         X3356fMv8C4WlZfc4BKl3ED6PQPopPSuqAG8UPVXl+3Ldub+xRR92S20bqIzSAmndr73
         R9AQ==
X-Gm-Message-State: AOAM530sDnSMiw/cuFFy/E3X8JQ5+HrJZX585j8miPAIuPirTH76UGyK
        UmLEYHhpR7RnO8/35HBC6GgF8g==
X-Google-Smtp-Source: ABdhPJwT3egLNqlOPdmJqDBfOvuBtNjLqFSOvCK/N7g6m3nbAMLWYxg8FpxRpAbVie8oM/srAUTQxw==
X-Received: by 2002:a19:942:: with SMTP id 63mr1224078lfj.23.1601483243337;
        Wed, 30 Sep 2020 09:27:23 -0700 (PDT)
Received: from localhost (h-209-203.A463.priv.bahnhof.se. [155.4.209.203])
        by smtp.gmail.com with ESMTPSA id l129sm242018lfd.279.2020.09.30.09.27.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2020 09:27:22 -0700 (PDT)
Date:   Wed, 30 Sep 2020 18:27:22 +0200
From:   Niklas =?iso-8859-1?Q?S=F6derlund?= 
        <niklas.soderlund@ragnatech.se>
To:     Marc Zyngier <maz@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Frank Rowand <frowand.list@gmail.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, kernel-team@android.com
Subject: Re: [PATCH v2] of: address: Work around missing device_type property
 in pcie nodes
Message-ID: <20200930162722.GF1516931@oden.dyn.berto.se>
References: <20200819094255.474565-1-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200819094255.474565-1-maz@kernel.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Marc,

I'm afraid this commit breaks booting my rk3399 device.

I bisected the problem to this patch merged as [1]. I'm testing on a 
Scarlet device and I'm using the unmodified upstream  
rk3399-gru-scarlet-inx.dtb for my tests.

The problem I'm experience is a black screen after the bootloader and 
the device is none responsive over the network. I have no serial console 
to this device so I'm afraid I can't tell you if there is anything 
useful on to aid debugging there.

If I try to test one commit earlier [2] the system boots as expected and 
everything works as it did for me in v5.8 and earlier. I have worked 
little with this device and have no clue about what is really on the PCI 
buss. But running from [2] I have this info about PCI if it's helpful, 
please ask if somethings missing.

# dmesg | grep -i pci
[    0.003943] PCI/MSI: /interrupt-controller@fee00000/interrupt-controller@fee20000 domain created
[    0.922022] PCI: CLS 0 bytes, default 64
[    0.941517] rockchip-pcie f8000000.pcie: host bridge /pcie@f8000000 ranges:
[    0.941577] rockchip-pcie f8000000.pcie:      MEM 0x00fa000000..0x00fbefffff -> 0x00fa000000
[    0.941962] rockchip-pcie f8000000.pcie: GPIO lookup for consumer ep
[    0.941981] rockchip-pcie f8000000.pcie: using device tree for GPIO lookup
[    0.942018] of_get_named_gpiod_flags: parsed 'ep-gpios' property of node '/pcie@f8000000[0]' - status (0)
[    0.942255] rockchip-pcie f8000000.pcie: no vpcie12v regulator found
[    4.196248] ehci-pci: EHCI PCI platform driver
[    4.214639] ohci-pci: OHCI PCI platform driver


# ls /sys/bus/{pci,pci_express}/devices
/sys/bus/pci/devices:

/sys/bus/pci_express/devices:


# ls /sys/bus/{pci,pci_express}/drivers
/sys/bus/pci/drivers:
cavium_rng_pf  cavium_rng_vf  dwc3-haps  ehci-pci  exar_serial  ohci-pci  pcieport  serial  xhci_hcd

/sys/bus/pci_express/drivers:
pcie_pme


# ls /sys/bus/platform/drivers/rockchip-{pcie,pcie-phy}
/sys/bus/platform/drivers/rockchip-pcie:
bind  uevent  unbind

/sys/bus/platform/drivers/rockchip-pcie-phy:
bind  ff770000.syscon:pcie-phy  uevent  unbind

1. d1ac0002dd297069 ("of: address: Work around missing device_type property in pcie nodes")
2. 43647929175e2cd3 ("dt: writing-schema: Miscellaneous grammar fixes")

On 2020-08-19 10:42:55 +0100, Marc Zyngier wrote:
> Recent changes to the DT PCI bus parsing made it mandatory for
> device tree nodes describing a PCI controller to have the
> 'device_type = "pci"' property for the node to be matched.
> 
> Although this follows the letter of the specification, it
> breaks existing device-trees that have been working fine
> for years.  Rockchip rk3399-based systems are a prime example
> of such collateral damage, and have stopped discovering their
> PCI bus.
> 
> In order to paper over it, let's add a workaround to the code
> matching the device type, and accept as PCI any node that is
> named "pcie",
> 
> A warning will hopefully nudge the user into updating their
> DT to a fixed version if they can, but the incentive is
> obviously pretty small.
> 
> Fixes: 2f96593ecc37 ("of_address: Add bus type match for pci ranges parser")
> Suggested-by: Rob Herring <robh+dt@kernel.org>
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> ---
>  drivers/of/address.c | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/of/address.c b/drivers/of/address.c
> index 590493e04b01..b37bd9cc2810 100644
> --- a/drivers/of/address.c
> +++ b/drivers/of/address.c
> @@ -128,15 +128,29 @@ static unsigned int of_bus_pci_get_flags(const __be32 *addr)
>   * PCI bus specific translator
>   */
>  
> +static bool of_node_is_pcie(struct device_node *np)
> +{
> +	bool is_pcie = of_node_name_eq(np, "pcie");
> +
> +	if (is_pcie)
> +		pr_warn_once("%pOF: Missing device_type\n", np);
> +
> +	return is_pcie;
> +}
> +
>  static int of_bus_pci_match(struct device_node *np)
>  {
>  	/*
>   	 * "pciex" is PCI Express
>  	 * "vci" is for the /chaos bridge on 1st-gen PCI powermacs
>  	 * "ht" is hypertransport
> +	 *
> +	 * If none of the device_type match, and that the node name is
> +	 * "pcie", accept the device as PCI (with a warning).
>  	 */
>  	return of_node_is_type(np, "pci") || of_node_is_type(np, "pciex") ||
> -		of_node_is_type(np, "vci") || of_node_is_type(np, "ht");
> +		of_node_is_type(np, "vci") || of_node_is_type(np, "ht") ||
> +		of_node_is_pcie(np);
>  }
>  
>  static void of_bus_pci_count_cells(struct device_node *np,
> -- 
> 2.27.0
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
Regards,
Niklas Söderlund
