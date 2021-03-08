Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96CF8330C25
	for <lists+linux-pci@lfdr.de>; Mon,  8 Mar 2021 12:21:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231631AbhCHLUq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 8 Mar 2021 06:20:46 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:37314 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231807AbhCHLUV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 8 Mar 2021 06:20:21 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 128BKA6m034469;
        Mon, 8 Mar 2021 05:20:10 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1615202410;
        bh=X0skZyXiurW0+yZ7uQrkXMAbd3onpmzCMjNgAfTUnDo=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=GG8gDZrRlDziKcYILS44riX7TAOeb4oC8ruOrOXz5TMe6qw5IkjZQhDthtQLm5FZA
         hlK+ExkKwBKm3hMBYSpl+yMgtcQErM0rxuMh2TvVQ49ltKlxIO2/eiFaQhcmv/4FMx
         O1b5h4X1CUOeSRSFI3UK3wg+nYj+uN5hvJWacfnk=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 128BKAL6084081
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 8 Mar 2021 05:20:10 -0600
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 8 Mar
 2021 05:20:09 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 8 Mar 2021 05:20:09 -0600
Received: from [10.250.234.4] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 128BK6UM050767;
        Mon, 8 Mar 2021 05:20:07 -0600
Subject: Re: [PATCHv2 00/15] Update dra7 devicetree files to probe with genpd
To:     Tony Lindgren <tony@atomide.com>, <linux-omap@vger.kernel.org>
CC:     =?UTF-8?Q?Beno=c3=aet_Cousson?= <bcousson@baylibre.com>,
        <devicetree@vger.kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        <linux-pci@vger.kernel.org>
References: <20210126124004.52550-1-tony@atomide.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <09bf6c8c-2a89-82ac-923b-6329759cfcdd@ti.com>
Date:   Mon, 8 Mar 2021 16:50:03 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210126124004.52550-1-tony@atomide.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 26/01/21 6:09 pm, Tony Lindgren wrote:
> Hi all,
> 
> Here's v2 series to update dra7 to probe with ti-sysc and genpd like we've
> already done for am3 and 4.
> 
> These patches are against v5.11-rc1, and depend on the following commits
> in my fixes branch:
> 
> 7078a5ba7a58 ("soc: ti: omap-prm: Fix boot time errors for rst_map_012 bits 0 and 1")
> 2a39af3870e9 ("ARM: OMAP2+: Fix booting for am335x after moving to simple-pm-bus")
> 
> These patches also depend on the series:
> 
> [PATCH 0/3] Few ti-sysc changes for v5.12 merge window
> 
> Please review and test, I've also pushed out a temporary testing branch to
> make testing easier to [0][1].

Looks good to me and didn't observe any issues in my testing.

Tested-by: Kishon Vijay Abraham I <kishon@ti.com>
> 
> Regards,
> 
> Tony
> 
> Changes since v1:
> 
> - Split the series into two parts, looks like most of the emails did not
>   make it to the lists
> 
> - Dropped Balaji from Cc as the email address bounces
> 
> [0] git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap.git tmp-testing-genpd-dra7
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap.git/log/?h=omap-for-v5.12/tmp-testing-genpd-dra7
> 
> Tony Lindgren (15):
>   PCI: pci-dra7xx: Prepare for deferred probe with
>     module_platform_driver
>   ARM: dts: Update pcie ranges for dra7
>   ARM: dts: Configure interconnect target module for dra7 pcie
>   ARM: dts: Properly configure dra7 edma sysconfig registers
>   ARM: dts: Move dra7 l3 noc to a separate node
>   ARM: dts: Configure interconnect target module for dra7 qspi
>   ARM: dts: Configure interconnect target module for dra7 sata
>   ARM: dts: Configure interconnect target module for dra7 mpu
>   ARM: dts: Configure interconnect target module for dra7 dmm
>   ARM: dts: Configure simple-pm-bus for dra7 l4_wkup
>   ARM: dts: Configure simple-pm-bus for dra7 l4_per1
>   ARM: dts: Configure simple-pm-bus for dra7 l4_per2
>   ARM: dts: Configure simple-pm-bus for dra7 l4_per3
>   ARM: dts: Configure simple-pm-bus for dra7 l4_cfg
>   ARM: dts: Configure simple-pm-bus for dra7 l3
> 
>  arch/arm/boot/dts/dra7-l4.dtsi          |  76 ++++++---
>  arch/arm/boot/dts/dra7.dtsi             | 216 ++++++++++++++++--------
>  drivers/pci/controller/dwc/pci-dra7xx.c |  13 +-
>  3 files changed, 213 insertions(+), 92 deletions(-)
> 
