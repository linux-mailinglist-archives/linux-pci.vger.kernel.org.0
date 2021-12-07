Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33B6346C230
	for <lists+linux-pci@lfdr.de>; Tue,  7 Dec 2021 18:54:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234363AbhLGR5x (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 7 Dec 2021 12:57:53 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:56598 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234315AbhLGR5w (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 7 Dec 2021 12:57:52 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 3D466CE1C9A;
        Tue,  7 Dec 2021 17:54:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C3AFC341C3;
        Tue,  7 Dec 2021 17:54:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638899658;
        bh=kVi8XrFSssRXT3rgDgO1jjnYQhug1iemGioceZ8LSLU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=CVEsPspzTJfq0TiQD74as4ZI7nk6iN/8wQrz6kGsFg6ZuWh/GWh/cQHLh8JrifBmT
         81m9io7385vE4X8Zif3qRfiinKAHvDun7SCo4KTQKJR15Xl022OBYBL7xqOu9tjqnx
         JjmEZGlvMSx7nQNRuOUUaNv6DrXXvutdAO0kRV05t9kd8RW/+HU6ULnIPbeJhgnXna
         jPMJPi9GFiMtFPaUW8vLH1qZ4GS/xz3GT5QQGAyg+9EQMO4a/908g2IPoS6Sw7aO6z
         VBeK9zTKkCGAkltLbR00Vb1/jw/T4r/cj8qCxjrZNMx+YPC5bdTOfvgt/20BLdkrPD
         u5SS4yQi2T5cQ==
Date:   Tue, 7 Dec 2021 11:54:16 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     qizhong cheng <qizhong.cheng@mediatek.com>
Cc:     Ryder Lee <ryder.lee@mediatek.com>,
        Jianjun Wang <jianjun.wang@mediatek.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, chuanjia.liu@mediatek.com,
        Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Mark Kettenis <mark.kettenis@xs4all.nl>,
        Luca Ceresoli <luca@lucaceresoli.net>
Subject: Re: [RESEND PATCH v2] PCI: mediatek: Delay 100ms to wait power and
 clock to become stable
Message-ID: <20211207175416.GA42725@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211207084153.23019-1-qizhong.cheng@mediatek.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Marc, Alyssa, Mark, Luca for reset timing questions]

On Tue, Dec 07, 2021 at 04:41:53PM +0800, qizhong cheng wrote:
> Described in PCIe CEM specification sections 2.2 (PERST# Signal) and
> 2.2.1 (Initial Power-Up (G3 to S0)). The deassertion of PERST# should
> be delayed 100ms (TPVPERL) for the power and clock to become stable.
> 
> Signed-off-by: qizhong cheng <qizhong.cheng@mediatek.com>
> Acked-by: Pali Rohár <pali@kernel.org>
> ---
> 
> v2:
>  - Typo fix.
>  - Rewrap into one paragraph.

1) If you change something, even in the commit log or comments, it is
a new version, not a "RESEND".  A "RESEND" means "I sent this quite a
while ago and didn't hear anything, so I'm sending the exact same
thing again in case the first one got lost."

2) I suggested a subject line update, which apparently got missed.
Here's a better one:

  PCI: mediatek: Assert PERST# for 100ms for power and clock to stabilize

3) Most importantly, this needs to be reconciled with the similar
change to the apple driver:

  https://lore.kernel.org/r/20211123180636.80558-2-maz@kernel.org

In the apple driver, we're doing:

  - Assert PERST#
  - Set up REFCLK
  - Sleep 100us (T_perst-clk, CEM r5 2.2, 2.9.2)
  - Deassert PERST#
  - Sleep 100ms (not sure there's a name? PCIe r5 6.6.1)

But here in mediatek, we're doing:

  - Assert PERST#
  - Sleep 100ms (T_pvperl, CEM r5 2.2, 2.2.1, 2.9.2)
  - Deassert PERST#

My questions:

  - Where does apple enforce T_pvperl?  I can't tell where power to
    the slot is turned on.

  - Where does mediatek enforce the PCIe sec 6.6.1 delay after
    deasserting PERST# and before config requests?

  - Does either apple or mediatek support speeds greater than 5 GT/s,
    and if so, shouldn't we start the sec 6.6.1 100ms delay *after*
    Link training completes?

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
> +	 * Described in PCIe CEM specification sections 2.2 (PERST# Signal) and
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
