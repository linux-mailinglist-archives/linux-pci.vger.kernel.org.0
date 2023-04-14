Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EACE6E2B36
	for <lists+linux-pci@lfdr.de>; Fri, 14 Apr 2023 22:42:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbjDNUl6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 14 Apr 2023 16:41:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjDNUl5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 14 Apr 2023 16:41:57 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6BF344A8;
        Fri, 14 Apr 2023 13:41:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kVy+3QN6dzyTMdqIcoPs1RajsSS6/KQgwBuU69JIg5tFgDQ558aPDfINZKFtuGFpXZF9EpxdfkJdRRuTSQh4tV+BwZYPWXLJSnUf6YhMbCAGOWoMlwm62MOxBw/Pgx4V2UvajwTtpfWDMlk0pk5l89J8zfCAwhIyh1SIdLPVYcB7rh94Zw6Wx6clqv9Us2E5vkPbrcK1Bry+dSfk+rE2YhKSgptMhc6JPMZnmT6yfoS/vZdb3RRd+bFxENj3Et71NQoT+lbYu9rovZjZH+kFRBEGtfUUhPl3TUqXEFbfyDTTd0MQiO2C9GQ320RQ2ZFj4bU103Mpty2nRe8wJjL8UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VIXDGNruQWBQfHpl/ovgrhuDUFgKfVad/y94o7EFp00=;
 b=DMrAgnu5Yz9JtwlLWWVcdR/LoqQLhmTGn2XzzDFegqHAyQJFflUjBNUGRSeD1ZqhXOME+9LqMUktnl8tntEkz0QItaZ3SyGekaPt+aFw95ly14cEyoc4xle0bv3pgLKLtuNuT3eG4miDJO8JHTYkRjT+dSNzsh5kwzEdcu3djcdc2ehiECWtZuqXTfFppLrrV0wspSuNOtjX32rQYXHoHcGzCeyyGc4Ww1ub0NYRq678nPi+PnEpdfLU6VmUSbrJbIzhBoW1LMkn5Jpr988ZWKmbwXNQxtaj0GI5G+QpGMmvAN8hPaHKmJHow0F0iVwtz5ayJJww6pAFp5VV5A2dtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VIXDGNruQWBQfHpl/ovgrhuDUFgKfVad/y94o7EFp00=;
 b=pYkv6Vmt2gIBR4EaW3Qf2B0CT4IpH5YUTwl4cGC759M4OLVzYicZGnnlFufDByLRS8Fgco4EIfw6gpPWB3ZoKsGJazs6FMJsx1NU7wwQn36utwuKIDsZ0hzYAe45rF38TKRO0Nkg8happA6Ts8b1TjfjxkeAXlxXwsN+mo0FYsY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6390.namprd12.prod.outlook.com (2603:10b6:8:ce::7) by
 SA0PR12MB7073.namprd12.prod.outlook.com (2603:10b6:806:2d5::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6298.30; Fri, 14 Apr 2023 20:41:54 +0000
Received: from DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::48cb:9d06:e70b:4b42]) by DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::48cb:9d06:e70b:4b42%3]) with mapi id 15.20.6298.030; Fri, 14 Apr 2023
 20:41:54 +0000
Message-ID: <1e93d649-c892-1992-2b38-93fa9ab3041d@amd.com>
Date:   Fri, 14 Apr 2023 15:41:50 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2 3/5] pci/aer: Export cper_print_aer() for CXL driver
 logging
To:     Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        alison.schofield@intel.com, vishal.l.verma@intel.com,
        ira.weiny@intel.com, bwidawsk@kernel.org, dan.j.williams@intel.com,
        dave.jiang@intel.com, Jonathan.Cameron@huawei.com,
        linux-cxl@vger.kernel.org, rrichter@amd.com, mahesh@linux.ibm.com,
        oohall@gmail.com, linux-pci@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, bhelgaas@google.com
References: <20230323213808.398039-1-terry.bowman@amd.com>
 <20230323213808.398039-4-terry.bowman@amd.com>
 <f31edb04-04c7-2d98-e3ef-a591993e7ceb@amd.com>
 <ef57e100-e656-d692-b776-3f6e3f242c15@linux.intel.com>
