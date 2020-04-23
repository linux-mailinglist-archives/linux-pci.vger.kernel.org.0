Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB8E81B63F2
	for <lists+linux-pci@lfdr.de>; Thu, 23 Apr 2020 20:44:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728044AbgDWSoQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 23 Apr 2020 14:44:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:33900 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727815AbgDWSoQ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 23 Apr 2020 14:44:16 -0400
Received: from localhost (mobile-166-175-187-210.mycingular.net [166.175.187.210])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 457C920704;
        Thu, 23 Apr 2020 18:44:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587667455;
        bh=oH8i6inFuj5Rng6ApjOBTWHiTe3t7pOyuJtNWpC4a0g=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=YpZXepEhHlNZSPjCzpqUTY3unaPhtScEXHdtET5aPThZYMhI0xORsXgtR6iA05KPX
         mm94fslsO9ZvX5ec0pKSpUikLMwaYCCb6a0diBU0z8W/acJuhhKuUzcYigNX2k4mIY
         4INQ3b0BFtxin/2ZBo9xqxDzMGT+8exdDi29983M=
Date:   Thu, 23 Apr 2020 13:44:13 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Marek =?iso-8859-1?Q?Beh=FAn?= <marek.behun@nic.cz>
Cc:     linux-pci@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Remi Pommarel <repk@triplefau.lt>,
        Tomasz Maciej Nowak <tmn505@gmail.com>,
        Xogium <contact@xogium.me>,
        Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 5/9] PCI: aardvark: add FIXME comment for
 PCIE_CORE_CMD_STATUS_REG access
Message-ID: <20200423184413.GA202435@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200421111701.17088-6-marek.behun@nic.cz>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Rob]

On Tue, Apr 21, 2020 at 01:16:57PM +0200, Marek Behún wrote:
> From: Pali Rohár <pali@kernel.org>
> 
> Register PCIE_CORE_CMD_STATUS_REG is applicable only when the controller
> is configured for Endpoint mode, which is not the case for the current
> version of this driver.
> 
> Add a FIXME comment, since this needs to be explained, removed or fixed.

If it's not applicable, why not just remove it?

> Signed-off-by: Pali Rohár <pali@kernel.org>
> ---
>  drivers/pci/controller/pci-aardvark.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
> index e2d18094d8ca..e893d7d8859f 100644
> --- a/drivers/pci/controller/pci-aardvark.c
> +++ b/drivers/pci/controller/pci-aardvark.c
> @@ -429,6 +429,12 @@ static void advk_pcie_setup_hw(struct advk_pcie *pcie)
>  
>  	advk_pcie_train_link(pcie);
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
> 2.24.1
> 
