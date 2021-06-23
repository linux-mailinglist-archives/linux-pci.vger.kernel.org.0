Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B65693B1AC0
	for <lists+linux-pci@lfdr.de>; Wed, 23 Jun 2021 15:08:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230326AbhFWNK5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 23 Jun 2021 09:10:57 -0400
Received: from mail-mw2nam08on2072.outbound.protection.outlook.com ([40.107.101.72]:36544
        "EHLO NAM04-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230430AbhFWNKz (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 23 Jun 2021 09:10:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PloSFpD2HQlgzei3i3UnWKIL4yUbIuLJhNazv0CdNF1DGqurVswHxD1o9GDBw2hBp2iJwWQ9wuAtLUKKOrrEp0eOdEK4TcyDPZz9lvMcdIqHi0AA03LYQVOR4lVyhDqBK10S5LY0iGsvfvFDiGa40hbwDPeokh+5rFU2AvevbWkzMkjX4gGLsjzZSgn4TxdBBjcBJN04TgDvMG+QhTJNIAS/Jh35XACdjjDQzc8BzQWMqLHQSJ3lBI2ZYYuPEXb1OZTkBxu78WCTWg+HAqAruWDIUXuQIcdKdPDIxMCvPplIHzlO+JWY31YBG06Rcp/EKlSJ5u4B7JEoic8jOdZ+ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rP0wHlia1yI1cUcdDmU/uCnMmEauFXjOKTA5MsIAO20=;
 b=aoeGN9buCwslhC5BgO6qC3mWW5BnscPfIcmwijAZZLFSUL5UZKTnnqkEgtHbMkMZ7QKluP9vf03QV6ouT6rh5fb353Vx0LA+GW/vPjRT3dhkZTw/sZAWs8Zb5MIRxF+lpoSRRecnw1NQ9rHiULdBzVsJBjA7dW6gPb5hcrR4wUfAHCA9W9Ibyqrn/GsFi1Pl6RCpcPvxunXJA72nRJ15K8WKN43TVpFM6aO3ZnyL0Tu6LFA8UICs8bF355BraTWFE0AVXoO8DoMdkSLI2drnLwFEYG8IYbFeD8tRbqOi0VPBxgNhak2y3tTnxo7cyFyC6YZLadlQSsrJvkpYnph1UA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rP0wHlia1yI1cUcdDmU/uCnMmEauFXjOKTA5MsIAO20=;
 b=AvjxNZio6ES8hPXgXR71GdYg/vkWUTPmvCJrkm0v1TFxW/fJOd3oS1Qpk4jCaawZcaIDCbpPccjvEiMJFIO6yG808ZU6r3djNWR3f0IwH3Ah33FOOjuTgbw0ADJhLzTA08EWBZg11wH7h4jope+fUTFo8iGhsDYlfevMkry6z3o=
Received: from DS7PR03CA0243.namprd03.prod.outlook.com (2603:10b6:5:3b3::8) by
 SN6PR02MB5437.namprd02.prod.outlook.com (2603:10b6:805:ea::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4242.21; Wed, 23 Jun 2021 13:08:36 +0000
Received: from DM3NAM02FT034.eop-nam02.prod.protection.outlook.com
 (2603:10b6:5:3b3:cafe::54) by DS7PR03CA0243.outlook.office365.com
 (2603:10b6:5:3b3::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.19 via Frontend
 Transport; Wed, 23 Jun 2021 13:08:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 DM3NAM02FT034.mail.protection.outlook.com (10.13.4.156) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4264.18 via Frontend Transport; Wed, 23 Jun 2021 13:08:36 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 23 Jun 2021 06:08:09 -0700
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Wed, 23 Jun 2021 06:08:09 -0700
Envelope-to: git@xilinx.com,
 linux-pci@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 robh@kernel.org,
 lorenzo.pieralisi@arm.com,
 bhelgaas@google.com,
 monstr@monstr.eu,
 linux-kernel@vger.kernel.org,
 kw@linux.com
Received: from [172.30.17.109] (port=43174)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <michal.simek@xilinx.com>)
        id 1lw2bw-00074a-JD; Wed, 23 Jun 2021 06:08:08 -0700
Subject: Re: [PATCH] PCI: xilinx-nwl: Enable the clock through CCF
To:     =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Michal Simek <michal.simek@xilinx.com>
CC:     <linux-kernel@vger.kernel.org>, <monstr@monstr.eu>,
        <git@xilinx.com>, "Hyun Kwon" <hyun.kwon@xilinx.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Lorenzo Pieralisi" <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-pci@vger.kernel.org>
References: <dbc0ab2e109111ca814e73abb30a1dda5d333dbe.1624449519.git.michal.simek@xilinx.com>
 <20210623122040.GA46059@rocinante>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <d7dd7dfe-2c48-c155-793d-1431256a070e@xilinx.com>
Date:   Wed, 23 Jun 2021 15:08:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210623122040.GA46059@rocinante>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b0ac16ce-063d-4e3e-3eee-08d9364802c4
X-MS-TrafficTypeDiagnostic: SN6PR02MB5437:
X-Microsoft-Antispam-PRVS: <SN6PR02MB54379410A7C5899F5BBB686AC6089@SN6PR02MB5437.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: V2YQ9GS0nzv6tuTh42jn22QgQAUnug00LUZTaQtYN+N6UVjPkzMykcmfSi5fIf1Ud5j8MB5xAfUl6cJDH5qIr0lVk6y5wn7JErYhJ7NdBpjIz6se962fSqeOcEc37Ag+kUATEGrt6vrbHC3yHiKezUIdKk2kkGpbyz+xk0tuJNanfT3Sxg2H5WATdTkQZo6kTYVu6pH2EIZBTystzpW32jFguzCy+CO0eMk2SAL0hND7XlTDwxK0IqwRAX0ky/lho+9pxprZ7BWncxl2Na8m39MGHZrTlarRkNeC4Jzd/AxMT72Fj4xprqIUJftTAaPOusOQuFmBw9ZtuOMNzQh/lb4theYS8nzxdyMPPy9g5NetS2elnJ0KLgqHRHUy0g9aTkOO72XLhbQeCZdvFbPkCeW4AR3ZbnemMq+3PLLkivPe/GLPu+t87ALewhIAyA7Q6G6CqRfAW57Tz6Jt7DAuk3wCOSj68iVkVOBcUPSl1oKqOKoXEu4BCvBcLCBuzn2LLRkvVZT5Kgsicm5/Nwl2RCOuhZ2IMoIjOAhT1kivyi3rR8S4OiawI4aBC01im4Jbhz2A1zxUbVAuXUT0teATqv7z0UPmNX4WOf4S7HDL8gQzJl3h8+AsOeBJAVNdURGxzZj0q27HJG+dycngHAqN8YHXfCT2WPfTxodzLoYU/cqkpMygfFU3LToN+AK8hAMbs56YDncvzaYhsMjuvMr4Lg==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(136003)(39860400002)(376002)(346002)(396003)(36840700001)(46966006)(8936002)(2906002)(8676002)(478600001)(70206006)(336012)(316002)(36906005)(36860700001)(186003)(4326008)(70586007)(110136005)(54906003)(82310400003)(5660300002)(53546011)(26005)(47076005)(83380400001)(9786002)(31696002)(6666004)(82740400003)(426003)(36756003)(2616005)(7636003)(31686004)(44832011)(66574015)(356005)(50156003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2021 13:08:36.0687
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b0ac16ce-063d-4e3e-3eee-08d9364802c4
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3NAM02FT034.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB5437
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Krzysztof,

On 6/23/21 2:20 PM, Krzysztof Wilczyński wrote:
> Hi Michal,
> 
> Thank you for sending the patch over!

Thanks for review.

> 
>> Simply enable clocks. There is no remove function that's why
>> this should be enough for simple operation.
> 
> What clock is this?  Would it be worth mentioning what it is for
> a reference (and for posterity) the commit message?

It is reference clock coming to the IP. I will update commit message.


> 
> Also why it would need to be enabled and wasn't before?  Would this be
> a fix for some problem?  Would this warrant a "Fixes:" tag?  And would
> it need to be back-ported to stable kernels?

I will update commit message. Normally reference clock is enabled by
firmware but on some configurations this doesn't need to be truth that's
why it is necessary to enable it. It also records refcount for this
reference clock is good.

I will add Fixes tag to v2.

> 
> [...]
>> @@ -823,6 +825,11 @@ static int nwl_pcie_probe(struct platform_device *pdev)
>>  		return err;
>>  	}
>>  
>> +	pcie->clk = devm_clk_get(dev, NULL);
>> +	if (IS_ERR(pcie->clk))
>> +		return PTR_ERR(pcie->clk);
>> +	clk_prepare_enable(pcie->clk);
>> +
> [...]
> 
> Almost every other user of clk_prepare_enable() would check for
> potential failure, print an appropriate message, and then do the
> necessary clean-up before bailing out and returning an error.
> 
> Would adding an error check for clk_prepare_enable() and printing an
> error message using dev_err() be too much in this case?  If not, then
> I would rather follow the pattern that other users established and
> handle errors as needed.  What do you think?

Agree. I have added it. It is called very early and devm_ functions are
used that's why cleanup shouldn't be necessary.

I have also found that clock wasn't documented in dt binding for this IP
but we are setting it up for quite a long time.
9c8a47b484ed ("arm64: dts: xilinx: Add the clock nodes for zynqmp")

Thanks,
Michal
