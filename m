Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 751FC5E219
	for <lists+linux-pci@lfdr.de>; Wed,  3 Jul 2019 12:33:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726678AbfGCKd3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 3 Jul 2019 06:33:29 -0400
Received: from foss.arm.com ([217.140.110.172]:43760 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725796AbfGCKd2 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 3 Jul 2019 06:33:28 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 07DC2344;
        Wed,  3 Jul 2019 03:33:28 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (unknown [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 052843F246;
        Wed,  3 Jul 2019 03:33:25 -0700 (PDT)
Date:   Wed, 3 Jul 2019 11:33:19 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     "Z.q. Hou" <zhiqiang.hou@nxp.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "l.subrahmanya@mobiveil.co.in" <l.subrahmanya@mobiveil.co.in>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Leo Li <leoyang.li@nxp.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        Mingkai Hu <mingkai.hu@nxp.com>,
        "M.h. Lian" <minghuan.lian@nxp.com>,
        Xiaowei Bao <xiaowei.bao@nxp.com>
Subject: Re: [PATCHv5 00/20] PCI: mobiveil: fixes for Mobiveil PCIe Host
 Bridge IP driver
Message-ID: <20190703103319.GA26804@e121166-lin.cambridge.arm.com>
References: <20190412083635.33626-1-Zhiqiang.Hou@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190412083635.33626-1-Zhiqiang.Hou@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Apr 12, 2019 at 08:35:11AM +0000, Z.q. Hou wrote:
> From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> 
> This patch set is to add fixes for Mobiveil PCIe Host driver.
> And these patches are splited from the thread below:
> http://patchwork.ozlabs.org/project/linux-pci/list/?series=96417
> 
> Hou Zhiqiang (20):
>   PCI: mobiveil: Unify register accessors
>   PCI: mobiveil: Format the code without functionality change
>   PCI: mobiveil: Correct the returned error number
>   PCI: mobiveil: Remove the flag MSI_FLAG_MULTI_PCI_MSI
>   PCI: mobiveil: Correct PCI base address in MEM/IO outbound windows
>   PCI: mobiveil: Replace the resource list iteration function
>   PCI: mobiveil: Use WIN_NUM_0 explicitly for CFG outbound window
>   PCI: mobiveil: Use the 1st inbound window for MEM inbound transactions
>   PCI: mobiveil: Correct inbound/outbound window setup routines
>   PCI: mobiveil: Fix the INTx process errors
>   PCI: mobiveil: Correct the fixup of Class Code field
>   PCI: mobiveil: Move the link up waiting out of mobiveil_host_init()
>   PCI: mobiveil: Move IRQ chained handler setup out of DT parse
>   PCI: mobiveil: Initialize Primary/Secondary/Subordinate bus numbers
>   PCI: mobiveil: Fix the checking of valid device
>   PCI: mobiveil: Add link up condition check
>   PCI: mobiveil: Complete initialization of host even if no PCIe link
>   PCI: mobiveil: Disable IB and OB windows set by bootloader
>   PCI: mobiveil: Add 8-bit and 16-bit register accessors
>   dt-bindings: PCI: mobiveil: Change gpio_slave and apb_csr to optional
> 
>  .../devicetree/bindings/pci/mobiveil-pcie.txt |   2 +
>  drivers/pci/controller/pcie-mobiveil.c        | 578 +++++++++++-------
>  2 files changed, 368 insertions(+), 212 deletions(-)

I am putting together a branch with the patches I would like
to queue, for the ones I requested to split please wait for
me, I will publish the branch and will ask you to rebase
on top of it.

Lorenzo
