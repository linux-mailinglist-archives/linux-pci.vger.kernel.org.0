Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 630286CF18A
	for <lists+linux-pci@lfdr.de>; Wed, 29 Mar 2023 19:59:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbjC2R7J (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 29 Mar 2023 13:59:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjC2R7I (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 29 Mar 2023 13:59:08 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2064.outbound.protection.outlook.com [40.107.94.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD2C52132;
        Wed, 29 Mar 2023 10:59:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j8Sa5UAjM5UHRXzXy8UWrBoXwQlVtaA+8jMeuHfUHb7n9z2EOjmt+9Kc0cIooO+z8AuOTLmxQX+Lmbo4UGe8pnOschd4J8JOnlHHBci03O3DymxzSWDjCM4uA0+MBUucItWfrcrJ4k9cb5zC68NzwOWuaTy9TOWq566pt5P8nAaPKzMY/hO5ShD5h0uA011dcwBAq/VKhE5n2AsTgXr6DJErx4raO05o3V0OC75jM4Q2YVTbabr6QV96ne8+mI7AhCht6v2+sKV9W9SsyLyXR58Io5Dc2hxbrSHM0pbhPTMjGEqc9Xt0EuyVvNA2/8MbksAP0TO7+ykUmgHUlUnXMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZOPneTcbaqfS9zLowMOyXCiplcRCbA5JdYHvdLSXTiw=;
 b=hPzA9uRoaPa03i0Vl8Dj7slquXGvM4ypkC2ls/AopuwJzwj6Obu9AzA16j7m00C/G+FG7IJ8DYv+zRMp9pwxM2Bgtqds96EysstW0p6qyJek8tQMRM5/QghrCE4aCtCgpv6dIj6ZJYLuNoFcXRlipBQCSnD1UI7eYmY/I8ky3DqZo3FMcdLmuY1vnmzRz87TAXo6dAYz8F24/DMXq6yFtWX2KDeW3d+O5am5GmSKoA3QrFpkBX5zlVVWtkV9K2WGQGgtMlJaF5dTwNtMQBdu6h1pJ7JyMrP8K0b2at2rTgquLrRgsv608x6z3ZKTh9/Kf1fTGS4DTxlGnqO0puJVwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZOPneTcbaqfS9zLowMOyXCiplcRCbA5JdYHvdLSXTiw=;
 b=hrK5t53NpSfluhr3iXO9DdvYwls3aw9vuuLMF5J5BHN6h2PJ2jY5/Pik0x3VP6dCkd3B/6nL6UETR+kV+xQLmYMqlg+6VuWUcgy6WQwkcCvyqmpJRFYHaNLn2gaAt1eFAz7CcHIoX1xXorBqYjpaVU8MJ+bYyiNEe9CIQ3nWm9JcRXz5eSOC9MNZ58NzLNY78gxQqIy+PaumdszPKwCzuhFgYkPcEwFjsbDy+jNYxnQ++uq3NEtXzDu38dpe2Flcdsla38zWcjfG8quD8AzgtTc7CS3fkpW+ObynrqeCl/B7nSJUA0sk5qFW3KL24BZ43pI8YkFTzZpF7jf3w3Mgzg==
Received: from CY5PR04CA0010.namprd04.prod.outlook.com (2603:10b6:930:1e::19)
 by SJ2PR12MB7848.namprd12.prod.outlook.com (2603:10b6:a03:4ca::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.28; Wed, 29 Mar
 2023 17:59:01 +0000
Received: from CY4PEPF0000C981.namprd02.prod.outlook.com
 (2603:10b6:930:1e:cafe::a0) by CY5PR04CA0010.outlook.office365.com
 (2603:10b6:930:1e::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.20 via Frontend
 Transport; Wed, 29 Mar 2023 17:59:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000C981.mail.protection.outlook.com (10.167.241.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.26 via Frontend Transport; Wed, 29 Mar 2023 17:59:01 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 29 Mar 2023
 10:58:49 -0700
Received: from [10.41.21.79] (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Wed, 29 Mar
 2023 10:58:43 -0700
Message-ID: <1d029226-9749-9211-2baa-7f9188641ce0@nvidia.com>
Date:   Wed, 29 Mar 2023 23:28:40 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [Patch v4 10/10] PCI: tegra194: add interconnect support in
 Tegra234
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     <treding@nvidia.com>, <krzysztof.kozlowski@linaro.org>,
        <dmitry.osipenko@collabora.com>, <viresh.kumar@linaro.org>,
        <rafael@kernel.org>, <jonathanh@nvidia.com>, <robh+dt@kernel.org>,
        <lpieralisi@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <mmaddireddy@nvidia.com>, <kw@linux.com>, <bhelgaas@google.com>,
        <vidyas@nvidia.com>, <sanjayc@nvidia.com>, <ksitaraman@nvidia.com>,
        <ishah@nvidia.com>, <bbasu@nvidia.com>,
        Sumit Gupta <sumitg@nvidia.com>
References: <20230329165957.GA3066317@bhelgaas>
From:   Sumit Gupta <sumitg@nvidia.com>
In-Reply-To: <20230329165957.GA3066317@bhelgaas>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000C981:EE_|SJ2PR12MB7848:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d2c4ae9-e08d-4ffc-51e6-08db307f4720
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: D6kR2wcA3gTet6BsihXBjG0+2Z6/uZ6d9W7moBalrVAHpv/rdjDL8plrL59XH5j8uWZWVNRK6N4lQqVzzNQOlVvkUkMrxnkE+JHZEEemEi/QLn1RMZMf585o9sxKPyBi4nqGeHyo43xMUw5f7G0TFCfvjJI9C3moKrt8k6mwI2epwgcbfmPRV8q9aGMaVzU/uYbiDQuLvDpj5FR1Mgjmg0yvsQOY5VrgQpWaNzRukskknrLpBxF27UeZ+Aga4jBDPH8bQIl9IqToBfsJ/n0y7bodsJz3a5KqRQ9bZuIAL6A6+GTTxNJ6NkANUmV7BKH2nZj5rNIWzpxidbz/FN1rpf2TmQTKhU3Lkl+OZZqPDPdU1pFlnAgdKCTfLriqQ3T+Z0LrFKwjg6OE+em9LcGeQZ2iPPe1XZFMXzZ33ZTSZI47dbQgTaLNertnAg0N4DtHSEeLfo0t8QWiGLLzs+ZqQzXVXOyek9BHuoAi+6sLyUTMzo6y5MshRotLq+6eqqPtww9aoU1jZwdvve9l+BjOsE+em+PijTGwG/I6DZ0YCBiQ5I8B2K1AXLZElUGg/gVRyvChF9WdWZA1CMuTuq9yt9sM9CfDvYCBiPeD42OWUfntI7HkjpU1oyB/6iI6+ohu6V3llkmMG/4BldTvZ6MSO+o1YpNEzspxHk6Ls8wK0iPSHBJuq6pRgRYi8wRETn01sgArMWP9xKGcMsgIZAFdODEcJMjIy+v/GWBLagFqR21RUJ5fBm0koMpzWKR6JLcYF1CALpDzaUtJfJlyLAZo8kFpXU6IK/Ibyu5nEJUEJqk=
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(136003)(346002)(39860400002)(451199021)(46966006)(36840700001)(40470700004)(47076005)(2906002)(2616005)(83380400001)(426003)(336012)(6916009)(8676002)(4326008)(70206006)(70586007)(478600001)(54906003)(53546011)(316002)(16576012)(26005)(16526019)(7416002)(107886003)(82310400005)(186003)(36756003)(86362001)(36860700001)(41300700001)(31696002)(82740400003)(7636003)(5660300002)(356005)(40480700001)(40460700003)(31686004)(8936002)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2023 17:59:01.3931
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d2c4ae9-e08d-4ffc-51e6-08db307f4720
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000C981.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7848
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 29/03/23 22:29, Bjorn Helgaas wrote:
> External email: Use caution opening links or attachments
> 
> 
> On Wed, Mar 29, 2023 at 02:44:34PM +0530, Sumit Gupta wrote:
>> On 28/03/23 23:23, Bjorn Helgaas wrote:
>>>> +static void tegra_pcie_icc_set(struct tegra_pcie_dw *pcie)
>>>> +{
>>>> +     struct dw_pcie *pci = &pcie->pci;
>>>> +     u32 val, speed, width;
>>>> +
>>>> +     val = dw_pcie_readw_dbi(pci, pcie->pcie_cap_base + PCI_EXP_LNKSTA);
>>>> +
>>>> +     speed = FIELD_GET(PCI_EXP_LNKSTA_CLS, val);
>>>> +     width = FIELD_GET(PCI_EXP_LNKSTA_NLW, val);
>>>> +
>>>> +     val = width * (PCIE_SPEED2MBS_ENC(pcie_link_speed[speed]) / BITS_PER_BYTE);
>>>> +
>>>> +     if (icc_set_bw(pcie->icc_path, MBps_to_icc(val), 0))
>>>> +             dev_err(pcie->dev, "can't set bw[%u]\n", val);
>>>> +
>>>> +     clk_set_rate(pcie->core_clk, pcie_gen_freq[speed - 1]);
>>>
>>> Array bounds violation; PCI_EXP_LNKSTA_CLS is 0x000f, so possible
>>> speed (CLS) values are 0..0xf and "speed - 1" values are -1..0xe.
>>>
>>> pcie_gen_freq[] is of size 4 (valid indices 0..3).
>>>
>>> I see that you're just *moving* this code, but might as well fix it.
>>>
>> Thank you for the review.
>> Will include the below change in the same patch. Please let me know if any
>> issue.
>>
>>   -       clk_set_rate(pcie->core_clk, pcie_gen_freq[speed - 1]);
>>   +       if (speed && (speed <= ARRAY_SIZE(pcie_gen_freq)))
>>   +               clk_set_rate(pcie->core_clk, pcie_gen_freq[speed - 1]);
>>   +       else
>>   +               clk_set_rate(pcie->core_clk, pcie_gen_freq[0]);
> 
> I didn't notice that speed is a u32, so -1 is not a possible value.
> Also, it's used earlier for PCIE_SPEED2MBS_ENC(), so you could do
> something like this:
> 
>    speed = FIELD_GET(PCI_EXP_LNKSTA_CLS, val) - 1;
>    if (speed >= ARRAY_SIZE(pcie_gen_freq))
>      speed = 0;
> 
>    val = width * (PCIE_SPEED2MBS_ENC(pcie_link_speed[speed]) /
>          BITS_PER_BYTE);
>    ...
>    clk_set_rate(pcie->core_clk, pcie_gen_freq[speed]);

I tried this change but PCIE_SPEED2MBS_ENC gives zero when speed value 
is one. The speed value ranges from "1 to 4" and for value "1", 
pcie_link_speed[speed] gives '0xff'.

  const unsigned char pcie_link_speed[] = {
          PCI_SPEED_UNKNOWN,              /* 0 */

The below change works fine. Please share if its OK to add it in patch.

   speed = FIELD_GET(PCI_EXP_LNKSTA_CLS, val);
   if (!speed || speed >= ARRAY_SIZE(pcie_gen_freq))
           speed = 1;

   val = width * (PCIE_SPEED2MBS_ENC(pcie_link_speed[speed]) / 
BITS_PER_BYTE);

   if (icc_set_bw(pcie->icc_path, MBps_to_icc(val), 0))
           dev_err(pcie->dev, "can't set bw[%u]\n", val);

   clk_set_rate(pcie->core_clk, pcie_gen_freq[speed - 1]);


Thank you,
Sumit Gupta
