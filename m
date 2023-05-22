Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D378F70BBC7
	for <lists+linux-pci@lfdr.de>; Mon, 22 May 2023 13:28:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231996AbjEVL2v (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 22 May 2023 07:28:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230502AbjEVL2h (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 22 May 2023 07:28:37 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6516FB6;
        Mon, 22 May 2023 04:28:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K4XrRldZV2iJDZbQnTNWeRkygDtRBWWxAIG9VuXCWI8IIJfJfF0JU4LdLoShm9qk9NzmLXAp41h+R0TXhHL85IzPALpx+5LfOexiEnsptQWEdqfeTWxtCbR3+bOmhQKGbezYUeyfK7sUsZvxIUG62rrVQXHspfGvvyzeUdu8TcJawPUD28zCMU//yL3ywX5mhyEUTWhhLNHCoDbg2ZrJZJLEh0wnzvOTAYArkDvlgSG9hP/cG5DhtJ9nKXG3WGGJ28nN1RpXvNGnfUT1v8ZAyoAoKvvptL9wtYhWAxR6UPleXLf3enhdFufizL8GENIuuk9yRZrD54CpKVSpWJ4+og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q2KBtZXyzhsvNSciRr3PwQeCdafgMei2TPkzOXneLIM=;
 b=GN94myfEOznVLECjDB2LhAWdBG3WPgVfBV5EbTiOSb7RgLk9uoUkvR5a2n9gwypuH4aM5PPDoQjk6JR/7PZE4WlMs9NnF6585CwiBqE/sFhAaF9aphm+KRD+eaWwlFP4PfB0D7svv0JfDT9WuoEImHO/+lJMBiwWoKcLgBQSQpldM/D3U57W8aa9LY9smnsWxuGQGF19rT5VV71/JhxRl/dNj+jPhIAfP1v2AT0fX0kZzreyMfnbhExHegMvdHnzn+nN93ebeh9nETcDI5CwFytvkrcksMTSdNVZ6Bb+0F1qMXMXzwSr/w1TMDkfo9WFOElvD5OQ6cJvgM1lIQzN7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q2KBtZXyzhsvNSciRr3PwQeCdafgMei2TPkzOXneLIM=;
 b=Y5Q1hAK4jXphV2/utSXxlOCDmH1xU3PGK7R1bLK95aIl8qjEO+bHNTfwg0T4o9MrogtKVH5jsKS10e4I7HNnr5DTDWrc9qFqJQpSJSDuR3+xGbURGeJ5tMGwzKVPasA9S6wQw+EmmCdGgOn9i+ixzXd7TE7Qu9wquWbCN+egZmk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by CY5PR12MB6623.namprd12.prod.outlook.com (2603:10b6:930:41::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Mon, 22 May
 2023 11:28:28 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::3f45:358e:abba:24f5]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::3f45:358e:abba:24f5%3]) with mapi id 15.20.6411.028; Mon, 22 May 2023
 11:28:28 +0000
Message-ID: <da80fb19-0b98-bf19-eea3-bc2cca2024f5@amd.com>
Date:   Mon, 22 May 2023 06:28:25 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v2] PCI: Don't assume root ports from > 2015 are power
 manageable
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        S-k Shyam-sundar <Shyam-sundar.S-k@amd.com>,
        Natikar Basavaraj <Basavaraj.Natikar@amd.com>,
        Deucher Alexander <Alexander.Deucher@amd.com>,
        Iain Lane <iain@orangesquash.org.uk>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
References: <20230517150827.89819-1-mario.limonciello@amd.com>
 <20230522055555.GI45886@black.fi.intel.com>
Content-Language: en-US
From:   Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20230522055555.GI45886@black.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1PR02CA0014.namprd02.prod.outlook.com
 (2603:10b6:806:2cf::21) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|CY5PR12MB6623:EE_
