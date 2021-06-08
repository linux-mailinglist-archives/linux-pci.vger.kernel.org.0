Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6931439EF18
	for <lists+linux-pci@lfdr.de>; Tue,  8 Jun 2021 08:56:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229507AbhFHG55 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 8 Jun 2021 02:57:57 -0400
Received: from regular1.263xmail.com ([211.150.70.206]:47228 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230323AbhFHG54 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 8 Jun 2021 02:57:56 -0400
X-Greylist: delayed 406 seconds by postgrey-1.27 at vger.kernel.org; Tue, 08 Jun 2021 02:57:56 EDT
Received: from localhost (unknown [192.168.167.32])
        by regular1.263xmail.com (Postfix) with ESMTP id 92D1C1B43;
        Tue,  8 Jun 2021 14:48:47 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-SKE-CHECKED: 1
X-ABS-CHECKED: 1
Received: from [172.16.12.64] (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P30809T139674015004416S1623134925256256_;
        Tue, 08 Jun 2021 14:48:46 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <f6723536972b33749120c29e955b16f5>
X-RL-SENDER: shawn.lin@rock-chips.com
X-SENDER: lintao@rock-chips.com
X-LOGIN-NAME: shawn.lin@rock-chips.com
X-FST-TO: javierm@redhat.com
X-RCPT-COUNT: 11
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-System-Flag: 0
Message-ID: <c3f49fe5-edbe-2889-bd59-92891adc807b@rock-chips.com>
Date:   Tue, 8 Jun 2021 14:48:45 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:90.0) Gecko/20100101
 Thunderbird/90.0
Cc:     shawn.lin@rock-chips.com, Peter Robinson <pbrobinson@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: =?UTF-8?Q?Re=3a_=5bPATCH=5d_PCI=3a_rockchip=3a_Avoid_accessing_PCIe?=
 =?UTF-8?B?IHJlZ2lzdGVycyB3aXRoIGNsb2NrcyBnYXRlZOOAkOivt+azqOaEj++8jOmCrg==?=
 =?UTF-8?Q?=e4=bb=b6=e7=94=b1linux-rockchip-bounces+shawn=2elin=3drock-chips?=
 =?UTF-8?B?LmNvbUBsaXN0cy5pbmZyYWRlYWQub3Jn5Luj5Y+R44CR?=
To:     Javier Martinez Canillas <javierm@redhat.com>
References: <20210607213328.1711570-1-javierm@redhat.com>
From:   Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <20210607213328.1711570-1-javierm@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2021/6/8 5:33, Javier Martinez Canillas wrote:
> IRQ handlers that are registered for shared interrupts can be called at
> any time after have been registered using the request_irq() function.
> 
> It's up to drivers to ensure that's always safe for these to be called.
> 
> Both the "pcie-sys" and "pcie-client" interrupts are shared, but since
> their handlers are registered very early in the probe function, an error
> later can lead to these handlers being executed before all the required
> have been properly setup.
> 
> For example, the rockchip_pcie_read() function used by these IRQ handlers
> expects that some PCIe clocks will already be enabled, otherwise trying
> to access the PCIe registers causes the read to hang and never return.
> 
> The CONFIG_DEBUG_SHIRQ option tests if drivers are able to cope with their
> shared interrupt handlers being called, by generating a spurious interrupt
> just before a shared interrupt handler is unregistered.
> 
> But this means that if the option is enabled, any error in the probe path
> of this driver could lead to one of the IRQ handlers to be executed.
> 
> In a rockpro64 board, the following sequence of events happens:
> 
>    1) "pcie-sys" IRQ is requested and its handler registered.
>    2) "pcie-client" IRQ is requested and its handler registered.
>    3) probe later fails due readl_poll_timeout() returning a timeout.
>    4) the "pcie-sys" IRQ is unregistered.
>    5) CONFIG_DEBUG_SHIRQ triggers a spurious interrupt.
>    6) "pcie-client" IRQ handler is called for this spurious interrupt.
>    7) IRQ handler tries to read PCIE_CLIENT_INT_STATUS with clocks gated.
>    8) the machine hangs because rockchip_pcie_read() call never returns.
> 
> To avoid cases like this, the handlers don't have to be registered until
> very late in the probe function, once all the resources have been setup.
> 
> So let's just move all the IRQ init before the pci_host_probe() call, that
> will prevent issues like this and seems to be the correct thing to do too.
> 

Acked-by: Shawn Lin <shawn.lin@rock-chips.com>

Thanks.

> Reported-by: Peter Robinson <pbrobinson@gmail.com>
> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
> ---
> 
>   drivers/pci/controller/pcie-rockchip-host.c | 12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-rockchip-host.c b/drivers/pci/controller/pcie-rockchip-host.c
> index f1d08a1b159..78d04ac29cd 100644
> --- a/drivers/pci/controller/pcie-rockchip-host.c
> +++ b/drivers/pci/controller/pcie-rockchip-host.c
> @@ -592,10 +592,6 @@ static int rockchip_pcie_parse_host_dt(struct rockchip_pcie *rockchip)
>   	if (err)
>   		return err;
>   
> -	err = rockchip_pcie_setup_irq(rockchip);
> -	if (err)
> -		return err;
> -
>   	rockchip->vpcie12v = devm_regulator_get_optional(dev, "vpcie12v");
>   	if (IS_ERR(rockchip->vpcie12v)) {
>   		if (PTR_ERR(rockchip->vpcie12v) != -ENODEV)
> @@ -973,8 +969,6 @@ static int rockchip_pcie_probe(struct platform_device *pdev)
>   	if (err)
>   		goto err_vpcie;
>   
> -	rockchip_pcie_enable_interrupts(rockchip);
> -
>   	err = rockchip_pcie_init_irq_domain(rockchip);
>   	if (err < 0)
>   		goto err_deinit_port;
> @@ -992,6 +986,12 @@ static int rockchip_pcie_probe(struct platform_device *pdev)
>   	bridge->sysdata = rockchip;
>   	bridge->ops = &rockchip_pcie_ops;
>   
> +	err = rockchip_pcie_setup_irq(rockchip);
> +	if (err)
> +		goto err_remove_irq_domain;
> +
> +	rockchip_pcie_enable_interrupts(rockchip);
> +
>   	err = pci_host_probe(bridge);
>   	if (err < 0)
>   		goto err_remove_irq_domain;
> 


