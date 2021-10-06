Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B22F1423A4D
	for <lists+linux-pci@lfdr.de>; Wed,  6 Oct 2021 11:14:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237703AbhJFJPv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 6 Oct 2021 05:15:51 -0400
Received: from foss.arm.com ([217.140.110.172]:37352 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230120AbhJFJPu (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 6 Oct 2021 05:15:50 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 931AF1FB;
        Wed,  6 Oct 2021 02:13:58 -0700 (PDT)
Received: from lpieralisi (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C7AB13F766;
        Wed,  6 Oct 2021 02:13:57 -0700 (PDT)
Date:   Wed, 6 Oct 2021 10:13:38 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
        sashal@kernel.org
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        pali@kernel.org
Subject: Re: [PATCH v2 07/13] PCI: aardvark: Do not unmask unused interrupts
Message-ID: <20211006091337.GA9287@lpieralisi>
References: <20211005180952.6812-1-kabel@kernel.org>
 <20211005180952.6812-8-kabel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211005180952.6812-8-kabel@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[CC Sasha for stable kernel rules]

On Tue, Oct 05, 2021 at 08:09:46PM +0200, Marek Behún wrote:
> From: Pali Rohár <pali@kernel.org>
> 
> There are lot of undocumented interrupt bits. Fix all *_ALL_MASK macros to
> define all interrupt bits, so that driver can properly mask all interrupts,
> including those which are undocumented.
> 
> Fixes: 8c39d710363c ("PCI: aardvark: Add Aardvark PCI host controller driver")
> Signed-off-by: Pali Rohár <pali@kernel.org>
> Reviewed-by: Marek Behún <kabel@kernel.org>
> Signed-off-by: Marek Behún <kabel@kernel.org>
> Cc: stable@vger.kernel.org

I don't think this is a fix and I don't think it should be sent
to stable kernels in _preparation_ for other fixes to come (that
may never land in mainline).

If, for future fixes a depedency is detected they can be added
in the relevant commit log.

That's my understanding, Sasha can clarify if needed.

Patch itself is fine.

Thanks,
Lorenzo

> ---
>  drivers/pci/controller/pci-aardvark.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
> index f7eebf453e83..3448a8c446d4 100644
> --- a/drivers/pci/controller/pci-aardvark.c
> +++ b/drivers/pci/controller/pci-aardvark.c
> @@ -107,13 +107,13 @@
>  #define     PCIE_ISR0_MSI_INT_PENDING		BIT(24)
>  #define     PCIE_ISR0_INTX_ASSERT(val)		BIT(16 + (val))
>  #define     PCIE_ISR0_INTX_DEASSERT(val)	BIT(20 + (val))
> -#define	    PCIE_ISR0_ALL_MASK			GENMASK(26, 0)
> +#define     PCIE_ISR0_ALL_MASK			GENMASK(31, 0)
>  #define PCIE_ISR1_REG				(CONTROL_BASE_ADDR + 0x48)
>  #define PCIE_ISR1_MASK_REG			(CONTROL_BASE_ADDR + 0x4C)
>  #define     PCIE_ISR1_POWER_STATE_CHANGE	BIT(4)
>  #define     PCIE_ISR1_FLUSH			BIT(5)
>  #define     PCIE_ISR1_INTX_ASSERT(val)		BIT(8 + (val))
> -#define     PCIE_ISR1_ALL_MASK			GENMASK(11, 4)
> +#define     PCIE_ISR1_ALL_MASK			GENMASK(31, 0)
>  #define PCIE_MSI_ADDR_LOW_REG			(CONTROL_BASE_ADDR + 0x50)
>  #define PCIE_MSI_ADDR_HIGH_REG			(CONTROL_BASE_ADDR + 0x54)
>  #define PCIE_MSI_STATUS_REG			(CONTROL_BASE_ADDR + 0x58)
> @@ -199,7 +199,7 @@
>  #define     PCIE_IRQ_MSI_INT2_DET		BIT(21)
>  #define     PCIE_IRQ_RC_DBELL_DET		BIT(22)
>  #define     PCIE_IRQ_EP_STATUS			BIT(23)
> -#define     PCIE_IRQ_ALL_MASK			0xfff0fb
> +#define     PCIE_IRQ_ALL_MASK			GENMASK(31, 0)
>  #define     PCIE_IRQ_ENABLE_INTS_MASK		PCIE_IRQ_CORE_INT
>  
>  /* Transaction types */
> -- 
> 2.32.0
> 
