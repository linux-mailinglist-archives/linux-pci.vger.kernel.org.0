Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49300483EAB
	for <lists+linux-pci@lfdr.de>; Tue,  4 Jan 2022 10:02:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229768AbiADJCi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 4 Jan 2022 04:02:38 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:51434 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229763AbiADJCh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 4 Jan 2022 04:02:37 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 20492TJ8085537;
        Tue, 4 Jan 2022 03:02:29 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1641286949;
        bh=SSFKI9jF+2pXTo1KdebT/jchgYGF9m9VboCPAUuM6Y0=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=J1CzwysLDa6BM/o2zgCXWqJ4QoBpI+kXglDUrRDdnj19+E1noTpoxrdo9ubaAWHCT
         H+r7yPklxqsQ0x55jpdNYUbMgHmDuCYAz6mrhzaSs+fC7w7RFD3F99jKSRiMpSNXU/
         dpLWI77XETpyKs+qAtFO2Q3kSFGrB82uKClraz7Q=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 20492T5R027477
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 4 Jan 2022 03:02:29 -0600
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Tue, 4
 Jan 2022 03:02:28 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Tue, 4 Jan 2022 03:02:28 -0600
Received: from [10.24.69.159] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 20492QI0109434;
        Tue, 4 Jan 2022 03:02:26 -0600
Subject: Re: [PATCH v2 0/5] PCI: Keystone: Misc fixes for TI's AM65x PCIe
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, Rob Herring <robh@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>
References: <20211126083119.16570-1-kishon@ti.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <20979d61-87a3-f9c5-8185-f8032431367d@ti.com>
Date:   Tue, 4 Jan 2022 14:32:25 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211126083119.16570-1-kishon@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Lorenzo,

On 26/11/21 2:01 pm, Kishon Vijay Abraham I wrote:
> Patch series includes miscellaneous fixes for TI's AM65x SoC
> "PCI: keystone: Add workaround for Errata #i2037 (AM65x SR 1.0)"  has
> already been sent before [1]
> 
> The other patch is to prevent PCIEPORTBUS driver to write to
> MSI-X table (which is not mapped) leading to ~10sec delay
> due to msix_mask_all().
> 
> v1 if the patch series is @ [2]
> 
> Changes from v1:
> 1) Added two patches to fix 'dtbs_check'; a DT binding documentation
> update and a driver update.
> 2) Remove falling back to smaller DMA mask as suggested by Christoph.
> 
> [1] -> https://lore.kernel.org/r/20210325090026.8843-7-kishon@ti.com
> [2] -> https://lore.kernel.org/r/20211110073343.12396-1-kishon@ti.com
> 
> Kishon Vijay Abraham I (5):
>   dt-bindings: PCI: ti,am65: Fix
>     "ti,syscon-pcie-id"/"ti,syscon-pcie-mode" to take argument
>   PCI: keystone: Use phandle argument from
>     "ti,syscon-pcie-id"/"ti,syscon-pcie-mode"
>   PCI: keystone: Add workaround for Errata #i2037 (AM65x SR 1.0)
>   PCI: keystone: Add quirk to mark AM654 RC BAR flag as IORESOURCE_UNSET
>   PCI: keystone: Set DMA mask and coherent DMA mask
> 
>  .../bindings/pci/ti,am65-pci-ep.yaml          |  8 +-
>  .../bindings/pci/ti,am65-pci-host.yaml        | 16 +++-
>  drivers/pci/controller/dwc/pci-keystone.c     | 82 ++++++++++++++++++-
>  3 files changed, 96 insertions(+), 10 deletions(-)

Can this be merged?

Regards,
Kishon
