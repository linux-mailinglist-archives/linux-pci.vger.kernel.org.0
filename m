Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F641770561
	for <lists+linux-pci@lfdr.de>; Fri,  4 Aug 2023 17:56:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230448AbjHDP4r (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 4 Aug 2023 11:56:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbjHDP4p (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 4 Aug 2023 11:56:45 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B671149F3;
        Fri,  4 Aug 2023 08:56:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AMe5FK9k+YG3a7Gwq7j4mcPUgkN+RYQ+UzlY1RsfcuQcpRue6Z/CMxFKqLRc6aODivWKu++ssjJtvzVx5V2DOW8Fr1RpOLrGS9v2H70kR6XgxBTC5GAD9UCwSr3b1BCWxR05qjMPQA9XPuzX5JTP00BwDF4ubH2xipgiddlvpSjKDjp1mD7Gm5e5omLYOaMmn/mNA5ntkRAt67Oa4TQVKcQWAXp31erhb8cxyCR++IP3OHy4P9TsQvAabyhQmm4Q4QR36GwYbSnTaKtF3ahii2JHaXmdiXuSG8VK7PVWxu1WwJTymT+pxcovtxnhWBxjZGoReK2ALlMuyuLsyzQ2Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iGyHlrY26NOtW8Q+AU7012pNh9a6dTzGtY385euVTe8=;
 b=MhG5xjXXTdCJlIrNA4iYUOlyoA55PjhkYtV3lsW9DN8Mh5ftWyGmis2Dg9jV/jcKCKilTdlMXtGI9IA4TX0KLWMQ7zONG5psOi/TwZmfWPE1R8AqSH2Pyw5Jmags/I0IN39mPoq2wx0c26FV173R5RYvH/pTZ0Z3YnbV5SgamAJcT6q9W3YNAFOKMU0x4mmRz2p1SvRWdomz4J3GnhbWitAeoup91igUungluMK3/sWCZafvXiC/9ink85veC/px0PQjd1Q8T6S21uureeUHW4iF3VT05SBfZxoSprDTYLY6WvK8d9K3LCIs1oBnqxNDXrq7QYqEAn41lPHR0tULtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iGyHlrY26NOtW8Q+AU7012pNh9a6dTzGtY385euVTe8=;
 b=iF2hLsopvRGWV4G8zlsF71OOaM8Rod2d0TsiEpYjGP+Sr5BFjX5K9E7KwdNZCsyHmbF7ATsHtzT+m7zsotE092sQp8J3eC0hM6H69t/6U9ncQBounmI42mm0njIKXfZwTOisccA4IcTXKDRH9QrbpDfcpkZNKVmozByuxb6hj4g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by BL1PR12MB5143.namprd12.prod.outlook.com (2603:10b6:208:31b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.21; Fri, 4 Aug
 2023 15:56:35 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146%7]) with mapi id 15.20.6631.046; Fri, 4 Aug 2023
 15:56:35 +0000
Message-ID: <36dfd3cf-37c6-a630-7ef6-376a339a8f8d@amd.com>
Date:   Fri, 4 Aug 2023 10:56:32 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 3/3] PCI/ACPI: Use device constraints to decide PCI
 target state fallback policy
Content-Language: en-US
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-acpi@vger.kernel.org,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Iain Lane <iain@orangesquash.org.uk>,
        Shyam-sundar S-k <Shyam-sundar.S-k@amd.com>
References: <20230804010229.3664-1-mario.limonciello@amd.com>
 <20230804010229.3664-4-mario.limonciello@amd.com>
 <20230804131703.GB14638@black.fi.intel.com>
