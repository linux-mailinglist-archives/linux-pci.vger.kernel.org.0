Return-Path: <linux-pci+bounces-603-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A89B8081CD
	for <lists+linux-pci@lfdr.de>; Thu,  7 Dec 2023 08:24:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D1FD1C218FB
	for <lists+linux-pci@lfdr.de>; Thu,  7 Dec 2023 07:24:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE894179AD;
	Thu,  7 Dec 2023 07:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Bs1Yhx2O"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2051.outbound.protection.outlook.com [40.107.220.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0679137;
	Wed,  6 Dec 2023 23:24:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QRdHhekgzKGQxVWNYjJvxoDIdb05+EXjx7eum2BbplSlu7oE0EmbRa90DpBh9aS7P41DaDkr3+eQSJo89lqaqB89c5ei93Kr+63YcFMo4JH8L1uws3YIVun5O8uZHAeS2oUgul7R+nW0GNeWoBF5PF0iTSe8F7FZTkScQCvKyNpAq/y5giIekzXdk567SPnwWzWM0Ed+BkcirXVHZt0rr8oETLh1fB84C4MSdsYPUdO/b8k6e5CKHrj1SZ6Upl+weCO4EHU4twn1pSwKVCcpezkdREL7KKhtuwHKb09yKnDNazfN57hkiXgVnhoasVHd7gg8dKjyMtbhGXnyShRzmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+8Cbt8nvIbMcjXSLbl70zjwu+kqJsiOXYMoU0yD4Ezw=;
 b=L9PRn7Q6T+ql786GXkx1r20KiEIdyKfFb2zWlk/BeKffZPf1jGTXKzsaKVvNubp9bjKX4WBAENZvfipMRUghRvqJCMqL97qNCbw7EAtvnVS0mbqS7JuDJ9lCwabBFtAXovDGY77s9Sf9dOaxaVQJIFDPD5JCIhkDs0s02M1L8UapdlewPRZrI5Rq61QoUxnD4C3G82KSLYlnFwhrcFEbTJfUqYMdoOqKZQTpectNS1Jao3XV5x0RfjJcYgfEbzzyyA9XceU8bz9iLS85UK32wet+r3+Xr6q94vxrsF68Ra/GLBGi0/RxfZvXlIrTH7FGC7jlmx+/CE60mTQUZQwgEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+8Cbt8nvIbMcjXSLbl70zjwu+kqJsiOXYMoU0yD4Ezw=;
 b=Bs1Yhx2Of40OMbcYBInZBp5gvGynXfS0chnoY9N4Jyx8Mj0xB1VEbaHRJDqkmPb5cxvn/MiHR3qQu97rxAMruvVqKDsHLdGqiZ9rkWDtP9EGQAaA24QVmY2Sco5vB9B8PnEX9zoxJLj0ClfsSKkdV4aw8oEpS1QnjhG17hpt5WXSCmNvFk4VwgIIDpVZ0vU9w2DS1ZYczc7SgBKx0/m1pjhtd0lbAYMLCezFxzZ5WSiUX1appd6p9jAcS+zlTCTSmQNOkvu1vOXjWvqw5z8ZjqsMGFEAx8JwKqQdP8boQ6kK349qcbXok8TBiaXdSrTUKuzRRUW00rSjZDhT1fMB1w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3356.namprd12.prod.outlook.com (2603:10b6:5:38::11) by
 BL3PR12MB6596.namprd12.prod.outlook.com (2603:10b6:208:38f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.25; Thu, 7 Dec
 2023 07:24:17 +0000
Received: from DM6PR12MB3356.namprd12.prod.outlook.com
 ([fe80::1a50:8e27:5f8f:7c4d]) by DM6PR12MB3356.namprd12.prod.outlook.com
 ([fe80::1a50:8e27:5f8f:7c4d%5]) with mapi id 15.20.7068.025; Thu, 7 Dec 2023
 07:24:17 +0000
Message-ID: <c86e8f75-f74a-491e-9ac0-2431a6ec4b80@nvidia.com>
Date: Thu, 7 Dec 2023 12:54:04 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC,v14 4/5] arm64: tegra: Add PCIe port node with PCIe WAKE#
 for C1 controller
