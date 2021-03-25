Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1ADC7349B23
	for <lists+linux-pci@lfdr.de>; Thu, 25 Mar 2021 21:42:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230285AbhCYUlj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 25 Mar 2021 16:41:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:47778 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230288AbhCYUlM (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 25 Mar 2021 16:41:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9251060240;
        Thu, 25 Mar 2021 20:41:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616704871;
        bh=/T8zm22SRswwq/QrrEZFtj36xizo7XK9JG+GRYx/kWQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=YkYohe33OH2FT7ixuKahB/b0usVAEtY8Knjnlzo39E2ESvpQqKpN2lk3AbUeayft2
         FBnMWXnte95ocYRSFUrZWNd1UkTf8iO+Amm2ZrQYZ+ripvmcUZjSWAv/gdB97eLM16
         dzhiok58gzwxVKKk3+nMbaOYA6e3qKnLK8oYp9lwWS3HSxAus6v37OcqhsqQwqcqKF
         +dz1jR+FNCm0LHDqWGzub8VyFwtWne8sOus407H9ppmm9x7CVTPZfMIe1NqT6ZJyDJ
         BaGCQGkpXXcHSKCm0U6wsftpVMotBy1737irp6rQVO6gXYX6f/3QAqFutPpOO6c7P+
         JhRzooJuk+ZmA==
Date:   Thu, 25 Mar 2021 15:41:10 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Tom Joseph <tjoseph@cadence.com>, linux-omap@vger.kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Lokesh Vutla <lokeshvutla@ti.com>
Subject: Re: [PATCH 2/4] PCI: j721e: Add PCI legacy interrupt support for
 J721E
Message-ID: <20210325204110.GA809665@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210325090936.9306-3-kishon@ti.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

I'd promote J721E earlier in subject so it doesn't get truncated, e.g.,

  PCI: j721e: Add J721E PCI legacy interrupt support

On Thu, Mar 25, 2021 at 02:39:34PM +0530, Kishon Vijay Abraham I wrote:

> +static void j721e_pcie_legacy_irq_handler(struct irq_desc *desc)
> +{
> +	int i;
> +	u32 reg;
> +	int virq;
> +	struct j721e_pcie *pcie = irq_desc_get_handler_data(desc);
> +	struct irq_chip *chip = irq_desc_get_chip(desc);

The rest of this driver sorts locals in order of use, e.g.,

	struct j721e_pcie *pcie = irq_desc_get_handler_data(desc);
	struct irq_chip *chip = irq_desc_get_chip(desc);
	int i;
	u32 reg;
	int virq;

> +	chained_irq_enter(chip, desc);
> +
> +	for (i = 0; i < PCI_NUM_INTX; i++) {
> +		reg = j721e_pcie_intd_readl(pcie, STATUS_REG_SYS_0);
> +		if (!(reg & INTx_EN(i)))
> +			continue;
> +
> +	virq = irq_find_mapping(pcie->legacy_irq_domain, 3 - i);

Whitespace error (should be indented another tab, I think).

> +		generic_handle_irq(virq);
> +		j721e_pcie_intd_writel(pcie, STATUS_CLR_REG_SYS_0, INTx_EN(i));
> +		j721e_pcie_intd_writel(pcie, EOI_REG, 3 - i);
> +	}
> +
> +	chained_irq_exit(chip, desc);
> +}
