Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFC9B2774EF
	for <lists+linux-pci@lfdr.de>; Thu, 24 Sep 2020 17:11:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728240AbgIXPLJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Sep 2020 11:11:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:41816 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728215AbgIXPLJ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 24 Sep 2020 11:11:09 -0400
Received: from localhost (52.sub-72-107-123.myvzw.com [72.107.123.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3DD7920888;
        Thu, 24 Sep 2020 15:11:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600960268;
        bh=eKzStppL6O+Yi3zbaWGa3CiyDjwdh/bVEGy1dk9/RAM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=1FzU+jmafCRzt7I9wuLQzoKAySsY9GoInYk3p6dgPXh0wFOJ+McDsLqsDnKH2k490
         7t/7Pnd+lxzxhlTx7PTaJRBHoabCS+Abq2c8s0/sJbrGshJ7uzRvcXmu/tqQvFYMSm
         Hhu915BUJdXsVo2F4I/qlT2aLBlQDIu6iYig6LA0=
Date:   Thu, 24 Sep 2020 10:11:06 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: aardvark: Update comment about disabling link
 training
Message-ID: <20200924151106.GA2319992@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200924084618.12442-1-pali@kernel.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Sep 24, 2020 at 10:46:18AM +0200, Pali Rohár wrote:
> It is not HW bug or workaround for some cards but it is requirement by PCI
> Express spec. After fundamental reset is needed 100ms delay prior enabling
> link training. So update comment in code to reflect this requirement.
> 
> Signed-off-by: Pali Rohár <pali@kernel.org>
> ---
>  drivers/pci/controller/pci-aardvark.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
> index 50ab6d7519ae..19b9b79226e5 100644
> --- a/drivers/pci/controller/pci-aardvark.c
> +++ b/drivers/pci/controller/pci-aardvark.c
> @@ -259,7 +259,12 @@ static void advk_pcie_issue_perst(struct advk_pcie *pcie)
>  	if (!pcie->reset_gpio)
>  		return;
>  
> -	/* PERST does not work for some cards when link training is enabled */
> +	/*
> +	 * As required by PCI Express spec a delay for at least 100ms after
> +	 * de-asserting PERST# signal is needed before link training is enabled.
> +	 * So ensure that link training is disabled prior de-asserting PERST#
> +	 * signal to fulfill that PCI Express spec requirement.

Can you please include the spec citation here?  In the PCIe base spec,
PERST# is only mentioned in PCIe r5.0, sec 6.6.1, and I don't see the
connection there to 100ms between de-assert of PERST# and enabling
link training.

Sec 6.1.1 does talk about 100ms before sending config requests (for
ports that support <= 5 GT/s), and 100ms after link training completes
(for ports that support > 5 GT/s).

Maybe there's more language in a form-factor spec or something?

> +	 */
>  	reg = advk_readl(pcie, PCIE_CORE_CTRL0_REG);
>  	reg &= ~LINK_TRAINING_EN;
>  	advk_writel(pcie, reg, PCIE_CORE_CTRL0_REG);
> -- 
> 2.20.1
> 
