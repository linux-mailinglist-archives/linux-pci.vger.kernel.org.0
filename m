Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80D1C46B014
	for <lists+linux-pci@lfdr.de>; Tue,  7 Dec 2021 02:53:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235603AbhLGB46 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 6 Dec 2021 20:56:58 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:41690 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233991AbhLGB46 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 6 Dec 2021 20:56:58 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 96775B81644;
        Tue,  7 Dec 2021 01:53:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E42ADC004DD;
        Tue,  7 Dec 2021 01:53:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638842006;
        bh=eXTQmCkV7TlQUUyikTeYDDeh2Q2A+dhlVrouNNuPuY4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=pfNIZhoFL5Z2N5wUx7SiDtzqqqsGp1pcVzcbnxzFyBCCu69un9CTSEJm20HqpSa26
         NWERhDKFPo2tvCk+QBNApNV2R0BjzaQb6HEhQPPFiQSS0jfiQdLbxZ8UEMeJ2R47Ek
         RyeS8Q1XhA8bxlJD55FyeVJQqykMHY0AwiVtQOd/qiAqPpL5Z6xLb8vgrfb/8EaWn1
         5DjywXW46pWw0i9TqyPkMmf67XVcYTDuPFW2Q2jR7KumamuczRDHZDMk0vij1pkcNk
         EFuhijwDHyQp+EGTQTaXV75F8r8RbqRorE97rcvUYYRoHosPsrjo3gJsAe41zp0l+9
         2VaYeiXJ7wPww==
Date:   Mon, 6 Dec 2021 19:53:23 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     qizhong cheng <qizhong.cheng@mediatek.com>
Cc:     Ryder Lee <ryder.lee@mediatek.com>,
        Jianjun Wang <jianjun.wang@mediatek.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Krzysztof =?utf-8?Q?Wilczyi=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Chuanjia Liu <chuanjia.liu@mediatek.com>,
        Jiey Yang <ot_jiey.yang@mediatek.com>
Subject: Re: [PATCH] PCI: mediatek: Delay 100ms to wait power and clock to
 become stable
Message-ID: <20211207015323.GA26237@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211104062144.31453-1-qizhong.cheng@mediatek.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Nov 04, 2021 at 02:21:44PM +0800, qizhong cheng wrote:
> Described in PCIe CEM specification setctions 2.2 (PERST# Signal) and
> 2.2.1 (Initial Power-Up (G3 to S0)). The deassertion of PERST# should
> be delayed 100ms (TPVPERL) for the power and clock to become stable.

Thanks for the spec references.

s/setctions/sections/

> Signed-off-by: qizhong cheng <qizhong.cheng@mediatek.com>
> ---
>  drivers/pci/controller/pcie-mediatek.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/pci/controller/pcie-mediatek.c b/drivers/pci/controller/pcie-mediatek.c
> index 2f3f974977a3..b32acbac8084 100644
> --- a/drivers/pci/controller/pcie-mediatek.c
> +++ b/drivers/pci/controller/pcie-mediatek.c
> @@ -702,6 +702,14 @@ static int mtk_pcie_startup_port_v2(struct mtk_pcie_port *port)
>  	 */
>  	writel(PCIE_LINKDOWN_RST_EN, port->base + PCIE_RST_CTRL);
>  
> +	/*
> +	 * Described in PCIe CEM specification setctions 2.2 (PERST# Signal)
> +	 * and 2.2.1 (Initial Power-Up (G3 to S0)).
> +	 * The deassertion of PERST# should be delayed 100ms (TPVPERL)
> +	 * for the power and clock to become stable.

s/setctions/sections/ again.  Otherwise we'll have a typo-fixing patch
eventually.

Please also rewrap into one paragraph.

> +	 */
> +	msleep(100);
> +
>  	/* De-assert PHY, PE, PIPE, MAC and configuration reset	*/
>  	val = readl(port->base + PCIE_RST_CTRL);
>  	val |= PCIE_PHY_RSTB | PCIE_PERSTB | PCIE_PIPE_SRSTB |
> -- 
> 2.25.1
> 
