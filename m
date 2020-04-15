Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D62E61AADB6
	for <lists+linux-pci@lfdr.de>; Wed, 15 Apr 2020 18:32:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1415539AbgDOQSl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 15 Apr 2020 12:18:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:34950 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1415531AbgDOQSk (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 15 Apr 2020 12:18:40 -0400
Received: from pali.im (pali.im [31.31.79.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B085920656;
        Wed, 15 Apr 2020 16:18:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586967518;
        bh=q8zTcG6Hj0nZ+flnS9S7FR0xRxG3fw+TBBjwkItPLsQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Z46bEaHehb63VF8B8JD4a8vIFzqQjN4jhfV/Aod+FOSci+JNDg+SJA0HNWgEkHfeU
         w343aZtAzYEx7beKZ7ZYbzfTqt+2hpLVE3qtbF25wEVvwz26QpHwtjZs54ENRN/hDk
         eUlbtZL5EvUu7qNQSaNWTjHMYb96cozdlQk7QJPo=
Received: by pali.im (Postfix)
        id 92DCE58E; Wed, 15 Apr 2020 18:18:36 +0200 (CEST)
Date:   Wed, 15 Apr 2020 18:18:36 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Remi Pommarel <repk@triplefau.lt>,
        Marek =?utf-8?B?QmVow7pu?= <marek.behun@nic.cz>,
        Tomasz Maciej Nowak <tmn505@gmail.com>,
        Xogium <contact@xogium.me>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH 8/8] PCI: aardvark: Add FIXME for code which access
 PCIE_CORE_CMD_STATUS_REG
Message-ID: <20200415161836.lqbhr6bona7zmgpt@pali>
References: <20200415160054.951-1-pali@kernel.org>
 <20200415160348.1146-4-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200415160348.1146-4-pali@kernel.org>
User-Agent: NeoMutt/20180716
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wednesday 15 April 2020 18:03:48 Pali Rohár wrote:
> Register PCIE_CORE_CMD_STATUS_REG is applicable only when aardvark
> controller is configured for Endpoint mode. Which is not the case of
> current kernel driver.
> 
> Signed-off-by: Pali Rohár <pali@kernel.org>
> ---
>  drivers/pci/controller/pci-aardvark.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
> index 6a97a3838098..a1cebc734f2d 100644
> --- a/drivers/pci/controller/pci-aardvark.c
> +++ b/drivers/pci/controller/pci-aardvark.c
> @@ -423,6 +423,12 @@ static void advk_pcie_setup_hw(struct advk_pcie *pcie)
>  		advk_writel(pcie, reg, PCIE_CORE_LINK_CTRL_STAT_REG);
>  	} while (1);
>  
> +	/*
> +	 * FIXME: Following code which access PCIE_CORE_CMD_STATUS_REG register
> +	 *        is suspicious. This register is applicable only when the PCI
> +	 *        controller is configured for Endpoint mode. And not when it
> +	 *        is configured for Root Complex.
> +	 */
>  	reg = advk_readl(pcie, PCIE_CORE_CMD_STATUS_REG);
>  	reg |= PCIE_CORE_CMD_MEM_ACCESS_EN |
>  		PCIE_CORE_CMD_IO_ACCESS_EN |
> -- 
> 2.20.1
> 

Just to note, above code needs to be removed or fixed or properly
commented why is correct and what is doing.

I really do not know, so I'm adding at least FIXME comment to document
suspicious code which may cause unexpected problems.
