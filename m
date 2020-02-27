Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6C4D3172A75
	for <lists+linux-pci@lfdr.de>; Thu, 27 Feb 2020 22:52:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729501AbgB0VwJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 27 Feb 2020 16:52:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:35166 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726791AbgB0VwJ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 27 Feb 2020 16:52:09 -0500
Received: from localhost (mobile-166-175-186-165.mycingular.net [166.175.186.165])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9FA222469F;
        Thu, 27 Feb 2020 21:52:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582840329;
        bh=YLXCleFm1NkklXXaZAYKs9oeGWD4D6WAcvWOVfS/Yds=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=KUpG0iuBefzm2uAQI7WMmOBdna/ED1rYoPmTnh50Hmf0hYfPmfxDqnNcvK8XIZKnZ
         h8ynJuHrNhfDB8Jxz7TebXoXKykU5LX04SjWPVns2lWXZCOLcbPe4w9bQQxyEg/s5v
         y/FLYa40/vS/VpnAdE/1JM/temjC7d3e+wylbJ2c=
Date:   Thu, 27 Feb 2020 15:52:06 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Tom Joseph <tjoseph@cadence.com>,
        Andrew Murray <andrew.murray@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-pci@vger.kernel.org, Joe Perches <joe@perches.com>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: adjust entry to moving cadence drivers
Message-ID: <20200227215206.GA146772@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200221185402.4703-1-lukas.bulwahn@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Feb 21, 2020 at 07:54:02PM +0100, Lukas Bulwahn wrote:
> Commit de80f95ccb9c ("PCI: cadence: Move all files to per-device cadence
> directory") moved files of the pci cadence drivers, but did not adjust
> the entry in MAINTAINERS.
> 
> Since then, ./scripts/get_maintainer.pl --self-test complains:
> 
>   warning: no file matches F: drivers/pci/controller/pcie-cadence*
> 
> So, repair the MAINTAINERS entry now.
> 
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>

Applied to for-linus for v5.6, thanks!

> ---
> Tom, Andrew, please ack. Lorenzo, please pick this patch.
> applies cleanly on current master and next-20200221
> 
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 4beb8dc4c7eb..d8f690f0e838 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -12740,7 +12740,7 @@ M:	Tom Joseph <tjoseph@cadence.com>
>  L:	linux-pci@vger.kernel.org
>  S:	Maintained
>  F:	Documentation/devicetree/bindings/pci/cdns,*.txt
> -F:	drivers/pci/controller/pcie-cadence*
> +F:	drivers/pci/controller/cadence/
>  
>  PCI DRIVER FOR FREESCALE LAYERSCAPE
>  M:	Minghuan Lian <minghuan.Lian@nxp.com>
> -- 
> 2.17.1
> 
