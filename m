Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 368B3DAE00
	for <lists+linux-pci@lfdr.de>; Thu, 17 Oct 2019 15:14:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394362AbfJQNOy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 17 Oct 2019 09:14:54 -0400
Received: from [217.140.110.172] ([217.140.110.172]:42824 "EHLO foss.arm.com"
        rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
        id S2394358AbfJQNOx (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 17 Oct 2019 09:14:53 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0FB691AED;
        Thu, 17 Oct 2019 06:14:31 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AF35C3F6C4;
        Thu, 17 Oct 2019 06:14:29 -0700 (PDT)
Date:   Thu, 17 Oct 2019 14:14:27 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Simon Horman <horms@verge.net.au>
Cc:     Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-pci@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: Add Marek and Shimoda-san as R-Car PCIE
 co-maintainers
Message-ID: <20191017131427.GF9589@e121166-lin.cambridge.arm.com>
References: <20191016120249.16776-1-horms@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191016120249.16776-1-horms@verge.net.au>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Oct 16, 2019 at 02:02:49PM +0200, Simon Horman wrote:
> At the end of the v5.3 upstream development cycle I stepped down
> from my role at Renesas.
> 
> Pass maintainership of the R-Car PCIE to Marek and Shimoda-san.
> 
> Signed-off-by: Simon Horman <horms@verge.net.au>
> ---
>  MAINTAINERS | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Applied to pci/misc, thanks.

Lorenzo

> diff --git a/MAINTAINERS b/MAINTAINERS
> index 783569e3c4b4..b61ade7afd64 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -12337,7 +12337,8 @@ F:	Documentation/devicetree/bindings/pci/nvidia,tegra20-pcie.txt
>  F:	drivers/pci/controller/pci-tegra.c
>  
>  PCI DRIVER FOR RENESAS R-CAR
> -M:	Simon Horman <horms@verge.net.au>
> +M:	Marek Vasut <marek.vasut+renesas@gmail.com>
> +M:	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
>  L:	linux-pci@vger.kernel.org
>  L:	linux-renesas-soc@vger.kernel.org
>  S:	Maintained
> -- 
> 2.11.0
> 
