Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BA06227A50
	for <lists+linux-pci@lfdr.de>; Tue, 21 Jul 2020 10:16:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726214AbgGUIQF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 21 Jul 2020 04:16:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725984AbgGUIQF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 21 Jul 2020 04:16:05 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46D62C061794
        for <linux-pci@vger.kernel.org>; Tue, 21 Jul 2020 01:16:05 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=localhost)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1jxnRS-0000UG-Aj; Tue, 21 Jul 2020 10:16:02 +0200
Message-ID: <d8760e851fdf8a934dca20a9440bced16bb39123.camel@pengutronix.de>
Subject: Re: [PATCH 1/2] ARM: dts: imx6qp-sabresd: enable pcie
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Richard Zhu <hongxing.zhu@nxp.com>, bhelgaas@google.com,
        shawnguo@kernel.org, festevam@gmail.com
Cc:     linux-pci@vger.kernel.org, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de
Date:   Tue, 21 Jul 2020 10:16:01 +0200
In-Reply-To: <1595317470-9394-1-git-send-email-hongxing.zhu@nxp.com>
References: <1595317470-9394-1-git-send-email-hongxing.zhu@nxp.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.3 (3.36.3-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pci@vger.kernel.org
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Am Dienstag, den 21.07.2020, 15:44 +0800 schrieb Richard Zhu:
> Add one regulator, used to power up the external oscillator,
> and enable PCIe on iMX6QP SABRESD board.

That's not the right thing to do. If there is an external oscillator,
which requires a power supply then the oscillator should have its own
clock DT node (it's a separate device after all) and this node needs to
control the regulator.

This has nothing to do with the PCIe controller, which only cares about
the clock being provided.

Regards,
Lucas

> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> ---
>  arch/arm/boot/dts/imx6qp-sabresd.dts | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/imx6qp-sabresd.dts
> b/arch/arm/boot/dts/imx6qp-sabresd.dts
> index 480e73183f6b..cd8a1f610427 100644
> --- a/arch/arm/boot/dts/imx6qp-sabresd.dts
> +++ b/arch/arm/boot/dts/imx6qp-sabresd.dts
> @@ -51,7 +51,8 @@
>  };
>  
>  &pcie {
> -	status = "disabled";
> +	vepdev-supply = <&vgen3_reg>;
> +	status = "okay";
>  };
>  
>  &sata {

