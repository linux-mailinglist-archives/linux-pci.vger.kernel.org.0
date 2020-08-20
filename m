Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CC0224C6EC
	for <lists+linux-pci@lfdr.de>; Thu, 20 Aug 2020 22:59:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728306AbgHTU7p (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 20 Aug 2020 16:59:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:46414 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728255AbgHTU7o (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 20 Aug 2020 16:59:44 -0400
Received: from localhost (104.sub-72-107-126.myvzw.com [72.107.126.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CEA9320885;
        Thu, 20 Aug 2020 20:59:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597957184;
        bh=H662cr6lScXQk41xUWiJvAnd8nyYL+JK+HQiAf80rjI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=tJ0E9vgy4lb+T/PyAqh+xD7960Jq5zpo15WdjuxFqS13hS/oBMWoBev8UcB/4bFqH
         gU4w3gRAAYP+ibtfKfiihzjUj30KU++4blJzQu7HzniSrXfYdPkwiaxKBTaOaKGRaq
         Dnt8FfW4jNzZcB+Ec4rGZe+/IGzUa5+zNgx1bICQ=
Date:   Thu, 20 Aug 2020 15:59:42 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        Joao Pinto <Joao.Pinto@synopsys.com>
Subject: Re: [PATCH] PCI: Add #defines for max payload size options
Message-ID: <20200820205942.GA1566692@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3c9aea7c585171eefe40e0bec6e2b996ec894d84.1597327415.git.gustavo.pimentel@synopsys.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Aug 13, 2020 at 04:08:50PM +0200, Gustavo Pimentel wrote:
> Add #defines for the max payload size options. No functional change
> intended.
> 
> Cc: Joao Pinto <jpinto@synopsys.com>
> Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
> ---
>  include/uapi/linux/pci_regs.h | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
> index f970141..db625bd 100644
> --- a/include/uapi/linux/pci_regs.h
> +++ b/include/uapi/linux/pci_regs.h
> @@ -503,6 +503,12 @@
>  #define  PCI_EXP_DEVCTL_URRE	0x0008	/* Unsupported Request Reporting En. */
>  #define  PCI_EXP_DEVCTL_RELAX_EN 0x0010 /* Enable relaxed ordering */
>  #define  PCI_EXP_DEVCTL_PAYLOAD	0x00e0	/* Max_Payload_Size */
> +#define  PCI_EXP_DEVCTL_PAYLOAD_128B  0x0000 /* 128 Bytes */
> +#define  PCI_EXP_DEVCTL_PAYLOAD_256B  0x0020 /* 256 Bytes */
> +#define  PCI_EXP_DEVCTL_PAYLOAD_512B  0x0040 /* 512 Bytes */
> +#define  PCI_EXP_DEVCTL_PAYLOAD_1024B 0x0060 /* 1024 Bytes */
> +#define  PCI_EXP_DEVCTL_PAYLOAD_2048B 0x0080 /* 2048 Bytes */
> +#define  PCI_EXP_DEVCTL_PAYLOAD_4096B 0x00a0 /* 4096 Bytes */

I would apply this if we actually *used* these anywhere, but I'm not
sure it's worth adding them just as documentation.

>  #define  PCI_EXP_DEVCTL_EXT_TAG	0x0100	/* Extended Tag Field Enable */
>  #define  PCI_EXP_DEVCTL_PHANTOM	0x0200	/* Phantom Functions Enable */
>  #define  PCI_EXP_DEVCTL_AUX_PME	0x0400	/* Auxiliary Power PM Enable */
> -- 
> 2.7.4
> 
