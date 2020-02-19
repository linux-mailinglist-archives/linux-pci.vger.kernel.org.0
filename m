Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B1AE616426D
	for <lists+linux-pci@lfdr.de>; Wed, 19 Feb 2020 11:42:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726707AbgBSKmr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 19 Feb 2020 05:42:47 -0500
Received: from 8bytes.org ([81.169.241.247]:54904 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726270AbgBSKmr (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 19 Feb 2020 05:42:47 -0500
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id C31CF36C; Wed, 19 Feb 2020 11:42:45 +0100 (CET)
Date:   Wed, 19 Feb 2020 11:42:44 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc:     bhelgaas@google.com, will@kernel.org, robh+dt@kernel.org,
        lorenzo.pieralisi@arm.com, baolu.lu@linux.intel.com,
        linux-doc@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-acpi@vger.kernel.org, iommu@lists.linux-foundation.org,
        corbet@lwn.net, mark.rutland@arm.com, liviu.dudau@arm.com,
        sudeep.holla@arm.com, guohanjun@huawei.com, rjw@rjwysocki.net,
        lenb@kernel.org, robin.murphy@arm.com, dwmw2@infradead.org,
        amurray@thegoodpenguin.co.uk, frowand.list@gmail.com
Subject: Re: [PATCH 00/10] PCI/ATS: Device-tree support and other improvements
Message-ID: <20200219104244.GD1961@8bytes.org>
References: <20200213165049.508908-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200213165049.508908-1-jean-philippe@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Jean-Philippe,


On Thu, Feb 13, 2020 at 05:50:38PM +0100, Jean-Philippe Brucker wrote:
> Jean-Philippe Brucker (11):
>   dt-bindings: PCI: generic: Add ats-supported property
>   PCI: Add ats_supported host bridge flag
>   PCI: OF: Check whether the host bridge supports ATS
>   ACPI/IORT: Check ATS capability in root complex node
>   PCI/ATS: Gather checks into pci_ats_supported()
>   iommu/amd: Use pci_ats_supported()
>   iommu/arm-smmu-v3: Use pci_ats_supported()
>   iommu/vt-d: Use pci_ats_supported()
>   ACPI/IORT: Drop ATS fwspec flag
>   arm64: dts: fast models: Enable PCIe ATS for Base RevC FVP
>   Documentation: Generalize the "pci=noats" boot parameter 

Nice patch-set! Thanks for the consolidation work. I can take it into
the iommu-tree, given that the non-iommu parts get the necessary Acks.


Regards,

	Joerg
