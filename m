Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7AD449F5F9
	for <lists+linux-pci@lfdr.de>; Fri, 28 Jan 2022 10:08:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233652AbiA1JIN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 28 Jan 2022 04:08:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231432AbiA1JIN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 28 Jan 2022 04:08:13 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FE1AC061714
        for <linux-pci@vger.kernel.org>; Fri, 28 Jan 2022 01:08:13 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1nDNEg-00082M-Vr; Fri, 28 Jan 2022 10:08:03 +0100
Message-ID: <dd30b476f0378a4ae4639ffff635e55093bd070c.camel@pengutronix.de>
Subject: Re: [RFC PATCH] PCI: imx6: Handle the abort from user-space
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Francesco Dolcini <francesco.dolcini@toradex.com>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?UTF-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Jason Liu <jason.hui.liu@nxp.com>
Cc:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Shawn Guo <shawnguo@kernel.org>
Date:   Fri, 28 Jan 2022 10:07:58 +0100
In-Reply-To: <20220128082920.591115-1-francesco.dolcini@toradex.com>
References: <20220128082920.591115-1-francesco.dolcini@toradex.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 (3.40.4-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pci@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Am Freitag, dem 28.01.2022 um 09:29 +0100 schrieb Francesco Dolcini:
> From: Jason Liu <jason.hui.liu@nxp.com>
> 
> The driver install one hook to handle the external abort, but issue
> is that if the abort introduced from user space code, the following
> code unsigned long instr = *(unsigned long *)pc; which will created
> another data-abort(page domain fault) if CONFIG_CPU_SW_DOMAIN_PAN.
> 
> The patch does not intent to use copy_from_user and then do the hack
> due to the security consideration. In fact, we can just return and
> report the external abort to user-space.
> 
I'm not sure how userspace would be able to trigger this abort. Maybe
invalid access to a device cfg space via sysfs?

However the patch seems to do the right thing in that case.

Acked-by: Lucas Stach <l.stach@pengutronix.de>
 
> Signed-off-by: Jason Liu <jason.hui.liu@nxp.com>
> Reviewed-by: Richard Zhu <hongxing.zhu@nxp.com>
> Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
> ---
> We have this patch from NXP downstream kernel [1] in our kernel branch [2]
> since a long time, to me it would make sense to upstream it. Any concern?
> 
> [1] https://source.codeaurora.org/external/imxsupport/linux-imx/commit/?id=62dfb2fb953463dd1b6710567c9e174672a98f24
> [2] https://git.toradex.com/cgit/linux-toradex.git/commit/?id=2b42547cf659f979be2defdff6a99f921b33d0f1
> ---
>  drivers/pci/controller/dwc/pci-imx6.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index 6974bd5aa116..6b178a29e253 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -27,6 +27,7 @@
>  #include <linux/resource.h>
>  #include <linux/signal.h>
>  #include <linux/types.h>
> +#include <linux/uaccess.h>
>  #include <linux/interrupt.h>
>  #include <linux/reset.h>
>  #include <linux/phy/phy.h>
> @@ -297,8 +298,15 @@ static int imx6q_pcie_abort_handler(unsigned long addr,
>  		unsigned int fsr, struct pt_regs *regs)
>  {
>  	unsigned long pc = instruction_pointer(regs);
> -	unsigned long instr = *(unsigned long *)pc;
> -	int reg = (instr >> 12) & 15;
> +	unsigned long instr;
> +	int reg;
> +
> +	/* if the abort from user-space, just return and report it */
> +	if (user_mode(regs))
> +		return 1;
> +
> +	instr = *(unsigned long *)pc;
> +	reg = (instr >> 12) & 15;
>  
>  	/*
>  	 * If the instruction being executed was a read,


