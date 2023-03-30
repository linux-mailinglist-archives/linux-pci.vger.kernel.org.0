Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEA346CFD98
	for <lists+linux-pci@lfdr.de>; Thu, 30 Mar 2023 10:01:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230012AbjC3IAw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 30 Mar 2023 04:00:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229967AbjC3IAt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 30 Mar 2023 04:00:49 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2058.outbound.protection.outlook.com [40.107.243.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1E4B6199;
        Thu, 30 Mar 2023 01:00:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eZmlr/iyfazVZnT3DIEI6b9aIwGGntg9dPkrVn99FYskHlTB0UZSlsGucDKG5zIs/uvSa9afGXD5Mfu+sqGmJ1XGWyFGDTx+N2ig8Rt+r74/z0fLkKA9b8g7vBR4QicuxOZat/whpqXgV1/Wxz/1pnKxt2p3Eumam3RfcDv2nzo196VF2TBMMkfipLH/u/UBuzkQKwEDBR2yHj2jaI8Y648isv5CS9tjPQfB29+InwOF8RZXtIqaUuauicuAuPomqSt+Gchhm+8xqBlLal0VPznng9A+RBbSJmAvBSux0eh2NnCdmy8wGbQ4fRSysjNTNbC4SpINcwy9IiRfTQoBSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QDHLdFJ2rnEBPrCpcr3nXSZR/4JHONT4dd5pvk7UmSI=;
 b=XmCpsdxBO0LoyVjvE0j3slW5Q7zAglEqg3FYGEZlCqRGP4kPny1euV/8SoI4Kkr6v4S2g6Wsmst5dBubia0d0ooF1UUTSUXp5nrEEL2ThNg9PadcapSOCGUpqPnQGtchHo/OripKO67WRIoKITCtbSBOJV/SMonFjUtZoXkk1xnaFoRLK4S7o0P8p5DMNG3VKM3Nhm1ZKd4Vi49Ti6XZyR7juLQAW0VYjvMddXg0qR5QRzw+STtuPK4+aD0jjbPnMJnmzCfKOM95WcS7UGE/t7YdVv+R10IRfMhRwiAtFMn4Alt3IgYmowZlTimGpH4no0HviNIfOZ8Uo2WB+P1Qqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QDHLdFJ2rnEBPrCpcr3nXSZR/4JHONT4dd5pvk7UmSI=;
 b=kwy99lLRY2yBZwzru8UidHyIQIb/4vElUs+qZH1IujBP9G46olnh2JpFCNo37GzXn/y9s/fFp9+kJukASlv2zOcNImr6zD8dJ3pQILJpRhEQDHZN2IDocWbXNip/iZ163Q09Kq03CTx7jSF899IujxKcjBFAlAQ2IO7C4xrCtvpUHaljzwIZHmqPE98NHqKXRnW5f0Q5AHO+YEZQWVfi8C/cD+JRAlAEeABKMOtUO82sRaSnHfEH1a7yyU/GXkoToa6PHa6ui7t2K3mUc7OO/KRpxRfuHML/8vy3AHbmgVPLe1rbF8HZh1IWo6ECtXCKXYT/doK0bxv5XvvcyuzXvg==
Received: from MW4PR04CA0098.namprd04.prod.outlook.com (2603:10b6:303:83::13)
 by DS0PR12MB6487.namprd12.prod.outlook.com (2603:10b6:8:c4::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.26; Thu, 30 Mar
 2023 08:00:46 +0000
Received: from CO1NAM11FT046.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:83:cafe::4d) by MW4PR04CA0098.outlook.office365.com
 (2603:10b6:303:83::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.20 via Frontend
 Transport; Thu, 30 Mar 2023 08:00:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1NAM11FT046.mail.protection.outlook.com (10.13.174.203) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6254.22 via Frontend Transport; Thu, 30 Mar 2023 08:00:45 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 30 Mar 2023
 01:00:24 -0700
Received: from [10.41.21.79] (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Thu, 30 Mar
 2023 01:00:18 -0700
Message-ID: <72b9168b-d4d6-4312-32ea-69358df2f2d0@nvidia.com>
Date:   Thu, 30 Mar 2023 13:30:16 +0530
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
References: <20230329191703.GA3076491@bhelgaas>
From:   Sumit Gupta <sumitg@nvidia.com>
In-Reply-To: <20230329191703.GA3076491@bhelgaas>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT046:EE_|DS0PR12MB6487:EE_
X-MS-Office365-Filtering-Correlation-Id: fa544357-74cc-4cc7-7a91-08db30f4de39
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qHQi7QEiEKez7cDlBSG7nCwLHGTyu2P9NHJ17KLL+YSjy2vR4X6L/rYWiGZFrjL8U7JGA8WTwJW92ambbpZR023FDYxPrjA02KERYYD0zMmMK/Kuz+2/J7sFgATdKnvXjAnq1GpXUJ+d04dEirIB9TZVUG629fsNWIheHtA5A99UcAhGniBTvT6UtmZELBD38buJU7IjWLXazUbpxnxrwWniMEVKqMOYDfoQRYQMiVw4KAFZ200lZArf4Yf1Ub5+1UwpeqvUEqwrYSl1KnhRuRjhv5coAhXUoPdIV45RM0VctegWgHsbcCS3miI/pNYAt7mg4zRw98U9Y10BBWD2h/EScfVTFFbwPo1Cj06IACV94FEAVtnArb5P8FqBbZPoav10ATlT+aN8qmnp6skULFeJJIghJzNDYYEywErNkg68L+rv9unBMyzC9XD7nHa0TPst9xJSh7kHe7/7sI8yw+z1gMi8/JFy1673V0CV1BFqrjS9lJDcIrQD/VbbyPo1BoYDhKfEZFYEcTQJkffSxpxJcEmCz3vcAZv0TBVEaUmsG6eMbYzytpVpQirIQHIpSSN/my9h4oEzKdrL/Ubx43az+jXu7+IcJDrUo5mDWFbWsY0Oht2idCyzRvNkG9FplvivQ3ZlFvK2V6RYLIMJkjowChINsdkZIQ2nF9zXNLbhHF16EOLUeXjQeiiHqkHjdGLmSAbOI4rmyVlkcBqFNNR34vHYRORgdOkxdCxx/wZvgGEIeNzjWcUmpmYcXf92Y+PhAVzBddKanDjk6Mr6kpxQxqa9vlNiZz2EcHpWf1Iklt3tXnp84VyVsRMVxt6S
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(136003)(396003)(346002)(451199021)(36840700001)(46966006)(40470700004)(36860700001)(336012)(47076005)(478600001)(26005)(8676002)(40460700003)(16526019)(356005)(31696002)(107886003)(2906002)(31686004)(54906003)(70586007)(40480700001)(186003)(4326008)(82310400005)(316002)(7416002)(86362001)(36756003)(41300700001)(16576012)(83380400001)(53546011)(82740400003)(426003)(7636003)(5660300002)(2616005)(70206006)(34020700004)(8936002)(6916009)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2023 08:00:45.9957
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fa544357-74cc-4cc7-7a91-08db30f4de39
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT046.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6487
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 30/03/23 00:47, Bjorn Helgaas wrote:
> External email: Use caution opening links or attachments
> 
> 
> On Wed, Mar 29, 2023 at 11:28:40PM +0530, Sumit Gupta wrote:
>> On 29/03/23 22:29, Bjorn Helgaas wrote:
>>> On Wed, Mar 29, 2023 at 02:44:34PM +0530, Sumit Gupta wrote:
>>>> On 28/03/23 23:23, Bjorn Helgaas wrote:
>>>>>> +static void tegra_pcie_icc_set(struct tegra_pcie_dw *pcie)
>>>>>> +{
>>>>>> +     struct dw_pcie *pci = &pcie->pci;
>>>>>> +     u32 val, speed, width;
>>>>>> +
>>>>>> +     val = dw_pcie_readw_dbi(pci, pcie->pcie_cap_base + PCI_EXP_LNKSTA);
>>>>>> +
>>>>>> +     speed = FIELD_GET(PCI_EXP_LNKSTA_CLS, val);
>>>>>> +     width = FIELD_GET(PCI_EXP_LNKSTA_NLW, val);
>>>>>> +
>>>>>> +     val = width * (PCIE_SPEED2MBS_ENC(pcie_link_speed[speed]) / BITS_PER_BYTE);
>>>>>> +
>>>>>> +     if (icc_set_bw(pcie->icc_path, MBps_to_icc(val), 0))
>>>>>> +             dev_err(pcie->dev, "can't set bw[%u]\n", val);
>>>>>> +
>>>>>> +     clk_set_rate(pcie->core_clk, pcie_gen_freq[speed - 1]);
>>>>>
>>>>> Array bounds violation; PCI_EXP_LNKSTA_CLS is 0x000f, so possible
>>>>> speed (CLS) values are 0..0xf and "speed - 1" values are -1..0xe.
>>>>>
>>>>> pcie_gen_freq[] is of size 4 (valid indices 0..3).
>>>>>
>>>>> I see that you're just *moving* this code, but might as well fix it.
>>>>>
>>>> Thank you for the review.
>>>> Will include the below change in the same patch. Please let me know if any
>>>> issue.
>>>>
>>>>    -       clk_set_rate(pcie->core_clk, pcie_gen_freq[speed - 1]);
>>>>    +       if (speed && (speed <= ARRAY_SIZE(pcie_gen_freq)))
>>>>    +               clk_set_rate(pcie->core_clk, pcie_gen_freq[speed - 1]);
>>>>    +       else
>>>>    +               clk_set_rate(pcie->core_clk, pcie_gen_freq[0]);
>>>
>>> I didn't notice that speed is a u32, so -1 is not a possible value.
>>> Also, it's used earlier for PCIE_SPEED2MBS_ENC(), so you could do
>>> something like this:
>>>
>>>     speed = FIELD_GET(PCI_EXP_LNKSTA_CLS, val) - 1;
>>>     if (speed >= ARRAY_SIZE(pcie_gen_freq))
>>>       speed = 0;
>>>
>>>     val = width * (PCIE_SPEED2MBS_ENC(pcie_link_speed[speed]) /
>>>           BITS_PER_BYTE);
>>>     ...
>>>     clk_set_rate(pcie->core_clk, pcie_gen_freq[speed]);
>>
>> I tried this change but PCIE_SPEED2MBS_ENC gives zero when speed value is
>> one. The speed value ranges from "1 to 4" and for value "1",
>> pcie_link_speed[speed] gives '0xff'.
> 
> Oh, my fault, sorry!  I thought both places indexed the same array,
> but the first is pcie_link_speed[] (where all the possible values
> (0..0xf) are valid indices) and the second is pcie_gen_freq[] (where
> only 0..3 are valid).
> 
>> The below change works fine. Please share if its OK to add it in patch.
>>
>>    speed = FIELD_GET(PCI_EXP_LNKSTA_CLS, val);
>>    if (!speed || speed >= ARRAY_SIZE(pcie_gen_freq))
>>            speed = 1;
>>
>>    val = width * (PCIE_SPEED2MBS_ENC(pcie_link_speed[speed]) /
>> BITS_PER_BYTE);
> 
> So I don't think you need to clamp "speed" for indexing
> pcie_link_speed[] at all.
> 
>>    if (icc_set_bw(pcie->icc_path, MBps_to_icc(val), 0))
>>            dev_err(pcie->dev, "can't set bw[%u]\n", val);
>>
>>    clk_set_rate(pcie->core_clk, pcie_gen_freq[speed - 1]);
> 
> What if you added a 0th entry to pcie_gen_freq[] so you can index it
> directly with the PCI_EXP_LNKSTA_CLS value the same way as
> pcie_link_speed[]?  Then you wouldn't need the "- 1" and only have to
> worry about going off the end:
> 
>    static const unsigned int pcie_gen_freq[] = {
>      GEN1_CORE_CLK_FREQ,   /* PCI_EXP_LNKSTA_CLS == 0; undefined */
>      GEN1_CORE_CLK_FREQ,
>      GEN2_CORE_CLK_FREQ,
>      GEN3_CORE_CLK_FREQ,
>      GEN4_CORE_CLK_FREQ,
>    };
> 
>    speed = FIELD_GET(PCI_EXP_LNKSTA_CLS, val);
> 
>    val = width * (PCIE_SPEED2MBS_ENC(pcie_link_speed[speed]) /
>          BITS_PER_BYTE);
> 
>    if (speed >= ARRAY_SIZE(pcie_gen_freq))
>      speed = 0;
>    clk_set_rate(pcie->core_clk, pcie_gen_freq[speed]);
> 
> Bjorn

Yes, this is working fine. Will add it in the patch.

Thank you,
Sumit Gupta
