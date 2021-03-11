Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 625C3337F96
	for <lists+linux-pci@lfdr.de>; Thu, 11 Mar 2021 22:23:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230150AbhCKVXE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 11 Mar 2021 16:23:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:42112 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229490AbhCKVWk (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 11 Mar 2021 16:22:40 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 11FD964F9F;
        Thu, 11 Mar 2021 21:22:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615497760;
        bh=oasnzg0v+A/izrbjsAY+YofycDi4i+ZadoG5W9BgJuo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=oUxSKxGJGNPP3L+KvJksO9LfWPSKopMM5RRg4vFGPECDhLNwfOGXbbfIXPSA65aKQ
         W43U65I8qbAqgBOZOSOyZc3XWls5mDKw1Z5mgqAk+1XAtUmIIaRZtXuZAt00uN0ZpK
         qlxecAFCJ9YyQmdRxIy3s7konocztYkAtwqp/eaQg1YQrSyHqIwhEwyJxSVE2JSyHA
         4Wp0HzEDbew0WdY4VALhnQXEIAx3uhQdZXSrzJ+Ue1JpHy4VGxMDknk3tbzokwYKnv
         l2DFpKN96hA49CRKfDmPxj6t2gY1dqVQOZl+QVFSlxcH5M5uoeTrblvczVPSqyMT9s
         80bcnW79fvR6A==
Date:   Thu, 11 Mar 2021 15:22:38 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh@kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/3] PCI: controller: al: select CONFIG_PCI_ECAM
Message-ID: <20210311212238.GA2169679@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a2tNAqjSSP4g6dguT58C4DUGUT4Jgf-Osa1Da03cecLRQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Mar 10, 2021 at 10:02:55PM +0100, Arnd Bergmann wrote:
> On Wed, Mar 10, 2021 at 8:32 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> >
> > On Mon, Mar 08, 2021 at 04:24:46PM +0100, Arnd Bergmann wrote:
> > > From: Arnd Bergmann <arnd@arndb.de>
> > >
> > > Compile-testing this driver without ECAM support results in a link
> > > failure:
> > >
> > > ld.lld: error: undefined symbol: pci_ecam_map_bus
> > > >>> referenced by pcie-al.c
> > > >>>               pci/controller/dwc/pcie-al.o:(al_pcie_map_bus) in archive drivers/built-in.a
> > >
> > > Select CONFIG_ECAM like the other drivers do.
> >
> > Did we add these compile issues in the v5.12-rc1?  I.e., are the fixes
> > candidates for v5.12?
> 
> No, the bug exists but is hidden until you apply patch 3/3 because the
> driver is never compile tested on anything other than arm64, which
> turns on PCI_ECAM unconditionally.
> 
> Merging all three for 5.13 is sufficient.

I put these on pci/misc for v5.13, thanks!
