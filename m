Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8FCF1186EC7
	for <lists+linux-pci@lfdr.de>; Mon, 16 Mar 2020 16:40:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731563AbgCPPkb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 16 Mar 2020 11:40:31 -0400
Received: from foss.arm.com ([217.140.110.172]:50870 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731554AbgCPPkb (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 16 Mar 2020 11:40:31 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9EA1E1FB;
        Mon, 16 Mar 2020 08:40:30 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6AC763F534;
        Mon, 16 Mar 2020 08:40:29 -0700 (PDT)
Date:   Mon, 16 Mar 2020 15:40:23 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Murali Karicheri <m-karicheri2@ti.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Xiaowei Bao <xiaowei.bao@nxp.com>
Subject: Re: [PATCH v2 0/3] PCIe: Endpoint: Redesign MSI-X support
Message-ID: <20200316154023.GA8550@e121166-lin.cambridge.arm.com>
References: <20200225081703.8857-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200225081703.8857-1-kishon@ti.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Feb 25, 2020 at 01:47:00PM +0530, Kishon Vijay Abraham I wrote:
> Existing MSI-X support in Endpoint core has limitations:
>  1) MSIX table (which is mapped to a BAR) is not allocated by
>     anyone. Ideally this should be allocated by endpoint
>     function driver.
>  2) Endpoint controller can choose any random BARs for MSIX
>     table (irrespective of whether the endpoint function driver
>     has allocated memory for it or not)
> 
> In order to avoid these limitations, pci_epc_set_msix() is
> modified to include BAR Indicator register (BIR) configuration
> and MSIX table offset as arguments. This series also fixed MSIX
> support in dwc driver and add MSI-X support in Cadence PCIe driver.
> 
> Changes from v1:
> *) Removed Cadence MSI-X support from the series
> *) Fixed nits pointed out by Bjorn
> 
> Kishon Vijay Abraham I (3):
>   PCI: endpoint: Fix ->set_msix() to take BIR and offset as arguments
>   PCI: dwc: Fix dw_pcie_ep_raise_msix_irq() to get correct MSI-X table
>     address
>   PCI: keystone: Allow AM654 PCIe Endpoint to raise MSI-X interrupt
> 
>  drivers/pci/controller/dwc/pci-keystone.c     |  5 +-
>  .../pci/controller/dwc/pcie-designware-ep.c   | 61 +++++++++----------
>  drivers/pci/controller/dwc/pcie-designware.h  |  1 +
>  drivers/pci/endpoint/functions/pci-epf-test.c | 31 ++++++++--
>  drivers/pci/endpoint/pci-epc-core.c           |  7 ++-
>  drivers/pci/endpoint/pci-epf-core.c           |  2 +
>  include/linux/pci-epc.h                       |  6 +-
>  include/linux/pci-epf.h                       | 15 +++++
>  8 files changed, 86 insertions(+), 42 deletions(-)

I have applied it to pci/endpoint for v5.7, thanks.

Lorenzo
