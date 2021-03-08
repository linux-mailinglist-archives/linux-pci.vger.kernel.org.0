Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D45FF330B81
	for <lists+linux-pci@lfdr.de>; Mon,  8 Mar 2021 11:43:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231286AbhCHKnY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 8 Mar 2021 05:43:24 -0500
Received: from mail-bn8nam11on2050.outbound.protection.outlook.com ([40.107.236.50]:36065
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230519AbhCHKnK (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 8 Mar 2021 05:43:10 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=atASTpSUWf/WCNeTyOgUWuqz+MIV/RpDfmrVUf3WoAnzjnTlGFXo2kjkIYbCx8HEqSyL3e6dvHPB/q7SkF9HcA7dCocf/RdQvbhEqxyEZEiKcve4sRKW+S+4fGasVbO5l0DdKSx3Tj0lymgK3chvxWId8BKL0lcUnS6OwPKaxMUIKcaFLQ1sLqNkyJiaWxB4Yr2h5fhlzjFgjTX5hFWJaGbGKQZPgsnlnsiXFVsQVWfxRDkwfeF+Y8LATbXxGIZUkUf5wjwhZ21SI9KU/RjKcpzcn85i7bj9F0XcQo6OqRtwBZynpg3bkTXtbKA2nnP2HPWvBln/TRnUu1tbJoNXAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HRrTQHfu0ZFRc/pYjqZvOmvTsKN1s6Lu9adk08Srijw=;
 b=DQNZToqV6V9H9Etj/Tb/flgkufBg46FgEq8KE8JDtT32OWe4D9HXUXFbF58VsYEug9KfmvZCXv+IpCkd3AaCVqs6Az6j300kubcmmf2KfBEghiMO+ZzSWXLrJJedFUDPlxCKM7zsrFs6Yv34/RwicFsaKP1EAzua+FQF09FHWvGiwOWAKkaezQYJ8fBRuzgcfCH9dSf9FL3aEjH77kdNmHNZ6C2cCYcs6r1YH9XBGe0DKLFjVXQydkIfdlwJFQhjVXhKWtr99v7liDoSvkLYwB4C8KfIN5HagXLduhpJGj4mZfUaBvMAOl0Tk8rsJeF4/WRHWcOea6RLHUN1zruTPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=arm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HRrTQHfu0ZFRc/pYjqZvOmvTsKN1s6Lu9adk08Srijw=;
 b=lYUC1QI3jtM+4i4AEMoy/wFzGxCS6LDXCofDbdiB7dDl1054ad5vbiFSP9JYh3MPv9aynk6aLlM6X/qr7rID66HbOvkKt8vAom4UhPIJFanPchvBX0j+0OJ30ce259XfbJKp48sEgvDvboDkJTK0Bfva1krOMXygut5NGyec4/8=
Received: from MW4PR04CA0331.namprd04.prod.outlook.com (2603:10b6:303:8a::6)
 by DM6PR12MB2716.namprd12.prod.outlook.com (2603:10b6:5:49::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19; Mon, 8 Mar
 2021 10:43:05 +0000
Received: from CO1NAM11FT060.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8a:cafe::65) by MW4PR04CA0331.outlook.office365.com
 (2603:10b6:303:8a::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend
 Transport; Mon, 8 Mar 2021 10:43:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 CO1NAM11FT060.mail.protection.outlook.com (10.13.175.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.3890.19 via Frontend Transport; Mon, 8 Mar 2021 10:43:04 +0000
Received: from [10.25.79.200] (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 8 Mar
 2021 10:42:59 +0000
Subject: Re: [PATCH] PCI: tegra: Disable PTM capabilities for EP mode
To:     Vidya Sagar <vidyas@nvidia.com>, Bjorn Helgaas <helgaas@kernel.org>
CC:     <jingoohan1@gmail.com>, <gustavo.pimentel@synopsys.com>,
        <lorenzo.pieralisi@arm.com>, <amurray@thegoodpenguin.co.uk>,
        <bhelgaas@google.com>, <kishon@ti.com>, <thierry.reding@gmail.com>,
        <Jisheng.Zhang@synaptics.com>, <jonathanh@nvidia.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kthota@nvidia.com>, <mmaddireddy@nvidia.com>,
        <oop.singh@gmail.com>
References: <20210305121934.GA1067436@bjorn-Precision-5520>
 <81c84df2-e52b-7713-5026-c3e0a27376bd@nvidia.com>
From:   Om Prakash Singh <omp@nvidia.com>
Message-ID: <26834aba-4d45-6da4-0548-1fb61e684b59@nvidia.com>
Date:   Mon, 8 Mar 2021 16:12:55 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <81c84df2-e52b-7713-5026-c3e0a27376bd@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3d21c63a-3b01-46ad-a457-08d8e21ef466
X-MS-TrafficTypeDiagnostic: DM6PR12MB2716:
X-Microsoft-Antispam-PRVS: <DM6PR12MB2716DE2B0AD2A3FA8B82B8E2DA939@DM6PR12MB2716.namprd12.prod.outlook.com>
X-MS-Exchange-Transport-Forked: True
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YB6v1jXGTgGiKe6LwXa5m1pJnmb4axyntCsLy/1+SO6aJWLyXXFl6bEqi/D1uqo34T8wkInM1tO+xZ+FoEl1RTc3BF5jMb9UHU7fN/37EmiFKCpPXTu6f1xaxYUaedavss4RsB+9Ri4TcljhjkOSZXsumZOyohov0AK7NylnEfcfqdgOEw3NK4bVNgSauvTZrSLqXPJ8ZZfC+87FffNHbZ09CmoMa8MiI45uCbfCbo2udAX9iVKhGhhEM04jE+fxUvzSDNE6bg8CkTEIwTK+qorLvF/tZTUHauHQEQOOljz/MgnnoZ42/v0cc+bfoygdUEc6GXODqXqSOOIzcm3SEbVRn844G/gsZ2RyPSWJAnz5Zz91rZJc4vPuDogXTW69jfJZh4fCUwFbSMgCdmrFv5rxtjI1swF6wBXH2/YMOZvZesPkE66mN1bbXsdLjKO+u/7AeL+OWCOBoxBDYrfINg9mC+OmBWErNVZ9SwhQO5TyZ0SPSDRpcLDi4cRD1KaSFoQExC8vmIHDsP0eweHTyHqJ6KM2Q0CVSLikuJG4eWV7npR+Tx3jU4/OavvpwGxzPJUzEzisCTzPwywSSDZfsR0faNV/uIf/VgJCerRubIiL0yKvq3BB1vAn4xDydAfibVllPEI5m59h+WknmEoFro7BrD0HtdnOPkgGi8cdA/dTkGmlrrpjgQ44FxcOXwHAIKLkOuXcIklV+U4Rl5CZ0g==
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(376002)(39860400002)(136003)(346002)(396003)(46966006)(36840700001)(2616005)(36756003)(2906002)(36860700001)(31686004)(5660300002)(426003)(8676002)(53546011)(356005)(16576012)(336012)(7416002)(47076005)(8936002)(31696002)(70586007)(54906003)(316002)(6666004)(86362001)(26005)(82310400003)(34020700004)(186003)(83380400001)(7636003)(4326008)(16526019)(70206006)(82740400003)(36906005)(478600001)(110136005)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2021 10:43:04.9149
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d21c63a-3b01-46ad-a457-08d8e21ef466
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT060.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2716
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 3/5/2021 11:43 PM, Vidya Sagar wrote:
> 
> 
> On 3/5/2021 5:49 PM, Bjorn Helgaas wrote:
>> External email: Use caution opening links or attachments
>>
>>
>> On Fri, Mar 05, 2021 at 01:42:34PM +0530, Om Prakash Singh wrote:
>>> PCIe EP compliance expect PTM capabilities (ROOT_CAPABLE, RES_CAPABLE,
>>> CLK_GRAN) to be disabled.
>>
>> I guess this is just enforcing the PCIe spec requirements that only
>> Root Ports, RCRBs, and Switches are allowed to set the PTM Responder
>> Capable bit, and that the Local Clock Granularity is RsvdP if PTM Root
>> Capable is zero?  (PCIe r5.0, sec 7.9.16.2)
>>
>> Should this be done more generally somewhere in the dwc code as
>> opposed to in the tegra code?
> Agree.
>
I'll take care of this in next patch version
 
>>
>>> Signed-off-by: Om Prakash Singh <omp@nvidia.com>
>>> ---
>>>   drivers/pci/controller/dwc/pcie-tegra194.c | 17 ++++++++++++++++-
>>>   include/uapi/linux/pci_regs.h              |  1 +
>>>   2 files changed, 17 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
>>> index 6fa216e..a588312 100644
>>> --- a/drivers/pci/controller/dwc/pcie-tegra194.c
>>> +++ b/drivers/pci/controller/dwc/pcie-tegra194.c
>>> @@ -1639,7 +1639,7 @@ static void pex_ep_event_pex_rst_deassert(struct tegra_pcie_dw *pcie)
>>>        struct dw_pcie *pci = &pcie->pci;
>>>        struct dw_pcie_ep *ep = &pci->ep;
>>>        struct device *dev = pcie->dev;
>>> -     u32 val;
>>> +     u32 val, ptm_cap_base = 0;
>>
>> Unnecessary init.
>>
>>>        int ret;
>>>
>>>        if (pcie->ep_state == EP_STATE_ENABLED)
>>> @@ -1760,6 +1760,21 @@ static void pex_ep_event_pex_rst_deassert(struct tegra_pcie_dw *pcie)
>>>                                                      PCI_CAP_ID_EXP);
>>>        clk_set_rate(pcie->core_clk, GEN4_CORE_CLK_FREQ);
>>>
>>> +     /* Disable PTM root and responder capability */
>>> +     ptm_cap_base = dw_pcie_find_ext_capability(&pcie->pci,
>>> +                                                PCI_EXT_CAP_ID_PTM);
>>> +     if (ptm_cap_base) {
>>> +             dw_pcie_dbi_ro_wr_en(pci);
>>> +             val = dw_pcie_readl_dbi(pci, ptm_cap_base + PCI_PTM_CAP);
>>> +             val &= ~PCI_PTM_CAP_ROOT;
>>> +             dw_pcie_writel_dbi(pci, ptm_cap_base + PCI_PTM_CAP, val);
>>> +
>>> +             val = dw_pcie_readl_dbi(pci, ptm_cap_base + PCI_PTM_CAP);
>>> +             val &= ~(PCI_PTM_CAP_RES | PCI_PTM_GRANULARITY_MASK);
> Why can't this be clubbed with "val &= ~PCI_PTM_CAP_ROOT;" ?
>
This cannot be clubbed as PTM root capability needs to disable first before disabling responded capability 
 
>>> +             dw_pcie_writel_dbi(pci, ptm_cap_base + PCI_PTM_CAP, val);
>>> +             dw_pcie_dbi_ro_wr_dis(pci);
>>> +     }
>>> +
>>>        val = (ep->msi_mem_phys & MSIX_ADDR_MATCH_LOW_OFF_MASK);
>>>        val |= MSIX_ADDR_MATCH_LOW_OFF_EN;
>>>        dw_pcie_writel_dbi(pci, MSIX_ADDR_MATCH_LOW_OFF, val);
>>> diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
>>> index e709ae8..9dd6f8d 100644
>>> --- a/include/uapi/linux/pci_regs.h
>>> +++ b/include/uapi/linux/pci_regs.h
>>> @@ -1050,6 +1050,7 @@
>>>   /* Precision Time Measurement */
>>>   #define PCI_PTM_CAP                  0x04        /* PTM Capability */
>>>   #define  PCI_PTM_CAP_REQ             0x00000001  /* Requester capable */
>>> +#define  PCI_PTM_CAP_RES             0x00000002  /* Responder capable */
>>>   #define  PCI_PTM_CAP_ROOT            0x00000004  /* Root capable */
>>>   #define  PCI_PTM_GRANULARITY_MASK    0x0000FF00  /* Clock granularity */
>>>   #define PCI_PTM_CTRL                 0x08        /* PTM Control */
>>> -- 
>>> 2.7.4
>>>