Content-Language: en-US
From:   Terry Bowman <Terry.Bowman@amd.com>
In-Reply-To: <ef57e100-e656-d692-b776-3f6e3f242c15@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BLAPR03CA0123.namprd03.prod.outlook.com
 (2603:10b6:208:32e::8) To DS0PR12MB6390.namprd12.prod.outlook.com
 (2603:10b6:8:ce::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6390:EE_|SA0PR12MB7073:EE_
X-MS-Office365-Filtering-Correlation-Id: 1bf58b6d-1f0e-4b12-fcda-08db3d28ae94
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QrfmbhfbBI/ZfEPkkSgNAJLKXy5RoApQxAOtgd/0Qq9HUdjn5BGKZ+OjixIIKt9n1Ie+5ukVt6buW1KizkulzKozC1RAvsVyXcL6U6l1eEhfMLXu3a2mpzYWAriAFdZLhpScDEX0ntIRiCFQXGj+k+Z6Wmc4UKie0obNFmXq/IXyhA/HrZ6mv5NYggnGnhyRNct9fOGW+rWvuAxYZlGraOZbsBglsjXlWa97tXpymAk31Xw0MvlA5pdSIGBcOVkM26w90o+keISwC9ccORLkMNSfWcvvawg7cUdjzQIelYChGHM7xEqQ94IOo8GDG9ZEck86420mfXfT1XYo2NFdF+ol8zb+Rno8jgWw2XJGkJlYTPdd3eqjtNefs/9w+BU/5weU8eRLMaPfq1qQNHAwtiZ6LgCbJADiJaiT5S0Cd08c9e5xRu6hsfUKZaf7ll2kYRNfTjuH1yp/BzX9naBzIE+IGA4SMC6P4v7AP7p4H2CsiFm5Ff1tqnGuSZkC0ZOM6cID9lXVcTlaOIharYKGfJTg+Sn5isdSc1p852lajJt+IRmcxsCqRgpBoUVfDQUD1ptp2ADk91YJCGSjB8Pipmg4Yq/1tp2O0C4EIgN+CW2upma8DIfTA7xMT5XqiHtB0lXqXdi3EaR3FAgIkovQbNiG8b5m5egcuvPPqtT+JXY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6390.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(366004)(376002)(346002)(396003)(451199021)(6506007)(2616005)(4326008)(6486002)(6666004)(478600001)(186003)(6512007)(53546011)(38100700002)(2906002)(5660300002)(316002)(36756003)(66946007)(66476007)(921005)(66556008)(41300700001)(31696002)(8936002)(86362001)(8676002)(558084003)(7416002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aHdiVGlaWkRpSGt4MDdORmlGRE1yUWozc2RLY2NqQWpwdlEyM3g5b1RINVRh?=
 =?utf-8?B?WG9aR1RHYVBSTUlOVjhzYXRDcWVZUVR5THBySWtTTURsNlQ3L1lEblRKT0o2?=
 =?utf-8?B?bXJwNno1WnNlb1B2VzIxa0xUcTdPMGExMmpQWHB1ZTJRbXdZU0tRQm85TzNU?=
 =?utf-8?B?OXVJVU5HWFpJaE1FRXdUNU55TWw5b0dqMFpUdDV5TE1TY0tjeS8rcGtuR2JX?=
 =?utf-8?B?RmJjbHVwQ0lYbXludjdGSEtzM2R6eEdlbTBQU0lWOUlOd0FCMXpaRmpINzZL?=
 =?utf-8?B?Ym1SZkNqTThmZCtKa0RJbVpodVQzb05MMmVLR0xDOE04eitSbnRYRVVlMmth?=
 =?utf-8?B?ZlFyYTV3ZmZwZTJBRjVNSXQvS3ZuZngrSnZLL1Y4MlpmSW5XWHFqREU5Vy9h?=
 =?utf-8?B?UktXRTNBYjJZZllXdTYrc09lWDlVYnhjeGFyMkNEYUluaGVIY0JFeWxwZkJk?=
 =?utf-8?B?L3FKK2paQXdIZmROdEZJVzZVRThMcGwyZFFLbUFqc1ZjOStFa1RoZWJWQ2xl?=
 =?utf-8?B?MlpaVzM1UU5PM1J5UnNqV3plSzJwcUx2MXlSNmg4Q0xxWFJGb2ZYMmxKcGlR?=
 =?utf-8?B?QXFjbXNicDlMUXI2STd2emp1bG0wOGhWL3B5UWs3VENId29sWHRJK3NlWUQ2?=
 =?utf-8?B?YTIwNXNrRHVGSmE5VytkU3JmTjBSNDh6N1JzK1ZaS29WK1JzWEtOaDZLaEtu?=
 =?utf-8?B?b0ZlU04rSnpkWkxMNkREczhrZkp5NFBVRkNwSWdlU21ORjNYOGNaRzUxeGhn?=
 =?utf-8?B?WnJnQUtoZGtoc1h6clhzZTNSVStiV2h4UlI3YlpDR2QxbEZoakNtdGdKU2Zk?=
 =?utf-8?B?TmRyRCszQlk2WGl4emFSbkNZUm92L3AyeHpoQUxZZ0ladlZQUGlEQ01WY2sz?=
 =?utf-8?B?S0lUZzk3RUNEYlIydUJReHp4WW5qNTBpaTJrczUvQWYxMTZOd2hQZlpVS0k3?=
 =?utf-8?B?dHdadkxvb2UxRldlY2hvbm5rcDFCWFgwdVRXTW9qdW1EbzlJTFJqVWcwWjRV?=
 =?utf-8?B?KzlKdVR4K0U2MGx4THc0eEVld0ZQNy9URWc4bWwzNi9pSVY4Q1VVSVc2QStH?=
 =?utf-8?B?dDYzVWZnYkxRcUpSR09JNVMva1R0L0F0RU9pWkR6blV0b0g5Si9mVEw0UkdP?=
 =?utf-8?B?dWlvRVhXMjhFdHNsblp0RStGVkJ5bkdZYVd4akJBRmtPeElDNlVsa0FINlNO?=
 =?utf-8?B?WmJ6ZzVrczFhajNEMENZTkMwejhGeVpIbzJYcXYvMnBHWWllWWhxTEY1VVln?=
 =?utf-8?B?NHVseW5FS25tVE1yNzNIU2xvTWZzalRsTGZlRit4MVpVaWlFdGtmUVBScStG?=
 =?utf-8?B?RXBRSUhmZWRDaUtuS1gxRFk0Q2duOUFlYVZ2SVRHRHdlcXl3NmlWV1lJdjVu?=
 =?utf-8?B?ek8wVUVyd2U2NDc2SHJ2UHMrWW9kc2Q5YW42Y3JpVkN4U2Nzb00xcFVWY0wv?=
 =?utf-8?B?dUYxRHdENTlpUkVmWENNQ2o1c1BaL01ReWR2b1M0ZVpVTjdncUV6bEl4bHNZ?=
 =?utf-8?B?Wmgya3lDTXViSnBDcS95NFprR3p2bW9aVUthV2hTbFVuS0Yxc3lvRDdUTml1?=
 =?utf-8?B?Vkdyd3FFRmRjbEJWazBaOGdnaXNPaXpZVktVR081NVl4TkRrRDJHOUZjcklz?=
 =?utf-8?B?RE42LzJvVFhSVjVOaTE4Q3ltWXptbmdvNWdMMkh4OGMrZStQK3VCK2Q3TnRR?=
 =?utf-8?B?TGl4MGFSVzN1L3pQU2hUckgwVUswTTdEWUZLZUxnelN0aS83T3czUkNFOTNK?=
 =?utf-8?B?dUlmN0pyRUkzTFlaUjRFRW5VSU82U0p4dERmZGxueEZNaUtDUjVFTVVEejkr?=
 =?utf-8?B?OWEwM2x2Z0JLOU9RNTJyaVMrRjg5Y05Md0h1RmRqeFVFclpVRXp1SUE2YXFJ?=
 =?utf-8?B?RWRmbEJpdnhmblFVcUlTNmRaUDh3OTJ3aC9NbGtrR1FPLzBDR3FtenEzWkJN?=
 =?utf-8?B?Tit0d2lVcHpQem9xdmZtczR6bDlIcmcvZFkzamhUQVR0S1J1dCtLUVl5cjYx?=
 =?utf-8?B?WHB4bzNSZnhzTk1tUlBaYm1vVEF3RFlCUUFzVnZCMG51dWVBalJZN3dtakIw?=
 =?utf-8?B?bEZSU1pnVFQzcGNpQ0hSS3U4bFIvT1BKeDhWeDFWbDJrYlBKYlY1cHJJMTg2?=
 =?utf-8?B?TWZpWHZDd3A3RFE2WkdqTnVQSmN4Ym5lRUNuNlpxczE0djdxVTRSQjlZOEtQ?=
 =?utf-8?Q?LG2uHG1UpIhjocSCW0fz5Pyk8VhPgM/zg1Yh+T4ST63p?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bf58b6d-1f0e-4b12-fcda-08db3d28ae94
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2023 20:41:54.3958
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Lc4t6sWQrQhZV0EZEqc5ogsLsFmD1jncqSiT8wwqHR9AQ9MlRtD8FZ/evCZXcJBV/NF8500KrrccATWG/4hp0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7073
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Thanks Sathya.

On 3/23/23 17:26, Sathyanarayanan Kuppuswamy wrote:
> Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
