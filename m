Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE39E43E856
	for <lists+linux-pci@lfdr.de>; Thu, 28 Oct 2021 20:33:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230293AbhJ1SgF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 28 Oct 2021 14:36:05 -0400
Received: from foss.arm.com ([217.140.110.172]:58182 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229645AbhJ1SgF (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 28 Oct 2021 14:36:05 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 87EED1063;
        Thu, 28 Oct 2021 11:33:37 -0700 (PDT)
Received: from lpieralisi (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D49CC3F5A1;
        Thu, 28 Oct 2021 11:33:36 -0700 (PDT)
Date:   Thu, 28 Oct 2021 19:33:34 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        pali@kernel.org
Subject: Re: [PATCH 00/14] PCI: aardvark controller fixes BATCH 2
Message-ID: <20211028183334.GB4746@lpieralisi>
References: <20211012164145.14126-1-kabel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211012164145.14126-1-kabel@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Oct 12, 2021 at 06:41:31PM +0200, Marek Behún wrote:
> Hi Lorenzo,
> 
> we are sending second batch of updates for Aardvark PCIe controller.
> 
> - patch 1 fixes pci-bridge-emul handling of W1C bits
> - patches 2-9 fix MSI interrupts
> - patch 10 enables MSI-X interrupts
> - patches 11-14 fix registers in emulated PCI bridge

I tried to merge patch [1-3] and [11-14] but [11-14] need rebasing
if I drop the ones in between.

Please if you have time resend [1-3][11-14] as a series and I shall
pull them (I have a pending question on patch 12 though).

Thanks,
Lorenzo

> Marek & Pali
> 
> Marek Behún (3):
>   PCI: pci-bridge-emul: Fix emulation of W1C bits
>   PCI: aardvark: Fix return value of MSI domain .alloc() method
>   PCI: aardvark: Read all 16-bits from PCIE_MSI_PAYLOAD_REG
> 
> Pali Rohár (11):
>   PCI: aardvark: Fix support for MSI interrupts
>   PCI: aardvark: Fix reading MSI interrupt number
>   PCI: aardvark: Clear all MSIs at setup
>   PCI: aardvark: Refactor unmasking summary MSI interrupt
>   PCI: aardvark: Fix masking MSI interrupts
>   PCI: aardvark: Fix setting MSI address
>   PCI: aardvark: Enable MSI-X support
>   PCI: aardvark: Fix support for bus mastering and PCI_COMMAND on
>     emulated bridge
>   PCI: aardvark: Set PCI Bridge Class Code to PCI Bridge
>   PCI: aardvark: Fix support for PCI_BRIDGE_CTL_BUS_RESET on emulated
>     bridge
>   PCI: aardvark: Fix support for PCI_ROM_ADDRESS1 on emulated bridge
> 
>  drivers/pci/controller/pci-aardvark.c | 226 ++++++++++++++++++++------
>  drivers/pci/pci-bridge-emul.c         |  13 ++
>  2 files changed, 188 insertions(+), 51 deletions(-)
> 
> -- 
> 2.32.0
> 
