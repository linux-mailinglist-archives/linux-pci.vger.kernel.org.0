Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BA8CAB7862
	for <lists+linux-pci@lfdr.de>; Thu, 19 Sep 2019 13:24:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731086AbfISLYP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 19 Sep 2019 07:24:15 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:15233 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727273AbfISLYP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 19 Sep 2019 07:24:15 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d8365620000>; Thu, 19 Sep 2019 04:24:18 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 19 Sep 2019 04:24:12 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 19 Sep 2019 04:24:12 -0700
Received: from DRHQMAIL107.nvidia.com (10.27.9.16) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 19 Sep
 2019 11:24:12 +0000
Received: from [10.24.45.73] (10.124.1.5) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 19 Sep
 2019 11:24:09 +0000
Subject: Re: [PATCH v2] PCI: dwc: Add support to add GEN3 related equalization
 quirks
To:     Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>,
        Andrew Murray <andrew.murray@arm.com>,
        Pankaj Dubey <pankaj.dubey@samsung.com>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        'Anvesh Salveru' <anvesh.s@samsung.com>
References: <CGME20190913104018epcas5p3d93265a6786dc2b7b8a7d3231bfe9c14@epcas5p3.samsung.com>
 <1568371190-14590-1-git-send-email-pankaj.dubey@samsung.com>
 <20190916101543.GM9720@e119886-lin.cambridge.arm.com>
 <00a401d56c7e$cf3abd30$6db03790$@samsung.com>
 <20190916122400.GO9720@e119886-lin.cambridge.arm.com>
 <DM6PR12MB4010AE07CC6F1CC60A715EE4DA8C0@DM6PR12MB4010.namprd12.prod.outlook.com>
X-Nvconfidentiality: public
From:   Vidya Sagar <vidyas@nvidia.com>
Message-ID: <7ad2b603-49ce-e955-58c4-fba1fb5ca6c8@nvidia.com>
Date:   Thu, 19 Sep 2019 16:54:06 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <DM6PR12MB4010AE07CC6F1CC60A715EE4DA8C0@DM6PR12MB4010.namprd12.prod.outlook.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 DRHQMAIL107.nvidia.com (10.27.9.16)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1568892258; bh=KKun64Wvruq/uh6Fcof0AvKkhxDKGeDzuD2+SaxGsls=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=WClhNZq8cBe8vftClsA3ALgVDz1QjMP6Facr59It4I4byevkBpNOMQXTDpTgyJz8X
         0khn0Ivhs2GbAuZahXZfV9F98iyfPXSrSHQDlUH3SBb5KfYPiUHfLDd4VI6S3RkDyL
         ZjXz/CD0IAloQJxAyOzbmppcQTo5NFSbPkOpHHQzfNWj1Ay5UQ6FHmAJbnYAzovohd
         7j0btXY8kU9SQVWFMcLspw4YzbYecT3JRiNRt3zbyWqMJ4hS5yxLFvJnTszVIQPu0Z
         3Uevr6R9TUGcGhxrw0561B1BbS0HQCjjH4ZIvZa331dASvHVK2TGX2d92bWs/odo3+
         8Goo6cJUKm6fA==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 9/16/2019 6:22 PM, Gustavo Pimentel wrote:
> On Mon, Sep 16, 2019 at 13:24:1, Andrew Murray <andrew.murray@arm.com>
> wrote:
> 
>> On Mon, Sep 16, 2019 at 04:36:33PM +0530, Pankaj Dubey wrote:
>>>
>>>
>>>> -----Original Message-----
>>>> From: Andrew Murray <andrew.murray@arm.com>
>>>> Sent: Monday, September 16, 2019 3:46 PM
>>>> To: Pankaj Dubey <pankaj.dubey@samsung.com>
>>>> Cc: linux-pci@vger.kernel.org; linux-kernel@vger.kernel.org;
>>>> jingoohan1@gmail.com; gustavo.pimentel@synopsys.com;
>>>> lorenzo.pieralisi@arm.com; bhelgaas@google.com; Anvesh Salveru
>>>> <anvesh.s@samsung.com>
>>>> Subject: Re: [PATCH v2] PCI: dwc: Add support to add GEN3 related
>>> equalization
>>>> quirks
>>>>
>>>> On Fri, Sep 13, 2019 at 04:09:50PM +0530, Pankaj Dubey wrote:
>>>>> From: Anvesh Salveru <anvesh.s@samsung.com>
>>>>>
>>>>> In some platforms, PCIe PHY may have issues which will prevent linkup
>>>>> to happen in GEN3 or higher speed. In case equalization fails, link
>>>>> will fallback to GEN1.
>>>>>
>>>>> DesignWare controller gives flexibility to disable GEN3 equalization
>>>>> completely or only phase 2 and 3 of equalization.
>>>>>
>>>>> This patch enables the DesignWare driver to disable the PCIe GEN3
>>>>> equalization by enabling one of the following quirks:
>>>>>   - DWC_EQUALIZATION_DISABLE: To disable GEN3 equalization all phases
I don't think Gen-3 equalization can be skipped altogether.
PCIe Spec Rev 4.0 Ver 1.0 in Section-4.2.3 has the following statement.

