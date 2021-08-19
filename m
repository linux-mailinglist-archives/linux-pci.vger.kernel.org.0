Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CB873F1AD2
	for <lists+linux-pci@lfdr.de>; Thu, 19 Aug 2021 15:44:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240038AbhHSNpA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 19 Aug 2021 09:45:00 -0400
Received: from foss.arm.com ([217.140.110.172]:38710 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238463AbhHSNo7 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 19 Aug 2021 09:44:59 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CE0F41063;
        Thu, 19 Aug 2021 06:44:22 -0700 (PDT)
Received: from lpieralisi (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3C7F93F70D;
        Thu, 19 Aug 2021 06:44:21 -0700 (PDT)
Date:   Thu, 19 Aug 2021 14:44:18 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tom Joseph <tjoseph@cadence.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, nadeem@cadence.com
Subject: Re: [PATCH v3 0/5] PCI: Add support for J7200 and AM64
Message-ID: <20210819134418.GB26966@lpieralisi>
References: <20210811123336.31357-1-kishon@ti.com>
 <a618e0af-d95f-8e25-5b86-eff7fd14d186@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a618e0af-d95f-8e25-5b86-eff7fd14d186@ti.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Aug 19, 2021 at 06:12:54PM +0530, Kishon Vijay Abraham I wrote:
> Hi Lorenzo,
> 
> On 11/08/21 6:03 pm, Kishon Vijay Abraham I wrote:
> > This series adds the compatible specific to J7200 and AM64 and
> > applies the erratas and configuration specific to them.
> > 
> > This series also includes Nadeem's patch that adds a quirk in
> > Cadence driver which is used by J7200 [1].
> > 
> > The DT binding for both J7200 and AM64 is already merged.
> > 
> > v1 of the patch series can be found at [2]
> > v2 of the patch series can be found at [3]
> 
> Gentle ping on this series.
> 
> I've dropped "misc: pci_endpoint_test: Do not request or allocate IRQs
> in probe" [A] from the previous version of the series which you had
> concerns with.
> 
> [A] -> http://lore.kernel.org/r/02c1ddb7-539e-20a0-1bef-e10e76922a0e@ti.com

Understood. The question is, how did you solve the issue that was
forcing you to have that patch in place in the updated series.

Thanks,
Lorenzo

> 
> Thanks
> Kishon
> 
> > 
> > Changes from v2:
> > 1) Drop the patch that does not request or allocate IRQs in probe for
> > J721E/AM654
> > 2) Fix other minor comments given by Lorenzo
> > 
> > Changes from v1:
> > 1) As suggested by Bjorn, used unsigned int :1, instead of bool for
> > structure members
> > 2) Removed using unnecessary local variables and also fixed some
> > code alignment
> > 
> > [1] -> https://lore.kernel.org/r/20210528155626.21793-1-nadeem@cadence.com
> > [2] -> https://lore.kernel.org/r/20210706105035.9915-1-kishon@ti.com
> > [3] -> https://lore.kernel.org/r/20210803074932.19820-1-kishon@ti.com
> > 
> > Kishon Vijay Abraham I (4):
> >   PCI: cadence: Use bitfield for *quirk_retrain_flag* instead of bool
> >   PCI: j721e: Add PCIe support for J7200
> >   PCI: j721e: Add PCIe support for AM64
> >   misc: pci_endpoint_test: Add deviceID for AM64 and J7200
> > 
> > Nadeem Athani (1):
> >   PCI: cadence: Add quirk flag to set minimum delay in LTSSM
> >     Detect.Quiet state
> > 
> >  drivers/misc/pci_endpoint_test.c              |  8 +++
> >  drivers/pci/controller/cadence/pci-j721e.c    | 61 +++++++++++++++++--
> >  .../pci/controller/cadence/pcie-cadence-ep.c  |  4 ++
> >  .../controller/cadence/pcie-cadence-host.c    |  3 +
> >  drivers/pci/controller/cadence/pcie-cadence.c | 16 +++++
> >  drivers/pci/controller/cadence/pcie-cadence.h | 17 +++++-
> >  6 files changed, 103 insertions(+), 6 deletions(-)
> > 
