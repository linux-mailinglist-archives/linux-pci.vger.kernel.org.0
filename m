Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0C7F46BADE
	for <lists+linux-pci@lfdr.de>; Tue,  7 Dec 2021 13:17:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231804AbhLGMUg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 7 Dec 2021 07:20:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236191AbhLGMUe (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 7 Dec 2021 07:20:34 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2844CC061748;
        Tue,  7 Dec 2021 04:17:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E3A54B81760;
        Tue,  7 Dec 2021 12:17:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74C30C341C6;
        Tue,  7 Dec 2021 12:17:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638879421;
        bh=KDt8PPYWG58ffYc2l1pOEsORKmSleEnHCgAKOfDzXCg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=nglkm3J3vdcOyNSkEw2XQDC3fMXOim+pTw9GEuMSw/xSwQY3lvYSIKwmoxLCrVgh2
         wfJ0M6/wjx1plTYCtWZv/EBMbHjQeAfsml7uo43hBnRWQHBDPcpAWz7sD8nAEYqvfG
         T5Bgq3j/s+EY88LWu0nzypV/4Yw66LxtgIlirU19c3Fs54NicnBqeMHN4c1CJygezW
         sP74ug9x8kz6sWQ8QUtA7oCVSQZNZAxv5gP58qIRQmVucC7gJqewBj+i7nyiuZynUi
         VOgM5oxTM5xUdKoFJyMwcI2UcaOE4M8pQcxVgieEbhQVbsCpoCuYN9On4IQYKUMaf/
         Ax298oNyc6x2Q==
Date:   Tue, 7 Dec 2021 06:16:59 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     qizhong cheng <qizhong.cheng@mediatek.com>
Cc:     Ryder Lee <ryder.lee@mediatek.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Jianjun Wang <jianjun.wang@mediatek.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, chuanjia.liu@mediatek.com
Subject: Re: [PATCH] PCI: mediatek: Delay 100ms to wait power and clock to
 become stable
Message-ID: <20211207121659.GA36700@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211207060550.20918-1-qizhong.cheng@mediatek.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

In the subject:

  PCI: mediatek: Assert PERST# for 100ms for power and clock to stabilize

On Tue, Dec 07, 2021 at 02:05:50PM +0800, qizhong cheng wrote:
> Described in PCIe CEM specification setctions 2.2 (PERST# Signal) and
> 2.2.1 (Initial Power-Up (G3 to S0)). The deassertion of PERST# should
> be delayed 100ms (TPVPERL) for the power and clock to become stable.

Please fix the typos above and in the comment below: "setctions"
should be "sections".

I mentioned this yesterday:
https://lore.kernel.org/all/20211207015323.GA26237@bhelgaas/

But maybe the "s/setctions/sections/" notation wasn't obvious.
This is used in sed, vi, and other tools, and it is a command
that searches for the first regular expression ("setctions") and
replaces it with the second ("sections").

> Signed-off-by: qizhong cheng <qizhong.cheng@mediatek.com>
> Change-Id: Ia9abe1e763564a5bad1d045fd268c38e76e2ae95

No need for the "Change-Id".  I assume this came from a gerrit server
somewhere, but unless there's something to tell us *which* server that
is, and unless that server is public, this isn't really useful.

> ---
>  drivers/pci/controller/pcie-mediatek.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/pci/controller/pcie-mediatek.c b/drivers/pci/controller/pcie-mediatek.c
> index 2f3f974977a3..a61ea3940471 100644
> --- a/drivers/pci/controller/pcie-mediatek.c
> +++ b/drivers/pci/controller/pcie-mediatek.c
> @@ -702,6 +702,13 @@ static int mtk_pcie_startup_port_v2(struct mtk_pcie_port *port)
>  	 */
>  	writel(PCIE_LINKDOWN_RST_EN, port->base + PCIE_RST_CTRL);
>  
> +	/*
> +	 * Described in PCIe CEM specification setctions 2.2 (PERST# Signal) and
> +	 * 2.2.1 (Initial Power-Up (G3 to S0)). The deassertion of PERST# should
> +	 * be delayed 100ms (TPVPERL) for the power and clock to become stable.
> +	 */
> +	msleep(100);
> +
>  	/* De-assert PHY, PE, PIPE, MAC and configuration reset	*/
>  	val = readl(port->base + PCIE_RST_CTRL);
>  	val |= PCIE_PHY_RSTB | PCIE_PERSTB | PCIE_PIPE_SRSTB |
> -- 
> 2.25.1
> 
