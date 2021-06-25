Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FE2C3B41EC
	for <lists+linux-pci@lfdr.de>; Fri, 25 Jun 2021 12:49:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231501AbhFYKv0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 25 Jun 2021 06:51:26 -0400
Received: from mail-bn8nam12on2067.outbound.protection.outlook.com ([40.107.237.67]:20942
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231235AbhFYKvZ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 25 Jun 2021 06:51:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HMVmNZi3V+bJNq4mgmVd8eQX/E16B8aLD4JziE6wxORa/bK4UjRcx4cv1i6Yjn6GRUjNPpv5dATTe4cGgxzAVtepCaedWfMc0A3TuK12jsm4c5rITtIGobkMqqEM9JzktjhvM7l9G4kbXiaTTjvYV8NJ80k509/ioMtsyRhr6tkU29Z3DrmsVFifacaXNPjS1lNfrhNZunnzjxyS6af4QcImOef6b1YNAqD8yr9udbn8LBPuS+vEagG/C0l2TVLeMX5eKOqJC9ETalPaO+yyQ2vqIRbx4rN3OvIy5+cJglNkFIR01bykLt+5EqFVVstTA9VhT4qSjeO4QXDXTeRwow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Esf1KAlMdBGuh/VdIa/6hNVZGDIOSM+AImvAX1GcZwo=;
 b=KdPGwyMDb7ueaLUb/AegatdDhbASta4YJyIDAyDj/+6W2pP1rFr9LH0W+ZnpynpJDsAbcrqx+2y/ymn0+Pa+NKMgJuemw5fA8vFJM/ocGlSFCc8PB6wQJ8wtJlocsHWKAnKg1ERkh77SsI8lQlPVt5ebkV6cwxJuM9GvCJeXNF5tLIjSj98+zNVB6WiW9N7zmek2//wVR305wyjIe4Yz0uxkSZvwNvzyq737cQugUzSpLDyGQJtvKi6NZD5a4zxU32gR+l2etmcWMxE6sOucosdRqFNOmDQbiBrESwCy7ByPC8OE9dHAJRvoY+k3ZQzFP6u+hud3QUtCmKDMtI3XoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Esf1KAlMdBGuh/VdIa/6hNVZGDIOSM+AImvAX1GcZwo=;
 b=Aktp6SVKhzh7fBT+JXNH6Nin0K0hzwcJaORpqTIy2ideiO8VJTxr73V2HQLbafZ/Hr7IEOyK0dHI6U8NSvmtDLkt6sAt70gTkFUG1LX80TN9VhCTYoWJN7JasihVOxTNBNfTji0Q4ykxApdcUTFdAEuNzTYoMP3zWwUIKuO2h5E=
Received: from DM5PR21CA0032.namprd21.prod.outlook.com (2603:10b6:3:ed::18) by
 CH2PR02MB6294.namprd02.prod.outlook.com (2603:10b6:610:e::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4264.20; Fri, 25 Jun 2021 10:49:02 +0000
Received: from DM3NAM02FT057.eop-nam02.prod.protection.outlook.com
 (2603:10b6:3:ed:cafe::6) by DM5PR21CA0032.outlook.office365.com
 (2603:10b6:3:ed::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.3 via Frontend
 Transport; Fri, 25 Jun 2021 10:49:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 DM3NAM02FT057.mail.protection.outlook.com (10.13.5.64) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4264.18 via Frontend Transport; Fri, 25 Jun 2021 10:49:02 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 25 Jun 2021 03:49:01 -0700
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Fri, 25 Jun 2021 03:49:01 -0700
Envelope-to: git@xilinx.com,
 linux-pci@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 sashal@kernel.org,
 robh@kernel.org,
 maz@kernel.org,
 lorenzo.pieralisi@arm.com,
 bhelgaas@google.com,
 monstr@monstr.eu,
 linux-kernel@vger.kernel.org,
 kw@linux.com
Received: from [172.30.17.109] (port=45432)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <michal.simek@xilinx.com>)
        id 1lwjOO-0001vG-01; Fri, 25 Jun 2021 03:49:00 -0700
Subject: Re: [PATCH v2 2/2] PCI: xilinx-nwl: Enable the clock through CCF
To:     =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Michal Simek <michal.simek@xilinx.com>
CC:     <linux-kernel@vger.kernel.org>, <monstr@monstr.eu>,
        <git@xilinx.com>, <bharat.kumar.gogada@xilinx.com>,
        Hyun Kwon <hyun.kwon@xilinx.com>,
        "Bjorn Helgaas" <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Ravi Kiran Gummaluri <rgummal@xilinx.com>,
        "Rob Herring" <robh@kernel.org>, Sasha Levin <sashal@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-pci@vger.kernel.org>
References: <cover.1624454607.git.michal.simek@xilinx.com>
 <be603822953d0a815034a952b9c71bac642f22ae.1624454607.git.michal.simek@xilinx.com>
 <20210623135326.GA54420@rocinante>
 <f15a9fca-0fb0-5f7a-e1c7-6c52df617a2e@xilinx.com>
 <20210623141920.GB54420@rocinante>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <166b9626-cc4d-ff28-74bc-3e0f455c67e8@xilinx.com>
Date:   Fri, 25 Jun 2021 12:48:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210623141920.GB54420@rocinante>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3f60d55c-28b2-48ff-2526-08d937c6d88f
X-MS-TrafficTypeDiagnostic: CH2PR02MB6294:
X-Microsoft-Antispam-PRVS: <CH2PR02MB629427B79DE66A56129462B6C6069@CH2PR02MB6294.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yNgX0bZ0BuYd2UwoTurLFEvqz02FBtmRZB7NTrFGdTjk1NHorhlFtMsBEPmj8JZ4R0f/YCaeu8QdhqxRx8uev/nbz2APf0qvv/rfyNUcjJNf6q0hpmDp6AX7EtmVdYUe7ZH5NTWAlx/LW4Ajc1bXvX5aE65ZUIdvcqrsGNq0/M/ypAhIe9sgi8kv9XtqY9IL9fjJ2QF4+E3vAh0OgEmu1Me2WWKccjAa1YT4vXP7+6ZAN9kNSdAAojHmWID7CUno7X0vkbman2H9g1hg2jD9qrsMK2SsURGX6R+QlkngFUkk2QDn671zlnN2k+iygXWDZp9LQCkWHq1FLNMr5202rK1pjkaC3yXO1Kzd07SHD38UztPNhyuRFq3DEQdmAPKPCfpJ13oVrlcYRsAR0h0AcNmqBlCrVkuwtGqA0dz3Lbp7dkXdj5Vgu4B8n80QJkL11sbZ6tOFbqZG6TkRHWWWyi8xBm/XGYAYqNxyH8V/GyAdQ7U5wAjvkJfqhNa0ZnDhnXcgpttQDFzVQrEf+GI7Uluo+yYv+8uElFAXfKekw5moKHfqjMeUp7ExiZU5cFpp4K/px3I0sYB5arQpgX4HiXWniUvOrwcainaf3xllxfZ250jMCBt3rb5waYzjytwdjrFelEWE6gz2gOddoTKK3PRbFGfhSa5BFMJwoBGc3+kirbORiicenXIRB+L9ST30Rv/o76H8rHqeSEaZcMruVWBg3miU/0lOea+9E+XWh+/zlrCUdeDvoU/eu/80uJnUwcIg+eQRHE4cHXihj6uXva+RYh61KMS9tDRs8R90VVPHgkXtzLIapmwP7lYTg6YQZoSyIwRq2kQCDmUd8XqHMA==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(39860400002)(376002)(346002)(396003)(136003)(46966006)(36840700001)(70586007)(83380400001)(5660300002)(36756003)(2906002)(966005)(478600001)(82740400003)(8676002)(7636003)(82310400003)(356005)(70206006)(6666004)(44832011)(31686004)(53546011)(8936002)(426003)(54906003)(36906005)(316002)(110136005)(336012)(47076005)(2616005)(9786002)(186003)(26005)(4326008)(7416002)(31696002)(36860700001)(50156003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2021 10:49:02.5048
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f60d55c-28b2-48ff-2526-08d937c6d88f
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3NAM02FT057.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR02MB6294
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On 6/23/21 4:19 PM, Krzysztof Wilczyński wrote:
> Hi Michal,
> 
> [...]
>>> Does it make sense for this change to be back-ported to stable and
>>> long-term kernels?
>>>
>>> I am asking to make sure we do the right thing here, as I can imagine
>>> that older kernels (primarily because some folks could use, for example,
>>> Ubuntu LTS releases for development) might often be used by people who
>>> work with the Xilinx FPGAs and such.
>>
>> I think that make sense to do so. I haven't had a time to take look at
>> it closely but I think on Xilinx ZynqMP zcu102 board this missing patch
>> is causing hang when standard debian 5.10 is used.
> 
> OK.  This definitely would be a good candidate for back-port then - it
> might help quite a few folks to get their device going without this
> troublesome hang you mentioned.
> 
> There are a few options as per:
>   https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
> 
> You can send v3 adding the appropriate tag (see above link or the
> comment below) or once this series (or mainly this patch) reaches Linus'
> tree, then send a message to the stable maintainers mailing list to let
> them know what any why to back-port.
> 
> At this point, I believe that adding the "Cc:" tag which includes the
> "stable@vger.kernel.org" might be the best option as it would involve
> the least amount of work to for Sasha et al.
> 
> What do you think?  Which option would you like to go for?

I have sent v3 with above changes.

Thanks,
Michal
