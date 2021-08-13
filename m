Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA9CD3EB98E
	for <lists+linux-pci@lfdr.de>; Fri, 13 Aug 2021 17:53:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241152AbhHMPyA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 13 Aug 2021 11:54:00 -0400
Received: from foss.arm.com ([217.140.110.172]:55230 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236895AbhHMPx7 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 13 Aug 2021 11:53:59 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 84EAD1FB;
        Fri, 13 Aug 2021 08:53:32 -0700 (PDT)
Received: from lpieralisi (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3439B3F718;
        Fri, 13 Aug 2021 08:53:31 -0700 (PDT)
Date:   Fri, 13 Aug 2021 16:53:28 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Luca Ceresoli <luca@lucaceresoli.net>, kishon@ti.com
Cc:     linux-pci@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Subject: Re: [PATCH v2 0/4] PCI: dwc: pci-dra7xx: miscellaneous improvements
Message-ID: <20210813155328.GC15515@lpieralisi>
References: <20210531085934.2662457-1-luca@lucaceresoli.net>
 <20210621144109.GC27516@lpieralisi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210621144109.GC27516@lpieralisi>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jun 21, 2021 at 03:41:09PM +0100, Lorenzo Pieralisi wrote:
> On Mon, May 31, 2021 at 10:59:30AM +0200, Luca Ceresoli wrote:
> > This is an series of mixed improvements to the DRA7 PCI controller driver:
> > allow building as a loadabel module, allow to get and enable a clock and a
> > small cleanup.
> > 
> > Luca
> > 
> > Luca Ceresoli (4):
> >   PCI: dwc: Export more symbols to allow modular drivers
> >   PCI: dra7xx: Make it a kernel module
> >   PCI: dra7xx: Remove unused include
> >   PCI: dra7xx: Get an optional clock
> > 
> >  drivers/pci/controller/dwc/Kconfig            |  6 ++---
> >  drivers/pci/controller/dwc/pci-dra7xx.c       | 22 +++++++++++++++++--
> >  .../pci/controller/dwc/pcie-designware-ep.c   |  1 +
> >  drivers/pci/controller/dwc/pcie-designware.c  |  1 +
> >  4 files changed, 25 insertions(+), 5 deletions(-)
> 
> Hi Kishon,
> 
> I'd need your ACK to proceed with this series that looks like it
> is ready to go, please let me know.

Still need it - please let me know.

Lorenzo
