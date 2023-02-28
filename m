Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43C7B6A58DA
	for <lists+linux-pci@lfdr.de>; Tue, 28 Feb 2023 13:08:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231634AbjB1MIg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 28 Feb 2023 07:08:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbjB1MIe (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 28 Feb 2023 07:08:34 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2052.outbound.protection.outlook.com [40.107.223.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 764C4B473;
        Tue, 28 Feb 2023 04:08:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NVlsLnOSiNWe3flN2SEXXvl/9FZ5EDmZmeAMGa4RigkiA++PlrHavRnxUTbnL4cV9dZc3g2KHjxtj+xw19s/xKdqgbdxNOULMr9SPRG3CCNw5cyIx1tkcOm1ejU//v6FTmOOAh413iUnXrzOdI2hCLJHiIiXoKc3FTtiR7RnIAjkp0BVKn8XxgU0nB86tAj5K8DeZJNQhbyEprzIt2hqyBLn0SShDuEmNlA9RLpc1LIMezroI+KtH0tdofjHJ2hyQ/FcEanlJWp/PsUXg0j0bZcS9nrAwAAE4cMV6NNAyI83k8aednVWPoxk6YuAkToOvNHa4F1SNIosyP9hiWgysQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vzzTvt3fN8vPNX/a3SqMvlyCJrO5kfjpEE18RutIpGs=;
 b=PTg41kvMMv+hYY9ZhhASPPY2CXDh4xEF/DSY17LET5ueCSZXSqSCHf4uyX784LwiJvcjEHeCzdvSdNKvCjcQ2C3oBuTy8GJQ/IyW1zar6mnTKW2Te7FQkp7obmlJ51Is7UwZ1jiXjyMcWunuH18Fc+u7Y39Mh/wGtDQ9vsma4ozC4zWHgwaE5PbfK+ZwaPxCp4tX5pAKld73c5oIfn9uYIr/qwqzpm3cSMcrhwSOwK2ROqVoKY7BkxSuVTl0K32d77e7Diytdeuawd/+ptE+OcyXKjoKzBuziy7WzBDga0iDT7UJalpEQRW/taV/SH3M/9ohMj/FpZLEI8v+yRs2RA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vzzTvt3fN8vPNX/a3SqMvlyCJrO5kfjpEE18RutIpGs=;
 b=OVEqwijMG7AQlmR4Hx2y4UduwYmH5XW1h0yoHoKxjbB71vX/NuEVxrsKnZyj41ojTCERpvmKTNvgKEvpImADGq9yeLenubxmKji8rt04FxxdqDZxMp3AcHZ9iZziVgdI67UDC60TYsuTc5dk3WaVZMcsEuSNcm/T6KLTO/wbuZM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2843.namprd12.prod.outlook.com (2603:10b6:5:48::24) by
 IA1PR12MB6604.namprd12.prod.outlook.com (2603:10b6:208:3a0::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6134.21; Tue, 28 Feb 2023 12:08:31 +0000
Received: from DM6PR12MB2843.namprd12.prod.outlook.com
 ([fe80::1185:1d60:8b6e:89d3]) by DM6PR12MB2843.namprd12.prod.outlook.com
 ([fe80::1185:1d60:8b6e:89d3%7]) with mapi id 15.20.6134.029; Tue, 28 Feb 2023
 12:08:30 +0000
Message-ID: <95aa1497-44d8-b2ca-ac50-450a218d7a6e@amd.com>
Date:   Tue, 28 Feb 2023 23:08:20 +1100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v3 01/16] cxl/pci: Fix CDAT retrieval on big endian
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
 <bbbe1c4f3788052865941572565aeb2be67a6770.1676043318.git.lukas@wunner.de>
 <ccfc3dcd-a52b-7649-fa8e-89a6ac7ebb3c@amd.com>
 <20230228082400.GA4168@wunner.de>
From:   Alexey Kardashevskiy <aik@amd.com>
In-Reply-To: <20230228082400.GA4168@wunner.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SY5PR01CA0090.ausprd01.prod.outlook.com
 (2603:10c6:10:1f5::11) To DM6PR12MB2843.namprd12.prod.outlook.com
 (2603:10b6:5:48::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB2843:EE_|IA1PR12MB6604:EE_
X-MS-Office365-Filtering-Correlation-Id: 60dc54b9-b40f-44c5-5e4c-08db19848191
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VWtZp81IGcJzMzc+57Z6Gj33AuZS+9wxcOSLcZUKLAs4tFiCGdKNR10mt0qXmvMlxQPLCfSSYCe45KHK/wzPagdlI4XgNeqS96XMOLw1kWkstr2iBhUH0kutrH4dapEmX/QZLkrsDHIuSw75/AMiYc7EVLRU1PLQezqnB5wuyWorXhKYcwSQ2pzjHEskdIqKLPVZ0x7g9QsFyVhW/5weO0NRsRLm/HlK8b+Ax90SVOPE3vADGrjgaWlMOWdQ02x1xGuKoIPh90s2uTWsmBeAcXBTRWIsWjDhIOTBqYcQvXeaACf83sxdcGG831EJrwQGG6MWb4WR03vhP4KZ7gV9PccumtfL1dlLCr3IfAlwR1hO2EHgZZHSsbdysZ1nxUAz0+YobMB9rJVqmxHdJH1yqJi9K9FGt2fEE2syknua626sAhE/ECjhM8RMHrvx+3kmo2OKl0GxNIGl7wrP7a2pMq10Dztey5uGOVdCj4EJhuK/zOSh6jgNn4v+fpAajX5jy1g6qUIeGHVBl/+P6GXOBoqKPObbmpmuVGKvqkwpMQrbmdQ/gubIUDCszpmOvimh3VF6hiYCJJLHZ0lHMeBL0axeTAkv8iD9O0B/FeH+Gr4hWsY0YueaKGO6lzyWg93zvqw/MjKSV9jrf/PoeZueiI3I8W88X3P1ME+pMoJSoaO/GhjGxpKb5w1hMnZKOw275tXfrWjcqdOy+ly0cydYofVF08rENClE0uQ773cafJc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB2843.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(376002)(39860400002)(346002)(136003)(366004)(451199018)(38100700002)(7416002)(2906002)(31696002)(2616005)(31686004)(6486002)(26005)(53546011)(36756003)(186003)(6512007)(6506007)(8676002)(54906003)(478600001)(66476007)(6666004)(6916009)(316002)(41300700001)(66556008)(4326008)(66946007)(8936002)(5660300002)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ak9XZmVFSE9Xb2JBU3ZHV0dKak5wZkQwY21mTTFzZWRUdmx4WG5ZWHpHbzJU?=
 =?utf-8?B?NVMydDNwdWNpNmw2a3ZUL3JzWmVUV2t6VE5EYW1MQVdmaUR6bmFobTRseEp3?=
 =?utf-8?B?TmNhdWs2cnk0OWhCc0VTS1NnNkRGNUZBSTBBaVRyckROTkNiM1ZvMGVzOXk3?=
 =?utf-8?B?YWxHTFJnTHFCWDZhOXdhT0k2ZDZzbmpKUlAwOFRvTzEya0xIdG9WbFBScllG?=
 =?utf-8?B?OGlHZzRFVXRYVGJnSDdQdXg5WWVNMFRpUy81OXBwQ21iTEpGSkF4bmZYYklI?=
 =?utf-8?B?VlFMeFpiTzlPL05pY3FDRnV5ZEJWUHpiTVVQWTc2V3diZ1lHdW1Wd1pxMnFq?=
 =?utf-8?B?R05VSHJNNGUra0NhODNLdW1xendZc2NnenpoYmcwN0hMZnZTVnlhS3FzTFdm?=
 =?utf-8?B?TVowajcxbkI5ZEd4WEs0c1pPci80d2cwcFVUS1ZqcFJHSDRkK1Jac2JrRFFE?=
 =?utf-8?B?S0F5ajdLdEplK3d2d0tOWVhwK2hHSTM0cGZEMjhQZFZzODRlbUtIOUs5T2t5?=
 =?utf-8?B?MDIrVnZxRmRJT2s0L2ZlNkhQTWdyY1k5czJ3cVYwN1dTNmtidy8wa282bDcy?=
 =?utf-8?B?L2N0Z2Y0MUQ3T0pvQ3REVGZzRjJXUkNhS1c0ZzRMNmttdGpXZm5yMjJyMXhJ?=
 =?utf-8?B?YmN1R1h6M3FnUmptNVc0WDl3T0tUNEQzWlk5Wlc5VGRncjhFa2xDL1ZLaXNY?=
 =?utf-8?B?V1dkU2hoVFZHYkQ0NkNwcE10Nlg3RDMrTGhsRWo2ZStIYzVtUjRsVTNZb1Zh?=
 =?utf-8?B?by96OVdESmt2L0FrM3QrNTBCdGcrdnFrSVVGSHhmZTBqaFJDRU14K3VpZEVL?=
 =?utf-8?B?d05uQ0ZkRG9HNWxZSVRNWGdmZlpYSmZjVEIxQVlDVkVxQkxlMUtYL29aR1Nh?=
 =?utf-8?B?RWxFRWFucHZFSEMxZjRWMnU0R3gwdlZ5QTlpR3hvamc0VC9XR2dPYkhTOC9F?=
 =?utf-8?B?S2pwTDNtRmpTeEl5S3A0RmFIMXFkelk1UnFxeVoxZ3Q2QmlvdmIrSTFiMkJW?=
 =?utf-8?B?T3pFUHVrazF0ckxLNTB6OXJidFN4SmJERjVZdm5ZWG4rSjBUVU4yVmtiQUI5?=
 =?utf-8?B?UHRZY0RxVm84YUFEcmVqVnJ2UnlUMDVWQTZhWXUyc1N5Mll6OUUyc0lNc1Vi?=
 =?utf-8?B?dUtXMm1LNmJSd1NLb29uZkVsSWxrVTdIWTl6VGVYL1ZiQytFVmJnSXlCdU1k?=
 =?utf-8?B?bS9aUGZKaTR6ZEhtbk9ucFdXNkpSblpqZ2VRNEVWUUFBUGhCWHNCSThVdjZu?=
 =?utf-8?B?S0kvbFlvL3VpaTFTaEZxSGlQRFU4OThhWXpzb3lBaHBSZ1lEaDFPaW1jaHUr?=
 =?utf-8?B?d3BoRWhmckpyRklqWGRPYkF4S1dHTTR4SS84dDd6V0hoNWV1L3BEV1RzamNr?=
 =?utf-8?B?Mmh0SWZFZWg3Njc1N3JEQnNZOThEd2phbUtLNVRRZDBTSXdQWVBIcjZPQ0ZV?=
 =?utf-8?B?a0M3Qk1SLy9qZ2JEZXBUcGtJVHhpZVppOWh5STlBcWs3Mi9ER3FQQ3FialE1?=
 =?utf-8?B?U3doNGF2NzhaS0xQRGJmc0x2MEkwRVV6dHR3SVV5M1FiL1FjenArdXk3ZW5U?=
 =?utf-8?B?ZEQ4REJpQWhHZVlEd0lDMC9nbWVwcGR6dGlmSytSUmxPL0JuUEdyVUZ3L0Ru?=
 =?utf-8?B?THFLMFlQbWtnS1hoNTljbUpNT2NZVEVkNkRETnFJcnBDM00rNEQyZVk1M09a?=
 =?utf-8?B?VFh0UmhtVjgyWDNYSHF3Q09zdVVMVG5xR0VqY3Z4bmozSTZzT0VadXhGaUVT?=
 =?utf-8?B?bjBCNUZrVkRlUHMyZ2FKbGVlaDdHUzlFQ01nTFFTZEFSRlpsRmIxSFk4MGJB?=
 =?utf-8?B?dEQ3bGVVVFQzTnMvZjdxZEZWcjhFZGNsTXU4SXNIbWpkMnVMVyt1ZzdPVVZ3?=
 =?utf-8?B?NEZrcmRZSCtHd0dzM3V0Q3MrR2Z2S1N2bS9MR2QrSnlwbTNLcm5tcmlHMkVG?=
 =?utf-8?B?RVJ5WVZHUnZuVDg5OWo5em9hdHRvZm1ZMkxEeXZ2R2hyTmR6djYvUVdiWGZn?=
 =?utf-8?B?WVRkcStlbDd4UFBsb3g1WC95b1hCbm41YmxGcWdNcWdCL1hoTmhtTFVZeEF4?=
 =?utf-8?B?WkxPbjR6RUMvbzgzMjhJUVlDTGhpdGlUaXlWVlNuUFFjTnpCV1R4L1ZCOVFi?=
 =?utf-8?Q?0WUVMaX3nVpUvkR7DZjAk7c+K?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60dc54b9-b40f-44c5-5e4c-08db19848191
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2843.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2023 12:08:30.6659
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SlxI1MWtsPIajFI2fl6mpsRnVs8qk0230sw0EMq5yf0cX+3b7vOS5PiKbD/qQuop5MORosv4xC/5eIJ/4qQLug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6604
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 28/2/23 19:24, Lukas Wunner wrote:
> On Tue, Feb 28, 2023 at 01:53:46PM +1100, Alexey Kardashevskiy wrote:
>> On 11/2/23 07:25, Lukas Wunner wrote:
>>> @@ -493,8 +493,8 @@ static void cxl_doe_task_complete(struct pci_doe_task *task)
>>>    }
>>>    struct cdat_doe_task {
>>> -	u32 request_pl;
>>> -	u32 response_pl[32];
>>> +	__le32 request_pl;
>>> +	__le32 response_pl[32];
>>
>> This is ok as it is a binary format of DOE message (is it?)...
> 
> Yes, the DOE request and response is an opaque byte stream.
> 
> The above-quoted type changes are necessary to avoid sparse warnings
> (as noted in the commit message).
> 
> 
>>> --- a/drivers/pci/doe.c
>>> +++ b/drivers/pci/doe.c
>>> @@ -143,7 +143,7 @@ static int pci_doe_send_req(struct pci_doe_mb *doe_mb,
>>>    					  length));
>>>    	for (i = 0; i < task->request_pl_sz / sizeof(u32); i++)
>>>    		pci_write_config_dword(pdev, offset + PCI_DOE_WRITE,
>>> -				       task->request_pl[i]);
>>> +				       le32_to_cpu(task->request_pl[i]));
>>
>> Does it really work on BE? My little brain explodes on all these convertions
>>
>> char buf[] = { 1, 2, 3, 4 }
>> u32 *request_pl = buf;
>>
>> request_pl[0] will be 0x01020304.
>> le32_to_cpu(request_pl[0]) will be 0x04030201
>> And then pci_write_config_dword() will do another swap.
>>
>> Did I miss something? (/me is gone bringing up a BE system).
> 
> Correct.

Uff, ok, your code works correct, sorry for the noise.


> 
>>> @@ -45,9 +49,9 @@ struct pci_doe_mb;
>>>     */
>>>    struct pci_doe_task {
>>>    	struct pci_doe_protocol prot;
>>> -	u32 *request_pl;
>>> +	__le32 *request_pl;
>>>    	size_t request_pl_sz;
>>> -	u32 *response_pl;
>>> +	__le32 *response_pl;
>>
>>
>> This does not look right. Either:
>> - pci_doe() should also take __le32* or
>> - pci_doe() should do cpu_to_le32() for the request, and
>> pci_doe_task_complete() - for the response.
> 
> Again, the type changes are necessary to avoid sparse warnings.

I'd shut it up like this:

===
          for (i = 0; i < task->request_pl_sz / sizeof(__le32); i++)
                 pci_write_config_dword(pdev, offset + PCI_DOE_WRITE,
-                                      le32_to_cpu(task->request_pl[i]));
+                                      le32_to_cpu(*(__le32 
*)&task->request_pl[i]));
===

+ may be a comment that LE is a natural order. Dunno.

Changing types to __le32 without explicit conversions or comments just 
confuses. Thanks,


> pci_doe() takes a void * because patch [15/16] eliminates the need
> for the request and response size to be a multiple of dwords.
> Passing __le32 * to pci_doe() would then no longer be correct.


-- 
Alexey

