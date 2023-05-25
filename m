Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6248671108E
	for <lists+linux-pci@lfdr.de>; Thu, 25 May 2023 18:11:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232561AbjEYQLe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 25 May 2023 12:11:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231133AbjEYQLd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 25 May 2023 12:11:33 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2080.outbound.protection.outlook.com [40.107.96.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A3A4195;
        Thu, 25 May 2023 09:11:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OsnQ95qBw52CGGDvuJz+As5fE1hmiyR5riZFTMEgKlZ4vW4yIDl9wtFsNRIkO1zwf20bGXeL9zvborXoSswteGMctsCeBmpku2uPMM0yiA7LnshnbHTKVD6lflFUtXjAVR2U8sZbh+sz4/+3td1/U91Zf1LaauQYME3vZS7XeBa331lsiwX49YYf298Z0AUA494anXkRgAckJihvoAvbxx0FRc0zDtWXPOrfyQQy+w8b4L7LVpEaM/1YmmngvccqBpsLOHkJ5nfbJgBcJwAR0rDnn/6gDy2Ss6v1sWwHkh3/2ThWKbfEcB2Jyo+UyKp/2RM7zWOPw97wRUBHFofBSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hNBM2D6C7LWVHnUYcAx8YjXFBfPt7Ci3ytbAJ+F3lbI=;
 b=E4PLV6bAd5NLixaQkEBbcl3LiykQEV/cxadFvEDAbvWkYj1Y0VvVhaUwOji4LWe9ScxZYnD5bVXbRdphByZ5WMKMp2A9npVOzNwDls9tAlnuq8c1oQzNRM1gQOH1yIExZU7M378o1fgNErHwqrtAj1NNW5piZZ2I8q+G74Zzpy6dbvyCm1LwveAKzqvUddu4BD845pk8k5epvz627GK2rAMr6zhPFpALqow1s206f/mftMxh9Zi45xF7fi5lXfEfdSfsiNw34tqrNSFOfNDtnHlkpxRte/ILxKssmpyc7W+LUddfSZj5V5v80Pa1M6WQ6UAxCKlYm3wUwtqCnS3Qag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hNBM2D6C7LWVHnUYcAx8YjXFBfPt7Ci3ytbAJ+F3lbI=;
 b=NaymgfzzxdvhV4IWKjXOf0kYZ5EMDouiwJns6YS/CTZMKOXwdYj3V+huirGmMnE3msox4CsFwzh48xIHNRMmVHSWbJm9ki3N8q3o0O2yvTCGiVxedka5IWiVAPUEVQN1hPgl/k8apZ6F4gP0F4qA+x/9nwR1DKm20fGUGmKJoSs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by BL1PR12MB5047.namprd12.prod.outlook.com (2603:10b6:208:31a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.16; Thu, 25 May
 2023 16:10:43 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::3f45:358e:abba:24f5]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::3f45:358e:abba:24f5%3]) with mapi id 15.20.6411.028; Thu, 25 May 2023
 16:10:43 +0000
Message-ID: <acf1f9a9-9b70-8672-1a0e-3d7f192d0926@amd.com>
Date:   Thu, 25 May 2023 11:10:40 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v4 2/2] PCI: Don't assume root ports from > 2015 are power
 manageable
Content-Language: en-US
To:     Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        S-k Shyam-sundar <Shyam-sundar.S-k@amd.com>,
        Natikar Basavaraj <Basavaraj.Natikar@amd.com>,
        Deucher Alexander <Alexander.Deucher@amd.com>,
        linux-pm@vger.kernel.org, Lukas Wunner <lukas@wunner.de>,
        Iain Lane <iain@orangesquash.org.uk>
References: <20230524190726.17012-1-mario.limonciello@amd.com>
 <20230524190726.17012-2-mario.limonciello@amd.com>
 <9cf6d69c-7c14-e709-0cd7-d51f21c6141f@linux.intel.com>
