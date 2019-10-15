Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 30BDDD79CA
	for <lists+linux-pci@lfdr.de>; Tue, 15 Oct 2019 17:29:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387513AbfJOP2H (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 15 Oct 2019 11:28:07 -0400
Received: from foss.arm.com ([217.140.110.172]:41084 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733174AbfJOP2H (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 15 Oct 2019 11:28:07 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 03C1F28;
        Tue, 15 Oct 2019 08:28:07 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (unknown [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 378293F718;
        Tue, 15 Oct 2019 08:28:06 -0700 (PDT)
Date:   Tue, 15 Oct 2019 16:28:01 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Andrew Murray <andrew.murray@arm.com>
Cc:     Simon Horman <horms@verge.net.au>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH] PCI: rcar: Remove unnecessary header include (../pci.h)
Message-ID: <20191015152801.GA25674@e121166-lin.cambridge.arm.com>
References: <20190905150528.20417-1-andrew.murray@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190905150528.20417-1-andrew.murray@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Sep 05, 2019 at 04:05:28PM +0100, Andrew Murray wrote:
> Remove unnecessary header include (../pci.h) since it doesn't
> provide any needed symbols.
> 
> Signed-off-by: Andrew Murray <andrew.murray@arm.com>
> ---
>  drivers/pci/controller/pcie-rcar.c | 2 --
>  1 file changed, 2 deletions(-)

Applied to pci/rcar, thanks.

Lorenzo

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
