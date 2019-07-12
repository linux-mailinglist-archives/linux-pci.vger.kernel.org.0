Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4F9A467099
	for <lists+linux-pci@lfdr.de>; Fri, 12 Jul 2019 15:54:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726724AbfGLNyS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 12 Jul 2019 09:54:18 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:56385 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726254AbfGLNyS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 12 Jul 2019 09:54:18 -0400
Received: from [2001:67c:670:100:6a05:caff:fe2d:a9b1]
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <a.fatoum@pengutronix.de>)
        id 1hlw09-00058S-39; Fri, 12 Jul 2019 15:54:17 +0200
Subject: Re: [PATCH] PCI: dwc: avoid OOB read in find_next_bit
To:     Lucas Stach <l.stach@pengutronix.de>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     linux-pci@vger.kernel.org, kernel@pengutronix.de,
        patchwork-lst@pengutronix.de
References: <20190712132611.3374-1-l.stach@pengutronix.de>
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
Message-ID: <06320942-63ce-7233-b3a5-5c4e00a36dc0@pengutronix.de>
Date:   Fri, 12 Jul 2019 15:54:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190712132611.3374-1-l.stach@pengutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:6a05:caff:fe2d:a9b1
X-SA-Exim-Mail-From: a.fatoum@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pci@vger.kernel.org
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello Lucas,

On 7/12/19 3:26 PM, Lucas Stach wrote:
> Find_next_bit works on a long type, which causes a OOB read on the
> u32 input when used on ARM64.
> 
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> ---
>  drivers/pci/controller/dwc/pcie-designware-host.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index 77db32529319..81a2139d68d6 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -78,15 +78,16 @@ static struct msi_domain_info dw_pcie_msi_domain_info = {
>  irqreturn_t dw_handle_msi_irq(struct pcie_port *pp)
>  {
>  	int i, pos, irq;
> -	u32 val, num_ctrls;
> +	u32 num_ctrls;
>  	irqreturn_t ret = IRQ_NONE;
> +	unsigned long val;
>  
>  	num_ctrls = pp->num_vectors / MAX_MSI_IRQS_PER_CTRL;
>  
>  	for (i = 0; i < num_ctrls; i++) {
>  		dw_pcie_rd_own_conf(pp, PCIE_MSI_INTR0_STATUS +
>  					(i * MSI_REG_CTRL_BLOCK_SIZE),
> -				    4, &val);
> +				    4, (u32 *)&val);

Wouldn't this still be wrong on big-endian 64-bit systems?
You're writing the first 4 bytes here, leaving the higher 4 uninitialized.
find_next_bit will read the lowest-valued 32-bits, i.e. the highest
four on ARM64, which are uninitialized.


>  		if (!val)
>  			continue;
>  
> 


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
