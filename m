Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 84D2A12AD66
	for <lists+linux-pci@lfdr.de>; Thu, 26 Dec 2019 17:13:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726480AbfLZQNa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 26 Dec 2019 11:13:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:39930 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726236AbfLZQNa (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 26 Dec 2019 11:13:30 -0500
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F4071206CB;
        Thu, 26 Dec 2019 16:13:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577376810;
        bh=5CpwpYwElWAF5Kv4usL3q9PjIqr9jhstpZ2xORSEU3Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Py4rhqigFMlvpN1YEIs0mPOApJTDvwpFgO6YWEJbGrfOyfSyNrt+G/nFTr3o6lYlD
         VuXAa4XqTJqdURBqH4uxvAkl/v3aLoHpsQ7AxNs8VdSRySv7Y7wifuKAbhySY42sHs
         LVZjQNQ4lJTIjLpoNu4sQ5hxi+X6jQ7ucD5cISJs=
Date:   Thu, 26 Dec 2019 09:13:27 -0700
From:   Keith Busch <kbusch@kernel.org>
To:     Renjun Wang <rwang@panyi.ai>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: PROBLEM: pci_alloc_irq_vectors function request 32 MSI
 interrupts vectors, but return 1 in KVM virtual machine.
Message-ID: <20191226161327.GA35073@dhcp-10-100-145-180.wdl.wdc.com>
References: <BJXPR01MB053429F1D6CD8E31B55D9D80DE280@BJXPR01MB0534.CHNPR01.prod.partner.outlook.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <BJXPR01MB053429F1D6CD8E31B55D9D80DE280@BJXPR01MB0534.CHNPR01.prod.partner.outlook.cn>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Dec 25, 2019 at 01:34:26AM +0000, Renjun Wang wrote:
> I have a virtual machine with ubuntu 16.4.03  on KVM platform. There
> is a PCIe device(Xilinx PCIe IP) plugged in the host machine.
>
> On the ubuntu operation system, I am developing the pcie driver. When
> I use pci_alloc_irq_vectors() function to allocate 32 msi vectors, but
> return 1.
>
> The command  `lspci -vvv` output shows 
> MSI: Enable+ Count=1/32 Maskable+ 64bit+
> 
> 
> there is a similar case https://stackoverflow.com/questions/49821599/multiple-msi-vectors-linux-pci-alloc-irq-vectors-return-one-while-the-devi.
> But not working for KVM virtual machine.
> 
> I do not known why the function  pci_alloc_irq_vectors() returns one ?

Are you setting the "PCI_IRQ_AFFINITY" flag in your alloc call like
in your stackoverflow link? If so, how many CPUs does your virtual
machine have?
