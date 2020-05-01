Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 846391C19D8
	for <lists+linux-pci@lfdr.de>; Fri,  1 May 2020 17:39:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729050AbgEAPij (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 1 May 2020 11:38:39 -0400
Received: from foss.arm.com ([217.140.110.172]:42882 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728865AbgEAPig (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 1 May 2020 11:38:36 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0FD7A30E;
        Fri,  1 May 2020 08:38:35 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 140BF3F68F;
        Fri,  1 May 2020 08:38:32 -0700 (PDT)
Date:   Fri, 1 May 2020 16:38:30 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, Will Deacon <will@kernel.org>,
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
Message-ID: <20200501153830.GD7398@e121166-lin.cambridge.arm.com>
References: <20200409234923.21598-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200409234923.21598-1-robh@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Apr 09, 2020 at 05:49:20PM -0600, Rob Herring wrote:
> This is part of a larger effort to modularize ARCH_VEXPRESS. In
> particular, the Arm FVP platforms use the host-generic driver. This
> conversion was straight-forward. I didn't convert the other ECAM drivers
> using host-common to modules, but am happy to do so if there's a strong
> desire to do so.
> 
> In the process, I noticed that 'const' was being dropped from the match
> table .data pointer, so the first patch constifies struct pci_ecam_ops.
> I started trying to constify pci_ops too, but that became a never ending
> treewide rabbit hole. So I ended up with a cast when we assign pci_ops
> from pci_ecam_ops.
> 
> Rob
> 
> 
> Rob Herring (3):
>   PCI: Constify struct pci_ecam_ops
>   PCI: host-generic: Support building as modules
>   PCI: host-generic: Eliminate pci_host_common_probe wrappers
> 
>  arch/arm64/kernel/pci.c                   |  4 ++--
>  drivers/acpi/pci_mcfg.c                   |  8 +++----
>  drivers/pci/controller/Kconfig            |  4 ++--
>  drivers/pci/controller/dwc/pcie-al.c      |  2 +-
>  drivers/pci/controller/dwc/pcie-hisi.c    | 19 +++++------------
>  drivers/pci/controller/pci-host-common.c  | 18 ++++++++++++----
>  drivers/pci/controller/pci-host-generic.c | 26 +++++++----------------
>  drivers/pci/controller/pci-thunder-ecam.c | 14 ++++++------
>  drivers/pci/controller/pci-thunder-pem.c  | 16 ++++++--------
>  drivers/pci/controller/pci-xgene.c        |  4 ++--
>  drivers/pci/controller/pcie-tango.c       |  9 +++++---
>  drivers/pci/ecam.c                        | 10 ++++++---
>  drivers/pci/setup-bus.c                   |  1 +
>  include/linux/pci-acpi.h                  |  2 +-
>  include/linux/pci-ecam.h                  | 25 +++++++++++-----------
>  15 files changed, 78 insertions(+), 84 deletions(-)

Applied to pci/host-generic for v5.8, thanks !

Lorenzo
