Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BFAF6152823
	for <lists+linux-pci@lfdr.de>; Wed,  5 Feb 2020 10:20:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728078AbgBEJUC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 5 Feb 2020 04:20:02 -0500
Received: from verein.lst.de ([213.95.11.211]:36313 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728034AbgBEJUC (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 5 Feb 2020 04:20:02 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id CC7AC68C7B; Wed,  5 Feb 2020 10:19:59 +0100 (CET)
Date:   Wed, 5 Feb 2020 10:19:59 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: pci-usb/pci-sata broken with LPAE config after "reduce use of
 block bounce buffers"
Message-ID: <20200205091959.GA24413@lst.de>
References: <20200130075833.GC30735@lst.de> <4a41bd0d-6491-3822-172a-fbca8a6abba5@ti.com> <20200130164235.GA6705@lst.de> <f76af743-dcb5-f59d-b315-f2332a9dc906@ti.com> <20200203142155.GA16388@lst.de> <a5eb4f73-418a-6780-354f-175d08395e71@ti.com> <20200205074719.GA22701@lst.de> <4a8bf1d3-6f8e-d13e-eae0-4db54f5cab8c@ti.com> <20200205084844.GA23831@lst.de> <88d50d13-65c7-7ca3-59c6-56f7d66c3816@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <88d50d13-65c7-7ca3-59c6-56f7d66c3816@ti.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Feb 05, 2020 at 02:48:17PM +0530, Kishon Vijay Abraham I wrote:
> Christoph,
> 
> On 05/02/20 2:18 PM, Christoph Hellwig wrote:
> > On Wed, Feb 05, 2020 at 02:02:51PM +0530, Kishon Vijay Abraham I wrote:
> >>> you try that branch?
> >>
> >> I see data mismatch with that branch.
> > 
> > But previously it didn't work at all? If you disable LPAE and thus
> > limit the available RAM, does it work without any fixes?
> 
> Previously there was a warn dump and it gets stuck.
> 
> With the branch you shared (with LPAE enabled), there was data mismatch.
> With the branch you shared (with LPAE disabled), things work fine
> (https://pastebin.ubuntu.com/p/kPNdsJd7ds/)

Does the miscompare still happen if you revert:

 "dma-direct: improve DMA mask overflow reporting"

and

 "dma-direct: improve swiotlb error reporting"

?
