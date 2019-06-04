Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B391B35069
	for <lists+linux-pci@lfdr.de>; Tue,  4 Jun 2019 21:46:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726295AbfFDTqB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 4 Jun 2019 15:46:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:41314 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726179AbfFDTqA (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 4 Jun 2019 15:46:00 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AB087206B8;
        Tue,  4 Jun 2019 19:45:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559677559;
        bh=1tBYtI0D2Gm8NgAPNHeS+3+9XEB1WWJiwXHzo6wtquI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wiCx5eHdZP0Vtxa21xguwHieM1fpdxfa/f3hN0HhcqBIWd7i1OT7ClXdvS7I74hEx
         Us9WAhkHug9BCopGgZexJIDCTTT5ogopVfG9VKrEPGVA4nldu5XguklleSkSPhiCto
         53m3TzWmgImw9Vh0/2c9Ug7HCpkktPv86AZkDLHg=
Date:   Tue, 4 Jun 2019 14:45:57 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Tom Joseph <tjoseph@cadence.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Jingoo Han <jingoohan1@gmail.com>, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [RFC PATCH 26/30] MAINTAINERS: Add MAINTAINER entry for PCIe on
 TI's J721E SoC
Message-ID: <20190604194557.GB84290@google.com>
References: <20190604131516.13596-1-kishon@ti.com>
 <20190604131516.13596-27-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190604131516.13596-27-kishon@ti.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Nit: the subject wastes a lot of space in the most valuable part (the
beginning).  Something like this would make "git log --oneline" more
useful:

  MAINTAINERS: Add Kishon Vijay Abraham I for TI J721E SoC PCIe

On Tue, Jun 04, 2019 at 06:45:12PM +0530, Kishon Vijay Abraham I wrote:
> Add MAINTAINER entry for PCIe on TI's J721E SoC.
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  MAINTAINERS | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index a6954776a37e..8a421949f335 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -12122,13 +12122,14 @@ S:	Maintained
>  F:	Documentation/devicetree/bindings/pci/designware-pcie.txt
>  F:	drivers/pci/controller/dwc/*designware*
>  
> -PCI DRIVER FOR TI DRA7XX
> +PCI DRIVER FOR TI DRA7XX/J721E
>  M:	Kishon Vijay Abraham I <kishon@ti.com>
>  L:	linux-omap@vger.kernel.org
>  L:	linux-pci@vger.kernel.org
>  S:	Supported
>  F:	Documentation/devicetree/bindings/pci/ti-pci.txt
>  F:	drivers/pci/controller/dwc/pci-dra7xx.c
> +F:	drivers/pci/controller/pci-j721e.c
>  
>  PCI DRIVER FOR TI KEYSTONE
>  M:	Murali Karicheri <m-karicheri2@ti.com>
> -- 
> 2.17.1
> 
