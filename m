Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2E95777CCA
	for <lists+linux-pci@lfdr.de>; Thu, 10 Aug 2023 17:54:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235708AbjHJPyR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 10 Aug 2023 11:54:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236286AbjHJPyP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 10 Aug 2023 11:54:15 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2056.outbound.protection.outlook.com [40.107.92.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F050B2115;
        Thu, 10 Aug 2023 08:54:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yv0b/JI/yRxOwRWH7Edgb5vtAuJzUHxk/COKCzqiFyZ2xrSrS//Z16ydA95S1A4NIyYNoxwuxG65N5PCLDhpkqNvh+0/gniI1BgvCAmMHyAofxSuXf3VfwhoDp8nOxFhY1dWmxqlp/zNwc1mTXvCgPvIWzNgfxdTw0IBMvMIgkOLr2AsGLr6OJ7Crboy51yZqMmVrwIkdlsB7/eTrjUgY95zBcnx1bQQDibTmqL10G5YOrW0MxqWrpGWyvTVrrbcMxtML7D5YWRwIq2dQkPz66rMXi8h921yY6uVu7y4E06Cp4wR+Ivl2lvdniEVQRea6ownaec50NVOo7zqmgkjDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dVFBEMMx2X19fQrKCWVDDS/86+INLqQj2bUKb7Kz7nA=;
 b=fpJC1md+PhSJbDeF7D4c62AFkjEgHXbr+OTx8OzBph0So6tsuHUjPW5JLu++AVP8pKxDE9DgDeLn1w3KOADRFVArgxHNTLLcfHC0WRdUgzq/YFB+hKPlbpu7uS7eC+VE785ty5DTS8jEcx1iiES1TKn/PsVIasrnSHWxiKe8Fh/jGY/IvjWsZEDVHQLpnkwANU1/4SXv6wdZFQlEC0BRKjeQLe9YnexSDnu7rvJIw9H/mGEDtbxsHd8qv9bcKoEVAdvBd4t5unkjeNWQppDXcHbJbtRUI+YdZCZTRuDlDrNphCGpJM91Dl4wXkRVls1FRnFG+JhOVKf6EpjKaJ/h8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dVFBEMMx2X19fQrKCWVDDS/86+INLqQj2bUKb7Kz7nA=;
 b=giN1ai3jQZtWFhcv0igFUH6Or207JCKKtARHEr0Qdz40vvW/FIxrfDDAbrptmM+p+DKYsa8lXvH4AhhVGj3++6dBVkrRBdG7shNgWm0Ys+BJ+y4UpJ5R5IKyWij5ganmIv0gdly/tBmRj7D3UpS62IFKm7dLWOOVPBL/h+5WR1s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by PH7PR12MB5925.namprd12.prod.outlook.com (2603:10b6:510:1d8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Thu, 10 Aug
 2023 15:54:11 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146%7]) with mapi id 15.20.6652.029; Thu, 10 Aug 2023
 15:54:11 +0000
Message-ID: <a480b846-bd5c-4a98-a1ee-9eacb53816b7@amd.com>
Date:   Thu, 10 Aug 2023 10:54:08 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 6/9] ACPI: x86: s2idle: Add a function to get
 constraints for a device
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Iain Lane <iain@orangesquash.org.uk>,
        Shyam-sundar S-k <Shyam-sundar.S-k@amd.com>
References: <20230809185453.40916-1-mario.limonciello@amd.com>
 <20230809185453.40916-7-mario.limonciello@amd.com>
 <ZNUGoONuUZAp0TM9@smile.fi.intel.com>
From:   "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <ZNUGoONuUZAp0TM9@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR07CA0112.namprd07.prod.outlook.com
 (2603:10b6:5:330::27) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|PH7PR12MB5925:EE_
