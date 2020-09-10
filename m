Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A5BD264938
	for <lists+linux-pci@lfdr.de>; Thu, 10 Sep 2020 17:59:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731241AbgIJP7E (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 10 Sep 2020 11:59:04 -0400
Received: from mail-il1-f195.google.com ([209.85.166.195]:44489 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731529AbgIJP5P (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 10 Sep 2020 11:57:15 -0400
Received: by mail-il1-f195.google.com with SMTP id h11so6095177ilj.11;
        Thu, 10 Sep 2020 08:56:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=75EPNsIBYVup6AIGiJwzSdSJw0NGHqRELWm5o6mzFMs=;
        b=OFDjh6hXcTEHijVpQPKY2/5EJ9quxQApX6oyZHIpX8M2xXFg+f+Z7HwXbjiexxblCb
         6LNbcVaev6A3zSUmi42nhcqgTr7D/DVyfOH5FWibGfMNKVlXNO00LwZlv10eNdBW/gvv
         lHJBcMZs+GRUToF14HtoW0tQzNXTQHryrO9b2XMNlccxSBxXrDsz3ozBzB+zMVvVHdHV
         wmp5I5dZOe1gV03HNErhwQaCwjp+nHeDB/KaV5XvpMW690SCCgPCb6dpxIy/giNWQZxI
         fyz1twZJpg6Pq7X6k/P9pfKV+sqidHiMqk8PjIjqqzX09rSsT5iIg3tqIlHxomkWiC0c
         M4fg==
X-Gm-Message-State: AOAM530QzhnanBZRfYCj/+zKcYWquXqhlzcfDRvJzXT95yhaQK4D8OCL
        JXRZ1T2+GprIJvDHIQVeMiTNnwkeAToe
X-Google-Smtp-Source: ABdhPJy4YBC4Og5nCPNZgXln9mIj11eNmiP8UC9Zd2pwLdDntsNRTIUnoo41piAt35aUn1jJdSewgA==
X-Received: by 2002:a92:7984:: with SMTP id u126mr7266050ilc.139.1599753398667;
        Thu, 10 Sep 2020 08:56:38 -0700 (PDT)
Received: from xps15 ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id s17sm1301374ilb.24.2020.09.10.08.56.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2020 08:56:38 -0700 (PDT)
Received: (nullmailer pid 439332 invoked by uid 1000);
        Thu, 10 Sep 2020 15:56:37 -0000
Date:   Thu, 10 Sep 2020 09:56:37 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jim Quinlan <james.quinlan@broadcom.com>
Cc:     linux-pci@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Christoph Hellwig <hch@lst.de>,
        Robin Murphy <robin.murphy@arm.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v11 04/11] PCI: brcmstb: Add suspend and resume pm_ops
Message-ID: <20200910155637.GA423872@bogus>
References: <20200824193036.6033-1-james.quinlan@broadcom.com>
 <20200824193036.6033-5-james.quinlan@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200824193036.6033-5-james.quinlan@broadcom.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Aug 24, 2020 at 03:30:17PM -0400, Jim Quinlan wrote:
> From: Jim Quinlan <jquinlan@broadcom.com>
> 
> Broadcom Set-top (BrcmSTB) boards typically support S2, S3, and S5 suspend
> and resume.  Now the PCIe driver may do so as well.
> 
> Signed-off-by: Jim Quinlan <jquinlan@broadcom.com>
> Acked-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  drivers/pci/controller/pcie-brcmstb.c | 47 +++++++++++++++++++++++++++
>  1 file changed, 47 insertions(+)
> 
> diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
> index c2b3d2946a36..3d588ab7a6dd 100644
> --- a/drivers/pci/controller/pcie-brcmstb.c
> +++ b/drivers/pci/controller/pcie-brcmstb.c
> @@ -978,6 +978,47 @@ static void brcm_pcie_turn_off(struct brcm_pcie *pcie)
>  	brcm_pcie_bridge_sw_init_set(pcie, 1);
>  }
>  
> +static int brcm_pcie_suspend(struct device *dev)
> +{
> +	struct brcm_pcie *pcie = dev_get_drvdata(dev);
> +
> +	brcm_pcie_turn_off(pcie);
> +	clk_disable_unprepare(pcie->clk);
> +
> +	return 0;
> +}
> +
> +static int brcm_pcie_resume(struct device *dev)
> +{
> +	struct brcm_pcie *pcie = dev_get_drvdata(dev);
> +	void __iomem *base;
> +	u32 tmp;
> +	int ret;
> +
> +	base = pcie->base;
> +	clk_prepare_enable(pcie->clk);
> +
> +	/* Take bridge out of reset so we can access the SERDES reg */
> +	brcm_pcie_bridge_sw_init_set(pcie, 0);
> +
> +	/* SERDES_IDDQ = 0 */
> +	tmp = readl(base + PCIE_MISC_HARD_PCIE_HARD_DEBUG);
> +	u32p_replace_bits(&tmp, 0, PCIE_MISC_HARD_PCIE_HARD_DEBUG_SERDES_IDDQ_MASK);
> +	writel(tmp, base + PCIE_MISC_HARD_PCIE_HARD_DEBUG);
> +
> +	/* wait for serdes to be stable */
> +	udelay(100);

Really needs to be a spinloop?

> +
> +	ret = brcm_pcie_setup(pcie);
> +	if (ret)
> +		return ret;
> +
> +	if (pcie->msi)
> +		brcm_msi_set_regs(pcie->msi);
> +
> +	return 0;
> +}
> +
>  static void __brcm_pcie_remove(struct brcm_pcie *pcie)
>  {
>  	brcm_msi_remove(pcie);
> @@ -1087,12 +1128,18 @@ static int brcm_pcie_probe(struct platform_device *pdev)
>  
>  MODULE_DEVICE_TABLE(of, brcm_pcie_match);
>  
> +static const struct dev_pm_ops brcm_pcie_pm_ops = {
> +	.suspend_noirq = brcm_pcie_suspend,
> +	.resume_noirq = brcm_pcie_resume,

Why do you need interrupts disabled? There's 39 cases of .suspend_noirq 
and 1352 of .suspend in the tree.

Is doing a clk unprepare even safe in .suspend_noirq? IIRC, 
prepare/unprepare can sleep.

> +};
> +
>  static struct platform_driver brcm_pcie_driver = {
>  	.probe = brcm_pcie_probe,
>  	.remove = brcm_pcie_remove,
>  	.driver = {
>  		.name = "brcm-pcie",
>  		.of_match_table = brcm_pcie_match,
> +		.pm = &brcm_pcie_pm_ops,
>  	},
>  };
>  module_platform_driver(brcm_pcie_driver);
> -- 
> 2.17.1
> 
