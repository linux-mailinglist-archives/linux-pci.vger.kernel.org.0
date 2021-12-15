Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94865476390
	for <lists+linux-pci@lfdr.de>; Wed, 15 Dec 2021 21:42:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232564AbhLOUmK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 15 Dec 2021 15:42:10 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:51558 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236374AbhLOUmJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 15 Dec 2021 15:42:09 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 820D761A9D;
        Wed, 15 Dec 2021 20:42:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9397CC36AE2;
        Wed, 15 Dec 2021 20:42:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639600928;
        bh=77j1aFKa3BKj9OCIas2iLnj9Txbm+/MSJFvVadJN+gc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=U0/niBIgwV0jq1JklZXB1TQnBOSGK19gh4zLFeQg0jhpgCYm5Jhtnfkj7QLn1ChUU
         n+GIjv9gqJ9euoh5GdJRV6EC+3yA8IwUxE9nDQ40ula8hxJdd+C2V5n+W53VyMrNQR
         EwmhjVwyqI8LhRGmSIWsxk8rFuhphINMmmuER2BekMJPZlgiY7G1mUPAhKFXi26aTy
         nNOU1KwR/52k9gGBOzIfMYSAP4ZYNTVleTL8wh+NuwHH7RUQ08D+wr5dyia0jJ+1My
         nknddiB2NoMQTC19/F6qyab5E7ecLzjDA3YAH8U9syQ51e0E1kjx0giXqhSZ6PNAXL
         /VYn9/NTkHWwQ==
Date:   Wed, 15 Dec 2021 14:42:07 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        Toan Le <toan@os.amperecomputing.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH 1/2] sizes.h: Add SZ_1T macro
Message-ID: <20211215204207.GA710838@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b03f5cf556f1a89ccb4d7ae2f56414520cfd9209.1638973836.git.christophe.leroy@csgroup.eu>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Dec 08, 2021 at 02:32:42PM +0000, Christophe Leroy wrote:
> Today drivers/pci/controller/pci-xgene.c defines SZ_1T
> 
> Move it into linux/sizes.h so that it can be re-used elsewhere.
> 
> Cc: Toan Le <toan@os.amperecomputing.com>
> Cc: linux-pci@vger.kernel.org
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>

I guess this needs to go with the [2/2] patch, since it also uses
SZ_1T.

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> ---
>  drivers/pci/controller/pci-xgene.c | 1 -
>  include/linux/sizes.h              | 2 ++
>  2 files changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/pci-xgene.c b/drivers/pci/controller/pci-xgene.c
> index 56d0d50338c8..716dcab5ca47 100644
> --- a/drivers/pci/controller/pci-xgene.c
> +++ b/drivers/pci/controller/pci-xgene.c
> @@ -49,7 +49,6 @@
>  #define EN_REG				0x00000001
>  #define OB_LO_IO			0x00000002
>  #define XGENE_PCIE_DEVICEID		0xE004
> -#define SZ_1T				(SZ_1G*1024ULL)
>  #define PIPE_PHY_RATE_RD(src)		((0xc000 & (u32)(src)) >> 0xe)
>  
>  #define XGENE_V1_PCI_EXP_CAP		0x40
> diff --git a/include/linux/sizes.h b/include/linux/sizes.h
> index 1ac79bcee2bb..84aa448d8bb3 100644
> --- a/include/linux/sizes.h
> +++ b/include/linux/sizes.h
> @@ -47,6 +47,8 @@
>  #define SZ_8G				_AC(0x200000000, ULL)
>  #define SZ_16G				_AC(0x400000000, ULL)
>  #define SZ_32G				_AC(0x800000000, ULL)
> +
> +#define SZ_1T				_AC(0x10000000000, ULL)
>  #define SZ_64T				_AC(0x400000000000, ULL)
>  
>  #endif /* __LINUX_SIZES_H__ */
> -- 
> 2.33.1
