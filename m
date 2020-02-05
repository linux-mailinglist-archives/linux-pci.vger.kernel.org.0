Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 378A815272F
	for <lists+linux-pci@lfdr.de>; Wed,  5 Feb 2020 08:47:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725497AbgBEHrW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 5 Feb 2020 02:47:22 -0500
Received: from verein.lst.de ([213.95.11.211]:36001 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725468AbgBEHrW (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 5 Feb 2020 02:47:22 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id D9A8B68CEC; Wed,  5 Feb 2020 08:47:19 +0100 (CET)
Date:   Wed, 5 Feb 2020 08:47:19 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: pci-usb/pci-sata broken with LPAE config after "reduce use of
 block bounce buffers"
Message-ID: <20200205074719.GA22701@lst.de>
References: <120f7c3e-363d-deb0-a347-782ac869ee0d@ti.com> <20200130075833.GC30735@lst.de> <4a41bd0d-6491-3822-172a-fbca8a6abba5@ti.com> <20200130164235.GA6705@lst.de> <f76af743-dcb5-f59d-b315-f2332a9dc906@ti.com> <20200203142155.GA16388@lst.de> <a5eb4f73-418a-6780-354f-175d08395e71@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a5eb4f73-418a-6780-354f-175d08395e71@ti.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Feb 05, 2020 at 10:45:24AM +0530, Kishon Vijay Abraham I wrote:
> > Ok, this mostly like means we allocate a swiotlb buffer that isn't
> > actually addressable.  To verify that can you post the output with the
> > first attached patch?  If it shows the overflow message added there,
> > please try if the second patch fixes it.
> 
> I'm seeing some sort of busy loop after applying your 1st patch. I sent
> a SysRq to see where it is stuck

And that shows up just with the patch?  Really strange as it doesn't
change any blockig points.  What also is strange is that I don't see
any of the warnings that should be there.  FYI, the slightly updated
version of the patch that went through my testing it here:

    git://git.infradead.org/users/hch/misc.git swiotlb-debug

Gitweb:

    http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/swiotlb-debug

this also includes what was the second patch in the previous mail.  Can
you try that branch?
