Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0EA725B12B
	for <lists+linux-pci@lfdr.de>; Wed,  2 Sep 2020 18:16:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727825AbgIBQPz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 2 Sep 2020 12:15:55 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:38396 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727943AbgIBQNk (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 2 Sep 2020 12:13:40 -0400
Received: from andrew by vps0.lunn.ch with local (Exim 4.94)
        (envelope-from <andrew@lunn.ch>)
        id 1kDVO4-00Cud1-AA; Wed, 02 Sep 2020 18:13:28 +0200
Date:   Wed, 2 Sep 2020 18:13:28 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Marek =?iso-8859-1?Q?Beh=FAn?= <marek.behun@nic.cz>,
        Tomasz Maciej Nowak <tmn505@gmail.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/2] phy: marvell: comphy: Convert internal SMCC firmware
 return codes to errno
Message-ID: <20200902161328.GE3050651@lunn.ch>
References: <20200902144344.16684-1-pali@kernel.org>
 <20200902144344.16684-2-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200902144344.16684-2-pali@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Sep 02, 2020 at 04:43:43PM +0200, Pali Rohár wrote:
> Driver ->power_on and ->power_off callbacks leaks internal SMCC firmware
> return codes to phy caller. This patch converts SMCC error codes to
> standard linux errno codes. Include file linux/arm-smccc.h already provides
> defines for SMCC error codes, so use them instead of custom driver defines.
> Note that return value is signed 32bit, but stored in unsigned long type
> with zero padding.
> 
> Signed-off-by: Pali Rohár <pali@kernel.org>
> ---
>  drivers/phy/marvell/phy-mvebu-a3700-comphy.c | 14 +++++++++++---
>  drivers/phy/marvell/phy-mvebu-cp110-comphy.c | 14 +++++++++++---
>  2 files changed, 22 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/phy/marvell/phy-mvebu-a3700-comphy.c b/drivers/phy/marvell/phy-mvebu-a3700-comphy.c
> index 1a138be8bd6a..810f25a47632 100644
> --- a/drivers/phy/marvell/phy-mvebu-a3700-comphy.c
> +++ b/drivers/phy/marvell/phy-mvebu-a3700-comphy.c
> @@ -26,7 +26,6 @@
>  #define COMPHY_SIP_POWER_ON			0x82000001
>  #define COMPHY_SIP_POWER_OFF			0x82000002
>  #define COMPHY_SIP_PLL_LOCK			0x82000003
> -#define COMPHY_FW_NOT_SUPPORTED			(-1)
>  
>  #define COMPHY_FW_MODE_SATA			0x1
>  #define COMPHY_FW_MODE_SGMII			0x2
> @@ -112,10 +111,19 @@ static int mvebu_a3700_comphy_smc(unsigned long function, unsigned long lane,
>  				  unsigned long mode)
>  {
>  	struct arm_smccc_res res;
> +	s32 ret;
>  
>  	arm_smccc_smc(function, lane, mode, 0, 0, 0, 0, 0, &res);
> +	ret = res.a0;
>  
> -	return res.a0;

> +	switch (ret) {
> +	case SMCCC_RET_SUCCESS:
> +		return 0;
> +	case SMCCC_RET_NOT_SUPPORTED:
> +		return -EOPNOTSUPP;
> +	default:
> +		return -EINVAL;
> +	}
>  }

Hi Pali

Maybe this should be a global helper translating SMCCC_RET_* into a
standard errno value?

	 Andrew
