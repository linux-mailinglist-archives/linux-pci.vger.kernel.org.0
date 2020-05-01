Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4ECD81C184A
	for <lists+linux-pci@lfdr.de>; Fri,  1 May 2020 16:47:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729309AbgEAOqI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 1 May 2020 10:46:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:53628 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729434AbgEAOqH (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 1 May 2020 10:46:07 -0400
Received: from localhost (mobile-166-175-184-168.mycingular.net [166.175.184.168])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1019020857;
        Fri,  1 May 2020 14:46:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588344366;
        bh=v2w4/6U0YomoqMu9R0xWF2AIpjpBELByx2/SoReXrgM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=cKaEafwIZEj3qeHZPBR4aUAeYkFReJVPxAiqe+ALOPwcbbuT1UfNmMqGPBgbOzAJB
         1es+t74JKbObhCqW7OIK1+M8u3q5pXmozFcYVTWNghyYoYCPThIjsaBWa/Wv9FxtnE
         gAuhmuGwhokE2MD/OBT7K9+NSH2EY6ogt8ttjAKc=
Date:   Fri, 1 May 2020 09:46:04 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Will Deacon <will@kernel.org>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mans Rullgard <mans@mansr.com>,
        Marc Gonzalez <marc.w.gonzalez@free.fr>,
        Robert Richter <rrichter@marvell.com>,
        Zhou Wang <wangzhou1@hisilicon.com>,
        Toan Le <toan@os.amperecomputing.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Jonathan Chocron <jonnyc@amazon.com>,
        linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH 0/3] PCI: Modularize host-generic
Message-ID: <20200501144604.GA108647@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200501141626.GA7398@e121166-lin.cambridge.arm.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, May 01, 2020 at 03:16:26PM +0100, Lorenzo Pieralisi wrote:
> On Thu, Apr 09, 2020 at 05:49:20PM -0600, Rob Herring wrote:
> > This is part of a larger effort to modularize ARCH_VEXPRESS. In
> > particular, the Arm FVP platforms use the host-generic driver. This
> > conversion was straight-forward. I didn't convert the other ECAM drivers
> > using host-common to modules, but am happy to do so if there's a strong
> > desire to do so.
> > 
> > In the process, I noticed that 'const' was being dropped from the match
> > table .data pointer, so the first patch constifies struct pci_ecam_ops.
> > I started trying to constify pci_ops too, but that became a never ending
> > treewide rabbit hole. So I ended up with a cast when we assign pci_ops
> > from pci_ecam_ops.
> > 
> > Rob
> 
> Hi Bjorn,
> 
> if you don't have any objections I'd need your ACK to take this
> series.

Oh, sorry, I didn't notice:

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> > Rob Herring (3):
> >   PCI: Constify struct pci_ecam_ops
> >   PCI: host-generic: Support building as modules
> >   PCI: host-generic: Eliminate pci_host_common_probe wrappers
> > 
> >  arch/arm64/kernel/pci.c                   |  4 ++--
> >  drivers/acpi/pci_mcfg.c                   |  8 +++----
> >  drivers/pci/controller/Kconfig            |  4 ++--
> >  drivers/pci/controller/dwc/pcie-al.c      |  2 +-
> >  drivers/pci/controller/dwc/pcie-hisi.c    | 19 +++++------------
> >  drivers/pci/controller/pci-host-common.c  | 18 ++++++++++++----
> >  drivers/pci/controller/pci-host-generic.c | 26 +++++++----------------
> >  drivers/pci/controller/pci-thunder-ecam.c | 14 ++++++------
> >  drivers/pci/controller/pci-thunder-pem.c  | 16 ++++++--------
> >  drivers/pci/controller/pci-xgene.c        |  4 ++--
> >  drivers/pci/controller/pcie-tango.c       |  9 +++++---
> >  drivers/pci/ecam.c                        | 10 ++++++---
> >  drivers/pci/setup-bus.c                   |  1 +
> >  include/linux/pci-acpi.h                  |  2 +-
> >  include/linux/pci-ecam.h                  | 25 +++++++++++-----------
> >  15 files changed, 78 insertions(+), 84 deletions(-)
> > 
> > --
> > 2.20.1