X-MS-Office365-Filtering-Correlation-Id: 88dde69e-96df-44be-7422-08db5ab7a9e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: odoLgr42l6kkIHVCkpkdIKK6K2PxojRvrc6m+HjXKZ/kOh4+1cdEcUziYlU5UA3skzAHlRngq0Uxb2JpOZBTM9UDaQt3uvt33CEHofAqzj2vrLVvufPJUql/Xz7mBl/uJQfcq64m51ztRN71RnpfkBHWvYK6V2bMAI8Dxel2taQ6QG2FwqFSNsDwfPAqFHhWP8H4+Du3HhT2ft1GnZKOgxRzQkOEfzC6hfXHIRqklGYUGIZBpg+QInwXpCTUkwAIibezkPfsjxa6bArAhB+CDlTyPe4rw5I1ou0cdgdO2yQxRt+J+P6v1G3JZgC4HN2GwuGxJsotVJdsattwuetc5BfT0PnK37cMc5crjwiqPu7QXeu4uWgBnTfpUdh8S3AjNVZX5gL564lBLlE3UiJGAsvz4nG8seNDCmBReQFJxAkgFy6GMsjHggUi0jNf9m8+lM5FFBS8z+Cy9tqZjAK5X7q501n4rJme+YfrlGF5PtHn8NzCXtGa5+AupJbZZ5CpAWb3+hcm8tnTyBKgrxb/PDjQL8mLjOJov/cSe1FUNRMHwX/Ub8TzxGz81hq/uB6BSWVUCTduQtYjwdjr2nW+K760ie+SUXaBsZXpdQWek8nfojg+yL9/5Eml3Ol3OWsWFld2yaJLlmfg8V+3YDKJKA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(376002)(396003)(366004)(346002)(451199021)(31686004)(2906002)(54906003)(5660300002)(44832011)(66574015)(8676002)(8936002)(41300700001)(316002)(66476007)(66556008)(66946007)(478600001)(6916009)(4326008)(36756003)(6666004)(6486002)(966005)(53546011)(6506007)(6512007)(38100700002)(31696002)(86362001)(2616005)(186003)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VWNKYURjOVNLVStoRzhlTXlPRkVIQXJ1WWRoK1U2RVBURHJuZDNBS0htWGRY?=
 =?utf-8?B?ZXRkN3djRzVCSm85Z1VMT3V2WUd1TDlsRmRrNnN3cDlLellqbmxkdjRGYWFz?=
 =?utf-8?B?NE85dkVocWltNXVSMkV1dzJlQ25xWGNwRXZvOGtLY1lEQmRhQmt3V1RGL0du?=
 =?utf-8?B?dFM5a0pFNklFSGpYd2tFenB0azJqeEhyQUthblVZZWhlcGNTNXRRMHIwVXpt?=
 =?utf-8?B?dEJEa0NFVWNjTUpUMGlPM3Y2YXozZkFyUElKM3luU3daUEQ0bkx2c2dtSkc4?=
 =?utf-8?B?aUhQNkZ2OU5wOERSTkxleWVIMDJNc2FZdFc5N0YrRWxKZGxkOTZhcURHaFEv?=
 =?utf-8?B?OXl6ZEZ0NE5ZZXNxcDR1NGpTMHF3Ylc1MGJPVkZJZzFlWlhmUS83aVI4WUZI?=
 =?utf-8?B?ODE5YmxMZndnNi9pTGhwYXYzMzRyamJrLzBGOHpVaFVRdkRVb29uYXI5OG5t?=
 =?utf-8?B?aUgvM1ArWm9WWHV3ZmZKUjg5SnlJTUhZZ3E3WSs5ODhPMnQ3aUdud1ZQRnJr?=
 =?utf-8?B?cTNRNFBCeGNmOWJhN244WkozS0RneUlTYm9SWTVtWE9uY0FFVWt5NzREcmpC?=
 =?utf-8?B?YlhoZ2JxdGlJdVB6N2lOVmpxbDc1aStjMkRFRUxRaWtrNU9VVnM5NDMya2t6?=
 =?utf-8?B?ODQySUV5TnlyZENOcUJOTXhieGNLUVpqYzR4UTFBNUtSK2M2SDNQTEdERU0r?=
 =?utf-8?B?eDZHSHlrS29LTUxsZ2FzVGNmSU5tdmtoa2JNVVRmb3p1aERRV1liOGJZazNO?=
 =?utf-8?B?MmI3VUMyWXN6QzVPQXhENHJKVVFaeXcxcFpwV3VCald0eDBmdE1WTTZnZVI5?=
 =?utf-8?B?VG9YTG8vWHk0UGdwY1VXZStDMkFVdW8vSU4yVmIzeFZCSXZ0d0VBbU03NEpk?=
 =?utf-8?B?dU11RFUzaGtnVFM2SzNHSlJSdU1nN05vVVJlUDNnNUFFOEVZM2twVThvNDY4?=
 =?utf-8?B?eXVOdThTWXFXNThtV2dQcGczMnJ5ditGSGswQ0h2Sm1qS3hwOC9MYk5xQTBv?=
 =?utf-8?B?NDZpUlExZmRWOTQ2MlJCZkJ0d0FqcWhYUjZQdWtWYW1JUVR5ZDhEWnBtbHZR?=
 =?utf-8?B?YktQSTBXTGxGT0FzQWNaYzVQaTlCeWRYQzBUUE5iUk5TSWJrbFRRaVdBRVkw?=
 =?utf-8?B?dVRFMjhkdzBhT2kyODVXQ1BZd25DSzduamdvN29tdHBUcEp4TjBtdXZETWZs?=
 =?utf-8?B?OEhoWUVvUlFDVm5DTXBaMlN1MFIvSWZPNnFCdjRneGdtSUUvUWx6eVZITXVC?=
 =?utf-8?B?Z2huU1RCRDROdmpLbVNFYlhUaGRqVW56dnJOQi9aQ2paOWx6MjdYSnFkRDlv?=
 =?utf-8?B?YnhFbVE1OFZJK2drN3kwbCswTjRCTTd4UWZpb3dZRzNiblh4ZGZHMmFCeUlX?=
 =?utf-8?B?VDhXN3R5N3c2WmRHSnB5bG54TW0reHpGekxyK1ZINVM1U1I5TENUYldBN1pE?=
 =?utf-8?B?ODRtTXhzeFM2Qk4zVU1VbkZpK1VzQmFzS3pEMmVkK3Ard21XaEJZSWJJM1F6?=
 =?utf-8?B?V3pDWW9MVVFqNXdGN0JvRG5nMzh1KzJhMm1iVi9HS1FjRU5DVStUYlRaZHdH?=
 =?utf-8?B?SEJGN2pkOFZtRjdkMStoVmdGUE1WZ2MwMGRzOFVlNjB5R1RGQVZmR2RzY3I4?=
 =?utf-8?B?bkFXNEpzYk1xL1B5T0tNRHE4YkF6SEhGMW05LzNxcCsva1dXWmY4UGlmUFZJ?=
 =?utf-8?B?ZFhvcFhEalh2eldJT3gxK2xFWHV5bjNXTmVDYUZNV0lLd1M3QVpVelJrdm5L?=
 =?utf-8?B?UjJMSmtQMVlLSjVYS2pWSXJ1d0dsV0poRUpHNVp3ZXFWakNzU2UxMkVpQ2VI?=
 =?utf-8?B?cjY3UGplR2V5dGxNSGJOZDNYTlU3YnJ3eEs0endiN2lXNThjWjZacVJHRmV0?=
 =?utf-8?B?T1pWUWJmQUVBQ05KSEFKZHRkUTN5UDltYUV2SDZhc2Vxbm5HMjZQd202V2Uy?=
 =?utf-8?B?c2N1bEVPdGtKSFY4SHdNZHZZNDJPeVNQaGhPKzlXNUNSUW9lK1NWRlRMd3F6?=
 =?utf-8?B?M2dnN3Y4bmhFY3F5UllmV2hya0dYaUFyZVBJR1JBL2lrWUlwWkl4S1VGck4x?=
 =?utf-8?B?MTNaRmEycUlYNW51ditBNjNTNW1FcW56d2RVMWJLRitQUUZKWjAwVjdiNFNF?=
 =?utf-8?B?RTI2OWp4SDVzY05HWnpwYjJoN09GemdJU3VEd01YT0NWTHBiMHp1ZlR4b1Ux?=
 =?utf-8?B?N1E9PQ==?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88dde69e-96df-44be-7422-08db5ab7a9e4
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2023 11:28:28.0708
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 14L2mraujNqATFcFPjf3Sas/2adccwNaUYp4Hc4Clbeoqi0mZ/Gk3X3j2UVH4SnA/xC2lc7EAHVEITeyOvhOoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6623
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 5/22/23 00:55, Mika Westerberg wrote:
> Hi Mario,
> 
> On Wed, May 17, 2023 at 10:08:27AM -0500, Mario Limonciello wrote:
>> Using an XHCI device to wakeup the system from s2idle fails when
>> that XHCI device is connected to a USB-C port for an AMD USB4
>> router.
>>
>> Due to commit 9d26d3a8f1b0 ("PCI: Put PCIe ports into D3 during
>> suspend") all root port go into D3 during s2idle.
>> When the root ports are in D3 over s2idle it's not possible for the
>> platform firmware to properly identify the wakeup source.
>>
>> Comparing registers between Linux and Windows 11 this behavior to put root
>> ports into D3 at suspend is unique to Linux.  On an affected system
>> Windows does not put the root ports into D3 over Modern Standby.
>>
>> Windows doesn't put the root ports into D3 because root ports are not
>> power manageable; they're missing _PRW and _S0W.
>>
>> Linux shouldn't be assuming they support D3 just because they're newer
>> than 2015, the ports should also be deemed power manageable.
>> Add an extra check for this to ensure D3 isn't selected for such machines.
>>
>> Fixes: 9d26d3a8f1b0 ("PCI: Put PCIe ports into D3 during suspend")
>> Reported-by: Iain Lane <iain@orangesquash.org.uk>
>> Closes: https://forums.lenovo.com/t5/Ubuntu/Z13-can-t-resume-from-suspend-with-external-USB-keyboard/m-p/5217121
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>> ---
>>   drivers/pci/pci.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>> index 5ede93222bc1..3fe27aef09e6 100644
>> --- a/drivers/pci/pci.c
>> +++ b/drivers/pci/pci.c
>> @@ -3010,6 +3010,9 @@ bool pci_bridge_d3_possible(struct pci_dev *bridge)
>>   		if (dmi_check_system(bridge_d3_blacklist))
>>   			return false;
>>   
>> +		if (!platform_pci_power_manageable(bridge))
>> +			return false;
>> +
> 
> We already call platform_pci_bridge_d3() few lines up. That function
> should know whether "platform" supports D3 for the bridges, and I think
> it actually calls acpi_device_power_manageable() that platform_pci_power_manageable()
> ends up checking too.

It does, but it doesn't end up returning false if it doesn't support it. 
  It only returns true if it does.

I've tested this patch on two different failing platforms and it works 
now on both.
