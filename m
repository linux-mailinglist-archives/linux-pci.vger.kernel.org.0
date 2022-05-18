Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E43B552C33A
	for <lists+linux-pci@lfdr.de>; Wed, 18 May 2022 21:24:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241891AbiERTWe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 18 May 2022 15:22:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241829AbiERTWd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 18 May 2022 15:22:33 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1anam02on2078.outbound.protection.outlook.com [40.107.96.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5D1D14C762;
        Wed, 18 May 2022 12:22:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dskzI4tjINEaWkkaAbQQcg70UaR8zAeFHP7E5FyrtuNU7z33aiY31EwvOQOuzjFGCH7QSpIeqiiJfjYotBs5eT1jpdgxF9OwfQIN2h8v+Viln+573QnGPW52eSS1RNNWN3vMDsspQ5Iz/YQrAXrNyHAAPCWfWe/2vl6wgNwbJ2U+v0foMqQr9K/O6D48+/Kd59OWSIcjYHi/Px/zCufDChIVCQHzMqrQK7WKTjU5+bKnSS4jm1PL8JfEKKy7tEI1T8AdH9SLOCmRPxlB4FtMKneAr27fa+6RWpuGgZbGYPDOYtV47ibomiZwd9+kd4EcnYv5ebCCqEOPJCqJZp2wUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bb7XMGlD0sfsnTMl5CvumuJKGGemDeTchlrsWtTvTcg=;
 b=nbGlhssGwi6hR18j/XrTH5f0hV+Py7XwivQSzx/jHBQOL9SrGywlpZAyaiz41ZULOfZUCp/6twP+D5pxSk7xz3xvP0Et4SQA7C2tqDh4AR3xt9xvN1jnsDv0KehA66/M0qfW+pvfPd5kwU7bOynFwkIHAvYJLrYzU/UcAuygNiDqZ8j0SE1KiWSLgMqFADzZSTKUFYlOczo80AE9qAzSHnGlZBAqOsIoV1IB89JLZko1wudFczh3Su49niV0qW2EbRdmkF2GRScv7gZ1BM3UrCf8B+zM1jUw0TK1uDliH6f6PJWYtebZPTYC4hDRcHMHCCWMoi8ZYnQFfjhcUCkpAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=bootlin.com smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bb7XMGlD0sfsnTMl5CvumuJKGGemDeTchlrsWtTvTcg=;
 b=EsrE4LAIS4JFIsd6OfwUaWJFPsdMt7ge3CMk5gWDBQJ9I3ne3KAvCC6DMdIa2crl+8bQRNzmByk0/j+TJqk2SuvxmnaUtOZgj3zEv2e9VDhrUh1j1yqtsklPBS/odw7+TvUUwaEutRbccLskMub75b6D25seY69uZqxB5txNQJY=
Received: from SA9PR03CA0007.namprd03.prod.outlook.com (2603:10b6:806:20::12)
 by BY5PR02MB6644.namprd02.prod.outlook.com (2603:10b6:a03:20b::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.13; Wed, 18 May
 2022 19:22:28 +0000
Received: from SN1NAM02FT0036.eop-nam02.prod.protection.outlook.com
 (2603:10b6:806:20:cafe::d0) by SA9PR03CA0007.outlook.office365.com
 (2603:10b6:806:20::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.13 via Frontend
 Transport; Wed, 18 May 2022 19:22:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com; pr=C
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT0036.mail.protection.outlook.com (10.97.4.102) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5273.14 via Frontend Transport; Wed, 18 May 2022 19:22:27 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Wed, 18 May 2022 12:22:11 -0700
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Wed, 18 May 2022 12:22:11 -0700
Envelope-to: clement.leger@bootlin.com,
 helgaas@kernel.org,
 robh+dt@kernel.org,
 frowand.list@gmail.com,
 pantelis.antoniou@konsulko.com,
 bhelgaas@google.com,
 allan.nielsen@microchip.com,
 horatiu.vultur@microchip.com,
 steen.hegelund@microchip.com,
 thomas.petazonni@bootlin.com,
 alexandre.belloni@bootlin.com,
 broonie@kernel.org,
 andriy.shevchenko@linux.intel.com,
 kuba@kernel.org,
 hdegoede@redhat.com,
 andrew@lunn.ch,
 devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org,
 robh@kernel.org
Received: from [172.19.74.144] (port=43354)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <lizhi.hou@xilinx.com>)
        id 1nrPFH-000C3d-Ml; Wed, 18 May 2022 12:22:07 -0700
Message-ID: <c2f6d576-b48b-d1a7-2e4d-bbedea969f52@xilinx.com>
Date:   Wed, 18 May 2022 12:22:07 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH 2/3] PCI: of: create DT nodes for PCI devices if they do
 not exists
Content-Language: en-US
To:     =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <clement.leger@bootlin.com>,
        Bjorn Helgaas <helgaas@kernel.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Allan Nielsen <allan.nielsen@microchip.com>,
        Horatiu Vultur <horatiu.vultur@microchip.com>,
        Steen Hegelund <steen.hegelund@microchip.com>,
        Thomas Petazzoni <thomas.petazonni@bootlin.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Mark Brown <broonie@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Andrew Lunn <andrew@lunn.ch>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        Rob Herring <robh@kernel.org>
References: <20220427094502.456111-3-clement.leger@bootlin.com>
 <20220503225353.GA415393@bhelgaas> <20220504154303.5cdf8cc2@fixe.home>
From:   Lizhi Hou <lizhi.hou@xilinx.com>
In-Reply-To: <20220504154303.5cdf8cc2@fixe.home>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 02b1782a-f26a-4400-1ed6-08da3903bf03
X-MS-TrafficTypeDiagnostic: BY5PR02MB6644:EE_
X-Microsoft-Antispam-PRVS: <BY5PR02MB664439D04F11BD75AEC9A195A1D19@BY5PR02MB6644.namprd02.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bmDtyR3YKwH8tGOLkI/3lXczMkeiNqJiQt0pfQdxfUilG0YqhlzVjMIWH4POzHGdm27d7VA0fomZsxeKx2EXsUcR7T4ZVaGumYhVZmTqxHBR7I0dmkdrJY/Ubdv4yWYzCTDWia1YHaaMfte0ICztfWslWa6UBGxe9+771iqoAYZqZevGqj7bkK9eJy3TRWs2lHVCjEGjaQ968Vata/A7dhh1DUQXPJPF6LXO5JrQc1GuawH841CQH2QgME00W/hnTG4gz75p5KLjTn4HZOhQQil12Umb99e00lIPKY/1P9XWkzbKa54datP1oQEv5lGy4ngOqGZffHv4+m8XBLJNiXwBtH1AUA7qMJko9FaYYZJvCVWwF67T+sGzTsYsSAXjru6s8Wz2j7obJfxFSJlJFGIUAh0xw8U/ojf3o4t50II/hFMGiGMS1J+2u+UqyN0vuj2qJIi68tNVvtYbgeRU31LXXJcm9lDQWtMIso0v/QseBuwkB6rFOolC9VVeFk3GSIGavJtPrMa90mqHKM/xBHDAhfDZNY2//7+fF72ccxk2JCwQf/xzKebNSQi4Rd2AZyjPHlSpmrDrGAC1wwfAb1+73ojaECXuwt6oG5o0Iktlqe3XGhWQvGsNuAxrHRYY7OnRK3MD+L6Mw1p4wfmg45lagyydpGV1S+yGf3GvlPAwVFKEn5iYwxUY+QZB0NoVz4VXR9SDr4ssXCSUmiKpTwXd/SuyE+ujydEXOPePx+a10ch4aeLyxrjXQCe0hpdGpgRXIitz4mKqzvH/RDPHHQ49yD6xRCTmYKIq608wwpx9hmABKtbSrSb8O1kukUY8xnrddsDjvL9yRPyIcs+69TK9hPVISqRNv09UKIsaojs=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(4326008)(31696002)(83380400001)(40460700003)(26005)(54906003)(110136005)(316002)(426003)(336012)(7636003)(70206006)(356005)(70586007)(47076005)(66574015)(53546011)(2616005)(31686004)(186003)(2906002)(82310400005)(966005)(36756003)(8936002)(36860700001)(508600001)(8676002)(9786002)(7416002)(44832011)(5660300002)(50156003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2022 19:22:27.7746
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 02b1782a-f26a-4400-1ed6-08da3903bf03
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT0036.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR02MB6644
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 5/4/22 06:43, Clément Léger wrote:
> Le Tue, 3 May 2022 17:53:53 -0500,
> Bjorn Helgaas <helgaas@kernel.org> a écrit :
>
>> In subject:
>>
>>    PCI: of: Create DT nodes ... if they do not exist
>>
>> The subject could be read as saying that you're going to create DT
>> nodes before the PCI devices exist, but I think you mean that when we
>> enumerate a PCI devices, we're *always* going to create a DT node for
>> it, even if the DT didn't mention it.
> Hi Bjorn,
>
> Indeed ! I'll modify that.

Linking the dynamic generated dt node to PCIe device through 
pci_dev->dev.of_node may cause issues. Kernel and driver code may check 
of_node pointer and run complete different code path if of_node is not 
NULL.

For example:  in of_irq_parse_pci(): 
https://elixir.bootlin.com/linux/v5.18-rc2/source/drivers/pci/of.c#L492

I encountered different issues when I tried to create a prototype. And I 
have sent all may questions/thoughts through 
https://lore.kernel.org/lkml/79e4c876-e5a4-861f-cfbc-c75ed1a07ddd@xilinx.com/#t

I am wondering what would be the right way to resolve it?


Thanks,

Lizhi

>
>> Maybe something like:
>>
>>    PCI: of: Create DT node for every PCI device
>>
>> although I see Rob thinks this should be done on demand instead of
>> doing it for every device, which sounds sensible to me.
> Agreed, I'll rework this series.
>
> Thanks,
>
>> On Wed, Apr 27, 2022 at 11:45:01AM +0200, Clément Léger wrote:
>>> In order to apply overlays to PCI device nodes, the nodes must first
>>> exist. This commit add support to populate a skeleton tree for PCI bus
>>> and devices. These nodes can then be used by drivers to apply overlays.
>> s/This commit add support/Add support/
>>
>> Bjorn
>
>
