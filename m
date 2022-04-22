Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B6FF50C335
	for <lists+linux-pci@lfdr.de>; Sat, 23 Apr 2022 01:10:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231799AbiDVW2m (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 22 Apr 2022 18:28:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234120AbiDVW2Y (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 22 Apr 2022 18:28:24 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2068.outbound.protection.outlook.com [40.107.237.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2062B34515F;
        Fri, 22 Apr 2022 14:57:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wYyuEQEJsXTOLe1TkkCmAIwlKbDLrlznpviKyBQiyh4=;
 b=q6ISGHjgbn+jTyl3gxpjop5RlsNTaep77WeZCQILGKdWO6hQ9kZN7C0bWrh+Zozw+vaHaz3UN/Bi7q5xUfQ7HckbscJkf7ITRQeiRgcHcYXgTC0li6ief0e5j9BQJp36OQ4FMU6MlQJ6N49XmnGtZq2AmHh4akF+Wj+hDhtym8U=
Received: from DS7PR05CA0046.namprd05.prod.outlook.com (2603:10b6:8:2f::14) by
 MN2PR02MB6943.namprd02.prod.outlook.com (2603:10b6:208:205::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.13; Fri, 22 Apr
 2022 21:57:26 +0000
Received: from DM3NAM02FT044.eop-nam02.prod.protection.outlook.com
 (2603:10b6:8:2f:cafe::13) by DS7PR05CA0046.outlook.office365.com
 (2603:10b6:8:2f::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.6 via Frontend
 Transport; Fri, 22 Apr 2022 21:57:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.83.241.18)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 20.83.241.18 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.83.241.18;
 helo=mailrelay000001.14r1f435wfvunndds3vy4cdalc.xx.internal.cloudapp.net;
Received: from
 mailrelay000001.14r1f435wfvunndds3vy4cdalc.xx.internal.cloudapp.net
 (20.83.241.18) by DM3NAM02FT044.mail.protection.outlook.com (10.13.5.98) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14 via Frontend
 Transport; Fri, 22 Apr 2022 21:57:25 +0000
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2106.outbound.protection.outlook.com [104.47.70.106])
        by mailrelay000001.14r1f435wfvunndds3vy4cdalc.xx.internal.cloudapp.net (Postfix) with ESMTPS id DC46A41D3A;
        Fri, 22 Apr 2022 21:57:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f6qWRTXepdClt6Oise5K56RqZGwzgwF1wWbiyXSeTy6Pj25YamzkGzkIcunulpygZPhEgN9KUPbauqCOhu95yYGkHJesqhYcOfAw4DfDPCGMAncP8HH1ZMhMOp223C+Vdr2mRosC0WjfSrH3g4XzlWCdIMnrXa/HJkXHAkkoTZ5hWtOOu42iGjDL16hm0d0JGu3gyvD1mlN5BFFGXQys+nth/nLV/gythEJSWtM7eqLy4ebNLrjPr5RL+vXCs5nYeTtizH6b9XmC7D/1iZINUYfqMMaR8T7WNIPjN94J/8zyw3CcGLxlY33fmgDlHHkXGZCoTDSu3VQm1IUbynzYwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wYyuEQEJsXTOLe1TkkCmAIwlKbDLrlznpviKyBQiyh4=;
 b=dCpsZE5YVN5XNp5CtvwwOna6kFRKVuz4Xn74vt1vfSkw1Aof/6hq2gqMdsIukjvbIGPGwC2TiZoxJW7CsagD5vkfhKcEGHwYMsM2ZETaEZUhgML3PY5iA/d9jADvTtmzfrkw1avCgbURe7Z0l6kDzMnaXPJxXboH/d7cY7l4nGlTtn60zMyQxqBU5ZMmInYsK5sl9WTwRBMLDu9u1nIBUekMTznjZi5Eyl/IzHeyQNa7KRt2Ie/5KsUCi6cHMigO6mYF1w1yOMe5uCobsjl1RbhZkJoTrdwel5WMLkURwspqHSr+7QEOZLRfxn7vxGOPZo1RkqtoVD2/5j85/H5Bow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
Received: from BN0PR08CA0018.namprd08.prod.outlook.com (2603:10b6:408:142::29)
 by DM5PR02MB3701.namprd02.prod.outlook.com (2603:10b6:4:b0::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Fri, 22 Apr
 2022 21:57:21 +0000
Received: from BN1NAM02FT047.eop-nam02.prod.protection.outlook.com
 (2603:10b6:408:142:cafe::83) by BN0PR08CA0018.outlook.office365.com
 (2603:10b6:408:142::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.13 via Frontend
 Transport; Fri, 22 Apr 2022 21:57:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 BN1NAM02FT047.mail.protection.outlook.com (10.13.3.196) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5186.14 via Frontend Transport; Fri, 22 Apr 2022 21:57:21 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Fri, 22 Apr 2022 14:57:16 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Fri, 22 Apr 2022 14:57:16 -0700
Envelope-to: robh@kernel.org,
 trix@redhat.com,
 linux-pci@vger.kernel.org,
 devicetree@vger.kernel.org,
 yilun.xu@intel.com,
 mdf@kernel.org,
 dwmw2@infradead.org,
 linux-kernel@vger.kernel.org
Received: from [172.19.74.144] (port=51750)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <lizhi.hou@xilinx.com>)
        id 1ni1HA-0005Tv-Nm; Fri, 22 Apr 2022 14:57:16 -0700
Message-ID: <79e4c876-e5a4-861f-cfbc-c75ed1a07ddd@xilinx.com>
Date:   Fri, 22 Apr 2022 14:57:16 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH V1 RESEND 2/4] Documentation: devicetree: bindings: add
 binding for PCIe endpoint bus
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>, Tom Rix <trix@redhat.com>
CC:     PCI <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Xu Yilun <yilun.xu@intel.com>, Max Zhen <maxz@xilinx.com>,
        Sonal Santan <sonal.santan@xilinx.com>,
        Yu Liu <larryliu@amd.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Stefano Stabellini <stefanos@xilinx.com>,
        Moritz Fischer <mdf@kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Max Zhen <max.zhen@xilinx.com>
References: <20220305052304.726050-1-lizhi.hou@xilinx.com>
 <20220305052304.726050-3-lizhi.hou@xilinx.com>
 <e4c058e9-6549-4ce2-be05-d09d5b1a9fc9@redhat.com>
 <CAL_JsqKzxq8T=obPQwXeNyqedQOKkmm8hwHdfVgKr15EyAgBnQ@mail.gmail.com>
From:   Lizhi Hou <lizhi.hou@xilinx.com>
In-Reply-To: <CAL_JsqKzxq8T=obPQwXeNyqedQOKkmm8hwHdfVgKr15EyAgBnQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 1
X-MS-Office365-Filtering-Correlation-Id: 3c4144c0-5b87-4660-7257-08da24ab161a
X-MS-TrafficTypeDiagnostic: DM5PR02MB3701:EE_|DM3NAM02FT044:EE_|MN2PR02MB6943:EE_
X-Microsoft-Antispam-PRVS: <MN2PR02MB69435FAF328CCAC1047F9EC3A1F79@MN2PR02MB6943.namprd02.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: NX4EiWowmPpUUUKitov0A1uR1mU0/sb5nSMCVX+/NH2CE3k9xPj40LQd/6GTFKdd+sRMFsbnLuCLFI/FDOCgaNN2GEtFG7GqBd+8o7JudMccHlqjHcc+tpuawA2aI3C7hBOBTi/QHrttSnciHMv8/LbWZ01X8QKGTdkisYvUxUGrNOC2ClB/RaVH1aa3EKfnQltlkjsEm7na8R+uvm4+Hdr/EAjL1p8D3KdsEkF3dbfwd9KN9+5mjwNAJ6CS7a8y9r8bD5U/JWS1FGfahCKO67rxbRIGfqvjYW7Zzyo63MWRE7sF1R/tEzwOJmn3c2+8qJAJGJifvUKS2sC4zkkqo9YDp1kPfi5l8FrxYVWGWUx3haQIHw3bNHCtGe6+KURCJ49/d183cFfdwqmyxvJmqjrkDY2bzmScvYAiX+tGaruvVSWpD/kGIa7xyswYKO+Hb8AZ1PBX4A3sFLuDbhfc9DLJePIcmCMNAPQcCddHpM/5w5wn5zKMq395o0TMgJbHskxn0EJSec5brvdgM2pbNfx6CqNnvqv42lJy8kMckWCX5y/un3eXGQvvRaTez1ZYrpZ8h/CrkKBDcs9ltK8S32/+5zip5kJVxSq3OfGB23D9FQiJEDEP0lT77+I79rcc8kycJgoa1hWYtIINv+NEguDA1+L6NDMj90e0DJ5uM/5UOYocs5kO5CvTodtdvXZyTzI+D/3ugNEu1PfH207fnVxFVuOpBp8Epudojc6cMP7lH0PoUKKq+FMDqzvs3A5dRQ+DBgXqGhS/Pp/6MQjXnyyOzvUouN68u74U8H9bgZatyyo+Ju+CdatGOpTIKmMzjazUlwTlGYqqG05XoAKnIp6XtQ4JENpJPq3AX8/0x6Q=
X-Forefront-Antispam-Report-Untrusted: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(26005)(82310400005)(7636003)(53546011)(356005)(36860700001)(4326008)(186003)(70586007)(8676002)(70206006)(336012)(31686004)(110136005)(426003)(54906003)(47076005)(36756003)(2616005)(508600001)(31696002)(83380400001)(107886003)(316002)(966005)(9786002)(5660300002)(40460700003)(2906002)(44832011)(8936002)(50156003)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR02MB3701
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DM3NAM02FT044.eop-nam02.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: fee92368-bcf8-4e85-0ff4-08da24ab13d4
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Wj5wV6FBXsYuI6Tn2yUmPsy6DVCkwmI8nFfq8v1X9ZZ+2L3d2aHQGGtYJMhuxuNJiGn/7rniK+VHjT51z8iD725vSxQkVHrsURSj5ayGXt8TU2/5P7ccKKUm/DEwUcWr1hWhAfwEv6wsvOe77j0ypLwoQZPomj3emKOU1WHrCS1emPdMa57DJd6ezytaCkD8FtUWctzVtv5iP+7nmhz//7nuAMD+4WPhwltrcbrZk5219SzfWU98masv2DdAEIXFYGkrs0poAzKW0iEm9yvcxOI5wf5HMe7SKYpd1Z068O/y05EUqlzAQshzSW0rkZFvJmHz0Se7SmlFTusaUNQBIOcPSAwsl9rpkNy/rL+jKuRsVTvbC67WNeroQ4TkHdASxQq09kujZigR0FTfp/BldWxMoWkgoLRGmJcAj1f5A3uEFB1LAY+OUNxm1Bw2XjoUC2v3vvzQOIGv2Jmh/jjDROmyCiK38y8vR92WuAU7xB8KnCVa2D7/0+tNsFdjP4VE0vbAMZ+Mg2wf/mmf8XNx+WeLEi1S1nsJiK3WHfgp/45y53Igkb7v+wXwinVE21fdqax4zb5nX2UT6ZaLW7+8/JpWhdLr9q4nqwbSU2gskNqgiKKl9kOyu3Rp5ZLlZQkSFucY+54AZKE+PvdJmHR6ykc/DcOeMtiXnzlT1S1EGPP7Gk95v6Ka2lkzxqRMcYN7o3kKuqeN+W6k7okWtBEi19dT0Km+qh+hgbmojWJSTzH4GMZjB8MX3gc5nJKmogHFRJT6nW7OU6ZnlgJQ9onA8GL54iY0879i4DzgliwW1JEdiI/z/biSYYYs6FZq7o09sEapVmx9YfzIP9jB08oGmj8T0zV/JNsf/RHKMb3kQxMtfVY9Qy6XujvwMEAiHe/vHuUYKkRJu7xAWBHf+7NG0g==
X-Forefront-Antispam-Report: CIP:20.83.241.18;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mailrelay000001.14r1f435wfvunndds3vy4cdalc.xx.internal.cloudapp.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(40460700003)(31686004)(26005)(82310400005)(8676002)(70206006)(36756003)(4326008)(53546011)(508600001)(31696002)(966005)(81166007)(5660300002)(83380400001)(426003)(44832011)(186003)(336012)(2906002)(47076005)(2616005)(9786002)(8936002)(107886003)(110136005)(54906003)(36860700001)(316002)(50156003)(36900700001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2022 21:57:25.4092
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c4144c0-5b87-4660-7257-08da24ab161a
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[20.83.241.18];Helo=[mailrelay000001.14r1f435wfvunndds3vy4cdalc.xx.internal.cloudapp.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-DM3NAM02FT044.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB6943
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Rob,

On 3/7/22 06:07, Rob Herring wrote:
> On Sun, Mar 6, 2022 at 9:37 AM Tom Rix <trix@redhat.com> wrote:
>> Lizhi,
>>
>> Sorry for the delay, I am fighting with checking this with 'make
>> dt_binding_check'
>>
>> There is a recent failure in linux-next around display/mediatek,*
>> between next-20220301 and next-20220302 that I am bisecting.
> There's already patches for that posted.
>
> Just use 'make -k'.
>
>> There are a couple of checkpatch --strict warnings for this set, the
>> obvious one is adding to the MAINTAINERS for new files.
>>
>> Tom
>>
>> On 3/4/22 9:23 PM, Lizhi Hou wrote:
>>> Create device tree binding document for PCIe endpoint bus.
>>>
>>> Signed-off-by: Sonal Santan <sonal.santan@xilinx.com>
>>> Signed-off-by: Max Zhen <max.zhen@xilinx.com>
>>> Signed-off-by: Lizhi Hou <lizhi.hou@xilinx.com>
>>> ---
>>>    .../devicetree/bindings/bus/pci-ep-bus.yaml   | 72 +++++++++++++++++++
>>>    1 file changed, 72 insertions(+)
>>>    create mode 100644 Documentation/devicetree/bindings/bus/pci-ep-bus.yaml
>>>
>>> diff --git a/Documentation/devicetree/bindings/bus/pci-ep-bus.yaml b/Documentation/devicetree/bindings/bus/pci-ep-bus.yaml
>>> new file mode 100644
>>> index 000000000000..0ca96298db6f
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/bus/pci-ep-bus.yaml
>>> @@ -0,0 +1,72 @@
>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>> +%YAML 1.2
>>> +---
>>> +$id: http://devicetree.org/schemas/bus/pci-ep-bus.yaml#
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: PCIe Endpoint Bus binding
>>> +
>>> +description: |
>>> +  PCIe device may use flattened device tree to describe apertures in its
>>> +  PCIe BARs. The Bus PCIe endpoint node is created and attached under the
>>> +  device tree root node for this kind of device. Then the flatten device
>>> +  tree overlay for this device is attached under the endpoint node.
>>> +
>>> +  The aperture address which is under the endpoint node consists of BAR
>>> +  index and offset. It uses the following encoding:
>>> +
>>> +    0xIooooooo 0xoooooooo
>>> +
>>> +  Where:
>>> +
>>> +    I = BAR index
>>> +    oooooo oooooooo = BAR offset
>>> +
>>> +  The endpoint is compatible with 'simple-bus' and contains 'ranges'
>>> +  property for translating aperture address to CPU address.
>
> This binding is completely confusing because 'PCIe endpoint' is
> generally used (in context of bindings and Linux) for describing the
> endpoint's system (i.e. the internal structure of a PCIe device (e.g.
> add-in card) from the view of its own processor (not the host
> system)). This binding seems to be describing the host system's view
> of a PCIe device. We already have that! That's just the PCI bus
> binding[1] which has existed for ~25 years.
>
> For a non-DT system, what you are going to need here is some way to
> create DT nodes of the PCI bus hierarchy or at least from your device
> back up to the host bridge. I would suggest you solve that problem
> separately from implementing the FPGA driver by making it work first
> on a DT based system.
>
> Rob
>
> [1] https://www.devicetree.org/open-firmware/bindings/pci/pci2_1.pdf
>
>
I investigated the implementation detail for adding device tree node for
PCIe devices. Based on my findings this is quite involved and so would
like to bounce off my approach with you before I start making changes.

We will start with DT-Base system which already has device node for PCIe
controller in base device tree. And we will focus on:

- Adding functions to generate device tree node for all PCIe devices.
- Linking dynamically generated DT nodes to the PCIe to the PCIe devices.

So the first question to resolve is when the PCIe DT node will be created
and destroyed. Here are the different options:

- Option #1: Add functions in pci_bus_add_device()/pci_stop_dev()
   - The same place for creating/destroying device sysfs node. This should
     be able to handle different cases: SR-IOV vf, hotplug, virtual device
     etc.
   - Leverage existing PCI enumeration and get the device information
     directly from pci_dev structure.

-  Option #2: Enumerate PCIe devices and create DT node without relying
    on PCI subsystem enumeration.
   - E.g. Enumerating and creating PCIe dt node in an init callback
     pure_initcall()
   - Linking dt node to PCIe device is already supported in
     pci_setup_device()
   - Eventually need to handle hotplug case separately.

Option #1 looks an easier and cleaner way to implement.

The second question is for linking the dynamic generated dt node to PCIe
device through pci_dev->dev.of_node. The biggest concern is that current
kernel and driver code may check of_node pointer and run complete different
code path if of_node is not NULL. Here are some examples.

  - of_irq_parse_pci(): 
https://elixir.bootlin.com/linux/v5.18-rc2/source/drivers/pci/of.c#L492
  - pci_msi_domain_get_msi_rid(): 
https://elixir.bootlin.com/linux/v5.18-rc2/source/drivers/pci/msi/irqdomain.c#L233
  - pci_dma_configure(): 
https://elixir.bootlin.com/linux/v5.18-rc2/source/drivers/pci/pci-driver.c#L1610

It needs to identify all the places which use of_node and make sure using
dynamic generated of_node is equivalent with the code without using
of_node. Considering there are so many hardware and virtualization Linux
support, the risk might high for changing the code which has been existing
for long time. And how to validate the change could be another challenge.
Introducing compiling option (e.g. CONFIG_PCI_DT_NODE) may lower the risk.

There are other approaches for linking dt node to PCIe device.
- Option #a: Add a special flag or property to dynamic generated PCIe DT
   node. Then convert the code.

       if (pdev->dev.of_node)
           funcA();
       else
           funcB();

    to
       struct device_node *pci_get_of_node(pdev)
       {
           if (pdev->dev.of_node is dynamic generated)
               return NULL;
           return pdev->dev.of_node;
       }

       if (pci_get_of_node(pdev))
           funcA ();
       else
           funcB ();

- Option #b: Introduce a new data member "dyn_of_node" in struct device
   to link the dynamic generated PCIe dt node.

       struct device {
           ...
           of_node: Associated device tree node.
           fwnode: Associated device node supplied by platform firmware.
           dyn_of_node: Associated dynamic generated device tree node.
           ...

Could we implement Option #b for now because it is lower risk?

The last question is about the properties for each dynamic generated
PCIe dt node. To keep the generated device node lightweight, what will be
the desired (minimum) set of properties to generate? Besides the properties
defined in IEEE Std 1275, it looks more properties are needed. E.g.
     interrupt-map, interrupt-map-mask, ...

Thanks,
Lizhi

