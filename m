Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D54A41F0EC
	for <lists+linux-pci@lfdr.de>; Fri,  1 Oct 2021 17:13:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354865AbhJAPPJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 1 Oct 2021 11:15:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:50848 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1354953AbhJAPPJ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 1 Oct 2021 11:15:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EB84261A03;
        Fri,  1 Oct 2021 15:13:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633101205;
        bh=631cqBI4zzuyya1dk7UkFppXfo3kmF+rEVm0SaivdbY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=p89Wq91bkvdeRbhXf3oJAHa27xaldvYp8bV3NLoZ7Vn+JgUtfYBdWuoyVYJxhHBOO
         qI/wRkbYfw3+9d5GtrkTFN38DpjSMpk0MwnqW+PkfwsHNuJBMik7ELyC55V5q15cnb
         vuADqA/frDO9kwp/28O4r2myBF219H+JQkQCvSppBYr6gFq5Ff6+1rdD19N9y1gv8G
         JFiUvUPq/D3BAQ/0xevuDRwePlR9rnpVYBbUKRgPzTG7MAymSNhAc2e0N97zvu5t2E
         KZ15I1lPSDif9LHeM6dN10jnZ+mn16fCBscsvRU8nDjgKycs2nwcoPlxBNMaAMILle
         IhO+WqS54Onbw==
Date:   Fri, 1 Oct 2021 08:13:22 -0700
From:   Keith Busch <kbusch@kernel.org>
To:     Ajay Garg <ajaygargnsit@gmail.com>
Cc:     linux-pci@vger.kernel.org
Subject: Re: None of the virtual/physical/bus address matches the (base)
 BAR-0 register
Message-ID: <20211001151322.GA408729@dhcp-10-100-145-180.wdc.com>
References: <CAHP4M8UqzA4ET2bDVuucQYMJk9Lk4WqRr-9xX8=6YWXFOBBNzw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHP4M8UqzA4ET2bDVuucQYMJk9Lk4WqRr-9xX8=6YWXFOBBNzw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Oct 01, 2021 at 08:21:06PM +0530, Ajay Garg wrote:
> Hi All.
> 
> I have a SD/MMC reader over PCI, which displays the following (amongst
> others) when we do "lspci -vv" :
> 
> #########################################################
> Region 0: Memory at e2c20000 (32-bit, non-prefetchable) [size=512]
> #########################################################
> 
> Above shows that e2c20000 is the physical (base-)address of BAR0.
> 
> Now, in the device driver, I do the following :
> 
> ########################################################
> .....
> struct pci_dev *ptr;
> void __iomem *bar0_ptr;
> ......
> 
> ......
> pci_request_region(ptr, 0, "ajay_sd_mmc_BAR0_region");
> bar0_ptr = pci_iomap(ptr, 0, pci_resource_len(ptr, 0));
> 
> printk("Base virtual-address = [%p]\n", bar0_ptr);
> printk("Base physical-address = [%p]\n", virt_to_phys(bar0_ptr));
> printk("Base bus-address = [%p]\n", virt_to_bus(bar0_ptr));
>
> I have removed error-checking, but I confirm that pci_request_region()
> and pci_iomap calls are successful.
> 
> Now, in the 3 printk's, none of the value is printed as e2c20000.
> I was expecting that the 2nd result, of virt_to_phys() translation,
> would be equal to the base-address of BAR0 register, as reported by
> lspci.
> 
> 
> What am I missing?
> Will be grateful for pointers.

The CPU address isn't always the same as the PCI address. For example,
some memory resources are added via pci_add_resource_offset(), so the
windows the host sees will be different than the ones the devices use.