X-MS-Office365-Filtering-Correlation-Id: a5fb66da-7f63-400d-8656-08db99ba09c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Q/aVT/W5ad/wlLfJVdMaQ3CbeyFzjUWvjel5nk9XH43Yh/3L7I5BtaylPY/FJ5aD82YNszvN/49xFNpHdzOZmntalBljOa22gySWM1bt/4b7j0gTb1RMFuUO4k6RHn7BvKemoOmX4PZbS0B12mbmPzdVfgB8KsBGrVaTUqEncLjIFoFiJcMlZtcTYiogJMC8ccfDxw9wmULfAtFzefPJZuFkIe5BWOQ5tqAicdBMqEfofQnLpA9TU3Jj8d6W0XczB8J/H7HXhyhFiXg2ft+TB8HYoTnb+p1PNL2liJhlI79z/2RVwsJn3togBqz+PvHB92yXKkJzL6CO9ZlYxrWLX4Qvs9NpcULFdOT+BKUjh15HYVWjGo+jLOibWhwTW2z00E0+x9uwdYfOZ2AJZRDm2+qzw4KUjxiGgcufBO1aSQE8wCMRaUxfpidR62r0d1upGZE93fllyx6lNg/iaOVwFmAfaY5Dv1P1qMWBDuoLcahhObiUTME1DmIdztSvvaRT8Xz6aLqOZPHDd0EjKD/ZtTO4sIhG7mWhi3s+hsPsiTL1D0EcSMKFt0z5hPqxlNhHbYSVW+R4LyQy4yYeJKr3B5oyPOFaI3pOxyKr6Xd19H5sMIflgb9RB+uFPTmH4tHmpcjApaGPlKQYdYtkrC/NyQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(366004)(396003)(39860400002)(346002)(136003)(451199021)(186006)(1800799006)(6486002)(2906002)(31696002)(2616005)(478600001)(86362001)(6666004)(54906003)(38100700002)(316002)(53546011)(5660300002)(6506007)(26005)(36756003)(6512007)(8676002)(8936002)(31686004)(41300700001)(66476007)(66556008)(66946007)(6916009)(4326008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NXUwTVBZQjNzM252LzlSWitNQ0dkbTZ3ZjI3OWdBWDlrSWRDaWdMWWZGRDlB?=
 =?utf-8?B?ckMxU0d6bFhqSFEvWGw3NjZDRkhEeHZTRDA4RzBBNnJ6RmxpODh6cE9kWUxp?=
 =?utf-8?B?dkJWSWdIeVFpcmllU1FHUDFhemtyOFhBY29BdWZCNVJGZFdrbk9BdXRNaHZS?=
 =?utf-8?B?QnBrNkVxaEF1ZmY1cllheUJyckRPSFpyOWVkQ1J2T2RiM1F2MU15SFJqQmQr?=
 =?utf-8?B?UGhOdWQzWFpuTytUMzdqTnF6VE95N1JkUmR5LzNzTitwS2lMbFBvc3RLNWlw?=
 =?utf-8?B?cTB1M3dCSk5iUVVRWlNiRjhsdVpGaEdoN1BRN3NidEljUkhXS1FFejUrdm53?=
 =?utf-8?B?WHhJUlJ1bHM2SzJjVnhGUlJERU9ZL0ZGNUs0bEFMek1TbUxYZWNKTWxuZkNi?=
 =?utf-8?B?WlFiYU9WdlRvNEZ3L3NHM3RISUpNcGU4NE9XWXpFUWluZW1hQnhUTndrV1Zn?=
 =?utf-8?B?Nmw0bk1FV3FickE0b29uQmNlbGIxRTlsSThzRGlyL3NrVnZXaUM3K2Z4QUFK?=
 =?utf-8?B?aHlmU2pYOEJ2K2VPU2ZkNkVJa1N1UEMyZWQycGs1S0lYTmVUblRWUEQ4TDhw?=
 =?utf-8?B?Zm9BYTJ3bVFkNWFzT1VXNDFubzkzOG9pZWdMZG02R0trdzJvV3VGbW5FM2di?=
 =?utf-8?B?S1NPVFMvY2pxVDdlVVMvc28yekNYaTRNdWdvVzZFbW9udDc2NlpES1hoN0NU?=
 =?utf-8?B?TlRSOG1mNVNiTnFoMmtXZ25hMHl6L3lpYVJCOUZUNHhIRWxpUkd6aUNXYWxS?=
 =?utf-8?B?Q3J3bkVDdGszSEVUUUVXVlQ2TWpheDVHRmFVQ29FbEYwZkpFcVdVOE5jb1NI?=
 =?utf-8?B?L0Zsd01ZWEhPWS9tSEREUXRpTng0ZzlNZlhVM1RMdFdLVS9rOVAvMmZGaXEz?=
 =?utf-8?B?ZVkzQ3Bsdmlrcko1aVNTR05ISitJRm5adTNQS1BHbHdlaHlvSldBQ3d2NVBD?=
 =?utf-8?B?ZjNUc2lxZFFybnkveGV1dXJZRVBNcTVqVGM2WjN1N3FxR0FobEd2SVRhSnpK?=
 =?utf-8?B?N2d1b2ZiaHllL0lsZU04ai92TXl2MFliS3BsYlRFQVN1Y0daVGg4Z3ZWTmt4?=
 =?utf-8?B?VUJhWnFtaUsvMlZBZDZMTngwb3hMdlJDR1kwWi9LWkEvamF6cEhHa3B3eWk0?=
 =?utf-8?B?aDNqbGdoWG14MW5tSGVPaXNxc3paNXFXdkZuby90Rk9wRTdQK1NTbUJRc0R1?=
 =?utf-8?B?REU3c3pNOGNDR1p3SzZyLytEY2FvSWd1S3J5TXJkZmYrZVJZZW9ocWoxWDVH?=
 =?utf-8?B?cTUydDdxNW1LVk10K0ttOUl3dEo3UG5mT1Q4Mk5CVDV5ME1aM2pSSkxVYzRp?=
 =?utf-8?B?ZEduVEFiUGxHSThHYVBIaWxwZ1NaemJVc0Y4eXczR2ZPV05IMVhiR3Qwd1dC?=
 =?utf-8?B?dGw2Z0ticGNvL3NjN0FETkR5ektCT3pJMGZVenU4cGpCaENUVVdheHlZenpl?=
 =?utf-8?B?V21WTldRaGh2Q3ltT0RIU1ZFNFZtK3k3Tm5rZVFhZE9vbkFOa1ErM3UwTmRj?=
 =?utf-8?B?SVU4d0xlUVM3MU4yemU4Z083QjNJNkRLcHR1SDN4SE9vZUxZaEh5WmgyR3NY?=
 =?utf-8?B?bXN4Q25aS1RGNzltaEMrR28ydnRPK2dHYWQ3V2I5eWUwNDdwZUZ3VkdVU1hX?=
 =?utf-8?B?UHFIamNmcXpmc3kzcHhJaWtBMUR4V3AzSkVOejducUVxYmJVNndDb1JTTUlK?=
 =?utf-8?B?ZzJGc2tBZzM1aitWb2g4cThFYk45SkI2SHVVeW1NMGgxTFA5SDBvK1ZPdUF3?=
 =?utf-8?B?S1VNZmE0VFQ1eVFhTFpVYklQY2FackthK0h2RVZFTUhjeTJmeGRkZmFUUFlF?=
 =?utf-8?B?Y0gyT1AwZndtbGpJcFdMalpoallNMmx2VHNwQmlZSnlXalF6VzRKZkxVTXNw?=
 =?utf-8?B?bEc3Um8xcEFYMDQ3WVpPdjJLdGNpbk9xRGZWai9sdkRkZWFmaGxlZGV6M0Ny?=
 =?utf-8?B?NklFemxtd29CdGR1L3MxUG5rKzliekMxZnRoaWczcUp6eDM1UFJYTUZXL0JC?=
 =?utf-8?B?eG02RXhEV0FaeE16NDRGY3BGL29Gc2JpMjFZK21pWnhDeG14ckljaUhiY1VN?=
 =?utf-8?B?U1hEdUwrUE1abzhWRjFBbGQxK3I1bkMyWUdzVEREeHpkRlk2NlErbGwyTk9w?=
 =?utf-8?Q?sMumGXNXakuXVMVYCGlUtJ42/?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5fb66da-7f63-400d-8656-08db99ba09c4
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2023 15:54:11.2126
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qHQwbOAmyRZAYTKIwtH169BxxcrrEBSBvC3kDWnI/TdyZq+Q5no3j20u3sLU06+XlqSnqX3tyQALMgiCBDCXsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5925
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 8/10/2023 10:47 AM, Andy Shevchenko wrote:
> On Wed, Aug 09, 2023 at 01:54:50PM -0500, Mario Limonciello wrote:
>> Other parts of the kernel may use constraints information to make
>> decisions on what power state to put a device into.
> 
> ...
> 
>> +int acpi_get_lps0_constraint(struct device *dev)
>> +{
> 
>> +	int i;
>> +
>> +	for (i = 0; i < lpi_constraints_table_size; ++i) {
>> +		static struct lpi_constraints *entry;
> 
> static?!

Whoops!  Good catch!

> 
> Seems to me with the code in lpi_check_constraints() this actually can be first
> (separate patch maybe with conversion of the mentioned user) transformed to
> 
> #define for_each_lpi_constraint(entry)
> 	for (int i = 0;
> 	     entry = &lpi_constraints_table[i], i < lpi_constraints_table_size;
> 	     i++)
> 
>> +		int val;
>> +
>> +		entry = &lpi_constraints_table[i];
>> +		if (!device_match_acpi_handle(dev, entry->handle))
>> +			continue;
>> +		val = entry->enabled ? entry->min_dstate : 0;
>> +		acpi_handle_debug(entry->handle,
>> +				  "ACPI device constraint: %d\n", val);
>> +		return val;
>> +	}
> 
> So will become
> 
> 	struct lpi_constraints *entry;
> 	int val;
> 
> 	for_each_lpi_constraint(entry) {
> 		if (!device_match_acpi_handle(dev, entry->handle))
> 			continue;
> 		val = entry->enabled ? entry->min_dstate : 0;
> 		acpi_handle_debug(entry->handle,
> 				  "ACPI device constraint: %d\n", val);
> 		return val;
> 	}
> 
>> +	return -ENODEV;
>> +}
> 

Much appreciated suggestion.  I'll incorporate this in the next version.
