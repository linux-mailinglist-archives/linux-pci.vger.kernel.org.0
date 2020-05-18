Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A24C51D766B
	for <lists+linux-pci@lfdr.de>; Mon, 18 May 2020 13:14:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726907AbgERLOb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 18 May 2020 07:14:31 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:52658 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726895AbgERLOb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 18 May 2020 07:14:31 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 04IBEFVH058603;
        Mon, 18 May 2020 06:14:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1589800455;
        bh=E7fcJxnUqqFrAQDBSAN/iBT0XuTjX3npLA0yWrc9VYA=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=mtgETvu6xqx3g7gfJLdVqm1+VQxFSci/CZr7ghnLfM5jbF57diyHocidjdlY0XpDs
         ageZWmXJBKi/pV9jV4RAXbZFMSy3wisTEkU8lHZ+J0GveB/JosKnSo7yGqQESvylEO
         9J79gg99a+NMw+xDCkX5cK43m33pBBulP942fNtI=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 04IBEF6l123119
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 18 May 2020 06:14:15 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 18
 May 2020 06:14:14 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 18 May 2020 06:14:14 -0500
Received: from [10.250.233.85] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 04IBEBg0114342;
        Mon, 18 May 2020 06:14:11 -0500
Subject: Re: [PATCH v4 00/14] Add PCIe support to TI's J721E SoC
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Arnd Bergmann <arnd@arndb.de>, Tom Joseph <tjoseph@cadence.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-omap@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20200506151429.12255-1-kishon@ti.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <35f10b75-8235-7ea2-866f-dfb81fc8e485@ti.com>
Date:   Mon, 18 May 2020 16:44:10 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200506151429.12255-1-kishon@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Lorenzo, RobH

On 5/6/2020 8:44 PM, Kishon Vijay Abraham I wrote:
> TI's J721E SoC uses Cadence PCIe core to implement both RC mode
> and EP mode.
> 
> The high level features are:
>   *) Supports Legacy, MSI and MSI-X interrupt
>   *) Supports upto GEN4 speed mode
>   *) Supports SR-IOV
>   *) Supports multiple physical function
>   *) Ability to route all transactions via SMMU
> 
> This patch series
>   *) Add support in Cadence PCIe core to be used for TI's J721E SoC
>   *) Add a driver for J721E PCIe wrapper

Do you have any other comments on this series? I'm hoping this gets merged for 5.8.

Thanks
Kishon

> 
> v1 of the series can be found @ [1]
> v2 of the series can be found @ [2]
> v3 of the series can be found @ [5]
> 
> Changes from v3:
> 1) Changed the order of files in MAINTAINTERS file to fix Joe's comments
> 2) Fixed indentation and added Reviewed-by: Rob Herring <robh@kernel.org>
> 3) Cleaned up computing msix_tbl
> 4) Fixed RobH's comment on J721E driver
> 
> Changes from v2:
> 1) Converting Cadence binding to YAML schema was done as a 
>    separate series [3] & [4]. [3] is merged and [4] is
>    pending.
> 2) Included MSI-X support in this series
> 3) Added link down interrupt handling (only error message)
> 4) Rebased to latest 5.7-rc1
> 5) Adapted TI J721E binding to [3] & [4] 
> 
> Changes from v1:
> 1) Added DT schemas cdns-pcie-host.yaml, cdns-pcie-ep.yaml and
>    cdns-pcie.yaml for Cadence PCIe core and included it in
>    TI's PCIe DT schema.
> 2) Added cpu_addr_fixup() for Cadence Platform driver.
> 3) Fixed subject/description/renamed functions as commented by
>    Andrew Murray.
> 
> [1] -> http://lore.kernel.org/r/20191209092147.22901-1-kishon@ti.com
> [2] -> http://lore.kernel.org/r/20200106102058.19183-1-kishon@ti.com
> [3] -> http://lore.kernel.org/r/20200305103017.16706-1-kishon@ti.com
> [4] -> http://lore.kernel.org/r/20200417114322.31111-1-kishon@ti.com
> [5] -> http://lore.kernel.org/r/20200417125753.13021-1-kishon@ti.com
> 
> Alan Douglas (1):
>   PCI: cadence: Add MSI-X support to Endpoint driver
> 
> Kishon Vijay Abraham I (13):
>   PCI: cadence: Fix cdns_pcie_{host|ep}_setup() error path
>   linux/kernel.h: Add PTR_ALIGN_DOWN macro
>   PCI: cadence: Add support to use custom read and write accessors
>   PCI: cadence: Add support to start link and verify link status
>   PCI: cadence: Add read/write accessors to perform only 32-bit accesses
>   PCI: cadence: Allow pci_host_bridge to have custom pci_ops
>   PCI: cadence: Add new *ops* for CPU addr fixup
>   PCI: cadence: Fix updating Vendor ID and Subsystem Vendor ID register
>   dt-bindings: PCI: Add host mode dt-bindings for TI's J721E SoC
>   dt-bindings: PCI: Add EP mode dt-bindings for TI's J721E SoC
>   PCI: j721e: Add TI J721E PCIe driver
>   misc: pci_endpoint_test: Add J721E in pci_device_id table
>   MAINTAINERS: Add Kishon Vijay Abraham I for TI J721E SoC PCIe
> 
>  .../bindings/pci/ti,j721e-pci-ep.yaml         |  89 ++++
>  .../bindings/pci/ti,j721e-pci-host.yaml       | 113 ++++
>  MAINTAINERS                                   |   4 +-
>  drivers/misc/pci_endpoint_test.c              |   9 +
>  drivers/pci/controller/cadence/Kconfig        |  23 +
>  drivers/pci/controller/cadence/Makefile       |   1 +
>  drivers/pci/controller/cadence/pci-j721e.c    | 492 ++++++++++++++++++
>  .../pci/controller/cadence/pcie-cadence-ep.c  | 125 ++++-
>  .../controller/cadence/pcie-cadence-host.c    |  59 ++-
>  .../controller/cadence/pcie-cadence-plat.c    |  13 +
>  drivers/pci/controller/cadence/pcie-cadence.c |  48 +-
>  drivers/pci/controller/cadence/pcie-cadence.h | 158 +++++-
>  include/linux/kernel.h                        |   1 +
>  13 files changed, 1093 insertions(+), 42 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/pci/ti,j721e-pci-ep.yaml
>  create mode 100644 Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml
>  create mode 100644 drivers/pci/controller/cadence/pci-j721e.c
> 
