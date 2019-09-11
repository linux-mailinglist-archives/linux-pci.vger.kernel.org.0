Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 32DDDB05A9
	for <lists+linux-pci@lfdr.de>; Thu, 12 Sep 2019 00:33:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728717AbfIKWdJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 Sep 2019 18:33:09 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:42738 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728224AbfIKWdJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 11 Sep 2019 18:33:09 -0400
Received: from [192.168.0.20] (cpc89242-aztw30-2-0-cust488.18-1.cable.virginm.net [86.31.129.233])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id CB60533A;
        Thu, 12 Sep 2019 00:33:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1568241187;
        bh=Ulyq4f+6Afiv/6bNgVB/ITS9goTMGa4W5xjkJwM8xXU=;
        h=Subject:To:Cc:References:Reply-To:From:Date:In-Reply-To:From;
        b=mHBN/3PK09Ya76f2yBDbwJBUjgvYRHFX5a74Hwn/XAlxVGEIjlhPOORLglYTqqrxy
         36mrPoVlU7WeTmwOhcw6RlTKuqoFWiNl7IGuIwN6mVgaF4kGXJ4RQr/rsfaYFeGRkR
         5RWNYAwtYWU38fHAYug+OvyTWi9uWaWfzN3zipjM=
Subject: Re: [PATCH] PCI: rcar: Remove unnecessary header include (../pci.h)
To:     Andrew Murray <andrew.murray@arm.com>,
        Simon Horman <horms@verge.net.au>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
References: <20190905150528.20417-1-andrew.murray@arm.com>
Reply-To: kieran.bingham+renesas@ideasonboard.com
From:   Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Organization: Ideas on Board
Message-ID: <67fb0f5a-1bf1-596a-4012-8ae881220096@ideasonboard.com>
Date:   Wed, 11 Sep 2019 23:33:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190905150528.20417-1-andrew.murray@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Andy!

On 05/09/2019 16:05, Andrew Murray wrote:
> Remove unnecessary header include (../pci.h) since it doesn't
> provide any needed symbols.

This appears to have been added in 9e2aee80c78d ("PCI: Move private DT
related functions into private header")

Several other drivers were touched in that commit too.

Have you checked to see if any others can also be cleaned up?

 (I only ask, because I only see this single patch on linux-renesas-soc,
my apologies if others are on different lists.)

Regardless of that, this looks fine to me, and passes a cursory compile
check.

And I've just tried with pcie-xilinx, and pcie-altera, but both still
need this header - so perhaps pcie-rcar was just the odd one out.

Reviewed-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>


> Signed-off-by: Andrew Murray <andrew.murray@arm.com>
> ---
>  drivers/pci/controller/pcie-rcar.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-rcar.c b/drivers/pci/controller/pcie-rcar.c
> index f6a669a9af41..ee1c38c2fac9 100644
> --- a/drivers/pci/controller/pcie-rcar.c
> +++ b/drivers/pci/controller/pcie-rcar.c
> @@ -30,8 +30,6 @@
>  #include <linux/pm_runtime.h>
>  #include <linux/slab.h>
>  
> -#include "../pci.h"
> -
>  #define PCIECAR			0x000010
>  #define PCIECCTLR		0x000018
>  #define  CONFIG_SEND_ENABLE	BIT(31)
> 

