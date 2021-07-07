Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA5FC3BEFF3
	for <lists+linux-pci@lfdr.de>; Wed,  7 Jul 2021 20:59:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230282AbhGGTCh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 7 Jul 2021 15:02:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:54348 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229956AbhGGTCg (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 7 Jul 2021 15:02:36 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2762161C4E;
        Wed,  7 Jul 2021 18:59:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625684396;
        bh=f0UCqmRmQe5IQivxXbam5YgNA+4X5IZ1IhO70Ol3PJA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=ci0IgWsmEuHTwPjLGSiw50ybEJuZlAcYm/nEGxsIbhQfJw/RChkDZR+IHypxZfCTB
         Vutb60MAP7yr55pBNZh0M07TiHIG/SmyhfYgG5674LqjHF/6kTngP5OUNPar/XzEG5
         9DMtVtj64YGddTS6q4mG/by0mAy74+BkaMAuer72i8nqDgi2GKlZzmwe+9BiNAkXdh
         lJhXhUcHPrRnq3Bj0B3U3SJ36oYj9Z1plP7pQfnx2P9ACmihyyY8VQ0ChzKA+ExPds
         zJOof/cNerhNNf9/gF1w/HvQJWaYxGb7iE6PP8YJmjb9qlM5FgCjQWDBqC4/Sgz9+3
         31+CYr4Ezi1SQ==
Date:   Wed, 7 Jul 2021 13:59:49 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     stuart hayes <stuart.w.hayes@gmail.com>
Cc:     Krzysztof Wilczy??ski <kw@linux.com>,
        Lukas Wunner <lukas@wunner.de>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2] PCI/portdrv: Use link bandwidth notification
 capability bit
Message-ID: <20210707185949.GA913194@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <692d2bb1-a4fe-5ba4-8576-761096338775@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jul 07, 2021 at 10:48:20AM -0500, stuart hayes wrote:
> On 5/26/2021 8:12 PM, stuart hayes wrote:
> > On 5/14/2021 8:17 AM, Krzysztof Wilczy??ski wrote:
> > > Hi Lukas,
> > > 
> > > [...]
> > > > > I was wondering - is this fix connected to an issue filled in Bugzilla
> > > > > or does it fix a known commit that introduced this problem?  Basically,
> > > > > I am trying to see whether a "Fixes:" would be in order.
> > > > 
> > > > The fix is for a driver which has been removed from the tree (for now),
> > > > including in stable kernels.  The fix will prevent an issue that will
> > > > occur once the driver is re-introduced (once we've found a way to
> > > > overcome the issues that led to its removal).  A Fixes tag is thus
> > > > uncalled for.
> > > 
> > > Thank you for adding more details.  Much appreciated.
> > > 
> > > Krzysztof
> > > 
> > 
> > I made the patch because it was causing the config space for a
> > downstream port to not get restored when a DPC event occurred, and all
> > the NVMe drives under it disappeared.  I found that myself, though--I'm
> > not aware of anyone else reporting the issue.
> 
> Any chance this might get accepted?  I'm not sure if it just got forgotten,
> or if there's a problem with it.  Thanks!  --Stuart

Sorry, still on my list but I'll look at it after -rc1 comes out this
weekend.
