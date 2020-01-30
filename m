Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 20EB514D728
	for <lists+linux-pci@lfdr.de>; Thu, 30 Jan 2020 08:58:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726464AbgA3H6g (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 30 Jan 2020 02:58:36 -0500
Received: from verein.lst.de ([213.95.11.211]:39324 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726397AbgA3H6g (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 30 Jan 2020 02:58:36 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 7834468B05; Thu, 30 Jan 2020 08:58:33 +0100 (CET)
Date:   Thu, 30 Jan 2020 08:58:33 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: pci-usb/pci-sata broken with LPAE config after "reduce use of
 block bounce buffers"
Message-ID: <20200130075833.GC30735@lst.de>
References: <120f7c3e-363d-deb0-a347-782ac869ee0d@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <120f7c3e-363d-deb0-a347-782ac869ee0d@ti.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Nov 15, 2019 at 04:29:31PM +0530, Kishon Vijay Abraham I wrote:
> Hi Christoph,
> 
> I think we are encountering a case where the connected PCIe card (like PCIe USB
> card) supports 64-bit addressing and the ARM core supports 64-bit addressing
> but the PCIe controller in the SoC to which PCIe card is connected supports
> only 32-bits.
> 
> Here dma APIs can provide an address above the 32 bit region to the PCIe card.
> However this will fail when the card tries to access the provided address via
> the PCIe controller.

What kernel version do you test?  The classic arm version of dma_capable
doesn't take the bus dma mask into account.  In Linux 5.5 I switched
ARM to use the generic version in

130c1ccbf55 ("dma-direct: unify the dma_capable definitions")

so with that this case is supposed to work, without that it doesn't
have much of a chance.