Content-Language: en-US
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: bhelgaas@google.com, thierry.reding@gmail.com, petlozup@nvidia.com,
 rafael.j.wysocki@intel.com, lpieralisi@kernel.org, robh@kernel.org,
 jeffy.chen@rock-chips.com, krzysztof.kozlowski+dt@linaro.org,
 jonathanh@nvidia.com, dmitry.osipenko@collabora.com,
 viresh.kumar@linaro.org, gregkh@linuxfoundation.org, steven.price@arm.com,
 kw@linux.com, linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
 linux-pm@vger.kernel.org, vidyas@nvidia.com
References: <20230208111645.3863534-1-mmaddireddy@nvidia.com>
 <20230208111645.3863534-5-mmaddireddy@nvidia.com>
 <20231206153627.GJ12802@thinkpad>
X-Nvconfidentiality: public
From: Manikanta Maddireddy <mmaddireddy@nvidia.com>
In-Reply-To: <20231206153627.GJ12802@thinkpad>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BMXPR01CA0077.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:54::17) To DM6PR12MB3356.namprd12.prod.outlook.com
 (2603:10b6:5:38::11)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3356:EE_|BL3PR12MB6596:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ef0069f-8d71-4fc4-7bbf-08dbf6f58524
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	o739r9IuClSeobdMcsRG0rvagSktM/Gkt8wZNswCHJokpRjsbx8EYSq4lw6HX3Pfa2+2F4xZ5lgqAh/Ez1dYI+pasvIryy0/5ITXmeJw6WGVCENC2EQa7hIRcKXw2I/gJhG20Kd09WSVT+1OIBa11n8iY6xnzUEZ4eH2sCgP40gr6PH5fdNuDffNAuT3JVbdXODt7mfYM3TNlz5fT1MKzKxVFTo8FWO9sbG9B/VVVYJfrcnVp0qU85AEt1ZrUyMT9ZBcS5+7FFAiFKNXvgMwrw5yMxfbsjdO4w/L+OYuRnbghBn/Ev4jwbvcblxWDLsgB8JtRpMIQX4tG53sqUS8lxvl0sdBGo82HiXPkez/Z4NZ5O/eZ8ewgCQFgkkSfBw16Sypg2TCxnjErN1Mc9U17p6ZuqHwL5QPjtiFpg7MnftARuVbJkz9QtZLyDiGL1+IvDEpzOS+bDsYcFgS2Mjk81ISXoL3XWhDWt+kAehVwsldrQZCOV5tW2e6zHdDr+pSNY1uVXzMESn4zpSEXglg1nmw92W3VS9ecWaoPT6sBXnZkctn5puhvnbjrAD0dXi1W8HadMnPVaKGBIsZjttdJJ4DM1Y3Th0hdBOsNewQC4zS8WEe7UUCvmegtGitqtCqDpu1avVLJRRaQQYf+UZMZAEd4Hp1AHOT3xRIBslATNYhkf/dCk8QeDjg9lQKmSvsDKMOEX3cYuCm6dTMRnr93/eQpDJLkbNYrJoSfBZ+Kto=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3356.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(39860400002)(376002)(346002)(136003)(230173577357003)(230922051799003)(230273577357003)(451199024)(186009)(1800799012)(64100799003)(4326008)(2906002)(7416002)(5660300002)(38100700002)(8676002)(36756003)(41300700001)(31686004)(86362001)(8936002)(316002)(66476007)(6916009)(66556008)(66946007)(478600001)(966005)(31696002)(6486002)(6666004)(6506007)(53546011)(26005)(6512007)(107886003)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NjVoTDJCalFxTTFpZXpLa05GeEJEbWtXTEpNYzk5MUhIcDJiZVkxa3ZnemxE?=
 =?utf-8?B?azZDMERidjNtZWNtaVlLc0M1ZmlpSkY5ZUVGV3BnTGpLSndsNjNtTnphMFlQ?=
 =?utf-8?B?WHYwdThZSXg0dVIvd2NOdHFiQ2F3UEE2NFFwOVJLYnlsZXRUbFpjUFpUaVVx?=
 =?utf-8?B?M1pyRjZsckhMWGltZUZJdEpCZDZhRVRwVE1ieEZLUU14QkRYRHFNRWY3VUta?=
 =?utf-8?B?dXR0bUxna3ovTkxrQkpzeG1FNXFwQWtRZHZXNk1YbHBHWlZ4YVQ3K205Y1JX?=
 =?utf-8?B?Z3MzbHBuRkp2aGhOWnUxQ1BPdjVGSWRwdGkvaUt2NG45NmtWSTJVNGI0RitT?=
 =?utf-8?B?c3RSSDVxeDEwdUdoUVZFZE1Zc3Q3bFkyRnhJM3FablFBbEZXOWpJbzdZc1VE?=
 =?utf-8?B?Vy9HNUQ3dzEzN2I3RW9YNTl6VUZpdlZkTXk3QmRQcTEwc1FwYUwrVHg2emNi?=
 =?utf-8?B?NzRmemxxWFRFUzM1L2F6bDA4WEJrclpWS0k2UlVRUTlPV2FGVWpRbGNic2s3?=
 =?utf-8?B?NWJWbUNRNGJUMGtya2Jlc0NKTW1pa2FmMmVieFJmZUpCOElBWUQycnJmU2pa?=
 =?utf-8?B?UVdBWUlYWW8ramN4QWtZYzVHbmhNY0lUWHMrb09mSUNiMmZnODNWMThmVTdS?=
 =?utf-8?B?REIvODErMU44WW5TRUNRRWtMTWwrLzlWNTF2OVpkU1NYWThsSFhNTFR6Vncy?=
 =?utf-8?B?cGJMQlRyem4vRnBscFFLYk9NV2tnYkVrMzZwVU9aU1hUNXlNUXhOTmN4bjFS?=
 =?utf-8?B?eGZoL3JLSm5aeEJzOG9oQ0prWEhPWWk1TitlNUozZUJiRkhqYkdOQjhKazA1?=
 =?utf-8?B?VkFBenBIZnNXVTByQzA3Y29DSWorSHNibXlVbks1Z1lpdnVqMjZjL0NHdkZx?=
 =?utf-8?B?Tyt0YUN0YTZqL1pIMWM5cWo4ZldYUUM5RGV4RnBNV0xtOUI4TVltQTFYOXdU?=
 =?utf-8?B?THJjU2tmazMwcTFSMWtZTmNpM2t0VUZvWkpFd3dFZ3NZaTI0ZkNsbktoYXNs?=
 =?utf-8?B?RXYzczBJSURkQ3lFeC9DeThEczFnU1k2MS9WbGlmQWRBL2dmZ0xyUmNyc2lY?=
 =?utf-8?B?dG9uYXI4Mk1iQVlVcjB5Q2taUUxZTVk0dGwwTzBldlVSbTl1N1V1TkF5VlhI?=
 =?utf-8?B?aDFOekhqd0VCQzczdktQRkY3U0tqSVBhSVFQbytoSUx0WXBxTVFPd1Vyc1lt?=
 =?utf-8?B?d0NJMHVwNk9UVzJ0NkhaalVQeWtVTHVEMW9sMitpcFRVNDJkZUZJMldwSUxa?=
 =?utf-8?B?eUlQa1VoazI4c3ZNeGlyd1RIcnNRZGtqblhkVktlbWdMQXBNUWcrem1PYWpa?=
 =?utf-8?B?ZU9JZ0JqcnA5T3BhMktJMWNCQW9yK2pMUGlrT0hDb0gwSnE5OUNYaWZSMCt3?=
 =?utf-8?B?dnRPeUtyOEhkQ3V3NDNTeEFhVGkyNVRqdU12c0xLRmUzV1lPU2xGUW95M2hT?=
 =?utf-8?B?TkpMUkVRNzZQUkh4ODVEcVBtMyt3WUs0Ymh0NWx5UmRiK3lRV0lCSEVKRTJR?=
 =?utf-8?B?a3BONnRTdFpkZ1JCczBNeURYYlN6d3NnZWJoM1Blc2dzYktUZ0ZJVmdockUr?=
 =?utf-8?B?SVA1eXlyUm1OellFQW5NQnVvNGRBcXJzVlpvUE50c3M0ditOdXl2UWpyRGJ4?=
 =?utf-8?B?Q1ROMHNTQUlZRXBRMlUwcCtKMTVacXc5MlAxcEJFc1NEbzRXUWk1MHozSnpO?=
 =?utf-8?B?akRUSUwwK2Z1TjNMK2dIcGt1dDNHYmpCUmNMODBacmVaTzF2TnhtVlR4QkJx?=
 =?utf-8?B?WDc2ZFM1a21Ienc5MDhqMWRXY05PbmJLRTFYaWtSSFJZaFV0VEptNjc4WTZG?=
 =?utf-8?B?VGpXR2NkNWRrMjV4eWw3NGZYKzJnbnNzMDFGczl2Y2RHMlo0N3hVQytuUVMr?=
 =?utf-8?B?aklkMkFWcEIwUjhVN05EOTFJTU5MU2ZxSzFiZXNaZDl5NXdVeVRHK3RYSTJz?=
 =?utf-8?B?REVtbFEzVVJ5OTV0TWFtcy9PSjhjWXRlSXE1a3dRUmJDTWNMQ0k1SFRwQ3Fp?=
 =?utf-8?B?S1F0bllia0FpVG1LSVVNNW9WMnNGWi9OaTZ0QzFDblkvdWZxZjU5NDArNno1?=
 =?utf-8?B?dndPeTYvTXo2dG40bEkxdHZPQ3g2cmpKWDNHcFlNNElaVDlvQnB1a2hCL3Ar?=
 =?utf-8?B?Zk85VUhlQTBjMWZNZnJKZGwvTzdpUG5FVGNlSmNaY0hWa3lDMTlrL09XSXdG?=
 =?utf-8?B?d0E9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ef0069f-8d71-4fc4-7bbf-08dbf6f58524
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3356.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2023 07:24:16.8525
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ln1NckxrWl1iR8lrS/HVLzOBjaznlNKaUyyNcWisvHX87Mp/xyn7MhIpSEzx44pIy8xlJS2if+8esPipv819oA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6596


