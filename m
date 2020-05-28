Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BF311E68DF
	for <lists+linux-pci@lfdr.de>; Thu, 28 May 2020 19:53:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405639AbgE1Rxv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 28 May 2020 13:53:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405636AbgE1Rxu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 28 May 2020 13:53:50 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84A3BC08C5C6
        for <linux-pci@vger.kernel.org>; Thu, 28 May 2020 10:53:50 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id z15so2320997pjb.0
        for <linux-pci@vger.kernel.org>; Thu, 28 May 2020 10:53:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=YhNvAW92ZEK9h867b9iS1cctCTKmkiLmuttZMDJHtJE=;
        b=emHONirD3EAxo3LU0LbehdMV2tvAYzhhZj+1YScvp5WcGmvA3O1HiPHHAhkB5/i2I8
         AwKkbxcjFa4qDTdVR7oY+EQ3fgFNOCNkmf+pBLAIRxTbLmGBjOquLusQ4rDcSfHpH1Se
         lrnGl4e/MGk5aZOcMKC+UUVrqtpA0npeJ6Sho=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=YhNvAW92ZEK9h867b9iS1cctCTKmkiLmuttZMDJHtJE=;
        b=kS7c9QmX+PUHwM6Fin/tBUoAJTOfABaG6Gf38vALL92/41ZJWcf88DFbBkTLq6FBg1
         6jIkDCUN1Q2nNFOpf7U4HZUb/FoFa1W53GM8MM3etoAP7yZhKMTG4qDILa3vFeWfWdYn
         GK3jaTi+pk6j2vryOnx6CjhUyUjSYyX7H5+IlQTgkYP5U2qFENasiEorhIj24BIYhw0m
         1SZMlLHrYPcYSpkRf8H5sqK4kxW7pTfHKfFWh7CHKMyIrjMwSRSXCO2j2jGSfXXZwGJ9
         jcJiawJE6aeRUbCO+ZfGJsad5QclCScqxxcYZr0EYuVr/DalZOGQakaeZpzY+gASkQqY
         xmXA==
X-Gm-Message-State: AOAM531nNVXI4Bi6x5abhbNzMW8BfCFgXMvVabKDMkA1woj1Dzg2YflA
        6+Cwg/Gjxoi8yxCfgo9uSSDODA==
X-Google-Smtp-Source: ABdhPJz39e6oQezEw97jMiTLOwizsYhOWisoOEQMD7a0yn+8WmCvramZUqi5jMADbrC+KSjdBVmKPw==
X-Received: by 2002:a17:902:ff09:: with SMTP id f9mr4855405plj.322.1590688429968;
        Thu, 28 May 2020 10:53:49 -0700 (PDT)
Received: from [10.136.13.65] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id x8sm2161803pfm.202.2020.05.28.10.53.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 May 2020 10:53:49 -0700 (PDT)
Subject: Re: [PATCH 11/15] PCI: iproc: Use pci_host_probe() to register host
To:     Rob Herring <robh@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com
References: <20200522234832.954484-1-robh@kernel.org>
 <20200522234832.954484-12-robh@kernel.org>
From:   Scott Branden <scott.branden@broadcom.com>
Message-ID: <9da2fea3-85bb-a137-c7a8-82cb5eae6d44@broadcom.com>
Date:   Thu, 28 May 2020 10:53:46 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200522234832.954484-12-robh@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2020-05-22 4:48 p.m., Rob Herring wrote:
> The iproc host driver does the same host registration and bus scanning
> calls as pci_host_probe, so let's use it instead.
>
> The only difference is pci_assign_unassigned_bus_resources() was called
> instead of pci_bus_size_bridges() and pci_bus_assign_resources(). This
> should be the same.
>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Ray Jui <rjui@broadcom.com>
> Cc: Scott Branden <sbranden@broadcom.com>
> Cc: bcm-kernel-feedback-list@broadcom.com
> Signed-off-by: Rob Herring <robh@kernel.org>
Acked-by: Scott Branden <scott.branden@broadcom.com>
> ---
>   drivers/pci/controller/pcie-iproc.c | 18 +++++-------------
>   drivers/pci/controller/pcie-iproc.h |  2 --
>   2 files changed, 5 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/pci/controller/pcie-iproc.c b/drivers/pci/controller/pcie-iproc.c
> index 8c7f875acf7f..232fca0754e1 100644
> --- a/drivers/pci/controller/pcie-iproc.c
> +++ b/drivers/pci/controller/pcie-iproc.c
> @@ -1470,7 +1470,6 @@ int iproc_pcie_setup(struct iproc_pcie *pcie, struct list_head *res)
>   {
>   	struct device *dev;
>   	int ret;
> -	struct pci_bus *child;
>   	struct pci_host_bridge *host = pci_host_bridge_from_priv(pcie);
>   
>   	dev = pcie->dev;
> @@ -1531,21 +1530,12 @@ int iproc_pcie_setup(struct iproc_pcie *pcie, struct list_head *res)
>   	host->map_irq = pcie->map_irq;
>   	host->swizzle_irq = pci_common_swizzle;
>   
> -	ret = pci_scan_root_bus_bridge(host);
> +	ret = pci_host_probe(host);
>   	if (ret < 0) {
>   		dev_err(dev, "failed to scan host: %d\n", ret);
>   		goto err_power_off_phy;
>   	}
>   
> -	pci_assign_unassigned_bus_resources(host->bus);
> -
> -	pcie->root_bus = host->bus;
> -
> -	list_for_each_entry(child, &host->bus->children, node)
> -		pcie_bus_configure_settings(child);
> -
> -	pci_bus_add_devices(host->bus);
> -
>   	return 0;
>   
>   err_power_off_phy:
> @@ -1558,8 +1548,10 @@ EXPORT_SYMBOL(iproc_pcie_setup);
>   
>   int iproc_pcie_remove(struct iproc_pcie *pcie)
>   {
> -	pci_stop_root_bus(pcie->root_bus);
> -	pci_remove_root_bus(pcie->root_bus);
> +	struct pci_host_bridge *host = pci_host_bridge_from_priv(pcie);
> +
> +	pci_stop_root_bus(host->bus);
> +	pci_remove_root_bus(host->bus);
>   
>   	iproc_pcie_msi_disable(pcie);
>   
> diff --git a/drivers/pci/controller/pcie-iproc.h b/drivers/pci/controller/pcie-iproc.h
> index 4f03ea539805..c2676e442f55 100644
> --- a/drivers/pci/controller/pcie-iproc.h
> +++ b/drivers/pci/controller/pcie-iproc.h
> @@ -54,7 +54,6 @@ struct iproc_msi;
>    * @reg_offsets: register offsets
>    * @base: PCIe host controller I/O register base
>    * @base_addr: PCIe host controller register base physical address
> - * @root_bus: pointer to root bus
>    * @phy: optional PHY device that controls the Serdes
>    * @map_irq: function callback to map interrupts
>    * @ep_is_internal: indicates an internal emulated endpoint device is connected
> @@ -85,7 +84,6 @@ struct iproc_pcie {
>   	void __iomem *base;
>   	phys_addr_t base_addr;
>   	struct resource mem;
> -	struct pci_bus *root_bus;
>   	struct phy *phy;
>   	int (*map_irq)(const struct pci_dev *, u8, u8);
>   	bool ep_is_internal;

