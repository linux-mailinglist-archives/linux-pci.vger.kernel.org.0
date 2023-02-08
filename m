Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C2D468EE83
	for <lists+linux-pci@lfdr.de>; Wed,  8 Feb 2023 13:06:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230238AbjBHMG1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Feb 2023 07:06:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230150AbjBHMGZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 8 Feb 2023 07:06:25 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2047.outbound.protection.outlook.com [40.107.237.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 441CB4940F;
        Wed,  8 Feb 2023 04:06:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dFAQis6iUkd9h8C4yyOzbkfbc+7aF1VadeB8GDzd/mKNuLp5ifF/8mCYTH2PQd3IeQPjuWz6lPRhc42Gd5dHO8EdJ5Cyv+JynTO5a3GSDpvQ2B3+xwwscdcSd84ePwCK2ma7F1pZJinsVGFMXyFTISp+SF7sbWpQy95WGI5FFy4ZpYqSYYPF1LLnpEiVpbiI+AcYR/zYjHj2RRC1PQhXwjMZHrtVLDLLRIwi1Rik9RrIwtnOYl2TDIJcKjEEsEjXmBmp3cRaoCi7PpdELnBQe6/4Hx283Hsp9os6YJ5aR+xWXD/fensOXvPZnhcIP3G5KAdawNJKyQVwPWxk4kMs0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vbRlxLu3qrsDHG86ELZI7JEdHhyA7IUBBBUQRJDXtGk=;
 b=bQ6Zfmh2GqTlsLc1LB+vJ4pHGqccXIS7iSgMCSbfZdTA42xVhTCQHkj46M6oV6gzzCqkt5bqtLSdYwkNIQTq0FZHsjUaIn9t3CebdfLmQUVCaCD3ckGTs2pb/4el5ctVNYD2/2AHvkC2KL7AQuY0Kotx0ctGrgIeA5vkw0gvJHcHBEG+87NtKMBCKbkJQrt+4tGzlEjAOqjvy+N4m91FCWJa5l7q0cc6+ZSfjZOPeE/lu8D7yGnRk9vRQxeLJdydkmeR6LjfPH8Tn/iA7iVjosW9+gMdKPI5L2Y+kTlXUMgfFN1gm84xiLupmHaFIY1TlzbEa8nC79dbH92yUR3WSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vbRlxLu3qrsDHG86ELZI7JEdHhyA7IUBBBUQRJDXtGk=;
 b=ODBR16A+4ttd6krm2rFLzxnD+892a2jqxTwItcMzFia+raXhNSk0pqvf4zGmRb7S/KHsipCPoN3CsHnLbFfDhuDArkf2EMIjQm12RCgyCP3/C+gfdhX3axDFT8dJTVb7kA5f/GyoOfFqP9IhPtJW7T67JBDUvusRm1TaoRQalWqZfCISOHKVYfEVKdVxQR+nIDZvooSCXLlb1HdRkrgOOP2wadIUwh9cUEUPFqr/iQ/dFXHca8iVlQG1xwMHPBuV2grREr08kPsV0FLvIZNMOXLrFxno92aZ4HEIZ+HIVX9RFMPcnVebLW3UT1PqUePisGFKVhHh/SeUIjRnhorRMw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3356.namprd12.prod.outlook.com (2603:10b6:5:38::11) by
 SN7PR12MB7369.namprd12.prod.outlook.com (2603:10b6:806:298::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.34; Wed, 8 Feb
 2023 12:06:22 +0000
Received: from DM6PR12MB3356.namprd12.prod.outlook.com
 ([fe80::2654:3212:6fa4:ec1d]) by DM6PR12MB3356.namprd12.prod.outlook.com
 ([fe80::2654:3212:6fa4:ec1d%6]) with mapi id 15.20.6043.028; Wed, 8 Feb 2023
 12:06:22 +0000
Message-ID: <2c65fdac-0ea9-fff5-7cc8-bb964cb8fb14@nvidia.com>
Date:   Wed, 8 Feb 2023 17:36:05 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [RFC,v14 5/5] soc/tegra: pmc: Add Tegra234 PCIe wake event
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     bhelgaas@google.com, petlozup@nvidia.com,
        rafael.j.wysocki@intel.com, lpieralisi@kernel.org, robh@kernel.org,
        jeffy.chen@rock-chips.com, krzysztof.kozlowski+dt@linaro.org,
        jonathanh@nvidia.com, dmitry.osipenko@collabora.com,
        viresh.kumar@linaro.org, gregkh@linuxfoundation.org,
        steven.price@arm.com, kw@linux.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        vidyas@nvidia.com
References: <20230208111645.3863534-1-mmaddireddy@nvidia.com>
 <20230208111645.3863534-6-mmaddireddy@nvidia.com> <Y+OJmwo9rnM8Pf7C@orome>
Content-Language: en-US
X-Nvconfidentiality: public
From:   Manikanta Maddireddy <mmaddireddy@nvidia.com>
In-Reply-To: <Y+OJmwo9rnM8Pf7C@orome>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MAXPR01CA0107.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:5d::25) To DM6PR12MB3356.namprd12.prod.outlook.com
 (2603:10b6:5:38::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3356:EE_|SN7PR12MB7369:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b472d2b-f5dc-480d-95b1-08db09cce48e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0Pb+oMc05WTV0JEK/1t1ckYdRxwYpgFIRJCvSY0SZU0bvOhr6roClgq/sv0esHvphu/KFtGjU1+DORbKqCrjREoNx45DGIZ4ZuGLOW/cNEL26N2FkF+QBjvGuBpNm4aJbd9lXhwuRYkL1WmSW15ygoM7VD9nXZDOVMsuilHEnGhTnY0vHojBzIkeJYxE6+ABKg9SxzvWIwCI8B8miIRl7JjMOeTqPmmCHU0F9z/Xwfw0O/8Y/VN5WFQpZIS5l5pBWT0tmFjbbl2gb+iOEwt1D+j0lxSgXMVeG67g7F1PIz0o1IkOkHeBLwD/Om5ep4so4vzPKWYwfI/cONDHcobbEm8P+dvISz36hI/RJwXqQXxrrVssC3H/r+teUpfn32sEIU71MawCx+/rEsnwdPj+3IknD02GVVX43lmZbFgRzcfIfjWUiWa4FCtO7JmzMm/HzypId8yFTdm2gqCSxePW1mLQ20pcSW303ziq5NKnETb+iJ2J0pdNh2TJB2JZgwFszl+dozxj1h7EDhtkFQ5Z3Ysh5lk8MfVFvTEUH0BqC+/LJavaqB41hcNysotVckFRMkKoxcY1BMLi/h1ecHO83b/xWurgBhS6Yj6KqF2fzpJDAgO06yQJoIIOhl2LYPB3/1VrvJhIOxvpgmVq2JG241J5s6IdzdwCLrpnFGEeWGuSeyqm3cimiChKyVqNQSQwMv9A1GBDRnWX9tHeYV6fyjrmWVWuc1yvNOvUn4DRVBo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3356.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(39860400002)(346002)(376002)(396003)(366004)(451199018)(66556008)(4326008)(6916009)(8676002)(66476007)(66946007)(6506007)(186003)(8936002)(26005)(41300700001)(6512007)(53546011)(478600001)(6486002)(86362001)(316002)(31696002)(6666004)(107886003)(2906002)(5660300002)(7416002)(36756003)(2616005)(31686004)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YmhqbGw0WEhkaUlFUnBVTHl0c3dwaGxYOTdMT2UvTGlTZGZjazJYN1VtU0lZ?=
 =?utf-8?B?SStZOGFkZjRIdy91STRjM1FyYklXT1NRRFMrbU04eldZdjFkZ3hBc0ZVc0Za?=
 =?utf-8?B?TWRuL0RUclFWNkFuYWNQT0FHSUk4YUlqR3Y1SElKYzhPV1hnNlM4NFRsWS9Y?=
 =?utf-8?B?WVFpMkZBWWRWeXJXVHJBeWYzT3NJVzRlMzc1aUo3YktnZkRzaGo4K3hJUlht?=
 =?utf-8?B?QU1EWVN5ZTQwN09BdlQwNFJFREw5SmxIRDlmOTZzeExVSDluWHd4ajBqQTFX?=
 =?utf-8?B?Z09BR0cveDZlcWNjOWtGa0dwbVM5alRJcC81MHJBOEJ0azF1WTlmTEFIN2NX?=
 =?utf-8?B?MWRrVDliMUNaSlRvb3VGRHBBWFJUaDBQb3pSdDJldXZoSDQ1enI1K21IYlJ1?=
 =?utf-8?B?YmJEV2lWOCt4TkNOQ25yM1NES0NrTVZoL3BRdDd6WlRnaDI1WnN1THVlVFB4?=
 =?utf-8?B?ZUljclJoelArSzZhejFzbXBXN1h3L0haVHJhM3VZSncrZlV4R3g2Z1AwdWZC?=
 =?utf-8?B?KzhldUJmZkZpWGJRVndpbllRQjdFQmpUYmhUdEsvem5DdThycmRRUk9iNngz?=
 =?utf-8?B?M3pxVjhZZVgyUHFGd1ZFaG9ZVlVTdGpIVFNDd2g3NWRqNWhpcU4yWnpqZk9B?=
 =?utf-8?B?WElPcVBMNmN4Y2FnKzlvaGZLdUlsY3ZEd09xaE9nTWdjR3hjS2NJL3UvWWhR?=
 =?utf-8?B?QkttMmNQMjNyQW8xUVU4OXkxZGdPY0lOeWFTQU13RW1iS0F1MXA2M1VCeUxt?=
 =?utf-8?B?R0ZyTkF4QURDM05aZThlRWtTMm83Zy9ZcUhrQVFQdFVpaWtXZTRJUTR5T1Rz?=
 =?utf-8?B?ZXcxckxwcUF6QXpaaGNNQlVJc1VpU2NIbENUZlpNS0RFcUJ0ZU52UW1xRlVP?=
 =?utf-8?B?YUZEUW14cXowK0crUXp2a0o0OS8zYmhHbzVRTTV1RGY5bDZrTy9EYzlYN1pX?=
 =?utf-8?B?RHIyalQrNEhKVDQxL1ltNWVNenlkdVZmTzQwL0RWZ1lPeDFtWkFCZFlmQVNz?=
 =?utf-8?B?aDJOZmdGNE9kUmdoZ0dCcEZxZ2lpemd4WDJQMjlpTkpXUmNoOEFwY0Q1UHdQ?=
 =?utf-8?B?bHc0NEtGRVhpV04xT3d0K2hOdWR3aktzd1FrTFJzanZDR052TW9lc1NKbktX?=
 =?utf-8?B?WnF0WUZ2YXBTb0pVbGY4OFdkazV6VVZ1dEZ5aDlQSTdtOFpNY3BHZHRONVIv?=
 =?utf-8?B?YjBGd2VSd1NGT3dGbTR4dUJhL1krdGIySkczNlI5Zy9TMHR0UXc2Z0w0eFVU?=
 =?utf-8?B?S2g5cW9jUHJURW9mVlRLMFVZT2s1MVdMek5Ga1NobkRVZmJtODRyLzk0N3dX?=
 =?utf-8?B?VGtVc2JlQllDTEtRdEJmTy9jQWNKbVNNOEg3bWhLQUs3d1lQbjByelU5N1hR?=
 =?utf-8?B?ankzQzJTcTZ4L2N4NWJkTHhGNzVXTGJkbUg3eE9wV0V0MEJWYmQ2cTVVb1I2?=
 =?utf-8?B?TVJSZnRlbVc5NGVzS3BFc2pNQUFDTVFtRHZOTWYxWS8xOExKd3RtanRZUm80?=
 =?utf-8?B?QkRiM0txSXBIek9ZRDRBR3RqckhKSFFuQi94SlJUK2w0ZE1TNHljYTBvbEUv?=
 =?utf-8?B?SFViOHpzZ1ZYcjA5RkNsTFdKNGJhZkRNajk2Y0lWd1NIKzhqSmoza3c2MWZ1?=
 =?utf-8?B?TkdXZzRMZ2VoQUgzQzBCNWIrN1l5Yy9jcEZNZlBoYzRJcXZ2cmtvNEZCOXhB?=
 =?utf-8?B?TTRrUUluNUtvNVh2eXZOcW5uTWczQlZNMDR6UFpLWmhYajBvR3JIYThab3Qv?=
 =?utf-8?B?TE44UHFnYmVmZUFTOWlYVXdFRDNnUTM5WDJab0FqYmRCejEwclRneDllb09F?=
 =?utf-8?B?bFdHRjhNOWZtekl6U21rZTA3RFpGeWxkeElTNlppQU1ZZTBoTS83ZFJiUXlN?=
 =?utf-8?B?ZE83aGJrN0VmZ3VjQmptTDdrMFVwSXNMUVZnbGVwaVhnZmFJZk83RFJEd1hT?=
 =?utf-8?B?NjE5TkpiN2pLaU1Rd2QyYWw1a0ozSEZKWTkzNmg1NmNKajFiNVNzaEd5Tm0v?=
 =?utf-8?B?YWRmWVk1c3E1TzBoYU5zSERYUUJPWGx0RXBXa2NCUGNHVUJTVGlPV2poRFZC?=
 =?utf-8?B?eWgyQURrZUJqQ055a0Y4Z1RaV3VKUlJ2bURsVFRhUmU4ZEFKVHJUUXowcnFX?=
 =?utf-8?B?bzMzRWpuZ2E2Vm1LSmhFZW1oMitaN3QyVWJOTm8wNFFKdTlxOUZuWjgrbW9P?=
 =?utf-8?B?Nmc9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b472d2b-f5dc-480d-95b1-08db09cce48e
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3356.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2023 12:06:21.9803
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NF+8bhRf+K0btKk5Mo+zrlkyD6fpesNGkPppBLNDezv4PCXutxJzeEBmcXYnwVAg3MBdBXbEYx0Vh/aS1eZthQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7369
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 2/8/2023 5:08 PM, Thierry Reding wrote:
> On Wed, Feb 08, 2023 at 04:46:45PM +0530, Manikanta Maddireddy wrote:
>> Enable PCIe wake event for the Tegra234 SoC.
>>
>> Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
>> ---
>>
>> Changes in v14:
>> New patch in the series to support PCIe WAKE# in NVIDIA Jetson AGX Orin.
>>
>>   drivers/soc/tegra/pmc.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/soc/tegra/pmc.c b/drivers/soc/tegra/pmc.c
>> index cf4cfbf9f7c5..139ee853c32b 100644
>> --- a/drivers/soc/tegra/pmc.c
>> +++ b/drivers/soc/tegra/pmc.c
>> @@ -4225,6 +4225,7 @@ static const char * const tegra234_reset_sources[] = {
>>   };
>>   
>>   static const struct tegra_wake_event tegra234_wake_events[] = {
>> +	TEGRA_WAKE_GPIO("pcie", 1, 0, TEGRA234_MAIN_GPIO(L, 2)),
> What about wake events for other PCIe controllers? Do we need/want to
> distinguish by name for those?
>
> Thierry
Only one wake gpio is defined for PCIe in Tegra234. There is no 
implementation
withinPCIe controller, so any wake capable gpio can be used for PCIe wake.
As of now wedon't have a platform where different wake pins connected to 
PCIe slot.
If any platform use new pins for PCIe wake then we can add to this list.


Manikanta
