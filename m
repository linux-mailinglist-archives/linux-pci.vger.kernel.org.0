Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92BB145062B
	for <lists+linux-pci@lfdr.de>; Mon, 15 Nov 2021 14:59:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231947AbhKOOCQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 15 Nov 2021 09:02:16 -0500
Received: from foss.arm.com ([217.140.110.172]:55666 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231937AbhKOOCN (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 15 Nov 2021 09:02:13 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4DBEA6D;
        Mon, 15 Nov 2021 05:59:18 -0800 (PST)
Received: from [10.57.82.45] (unknown [10.57.82.45])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 60B483F766;
        Mon, 15 Nov 2021 05:59:16 -0800 (PST)
Message-ID: <94d3f4e5-a698-134c-8264-55d31d3eafa6@arm.com>
Date:   Mon, 15 Nov 2021 13:59:11 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH v2 1/1] PCI: brcmstb: Use BIT() as __GENMASK() is for
 internal use only
Content-Language: en-GB
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Jim Quinlan <jim2101024@gmail.com>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>
References: <20211115112000.23693-1-andriy.shevchenko@linux.intel.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20211115112000.23693-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2021-11-15 11:20, Andy Shevchenko wrote:
> Use BIT() as __GENMASK() is for internal use only. The rationale
> of switching to BIT() is to provide better generated code. The
> GENMASK() against non-constant numbers may produce an ugly assembler
> code. On contrary the BIT() is simply converted to corresponding shift
> operation.

FWIW, If you care about code quality and want the compiler to do the 
obvious thing, why not specify it as the obvious thing:

	u32 val = ~0 << msi->legacy_shift;


Personally I don't think that abusing BIT() in the context of setting 
multiple bits is any better than abusing __GENMASK()...

Robin.

> Note, it's the only user of __GENMASK() in the kernel outside of its own realm.
> 
> Fixes: 3baec684a531 ("PCI: brcmstb: Accommodate MSI for older chips")
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
> v2: switched to BIT() and elaborated why, hence not included tag
>   drivers/pci/controller/pcie-brcmstb.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
> index 1fc7bd49a7ad..0c49fc65792c 100644
> --- a/drivers/pci/controller/pcie-brcmstb.c
> +++ b/drivers/pci/controller/pcie-brcmstb.c
> @@ -619,7 +619,7 @@ static void brcm_msi_remove(struct brcm_pcie *pcie)
>   
>   static void brcm_msi_set_regs(struct brcm_msi *msi)
>   {
> -	u32 val = __GENMASK(31, msi->legacy_shift);
> +	u32 val = ~(BIT(msi->legacy_shift) - 1);
>   
>   	writel(val, msi->intr_base + MSI_INT_MASK_CLR);
>   	writel(val, msi->intr_base + MSI_INT_CLR);
> 
