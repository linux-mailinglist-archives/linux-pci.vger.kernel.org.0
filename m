Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E27C03F199E
	for <lists+linux-pci@lfdr.de>; Thu, 19 Aug 2021 14:43:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235893AbhHSMny (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 19 Aug 2021 08:43:54 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:44320 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230292AbhHSMny (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 19 Aug 2021 08:43:54 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 17JCh5jQ110007;
        Thu, 19 Aug 2021 07:43:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1629376985;
        bh=lnk1nOB3cbMxiNeGE8FYGgRYRrvd/pm8rx4I/wJc6iA=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=Sen3NAER1XvQgJOPLqcuY31emfCEyUkUVBjy0EgqVB8reDl1mKx5ZBabE1hjQJL7H
         o2PScRrNDyP6WQ3mC4yOBDmNXwQvKxTgfJz21T14fKJMc4lPb0xcnJEkqc2aSBXHcf
         9hfHsc6wzZQWYVwif010sw04m98ESH6/SdzZ3sF0=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 17JCh4NF108445
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 19 Aug 2021 07:43:05 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Thu, 19
 Aug 2021 07:43:04 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Thu, 19 Aug 2021 07:43:04 -0500
Received: from [10.250.233.2] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 17JCh0k9053556;
        Thu, 19 Aug 2021 07:43:01 -0500
Subject: Re: [PATCH v3 0/5] PCI: Add support for J7200 and AM64
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Arnd Bergmann <arnd@arndb.de>, Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
CC:     Lokesh Vutla <lokeshvutla@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tom Joseph <tjoseph@cadence.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-omap@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <nadeem@cadence.com>
References: <20210811123336.31357-1-kishon@ti.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <a618e0af-d95f-8e25-5b86-eff7fd14d186@ti.com>
Date:   Thu, 19 Aug 2021 18:12:54 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210811123336.31357-1-kishon@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Lorenzo,

On 11/08/21 6:03 pm, Kishon Vijay Abraham I wrote:
> This series adds the compatible specific to J7200 and AM64 and
> applies the erratas and configuration specific to them.
> 
> This series also includes Nadeem's patch that adds a quirk in
> Cadence driver which is used by J7200 [1].
> 
> The DT binding for both J7200 and AM64 is already merged.
> 
> v1 of the patch series can be found at [2]
> v2 of the patch series can be found at [3]

Gentle ping on this series.

I've dropped "misc: pci_endpoint_test: Do not request or allocate IRQs
in probe" [A] from the previous version of the series which you had
concerns with.

[A] -> http://lore.kernel.org/r/02c1ddb7-539e-20a0-1bef-e10e76922a0e@ti.com

Thanks
Kishon

> 
> Changes from v2:
> 1) Drop the patch that does not request or allocate IRQs in probe for
> J721E/AM654
> 2) Fix other minor comments given by Lorenzo
> 
> Changes from v1:
> 1) As suggested by Bjorn, used unsigned int :1, instead of bool for
> structure members
> 2) Removed using unnecessary local variables and also fixed some
> code alignment
> 
> [1] -> https://lore.kernel.org/r/20210528155626.21793-1-nadeem@cadence.com
> [2] -> https://lore.kernel.org/r/20210706105035.9915-1-kishon@ti.com
> [3] -> https://lore.kernel.org/r/20210803074932.19820-1-kishon@ti.com
> 
> Kishon Vijay Abraham I (4):
>   PCI: cadence: Use bitfield for *quirk_retrain_flag* instead of bool
>   PCI: j721e: Add PCIe support for J7200
>   PCI: j721e: Add PCIe support for AM64
>   misc: pci_endpoint_test: Add deviceID for AM64 and J7200
> 
> Nadeem Athani (1):
>   PCI: cadence: Add quirk flag to set minimum delay in LTSSM
>     Detect.Quiet state
> 
>  drivers/misc/pci_endpoint_test.c              |  8 +++
>  drivers/pci/controller/cadence/pci-j721e.c    | 61 +++++++++++++++++--
>  .../pci/controller/cadence/pcie-cadence-ep.c  |  4 ++
>  .../controller/cadence/pcie-cadence-host.c    |  3 +
>  drivers/pci/controller/cadence/pcie-cadence.c | 16 +++++
>  drivers/pci/controller/cadence/pcie-cadence.h | 17 +++++-
>  6 files changed, 103 insertions(+), 6 deletions(-)
> 
