Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46A9A2037F0
	for <lists+linux-pci@lfdr.de>; Mon, 22 Jun 2020 15:26:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728993AbgFVN0r (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 22 Jun 2020 09:26:47 -0400
Received: from 8bytes.org ([81.169.241.247]:48416 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728194AbgFVN0q (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 22 Jun 2020 09:26:46 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 1D94436B; Mon, 22 Jun 2020 15:26:43 +0200 (CEST)
Date:   Mon, 22 Jun 2020 15:26:42 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        iommu@lists.linux-foundation.org, linux-acpi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Hanjun Guo <guohanjun@huawei.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Makarand Pawagi <makarand.pawagi@nxp.com>,
        Diana Craciun <diana.craciun@oss.nxp.com>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>
Subject: Re: [PATCH v2 06/12] of/iommu: Make of_map_rid() PCI agnostic
Message-ID: <20200622132642.GJ3701@8bytes.org>
References: <20200521130008.8266-1-lorenzo.pieralisi@arm.com>
 <20200619082013.13661-1-lorenzo.pieralisi@arm.com>
 <20200619082013.13661-7-lorenzo.pieralisi@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200619082013.13661-7-lorenzo.pieralisi@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jun 19, 2020 at 09:20:07AM +0100, Lorenzo Pieralisi wrote:
> There is nothing PCI specific (other than the RID - requester ID)
> in the of_map_rid() implementation, so the same function can be
> reused for input/output IDs mapping for other busses just as well.
> 
> Rename the RID instances/names to a generic "id" tag.
> 
> No functionality change intended.
> 
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Joerg Roedel <joro@8bytes.org>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Cc: Marc Zyngier <maz@kernel.org>
> ---
>  drivers/iommu/of_iommu.c |  4 ++--
>  drivers/of/base.c        | 42 ++++++++++++++++++++--------------------
>  drivers/of/irq.c         |  2 +-
>  include/linux/of.h       |  4 ++--
>  4 files changed, 26 insertions(+), 26 deletions(-)

Acked-by: Joerg Roedel <jroedel@suse.de>

