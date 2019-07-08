Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7F62661DD1
	for <lists+linux-pci@lfdr.de>; Mon,  8 Jul 2019 13:35:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730465AbfGHLfL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 8 Jul 2019 07:35:11 -0400
Received: from foss.arm.com ([217.140.110.172]:45522 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727591AbfGHLfL (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 8 Jul 2019 07:35:11 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 88589360;
        Mon,  8 Jul 2019 04:35:10 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (unknown [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 83AEF3F738;
        Mon,  8 Jul 2019 04:35:08 -0700 (PDT)
Date:   Mon, 8 Jul 2019 12:35:03 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Cc:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        bhelgaas@google.com, robh+dt@kernel.org, mark.rutland@arm.com,
        l.subrahmanya@mobiveil.co.in, shawnguo@kernel.org,
        leoyang.li@nxp.com, catalin.marinas@arm.com, will.deacon@arm.com,
        Mingkai.Hu@nxp.com, Minghuan.Lian@nxp.com, Xiaowei.Bao@nxp.com
Subject: Re: [PATCHv6 00/28] PCI: mobiveil: fixes for Mobiveil PCIe Host
 Bridge IP driver
Message-ID: <20190708113503.GA21942@e121166-lin.cambridge.arm.com>
References: <20190705095656.19191-1-Zhiqiang.Hou@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190705095656.19191-1-Zhiqiang.Hou@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jul 05, 2019 at 05:56:28PM +0800, Hou Zhiqiang wrote:
> This patch set is to add fixes for Mobiveil PCIe Host driver.
> Splited #2, #3, #9 and #10 of v5 patches.
> 
> Hou Zhiqiang (28):
>   PCI: mobiveil: Unify register accessors
>   PCI: mobiveil: Remove the flag MSI_FLAG_MULTI_PCI_MSI
>   PCI: mobiveil: Fix PCI base address in MEM/IO outbound windows
>   PCI: mobiveil: Update the resource list traversal function
>   PCI: mobiveil: Use WIN_NUM_0 explicitly for CFG outbound window
>   PCI: mobiveil: Use the 1st inbound window for MEM inbound
>     transactions
>   PCI: mobiveil: Fix the Class Code field
>   PCI: mobiveil: Move the link up waiting out of mobiveil_host_init()
>   PCI: mobiveil: Move IRQ chained handler setup out of DT parse
>   PCI: mobiveil: Initialize Primary/Secondary/Subordinate bus numbers
>   PCI: mobiveil: Fix devfn check in mobiveil_pcie_valid_device()
>   dt-bindings: PCI: mobiveil: Change gpio_slave and apb_csr to optional
>   PCI: mobiveil: Reformat the code for readability
>   PCI: mobiveil: Make the register updating more readable
>   PCI: mobiveil: Revise the MEM/IO outbound window initialization
>   PCI: mobiveil: Fix the returned error number
>   PCI: mobiveil: Remove an unnecessary return value check
>   PCI: mobiveil: Remove redundant var definitions and register read
>     operations
>   PCI: mobiveil: Fix the valid check for inbound and outbound window
>   PCI: mobiveil: Add the statistic of initialized inbound windows
>   PCI: mobiveil: Clear the target fields before updating the register
>   PCI: mobiveil: Mask out the lower 10-bit hardcode window size
>   PCI: mobiveil: Add upper 32-bit CPU base address setup in outbound
>     window
>   PCI: mobiveil: Add upper 32-bit PCI base address setup in inbound
>     window
>   PCI: mobiveil: Fix the CPU base address setup in inbound window
>   PCI: mobiveil: Move PCIe PIO enablement out of inbound window routine
>   PCI: mobiveil: Fix infinite-loop in the INTx process
>   PCI: mobiveil: Fix the potential INTx missing problem
> 
>  .../devicetree/bindings/pci/mobiveil-pcie.txt      |    2 +
>  drivers/pci/controller/pcie-mobiveil.c             |  529 ++++++++++++--------
>  2 files changed, 318 insertions(+), 213 deletions(-)
> 

OK, I rewrote most of commit logs, dropped patch 25 since I do not
understand the commit log, pushed to pci/mobiveil tentatively for
v5.3.

Having said that, you should improve commit logs writing it took
me too much time to check them all and rewrite them.

Never ever again post a massive series like this mixing refactoring
fixes and clean-ups it was painful to review/rebase, please split
patch series into small chunks to make my life much easier.

Please check my pci/mobiveil branch and report back if something
is not in order.

Lorenzo
