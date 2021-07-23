Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAC573D3C6C
	for <lists+linux-pci@lfdr.de>; Fri, 23 Jul 2021 17:29:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235606AbhGWOsf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 23 Jul 2021 10:48:35 -0400
Received: from foss.arm.com ([217.140.110.172]:47444 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235575AbhGWOrp (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 23 Jul 2021 10:47:45 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1EEAA139F;
        Fri, 23 Jul 2021 08:28:12 -0700 (PDT)
Received: from lpieralisi (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A64B73F73D;
        Fri, 23 Jul 2021 08:28:10 -0700 (PDT)
Date:   Fri, 23 Jul 2021 16:28:05 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Rahul Tanwar <rtanwar@maxlinear.com>, bhelgaas@google.com
Cc:     robh@kernel.org, kw@linux.com, jingoohan1@gmail.com,
        gustavo.pimentel@synopsys.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, ckim@maxlinear.com,
        qwu@maxlinear.com, rahul.tanwar.linux@gmail.com
Subject: Re: [PATCH] PCI: dwc/intel-gw: Update MAINTAINERS file
Message-ID: <20210723152805.GA4103@lpieralisi>
References: <b3249e08155e04ac08d820be3b8da29a913c472a.1625559158.git.rtanwar@maxlinear.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b3249e08155e04ac08d820be3b8da29a913c472a.1625559158.git.rtanwar@maxlinear.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jul 06, 2021 at 04:20:59PM +0800, Rahul Tanwar wrote:
> Add maintainer for PCIe RC controller driver for Intel LGM gateway SoC.
> 
> Signed-off-by: Rahul Tanwar <rtanwar@maxlinear.com>
> ---
>  MAINTAINERS | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 3298f4592ce7..61c1cfcc453b 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -14392,6 +14392,13 @@ S:	Maintained
>  F:	Documentation/devicetree/bindings/pci/hisilicon-histb-pcie.txt
>  F:	drivers/pci/controller/dwc/pcie-histb.c
>  
> +PCIE DRIVER FOR INTEL LGM GW SOC
> +M:	Rahul Tanwar <rtanwar@maxlinear.com>
> +L:	linux-pci@vger.kernel.org
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/pci/intel-gw-pcie.yaml
> +F:	drivers/pci/controller/dwc/pcie-intel-gw.c
> +

Hi Bjorn,

do you think we can merge this patch as a fix in one of the upcoming
-rcX ?

Please let me know, thanks.

Lorenzo
