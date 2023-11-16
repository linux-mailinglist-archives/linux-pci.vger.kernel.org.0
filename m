Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 791707ED8A8
	for <lists+linux-pci@lfdr.de>; Thu, 16 Nov 2023 01:48:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbjKPAs3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 15 Nov 2023 19:48:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbjKPAs2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 15 Nov 2023 19:48:28 -0500
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2094.outbound.protection.outlook.com [40.107.95.94])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBC67125;
        Wed, 15 Nov 2023 16:48:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T0nesYt97ydNO4wtUm24/mM+Y6nCpzZjrMMmVk+EImaiQuFKTRwXohEgnXoGMSPzjNRJQrU0XCQXAFv1z8QG231k7eFdS+V3ug/2RfItyBRwa4hESu04nFs0zFOiOshR4arGQTDfEe0cZVK0GO8sbj1Dy/vkr6TpGBKZwYtpMGsmxNIuNjeUzM6FK9peO3qa0T8lHHLWjxmMvFNzQ45Boz9rNXH3L6NhZ4mEDaD1tK3CNef4PNaEtOExsRa7atV9cJ+O4FNCnbGeEvR9iF96ifuBwOwOcQVuHCWyUytGAABCvar0FiehKPMSnHhrwCGADjcQaTnJ+DHqVBHIxN9o4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w5y16fW60pijhOOQ4q5b+eZrnmq63ov3bpSQVzJMKR4=;
 b=E8L4MgDP9VumMW9gwoPKnFybTha3rpCyUyfMUtFVoabrlAOrhEX0znuQ8gJcb5MsM87g+nvmxJMPR/uhCqv8cAJLljDFX6Xssyg4Vl7uc6B3vT9p1/TK2L3c2+xO9009JJneeXrCo9mvwjwTk+IYmJLBuEesdIdLOJeBMnMGnMPSFZ+1mM1SQqvp2NABXAO4Ff9djyTMWK5ZhNQxy+5o/WcTPCmIQ2gy0JeZD6LvcyFoMVvn0Hys0BxTGxfLk5cHpgd8WHCzHjQNCov8wGORwhKuEmJSuiUffhokT0uIZc7MIfEUBArJbdLNXDc1m8jFDyerouElQW/l4jbVD03OfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w5y16fW60pijhOOQ4q5b+eZrnmq63ov3bpSQVzJMKR4=;
 b=KwMJB2lsYG6WqsTEW5UKJj6Om2DGrc6XyvMOs8Uzy9Oni5DZnfRLGy/dJOe+OAtLPzEIK+GRHPAiZrjmO1hrsaf8mUvGo5XifTqLVrkGyXUUMxfGNC4K3yWjPvEzRJdA+qQA2dxsi+YciYfk7DL93aRLiO6RBRmyeQrHQLcpeMs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from DM5PR0102MB3590.prod.exchangelabs.com (2603:10b6:4:a4::25) by
 MN0PR01MB7876.prod.exchangelabs.com (2603:10b6:208:383::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7002.20; Thu, 16 Nov 2023 00:48:20 +0000
Received: from DM5PR0102MB3590.prod.exchangelabs.com
 ([fe80::49fa:8dc0:6fd1:72e6]) by DM5PR0102MB3590.prod.exchangelabs.com
 ([fe80::49fa:8dc0:6fd1:72e6%4]) with mapi id 15.20.6977.018; Thu, 16 Nov 2023
 00:48:20 +0000
Date:   Wed, 15 Nov 2023 16:48:01 -0800 (PST)
From:   Ilkka Koskinen <ilkka@os.amperecomputing.com>
To:     Shuai Xue <xueshuai@linux.alibaba.com>
cc:     Ilkka Koskinen <ilkka@os.amperecomputing.com>,
        kaishen@linux.alibaba.com, helgaas@kernel.org,
        yangyicong@huawei.com, will@kernel.org,
        Jonathan.Cameron@huawei.com, baolin.wang@linux.alibaba.com,
        robin.murphy@arm.com, chengyou@linux.alibaba.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pci@vger.kernel.org, rdunlap@infradead.org,
        mark.rutland@arm.com, zhuo.song@linux.alibaba.com,
        renyu.zj@linux.alibaba.com
Subject: Re: [PATCH v10 4/5] drivers/perf: add DesignWare PCIe PMU driver
In-Reply-To: <011efd17-c384-4285-9de9-2e40640bec08@linux.alibaba.com>
Message-ID: <74ae6ba7-a2e4-3b89-940-9a29f7cea34f@os.amperecomputing.com>
References: <20231104133216.42056-1-xueshuai@linux.alibaba.com> <20231104133216.42056-5-xueshuai@linux.alibaba.com> <e053a5d-f2a8-86c7-5af-d211507140c4@os.amperecomputing.com> <011efd17-c384-4285-9de9-2e40640bec08@linux.alibaba.com>
Content-Type: multipart/mixed; boundary="1372433909-1567097883-1700095699=:2142"
X-ClientProxiedBy: CH2PR07CA0043.namprd07.prod.outlook.com
 (2603:10b6:610:5b::17) To DM5PR0102MB3590.prod.exchangelabs.com
 (2603:10b6:4:a4::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR0102MB3590:EE_|MN0PR01MB7876:EE_
X-MS-Office365-Filtering-Correlation-Id: a9c3bcce-e88c-4ad7-c75d-08dbe63dba16
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: O4SZG5ha6+C0aP1G25+I4RNgLLtNbl31H8UFkCLM8PFzCUMczcRrTzJjuhI7t85ixAk36HXHYVG6ZR/YukzEq3K1MVN/GAyOR7eurA8kGUfI6OcOOr8jgyzfx8IA5aESsuTpPi6ZQ0GPBu24MtSK9IQs/ipdjAIIh05e7RLsrgBjvWfmTRK9cYElyQETjLrwFKMMkcnRaLjfBOAGjns356JiEbuWxa7lhqZRTiF1duZhFsVExAfT8FMA0uj85Uw1hfuoezwh1T252HCftnTHuPJUD3+hMcrWFHvhvLascmGnKD/bRah1t7kcMPTUuJCAXgSmZSdmVF1jwSzbf2DcDUKbIgTQdU5b8O9p1E9KoO7zIAcs09ydbBgd3Ct+x3m0erRIKLwSLJnpfYzKqysCCe3F2a8QUFPw59Ss9akiCodKo0AYi7sU/4N9UASSXup83mR5/S4klgjXUV1vRZbBqw4IhRYQEYMYUMtnEDEjARTfePCwXVBuwkjS+l4ubWewjmHIy1F3d/qiu7B9RqFJRj1lmR3HTWCxP3ljMdn196s7/0viTAxBcIdScH6XTLsheqiQgRaku1DCtCPUB1IVtJXqIyVTdt8miB5d4QyLVPcPK19BXmuQkdhxWs2bIw04
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR0102MB3590.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(39850400004)(396003)(366004)(136003)(346002)(376002)(230922051799003)(1800799009)(451199024)(186009)(64100799003)(7416002)(2906002)(38100700002)(5660300002)(86362001)(6512007)(83380400001)(6506007)(38350700005)(33964004)(52116002)(53546011)(26005)(2616005)(6666004)(41300700001)(6486002)(19627235002)(478600001)(8676002)(66556008)(6916009)(316002)(66946007)(66476007)(8936002)(4326008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cTU5QnFpSVcybklSTXRla1hnSjh5Um02ci9hakxjOTdKL25TVld4SDZjTzl3?=
 =?utf-8?B?azcrd0lZQ3FsSzNnL3R5QlFSR0dYelJIb2FZVWRUaFgzbTFHT1pBUGNtY1lo?=
 =?utf-8?B?dG9EQzRKWURkUElHamlob0FRL3Vyems0UklyQ3FCNFJMdE4xcDZ1OVM0S09J?=
 =?utf-8?B?Q1RNbkZ5WFhFZXNhT2tpR2ZyMVJ1S3ZJUDE4M25yUkdpM1BGQVR5aGRCVFJB?=
 =?utf-8?B?UUNZblB3WU5Va1lueFV2b2ZpSk1lZnBjWnNNOFdNbjZML0h1dDF1TUxjSm84?=
 =?utf-8?B?b3ZwYzNUaGljVlJEbjJadUlVYTFNdEw3WWs1R2VkdXMvemhoa3VHOWdMWVJV?=
 =?utf-8?B?Tk9Gcm9lcTBFRnRYUU9tYUVXNkZtc1AwY0s5R2txYkw0R0RRdVdabUFJUXVn?=
 =?utf-8?B?RWVlQlpTa0pmYmlhNURYc3UxTHlyNUFPbnhiMmlXeEIraWhHZlcwL2Rhc1pB?=
 =?utf-8?B?TEwwVlpRcUdsM2tId0o1L291Ry9lbXp5WW91RklIdGcxSnR5WUdwUHl5bXk3?=
 =?utf-8?B?NlVJVExkMkxxbUFtR1l2cFBMdkJ0Yi8yNnVqYkF4Snp5T1FKSHExOThJaW1v?=
 =?utf-8?B?cEtBWWpGU05uOG5xY01Nbm5VaFRFMzFrTm1VN0xhKzA5RzdScUZyNnYzN0g5?=
 =?utf-8?B?UGNwUkZsOTY0SXByQVk1RkFIYkE5VEJDV2ovK0YzWllmM28zeTRuRlc0OTlx?=
 =?utf-8?B?UDdjTzR6WXRhcmpMeTBCNXA0SGRhblAwZmh1dkt6L0VUQW1NUnAxTHhiN0xa?=
 =?utf-8?B?Y0tIRURIWUFDRWRPeGlxWmZ3NmhDMmRwRDlmblFrdmppWndTMEI5YlRpbG41?=
 =?utf-8?B?YU9mdFZPUGEvTnU4eGpEbkQ1ZnVXd0tuQzhKcXhaL0FqYTNwMmUzZkozN1Z6?=
 =?utf-8?B?cG1tUXc0R1F4bFpSTkgrbDR4dDhFSDg4NERIM0o1NjZBWk15NzB0NVdPM2gy?=
 =?utf-8?B?MXA3RHYrWHdVTXFFejB4YkdYeVUyL2xWeHU5WUJxOW5LeVp2bTJZWndwUk5G?=
 =?utf-8?B?VUpiMFZPZE1tcytudlh2QjVtaVpJV0JiNC9xd1hYK0F6TDNNdEtvMEFOQTVk?=
 =?utf-8?B?eVUrRDlHY0ZaelFHeXdkTFVoN3M1ajNzcFFTOEJXbERwcU1zWVFQWnpydFd2?=
 =?utf-8?B?YXduWCtGMUJWZ2toQ2dSVnJiR0tpVElLZmJWczBHUjBDSVltc2lTM3ppemZp?=
 =?utf-8?B?ZGpWSzR4dVp6YUdzNFNpSjF0dTNueUpqTE1MWUliVWo4Umw2Z2MvRnRaRmw1?=
 =?utf-8?B?UE1tY0JZdlFFUjhmQzRwZTZYdGQyVzduOEJ1WmpVRkFZa1lnM2FLV1FTU0c4?=
 =?utf-8?B?SUlzeEdFejhxcVpqTFVyeDJjY0dOdlByRjYyL1VyM2dVUnBlNDJsR0xhbk1Q?=
 =?utf-8?B?Y1d1VC85WFViVVgySXV4bDNNNjJ3MG4veUF6YUtSSnh3eVBmZktTL1hXWHgz?=
 =?utf-8?B?dXF6VUVKM3dkVEJ1ZDA5WnBxdDhyMzFINmpNcnErLzBGc2VBSEQwdlpOb2gv?=
 =?utf-8?B?dXc3OFU2Ynh1emMxQUEzTXp0Q2h5c0NOUXdHZzBlcVh4engxemtVV01FZWpL?=
 =?utf-8?B?aWRCSTYyS2N5OUVKdW9JZzV1eWZvb2dLdEtCSmxUdXU1NDhrR3lReGEvMHlz?=
 =?utf-8?B?U3lrUEhLUDVLRkc2QmFoZENlYlZteGpvOVBWZE5obFJhcjJSWFRTR1FzNW50?=
 =?utf-8?B?cnBCdlRJY2I5YzhlNU5Wa3cxQ2tGM1lBU0x2YWl2ek5aZzVEWlhWeDlIdkxR?=
 =?utf-8?B?NlFBUEpzNzVUcTJ0cFpQb3pxa2E4SC9rWSt3TGllZ2sxcXVZaUJKaGZ6RVhv?=
 =?utf-8?B?RlAyS3UrUHJNR1RSd0p4anBrcndObkRJQ29qNWlwbm1xM0NZbm5QQ1B5Qm9n?=
 =?utf-8?B?SytGd0EyckZvVXB1SzRMRGYvQXllZHNaTk0yRXVJeWJaS2pua1JSc3BFN3dB?=
 =?utf-8?B?RVFaN2dUdG4zQWdoc2xaeWxEYkpVV09UMkI1R3VsZVB2SGlYbE1jZWh3THRo?=
 =?utf-8?B?ekJaUTUxeDU4bzIrazZPdG1JckJZdXloVlhaUHdsRjJjVE5lc3djUFZDWEU4?=
 =?utf-8?B?Vmg2QS9SOE5FZEhycTJ6ekpVMzM5dU1kdS9mYldVMTA1MlpYcEVXanVjS3h2?=
 =?utf-8?B?ZjYzbjZNSzdkelZzUnNLZWt6WkJZTXNxbS9FVWhVMEk4aXE1d0dSTzZTRDA4?=
 =?utf-8?Q?n3IfyRU2ktLAVRttn+OLh1g=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9c3bcce-e88c-4ad7-c75d-08dbe63dba16
X-MS-Exchange-CrossTenant-AuthSource: DM5PR0102MB3590.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2023 00:48:19.9945
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LFY/U+uVouQ3BiSyZFz2b45+dsfbMlkyYwDno4qkocOqoHiSnK/P4gYiEcGtzo7djqamHppX6rUFGb2Vx6eEpFGpgFGowittQz1o+gnTdyzYqCs8xKTMWkuM191WYOI6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR01MB7876
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

--1372433909-1567097883-1700095699=:2142
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT


On Wed, 15 Nov 2023, Shuai Xue wrote:
> On 2023/11/15 08:07, Ilkka Koskinen wrote:
>>
>> Hi Shuai,
>>
>> On Sat, 4 Nov 2023, Shuai Xue wrote:
>>> This commit adds the PCIe Performance Monitoring Unit (PMU) driver support
>>> for T-Head Yitian SoC chip. Yitian is based on the Synopsys PCI Express
>>> Core controller IP which provides statistics feature. The PMU is a PCIe
>>> configuration space register block provided by each PCIe Root Port in a
>>> Vendor-Specific Extended Capability named RAS D.E.S (Debug, Error
>>> injection, and Statistics).
>>>
>>> To facilitate collection of statistics the controller provides the
>>> following two features for each Root Port:
>>>
>>> - one 64-bit counter for Time Based Analysis (RX/TX data throughput and
>>>  time spent in each low-power LTSSM state) and
>>> - one 32-bit counter for Event Counting (error and non-error events for
>>>  a specified lane)
>>>
>>> Note: There is no interrupt for counter overflow.
>>>
>>> This driver adds PMU devices for each PCIe Root Port. And the PMU device is
>>> named based the BDF of Root Port. For example,
>>>
>>>    30:03.0 PCI bridge: Device 1ded:8000 (rev 01)
>>>
>>> the PMU device name for this Root Port is dwc_rootport_3018.
>>>
>>> Example usage of counting PCIe RX TLP data payload (Units of bytes)::
>>>
>>>    $# perf stat -a -e dwc_rootport_3018/Rx_PCIe_TLP_Data_Payload/
>>>
>>> average RX bandwidth can be calculated like this:
>>>
>>>    PCIe TX Bandwidth = Rx_PCIe_TLP_Data_Payload / Measure_Time_Window
>>>
>>> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
>>> Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>>> Reviewed-by: Yicong Yang <yangyicong@hisilicon.com>
>>
>> Thanks for the driver! I finally found some time to test your driver on AmpereOne and it seemed to work fine.
>
> Glad to hear that. Could you please explicitly give me you tested-by tag? I could add it in next version.

Sure, I'll reply to the cover letter mail.

>> I had to do a couple of changes though such as adding Ampere vendor ID
and support multiple PCIe domains. Given your driver is already in v10 and you have got quite a few reviewed and acked bys, I wonder if it's better to add my changes to your patches or me to create new patches on top of yours? I'm fine with either. Any thoughts?
>
> I prefer new separate patches, so that we can review them in a new loop.

Sounds good to me.

Cheers, Ilkka

>
>>
>> Cheers, Ilkka
>
> Best Regard,
> Shuai
>
--1372433909-1567097883-1700095699=:2142--
