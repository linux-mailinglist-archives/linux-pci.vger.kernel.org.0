Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 84BABAB4FD
	for <lists+linux-pci@lfdr.de>; Fri,  6 Sep 2019 11:34:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392931AbfIFJex (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 6 Sep 2019 05:34:53 -0400
Received: from kirsty.vergenet.net ([202.4.237.240]:57492 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391097AbfIFJew (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 6 Sep 2019 05:34:52 -0400
Received: from reginn.horms.nl (watermunt.horms.nl [80.127.179.77])
        by kirsty.vergenet.net (Postfix) with ESMTPA id 7006325BDB3;
        Fri,  6 Sep 2019 19:34:50 +1000 (AEST)
Received: by reginn.horms.nl (Postfix, from userid 7100)
        id 560EA940C5F; Fri,  6 Sep 2019 11:34:48 +0200 (CEST)
Date:   Fri, 6 Sep 2019 11:34:48 +0200
From:   Simon Horman <horms@verge.net.au>
To:     Andrew Murray <andrew.murray@arm.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH] PCI: rcar: Remove unnecessary header include (../pci.h)
Message-ID: <20190906093448.tsgjefgkbgx2udsn@verge.net.au>
References: <20190905150528.20417-1-andrew.murray@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190905150528.20417-1-andrew.murray@arm.com>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Sep 05, 2019 at 04:05:28PM +0100, Andrew Murray wrote:
> Remove unnecessary header include (../pci.h) since it doesn't
> provide any needed symbols.
> 
> Signed-off-by: Andrew Murray <andrew.murray@arm.com>

Reviewed-by: Simon Horman <horms+renesas@verge.net.au>

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
> -- 
> 2.21.0
> 