From:   "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <20230804131703.GB14638@black.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS7PR03CA0167.namprd03.prod.outlook.com
 (2603:10b6:5:3b2::22) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|BL1PR12MB5143:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f6c386e-6c96-4d47-f853-08db9503612c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YUd47bnHpehCW8hUZ9Qy2JjeD07Ba/Coj8Qq7AXG0xnfKKSCyU2F8j1g0XQd9HptHBz272e9HVLiaVJyV//P+4FVBlLnG2Qf0u/jrhyajsDgW5qqHritYzNjuJkSMvyLxVgHstOze9N00hZXzLlKIR3XNKYlZ09zRToYTPisLoGvjeKW8wemVVY1uS9xaOekKu1+pOaigjlSyCNNa8n7fDVnoSWepEuk+DM+nPxd5nALq2oQq0jQlaQ/NhTILa9MugGZMzFJHwNupVCsW4fUxbJbx7Iqkesw2y9jkX5rJ4xHEIZoDwrHFlvSYFEmjIsxwXxc5St8WzF+g6OYoJWVGh1tH9jDsx33BWq/HkKYIsnLePABjB9DcoGqkbWeGxGohNM+i1MyaA/lcegXYQ54ftdO0S4ic9ErXwoDkVoAttEtp9PxkonRtzfcwMvcqIBLsvilessvmS5mj9kiAHWKSv4qiMXj4Rt1lwcUYpvV6wZj6fbc1ukslVOSAZYhohl6oNs1IK2fRtljTVD8EfB15tQ6gonjufLx/7Ju5MOdZc0jGQyh38IEaJMNF/YM8IZYUpkgkBtrwWisImmHPa+JuTejiI/YIk7h6roaC1s4ZxUG1RjwJlApkvh/k1bymL3sLuYx0r1vHT3cfCvJ7mkI6w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(39860400002)(136003)(396003)(366004)(451199021)(1800799003)(186006)(5660300002)(4326008)(6916009)(66946007)(2906002)(66476007)(66556008)(316002)(54906003)(8676002)(8936002)(41300700001)(31686004)(478600001)(31696002)(86362001)(6666004)(6486002)(6512007)(38100700002)(6506007)(26005)(2616005)(36756003)(83380400001)(53546011)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MTFXQ3FkanZCRHJrUFlIYVhhOHpJNkxjQmtSTTBjcHA2TzBmdmp1SHRlUzlm?=
 =?utf-8?B?OWlha1dnVG1OVTB2dC9VMCtXOGpsanhkQllQRThsTUx6QTdVdEdCVEJiRk9j?=
 =?utf-8?B?bWVmNjVlajFNTWFDcmRHM29YaEczZlpCQjdaclI5c1BSeVlhdTFIdWhZM0t6?=
 =?utf-8?B?VWxwayswYlRNc0Z0UzFIRWU2a0l0ZE5oTXNYNGtJUGRPdXVXWFhMemwrL3pn?=
 =?utf-8?B?eDNTbDV5SWtlU1paanFTd0o4TkhSN2RsY3BaYzM2akJRTmtRTmQ5Q3JCR2NY?=
 =?utf-8?B?M1FodkNwelZrQm0wTC9ZcXRvU29qYXZ1dW1PdEhxd29ZUGI0WXZIUTVxc2tI?=
 =?utf-8?B?ZFU2UUZQeEdKZm1WWXRVN0F2VURCS01XRE1nNENIN24vZEhYd2wyYlN2UlpG?=
 =?utf-8?B?Q05QelNLL20vVGRzdXplcmcyWFJQbk5QL1F2S3VxcDNyYk1WV3pmNi9XSHNo?=
 =?utf-8?B?SCt5ek1WcjR0c0ZUZ1kvV1lLaXd0NVdYUVBtLzZVSEZqSUl6U0I1Qkx0ckhI?=
 =?utf-8?B?QXVyaTJ5dWl3TG9nUmdObWVOSTVmcllKdWJGRkI1QVY2cEJoSU10TWJwTXQ0?=
 =?utf-8?B?MHg3TklIT3dveEw4aHVzTUErckFFVGtwY28veHFma1JsWTYvNkRiV09VYmU2?=
 =?utf-8?B?dXlBT0dxeG44Zy8rc2dPVk5rcmRiSTIvOERSMnFYOGVLVkt3dFdQYkFxWlpw?=
 =?utf-8?B?NWFUZlRZTlJlNGt2Q2kzWkRjdGdUa09EN2hZODRBemNiL1FYWHhYR1pmM1VT?=
 =?utf-8?B?ajdHb0pucEJCMG9GdkFaalJYS01xRHZCaHdlNFVmRjN1aVVreGVNTnpRdStn?=
 =?utf-8?B?RVRtOHZrYmg4Ni9aZXVpSEE3ekxLZzRDZmhTZzczOXFQNk5SWmhKMXU0dHc0?=
 =?utf-8?B?M0IreFgxL2s4OHFMQ0Z4Y21jbXVYeWYyZHgvVXdiOVhOZUEzVkpPL0c0aWgw?=
 =?utf-8?B?WlJyWmJDaWpaM1NMbVpOMmxqc01oWTRHNW5RcnZReEh1Y0t1ZXU4OHlMTzg4?=
 =?utf-8?B?WGRwZ3JLdllFWWZ2V2xaRTJvTE03RGhseFVLMjl0SUV5QWFSMjNIQ2laNi9X?=
 =?utf-8?B?UndYckhyc0hDNGVhOXZIZnRnNmtjUEIwMnplbFNBMlhnRWxkKzBWS0k4QXVX?=
 =?utf-8?B?SDZIeFFYU1M0V25RQSthSFJWSTIrSUtVRTZqNDJObUhRSEtKUENwVlplYlV4?=
 =?utf-8?B?cEVBUXNqMmZNM3c3OGhrb0kzNzZmcFhPUWg3SlpiUllhVnRXOTYwcnpqZXI0?=
 =?utf-8?B?RTllRXpLVVkrRnFrL0REM0lHOVFGaVRLcUswT0dqVHlzSCtyZzJEZzhRU3pq?=
 =?utf-8?B?ejNrTE1lUThQL0hzOC9JUFdnL3J5WlhPR3hiLzVJWmEvSGlERXRqOHMvQWdo?=
 =?utf-8?B?Qmh4cDV6bFMxQjYybE9zN3pQd2Nabko5MHFUN2hRRGMwcllUTmRBVHhaMnps?=
 =?utf-8?B?Ykxmb3JZT2tUNkdkaTZoN3ZzWWpvWWYvcExQVjFlZEUrVitzVE00QzM2TTBu?=
 =?utf-8?B?eFF2VElHWGdBWXo3dzhCeXFmSnJkSE5kTHpKQnVEbldRL01QSituVGpKMTN4?=
 =?utf-8?B?eVpXMENmeXRZL3dPWStudDkrbU8xRGdXeVlSbzBZU2lVL0ozNExWWnM3QzJm?=
 =?utf-8?B?b2YyM3ZHY3VIaTJQUXhkQnhoc2hhQjcxWCtjR1Q3Ung5T1Y4dmlNamQ1ZVJR?=
 =?utf-8?B?T3p3Y3YvYzZzcmxVMVVISko5ejZPSWJ3R1h5VjB1bVBodkhUdnBtSEtMTnJm?=
 =?utf-8?B?aGswMmpnRlE1Vm90TGxJaWNkT2s1TEVJUDdFS0xrRitSYUF0TXM0UUcvcnVV?=
 =?utf-8?B?by8wRWNCY3lJZEMvOXk4bnJxazEwVzh1cUtMQ1NJbUFESjJWTDBCMkdnb0Nw?=
 =?utf-8?B?SlBJVXV3VWpNdi9uRUFaTjdjNE9XZEF5UndLalRhRW5GclNwWFBZdGQ1aUNk?=
 =?utf-8?B?d29sZEM3ZUlveFpDOE5jWWx5QmVLdVRjdkNMZXV3SzJvNEo3VHdFckJ5Q0tS?=
 =?utf-8?B?cXFJNE1UNU5JS25kYzYvZVFreDg1TDZBTCs3R0VLSWlhZFY5K1hqK3ZlVkY5?=
 =?utf-8?B?QllUVVk5bmNkYzlUaXJlbmNVeHMxWVlxYVI5MXdiN0NWNjNGWGxmQVRKU2JS?=
 =?utf-8?Q?cAO4LTOl3BjjBtU0v/4ZYWytL?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f6c386e-6c96-4d47-f853-08db9503612c
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2023 15:56:35.2481
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2wIZ+/H4I7e13xXa1lkQ0r9usTFspEqWjcF7Usrz/3/pVxHqr4iT2qOQ4RMa6ce26waDPZyxWrX2GQ49eapjFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5143
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 8/4/2023 8:17 AM, Mika Westerberg wrote:
> On Thu, Aug 03, 2023 at 08:02:29PM -0500, Mario Limonciello wrote:
>> +/**
>> + * acpi_pci_device_constraint - determine if the platform has a contraint for the device
>> + * @dev: PCI device to check
>> + * @result (out): the constraint specified by the platform
>> + *
>> + * If the platform has specified a constraint for a device, this function will
>> + * return 0 and set @result to the constraint.
>> + * Otherwise, it will return an error code.
>> + */
>> +int acpi_pci_device_constraint(struct pci_dev *dev, int *result)
>> +{
>> +	int constraint;
>> +
>> +	constraint = acpi_get_lps0_constraint(&dev->dev);
>> +	pci_dbg(dev, "ACPI device constraint: %d\n", constraint);
>> +	if (constraint < 0)
>> +		return constraint;
>> +	*result = constraint;
> 
> Is there something preventing to return the constraint directly instead
> of storing it into "result"?

My aim was to make the caller use it a pass/fail function.

I'll adjust it so that the caller would look for >= 0 instead.

> 
>> +
>> +	return 0;
>> +}
>> +
>>   static void acpi_pci_config_space_access(struct pci_dev *dev, bool enable)
>>   {
>>   	int val = enable ? ACPI_REG_CONNECT : ACPI_REG_DISCONNECT;
>> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>> index 60230da957e0c..6c70f921467c6 100644
>> --- a/drivers/pci/pci.c
>> +++ b/drivers/pci/pci.c
>> @@ -1082,6 +1082,14 @@ static inline bool platform_pci_bridge_d3(struct pci_dev *dev)
>>   	return acpi_pci_bridge_d3(dev);
>>   }
>>   
>> +static inline int platform_get_constraint(struct pci_dev *dev, int *result)
> 
> Ditto here.
> 
>> +{
>> +	if (pci_use_mid_pm())
>> +		return -ENODEV;
>> +
>> +	return acpi_pci_device_constraint(dev, result);
>> +}
>> +
