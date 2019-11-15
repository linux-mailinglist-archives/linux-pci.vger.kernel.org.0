Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D3127FDE8E
	for <lists+linux-pci@lfdr.de>; Fri, 15 Nov 2019 14:06:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727438AbfKONG5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 15 Nov 2019 08:06:57 -0500
Received: from verein.lst.de ([213.95.11.211]:44768 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727359AbfKONG4 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 15 Nov 2019 08:06:56 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id E7F7568BE1; Fri, 15 Nov 2019 14:06:54 +0100 (CET)
Date:   Fri, 15 Nov 2019 14:06:54 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: pci-usb/pci-sata broken with LPAE config after "reduce use of
 block bounce buffers"
Message-ID: <20191115130654.GA3414@lst.de>
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

What kernel version did you see your problems with?

Linux 5.3 added swiotlb to arm LPAE configs for exactly that case.