From:   "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <9cf6d69c-7c14-e709-0cd7-d51f21c6141f@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA1P222CA0040.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:2d0::8) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|BL1PR12MB5047:EE_
X-MS-Office365-Filtering-Correlation-Id: eb5395a5-c97e-4f24-b35b-08db5d3a974b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ed591sauhLpq+SZ3aPmYOxPbSWFchiYp73gAHnd8fM7KnaWx0jxwEGxQym4wOUlRTPE+3jR/5NoQ1K9uXjmgflKnX/OIl6QH9imQUtPiWqWHk6g/7WaRmIMiFp9sC39a+M8HA2nGYhcoPaxfnzZRjXg31z4ghDTjaIZz57ygq4KdBQPCFK6p+M9PzIvlKXBPKWKfIh3toiZHi0WQ+6WH6Rofu4V+aOssDwvcCL1vTfLpkEmEm9MJDFx/BG56OYtKmIBpr6nQtr4n982qvMRjvruwgcnZRF5tFLDOOlqoNwejNAaGC5d+nkGFPFVxFJcSK4SKANxw1X5VVLYlS0oo5/uTMxUKoLzmoEHV46tUHCiqYbcNL90XJ3Lgyea4MzYjUxzPf0G8r9Q9sSO70Gcv0TFQr61n7Kog52BqtLa6Hc7dhtWi0q8wE4JCz7SzbwF898TEfoPVBybHd+w9UulVHbdFuzXzT8Hr9HuBYk+9rLnWbo6W8XyPHIh1S+YckDn5oHrFh0wyxcIJU7cFTW4VNTE0IEJVdOKMujgZza8KaCzPACNHK0nrVbiHVKYhqmIdhpDi4w0BQmW8zmIkG7lJqKtGOAoQ4gT58ARkoEy7jZMYl/VOdMcPP5+gB/n1NYqTHVr3N3ytfVwWWvBZojyUKA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(376002)(39860400002)(396003)(366004)(451199021)(4326008)(36756003)(53546011)(86362001)(8676002)(8936002)(41300700001)(6506007)(6512007)(186003)(26005)(2616005)(110136005)(5660300002)(83380400001)(316002)(54906003)(66556008)(966005)(66476007)(66946007)(6486002)(478600001)(38100700002)(31696002)(66574015)(2906002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d3VsTHpZTlZIYUpnTlN1NW9jcUg1Q2ZNajVuVTVMRi9TdlJEbnhacmMzSXQx?=
 =?utf-8?B?VHl6Tmd6ckp3Tm5uV2tkYnNONFJ6QkhHeEt0WEFrdHEyM0dHcDVRME4xeVBh?=
 =?utf-8?B?TkZMNGx3WXo0bnpuT1RxOWhybjQydHZLcHFWcVVlVXlReDBxMFJvMmZPQ0Ev?=
 =?utf-8?B?VFdsbmVScmpYWmZ5aU1nNmE1elhtWUVvMHlXZVI5RFBoaDBVY1dkMnNObTEr?=
 =?utf-8?B?eUZsR0JEN2UvR2FqZ1VleU5oVFpYUC95TkhVdUNaY2krN0diNTNDQ0FXS3pC?=
 =?utf-8?B?eEF1WmF2Q2NRcDJLSVRUcTBrc1NyVm1mejV1TE9WSkU4MGNFRGs1YXVzOWlG?=
 =?utf-8?B?RFZKMUk4eTZ3Tk1TMFJqUVZ6QVJCa3ZhWTdkdWVONFlrMDVlbmlSU3cwQVhY?=
 =?utf-8?B?WDNkeDdTWXVUQTBsQXpLeks1YklnenY3cjAxcFVtUTdZcW5JN2hmMy9pRitK?=
 =?utf-8?B?RWg0UjliZGUvMERlemdHREs2Z3BqbG15SWtsR0RPTnJSeWliK2dNeVZPSkE0?=
 =?utf-8?B?RlNlYmx3Tm9DZDArNzIxS1RMaHdDS0IrUE91dHBGS2k0NjNlRTNibmdTVWE3?=
 =?utf-8?B?UXBtVWZWTDA0aUg5MGlqUEtKR1NzT2F2cVdLVUxoRnlPUTU2UksvQWptaVZn?=
 =?utf-8?B?SGZoSkg2K0VFdmFKN3FTeG1YYUluVHpGTEFzYjFralNBNFdJc2k1NXFxZmlj?=
 =?utf-8?B?cEtrcG9IWVJkUFk1QzBMTDh6RTVRNjlTM0hqeFplZTVDb0tCZEVsc2FON3Z0?=
 =?utf-8?B?R1RTS0p4OXhsekY3anlCck0ySFg5cno3N1JZOVFKbHhMNVRNNjNjV2FTSk1l?=
 =?utf-8?B?aDVLSk4zdVlrbVpJdjYyNWJpcUFPWFk5TE5jenlWRk13ejZKR3ZuTzBJWGdR?=
 =?utf-8?B?M3JTSCtMQTNVUGVuQmVBU0NBSjM5bmt3UFNQZ3F5NStRb0tINUhnS2cydDZT?=
 =?utf-8?B?MGFhVGVqQ0dFMDJrK0xWNmpDdTFURE9OSWp1Q001Z2RmWWxJZUJsa0ZZbTRn?=
 =?utf-8?B?Y3JJUmYzNStKSVR4S0l1aUFldjAvOTZUaFU1cGhQdHBoTnpyRThpblVYczdL?=
 =?utf-8?B?OEZLRWgxbHZ2eGszUExCT0F5RVBibGJvZ2pJNUtOa2lRK05kczZ0TmNvVVNP?=
 =?utf-8?B?cjZ6WUowbEN3ZENyTnJNUWRFSmVGZGk5T2k5aHdTclRIdlZieWtEYjFKejJ6?=
 =?utf-8?B?elBSZWRCdXpCOHk4UGtNQTFaaWkwdGprMjdrV0hHM2VYK290UXVZcEtDSk1C?=
 =?utf-8?B?S2ljaGIydzZPOUJiRDVXQU5wbCtDem5IS25sMTlFL0oxbmJEMmRNMnN2R2h1?=
 =?utf-8?B?VWJnWHBpOGkwT3RNUG45NjhlNXhiNzZTbG9ZSFhOV0JlNHdLNlg4OGlzcitz?=
 =?utf-8?B?OS9JdW1uellXc09iSjlmbkpSSGptRlBzRjhTNmlrT29WQ0crcHQvVUpzOU9a?=
 =?utf-8?B?U2RiY2N3QUhHZVpQMFlPMnBNQkhId3ZSTHlsa1A4bmxjUktKWEREMW9lcDBM?=
 =?utf-8?B?K3Rpa0ZzaFdIbnd3VmZJNXRTeE5CWSt4VWdEdWNVODNnVG5NY0tjRXNOdW1M?=
 =?utf-8?B?Qk5neHFsM1U0S0hLYUVpQW5WS0NKaW1hclFNc3ZxR2pQTElQSTFCNFVaRXVG?=
 =?utf-8?B?aW9CT1hSWjJoV1pqc2VLTWJUbVJ6bnJGbEtCU3MycXVCb3Z0bFcyYnNlOXBI?=
 =?utf-8?B?bjBVS3VTZ1FKWjh2U2szZmMzcUxjNXZrZUN0NGtZR3R6TU5KbkROd290KzlC?=
 =?utf-8?B?UzlZbDJjVjFMN1VRdlpqQm40eXVTbzJQNitpRk1IOHB2a3R0TWtVeUFKYjI3?=
 =?utf-8?B?WVg0WnE3aEpkeTNtc3BqeFBicXppblVLTGpudkVPeG5FTWhNMmxoOFZnUWZG?=
 =?utf-8?B?MGRGUkFUYU8xNHlTbUNqWFVJS3Q1NTQrdXJBaDI1bGg0dVpjamd5ZnlrYkti?=
 =?utf-8?B?QlV0a1o1NVJYMm0rQ2Yzd0tJT0JGQ3VCL0duSjk2NGlPcjdabVE3b241UmRz?=
 =?utf-8?B?cjA5UWhnZnpZdHhzZ3NFVERTOUxUd3pRdFJQZTRtMGJpKzEyQndYSGdlOWRp?=
 =?utf-8?B?RnY4WlQrR2JvQ3hUTFJqMXZ3SmQvcnJqU1V4cXByMTU0M3hnTFJ5ZHhmV1h4?=
 =?utf-8?Q?HKadYawUX+2sCxRE8an1sbx+0?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb5395a5-c97e-4f24-b35b-08db5d3a974b
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2023 16:10:43.3488
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GC1h8EA45K6/S9hY8KEUjvgrMlAzSJ07mISPYurZTWARXY4SGmNTeZ2rp/d8TQTOyPNtrRUuY0pI7fpteTvDpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5047
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 5/25/2023 11:03 AM, Sathyanarayanan Kuppuswamy wrote:
>
> On 5/24/23 12:07 PM, Mario Limonciello wrote:
>
> This looks like a generic fix to me. So why talk about > 2015? IMO,
> you can remove > 2015 from the title.
The issue was caused by the >2015 heuristic.  If that's taken
out then it went away.  But yes; I agree with you.  If I need
to respin I'll remove this.
>> Using a USB keyboard or mouse to wakeup the system from s2idle fails when
>> that XHCI device is connected to a USB-C port for an AMD USB4 router.
>>
>> Due to commit 9d26d3a8f1b0 ("PCI: Put PCIe ports into D3 during suspend")
>> all PCIe ports go into D3 during s2idle.
>>
>> When specific root ports are put into D3 over s2idle on some AMD platforms
>> it is not possible for the platform to properly identify wakeup sources.
>> This happens whether the root port goes into D3hot or D3cold.
> I think Linux/Windows comparison is also not needed. But it is up to you.
I think up to Bjorn :)
>> Comparing registers between Linux and Windows 11 this behavior to put
>> these specific root ports into D3 at suspend is unique to Linux. On an
>> affected system Windows does not put those specific root ports into D3
>> over Modern Standby.
>>
>> Windows doesn't put the root ports into D3 because root ports are not
>> power manageable.
>>
>> Linux shouldn't assume root ports support D3 just because they're on a
>> machine newer than 2015, the ports should also be deemed power manageable.
>> Add an extra check explicitly for root ports to ensure D3 isn't selected
>> for these ports.
>>
> Other than above suggestions, rest looks good to me.
>
> Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Much appreciated!
>> Fixes: 9d26d3a8f1b0 ("PCI: Put PCIe ports into D3 during suspend")
>> Reported-by: Iain Lane <iain@orangesquash.org.uk>
>> Closes: https://forums.lenovo.com/t5/Ubuntu/Z13-can-t-resume-from-suspend-with-external-USB-keyboard/m-p/5217121
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>> ---
>> v3->v4:
>>   * Move after refactor
>> ---
>>   drivers/pci/pci.c | 8 ++++++++
>>   1 file changed, 8 insertions(+)
>>
>> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>> index d1fa040bcea7..d293db963327 100644
>> --- a/drivers/pci/pci.c
>> +++ b/drivers/pci/pci.c
>> @@ -3015,6 +3015,14 @@ bool pci_bridge_d3_possible(struct pci_dev *bridge)
>>   	if (dmi_check_system(bridge_d3_blacklist))
>>   		return false;
>>   
>> +	/*
>> +	 * It's not safe to put root ports that don't support power
>> +	 * management into D3.
>> +	 */
>> +	if (pci_pcie_type(bridge) == PCI_EXP_TYPE_ROOT_PORT &&
>> +	    !platform_pci_power_manageable(bridge))
>> +		return false;
>> +
>>   	/*
>>   	 * It should be safe to put PCIe ports from 2015 or newer
>>   	 * to D3.
