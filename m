Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BA643F696A
	for <lists+linux-pci@lfdr.de>; Tue, 24 Aug 2021 21:00:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233610AbhHXTB0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 24 Aug 2021 15:01:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:55598 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233999AbhHXTBZ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 24 Aug 2021 15:01:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 23CF2610FD;
        Tue, 24 Aug 2021 19:00:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629831641;
        bh=7IciptIw3jJnUgdT5IN+77jffZ9goiQtAYha2MOaySM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=B2lq+XawTs3Vyn/CMrpYB5VBYKBFkdJv+HPBKwBq6iEgOWmT3SaPChA8V3AVCKL4L
         /ydGgnBGNS7nS4DPTvwM8x2adB07xw+jlv2YuIFfmNBgKqIrstyO/bocsKfZIzu4I6
         KTlmN3sMTQgFVcLHLWBRQAx2TIKXB3c/o7KiDlG+GYK1gxvykBErFqdJDSPMLpMClv
         jyRqV4vfCfWKcek0WiZVK0SESB0qJnV9MmUmJrKm1KppAp+kANyNe208T7Ujx38QlH
         vPZQOfpm/CO1f4UKASm4Jy7yfP/mV2m6BZccWlcosaEz67KkBPmLKzpnD3hDJ4f3jt
         QHruQ8bOB4jnA==
Date:   Tue, 24 Aug 2021 14:00:39 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh@kernel.org>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
        Remi Pommarel <repk@triplefau.lt>, Xogium <contact@xogium.me>,
        Tomasz Maciej Nowak <tmn505@gmail.com>,
        Nadav Haklai <nadavh@marvell.com>,
        Kostya Porotchkin <kostap@marvell.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [RESEND PATCH 2/5] PCI: Add PCI_EXP_DEVCTL_PAYLOAD_* macros
Message-ID: <20210824190039.GA3486187@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210624222621.4776-3-pali@kernel.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jun 25, 2021 at 12:26:18AM +0200, Pali Rohár wrote:
> Define a macro PCI_EXP_DEVCTL_PAYLOAD_* for every possible Max Payload
> Size in linux/pci_regs.h, in the same style as PCI_EXP_DEVCTL_READRQ_*.
> 
> Signed-off-by: Pali Rohár <pali@kernel.org>
> Reviewed-by: Marek Behún <kabel@kernel.org>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> ---
>  include/uapi/linux/pci_regs.h | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
> index e709ae8235e7..ff6ccbc6efe9 100644
> --- a/include/uapi/linux/pci_regs.h
> +++ b/include/uapi/linux/pci_regs.h
> @@ -504,6 +504,12 @@
>  #define  PCI_EXP_DEVCTL_URRE	0x0008	/* Unsupported Request Reporting En. */
>  #define  PCI_EXP_DEVCTL_RELAX_EN 0x0010 /* Enable relaxed ordering */
>  #define  PCI_EXP_DEVCTL_PAYLOAD	0x00e0	/* Max_Payload_Size */
> +#define  PCI_EXP_DEVCTL_PAYLOAD_128B 0x0000 /* 128 Bytes */
> +#define  PCI_EXP_DEVCTL_PAYLOAD_256B 0x0020 /* 256 Bytes */
> +#define  PCI_EXP_DEVCTL_PAYLOAD_512B 0x0040 /* 512 Bytes */
> +#define  PCI_EXP_DEVCTL_PAYLOAD_1024B 0x0060 /* 1024 Bytes */
> +#define  PCI_EXP_DEVCTL_PAYLOAD_2048B 0x0080 /* 2048 Bytes */
> +#define  PCI_EXP_DEVCTL_PAYLOAD_4096B 0x00a0 /* 4096 Bytes */
>  #define  PCI_EXP_DEVCTL_EXT_TAG	0x0100	/* Extended Tag Field Enable */
>  #define  PCI_EXP_DEVCTL_PHANTOM	0x0200	/* Phantom Functions Enable */
>  #define  PCI_EXP_DEVCTL_AUX_PME	0x0400	/* Auxiliary Power PM Enable */
> -- 
> 2.20.1
> 
