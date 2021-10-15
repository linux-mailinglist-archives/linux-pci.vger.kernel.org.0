Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D763042FAE4
	for <lists+linux-pci@lfdr.de>; Fri, 15 Oct 2021 20:22:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237755AbhJOSYv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 15 Oct 2021 14:24:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234813AbhJOSYu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 15 Oct 2021 14:24:50 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14DB6C061570
        for <linux-pci@vger.kernel.org>; Fri, 15 Oct 2021 11:22:44 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1mbRqp-0001OM-Qj; Fri, 15 Oct 2021 20:22:39 +0200
Message-ID: <8f855cf445e2b7827524d5d4adfba80d3a924c60.camel@pengutronix.de>
Subject: Re: [RESEND v2 3/5] PCI: imx6: Fix the regulator dump when link
 never came up
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Richard Zhu <hongxing.zhu@nxp.com>, bhelgaas@google.com,
        lorenzo.pieralisi@arm.com
Cc:     linux-pci@vger.kernel.org, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de
Date:   Fri, 15 Oct 2021 20:22:38 +0200
In-Reply-To: <1634277941-6672-4-git-send-email-hongxing.zhu@nxp.com>
References: <1634277941-6672-1-git-send-email-hongxing.zhu@nxp.com>
         <1634277941-6672-4-git-send-email-hongxing.zhu@nxp.com>
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

Am Freitag, dem 15.10.2021 um 14:05 +0800 schrieb Richard Zhu:
> When PCIe PHY link never came up and vpcie regulator is present, there
> would be following dump when try to put the regulator.
> Disable this regulator to fix this dump when link never came up.
> 
>   imx6q-pcie 33800000.pcie: Phy link never came up
>   imx6q-pcie: probe of 33800000.pcie failed with error -110
>   ------------[ cut here ]------------
>   WARNING: CPU: 3 PID: 119 at drivers/regulator/core.c:2256 _regulator_put.part.0+0x14c/0x158
>   Modules linked in:
>   CPU: 3 PID: 119 Comm: kworker/u8:2 Not tainted 5.13.0-rc7-next-20210625-94710-ge4e92b2588a3 #10
>   Hardware name: FSL i.MX8MM EVK board (DT)
>   Workqueue: events_unbound async_run_entry_fn
>   pstate: 80000005 (Nzcv daif -PAN -UAO -TCO BTYPE=--)
>   pc : _regulator_put.part.0+0x14c/0x158
>   lr : regulator_put+0x34/0x48
>   sp : ffff8000122ebb30
>   x29: ffff8000122ebb30 x28: ffff800011be7000 x27: 0000000000000000
>   x26: 0000000000000000 x25: 0000000000000000 x24: ffff00000025f2bc
>   x23: ffff00000025f2c0 x22: ffff00000025f010 x21: ffff8000122ebc18
>   x20: ffff800011e3fa60 x19: ffff00000375fd80 x18: 0000000000000010
>   x17: 000000040044ffff x16: 00400032b5503510 x15: 0000000000000108
>   x14: ffff0000003cc938 x13: 00000000ffffffea x12: 0000000000000000
>   x11: 0000000000000000 x10: ffff80001076ba88 x9 : ffff80001076a540
>   x8 : ffff00000025f2c0 x7 : ffff0000001f4450 x6 : ffff000000176cd8
>   x5 : ffff000003857880 x4 : 0000000000000000 x3 : ffff800011e3fe30
>   x2 : ffff0000003cc4c0 x1 : 0000000000000000 x0 : 0000000000000001
>   Call trace:
>    _regulator_put.part.0+0x14c/0x158
>    regulator_put+0x34/0x48
>    devm_regulator_release+0x10/0x18
>    release_nodes+0x38/0x60
>    devres_release_all+0x88/0xd0
>    really_probe+0xd0/0x2e8
>    __driver_probe_device+0x74/0xd8
>    driver_probe_device+0x7c/0x108
>    __device_attach_driver+0x8c/0xd0
>    bus_for_each_drv+0x74/0xc0
>    __device_attach_async_helper+0xb4/0xd8
>    async_run_entry_fn+0x30/0x100
>    process_one_work+0x19c/0x320
>    worker_thread+0x48/0x418
>    kthread+0x14c/0x158
>    ret_from_fork+0x10/0x18
>   ---[ end trace 3664ca4a50ce849b ]---
> 
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> ---
>  drivers/pci/controller/dwc/pci-imx6.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index 3372775834a2..cc837f8bf6d4 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -853,6 +853,8 @@ static int imx6_pcie_start_link(struct dw_pcie *pci)
>  		dw_pcie_readl_dbi(pci, PCIE_PORT_DEBUG0),
>  		dw_pcie_readl_dbi(pci, PCIE_PORT_DEBUG1));
>  	imx6_pcie_reset_phy(imx6_pcie);
> +	if (imx6_pcie->vpcie && regulator_is_enabled(imx6_pcie->vpcie) > 0)
> +		regulator_disable(imx6_pcie->vpcie);

This doesn't seem like the right place to add this. I guess it would be
better to have proper error handling after dw_pcie_host_init to roll
back things like the clock and regulator enable.

Regards,
Lucas

>  	return ret;
>  }
>  


