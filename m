Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E93D018A29E
	for <lists+linux-pci@lfdr.de>; Wed, 18 Mar 2020 19:49:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726864AbgCRStm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 18 Mar 2020 14:49:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:38852 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726619AbgCRStm (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 18 Mar 2020 14:49:42 -0400
Received: from localhost (mobile-166-175-186-165.mycingular.net [166.175.186.165])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 66AC020724;
        Wed, 18 Mar 2020 18:49:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584557381;
        bh=m4cbPVk0gn7Y6oT8HwTSVAuobPlopKWPy7rT39Co20w=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=PkApTePJZik35M+XbXXxSMGMQsmJfHgLTzOWT94R0zCsUHXCHOnRwbCtdgwOCQZDC
         gGkjkz1pp+VAKTPRN5WmwHlyybtimFIDOE51JoFUHbiRr2b0Z6T6Jp6E/TBG4EOssZ
         GBK4OUNkaChrKGS70Vi7a/wvbIWILG8EI+Id9pVY=
Date:   Wed, 18 Mar 2020 13:49:39 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Hou Zhiqiang <Zhiqiang.Hou@nxp.com>, Rob Herring <robh@kernel.org>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Joe Perches <joe@perches.com>, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: correct typo in new NXP LAYERSCAPE GEN4
Message-ID: <20200318184939.GA209856@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200314142559.13505-1-lukas.bulwahn@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Mar 14, 2020 at 03:25:59PM +0100, Lukas Bulwahn wrote:
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
> applies cleanly on next-20200313
> 
> Hou, please ack.
> Rob, please pick this patch (it is not urgent, though).

3edeb49525bb ("dt-bindings: PCI: Add NXP Layerscape SoCs PCIe Gen4
controller") is on Lorenzo's pci/mobiveil branch and queued for v5.7.

But it hasn't been merged upstream yet, so we should squash this fix
into Lorenzo's branch so we don't need a fixup commit.

>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 32a95d162f06..77eede976d0f 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -12858,7 +12858,7 @@ L:	linux-pci@vger.kernel.org
>  L:	linux-arm-kernel@lists.infradead.org
>  S:	Maintained
>  F:	Documentation/devicetree/bindings/pci/layerscape-pcie-gen4.txt
> -F:	drivers/pci/controller/mobibeil/pcie-layerscape-gen4.c
> +F:	drivers/pci/controller/mobiveil/pcie-layerscape-gen4.c
>  
>  PCI DRIVER FOR GENERIC OF HOSTS
>  M:	Will Deacon <will@kernel.org>
> 
> base-commit: 2e602db729948ce577bf07e2b113f2aa806b62c7
> -- 
> 2.17.1
> 
