Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD14D44525A
	for <lists+linux-pci@lfdr.de>; Thu,  4 Nov 2021 12:41:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231171AbhKDLnu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 4 Nov 2021 07:43:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:37734 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229843AbhKDLnt (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 4 Nov 2021 07:43:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AE6BB611EF;
        Thu,  4 Nov 2021 11:41:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636026071;
        bh=w4EJu5XJxSHpNU33OdK4OD1pgxNRI63+7YIulSPgqTA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nY3bp1C1iEUAgTkKHfaCeYAYC4rUcxlNvEa8hB1iU+Rxcst30p9ZVvmd5uaUXsO7t
         r/zSPFt7kZc5dvxsWd/RFVUdbUScmWNZCM3tXx5mPQ2BB6Txfn6ab49ftUhCyVceZY
         RBGUUdpd9K/tA2ci3FAFr5Bky7hm8hBdNKodHH7vKXghnjUtF5LIbzl6a4P3qF0/Gn
         4weR3k6xlCVPinWW0h66aYkPPGQpxGW8yscR/SJ5+LTFADWq2ykMRNXn/rqkLvI+Rh
         Fe2zMRlrHs9SOrORLyxVxuG52pFj5GPgfNOC2mR9w0SvXIu/dh6lBWEy7MlQEHmimj
         zeTuwUOZUITIQ==
Received: by pali.im (Postfix)
        id 19858990; Thu,  4 Nov 2021 12:41:09 +0100 (CET)
Date:   Thu, 4 Nov 2021 12:41:08 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
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
Message-ID: <20211104114108.mvhm5nhbc7hn2yld@pali>
References: <20211104062144.31453-1-qizhong.cheng@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211104062144.31453-1-qizhong.cheng@mediatek.com>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thursday 04 November 2021 14:21:44 qizhong cheng wrote:
> Described in PCIe CEM specification setctions 2.2 (PERST# Signal) and
> 2.2.1 (Initial Power-Up (G3 to S0)). The deassertion of PERST# should
> be delayed 100ms (TPVPERL) for the power and clock to become stable.
> 
> Signed-off-by: qizhong cheng <qizhong.cheng@mediatek.com>

Acked-by: Pali Rohár <pali@kernel.org>

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
> +	 */
> +	msleep(100);
> +

I guess that this change is fixing detection of some PCIe cards, right?

This ad-hoc driver change is really required as kernel pci code does not
contain this delay functionality.

Note that this delay is required in every native pci controller driver
(not only mediatek), otherwise some PCIe cards may not be detected.

For future direction, some more general solution for these issues is
needed. I proposed something in following email:
https://lore.kernel.org/linux-pci/20211022183808.jdeo7vntnagqkg7g@pali/
If you have a time, I would like to hear some feedback...

>  	/* De-assert PHY, PE, PIPE, MAC and configuration reset	*/
>  	val = readl(port->base + PCIE_RST_CTRL);
>  	val |= PCIE_PHY_RSTB | PCIE_PERSTB | PCIE_PIPE_SRSTB |
> -- 
> 2.25.1
> 
