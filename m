Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1552240818
	for <lists+linux-pci@lfdr.de>; Mon, 10 Aug 2020 17:03:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726944AbgHJPDb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 10 Aug 2020 11:03:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:40774 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726499AbgHJPDa (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 10 Aug 2020 11:03:30 -0400
Received: from pali.im (pali.im [31.31.79.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E30C820772;
        Mon, 10 Aug 2020 15:03:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597071809;
        bh=2upOspJQyAc6VxHI3ZoPXqjcC9tIQ2ybsAs1y8sw9EY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EXHd7G+NT+8jdi+vKGgK9WZpeHQgBvMdxobJdmsIiRUXpKRVvZQSMhsBmkSJdGgmF
         Z25rNlD7H3J1ghwDzPpD6NH/MfSJMEX0Uo9i5m0wiLphWHQDH9IWPObdWGGUP1qbb2
         BPpYGUa4N4LRKtgf47KO8Uj93JtiYIxDz3bpZqDo=
Received: by pali.im (Postfix)
        id 8D5B97C9; Mon, 10 Aug 2020 17:03:26 +0200 (CEST)
Date:   Mon, 10 Aug 2020 17:03:26 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Jason Cooper <jason@lakedaemon.net>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: mvebu: Check if reset gpio is defined
Message-ID: <20200810150326.mrfcxnilpmib7u3m@pali>
References: <20200724132930.7206-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200724132930.7206-1-pali@kernel.org>
User-Agent: NeoMutt/20180716
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Friday 24 July 2020 15:29:30 Pali Rohár wrote:
> Reset gpio is optional and it does not have to be defined for all boards.
> 
> So in mvebu_pcie_powerdown() like in mvebu_pcie_powerup() check that reset
> gpio is defined prior usage to prevent NULL pointer dereference.
> 
> Signed-off-by: Pali Rohár <pali@kernel.org>
> ---
>  drivers/pci/controller/pci-mvebu.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/pci-mvebu.c b/drivers/pci/controller/pci-mvebu.c
> index 153a64676bc9..58607cbe84c8 100644
> --- a/drivers/pci/controller/pci-mvebu.c
> +++ b/drivers/pci/controller/pci-mvebu.c
> @@ -947,7 +947,8 @@ static int mvebu_pcie_powerup(struct mvebu_pcie_port *port)
>   */
>  static void mvebu_pcie_powerdown(struct mvebu_pcie_port *port)
>  {
> -	gpiod_set_value_cansleep(port->reset_gpio, 1);
> +	if (port->reset_gpio)
> +		gpiod_set_value_cansleep(port->reset_gpio, 1);

Please drop this patch. I have realized that gpiod_set_value_cansleep()
calls VALIDATE_DESC_VOID() macro which returns from current running
function if passed pointer is NULL. So this patch is not needed as
gpiod_set_value_cansleep() may be called with NULL pointer.

>  
>  	clk_disable_unprepare(port->clk);
>  }
> -- 
> 2.20.1
> 
