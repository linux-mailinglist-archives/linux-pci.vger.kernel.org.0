Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81ACF203644
	for <lists+linux-pci@lfdr.de>; Mon, 22 Jun 2020 13:55:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727981AbgFVLzk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 22 Jun 2020 07:55:40 -0400
Received: from 8bytes.org ([81.169.241.247]:48372 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727799AbgFVLzk (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 22 Jun 2020 07:55:40 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 746F636B; Mon, 22 Jun 2020 13:55:38 +0200 (CEST)
Date:   Mon, 22 Jun 2020 13:55:37 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Zhangfei Gao <zhangfei.gao@linaro.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Hanjun Guo <guohanjun@huawei.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        jean-philippe <jean-philippe@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        kenneth-lee-2012@foxmail.com, Wangzhou <wangzhou1@hisilicon.com>,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        iommu@lists.linux-foundation.org, linux-acpi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH 0/2] Introduce PCI_FIXUP_IOMMU
Message-ID: <20200622115536.GH3701@8bytes.org>
References: <20200601174104.GA734973@bjorn-Precision-5520>
 <779f4044-cf6a-b0d3-916f-0274450c07d3@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <779f4044-cf6a-b0d3-916f-0274450c07d3@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jun 04, 2020 at 09:33:07PM +0800, Zhangfei Gao wrote:
> +++ b/drivers/iommu/iommu.c
> @@ -2418,6 +2418,10 @@ int iommu_fwspec_init(struct device *dev, struct
> fwnode_handle *iommu_fwnode,
>         fwspec->iommu_fwnode = iommu_fwnode;
>         fwspec->ops = ops;
>         dev_iommu_fwspec_set(dev, fwspec);
> +
> +       if (dev_is_pci(dev))
> +               pci_fixup_device(pci_fixup_final, to_pci_dev(dev));
> +

That's not going to fly, I don't think we should run the fixups twice,
and they should not be run from IOMMU code. Is the only reason for this
second pass that iommu_fwspec is not yet allocated when it runs the
first time? I ask because it might be easier to just allocate the struct
earlier then.

Regards,

	Joerg
