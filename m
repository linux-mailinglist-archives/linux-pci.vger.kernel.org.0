Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD56C2D1835
	for <lists+linux-pci@lfdr.de>; Mon,  7 Dec 2020 19:09:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726314AbgLGSIR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 7 Dec 2020 13:08:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:54896 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725901AbgLGSIR (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 7 Dec 2020 13:08:17 -0500
Date:   Mon, 7 Dec 2020 10:07:34 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607364457;
        bh=TohaYNwxFaNLjhryFg+JpFX5XCyTM6jg4f/Oe9xniVQ=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=KqPJryLhxz4xeyX7Wmns7Y8XVrV6IrwNHdz/gDov7enLLn20AKXFYre0GrIdLEpy/
         O6pBwuKX80HQbkNQGdxxb+d/ldGS3xTV7cNiHGVyQRpxXen3LbYrQDBtjtIr2zAbYu
         2AwLveFpubLW84hexHTMHVyGF8lizgrQttJT2wQPJ0nNligtGeOBUTle/UpmQ7JG09
         XRPHXIgT6q6mhrjgwr8mDqVxcT4iCObRw8v80rF52m74okTk2LlvcQnuT1wcHVCT2t
         BnPNXOVXD70ipDUdSQ+BqrrINkQf3O4jytyo35xYq0MdDftG6k5SrbYHRYrt5frlXU
         bU/stl5rxvIcA==
From:   Keith Busch <kbusch@kernel.org>
To:     Puranjay Mohan <puranjay12@gmail.com>
Cc:     Christoph Hellwig <hch@infradead.org>, Damien.LeMoal@wdc.com,
        linux-block@vger.kernel.org, Bjorn Helgaas <bjorn@helgaas.com>,
        Linux PCI <linux-pci@vger.kernel.org>
Subject: Re: [PATCH] drivers: block: save return value of
 pci_find_capability() in u8
Message-ID: <20201207180734.GC3679937@dhcp-10-100-145-180.wdc.com>
References: <20201206194300.14221-1-puranjay12@gmail.com>
 <20201207145258.GA16899@infradead.org>
 <CANk7y0jqS+Crf4Z3k82DXh2qxn1JO9KAO_CJGrpqH6xAJYU6Qw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANk7y0jqS+Crf4Z3k82DXh2qxn1JO9KAO_CJGrpqH6xAJYU6Qw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Dec 07, 2020 at 11:23:03PM +0530, Puranjay Mohan wrote:
> On Mon, Dec 7, 2020 at 8:23 PM Christoph Hellwig <hch@infradead.org> wrote:
> >
> > Can we take a step back?  I think in general drivers should not bother
> > with pci_find_capability.  Both mtip32xx and skd want to find out if
> > the devices are PCIe devices, skd then just prints the link speed for
> > which we have much better helpers, mtip32xx than messes with DEVCTL
> > which seems actively dangerous to me.
> 
> The skd driver uses pci_find_capability(skdev->pdev, PCI_CAP_ID_EXP);
> to check if the device is PCIe, it can use pci_is_pcie() to do that.
> After that it uses pci_read_config_word(skdev->pdev, pcie_reg,
> &pcie_lstat); to read the Link Status Register, I think
> it should use pcie_capability_read_word(skdev->pdev, PCI_EXP_LNKSTA,
> &pcie_lstat);
> 
> Please let me know if the above changes are correct so I may send a patch.

You just want to print the current link speed, right? Does
skdev->pdev->bus->cur_bus_speed provide what you need?
