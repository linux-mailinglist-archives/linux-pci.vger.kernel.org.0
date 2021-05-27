Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32DD7392D11
	for <lists+linux-pci@lfdr.de>; Thu, 27 May 2021 13:49:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234010AbhE0Lup (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 27 May 2021 07:50:45 -0400
Received: from mail-mw2nam10on2041.outbound.protection.outlook.com ([40.107.94.41]:56545
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233270AbhE0Lup (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 27 May 2021 07:50:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ah7uCvV/Ue2W3W2HG+evFfCn4NaBwgm94lGI/aYHg8qOtqYx9RuIRS87lB6ARJ71lutaVwpmnqebzvtwsGBU6cmvAxuUNt9emrU89h73TcSB4bBcNIZUEUJDbxcXcwSQZpLvNYTj//aUfeixnhiWDFvBRluLxha7SRqJoV2nETBba6bK2nmWAxJ1ZyvdS1kVURIjybIvYbmT2rx04xa4/ex7z0ZgWvYhrkq5I6pNOuuEAA2ZMMRhh/3zFqe9pkLlS0CgUEQPxysg2Q2Y1RDugiwfZFxv+ZBZd3YtgtnBVSC7LdfCaJHeUQi1Tk0vbUPNrS+BeP8Sr4EQJwXs0MXSvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Kd1KAruIYJUgQuRyY63bCYKfidisj+NtBR/JkAV6dQ=;
 b=mMTyWPE6n+fC3e7Qnz9eJSMCeZlIcxxN1jZbsRiTEWr0QJo7Xw/Xip/uB0XGakUWbNk32/EjxWEivhuunKSdFD5MMlE/2Qy37Ao5z5G+Nsl9WSNmdI4BNwdGtWe5ohIipIPR5aBiRHH4b81nCuUTCDf9t+lqTsMZwPeRB3OVeDbVE/4wCdB5Y5mRGUHj+qa6a2fBxVfU7Eewc8C64KgrEpkod7RB0p1EoROiYKTMhQVOqpf3iAZLCPT452uiDk/bUf/ZPYSZLnyabc8E4NiuaYey6CL6oLkyqnWKMEjqOXTPCYTeAFfn07ZMEduEeQ2KCpGraFW6/O5Xy0vTz6pdGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Kd1KAruIYJUgQuRyY63bCYKfidisj+NtBR/JkAV6dQ=;
 b=SVRrZTK/4bCq8g7RmWw6XmAfXNyK1EuPLt5ZVIDrwZ+H6CFZJxVgoKsnrxOUkJtG6SN4m++oH6YdZUbwwTGraeu7oHH1kbT7mNG//3yrdNZNfJGa5kjLNartfoVRQWuK3oyekC4VoaWGxwLHrY3aKYJnj/w1tLCZhWc6hO1OxE72wmzJO1cmicwtvDgEoLHSB90HryAKY5j6memFG5JqwJN54PeSubZi+4VzOgmR2DZDI1VUEaZN0psLP2OtWDnw7l50X4+9O8ESvVK1aaYKjyXRXJyYG8hRpXE2zGjtNonrQVGF+fA3ojq//PBPbIu44uDcAI00UO7wYt/9VbKOpg==
Received: from DM6PR02CA0089.namprd02.prod.outlook.com (2603:10b6:5:1f4::30)
 by DM5PR1201MB0092.namprd12.prod.outlook.com (2603:10b6:4:54::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20; Thu, 27 May
 2021 11:49:10 +0000
Received: from DM6NAM11FT024.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1f4:cafe::8f) by DM6PR02CA0089.outlook.office365.com
 (2603:10b6:5:1f4::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20 via Frontend
 Transport; Thu, 27 May 2021 11:49:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 DM6NAM11FT024.mail.protection.outlook.com (10.13.172.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4129.25 via Frontend Transport; Thu, 27 May 2021 11:49:10 +0000
Received: from [10.25.75.220] (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 27 May
 2021 11:49:05 +0000
Subject: Re: [PATCH 1/3] PCI: dwc: Add support for vendor specific capability
 search
To:     =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Shradha Todi <shradha.t@samsung.com>
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <jingoohan1@gmail.com>, <gustavo.pimentel@synopsys.com>,
        <lorenzo.pieralisi@arm.com>, <robh@kernel.org>,
        <bhelgaas@google.com>, <pankaj.dubey@samsung.com>,
        <p.rajanbabu@samsung.com>, <hari.tv@samsung.com>,
        <niyas.ahmed@samsung.com>, <l.mehra@samsung.com>
References: <20210518174618.42089-1-shradha.t@samsung.com>
 <CGME20210518173819epcas5p1ea10c2748b4bb0687184ff04a7a76796@epcas5p1.samsung.com>
 <20210518174618.42089-2-shradha.t@samsung.com>
 <20210521233100.GB79835@rocinante.localdomain>
From:   Vidya Sagar <vidyas@nvidia.com>
Message-ID: <0e6f5671-1d24-c43f-828a-4002562ec4ef@nvidia.com>
Date:   Thu, 27 May 2021 17:19:02 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210521233100.GB79835@rocinante.localdomain>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2976e525-4513-4928-eb17-08d921057102
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0092:
X-Microsoft-Antispam-PRVS: <DM5PR1201MB0092E9FBED930C3C96947900B8239@DM5PR1201MB0092.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0fP9wVSWjpXFUWhDIEBLstisxS9RZp1qKHelnRQToljkbcgGNLr2Xp2T/WE5zeZB525zOkegvL8s4CvyW0npshOSFRcUc6rhr3l6fASbh5zqJGh6SsvhKHWctM2xSXcC3ZX1tyy5fwb26nDRjh6HzbvYMIOa6/9GnXVPslTzjVely1lsuM6jaOXFXpw8tLeIT377a4p0wKi7AYNRPf3Zfi9q2Up0mCbzQugRy5OKT0E4yHKD/8AkdM0mZJE3HtnwWHeLfCWL/ub98TKjHXiyG2I6BHqJRFB5ehVM1xkTmJbfJhWBep1GIgkRTPA/eVkdfN3rEcHZCa9ud+haqUFsaQl6vnSvxNok0sjPikbqU2VCYXQPu/bNKbQA+cXAn+9TY4r27hDBM6uNuGpV8Ypg8MY1kUFLM18/B64kkFUZJ/p757zHD0/Xmy8EyIwD7fTLfDRRXAEN2YDS5KbBoKcshBFZVKJpEZXKg7iyi0TTzmmeaQzm4zJjrdtlIjVDV4X8eoCDIh8Aan3k8ZxP0bmIUJKJ9iL7wDwG8wb84/uHN7i+KJR23YaQMGwN012RY6CZlcX/kSgh2c1c/3DlBv/26hKRsWMmV6vUvZOuM+y0H4TUYYQAf/fF9PeX8r9gDFX7NSOZxeSkEUGuJHzsDEhm2qwN9+pJoT+AsADMCtVVTSZY91dI/gjzhsrGKe+EB6yJ
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(346002)(376002)(136003)(396003)(39860400002)(36840700001)(46966006)(53546011)(2616005)(70206006)(26005)(36906005)(82740400003)(356005)(6666004)(16576012)(70586007)(316002)(31696002)(4326008)(110136005)(8936002)(86362001)(54906003)(8676002)(31686004)(36860700001)(2906002)(36756003)(5660300002)(82310400003)(478600001)(7636003)(7416002)(336012)(16526019)(426003)(186003)(47076005)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2021 11:49:10.3066
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2976e525-4513-4928-eb17-08d921057102
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT024.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0092
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 5/22/2021 5:01 AM, Krzysztof Wilczyński wrote:
> External email: Use caution opening links or attachments
> 
> 
> Hi Shradha,
> 
> [...]
>> +u16 dw_pcie_find_vsec_capability(struct dw_pcie *pci, u8 vsec_cap)
>> +{
>> +     u16 vsec = 0;
>> +     u32 header;
>> +
>> +     while ((vsec = dw_pcie_find_next_ext_capability(pci, vsec,
>> +                                     PCI_EXT_CAP_ID_VNDR))) {
>> +             header = dw_pcie_readl_dbi(pci, vsec + PCI_VNDR_HEADER);
>> +             if (PCI_VNDR_HEADER_ID(header) == vsec_cap)
>> +                     return vsec;
>> +     }
>> +
>> +     return 0;
>> +}
>> +EXPORT_SYMBOL_GPL(dw_pcie_find_vsec_capability);
> 
> A small question as I am curious: why not use pci_find_vsec_capability()
> here?  The implementation looks very similar, which is why I am asking,
> but it might be that I am missing something, and for that I apologise in
> advance.
pci_find_vsec_capability() expects struct pci_dev * which we get only 
after enumeration is done. In the current scenario, we are still in 
pre-link up phase and don't have struct pci_dev * yet, hence this 
implementation, right Shradha??

> 
>          Krzysztof
> 
