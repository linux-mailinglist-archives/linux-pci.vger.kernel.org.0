Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FA54420306
	for <lists+linux-pci@lfdr.de>; Sun,  3 Oct 2021 19:05:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230519AbhJCRHA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 3 Oct 2021 13:07:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:51764 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230504AbhJCRHA (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 3 Oct 2021 13:07:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2ADFB61A54;
        Sun,  3 Oct 2021 17:05:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633280712;
        bh=kjm4yQ2dSP4syjQJv5Vac5bZ3EEqbasYaEDIDVysOTg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=bPB1ZYXBh2irUXIhlFc4Hl6dt3dmisSn1yW8qGgV5LwMn1KAhrN+SH/2UdMbO5wDR
         9R8MQJopnPbv0m5uZNVm6wUVE7LtCqJQi/fMMIzv0dmpD+wbZJVkTJ0txJIasRu4h2
         sYefb98/OC/EOShNNZ44lrEyPdrUDD63YWjNkF5xksrPhcfSDXZdFrx5qrxe7nU8k9
         MSTl4QvWBpWkWGxpWulG3b/owJHwsUJq06VJVG4NvniL2yjX+Yngtkw+XpdLwYR1Wr
         650+7L5CzW+wpuUL9iwiyybCCSgX50KoYn/kyDxM1lujrlDR4XWbLHOhpx4at8Ujix
         mTff2yQ2QZPAQ==
Date:   Sun, 3 Oct 2021 12:05:10 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Ajay Garg <ajaygargnsit@gmail.com>
Cc:     Keith Busch <kbusch@kernel.org>, linux-pci@vger.kernel.org
Subject: Re: None of the virtual/physical/bus address matches the (base)
 BAR-0 register
Message-ID: <20211003170510.GA982214@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHP4M8XzZCwKk3TGmHKVMdf5mkWKfafE75DEKBs6-t4ZPw-kaw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Oct 03, 2021 at 07:35:41AM +0530, Ajay Garg wrote:
> > Yes.  You should not need to use virt_to_phys() for PCI MMIO
> > addresses.
> 
> Hmm, the thing that started it all :P
> 
> > This path is IN the picture.  This is exactly the path used by drivers
> > doing MMIO accesses.
> >
> > The CPU does a load from a virtual address (0xffffa0c6c02eb000).  The
> > MMU translates that virtual address to a physical address
> > (0xe2c20000).
> 
> Hmm, so I guess the core takeaway is that the virtual-address <=>
> physical-address mapping is indeed happening as envisioned. It's just
> that there is no programmatic way to prove/display the mapped physical
> address, in the case of PCI-MMIO transfers (as virt_to_phys() is not
> usable in this case).

  bar0_ptr = pci_iomap(ptr, 0, pci_resource_len(ptr, 0));

  printk("Base physical-address (form-1) = [%lx]\n", dev->resource[0].start);
  printk("Base physical-address (form-2) = [%lx]\n", virt_to_phys(bar0_ptr));

  Base physical-address (form-1) = [e2c20000]
  Base physical-address (form-2) = [12e6002eb000]

Despite the fact that you shouldn't *need* to use virt_to_phys()
because drivers use virtual addresses to do MMIO, it *does* seem like
form-1 and form-2 should be the same since form-2 is basically the
result of:

  virt_to_phys(ioremap(form-1))

I can't explain the difference.
