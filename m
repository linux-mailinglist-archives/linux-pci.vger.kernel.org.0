Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 610BC433E8A
	for <lists+linux-pci@lfdr.de>; Tue, 19 Oct 2021 20:36:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232144AbhJSSi3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 19 Oct 2021 14:38:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:50896 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231783AbhJSSi3 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 19 Oct 2021 14:38:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CC75E60FC2;
        Tue, 19 Oct 2021 18:36:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634668576;
        bh=TroxlICHwR3suVp9Dk7ZQZ7w9nBv2uXWhPxdXOq7qk8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=L361jJfpluiPiJuDwoQgxmHGCQ7G6zqxuWIitrc3WhTFeW5UWCL5Y7Xv9a8Q1Pnao
         y/HNbbxl/p9ZxE6O9Ho4NSm29vpTV5nEOK08ftvqHG5SXjt8+A2KNfx/QT9B0ga9Y/
         Ogr2AIMk5PmdxAexVvN2bO0x1tGbzqKB/vLhPodCdGf+xM5H3OjlycfUKuMPTDrnPF
         EjKOpypT+XbLkyV2okKwxgzy+FTlsbdqhFayc0kRFguqYhLmKmgJ8TCMnn8PmkAIIH
         R0WJ9P6OBhqaVtlGD6XhezJklqQc90bJcYA0rx02+jYyAQM3h2jLxcZZu6+RMTSW6O
         hcyC8l1ijkpeg==
Received: by pali.im (Postfix)
        id 594FAAC1; Tue, 19 Oct 2021 20:36:13 +0200 (CEST)
Date:   Tue, 19 Oct 2021 20:36:13 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>
Cc:     Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH 00/14] PCI: aardvark controller fixes BATCH 2
Message-ID: <20211019183613.5slrrxw5plzfpuas@pali>
References: <20211012164145.14126-1-kabel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211012164145.14126-1-kabel@kernel.org>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello! Could you please review these patches? We have another 40+
patches for pci-aardvark driver which we would like to send for review
targeting next 5.16.

On Tuesday 12 October 2021 18:41:31 Marek Behún wrote:
> Hi Lorenzo,
> 
> we are sending second batch of updates for Aardvark PCIe controller.
> 
> - patch 1 fixes pci-bridge-emul handling of W1C bits
> - patches 2-9 fix MSI interrupts
> - patch 10 enables MSI-X interrupts
> - patches 11-14 fix registers in emulated PCI bridge
> 
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