On 06-12-2023 21:06, Manivannan Sadhasivam wrote:
> External email: Use caution opening links or attachments
>
>
> On Wed, Feb 08, 2023 at 04:46:44PM +0530, Manikanta Maddireddy wrote:
>> Add PCIe port node under the PCIe controller-1 device tree node to support
>> PCIe WAKE# interrupt for WiFi.
>>
>> Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
>> ---
>>
>> Changes in v14:
>> New patch in the series to support PCIe WAKE# in NVIDIA Jetson AGX Orin.
>>
>>   .../dts/nvidia/tegra234-p3737-0000+p3701-0000.dts     | 11 +++++++++++
>>   1 file changed, 11 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/nvidia/tegra234-p3737-0000+p3701-0000.dts b/arch/arm64/boot/dts/nvidia/tegra234-p3737-0000+p3701-0000.dts
>> index 8a9747855d6b..9c89be263141 100644
>> --- a/arch/arm64/boot/dts/nvidia/tegra234-p3737-0000+p3701-0000.dts
>> +++ b/arch/arm64/boot/dts/nvidia/tegra234-p3737-0000+p3701-0000.dts
>> @@ -2147,6 +2147,17 @@ pcie@14100000 {
>>
>>                        phys = <&p2u_hsio_3>;
>>                        phy-names = "p2u-0";
>> +
>> +                     pci@0,0 {
>> +                             reg = <0x0000 0 0 0 0>;
>> +                             #address-cells = <3>;
>> +                             #size-cells = <2>;
>> +                             ranges;
>> +
>> +                             interrupt-parent = <&gpio>;
>> +                             interrupts = <TEGRA234_MAIN_GPIO(L, 2) IRQ_TYPE_LEVEL_LOW>;
>> +                             interrupt-names = "wakeup";
> WAKE# should be part of the PCIe controller, not device. And the interrupt name
> should be "wake".
>
> - Mani
Hi,

Please refer to the discussion in below link, WAKE# is per PCI bridge.
https://patchwork.ozlabs.org/project/linux-pci/patch/20171226020806.32710-2-jeffy.chen@rock-chips.com/

I carried wakeup name defined in previous version, but wake seems to be 
sufficient.

Thanks,
Manikanta
>
>> +                     };
>>                };
>>
>>                pcie@14160000 {
>> --
>> 2.25.1
>>
> --
> மணிவண்ணன் சதாசிவம்

