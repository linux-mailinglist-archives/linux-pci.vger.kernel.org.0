Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBB9E6A53A2
	for <lists+linux-pci@lfdr.de>; Tue, 28 Feb 2023 08:24:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229711AbjB1HY5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 28 Feb 2023 02:24:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjB1HY4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 28 Feb 2023 02:24:56 -0500
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2076.outbound.protection.outlook.com [40.107.101.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40D141E9D4;
        Mon, 27 Feb 2023 23:24:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VoSVsmrqq3icT+1IZOH6LllO/vLD8IvQi8rsRiwqEfyFajDGUHd5sGrK6IAlkepdrYxZDu2LZeaC7FZy9bbdFgDqCsqkXGXRKF9TqCvRlteTv4wAYz8YWQp3VoOOHzfswG4eXgdRIW/A3dH54bS4pBQlih5gclwkcp+q+t02GV6zScmbWx7ncvNqzitEHOguDdQ+idPl6X/T685h7ylxrNF5uyznr2yAbQqWKTq+PzZlnZ5JfwovKhkiSm2LcffGijNGwyHwGlZcBbMa84Un0s1n+XpIcWgsjmzy7D4jDSNEHDmKXiF9bBjA7GrdHOCfF8BQEC+YK93OXPnIX2EmPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ExN5KymGD9/8HV0YcSwkT1pdiSr5xRawbcQ3wsb4DhY=;
 b=OQ7yky9+l+SAmhuIbQI+4ay0TPd8e5PGERPFPVnr09fqZeEf37KwxqRjfkgtn/yIHuYb3ptHn1vSEbhkNCqQ12r9I0a3YqDWSMlBXKAusL19dlplwrcclXwqUP8tRKEj83Bfiyf8ed3rkKHAk51o5sJSXtMEAyqxghLLHxHZica+BvKDorswYs93KurJWdzfauqjnkDLtnuSpr4KvX+pYMZnQbL0czOlLAx7qHGV/ZtA8Y9CEsx3njNDfjFWVvlRIMpBhhbkNEGsDrtpInR2FWE1aCzc69JbqG4DyMWRuMysw2x0Ublz5sBgFOVY1GpcBSCQimDCoYP/1YQ8ohCz0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ExN5KymGD9/8HV0YcSwkT1pdiSr5xRawbcQ3wsb4DhY=;
 b=lLpKx2O7Bg0wk9j/BtXxfUG/K3KVFiZIhppoH/Zr/go0JSm+XWoyq/efvssx8HqJ2JrjueNYztRq4MbmFJkeYoyatIC8veSOCmBaluWPt/mioe6FlPpP3k5qRchs2Op0daSUhkG5O66hSVI5rT1XOBvDWp774yuuftUP47RJAfE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2843.namprd12.prod.outlook.com (2603:10b6:5:48::24) by
 DS0PR12MB8367.namprd12.prod.outlook.com (2603:10b6:8:fd::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6134.29; Tue, 28 Feb 2023 07:24:52 +0000
Received: from DM6PR12MB2843.namprd12.prod.outlook.com
 ([fe80::1185:1d60:8b6e:89d3]) by DM6PR12MB2843.namprd12.prod.outlook.com
 ([fe80::1185:1d60:8b6e:89d3%7]) with mapi id 15.20.6134.029; Tue, 28 Feb 2023
 07:24:52 +0000
Message-ID: <66ca8670-6bd2-a446-d393-3c327aa45ccc@amd.com>
Date:   Tue, 28 Feb 2023 18:24:41 +1100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v3 12/16] PCI/DOE: Create mailboxes on device enumeration
Content-Language: en-US
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
        Gregory Price <gregory.price@memverge.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        "Li, Ming" <ming4.li@intel.com>, Hillf Danton <hdanton@sina.com>,
        Ben Widawsky <bwidawsk@kernel.org>, linuxarm@huawei.com,
        linux-cxl@vger.kernel.org
References: <cover.1676043318.git.lukas@wunner.de>
 <c3f9e24fffa318a045f89664fb9545099cb0d603.1676043318.git.lukas@wunner.de>
 <bc150b29-ee21-b033-7d05-dd28dd7a1af4@amd.com>
 <20230228054353.GA32202@wunner.de>
From:   Alexey Kardashevskiy <aik@amd.com>
In-Reply-To: <20230228054353.GA32202@wunner.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SY5PR01CA0078.ausprd01.prod.outlook.com
 (2603:10c6:10:1f5::20) To DM6PR12MB2843.namprd12.prod.outlook.com
 (2603:10b6:5:48::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB2843:EE_|DS0PR12MB8367:EE_
X-MS-Office365-Filtering-Correlation-Id: f361fc7c-b65f-4405-2003-08db195ce1f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MD+8R+PZKkZZXAhWEwEPyAaLyCk8rJNdpTWJWAg7+xTpSNKgVH5+M85T74jDb9Mn6ZUTIN5au40LqkKuDxVOgjtJ3KNZttxQIhWEgp+OzS+ES/MNoHcpWqS+GNhqdxmoPOZxnbDLm+2vf74wqkSNcNkgsF7p3AIfU7dMFrayr+ElbrQ1/TLVh1HlEbWBJJ0fDFoR+OKsWwNjefI5MbDET3P+AaGirFUnf7EKSH4wrudPBUGj8JIsBxqZh2DTL5iEv7DoN5g4ZJ05UcDmXG1LEIn99gKUgpAKXegzdeon3x0nFUpggXV91akcO9ImbpNmQNv/GlziYxfYM7/9HH+3q5jOoq3DYHJWHemm6dYcr3fKUk5Y8XlYzej5UVOUFw+7/NKFZ0W678iktPo51QwyadvHvjtg0rzoG78oR8/BRF2o6VKrEvOH7/PVQTxnFD+/wxfm9QRQ1ANtn/bt4bnH/nnUU3uO7D1d6OB3zaTtccHs41ZE3EUiKcDWWyzsXG4AFmOsnJ6OqMq5txW5n6renKiWeocJdLvWOk4ZpM1zIQq0HOsjMUApPqduhAVAyqX6jjGVnTZbeNWwV05M+bHZ8jWs90LPqdUWIVNv+ICmUJcwMT1rvLafJBKQQKr3cogpjR78TVzctVVb6XF3wcoAIDro8ZmRluEe88cipIfm9KY6Pz2/Lx6piKTg8F4aWHl/nmtMK0g4WcBzX5NR71z0p1uMDXFI+gq0nMZdiCwcQsQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB2843.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(366004)(346002)(136003)(376002)(396003)(451199018)(4326008)(31686004)(83380400001)(66946007)(6916009)(66476007)(66556008)(41300700001)(316002)(36756003)(8676002)(54906003)(8936002)(7416002)(38100700002)(5660300002)(2906002)(53546011)(186003)(26005)(478600001)(31696002)(15650500001)(6512007)(2616005)(6486002)(966005)(6506007)(6666004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZytlZW1FUlI1anpZNWo0OHNzL3VYYmRHeDQwZG5pbXRmandxcHFZVEpTbldt?=
 =?utf-8?B?WXdhNTI0OXd0bHFBZ0JVNTYrZTNqTG9HWjh0WHYwWjBleDRtdXB3cTJRZ1Bw?=
 =?utf-8?B?RjJwKzEvcmNhaCtYMVlVQXJMeElVcWkxVzgwRVdxenN5VlM4NlNDcXlYUk5K?=
 =?utf-8?B?UnRGaHdGZitjbGQ0bTdFRW0rN1Z1MzdVSmgrTWFkSlZUaVdVYkszRFJDYVJR?=
 =?utf-8?B?QjR3cktmUVlPNFlSRXVtSHFFb0tFcXA1eVlnTU9PVWYwK24wQTY0Z3lnNHdC?=
 =?utf-8?B?Q3dteWJXLzlqZ1EyUitwUjhLSFlSL1BsY01TTk1xRzBINnY3VG5MTjBqTWxN?=
 =?utf-8?B?V3AxUFBzWitZOHAzNGtMNlZ6ZmZjZWExUVBaUUR5RXVOaU14NUhZamdmeHd0?=
 =?utf-8?B?K1FEVDdXL2RJSzFqQ1ZYMkY5L2RHRjZqMUxrU04vUVpRcWFvVzRRaVNDTVpX?=
 =?utf-8?B?dGpNWVJSSVM0L3FOYUUvZ1RYdnJCYkppZUlHMGoySDExcVAvUVRDVUhoZ1p3?=
 =?utf-8?B?T1ZCcVhQM1RnV092dk1vK29VMFJ4WEs2b2tGOTZtNm9GRGFxbVhRajllU1ZT?=
 =?utf-8?B?cEZFbnRnNXN6ZTJlR3hjRFJmY0RCdzJaVnZpM0JKdWtYYVFwenh0bG1HMlV2?=
 =?utf-8?B?ZnpUYWF4ZThSNzEyRVI2aCtjYkUvVFNvQ1JBQnByL2NsZmpaQTBweDdZdldU?=
 =?utf-8?B?ak04bVBESUF5MzIzOE9ZVWJRU3prQXR4Tm5vdEFLcS9ab29NSkl3ZUx5V0VJ?=
 =?utf-8?B?K1ZDYWpVK1VpRjhReUQrWDkvRFZieW5udXMvL0ZKdGxlbktFRGplUmtEakxP?=
 =?utf-8?B?ZmxJYWVQR1hFYXI5WmI1V1MzMVk4eGlJdWpwL21KYTJWT3RhbndBeTExVkRW?=
 =?utf-8?B?SUtSVkNqa2xCampkKzRCMkExc204TXpIc3NLMDBsTWo0N3BOOEdlaEpta2J5?=
 =?utf-8?B?R0g5Ky8xbFExK2ErSmFmb0lMdWloaXZZc0IvZFlXaFlkUVFQM2JPU29MaVNo?=
 =?utf-8?B?YTJvZUlmSzAwTVJaMk1lMUlYR0pHaEcySCtTQk1aTHFGd3h5S2d1WFFvVW9w?=
 =?utf-8?B?MVdBZy9kamFqR1JneHQ3WnI2L1A2aVNtR1lKMG1UWW04TGZaUm1Yc09mdjBa?=
 =?utf-8?B?S3c4OWxGR0RISFRianN1L0swWSsvS2xRTjdOUzV5NzlIM0oyblAyVjd5aTR0?=
 =?utf-8?B?eWtoRnEvdG00S0c2dVJWNlNVbjZjM0F1aFQ4U3hBMEVjQktjT01YSkw4bTZQ?=
 =?utf-8?B?S3p1NGQ0b1ArczY0b0hhbzBwVUVZTUJQZ0lLU09BNXdzdy9wZGhxSERoQ3Bk?=
 =?utf-8?B?anFtYUtsWWxoU2xYYTgyVWU5YW1Da3lFTWlnL2VEdTdjRmVjdC9sQmpoNG1L?=
 =?utf-8?B?VnFhSS8zcitVWk1tdnVyam5PYVhFbW5vWnVDNzlLS2pJSjhJR1k1YTVPeWh4?=
 =?utf-8?B?QkU2MW51OUFpdnF3L2RtQXgwZVA5aTFMK1VmSmE2UHZQOFl1Zytxb25kbks0?=
 =?utf-8?B?bEhremNBYStvdGNOTnRwL3M0MklTQTVnR1dMaElFVXJhc05FdDgzcjFHNFgr?=
 =?utf-8?B?clRnNENyRnVOZm1YZlprN0dON0FScm9oQ25FRlpFUjZNSGVlN0RFSGdLL0pv?=
 =?utf-8?B?RXJzYllKeEZBOFJHQjJJTUl6djVkNndSNHMvRWFuR3V6ODFmSGdRWDUrcVRR?=
 =?utf-8?B?ems3Yk9wOXY1SnJ1aG5RRUNTa3lsTTNpa1BOdHZZVWFIcDV6WlZZRTBOdkQz?=
 =?utf-8?B?S0IzOVVMYVFRKzVtZ2l3TzBNWjQwR0ZpUHBKaDNrOS9YVlBNaENXeVpnTHFu?=
 =?utf-8?B?WTBRRndyRFVobUpkUlhyNGowVForQSsxU2N6S1ZpZ0g5aElIUGhTMjJKUnZF?=
 =?utf-8?B?S2g3RXZQVW41UG1LMnJ2Z0lVOXFpYWJJUU04NEdnL1crK0thWVlISW14cWo5?=
 =?utf-8?B?OWRFWndlNEl1OUY4OFdaekhWRVpKc1VSc0JpOUpDS3luLy95SWRSbXFFYUZx?=
 =?utf-8?B?K3hsbE44NUd5b2JGSDMwSmpIOTQ4cTNaRkJPeGhaM2R1K1RJV3hZeGtiSkYw?=
 =?utf-8?B?bFVhWnlCZjVKSXF6NE1QZGIvMjhzbzFjV0dDZzFiZE1WdGVVWmRmeFRsUk1q?=
 =?utf-8?Q?Mu2EJWFqZkep0SfHSHRcwD1rT?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f361fc7c-b65f-4405-2003-08db195ce1f8
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2843.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2023 07:24:52.5158
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UfiGs2zQpJt/LMALn+6tFw6xdI2a4u/q3kAViuuoS5d+obpneWwuFCAmrcq+i+1h2NL0x0+IlXfQ50CRVYv8ag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8367
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 28/2/23 16:43, Lukas Wunner wrote:
> On Tue, Feb 28, 2023 at 12:18:07PM +1100, Alexey Kardashevskiy wrote:
>> On 11/2/23 07:25, Lukas Wunner wrote:
>>> For the same reason a DOE instance cannot be shared between the PCI core
>>> and a driver.
>>
>> And we want this sharing why? Any example will do. Thanks,
> 
> The PCI core is going to perform CMA/SPDM authentication when a device
> gets enumerated (PCIe r6.0 sec 6.31).  That's the main motivation
> to lift DOE mailbox creation into the PCI core.  It's not mentioned
> here explicitly because I want the patch to stand on its own.
> CMA/SPDM support will be submitted separately.

I was going the opposite direction with avoiding adding this into the 
PCI core as 1) the pci_dev struct is already 2K  and 2) it is a niche 
feature and  3) I wanted this CMA/SPDM session setup to be platform 
specific as on our platform the SPDM support requires some devices to be 
probed before we can any SPDM.


> A driver that later on gets bound to the device should be allowed
> to talk to it via DOE as well, possibly even sharing the same DOE
> mailboxes used by the PCI core.
> 
> Patches for CMA/SPDM are under development on this branch:
> 
> https://github.com/l1k/linux/commits/doe

yes, thanks! Lots of reading :)


>>> Currently a DOE instance cannot be shared by multiple drivers because
>>> each driver creates its own pci_doe_mb struct for a given DOE instance.
>>
>> Sorry for my ignorance but why/how/when would a device have multiple drivers
>> bound? Or it only one driver at the time but we also want DOE MBs to survive
>> switching to another (different or newer) driver?
> 
> Conceivably, a driver may have the need to talk to multiple devices
> via DOE, even ones it's not bound to.  (E.g. devices in its ancestry
> or children.)

Ah ok. Well, a parent device could look for the DOE MB in a child using 
devres_find(), this requirement alone does not require moving things to 
the PCI core and potentially allows it to be a module which could be a 
better way as distros could have it always enabled but it would not 
waste any memory on my laptop when not loaded. Thanks,


-- 
Alexey

