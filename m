Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABBAC2F28CF
	for <lists+linux-pci@lfdr.de>; Tue, 12 Jan 2021 08:17:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391990AbhALHQu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 12 Jan 2021 02:16:50 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:59914 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388456AbhALHQu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 12 Jan 2021 02:16:50 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 10C7Frvf070745;
        Tue, 12 Jan 2021 01:15:53 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1610435753;
        bh=g7AbDhQGdVwNlve6TmM+Kxluc6Uu+tgfQyJ92TiNyP8=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=OK6GuZJYMdDho883EdA795tNm7onaXuFb+9spOKggyEOO3UgpT8UMdMwfi+5o+lmM
         yz1SHeHGFm7YP78sxCVGs4UGC7nSm+OKwz5Cipo8yM2ox2z5td98Id9AO6vdzV1Zx1
         HwlhoosSez+3n+eTG8w4+qnueqrwn2jaKq8wxOVo=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 10C7Frqu113397
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 12 Jan 2021 01:15:53 -0600
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 12
 Jan 2021 01:15:53 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 12 Jan 2021 01:15:53 -0600
Received: from [10.250.235.36] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 10C7FmkX028581;
        Tue, 12 Jan 2021 01:15:49 -0600
Subject: Re: [PATCH v7 0/2] PCI: cadence: Retrain Link to work around Gen2
To:     Nadeem Athani <nadeem@cadence.com>, <tjoseph@cadence.com>,
        <lorenzo.pieralisi@arm.com>, <robh@kernel.org>,
        <bhelgaas@google.com>, <linux-omap@vger.kernel.org>,
        <linux-pci@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <mparab@cadence.com>, <sjakhade@cadence.com>,
        <pthombar@cadence.com>
References: <20201230120515.2348-1-nadeem@cadence.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <15abdca0-d1e1-64b7-4a9a-d7549f035e01@ti.com>
Date:   Tue, 12 Jan 2021 12:45:47 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201230120515.2348-1-nadeem@cadence.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 30/12/20 5:35 pm, Nadeem Athani wrote:
> Cadence controller will not initiate autonomous speed change if strapped
> as Gen2. The Retrain Link bit is set as quirk to enable this speed change.
> Adding a quirk flag for defective IP. In future IP revisions this will not
> be applicable.
> 
> Version history:
> Changes in v7:
> - Changing the commit title of patch 1 in this series.
> - Added a return value for function cdns_pcie_retrain().
> Changes in v6:
> - Move the position of function cdns_pcie_host_wait_for_link to remove
>   compilation error. No changes in code. Separate patch for this.
> Changes in v5:
> - Remove the compatible string based setting of quirk flag.
> - Removed additional Link Up Check
> - Removed quirk from pcie-cadence-plat.c and added in pci-j721e.c
> Changes in v4:
> - Added a quirk flag based on a new compatible string.
> - Change of api for link up: cdns_pcie_host_wait_for_link().
> Changes in v3:
> - To set retrain link bit,checking device capability & link status.
> - 32bit read in place of 8bit.
> - Minor correction in patch comment.
> - Change in variable & macro name.
> Changes in v2:
> - 16bit read in place of 8bit.

Could get GEN2 card enumerated in GEN2 mode in J7ES EVM.

Tested-by: Kishon Vijay Abraham I <kishon@ti.com>

Thanks
Kishon
> 
> Nadeem Athani (2):
>   PCI: cadence: Shifting of a function to support new code.
>   PCI: cadence: Retrain Link to work around Gen2 training defect.
> 
>  drivers/pci/controller/cadence/pci-j721e.c         |  3 +
>  drivers/pci/controller/cadence/pcie-cadence-host.c | 70 ++++++++++++++++------
>  drivers/pci/controller/cadence/pcie-cadence.h      | 11 +++-
>  3 files changed, 65 insertions(+), 19 deletions(-)
> 
