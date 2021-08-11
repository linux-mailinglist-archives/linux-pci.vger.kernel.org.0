Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88FE53E9102
	for <lists+linux-pci@lfdr.de>; Wed, 11 Aug 2021 14:29:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232083AbhHKM3v (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 Aug 2021 08:29:51 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:51626 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238574AbhHKM31 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 11 Aug 2021 08:29:27 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 17BCSl05012714;
        Wed, 11 Aug 2021 07:28:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1628684927;
        bh=uFuvcytRDwdpQU2+G4QmfIFOs6apHaJfshNwqIteEi8=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=D5cMvSwDmQAxT+TBVoD3Vwet+VvAkJjidtJQ3OkLJJ3k5tIgMAkQPFsyI8tE2Uwmi
         qh8ebxT6wzMF7Ix2RK18SgJZYRiLknLgO80apKvwYU4UdMohtUw9moGe+YnwdHKYEk
         mhWBfP7IDXyfKjBEDFrMRZch2LZdVuJMnycib/F0=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 17BCSlSF050548
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 11 Aug 2021 07:28:47 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Wed, 11
 Aug 2021 07:27:03 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Wed, 11 Aug 2021 07:27:03 -0500
Received: from [10.250.233.105] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 17BCQwr7076212;
        Wed, 11 Aug 2021 07:26:59 -0500
Subject: Re: [PATCH v2 0/6] PCI: Add support for J7200 and AM64
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC:     Arnd Bergmann <arnd@arndb.de>, Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tom Joseph <tjoseph@cadence.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-omap@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <nadeem@cadence.com>
References: <20210803074932.19820-1-kishon@ti.com>
 <20210803105252.GD11252@lpieralisi>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <ea0c5f77-9034-872b-a25e-d4acc6c0947c@ti.com>
Date:   Wed, 11 Aug 2021 17:56:57 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210803105252.GD11252@lpieralisi>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Lorenzo,

On 03/08/21 4:22 pm, Lorenzo Pieralisi wrote:
> On Tue, Aug 03, 2021 at 01:19:26PM +0530, Kishon Vijay Abraham I wrote:
>> This series adds the compatible specific to J7200 and AM64 and
>> applies the erratas and configuration specific to them.
>>
>> This series also includes Nadeem's patch that adds a quirk in
>> Cadence driver which is used by J7200 [1].
>>
>> The DT binding for both J7200 and AM64 is already merged.
>>
>> v1 of the patch series can be found at [2]
>>
>> Changes from v1:
>> 1) As suggested by Bjorn, used unsigned int :1, instead of bool for
>> structure members
>> 2) Removed using unnecessary local variables and also fixed some
>> code alignment
>>
>> [1] -> https://lore.kernel.org/r/20210528155626.21793-1-nadeem@cadence.com
>> [2] -> https://lore.kernel.org/r/20210706105035.9915-1-kishon@ti.com
>>
>> Kishon Vijay Abraham I (5):
>>   PCI: cadence: Use bitfield for *quirk_retrain_flag* instead of bool
>>   PCI: j721e: Add PCIe support for J7200
>>   PCI: j721e: Add PCIe support for AM64
>>   misc: pci_endpoint_test: Do not request or allocate IRQs in probe
>>   misc: pci_endpoint_test: Add deviceID for AM64 and J7200
>>
>> Nadeem Athani (1):
>>   PCI: cadence: Add quirk flag to set minimum delay in LTSSM
>>     Detect.Quiet state
>>
>>  drivers/misc/pci_endpoint_test.c              | 27 ++++++--
>>  drivers/pci/controller/cadence/pci-j721e.c    | 61 +++++++++++++++++--
>>  .../pci/controller/cadence/pcie-cadence-ep.c  |  4 ++
>>  .../controller/cadence/pcie-cadence-host.c    |  3 +
>>  drivers/pci/controller/cadence/pcie-cadence.c | 17 ++++++
>>  drivers/pci/controller/cadence/pcie-cadence.h | 17 +++++-
>>  6 files changed, 117 insertions(+), 12 deletions(-)
> 
> I am not convinced about patch (5) the rest of the series can be
> merged (even though I assume patch (6) depends on (5)).

I'll drop patch 5, fix your other comments and send a new revision.

Thanks,
Kishon
