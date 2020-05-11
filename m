Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E48D31CDCD4
	for <lists+linux-pci@lfdr.de>; Mon, 11 May 2020 16:15:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730180AbgEKOPd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 11 May 2020 10:15:33 -0400
Received: from foss.arm.com ([217.140.110.172]:33126 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730158AbgEKOPd (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 11 May 2020 10:15:33 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B0E33D6E;
        Mon, 11 May 2020 07:15:32 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7B8D13F68F;
        Mon, 11 May 2020 07:15:31 -0700 (PDT)
Date:   Mon, 11 May 2020 15:15:20 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Hou Zhiqiang <Zhiqiang.Hou@nxp.com>, Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Joe Perches <joe@perches.com>, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 RESEND] MAINTAINERS: correct typo in new NXP
 LAYERSCAPE GEN4
Message-ID: <20200511141508.GA27249@e121166-lin.cambridge.arm.com>
References: <20200506052130.5780-1-lukas.bulwahn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200506052130.5780-1-lukas.bulwahn@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, May 06, 2020 at 07:21:30AM +0200, Lukas Bulwahn wrote:
> Commit 3edeb49525bb ("dt-bindings: PCI: Add NXP Layerscape SoCs PCIe Gen4
> controller") includes a new entry in MAINTAINERS, but slipped in a typo in
> one of the file entries.
> 
> Hence, since then, ./scripts/get_maintainer.pl --self-test complains:
> 
>   warning: no file matches F: \
>     drivers/pci/controller/mobibeil/pcie-layerscape-gen4.c
> 
> Correct the typo in PCI DRIVER FOR NXP LAYERSCAPE GEN4 CONTROLLER.
> 
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> ---
> Rob, please pick this patch (it is not urgent, though).
> 
> v1: https://lore.kernel.org/lkml/20200314142559.13505-1-lukas.bulwahn@gmail.com/
>   - already received: Reviewed-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
>   - Bjorn Helgaas' suggestion to squash this into commit 3edeb49525bb
>     ("dt-bindings: PCI: Add NXP Layerscape SoCs PCIe Gen4 controller") before
>     merging upstream did not happen.
> 
> v1 -> v2:
>   - v1 does not apply after reordering MAINTAINERS, i.e., commit 4400b7d68f6e
>     ("MAINTAINERS: sort entries by entry name") and commit 3b50142d8528
>     ("MAINTAINERS: sort field names for all entries").
>   - PATCH v2 applies on v5.7-rc1 now. Please pick v2 instead of v1.
> 
> v2-resend:
>   - resend of v2: https://lore.kernel.org/lkml/20200413070649.7014-1-lukas.bulwahn@gmail.com/ 
>   - still applies to v5.7-rc4 and next-20200505
> 
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to pci/misc, thanks !

Lorenzo

> diff --git a/MAINTAINERS b/MAINTAINERS
> index e64e5db31497..0fd27329e6f7 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -12941,7 +12941,7 @@ L:	linux-pci@vger.kernel.org
>  L:	linux-arm-kernel@lists.infradead.org
>  S:	Maintained
>  F:	Documentation/devicetree/bindings/pci/layerscape-pcie-gen4.txt
> -F:	drivers/pci/controller/mobibeil/pcie-layerscape-gen4.c
> +F:	drivers/pci/controller/mobiveil/pcie-layerscape-gen4.c
>  
>  PCI DRIVER FOR RENESAS R-CAR
>  M:	Marek Vasut <marek.vasut+renesas@gmail.com>
> -- 
> 2.17.1
> 
