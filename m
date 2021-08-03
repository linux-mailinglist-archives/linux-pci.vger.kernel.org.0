Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0FA53DEB47
	for <lists+linux-pci@lfdr.de>; Tue,  3 Aug 2021 12:53:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235058AbhHCKxK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 3 Aug 2021 06:53:10 -0400
Received: from foss.arm.com ([217.140.110.172]:47210 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234904AbhHCKxK (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 3 Aug 2021 06:53:10 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 078A4106F;
        Tue,  3 Aug 2021 03:52:56 -0700 (PDT)
Received: from lpieralisi (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 703983F40C;
        Tue,  3 Aug 2021 03:52:54 -0700 (PDT)
Date:   Tue, 3 Aug 2021 11:52:52 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tom Joseph <tjoseph@cadence.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, nadeem@cadence.com
Subject: Re: [PATCH v2 0/6] PCI: Add support for J7200 and AM64
Message-ID: <20210803105252.GD11252@lpieralisi>
References: <20210803074932.19820-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210803074932.19820-1-kishon@ti.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Aug 03, 2021 at 01:19:26PM +0530, Kishon Vijay Abraham I wrote:
> This series adds the compatible specific to J7200 and AM64 and
> applies the erratas and configuration specific to them.
> 
> This series also includes Nadeem's patch that adds a quirk in
> Cadence driver which is used by J7200 [1].
> 
> The DT binding for both J7200 and AM64 is already merged.
> 
> v1 of the patch series can be found at [2]
> 
> Changes from v1:
> 1) As suggested by Bjorn, used unsigned int :1, instead of bool for
> structure members
> 2) Removed using unnecessary local variables and also fixed some
> code alignment
> 
> [1] -> https://lore.kernel.org/r/20210528155626.21793-1-nadeem@cadence.com
> [2] -> https://lore.kernel.org/r/20210706105035.9915-1-kishon@ti.com
> 
> Kishon Vijay Abraham I (5):
>   PCI: cadence: Use bitfield for *quirk_retrain_flag* instead of bool
>   PCI: j721e: Add PCIe support for J7200
>   PCI: j721e: Add PCIe support for AM64
>   misc: pci_endpoint_test: Do not request or allocate IRQs in probe
>   misc: pci_endpoint_test: Add deviceID for AM64 and J7200
> 
> Nadeem Athani (1):
>   PCI: cadence: Add quirk flag to set minimum delay in LTSSM
>     Detect.Quiet state
> 
>  drivers/misc/pci_endpoint_test.c              | 27 ++++++--
>  drivers/pci/controller/cadence/pci-j721e.c    | 61 +++++++++++++++++--
>  .../pci/controller/cadence/pcie-cadence-ep.c  |  4 ++
>  .../controller/cadence/pcie-cadence-host.c    |  3 +
>  drivers/pci/controller/cadence/pcie-cadence.c | 17 ++++++
>  drivers/pci/controller/cadence/pcie-cadence.h | 17 +++++-
>  6 files changed, 117 insertions(+), 12 deletions(-)

I am not convinced about patch (5) the rest of the series can be
merged (even though I assume patch (6) depends on (5)).

Please let me know,
Lorenzo
