Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BD9025F8BB
	for <lists+linux-pci@lfdr.de>; Mon,  7 Sep 2020 12:45:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728501AbgIGKpw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 7 Sep 2020 06:45:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:38788 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728477AbgIGKpv (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 7 Sep 2020 06:45:51 -0400
Received: from gaia (unknown [46.69.195.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0766520768;
        Mon,  7 Sep 2020 10:45:49 +0000 (UTC)
Date:   Mon, 7 Sep 2020 11:45:47 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, will.deacon@arm.com,
        bhelgaas@google.com, gcherian@marvell.com, guohanjun@huawei.com
Subject: Re: [PATCH] arm64: PCI: fix memleak when calling pci_iomap/unmap()
Message-ID: <20200907104546.GC26513@gaia>
References: <20200905024811.74701-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200905024811.74701-1-yangyingliang@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Sep 05, 2020 at 10:48:11AM +0800, Yang Yingliang wrote:
> diff --git a/arch/arm64/kernel/pci.c b/arch/arm64/kernel/pci.c
> index 1006ed2d7c604..ddfa1c53def48 100644
> --- a/arch/arm64/kernel/pci.c
> +++ b/arch/arm64/kernel/pci.c
> @@ -217,4 +217,9 @@ void pcibios_remove_bus(struct pci_bus *bus)
>  	acpi_pci_remove_bus(bus);
>  }
>  
> +void pci_iounmap(struct pci_dev *dev, void __iomem *addr)
> +{
> +	iounmap(addr);
> +}
> +EXPORT_SYMBOL(pci_iounmap);

So, what's wrong with the generic pci_iounmap() implementation?
Shouldn't it call iounmap() already?

-- 
Catalin