"All the Lanes that are associated with the LTSSM
(i.e., those Lanes that are currently operational or may be operational in the future due to Link
Upconfigure) must participate in the Equalization procedure"

and in Section-4.2.6.4.2.1.1 it says
"Note: A transition to Recovery.RcvrLock might be used in the case where the
Downstream Port determines that Phase 2 and Phase 3 are not needed based on the
platform and channel characteristics."

Based on the above statements, I think it is Ok to skip only Phases 2&3 of equalization but not 0&1.
I even checked with our hardware engineers and it seems DWC_EQUALIZATION_DISABLE is present
only for debugging purpose in hardware simulations and shouldn't be used on real silicon otherwise it seems.

- Vidya Sagar


>>>>>   - DWC_EQ_PHASE_2_3_DISABLE: To disable GEN3 equalization phase 2 & 3
>>>>>
>>>>> Platform drivers can set these quirks via "quirk" variable of "dw_pcie"
>>>>> struct.
>>>>>
>>>>> Signed-off-by: Anvesh Salveru <anvesh.s@samsung.com>
>>>>> Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
>>>>> ---
>>>>> Patchset v1 can be found at:
>>>>>   - 1/2: https://urldefense.proofpoint.com/v2/url?u=https-3A__lkml.org_lkml_2019_9_10_443&d=DwIBAg&c=DPL6_X_6JkXFx7AXWqB0tg&r=bkWxpLoW-f-E3EdiDCCa0_h0PicsViasSlvIpzZvPxs&m=MtEKKeJsQvi2UM1eSZUv2vPLLxrYU0aI1Ry4ICIDaiQ&s=s_nPmMNbQFswYRxQgBkeg4H9J_0FEtzRE-0AruC5WI4&e=
>>>>>   - 2/2: https://urldefense.proofpoint.com/v2/url?u=https-3A__lkml.org_lkml_2019_9_10_444&d=DwIBAg&c=DPL6_X_6JkXFx7AXWqB0tg&r=bkWxpLoW-f-E3EdiDCCa0_h0PicsViasSlvIpzZvPxs&m=MtEKKeJsQvi2UM1eSZUv2vPLLxrYU0aI1Ry4ICIDaiQ&s=kkfdwcX6bYcLrnJSgw_GcMMGAjnDTMtN2v6svWuANpk&e=
>>>>>
>>>>> Changes w.r.t v1:
>>>>>   - Squashed two patches from v1 into one as suggested by Gustavo
>>>>>   - Addressed review comments from Andrew
>>>>>
>>>>>   drivers/pci/controller/dwc/pcie-designware.c | 12 ++++++++++++
>>>>> drivers/pci/controller/dwc/pcie-designware.h |  9 +++++++++
>>>>>   2 files changed, 21 insertions(+)
>>>>>
>>>>> diff --git a/drivers/pci/controller/dwc/pcie-designware.c
>>>>> b/drivers/pci/controller/dwc/pcie-designware.c
>>>>> index 7d25102..97fb18d 100644
>>>>> --- a/drivers/pci/controller/dwc/pcie-designware.c
>>>>> +++ b/drivers/pci/controller/dwc/pcie-designware.c
>>>>> @@ -466,4 +466,16 @@ void dw_pcie_setup(struct dw_pcie *pci)
>>>>>   		break;
>>>>>   	}
>>>>>   	dw_pcie_writel_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL, val);
>>>>> +
>>>>> +	if (pci->quirk & DWC_EQUALIZATION_DISABLE) {
>>>>> +		val = dw_pcie_readl_dbi(pci, PCIE_PORT_GEN3_RELATED);
>>>>> +		val |= PORT_LOGIC_GEN3_EQ_DISABLE;
>>>>> +		dw_pcie_writel_dbi(pci, PCIE_PORT_GEN3_RELATED, val);
>>>>> +	}
>>>>> +
>>>>> +	if (pci->quirk & DWC_EQ_PHASE_2_3_DISABLE) {
>>>>> +		val = dw_pcie_readl_dbi(pci, PCIE_PORT_GEN3_RELATED);
>>>>> +		val |= PORT_LOGIC_GEN3_EQ_PHASE_2_3_DISABLE;
>>>>> +		dw_pcie_writel_dbi(pci, PCIE_PORT_GEN3_RELATED, val);
>>>>> +	}
>>>>>   }
>>>>> diff --git a/drivers/pci/controller/dwc/pcie-designware.h
>>>>> b/drivers/pci/controller/dwc/pcie-designware.h
>>>>> index ffed084..e428b62 100644
>>>>> --- a/drivers/pci/controller/dwc/pcie-designware.h
>>>>> +++ b/drivers/pci/controller/dwc/pcie-designware.h
>>>>> @@ -29,6 +29,10 @@
>>>>>   #define LINK_WAIT_MAX_IATU_RETRIES	5
>>>>>   #define LINK_WAIT_IATU			9
>>>>>
>>>>> +/* Parameters for GEN3 related quirks */
>>>>> +#define DWC_EQUALIZATION_DISABLE	BIT(1)
>>>>> +#define DWC_EQ_PHASE_2_3_DISABLE	BIT(2)
>>>>> +
>>>>>   /* Synopsys-specific PCIe configuration registers */
>>>>>   #define PCIE_PORT_LINK_CONTROL		0x710
>>>>>   #define PORT_LINK_MODE_MASK		GENMASK(21, 16)
>>>>> @@ -60,6 +64,10 @@
>>>>>   #define PCIE_MSI_INTR0_MASK		0x82C
>>>>>   #define PCIE_MSI_INTR0_STATUS		0x830
>>>>>
>>>>> +#define PCIE_PORT_GEN3_RELATED		0x890
>>>>
>>>> I hadn't noticed this in the previous version - what is the proper name
>>> for this
>>>> register? Does it end in _RELATED?
>>>
>>> As per SNPS databook the name of the register is "GEN3_RELATED_OFF". It is
>>> port logic register so, to keep similarity with other port logic registers
>>> in this file we named it as "PCIE_PORT_GEN3_RELATED".
>>
>> OK.
>>
>> Reviewed-by: Andrew Murray <andrew.murray@arm.com>
>>
>> Also is the SNPS databook publicly available? I'd be interested in reading
>> it.
> 
> The databook isn't openly available, sorry.
> 
> Gustavo
> 
>>
>> Thanks,
>>
>> Andrew Murray
>>
>>>
>>>>
>>>> Thanks,
>>>>
>>>> Andrew Murray
>>>>
>>>>> +#define PORT_LOGIC_GEN3_EQ_PHASE_2_3_DISABLE	BIT(9)
>>>>> +#define PORT_LOGIC_GEN3_EQ_DISABLE		BIT(16)
>>>>> +
>>>>>   #define PCIE_ATU_VIEWPORT		0x900
>>>>>   #define PCIE_ATU_REGION_INBOUND		BIT(31)
>>>>>   #define PCIE_ATU_REGION_OUTBOUND	0
>>>>> @@ -244,6 +252,7 @@ struct dw_pcie {
>>>>>   	struct dw_pcie_ep	ep;
>>>>>   	const struct dw_pcie_ops *ops;
>>>>>   	unsigned int		version;
>>>>> +	unsigned int		quirk;
>>>>>   };
>>>>>
>>>>>   #define to_dw_pcie_from_pp(port) container_of((port), struct dw_pcie,
>>>>> pp)
>>>>> --
>>>>> 2.7.4
>>>>>
>>>
> 
> 

